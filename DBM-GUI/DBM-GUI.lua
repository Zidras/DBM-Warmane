-- *********************************************************
-- **               Deadly Boss Mods - GUI                **
-- **            http://www.deadlybossmods.com            **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--    * Adam Williams (Omegal @ US-Whisperwind) (Primary boss mod author) Contact: mysticalosx@gmail.com (Twitter: @MysticalOS)
--
-- The localizations are written by:
--    * enGB/enUS: Tandanu				http://www.deadlybossmods.com
--    * deDE: Tandanu					http://www.deadlybossmods.com
--    * zhCN: Diablohu					http://www.dreamgen.cn | diablohudream@gmail.com
--    * ruRU: Swix						stalker.kgv@gmail.com
--    * ruRU: TOM_RUS
--    * zhTW: Hman						herman_c1@hotmail.com
--    * zhTW: Azael/kc10577				paul.poon.kw@gmail.com
--    * koKR: nBlueWiz					everfinale@gmail.com
--    * esES: Snamor/1nn7erpLaY      	romanscat@hotmail.com
--
-- The ex-translators:
--    * ruRU: BootWin					bootwin@gmail.com
--    * ruRU: Vampik					admin@vampik.ru
--
-- Special thanks to:
--    * Arta
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
--
--
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners, license information for these media files can be found in the modules that make use of them.
--
--
--  You are free:
--    * to Share - to copy, distribute, display, and perform the work
--    * to Remix - to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). (A link to http://www.deadlybossmods.com is sufficient)
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--
--
local FrameTitle = "DBM_GUI_Option_"	-- all GUI frames get automatically a name FrameTitle..ID

local PanelPrototype = {}
DBM_GUI = {
	tabs	= {},
	panels	= {}
}
setmetatable(PanelPrototype, {__index = DBM_GUI})

local L		= DBM_GUI_L
local CL	= DBM_CORE_L

local tinsert, tremove, tsort, twipe = table.insert, table.remove, table.sort, table.wipe
local mfloor, mmax = math.floor, math.max
local modelFrameCreated = false
local playerName, realmName, playerLevel = UnitName("player"), GetRealmName(), UnitLevel("player")

StaticPopupDialogs["IMPORTPROFILE_ERROR"] = {
	text = "There are one or more errors importing this profile. Please see the chat for more information. Would you like to continue and reset found errors to default?",
	button1 = "Import and fix",
	button2 = "No",
	OnAccept = function(self)
		self.importFunc()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,
}

do
	local soundsRegistered = false

	function DBM_GUI:MixinSharedMedia3(mediatype, mediatable)
		if not LibStub or not LibStub("LibSharedMedia-3.0", true) then
			return mediatable
		end
		if not soundsRegistered then
			local LSM = LibStub("LibSharedMedia-3.0")
			soundsRegistered = true
			-- register some of our own media
			LSM:Register("sound", "Long",	"Interface\\AddOns\\DBM-Core\\sounds\\Long.mp3")
			LSM:Register("sound", "Alert",	"Interface\\AddOns\\DBM-Core\\sounds\\Alert.mp3")
			LSM:Register("sound", "Info",	"Interface\\AddOns\\DBM-Core\\sounds\\Info.mp3")
			-- Embedded Sound Clip media
			LSM:Register("sound", "AirHorn (DBM)", [[Interface\AddOns\DBM-Core\sounds\AirHorn.ogg]])
			LSM:Register("sound", "Jaina: Beware", [[Interface\AddOns\DBM-Core\sounds\SoundClips\beware.ogg]])
			LSM:Register("sound", "Jaina: Beware (reverb)", [[Interface\AddOns\DBM-Core\sounds\SoundClips\beware_with_reverb.ogg]])
			LSM:Register("sound", "Thrall: That's Incredible!", [[Interface\AddOns\DBM-Core\sounds\SoundClips\incredible.ogg]])
			LSM:Register("sound", "Saurfang: Don't Die", [[Interface\AddOns\DBM-Core\sounds\SoundClips\dontdie.ogg]])
			-- Blakbyrd
			LSM:Register("sound", "Blakbyrd Alert 1", [[Interface\AddOns\DBM-Core\sounds\BlakbyrdAlerts\Alert1.ogg]])
			LSM:Register("sound", "Blakbyrd Alert 2", [[Interface\AddOns\DBM-Core\sounds\BlakbyrdAlerts\Alert2.ogg]])
			LSM:Register("sound", "Blakbyrd Alert 3", [[Interface\AddOns\DBM-Core\sounds\BlakbyrdAlerts\Alert3.ogg]])
			-- User Media
			if DBM.Options.CustomSounds >= 1 then
				LSM:Register("sound", "DBM: Custom 1", [[Interface\AddOns\DBM-CustomSounds\Custom1.ogg]])
			end
			if DBM.Options.CustomSounds >= 2 then
				LSM:Register("sound", "DBM: Custom 2", [[Interface\AddOns\DBM-CustomSounds\Custom2.ogg]])
			end
			if DBM.Options.CustomSounds >= 3 then
				LSM:Register("sound", "DBM: Custom 3", [[Interface\AddOns\DBM-CustomSounds\Custom3.ogg]])
			end
			if DBM.Options.CustomSounds >= 4 then
				LSM:Register("sound", "DBM: Custom 4", [[Interface\AddOns\DBM-CustomSounds\Custom4.ogg]])
			end
			if DBM.Options.CustomSounds >= 5 then
				LSM:Register("sound", "DBM: Custom 5", [[Interface\AddOns\DBM-CustomSounds\Custom5.ogg]])
			end
			if DBM.Options.CustomSounds >= 6 then
				LSM:Register("sound", "DBM: Custom 6", [[Interface\AddOns\DBM-CustomSounds\Custom6.ogg]])
			end
			if DBM.Options.CustomSounds >= 7 then
				LSM:Register("sound", "DBM: Custom 7", [[Interface\AddOns\DBM-CustomSounds\Custom7.ogg]])
			end
			if DBM.Options.CustomSounds >= 8 then
				LSM:Register("sound", "DBM: Custom 8", [[Interface\AddOns\DBM-CustomSounds\Custom8.ogg]])
			end
			if DBM.Options.CustomSounds >= 9 then
				LSM:Register("sound", "DBM: Custom 9", [[Interface\AddOns\DBM-CustomSounds\Custom9.ogg]])
				if DBM.Options.CustomSounds > 9 then
					DBM.Options.CustomSounds = 9
				end
			end
		end
		-- Sort LibSharedMedia keys alphabetically (case-insensitive)
		local hashtable = LibStub("LibSharedMedia-3.0", true):HashTable(mediatype)
		local keytable = {}
		for k in next, hashtable do
			tinsert(keytable, k)
		end
		tsort(keytable, function(a, b)
			return a:lower() < b:lower()
		end);
		-- DBM values (mediatable) first, LibSharedMedia values (sorted alphabetically) afterwards
		local result = mediatable
		for i = 1, #result do
			if mediatype == "statusbar" then
				result[i].texture = true
			elseif mediatype == "font" then
				result[i].font = true
			elseif mediatype == "sound" then
				result[i].sound = true
			end
		end
		for i = 1, #keytable do
			if mediatype ~= "sound" or (keytable[i] ~= "None" and keytable[i] ~= "NPCScan") then
				local v = hashtable[keytable[i]]
				-- Filter duplicates
				local insertme = true
				for _, v2 in next, result do
					if v2.value == v then
						insertme = false
						break
					end
				end
				if insertme then
					local ins = {
						text	= keytable[i],
						value	= v
					}
					if mediatype == "statusbar" then
						ins.texture = true
					elseif mediatype == "font" then
						ins.font = true
					-- Only insert paths from addons folder, ignore file data ID, since there is no clean way to handle supporitng both FDID and soundkit at same time
					elseif mediatype == "sound" and type(v) == "string" and v:lower():find("addons") then
						ins.sound = true
					end
					if ins.texture or ins.font or ins.sound then
						tinsert(result, ins)
					end
				end
			end
		end
		return result
	end
end

do
	local LibSerialize = LibStub and LibStub("LibSerialize", true)
	local LibDeflate = LibStub and LibStub("LibDeflate", true)
	local AceGUI = LibStub and LibStub("AceGUI-3.0", true)

	local canWeWork = (LibSerialize and LibDeflate and AceGUI)
	local popupFrame

	local function createPopupFrame(title, subtitle, content, status, importFunc)
		popupFrame = AceGUI:Create("Frame")
		popupFrame:SetTitle(title)
		popupFrame:SetLayout("Flow")
		popupFrame:SetCallback("OnClose", function(widget)
			AceGUI:Release(widget)
			collectgarbage()
		end)
		popupFrame:SetWidth(535)
		popupFrame:SetHeight(350)

		local editbox = AceGUI:Create("MultiLineEditBox")
		editbox.editBox:SetFontObject(GameFontHighlightSmall)
		editbox:SetFullWidth(true)
		editbox:SetFullHeight(true)
		popupFrame:AddChild(editbox)
		popupFrame.editbox = editbox

		-- close on escape
		_G["DBMImportExportFrame"] = popupFrame.frame
		UISpecialFrames[#UISpecialFrames + 1] = "DBMImportExportFrame"

		popupFrame.importFunc = importFunc
		popupFrame:SetStatusText(status or "")
		editbox:SetLabel(subtitle)

		if content then
			editbox:DisableButton(true)
			editbox:SetText(content)
			editbox.editBox:SetFocus()
			editbox.editBox:HighlightText()
			editbox:SetCallback("OnLeave", function(widget)
				widget.editBox:HighlightText()
				widget.editBox:SetFocus()
			end)
			editbox:SetCallback("OnEnter", function(widget)
				widget.editBox:HighlightText()
				widget.editBox:SetFocus()
			end)
		else
			editbox:DisableButton(false)
			editbox.editBox:SetFocus()
			editbox.button:SetScript("OnClick", function(widget)
				DBM_GUI:ImportProfile(editbox:GetText())
				AceGUI:Release(popupFrame)
				collectgarbage()
			end)
		end
	end

	function DBM_GUI:CreateExportProfile(export)
		if not canWeWork then
			DBM:AddMsg("Missing required libraries to export.")
			return
		end
		export = LibDeflate:EncodeForPrint(LibDeflate:CompressDeflate(LibSerialize:Serialize(export), {level = 9}))
		createPopupFrame(L.ButtonExportProfile, L.ProfileExportTitle, export, L.ProfileExportSubtitle)
	end

	function DBM_GUI:CreateImportProfile(importFunc)
		if not canWeWork then
			DBM:AddMsg("Missing required libraries to export.")
			return
		end
		createPopupFrame(L.ButtonImportProfile, L.ProfileImportTitle, nil, L.ProfileImportSubtitle, importFunc)
	end

	function DBM_GUI:ImportProfile(import)
		local success, deserialized = LibSerialize:Deserialize(LibDeflate:DecompressDeflate(LibDeflate:DecodeForPrint(import)))
		if not success then
			DBM:AddMsg("Failed to deserialize")
			return false
		elseif popupFrame.importFunc then
			popupFrame.importFunc(deserialized)
			return true
		end
	end
end

do
	local framecount = 0
	function DBM_GUI:GetNewID()
		framecount = framecount + 1
		return framecount
	end
	function DBM_GUI:GetCurrentID()
		return framecount
	end
end

function DBM_GUI:ShowHide(forceshow)
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if forceshow == true then
		self:UpdateModList()
		optionsFrame:Show()
	elseif forceshow == false then
		optionsFrame:Hide()
	else
		if optionsFrame:IsShown() then
			optionsFrame:Hide()
		else
			self:UpdateModList()
			optionsFrame:Show()
		end
	end
end


-- This function creates a check box
-- Autoplaced buttons will be placed under the last widget
--
--  arg1 = text right to the CheckBox
--  arg2 = autoplaced (true or nil/false)
--  arg3 = text on left side
--  arg4 = DBM.Options[arg4]
--  arg5 = DBM.Bars:SetOption(arg5, ...)
--
do
	local sounds = DBM_GUI:MixinSharedMedia3("sound", {
		--Inject basically dummy values for ordering special warnings to just use default SW sound assignments
		{sound = true, text = L.None, value = "None"},
		{sound = true, text = "SW 1", value = 1},
		{sound = true, text = "SW 2", value = 2},
		{sound = true, text = "SW 3", value = 3},
		{sound = true, text = "SW 4", value = 4},

		--Inject DBMs custom media that's not available to LibSharedMedia because it uses SoundKit Id (which LSM doesn't support)
		{sound = true, text = "AirHorn (DBM)",	value	= "Interface\\AddOns\\DBM-Core\\sounds\\AirHorn.ogg"},
		{sound = true, text	= "Alert",			value 	= "Interface\\AddOns\\DBM-Core\\sounds\\Alert.mp3"},
		{sound = true, text	= "Info",			value 	= "Interface\\AddOns\\DBM-Core\\sounds\\Info.mp3"},
		{sound = true, text	= "Long",			value 	= "Interface\\AddOns\\DBM-Core\\sounds\\Long.mp3"},
		{sound = true, text = "Algalon: Beware!", value = "Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.wav"},
		{sound = true, text = "BB Wolf: Run Away", value = "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav"},
		{sound = true, text = "C'Thun: You Will Die!", value = "Sound\\Creature\\CThun\\CThunYouWillDie.wav"},
		{sound = true, text = "Headless Horseman: Laugh", value = "Sound\\Creature\\HeadlessHorseman\\Horseman_Laugh_01.wav"},
		{sound = true, text = "Illidan: Not Prepared", value = "Sound\\Creature\\Illidan\\BLACK_Illidan_04.wav"},
		{sound = true, text = "Kaz'rogal: Marked", value = "Sound\\Creature\\KazRogal\\CAV_Kaz_Mark02.wav"},
		{sound = true, text = "Kil'Jaeden: Destruction", value = "Sound\\Creature\\KilJaeden\\KILJAEDEN02.wav"},
		{sound = true, text = "Loatheb: I see you", value = "Sound\\Creature\\Loathstare\\Loa_Naxx_Aggro02.wav"},
		{sound = true, text = "Lady Malande: Flee", value = "Sound\\Creature\\LadyMalande\\BLCKTMPLE_LadyMal_Aggro01.wav"},
		{sound = true, text = "Milhouse: Light You Up", value = "Sound\\Creature\\MillhouseManastorm\\TEMPEST_Millhouse_Pyro01.wav"},
		{sound = true, text = "Night Elf Bell", value = "Sound\\Doodad\\BellTollNightElf.wav"},
		{sound = true, text = "PvP Flag", value = "Sound\\Spells\\PVPFlagTaken.wav"},
		{sound = true, text = "Void Reaver: Marked", value = "Sound\\Creature\\VoidReaver\\TEMPEST_VoidRvr_Aggro01.wav"},
		{sound = true, text = "Yogg Saron: Laugh", value = "Sound\\Creature\\YoggSaron\\UR_YoggSaron_Slay01.wav"},
})

	local tcolors = {
		{text = L.CBTGeneric, value = 0},
		{text = L.CBTAdd, value = 1},
		{text = L.CBTAOE, value = 2},
		{text = L.CBTTargeted, value = 3},
		{text = L.CBTInterrupt, value = 4},
		{text = L.CBTRole, value = 5},
		{text = L.CBTPhase, value = 6},
		{text = L.CBTImportant, value = 7},
	}

	local function MixinCountTable(baseTable)
		-- DBM values (baseTable) first, mediatable values afterwards
		local result = baseTable
		for i=1,#DBM.Counts do
			local mediatext = DBM.Counts[i].text
			local mediapath = DBM.Counts[i].path
			tinsert(result, {text = mediatext, value = mediapath})
		end
		return result
	end

	local cvoice = MixinCountTable({
		{text = L.None, value = 0},
		{text = L.CVoiceOne, value = 1},
		{text = L.CVoiceTwo, value = 2},
		{text = L.CVoiceThree, value = 3},
	})
end

do
	local function OnShowGetStats(bossid, statsType, top1value1, top1value2, top1value3, top2value1, top2value2, top2value3, bottom1value1, bottom1value2, bottom1value3, bottom2value1, bottom2value2, bottom2value3)
		return function(self)
			local mod = DBM:GetModByName(bossid)
			local stats = mod.stats
			if statsType == 1 then -- Party: normal, heroic
				top1value1:SetText( stats.normalKills )
				top1value2:SetText( stats.normalPulls - stats.normalKills )
				top1value3:SetText( stats.normalBestTime and ("%d:%02d"):format(mfloor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-" )
				top2value1:SetText( stats.heroicKills )
				top2value2:SetText( stats.heroicPulls-stats.heroicKills )
				top2value3:SetText( stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-" )
			elseif statsType == 2 and stats.normal25Pulls and stats.normal25Pulls > 0 and stats.normal25Pulls > stats.normalPulls then--Fix for BC instance
				top1value1:SetText( stats.normal25Kills )
				top1value2:SetText( stats.normal25Pulls - stats.normal25Kills )
				top1value3:SetText( stats.normal25BestTime and ("%d:%02d"):format(mfloor(stats.normal25BestTime / 60), stats.normal25BestTime % 60) or "-" )
			elseif statsType == 3 then
				top1value1:SetText( stats.normalKills )
				top1value2:SetText( stats.normalPulls - stats.normalKills )
				top1value3:SetText( stats.normalBestTime and ("%d:%02d"):format(mfloor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-" )
				top2value1:SetText( stats.heroicKills )
				top2value2:SetText( stats.heroicPulls-stats.heroicKills )
				top2value3:SetText( stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-" )
			else
				top1value1:SetText(stats.normalKills)
				top1value2:SetText(stats.normalPulls - stats.normalKills)
				top1value3:SetText(stats.normalBestTime and ("%d:%02d"):format(mfloor(stats.normalBestTime / 60), stats.normalBestTime % 60) or "-")
				top2value1:SetText(stats.normal25Kills)
				top2value2:SetText(stats.normal25Pulls - stats.normal25Kills)
				top2value3:SetText(stats.normal25BestTime and ("%d:%02d"):format(mfloor(stats.normal25BestTime / 60), stats.normal25BestTime % 60) or "-")
				bottom1value1:SetText(stats.heroicKills)
				bottom1value2:SetText(stats.heroicPulls-stats.heroicKills)
				bottom1value3:SetText(stats.heroicBestTime and ("%d:%02d"):format(mfloor(stats.heroicBestTime / 60), stats.heroicBestTime % 60) or "-")
				bottom2value1:SetText(stats.heroic25Kills)
				bottom2value2:SetText(stats.heroic25Pulls-stats.heroic25Kills)
				bottom2value3:SetText(stats.heroic25BestTime and ("%d:%02d"):format(mfloor(stats.heroic25BestTime / 60), stats.heroic25BestTime % 60) or "-")
			end
		end
	end

	local function CreateBossModTab(addon, panel, subtab)
		if not panel then
			error("Panel is nil", 2)
		end

		local modProfileArea
		if not subtab then
			local modProfileDropdown = {}
			modProfileArea = panel:CreateArea(L.Area_ModProfile)
			modProfileArea.frame:SetPoint("TOPLEFT", 10, -25)
			local resetButton = modProfileArea:CreateButton(L.ModAllReset, 200, 20)
			resetButton:SetPoint("TOPLEFT", 10, -14)
			resetButton:SetScript("OnClick", function()
				DBM:LoadAllModDefaultOption(addon.modId)
			end)
			for charname, charTable in pairs(_G[addon.modId:gsub("-", "") .. "_AllSavedVars"] or {}) do
				for _, optionTable in pairs(charTable) do
					if type(optionTable) == "table" then
						for i = 0, 3 do
							if optionTable[i] then
								tinsert(modProfileDropdown, {
									text	= (i == 0 and charname .. " (" .. ALL .. ")") or charname .. " (" .. TALENTS .. i .. "-" .. (charTable["talent" .. i] or "") .. ")",
									value	= charname .. "|" .. tostring(i)
								})
							end
						end
						break
					end
				end
			end

			local resetStatButton = modProfileArea:CreateButton(L.ModAllStatReset, 200, 20)
			resetStatButton.myheight = 0
			resetStatButton:SetPoint("LEFT", resetButton, "RIGHT", 40, 0)
			resetStatButton:SetScript("OnClick", function()
				DBM:ClearAllStats(addon.modId)
			end)

			local refresh

			local copyModProfile = modProfileArea:CreateDropdown(L.SelectModProfileCopy, modProfileDropdown, nil, nil, function(value)
				local name, profile = strsplit("|", value)
				DBM:CopyAllModOption(addon.modId, name, tonumber(profile))
				DBM:Schedule(0.05, refresh)
			end, 100)
			copyModProfile:SetPoint("TOPLEFT", -7, -54)
			copyModProfile:SetScript("OnShow", function()
				copyModProfile.value = nil
				copyModProfile.text = nil
				_G[copyModProfile:GetName() .. "Text"]:SetText("")
			end)

			local copyModSoundProfile = modProfileArea:CreateDropdown(L.SelectModProfileCopySound, modProfileDropdown, nil, nil, function(value)
				local name, profile = strsplit("|", value)
				DBM:CopyAllModTypeOption(addon.modId, name, tonumber(profile), "SWSound")
				DBM:Schedule(0.05, refresh)
			end, 100)
			copyModSoundProfile.myheight = 0
			copyModSoundProfile:SetPoint("LEFT", copyModProfile, "RIGHT", 27, 0)
			copyModSoundProfile:SetScript("OnShow", function()
				copyModSoundProfile.value = nil
				copyModSoundProfile.text = nil
				_G[copyModSoundProfile:GetName() .. "Text"]:SetText("")
			end)

			local copyModNoteProfile = modProfileArea:CreateDropdown(L.SelectModProfileCopyNote, modProfileDropdown, nil, nil, function(value)
				local name, profile = strsplit("|", value)
				DBM:CopyAllModTypeOption(addon.modId, name, tonumber(profile), "SWNote")
				DBM:Schedule(0.05, refresh)
			end, 100)
			copyModNoteProfile.myheight = 0
			copyModNoteProfile:SetPoint("LEFT", copyModSoundProfile, "RIGHT", 27, 0)
			copyModNoteProfile:SetScript("OnShow", function()
				copyModNoteProfile.value = nil
				copyModNoteProfile.text = nil
				_G[copyModNoteProfile:GetName() .. "Text"]:SetText("")
			end)

			local deleteModProfile = modProfileArea:CreateDropdown(L.SelectModProfileDelete, modProfileDropdown, nil, nil, function(value)
				local name, profile = strsplit("|", value)
				DBM:DeleteAllModOption(addon.modId, name, tonumber(profile))
				DBM:Schedule(0.05, refresh)
			end, 100)
			deleteModProfile.myheight = 60
			deleteModProfile:SetPoint("TOPLEFT", copyModSoundProfile, "BOTTOMLEFT", 0, -10)
			deleteModProfile:SetScript("OnShow", function()
				deleteModProfile.value = nil
				deleteModProfile.text = nil
				_G[deleteModProfile:GetName() .. "Text"]:SetText("")
			end)

			function refresh()
				copyModProfile:GetScript("OnShow")()
				copyModSoundProfile:GetScript("OnShow")()
				copyModNoteProfile:GetScript("OnShow")()
				deleteModProfile:GetScript("OnShow")()
			end

			-- Start import/export
			local fullname = DBM.Options.PerCharacterSettings and playerName.."-"..realmName or "Global"
			local function actuallyImport(importTable)
				local profileID = playerLevel > 9 and DBM_UseDualProfile and (GetActiveTalentGroup() or 1) or 0
				for _, id in ipairs(DBM.ModLists[addon.modId]) do
					_G[addon.modId:gsub("-", "") .. "_AllSavedVars"][fullname][id][profileID] = importTable[id]
					DBM:GetModByName(id).Options = importTable[id]
				end
				DBM:AddMsg("Profile imported.")
			end

			local importExportProfilesArea = panel:CreateArea(L.Area_ImportExportProfile, panel.frame:GetWidth(), 50, true)
			local test = importExportProfilesArea:CreateText(L.ImportExportInfo, nil, true, nil, "LEFT")
			test:SetPoint("TOPLEFT", 15, -10)
			local exportProfile = importExportProfilesArea:CreateButton(L.ButtonExportProfile, 120, 20, function()
				local exportProfile = {}
				local profileID = playerLevel > 9 and DBM_UseDualProfile and (GetActiveTalentGroup() or 1) or 0
				for _, id in ipairs(DBM.ModLists[addon.modId]) do
					exportProfile[id] = _G[addon.modId:gsub("-", "") .. "_AllSavedVars"][fullname][id][profileID]
				end
				DBM_GUI:CreateExportProfile(exportProfile)
			end)
			exportProfile.myheight = 0
			exportProfile:SetPoint("TOPLEFT", 12, -25)
			local importProfile = importExportProfilesArea:CreateButton(L.ButtonImportProfile, 120, 20, function()
				DBM_GUI:CreateImportProfile(function(importTable)
					local errors = {}
					for id, table in pairs(importTable) do
						-- Check if sound packs are missing
						for settingName, settingValue in pairs(table) do
							local ending = settingName:sub(-6):lower()
							if ending == "cvoice" or ending == "wsound" then -- CVoice or SWSound (s is ignored so we only have to sub once)
								if type(settingValue) == "string" and settingValue:lower() ~= "none" and not DBM:ValidateSound(settingValue, true, true) then
									tinsert(errors, id .. "-" .. settingName)
								end
							end
						end
					end
					-- Create popup confirming if they wish to continue (and therefor resetting to default)
					if #errors > 0 then
						local popup = StaticPopup_Show("IMPORTPROFILE_ERROR")
						if popup then
							popup.importFunc = function()
								local modOptions = {}
								for _, soundSetting in ipairs(errors) do
									local modID, settingName = soundSetting:match("([^-]+)-([^-]+)")
									if not modOptions[modID] then
										modOptions[modID] = DBM:GetModByName(modID).DefaultOptions
									end
									importTable[modID][settingName] = modOptions[modID][settingName]
								end
								actuallyImport(importTable)
							end
						end
					else
						actuallyImport(importTable)
					end
				end)
			end)
			importProfile.myheight = 0
			importProfile:SetPoint("LEFT", exportProfile, "RIGHT", 2, 0)
		end

		if addon.noStatistics then return end

		local ptext = panel:CreateText(L.BossModLoaded:format(subtab and addon.subTabs[subtab] or addon.name), nil, nil, GameFontNormal)
		ptext:SetPoint("TOPLEFT", panel.frame, "TOPLEFT", 10, modProfileArea and -245 or -10)

		local singleline = 0
		local doubleline = 0
		local area = panel:CreateArea(nil, panel.frame:GetWidth(), 10)
		area.frame:SetPoint("TOPLEFT", 10, modProfileArea and -260 or -25)
		area.onshowcall = {}

		for _, mod in ipairs(DBM.Mods) do
			if mod.modId == addon.modId and (not subtab or subtab == mod.subTab) and not mod.isTrashMod and not mod.noStatistics then
				local statsType = 0
				if not mod.stats then
					mod.stats = { }
				end
				local stats = mod.stats
				stats.normalKills = stats.normalKills or 0
				stats.normalPulls = stats.normalPulls or 0
				stats.heroicKills = stats.heroicKills or 0
				stats.heroicPulls = stats.heroicPulls or 0
				stats.normal25Kills = stats.normal25Kills or 0
				stats.normal25Pulls = stats.normal25Pulls or 0
				stats.heroic25Kills = stats.heroic25Kills or 0
				stats.heroic25Pulls = stats.heroic25Pulls or 0

				--Create Frames
				local Title			= area:CreateText(mod.localization.general.name, nil, nil, GameFontHighlight, "LEFT")

				local top1header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT")--Row 1, 1st column
				local top1text1			= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local top1text2			= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local top1text3			= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local top1value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top1value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top1value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top2header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT")--Row 1, 2nd column
				local top2text1			= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local top2text2			= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local top2text3			= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local top2value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top2value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local top2value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")

				local bottom1header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT")--Row 2, 1st column
				local bottom1text1		= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1text2		= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1text3		= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom1value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2header		= area:CreateText("", nil, nil, GameFontHighlightSmall, "LEFT")--Row 2, 2nd column
				local bottom2text1		= area:CreateText(L.Statistic_Kills, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2text2		= area:CreateText(L.Statistic_Wipes, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2text3		= area:CreateText(L.Statistic_BestKill, nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2value1		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2value2		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")
				local bottom2value3		= area:CreateText("", nil, nil, GameFontNormalSmall, "LEFT")

				--Set enable or disable per mods.
				if mod.addon.oneFormat then -- Classic/BC Raids
					statsType = 3
					if mod.addon.noHeroic then
						--Do not use top1 header.
						top1text1:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
					else
						--Use top1 and top2 area.
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						--Set header text.
						top1header:SetText(PLAYER_DIFFICULTY1)
						top2header:SetText(PLAYER_DIFFICULTY2)
					end
					--Set Dims
					Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10-(L.FontHeight*6*singleline))
					area.frame:SetHeight( area.frame:GetHeight() + L.FontHeight*6 )
					singleline = singleline + 1
				elseif mod.addon.type == "PARTY" then -- If party instance have no heroic, we should use oneFormat.
					statsType = 1
					if mod.oneFormat then
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						--Set header text.
						top1header:SetText(PLAYER_DIFFICULTY1)
						--Set Dims
						Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10-(L.FontHeight*6*singleline))
						area.frame:SetHeight( area.frame:GetHeight() + L.FontHeight*6 )
						singleline = singleline + 1
					elseif mod.onlyHeroic then
						top2header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top2text1:SetPoint("TOPLEFT", top2header, "BOTTOMLEFT", 20, -5)
						top2text2:SetPoint("TOPLEFT", top2text1, "BOTTOMLEFT", 0, -5)
						top2text3:SetPoint("TOPLEFT", top2text2, "BOTTOMLEFT", 0, -5)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						--Set header text.
						top2header:SetText(PLAYER_DIFFICULTY2)
						--Set Dims
						Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10-(L.FontHeight*6*singleline))
						area.frame:SetHeight( area.frame:GetHeight() + L.FontHeight*6 )
						singleline = singleline + 1
					else--Dungeons that are Normal, Heroic
						--Use top1 and top2 area. (normal, Heroic)
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						--Set header text.
						top1header:SetText(PLAYER_DIFFICULTY1)
						top2header:SetText(PLAYER_DIFFICULTY2)
						--Set Dims
						Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10-(L.FontHeight*6*singleline))
						area.frame:SetHeight( area.frame:GetHeight() + L.FontHeight*6 )
						singleline = singleline + 1
					end
				else
					Title:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10-(L.FontHeight*6*singleline)-(L.FontHeight*10*doubleline))
					if mod.onlyNormal or mod.addon.noHeroic then
						--Use top1, top2 area
						--10 Player, 25 Player
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						--Set header text.
						top1header:SetText(RAID_DIFFICULTY1)
						top2header:SetText(RAID_DIFFICULTY2)
						--Set Dims
						area.frame:SetHeight( area.frame:GetHeight() + L.FontHeight*6 )
						singleline = singleline + 1
					else
						--Use top1, top2, bottom1 and bottom2 area.
						--10 Player, 25 Player, 10 Player Heroic, 25 Player Heroic
						top1header:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 20, -5)
						top1text1:SetPoint("TOPLEFT", top1header, "BOTTOMLEFT", 20, -5)
						top1text2:SetPoint("TOPLEFT", top1text1, "BOTTOMLEFT", 0, -5)
						top1text3:SetPoint("TOPLEFT", top1text2, "BOTTOMLEFT", 0, -5)
						top1value1:SetPoint("TOPLEFT", top1text1, "TOPLEFT", 80, 0)
						top1value2:SetPoint("TOPLEFT", top1text2, "TOPLEFT", 80, 0)
						top1value3:SetPoint("TOPLEFT", top1text3, "TOPLEFT", 80, 0)
						top2header:SetPoint("LEFT", top1header, "LEFT", 220, 0)
						top2text1:SetPoint("LEFT", top1text1, "LEFT", 220, 0)
						top2text2:SetPoint("LEFT", top1text2, "LEFT", 220, 0)
						top2text3:SetPoint("LEFT", top1text3, "LEFT", 220, 0)
						top2value1:SetPoint("TOPLEFT", top2text1, "TOPLEFT", 80, 0)
						top2value2:SetPoint("TOPLEFT", top2text2, "TOPLEFT", 80, 0)
						top2value3:SetPoint("TOPLEFT", top2text3, "TOPLEFT", 80, 0)
						bottom1header:SetPoint("TOPLEFT", top1text3, "BOTTOMLEFT", -20, -5)
						bottom1text1:SetPoint("TOPLEFT", bottom1header, "BOTTOMLEFT", 20, -5)
						bottom1text2:SetPoint("TOPLEFT", bottom1text1, "BOTTOMLEFT", 0, -5)
						bottom1text3:SetPoint("TOPLEFT", bottom1text2, "BOTTOMLEFT", 0, -5)
						bottom1value1:SetPoint("TOPLEFT", bottom1text1, "TOPLEFT", 80, 0)
						bottom1value2:SetPoint("TOPLEFT", bottom1text2, "TOPLEFT", 80, 0)
						bottom1value3:SetPoint("TOPLEFT", bottom1text3, "TOPLEFT", 80, 0)
						bottom2header:SetPoint("LEFT", bottom1header, "LEFT", 220, 0)
						bottom2text1:SetPoint("LEFT", bottom1text1, "LEFT", 220, 0)
						bottom2text2:SetPoint("LEFT", bottom1text2, "LEFT", 220, 0)
						bottom2text3:SetPoint("LEFT", bottom1text3, "LEFT", 220, 0)
						bottom2value1:SetPoint("TOPLEFT", bottom2text1, "TOPLEFT", 80, 0)
						bottom2value2:SetPoint("TOPLEFT", bottom2text2, "TOPLEFT", 80, 0)
						bottom2value3:SetPoint("TOPLEFT", bottom2text3, "TOPLEFT", 80, 0)
						--Set header text.
						top1header:SetText(RAID_DIFFICULTY1)
						top2header:SetText(RAID_DIFFICULTY2)
						bottom1header:SetText(PLAYER_DIFFICULTY2)
						bottom2header:SetText(PLAYER_DIFFICULTY2)
						--Set Dims
						area.frame:SetHeight(area.frame:GetHeight() + L.FontHeight*10)
						doubleline = doubleline + 1
					end
				end

				tinsert(area.onshowcall, OnShowGetStats(mod.id, statsType, top1value1, top1value2, top1value3, top2value1, top2value2, top2value3, bottom1value1, bottom1value2, bottom1value3, bottom2value1, bottom2value2, bottom2value3))
			end
		end
		area.frame:SetScript("OnShow", function(self)
			for _,v in pairs(area.onshowcall) do
				v()
			end
		end)
		DBM_GUI_OptionsFrame:DisplayFrame(panel.frame, true)
	end

	local function LoadAddOn_Button(self)
		if DBM:LoadMod(self.modid, true) then
			self:Hide()
			self.headline:Hide()
			CreateBossModTab(self.modid, self.modid.panel)
			DBM_GUI_OptionsFrameBossMods:Hide()
			DBM_GUI_OptionsFrameBossMods:Show()
		end
	end

	local category = {}
	local subTabId = 0
	local expansions = {
		"CLASSIC", "BC", "WOTLK"
	}

	function DBM_GUI:UpdateModList()
		for _, addon in ipairs(DBM.AddOns) do
			local cat = addon.category:upper()
			if not category[cat] then
				-- Create a Panel for "Wrath of the Lich King", "The Burning Crusade", "Classic" or "Other"
				category[cat] = DBM_GUI:CreateNewPanel(_G["EXPANSION_NAME" .. (tIndexOf(expansions, cat) or 99) - 1] or L.TabCategory_OTHER, nil, cat == expansions[GetExpansionLevel() + 1])
			end

			if not addon.panel then
				-- Create a Panel for "Naxxramas" "Eye of Eternity" ...
				addon.panel = category[cat]:CreateNewPanel(addon.modId or "Error: No-modId", nil, false, nil, addon.name)

				if not IsAddOnLoaded(addon.modId) then
					local button = addon.panel:CreateButton(L.Button_LoadMod, 200, 30)
					button.modid = addon
					button.headline = addon.panel:CreateText(L.BossModLoad_now, 350)
					button.headline:SetHeight(50)
					button.headline:SetPoint("CENTER", button, "CENTER", 0, 80)

					button:SetScript("OnClick", LoadAddOn_Button)
					button:SetPoint("CENTER", 0, -20)
				else
					CreateBossModTab(addon, addon.panel)
				end
			end

			if addon.panel and addon.subTabs and IsAddOnLoaded(addon.modId) then
				-- Create a Panel for "Arachnid Quarter" "Plague Quarter" ...
				if not addon.subPanels then addon.subPanels = {} end

				for k,v in pairs(addon.subTabs) do
					if not addon.subPanels[k] then
						subTabId = subTabId + 1
						addon.subPanels[k] = addon.panel:CreateNewPanel("SubTab"..subTabId, nil, false, nil, v)
						CreateBossModTab(addon, addon.subPanels[k], k)
					end
				end
			end

			for _, mod in ipairs(DBM.Mods) do
				if mod.modId == addon.modId then
					if not mod.panel and (not addon.subTabs or (addon.subPanels and addon.subPanels[mod.subTab])) then
						if addon.subTabs and addon.subPanels[mod.subTab] then
							mod.panel = addon.subPanels[mod.subTab]:CreateNewPanel(mod.id or "Error: DBM.Mods", nil, nil, nil, mod.localization.general.name)
						else
							mod.panel = addon.panel:CreateNewPanel(mod.id or "Error: DBM.Mods", nil, nil, nil, mod.localization.general.name)
						end
						DBM_GUI:CreateBossModPanel(mod)
					end
				end
			end
		end
		if DBM_GUI_OptionsFrame:IsShown() then
			DBM_GUI_OptionsFrame:Hide()
			DBM_GUI_OptionsFrame:Show()
		end
	end


	function DBM_GUI:CreateBossModPanel(mod)
		if not mod.panel then
			DBM:AddMsg("Couldn't create boss mod panel for "..mod.localization.general.name)
			return false
		end
		local panel = mod.panel
		panel.initheight = 35
		local category

		local iconstat = panel.frame:CreateFontString("DBM_GUI_Mod_Icons"..mod.localization.general.name, "ARTWORK")
		iconstat:SetPoint("TOPRIGHT", panel.frame, "TOPRIGHT", -168, -10)
		iconstat:SetFontObject(GameFontNormal)
		iconstat:SetText(L.IconsInUse)
		for i=1, 8, 1 do
			local icon = panel.frame:CreateTexture()
			icon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons.blp")
			icon:SetPoint("TOPRIGHT", panel.frame, "TOPRIGHT", -150-(i*18), -26)
			icon:SetWidth(16)
			icon:SetHeight(16)
			if not mod.usedIcons or not mod.usedIcons[i] then		icon:SetAlpha(0.25)		end
			if 		i == 1 then		icon:SetTexCoord(0,		0.25,	0,		0.25)
			elseif	i == 2 then		icon:SetTexCoord(0.25,	0.5,	0,		0.25)
			elseif	i == 3 then		icon:SetTexCoord(0.5, 	0.75,	0,		0.25)
			elseif	i == 4 then		icon:SetTexCoord(0.75,	1,		0,		0.25)
			elseif	i == 5 then		icon:SetTexCoord(0,		0.25,	0.25,	0.5)
			elseif	i == 6 then		icon:SetTexCoord(0.25,	0.5,	0.25,	0.5)
			elseif	i == 7 then		icon:SetTexCoord(0.5,	0.75,	0.25,	0.5)
			elseif	i == 8 then		icon:SetTexCoord(0.75,	1,		0.25,	0.5)
			end
		end

		local reset  = panel:CreateButton(L.Mod_Reset, 155, 30, nil, GameFontNormalSmall)
		reset:SetPoint('TOPRIGHT', panel.frame, "TOPRIGHT", -6, -6)
		reset:SetScript("OnClick", function(self)
			DBM:LoadModDefaultOption(mod)
		end)
		local button = panel:CreateCheckButton(L.Mod_Enabled, true)
		button:SetScript("OnShow",  function(self) self:SetChecked(mod.Options.Enabled) end)
		button:SetPoint('TOPLEFT', panel.frame, "TOPLEFT", 8, -14)
		button:SetScript("OnClick", function(self) mod:Toggle()	end)

		for _, catident in pairs(mod.categorySort) do
			category = mod.optionCategories[catident]
			if category then
				local catpanel = panel:CreateArea(mod.localization.cats[catident], nil, nil, true)
				local catbutton, lastButton, addSpacer
				local hasDropdowns = 0
				for _, v in ipairs(category) do
					if v == DBM_OPTION_SPACER then
						addSpacer = true
					else
						lastButton = catbutton
						if v.line then
							catbutton = catpanel:CreateLine(v.text)
						elseif type(mod.Options[v]) == "boolean" then
							if mod.Options[v .. "TColor"] then
								catbutton = catpanel:CreateCheckButton(mod.localization.options[v], true, nil, nil, nil, mod, v, nil, true)
							elseif mod.Options[v .. "SWSound"] then
								catbutton = catpanel:CreateCheckButton(mod.localization.options[v], true, nil, nil, nil, mod, v)
							else
								catbutton = catpanel:CreateCheckButton(mod.localization.options[v], true)
							end
							catbutton:SetScript("OnShow", function(self)
								self:SetChecked(mod.Options[v])
							end)
							catbutton:SetScript("OnClick", function(self)
								mod.Options[v] = not mod.Options[v]
								if mod.optionFuncs and mod.optionFuncs[v] then
									mod.optionFuncs[v]()
								end
							end)
						elseif mod.buttons and mod.buttons[v] then
							local but = mod.buttons[v]
							catbutton = catpanel:CreateButton(v, but.width, but.height, but.onClick, but.fontObject)
							if not addSpacer then
								catbutton:SetPoint('TOPLEFT', lastButton, "TOPLEFT", 0, -25)
							end
						elseif mod.editboxes and mod.editboxes[v] then
							local editBox = mod.editboxes[v]
							catbutton = catpanel:CreateEditBox(mod.localization.options[v], mod.Options[v], editBox.width, editBox.height)
							catbutton:SetScript("OnEnterPressed", function(self)
								if mod.optionFuncs and mod.optionFuncs[v] then
									mod.optionFuncs[v]()
								end
							end)
							if not addSpacer then
								catbutton:SetPoint('TOPLEFT', lastButton, "TOPLEFT", 0, -25)
							end
						elseif mod.sliders and mod.sliders[v] then
							local slider = mod.sliders[v]
							catbutton = catpanel:CreateSlider(mod.localization.options[v], slider.minValue, slider.maxValue, slider.valueStep)
							catbutton:SetScript("OnShow", function(self)
								self:SetValue(mod.Options[v])
							end)
							catbutton:HookScript("OnValueChanged", function(self)
								if mod.optionFuncs and mod.optionFuncs[v] then
									mod.optionFuncs[v]()
								end
							end)
							if not addSpacer then
								catbutton:SetPoint('TOPLEFT', lastButton, "TOPLEFT", 0, -35)
							end
						elseif mod.dropdowns and mod.dropdowns[v] then
							local dropdownOptions = {}
							for i, val in ipairs(mod.dropdowns[v]) do
								dropdownOptions[#dropdownOptions + 1] = { text = mod.localization.options[val], value = val }
							end
							catbutton = catpanel:CreateDropdown(mod.localization.options[v], dropdownOptions, mod, v, function(value)
								mod.Options[v] = value
								if mod.optionFuncs and mod.optionFuncs[v] then
									mod.optionFuncs[v]()
								end
							end, nil, 32)
							if not addSpacer then
								hasDropdowns = hasDropdowns + 7--Add 7 extra pixels per dropdown, because autodims is only reserving 25 per line, and dropdowns are 32
								catbutton:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -10)
							end
						end
						if addSpacer then
							catbutton:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -6)
							addSpacer = false
						end
					end
				end
			end
		end
	end
end