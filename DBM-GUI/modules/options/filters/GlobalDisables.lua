local L = DBM_GUI_L

local spamPanel = DBM_GUI.Cat_Filters:CreateNewPanel(L.Panel_SpamFilter, "option")

local spamSpecAnnounceFeat = spamPanel:CreateArea(L.Area_SpamFilter_SpecFeatures)
spamSpecAnnounceFeat:CreateCheckButton(L.SpamBlockNoShowAnnounce, true, nil, "DontShowBossAnnounces")
spamSpecAnnounceFeat:CreateCheckButton(L.SpamBlockNoSpecWarnText, true, nil, "DontShowSpecialWarningText")
spamSpecAnnounceFeat:CreateCheckButton(L.SpamBlockNoSpecWarnFlash, true, nil, "DontShowSpecialWarningFlash")
-- spamSpecAnnounceFeat:CreateCheckButton(L.SpamBlockNoSpecWarnVibrate, true, nil, "DontDoSpecialWarningVibrate")
spamSpecAnnounceFeat:CreateCheckButton(L.SpamBlockNoSpecWarnSound, true, nil, "DontPlaySpecialWarningSound")

local spamTimers = spamPanel:CreateArea(L.Area_SpamFilter_Timers)
spamTimers:CreateCheckButton(L.SpamBlockNoShowBossTimers, true, nil, "DontShowBossTimers")
spamTimers:CreateCheckButton(L.SpamBlockNoShowTrashTimers, true, nil, "DontShowTrashTimers")
spamTimers:CreateCheckButton(L.SpamBlockNoShowEventTimers, true, nil, "DontShowEventTimers")
spamTimers:CreateCheckButton(L.SpamBlockNoShowUTimers, true, nil, "DontShowUserTimers")
spamTimers:CreateCheckButton(L.SpamBlockNoCountdowns, true, nil, "DontPlayCountdowns")

local spamNameplates = spamPanel:CreateArea(L.Area_SpamFilter_Nameplates)
spamNameplates:CreateCheckButton(L.SpamBlockNoNameplate, true, nil, "DontShowNameplateIcons")
if _G["Plater"] then
	spamNameplates:CreateCheckButton(L.SpamBlockNoBossGUIDs, true, nil, "DontSendBossGUIDs")
	spamNameplates:CreateCheckButton(L.SpamBlockTimersWithNameplates, true, nil, "DontShowTimersWithNameplates")
else
	local infotext = spamNameplates:CreateText(L.NameplateFooter, nil, false, GameFontNormalSmall, "LEFT", 25)
	infotext:SetPoint("BOTTOMLEFT", spamNameplates.frame, "BOTTOMLEFT", 10, 10)
end

local spamMisc = spamPanel:CreateArea(L.Area_SpamFilter_Misc)
spamMisc:CreateCheckButton(L.SpamBlockNoSetIcon, true, nil, "DontSetIcons")
spamMisc:CreateCheckButton(L.SpamBlockNoRangeFrame, true, nil, "DontShowRangeFrame")
spamMisc:CreateCheckButton(L.SpamBlockNoInfoFrame, true, nil, "DontShowInfoFrame")
spamMisc:CreateCheckButton(L.SpamBlockNoHudMap, true, nil, "DontShowHudMap2")

spamMisc:CreateCheckButton(L.SpamBlockNoYells, true, nil, "DontSendYells")
spamMisc:CreateCheckButton(L.SpamBlockNoNoteSync, true, nil, "BlockNoteShare")

local spamRestoreArea = spamPanel:CreateArea(L.Area_Restore)
spamRestoreArea:CreateCheckButton(L.SpamBlockNoIconRestore, true, nil, "DontRestoreIcons")
spamRestoreArea:CreateCheckButton(L.SpamBlockNoRangeRestore, true, nil, "DontRestoreRange")

local spamPTArea = spamPanel:CreateArea(L.Area_PullTimer)
spamPTArea:CreateCheckButton(L.DontShowPTNoID, true, nil, "DontShowPTNoID")
spamPTArea:CreateCheckButton(L.DontShowPT, true, nil, "DontShowPT2")
spamPTArea:CreateCheckButton(L.DontShowPTText, true, nil, "DontShowPTText")
spamPTArea:CreateCheckButton(L.DontShowPTCountdownText, true, nil, "DontShowPTCountdownText")
local SPTCDA = spamPTArea:CreateCheckButton(L.DontPlayPTCountdown, true, nil, "DontPlayPTCountdown")

local PTSlider = spamPTArea:CreateSlider(L.PT_Threshold, 1, 10, 1, 300)
PTSlider:SetPoint("BOTTOMLEFT", SPTCDA, "BOTTOMLEFT", 80, -40)
PTSlider:SetValue(math.floor(DBM.Options.PTCountThreshold2))
PTSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.PTCountThreshold2 = math.floor(self:GetValue())
end)

local spamTTArea = spamPanel:CreateArea(L.Area_TimerTracker)
spamTTArea:CreateCheckButton(L.PlayTT, true, nil, "PlayTT")
spamTTArea:CreateCheckButton(L.PlayTTCountdown, true, nil, "PlayTTCountdown")
spamTTArea:CreateCheckButton(L.PlayTTCountdownFinished, true, nil, "PlayTTCountdownFinished")

local spamBBArea = spamPanel:CreateArea(L.Area_BossBanner)
spamBBArea:CreateCheckButton(L.EnableBB, true, nil, "EnableBB")
spamBBArea:CreateCheckButton(L.PlayBBLoot, true, nil, "PlayBBLoot")
spamBBArea:CreateCheckButton(L.PlayBBSound, true, nil, "PlayBBSound")
local overrideBBFont = spamBBArea:CreateCheckButton(L.OverrideBBFont, true, nil, "OverrideBBFont")
overrideBBFont:HookScript("OnClick", function()
	BossBanner:UpdateStyle()
end)

-- BossBanner Font
local Fonts = DBM_GUI:MixinSharedMedia3("font", {
	{
		text	= DEFAULT,
		value	= "standardFont"
	},
	{
		text	= "Arial",
		value	= "Fonts\\ARIALN.TTF"
	},
	{
		text	= "Skurri",
		value	= "Fonts\\SKURRI.TTF"
	},
	{
		text	= "Morpheus",
		value	= "Fonts\\MORPHEUS.TTF"
	}
})

local FontDropDown = spamBBArea:CreateDropdown(L.FontType, Fonts, "DBM", "BBFont", function(value)
	DBM.Options.BBFont = value
	BossBanner:UpdateStyle()
end)
FontDropDown:SetPoint("TOPLEFT", overrideBBFont, "BOTTOMLEFT", 0, -10)

-- BossBanner Font Style
local FontStyles = {
	{
		text	= L.None,
		value	= "None"
	},
	{
		text	= L.Outline,
		value	= "OUTLINE",
		flag	= true
	},
	{
		text	= L.ThickOutline,
		value	= "THICKOUTLINE",
		flag	= true
	},
	{
		text	= L.MonochromeOutline,
		value	= "MONOCHROME,OUTLINE",
		flag	= true
	},
	{
		text	= L.MonochromeThickOutline,
		value	= "MONOCHROME,THICKOUTLINE",
		flag	= true
	}
}

local FontStyleDropDown = spamBBArea:CreateDropdown(L.FontStyle, FontStyles, "DBM", "BBFontStyle", function(value)
	DBM.Options.BBFontStyle = value
	BossBanner:UpdateStyle()
end)
FontStyleDropDown:SetPoint("TOPLEFT", FontDropDown, "BOTTOMLEFT", 0, -10)

-- BossBanner Font Shadow
local FontShadow = spamBBArea:CreateCheckButton(L.FontShadow, nil, nil, "BBFontShadow")
FontShadow:SetScript("OnClick", function()
	DBM.Options.BBFontShadow = not DBM.Options.BBFontShadow
	BossBanner:UpdateStyle()
end)
FontShadow:SetPoint("LEFT", FontStyleDropDown, "RIGHT", 35, 0)

-- BossBanner Font Size (add/subtract to default size)
local fontSizeSlider = spamBBArea:CreateSlider(L.FontSize, -10, 10, 1, 200)
fontSizeSlider:SetPoint("TOPLEFT", FontStyleDropDown, "TOPLEFT", 20, -45)
fontSizeSlider:SetValue(DBM.Options.BBFontSize)
fontSizeSlider:HookScript("OnValueChanged", function(self)
	DBM.Options.BBFontSize = self:GetValue()
	BossBanner:UpdateStyle()
end)

-- BossBanner Test Buttons
local testButton = spamBBArea:CreateButton(ANIMATION, 120, 16)
testButton:SetPoint("TOPRIGHT", spamBBArea.frame, "TOPRIGHT", -2, -4)
testButton:SetNormalFontObject(GameFontNormalSmall)
testButton:SetHighlightFontObject(GameFontNormalSmall)
testButton:SetScript("OnClick", function()
	BossBanner:Test()
end)

local showButton = spamBBArea:CreateButton(SHOW_TOAST_WINDOW_TEXT, 100, 16)
showButton:SetPoint("BOTTOMRIGHT", testButton, "BOTTOMLEFT", -2, 0)
showButton:SetNormalFontObject(GameFontNormalSmall)
showButton:SetHighlightFontObject(GameFontNormalSmall)
showButton:SetScript("OnClick", function()
	BossBanner:Show()
end)

-- BossBanner Keybinds
local keybindsString = "|cffffffff"..string.upper(KEY_BINDINGS).."|r\n"..KEY_BUTTON2..": "..HIDE
local keybindsInfotext = spamBBArea:CreateText(keybindsString, nil, false, GameFontNormal, "LEFT", 0)
keybindsInfotext:SetPoint("BOTTOMLEFT", spamBBArea.frame, "BOTTOMLEFT", 10, 10)
