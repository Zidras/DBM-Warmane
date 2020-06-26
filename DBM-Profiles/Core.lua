local addonName = ...

local DBM = DBM

local function copyTable(source, dest)
	for k,v in pairs(source) do
		dest[k] = v
	end
end

local defaults = {
	profile = DBM.DefaultOptions,
}

local barDefaultProperties = {}

local barDefaults = {
	profile = {
		-- ["*"] = barDefaultProperties,
		["DBM"] = barDefaultProperties,
	},
}

local barMT = getmetatable(DBT:New().options)

-- create a dummy mod to get the mod metatable
local dummyMod = DBM:NewMod("DBM-ProfilesDummy")
tremove(DBM.Mods)

local bossModPrototype = getmetatable(dummyMod).__index

local function setWarningType(self, color)
	self.announces[#self.announces].warningType = color
end

local function setWarningType1(self, _, color)
	setWarningType(self, color or 1)
end

local function setWarningType2(self, _, color)
	setWarningType(self, color or 2)
end

local function setWarningType3(self, _, color)
	setWarningType(self, color or 3)
end

-- hook these mod methods to add the added options to the defaults tables
local optionHooks = {
	AddBoolOption = function(self, name, default)
		self.defaults = self.defaults or {}
		self.defaults[name] = (default == nil) or default
	end,
	AddSliderOption = function(self, name, minValue, maxValue, valueStep, default)
		self.defaults = self.defaults or {}
		self.defaults[name] = default or 0
	end,
	AddDropdownOption = function(self, name, options, default)
		self.defaults = self.defaults or {}
		self.defaults[name] = default
	end,
	RemoveOption = function(self, name)
		-- self.defaults = self.defaults or {}
		self.defaults[name] = nil
	end,
	NewAnnounce = setWarningType1,
	NewTargetAnnounce = setWarningType2,
	NewSpellAnnounce = setWarningType3,
	NewCastAnnounce = setWarningType3,
	NewSoonAnnounce = setWarningType1,
	NewPreWarnAnnounce = function(self, spellId, time, color)
		setWarningType1(self, color)
	end,
	NewPhaseAnnounce = setWarningType1
}

for k,v in pairs(optionHooks) do
	hooksecurefunc(bossModPrototype, k, v)
end

local oldOptions = {}

local namespaces = {}

local addon = CreateFrame("Frame")
addon:RegisterEvent("ADDON_LOADED")
addon:RegisterEvent("PLAYER_LOGOUT")
addon:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

local function statsOnShow(panel)
	local stats = panel.mod.stats
	local f = panel
	f.nKills:SetText(stats.kills)
	f.nWipes:SetText(stats.pulls - stats.kills)
	f.nTime:SetText(stats.normalBestTime and ("%d:%02d"):format(math.floor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-")
	f.hKills:SetText(stats.heroicKills)
	f.hWipes:SetText(stats.heroicPulls - stats.heroicKills)
	f.hTime:SetText(stats.heroicBestTime and ("%d:%02d"):format(math.floor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
end

function addon:ADDON_LOADED(addon)
	if addon == "DBM-GUI" then
		DBM:RegisterOnGuiLoadCallback(function()
			local panel = DBM_GUI_Frame:CreateNewPanel("Profiles", "option")
			local area = panel:CreateArea(nil, nil, nil, true)
			AceDBUI:CreateUI("DBM-Profiles-UI", self.db, area.frame)
		end)

		local function setOnShow(addon, panel, subtab)
			if addon.modId == "DBM-PvP" then return	end
			local area = panel.areas[1]
			local frame = area.frame
			wipe(area.onshowcall)
			local n = 0

			for _,mod in ipairs(DBM.Mods) do
				if mod.modId == addon.modId and (not subtab or subtab == mod.subTab) then
					local p = {mod = mod}
					p.nKills, p.nWipes, p.nTime, p.hKills, p.hWipes, p.hTime = select(9 + 9 + (14 * n), frame:GetRegions())
					n = n + 1
					tinsert(area.onshowcall, p)
				end
			end
			frame:SetScript("OnShow", function(self)
				for _, v in pairs(area.onshowcall) do
					statsOnShow(v)
				end
			end)
		end

		local loadedSubTabs = {}

		local orig_UpdateModList = DBM_GUI.UpdateModList
		function DBM_GUI:UpdateModList()
			orig_UpdateModList(self)
			for _,addon in ipairs(DBM.AddOns) do
				if not IsAddOnLoaded(addon.modId) then
					-- this relies on the Load button being the only child of this frame
					local button = addon.panel.frame:GetChildren()
					local onClick = button:GetScript("OnClick")
					button:SetScript("OnClick", function(self)
						onClick(self)
						self:SetScript("OnClick", onClick)
						setOnShow(self.modid, self.modid.panel)
					end)
				else
					setOnShow(addon, addon.panel)
					if addon.subTabs then
						for k,_ in pairs(addon.subTabs) do
							if addon.subPanels[k] then
								setOnShow(addon, addon.subPanels[k], k)
							end
						end
						loadedSubTabs[addon.modId] = true
					end
				end
			end
			-- restore original function and hook it to hook not yet loaded panels
			self.UpdateModList = orig_UpdateModList
			hooksecurefunc(DBM_GUI, "UpdateModList", function(self)
				for _,addon in ipairs(DBM.AddOns) do
					if not loadedSubTabs[addon.modId] and addon.subTabs and IsAddOnLoaded(addon.modId) then
						for k,_ in pairs(addon.subTabs) do
							if addon.subPanels[k] then
								setOnShow(addon, addon.subPanels[k], k)
							end
						end
						loadedSubTabs[addon.modId] = true
					end
				end
			end)
		end
	elseif addon == addonName then
		self.db = LibStub("AceDB-3.0"):New("DeadlyBossModsDB", defaults, true)
		self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
		self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
		self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
		LibStub("LibDualSpec-1.0"):EnhanceDatabase(self.db, "DeadlyBossMods")

		local barDB = self.db:RegisterNamespace("DeadlyBarTimers", barDefaults)
		self.bars = barDB

		-- copy old settings into profile
		if DBM_SavedOptions and not DBM_SavedOptions["DBM-Profiles"] then
			copyTable(DBM_SavedOptions, self.db.profile)
			copyTable(DBT_SavedOptions, barDB.profile)
			DBM_SavedOptions["DBM-Profiles"] = true
		end

		self:RefreshConfig()

		local defaultStats = {}

		-- precreate all addon namespaces so profiles can be copied without the addons being loaded
		for _,v in ipairs(DBM.AddOns) do
			local modDefaults = {
				profile = {
					options = {},
					stats = defaultStats,
				}
			}

			local db = self.db:RegisterNamespace(v.modId, modDefaults)
			db.RegisterCallback(self, "OnProfileChanged", "RefreshModConfig")
			db.RegisterCallback(self, "OnProfileCopied", "RefreshModConfig")
			db.RegisterCallback(self, "OnProfileReset", "RefreshModConfig")
		end
	elseif GetAddOnMetadata(addon, "X-DBM-Mod") then
		local modId = addon
		local db = self.db:GetNamespace(modId)

		namespaces[db] = modId

		local statsName = modId:gsub("-", "").."_SavedStats"
		local oldStats = _G[statsName]
		if oldStats and not oldStats["DBM-Profiles"] then
			-- merge the old stats into the current profile
			local current = db.profile.stats
			for boss,stats in pairs(oldStats) do
				if current[boss] then
					for stat,value in pairs(stats) do
						if stat:find("Pulls$") or stat:find("Kills$") then
							current[boss][stat] = (current[boss][stat] or 0) + value
						elseif stat:find("BestTime$") then
							current[boss][stat] = min(current[boss][stat] or value, value)
						end
					end
				else
					current[boss] = stats
				end
			end
			-- flag the table so it won't get loaded again
			oldStats["DBM-Profiles"] = true
		end

		oldOptions[statsName] = _G[statsName]

		-- redefine the old saved variables to "trick" the modules into referring to our profiles instead
		_G[modId:gsub("-", "").."_SavedVars"] = db.profile.options
		_G[statsName] = db.profile.stats

		for _,v in ipairs(DBM.Mods) do
			if v.modId == modId then
				db.defaults.profile.options[v.id] = v.defaults
				v.defaults.Enabled = true
				v.defaults.Announce = false
				db.defaults.profile.stats[v.id] = {
					kills = 0,
					pulls = 0,
					heroicKills = 0,
					heroicPulls = 0
				}
			end
		end
	end
end

function addon:PLAYER_LOGOUT()
	for k,v in pairs(oldOptions) do
		_G[k] = v
	end
end

function addon:RefreshConfig(event, db, profile)
	DBM.Options = self.db.profile
	if self.bars then
		DBM.Bars.options = setmetatable(self.bars.profile.DBM, barMT)
	end
	if self.db.profile.ShowMinimapButton then
		DBMMinimapButton:Show()
	else
		DBMMinimapButton:Hide()
	end
	DBM:UpdateSpecialWarningOptions()
	local hpAnchor = DBMBossHealthDropdown and DBMBossHealthDropdown:GetParent()
	if hpAnchor then
		hpAnchor:ClearAllPoints()
	end
	DBM.BossHealth:UpdateSettings()
	-- announces uses color tables directly for their options, need to remap these upon changing profile
	for _,v in ipairs(DBM.Mods) do
		for _,v in ipairs(v.announces) do
			v.color = self.db.profile.WarningColors[v.warningType] or self.db.profile.WarningColors[1]
		end
	end

	local self = DBM.Bars
	self.mainAnchor:ClearAllPoints()
	self.mainAnchor:SetPoint(self.options.TimerPoint, UIParent, self.options.TimerPoint, self.options.TimerX, self.options.TimerY)
	self.secAnchor:ClearAllPoints()
	self.secAnchor:SetPoint(self.options.HugeTimerPoint, UIParent, self.options.HugeTimerPoint, self.options.HugeTimerX, self.options.HugeTimerY)
	for bar in self:GetBarIterator() do
		if not bar.dummy then
			if bar.moving == "enlarge" then
				bar.enlarged = true
				bar.moving = false
				self.owner.hugeBars:Append(self)
				bar:ApplyStyle()
			end
			bar.moving = nil
			bar:SetPosition()
			if not self.movable then
				bar.frame:EnableMouse(not self.options.ClickThrough)
			end
		end
	end
	DBM.Bars:ApplyStyle()
end

function addon:RefreshModConfig(event, db)
	for i, v in ipairs(DBM.Mods) do
		if v.modId and v.modId == namespaces[db] then
			v.Options = db.profile.options[v.id]
			v.stats = db.profile.stats[v.id]
		end
	end
end
