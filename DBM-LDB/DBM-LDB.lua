assert(LibStub, "DBM-LDB requires LibStub")
assert(LibStub:GetLibrary("LibDataBroker-1.1"), "DBM-LDB requires LibDataBroker-1.1")

local f = CreateFrame("Frame")
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local dropdownFrame = CreateFrame("Frame", "DBMLDBDropdownFrame", frame, "UIDropDownMenuTemplate")
local categories = {}
local initialize
local obj


local function createBossModEntry(id, level)
	local info
	local mod = DBM:GetModByName(id)
	if not mod then return end
	info = UIDropDownMenu_CreateInfo()
	info.text = mod.localization.general.name
	info.isTitle = true
	UIDropDownMenu_AddButton(info, level)
	info = UIDropDownMenu_CreateInfo()
	info.text = DBM_LDB_CAT_GENERAL
	info.notCheckable = true
	info.notClickable = true
	UIDropDownMenu_AddButton(info, level)
	info = UIDropDownMenu_CreateInfo()
	info.text = DBM_LDB_ENABLE_BOSS_MOD
	info.keepShownOnClick = 1
	info.checked = mod.Options.Enabled
	info.func = function() mod:Toggle() end
	UIDropDownMenu_AddButton(info, level)
	info = UIDropDownMenu_CreateInfo()
	info.text = DBM_LDB_ANNOUN_BOSS_MOD
	info.keepShownOnClick = 1
	info.checked = mod.Options.Announce
	info.func = function() mod.Options.Announce = not mod.Options.Announce end
	UIDropDownMenu_AddButton(info, level)
	for i, v in ipairs(mod.categorySort) do
		local cat = mod.optionCategories[v]
		info = UIDropDownMenu_CreateInfo()
		info.text = mod.localization.cats[v]
		info.notCheckable = true
		info.notClickable = true
		UIDropDownMenu_AddButton(info, level)
		for i, v in ipairs(cat) do
			if type(mod.Options[v]) == "boolean" then
				info = UIDropDownMenu_CreateInfo()
				info.text = mod.localization.options[v]
				info.keepShownOnClick = 1
				info.checked = mod.Options[v]
				info.func = function() mod.Options[v] = not mod.Options[v] end
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end
end

-- ugly? yes!
function initialize(self, level, menuList)
	local info
	if menuList and menuList:sub(0, 3) == "mod" then
		createBossModEntry(menuList:sub(4), level)
	elseif level == 1 then
		info = UIDropDownMenu_CreateInfo()
		info.text = "Deadly Boss Mods"
		info.isTitle = true
		UIDropDownMenu_AddButton(info, 1)
		for i, v in ipairs(DBM.AddOns) do
			if IsAddOnLoaded(v.modId) then
				info = UIDropDownMenu_CreateInfo()
				info.text = v.name
				info.notCheckable = true
				info.hasArrow = true
				info.menuList = "instance"..v.modId
				UIDropDownMenu_AddButton(info, 1)
			end
		end
		info = UIDropDownMenu_CreateInfo()
		info.text = DBM_LDB_LOAD_MODS
		info.notCheckable = true
		info.hasArrow = true
		info.menuList = "load"
		UIDropDownMenu_AddButton(info, 1)
	elseif level == 2 then
		if menuList == "load" then
			for i, v in ipairs(categories) do
				info = UIDropDownMenu_CreateInfo()
				info.text = getglobal("DBM_LDB_CAT_"..v) or v
				info.notCheckable = true
				info.hasArrow = true
				info.menuList = "load"..v
				UIDropDownMenu_AddButton(info, 2)
			end
		elseif menuList and menuList:sub(0, 8) == "instance" then
			local modId = menuList:sub(9)
			for i, v in ipairs(DBM.AddOns) do
				if v.modId == modId then
					if v.subTabs then
						for i, tab in ipairs(v.subTabs) do
							info = UIDropDownMenu_CreateInfo()
							info.text = tab
							info.notCheckable = true
							info.hasArrow = true
							info.menuList = "instance\t"..v.modId.."\t"..i
							UIDropDownMenu_AddButton(info, 2)
						end
						return
					else
						for i, v in ipairs(DBM.Mods) do
							if v.modId == modId then
								info = UIDropDownMenu_CreateInfo()
								info.text = v.localization.general.name
								info.notCheckable = true
								info.hasArrow = true
								info.menuList = "mod"..v.id
								UIDropDownMenu_AddButton(info, 2)
							end
						end
					end
					break
				end
			end
		end
	elseif level == 3 then
		if menuList and menuList:sub(0, 4) == "load" then
			local k = menuList:sub(5)
			for i, v in ipairs(categories[k]) do
				if not IsAddOnLoaded(v.modId) then
					info = UIDropDownMenu_CreateInfo()
					info.text = v.name
					info.notCheckable = true
					info.func = function() DBM:LoadMod(v) CloseDropDownMenus() end
					UIDropDownMenu_AddButton(info, 3)
				end
			end
		elseif menuList and menuList:sub(0, 8) == "instance" then
			local modId, subTab = select(2, string.split("\t", menuList))
			for i, v in ipairs(DBM.Mods) do
				if v.modId == modId and v.subTab == tonumber(subTab) then
					info = UIDropDownMenu_CreateInfo()
					info.text = v.localization.general.name
					info.notCheckable = true
					info.hasArrow = true
					info.menuList = "mod"..v.id
					UIDropDownMenu_AddButton(info, 3)
				end
			end
		end
	end
end


f:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" and select(1, ...) == "DBM-LDB" then
		for i, v in ipairs(DBM.AddOns) do
			if not categories[v.category] then
				categories[v.category] = {}
				table.insert(categories, v.category)
			end
			table.insert(categories[v.category], v)
		end
		obj = ldb:NewDataObject("DBM-LDB", {
			type = "launcher",
--			text = "Deadly Boss Mods",
			label = "DBM",
			icon = "Interface\\AddOns\\DBM-Core\\textures\\Minimap-Button-Up",
			OnTooltipShow = function(self)
				GameTooltip:AddLine("Deadly Boss Mods", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
				GameTooltip:AddLine(("%s (r%s)"):format(DBM.DisplayVersion, DBM.Revision), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(DBM_LDB_TOOLTIP_HELP1, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b)
				GameTooltip:AddLine(DBM_LDB_TOOLTIP_HELP2, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b)
				GameTooltip:Show()
			end,
			OnClick = function(self, button)
				if button == "LeftButton" then
					DBM:LoadGUI()
				elseif button == "RightButton" then
					UIDropDownMenu_Initialize(dropdownFrame, initialize, "MENU")
					ToggleDropDownMenu(1, nil, dropdownFrame, "cursor", 5, -10)
				end
			end,
		})
	end
end)
f:RegisterEvent("ADDON_LOADED")

