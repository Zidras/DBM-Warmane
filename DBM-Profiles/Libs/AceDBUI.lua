AceDBUI = {}

local L = {
	default = "Default",
	reset = "Reset profile",
	new = "New",
	choose = "Existing profiles",
	copy = "Copy From",
	delete = "Delete a profile",
	delete_confirm = "Are you sure you want to delete the selected profile?",
	profiles = "Profiles",

	dual_profile = "Dual profile",
	enabled = "Enable dual profile",
}

local LOCALE = GetLocale()
if LOCALE == "deDE" then
	L["default"] = "Standard"
	L["reset"] = "Profil zur\195\188cksetzen"
	L["new"] = "Neu"
	L["choose"] = "Vorhandene Profile"
	L["copy"] = "Kopieren von..."
	L["delete"] = "Profil l\195\182schen"
	L["delete_confirm"] = "Willst du das ausgew\195\164hlte Profil wirklich l\195\182schen?"
	L["profiles"] = "Profile"
	
	L["dual_profile"] = "Duales Profil"
	L["enabled"] = "Aktiviere Duale Profile"
elseif LOCALE == "frFR" then
	L["default"] = "D\195\169faut"
	L["reset"] = "R\195\169initialiser le profil"
	L["new"] = "Nouveau"
	L["choose"] = "Profils existants"
	L["copy"] = "Copier \195\160 partir de"
	L["delete"] = "Supprimer un profil"
	L["delete_confirm"] = "Etes-vous s\195\187r de vouloir supprimer le profil s\195\169lectionn\195\169 ?"
	L["profiles"] = "Profils"

	L["dual_profile"] = 'Second profil'
	L["enabled"] = 'Activez le second profil'
elseif LOCALE == "koKR" then
	L["default"] = "기본값"
	L["reset"] = "프로필 초기화"
	L["new"] = "새로운 프로필"
	L["choose"] = "프로필 선택"
	L["copy"] = "복사"
	L["delete"] = "프로필 삭제"
	L["delete_confirm"] = "정말로 선택한 프로필의 삭제를 원하십니까?"
	L["profiles"] = "프로필"
	
	L["dual_profile"] = "이중 프로필"
	L["enabled"] = "이중 프로필 사용"
elseif LOCALE == "esES" or LOCALE == "esMX" then
	L["default"] = "Por defecto"
	L["reset"] = "Reiniciar Perfil"
	L["new"] = "Nuevo"
	L["choose"] = "Perfiles existentes"
	L["copy"] = "Copiar de"
	L["delete"] = "Borrar un Perfil"
	L["delete_confirm"] = "¿Estas seguro que quieres borrar el perfil seleccionado?"
	L["profiles"] = "Perfiles"
	
	L["dual_profile"] = "Perfil dual"
	L["enabled"] = "Habilitar perfil dual"
elseif LOCALE == "zhTW" then
	L["default"] = "預設"
	L["reset"] = "重置設定檔"
	L["new"] = "新建"
	L["choose"] = "現有的設定檔"
	L["copy"] = "複製自"
	L["delete"] = "刪除一個設定檔"
	L["delete_confirm"] = "你確定要刪除所選擇的設定檔嗎？"
	L["profiles"] = "設定檔"
	
	L["dual_profile"] = "雙重輪廓"
	L["enabled"] = "啟用雙配置文件"
elseif LOCALE == "zhCN" then
	L["default"] = "默认"
	L["reset"] = "重置配置文件"
	L["choose_desc"] = "你可以通过在文本框内输入一个名字创立一个新的配置文件，也可以选择一个已经存在的配置文件。"
	L["new"] = "新建"
	L["choose"] = "现有的配置文件"
	L["copy"] = "复制自"
	L["delete"] = "删除一个配置文件"
	L["delete_confirm"] = "你确定要删除所选择的配置文件么？"
	L["profiles"] = "配置文件"
	
	L["dual_profile"] = "双重配置文件"
	L["enabled"] = "开启双重配置文件"
elseif LOCALE == "ruRU" then
	L["default"] = "По умолчанию"
	L["reset"] = "Сброс профиля"
	L["new"] = "Новый"
	L["choose"] = "Существующие профили"
	L["copy"] = "Скопировать из"
	L["delete"] = "Удалить профиль"
	L["delete_confirm"] = "Вы уверены, что вы хотите удалить выбранный профиль?"
	L["profiles"] = "Профили"
	
	L["dual_profile"] = "Второй профиль"
	L["enabled"] = "Включить двойной профиль"
end

local defaultProfiles = {}

local function profileSort(a, b)
	return a.value < b.value
end

local tempProfiles = {}

local function getProfiles(db, common, nocurrent)
	local profiles = {}
	
	-- copy existing profiles into the table
	local currentProfile = db:GetCurrentProfile()
	for _, v in ipairs(db:GetProfiles(tempProfiles)) do 
		if not (nocurrent and v == currentProfile) then 
			profiles[v] = v 
		end 
	end
	
	-- add our default profiles to choose from ( or rename existing profiles)
	for k, v in pairs(defaultProfiles) do
		if (common or profiles[k]) and not (nocurrent and k == currentProfile) then
			profiles[k] = v
		end
	end
	
	local sortProfiles = {}
	for k, v in pairs(profiles) do
		tinsert(sortProfiles, {text = v, value = k})
	end
	sort(sortProfiles, profileSort)
	
	return sortProfiles
end

local function initializeDropdown(self, level, menuList)
	for _, v in ipairs(getProfiles(self.db, self.common, self.nocurrent)) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = v.text
		info.func = self.func
		info.arg1 = v.value
		info.checked = (v.value == self.db[self.current or "GetCurrentProfile"](self.db))
		info.notCheckable = self.nocurrent
		info.owner = self
		UIDropDownMenu_AddButton(info)
	end
end

local currentDB
local widgetIndex = 1
local function getWidgetName()
	local name = currentDB.."Widget"..widgetIndex
	widgetIndex = widgetIndex + 1
	return name
end

local function setEnabled(self, enabled)
	if enabled then
		UIDropDownMenu_EnableDropDown(self)
	else
		UIDropDownMenu_DisableDropDown(self)
	end
end

local function createDropdown(parent)
	local name = getWidgetName()
	local dropdown = CreateFrame("Frame", name, parent, "UIDropDownMenuTemplate")
	UIDropDownMenu_SetWidth(dropdown, 160)
	UIDropDownMenu_JustifyText(dropdown, "LEFT")
	dropdown.SetEnabled = setEnabled
	dropdown.initialize = initializeDropdown
	dropdown.menuList = defaultProfiles
	
	local label = dropdown:CreateFontString(name.."Label", "BACKGROUND", "GameFontNormalSmall")
	label:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 20, 2)
	dropdown.label = label
	
	return dropdown
end

local function createButton(parent)
	local button = CreateFrame("Button", getWidgetName(), parent, "UIPanelButtonTemplate")
	return button
end

local function profilesLoaded(self)
	local db = self.db
	
	for k, object in pairs(self.objects) do
		object.db = db
		self[k] = object
	end
	
	db.RegisterCallback(self, "OnProfileChanged")
	db.RegisterCallback(self, "OnNewProfile")
	db.RegisterCallback(self, "OnProfileDeleted")
	
	local keys = db.keys
	defaultProfiles["Default"] = L.default
	defaultProfiles[keys.char] = keys.char
	defaultProfiles[keys.realm] = keys.realm
	defaultProfiles[keys.class] = UnitClass("player")
	
	UIDropDownMenu_SetText(self.choose, db:GetCurrentProfile())
	
	UIDropDownMenu_SetText(self.dualProfile, db:GetDualSpecProfile())
	
	local isDualSpecEnabled = db:IsDualSpecEnabled()
	self.dualEnabled:SetChecked(isDualSpecEnabled)
	self.dualProfile:SetEnabled(isDualSpecEnabled)
	
	self:CheckProfiles()
end

local mixins = {
	OnNewProfile = function(self, event, db, profile)
		self:CheckProfiles()
	end,
	OnProfileChanged = function(self, event, db, profile)
		UIDropDownMenu_SetText(self.choose, profile)
		UIDropDownMenu_SetText(self.dualProfile, db:GetDualSpecProfile())
		self:CheckProfiles()
	end,
	OnProfileDeleted = function(self, event, db, profile)
		UIDropDownMenu_SetText(self.delete, nil)
		self:CheckProfiles()
	end,
	CheckProfiles = function(self)
		local hasNoProfiles = self:HasNoProfiles()
		self.copy:SetEnabled(not hasNoProfiles)
		self.delete:SetEnabled(not hasNoProfiles)
	end,
	HasNoProfiles = function(self)
		return next(getProfiles(self.db, nil, true)) == nil
	end
}

local function newProfileOnEnterPressed(self)
	self.db:SetProfile(self:GetText())
	self:ClearFocus()
end

local profileText = "Enter new profile name"

local function onEditFocusGained(self)
	self:SetTextColor(1, 1, 1)
	self:SetText("")
end

local function onEditFocusLost(self)
	self:SetTextColor(0.5, 0.5, 0.5)
	self:SetText(profileText)
end

local function chooseProfileOnClick(self, profile)
	self.owner.db:SetProfile(profile)
end

local function enableDualProfileOnClick(self)
	local checked = self:GetChecked() == 1
	self.db:SetDualSpecEnabled(checked)
	self.dualProfile:SetEnabled(checked)
end

local function dualProfileOnClick(self, profile)
	self.owner.db:SetDualSpecProfile(profile)
	UIDropDownMenu_SetSelectedValue(self.owner, profile)
end

local function copyProfileOnClick(self, profile)
	self.owner.db:CopyProfile(profile)
end

local function deleteProfileOnClick(self, profile)
	StaticPopup_Show("DELETE_PROFILE", nil, nil, {db = self.owner.db, profile = profile})
	UIDropDownMenu_SetSelectedValue(self.owner, profile)
end

function AceDBUI:CreateUI(name, db, frame)
	frame = frame or CreateFrame("Frame", name)
	frame.db = db
	
	currentDB = name
	
	frame.ProfilesLoaded = profilesLoaded
	for k, v in pairs(mixins) do frame[k] = v end
	
	-- addon.RegisterCallback(frame, "AddonLoaded", "ProfilesLoaded")
	
	local objects = {}
	frame.objects = objects

	local newProfile = CreateFrame("EditBox", getWidgetName(), frame, "InputBoxTemplate")
	newProfile:SetWidth(170)
	newProfile:SetHeight(25)
	newProfile:SetPoint("TOP", 0, -50)
	newProfile:SetFontObject("ChatFontSmall")
	newProfile:SetAutoFocus(false)
	newProfile:SetScript("OnEscapePressed", newProfile.ClearFocus)
	newProfile:SetScript("OnEnterPressed", newProfileOnEnterPressed)
	newProfile:SetScript("OnEditFocusGained", onEditFocusGained)
	newProfile:SetScript("OnEditFocusLost", onEditFocusLost)
	newProfile:SetTextColor(0.5, 0.5, 0.5)
	newProfile:SetText(profileText)
	-- newProfile.label:SetText(L.new)
	objects.newProfile = newProfile
	
	local choose = createDropdown(frame)
	choose:SetPoint("TOP", newProfile, "BOTTOM", -4, -20)
	choose.label:SetText(L.choose)
	choose.func = chooseProfileOnClick
	choose.common = true
	objects.choose = choose
	
	local reset = createButton(frame)
	reset:SetHeight(18)
	reset:SetWidth(90)
	reset:SetPoint("RIGHT", choose, 85, 2)
	reset:SetScript("OnClick", function(self) self.db:ResetProfile() end)
	reset:SetText(L.reset)
	objects.reset = reset

	local copy = createDropdown(frame)
	copy:SetPoint("TOP", choose, "BOTTOM", 0, -16)
	copy.label:SetText(L.copy)
	copy.func = copyProfileOnClick
	copy.nocurrent = true
	objects.copy = copy

	delete = createDropdown(frame)
	delete:SetPoint("TOP", copy, "BOTTOM", 0, -16)
	delete.label:SetText(L.delete)
	delete.func = deleteProfileOnClick
	delete.nocurrent = true
	objects.delete = delete
	
	do
		local dualProfile = createDropdown(frame)
		dualProfile:SetPoint("TOP", delete, "BOTTOM", 0, -32)
		dualProfile:SetPoint("LEFT", choose)
		-- dualProfile.label:SetText(L.dual_profile)
		dualProfile.current = "GetDualSpecProfile"
		dualProfile.func = dualProfileOnClick
		dualProfile.common = true
		objects.dualProfile = dualProfile
		
		local enabled = CreateFrame("CheckButton", nil, frame, "OptionsBaseCheckButtonTemplate")
		enabled:SetPoint("BOTTOMLEFT", dualProfile, "TOPLEFT", 16, 0)
		enabled:SetPushedTextOffset(0, 0)
		enabled:SetScript("OnClick", enableDualProfileOnClick)
		enabled.tooltipText = L.enable_desc
		local text = enabled:CreateFontString(nil, nil, "GameFontHighlight")
		text:SetPoint("LEFT", enabled, "RIGHT", 0, 1)
		text:SetText(L.enabled)
		objects.dualEnabled = enabled

		enabled.dualProfile = dualProfile
	end
	
	profilesLoaded(frame)
	return frame
end

StaticPopupDialogs["DELETE_PROFILE"] = {
	text = L.delete_confirm,
	button1 = YES,
	button2 = NO,
	OnAccept = function(_, data)
		data.db:DeleteProfile(data.profile)
	end,
	OnCancel = function()
		UIDropDownMenu_SetText(delete, nil)
	end,
	timeout = 0,
}
