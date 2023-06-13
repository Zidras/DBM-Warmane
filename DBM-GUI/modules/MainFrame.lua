local L		= DBM_GUI_L
local CL	= DBM_CORE_L

local DBM = DBM
local CreateFrame = CreateFrame

local frame = _G["DBM_GUI_OptionsFrame"]
table.insert(_G["UISpecialFrames"], frame:GetName())
frame:SetFrameStrata("DIALOG")
if DBM.Options.GUIPoint then
	frame:SetPoint(DBM.Options.GUIPoint, UIParent, DBM.Options.GUIPoint, DBM.Options.GUIX, DBM.Options.GUIY)
else
	frame:SetPoint("CENTER")
end
if DBM.Options.GUIWidth then
	frame:SetSize(DBM.Options.GUIWidth, DBM.Options.GUIHeight)
else
	frame:SetSize(800, 600)
end
frame:EnableMouse(true)
frame:SetMovable(true)
frame:SetResizable(true)
frame:SetClampedToScreen(true)
frame:SetUserPlaced(true)
frame:RegisterForDrag("LeftButton")
frame:SetFrameLevel(frame:GetFrameLevel() + 4)
frame:SetMinResize(800, 400)
frame:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())
frame:Hide()
frame.backdropInfo = {
	bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background-Dark", -- 131071
	edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border", -- 131072
	tile		= true,
	tileSize	= 32,
	edgeSize	= 32,
	insets		= { left = 11, right = 12, top = 12, bottom = 11 }
}

frame:SetBackdrop(frame.backdropInfo)
frame:SetBackdropColor(1, 1, 1, .85)
frame.firstshow = true
frame:SetScript("OnShow", function(self)
	if self.firstshow then
		self.firstshow = false
		self:ShowTab(1)
	end
end)
frame:SetScript("OnHide", function()
	_G["DBM_GUI_DropDown"]:Hide()
end)
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	local point, _, _, x, y = self:GetPoint(1)
	DBM.Options.GUIPoint = point
	DBM.Options.GUIX = x
	DBM.Options.GUIY = y
end)
frame:SetScript("OnSizeChanged", function(self)
	self:UpdateMenuFrame(_G[self:GetName().."BossMods"])
	if DBM_GUI.currentViewing then
		self:DisplayFrame(DBM_GUI.currentViewing)
	end
end)
frame:SetScript("OnMouseUp", function(self)
	self:StopMovingOrSizing()
end)
frame.tabs = {}

-- Window Resizer (taken from WA)
--Check if DBM is being skinned by ElvUI, so we can adjust placement for both templates
local ElvUIAddonSkins, ElvUI_DBMSkin = IsAddOnLoaded("ElvUI_AddonSkins"), false
if ElvUIAddonSkins and ElvUI[1].private.addOnSkins.DBM then
	ElvUI_DBMSkin = true -- no need for an else statement, since ElvUI prompts UI reload if the option changes.
end

local function createFrameSizer(window, position)
	local left, right, top, bottom, xOffset1, yOffset1, xOffset2, yOffset2
	if position == "BOTTOMLEFT" then
		left, right, top, bottom = 1, 0, 0, 1
		xOffset1, yOffset1 = 6, 6
		xOffset2, yOffset2 = 0, 0
	elseif position == "BOTTOMRIGHT" then
		left, right, top, bottom = 0, 1, 0, 1
		xOffset1, yOffset1 = 0, 6
		xOffset2, yOffset2 = -6, 0
	elseif position == "TOPLEFT" then
		left, right, top, bottom = 1, 0, 1, 0
		xOffset1, yOffset1 = 6, 0
		xOffset2, yOffset2 = 0, -6
	elseif position == "TOPRIGHT" then
		left, right, top, bottom = 0, 1, 1, 0
		xOffset1, yOffset1 = 0, 0
		xOffset2, yOffset2 = -6, -6
	end

	local handle = CreateFrame("Button", nil, window)
	handle:SetPoint(position, window)
	if ElvUI_DBMSkin then
		handle:SetSize(16, 16)
	else
		handle:SetSize(25, 25)
	end
	handle:EnableMouse()

	handle:SetScript("OnMouseDown", function()
		frame:StartSizing(position)
	end)

	handle:SetScript("OnMouseUp", function()
		frame:StopMovingOrSizing()
		DBM.Options.GUIWidth = frame:GetWidth()
		DBM.Options.GUIHeight = frame:GetHeight()
	end)

	local normal = handle:CreateTexture(nil, "OVERLAY")
	normal:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
	normal:SetTexCoord(left, right, top, bottom)
	if ElvUI_DBMSkin then
		normal:SetPoint(position, handle)
	else
		normal:SetPoint("BOTTOMLEFT", handle, xOffset1, yOffset1)
		normal:SetPoint("TOPRIGHT", handle, xOffset2, yOffset2)
	end
	handle:SetNormalTexture(normal)

	local pushed = handle:CreateTexture(nil, "OVERLAY")
	pushed:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
	pushed:SetTexCoord(left, right, top, bottom)
	if ElvUI_DBMSkin then
		pushed:SetPoint(position, handle)
	else
		pushed:SetPoint("BOTTOMLEFT", handle, xOffset1, yOffset1)
		pushed:SetPoint("TOPRIGHT", handle, xOffset2, yOffset2)
	end
	handle:SetPushedTexture(pushed)

	local highlight = handle:CreateTexture(nil, "OVERLAY")
	highlight:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
	highlight:SetTexCoord(left, right, top, bottom)
	if ElvUI_DBMSkin then
		highlight:SetPoint(position, handle)
	else
		highlight:SetPoint("BOTTOMLEFT", handle, xOffset1, yOffset1)
		highlight:SetPoint("TOPRIGHT", handle, xOffset2, yOffset2)
	end
	handle:SetHighlightTexture(highlight)

	return handle
end
createFrameSizer(frame, "BOTTOMLEFT")
createFrameSizer(frame, "BOTTOMRIGHT")

local frameHeader = frame:CreateTexture("$parentHeader", "ARTWORK")
frameHeader:SetPoint("TOP", 0, 12)
frameHeader:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
frameHeader:SetSize(300, 68)

local frameHeaderText = frame:CreateFontString("$parentHeaderText", "ARTWORK", "GameFontNormal")
frameHeaderText:SetPoint("TOP", frameHeader, 0, -14)
frameHeaderText:SetText(L.MainFrame)

local frameRevision = frame:CreateFontString("$parentRevision", "ARTWORK", "GameFontDisableSmall")
frameRevision:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 20, 18)
if DBM.NewerVersion then
	frameRevision:SetText(L.DBMWarmane.. " " .. DBM.DisplayVersion.. " (" .. DBM:ShowRealDate(DBM.Revision) .. "). |cffff0000Version " .. DBM.NewerVersion .. " is available.|r")
else
	frameRevision:SetText(L.DBMWarmane.. " " .. DBM.DisplayVersion.. " (" .. DBM:ShowRealDate(DBM.Revision) .. ")")
end

do
	local count = 0

	local frameHeaderButton = CreateFrame("Button", nil, frame)
	frameHeaderButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 20, 18)
	frameHeaderButton:SetSize(frameRevision:GetSize())
	frameHeaderButton:EnableMouse(true)
	frameHeaderButton:SetScript("OnMouseUp", function()
		count = count + 1
		if count == 3 then
			count = 0
			DBM:PlaySoundFile("Interface\\AddOns\\DBM-Core\\Sounds\\RetailSupport\\VO_DHNightElfMalePissed04.ogg", true)
		end
		DBM:ShowUpdateReminder(nil, nil, CL.COPY_URL_DIALOG, DBM.DisplayVersion.. " (" .. DBM:ShowRealDate(DBM.Revision) .. ")") -- Custom, for easier copy paste
	end)
end

local frameTranslation = frame:CreateFontString("$parentTranslation", "ARTWORK", "GameFontDisableSmall")
frameTranslation:SetPoint("LEFT", frameRevision, "RIGHT", 20, 0)
if L.TranslationBy then
	frameTranslation:SetText(L.TranslationByPrefix .. L.TranslationBy)
end

local frameOkay = CreateFrame("Button", "$parentOkay", frame, "UIPanelButtonTemplate")
frameOkay:SetSize(96, 22)
frameOkay:SetPoint("BOTTOMRIGHT", -16, 14)
frameOkay:SetText(CLOSE)
frameOkay:SetScript("OnClick", function()
	frame:Hide()
	if DBM.Options.tempMusicSetting then
		SetCVar("Sound_EnableMusic", DBM.Options.tempMusicSetting)
		DBM.Options.tempMusicSetting = nil
	end
	if DBM.Options.musicPlaying then
		StopMusic()
		DBM.Options.musicPlaying = nil
	end
end)

local frameWebsite = frame:CreateFontString("$parentWebsite", "ARTWORK", "GameFontNormal")
frameWebsite:SetPoint("BOTTOMLEFT", frameRevision, "TOPLEFT", 0, 15)
frameWebsite:SetPoint("RIGHT", frameOkay, "RIGHT")
frameWebsite:SetText(L.Website)

local frameWebsiteButtonA = CreateFrame("Button", nil, frame)
frameWebsiteButtonA:SetAllPoints(frameWebsite)
frameWebsiteButtonA:SetScript("OnMouseUp", function()
	DBM:ShowUpdateReminder(nil, nil, CL.COPY_URL_DIALOG, "https://discord.gg/CyVWDWS")
end)

local frameWebsiteButton = CreateFrame("Button", "$parentWebsiteButton", frame, "UIPanelButtonTemplate")
frameWebsiteButton:SetSize(96, 22)
frameWebsiteButton:SetPoint("BOTTOMRIGHT", frameOkay, "BOTTOMLEFT", -20, 0)
frameWebsiteButton:SetText(L.WebsiteButton)
frameWebsiteButton:SetScript("OnClick", function()
	DBM:ShowUpdateReminder(nil, nil, CL.COPY_URL_DIALOG)
end)

local bossMods = CreateFrame("Frame", "$parentBossMods", frame)
bossMods.name = L.OTabBosses
frame:CreateTab(bossMods)

local DBMOptions = CreateFrame("Frame", "$parentDBMOptions", frame)
DBMOptions.name = L.OTabOptions
frame:CreateTab(DBMOptions)

local hack = OptionsList_OnLoad
function OptionsList_OnLoad(self, ...)
	if self:GetName() ~= frame:GetName() .. "List" then
		hack(self, ...)
	end
end

local frameList = CreateFrame("Frame", "$parentList", frame, "OptionsFrameListTemplate")
frameList:SetWidth(205)
frameList:SetPoint("TOPLEFT", 22, -40)
frameList:SetPoint("BOTTOMLEFT", frameWebsite, "TOPLEFT", 0, 5)
frameList:SetScript("OnShow", function()
	frame:UpdateMenuFrame()
end)
frameList.offset = 0
frameList:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
frameList.buttons = {}
for i = 1, math.floor(UIParent:GetHeight() / 18) do
	local button = CreateFrame("Button", "$parentButton" .. i, frameList)
	button:SetHeight(18)
	button.text = button:CreateFontString("$parentText", "ARTWORK", "GameFontNormalSmall")
	button:RegisterForClicks("LeftButtonUp")
	button:SetScript("OnClick", function(self)
		frame:ClearSelection()
		frame.tabs[frame.tab].selection = self.element
		self:LockHighlight()
		frame:DisplayFrame(self.element)
	end)
	if i == 1 then
		button:SetPoint("TOPLEFT", frameList, 0, -8)
	else
		button:SetPoint("TOPLEFT", frameList.buttons[i - 1], "BOTTOMLEFT")
	end
	local buttonHighlight = button:CreateTexture("$parentHighlight")
	buttonHighlight:SetTexture("Interface\\QuestFrame\\UI-QuestLogTitleHighlight")
	buttonHighlight:SetBlendMode("ADD")
	buttonHighlight:SetPoint("TOPLEFT", 0, 1)
	buttonHighlight:SetPoint("BOTTOMRIGHT", 0, 1)
	buttonHighlight:SetVertexColor(0.196, 0.388, 0.8)
	button:SetHighlightTexture(buttonHighlight)
	frameList.buttons[i] = button
	local buttonToggle = CreateFrame("Button", "$parentToggle", button, "UIPanelButtonTemplate2")
	button.toggle = buttonToggle
	buttonToggle:SetSize(14, 14)
	buttonToggle:SetPoint("TOPLEFT", button, "TOPLEFT", 5, -1)
	-- Add textures to button to prevent errors when skinning
	buttonToggle:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP")
	--
	buttonToggle:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	buttonToggle:SetScript("OnClick", function()
		button.element.showSub = not button.element.showSub
		frame:UpdateMenuFrame()
	end)
end
local frameListList = _G[frameList:GetName() .. "List"]
frameListList.backdropInfo = {
	edgeFile	= "Interface\\Tooltips\\UI-Tooltip-Border", -- 137057
	tile		= true,
	tileSize	= 16,
	edgeSize	= 12,
	insets		= { left = 0, right = 0, top = 5, bottom = 5 }
}
frameListList:SetBackdrop(frameListList.backdropInfo)
frameListList:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.6)
frameListList:SetScript("OnVerticalScroll", function(self, offset)
	local scrollbar = _G[self:GetName() .. "ScrollBar"]
	local _, max = scrollbar:GetMinMaxValues()
	scrollbar:SetValue(offset)
	if offset ~= 0 then
		_G[self:GetName() .. "ScrollBarScrollUpButton"]:Enable()
	else
		_G[self:GetName() .. "ScrollBarScrollUpButton"]:Disable()
	end
	if scrollbar:GetValue() - max ~= 0 then
		_G[self:GetName() .. "ScrollBarScrollDownButton"]:Enable()
	else
		_G[self:GetName() .. "ScrollBarScrollDownButton"]:Disable()
	end
	frameList.offset = math.floor((offset / 18) + 0.5)
	frame:UpdateMenuFrame()
end)
local frameListScrollBar = _G[frameListList:GetName() .. "ScrollBar"]
frameListScrollBar:SetMinMaxValues(0, 11)
frameListScrollBar:SetValueStep(18)
frameListScrollBar:SetValue(0)
frameList:EnableMouseWheel(true)
frameList:SetScript("OnMouseWheel", function(_, delta)
	frameListScrollBar:SetValue(frameListScrollBar:GetValue() - (delta * 18))
end)
local scrollUpButton = _G[frameListScrollBar:GetName() .. "ScrollUpButton"]
scrollUpButton:Disable()
scrollUpButton:SetScript("OnClick", function(self)
	self:GetParent():SetValue(self:GetParent():GetValue() - 18)
end)
local scrollDownButton = _G[frameListScrollBar:GetName() .. "ScrollDownButton"]
scrollDownButton:Enable()
scrollDownButton:SetScript("OnClick", function(self)
	self:GetParent():SetValue(self:GetParent():GetValue() + 18)
end)

local frameContainer = CreateFrame("ScrollFrame", "$parentPanelContainer", frame)
frameContainer:SetPoint("TOPLEFT", frameList, "TOPRIGHT", 16, 0)
frameContainer:SetPoint("BOTTOMLEFT", frameList, "BOTTOMRIGHT", 16, 0)
frameContainer:SetPoint("RIGHT", -22, 0)
frameContainer.backdropInfo = {
	edgeFile	= "Interface\\Tooltips\\UI-Tooltip-Border", -- 137057
	edgeSize	= 16,
	tileEdge	= true
}
frameContainer:SetBackdrop(frameContainer.backdropInfo)
frameContainer:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

local frameContainerFOV = CreateFrame("ScrollFrame", "$parentFOV", frameContainer, "FauxScrollFrameTemplate")
frameContainerFOV:Hide()
frameContainerFOV:SetPoint("TOPLEFT", frameContainer, "TOPLEFT", 0, -5)
frameContainerFOV:SetPoint("BOTTOMRIGHT", frameContainer, "BOTTOMRIGHT", 0, 5)

_G[frameContainerFOV:GetName() .. "ScrollBarScrollUpButton"]:Disable()
_G[frameContainerFOV:GetName() .. "ScrollBarScrollDownButton"]:Enable()

local frameContainerScrollBar = _G[frameContainerFOV:GetName() .. "ScrollBar"]
frameContainerScrollBar:ClearAllPoints()
frameContainerScrollBar:SetPoint("TOPRIGHT", -4, -15)
frameContainerScrollBar:SetPoint("BOTTOMRIGHT", 0, 15)

local frameContainerScrollBarBackdrop = CreateFrame("Frame", nil, frameContainerScrollBar)
frameContainerScrollBarBackdrop:SetPoint("TOPLEFT", -4, 20)
frameContainerScrollBarBackdrop:SetPoint("BOTTOMRIGHT", 4, -20)
frameContainerScrollBarBackdrop.backdropInfo = {
	edgeFile	= "Interface\\Tooltips\\UI-Tooltip-Border", -- 137057
	tile		= true,
	tileSize	= 16,
	edgeSize	= 16,
	insets		= { left = 0, right = 0, top = 5, bottom = 5 }
}
frameContainerScrollBarBackdrop:SetBackdrop(frameContainerScrollBarBackdrop.backdropInfo)
frameContainerScrollBarBackdrop:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.6)
