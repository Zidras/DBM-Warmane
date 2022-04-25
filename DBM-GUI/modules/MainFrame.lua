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
-- frame.firstshow = true
-- frame:SetScript("OnShow", function(self)
-- 	if self.firstshow then
-- 		self.firstshow = false
-- 		self:ShowTab(1)
-- 	end
-- end)
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