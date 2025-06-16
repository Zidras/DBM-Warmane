local L = DBM_GUI_L

local hideBlizzPanel = DBM_GUI.Cat_Filters:CreateNewPanel(L.Panel_HideBlizzard, "option")
local hideBlizzArea = hideBlizzPanel:CreateArea(L.Area_HideBlizzard)

hideBlizzArea:CreateCheckButton(L.HideBossEmoteFrame, true, nil, "HideBossEmoteFrame2")
hideBlizzArea:CreateCheckButton(L.HideWatchFrame, true, nil, "HideObjectivesFrame")
--hideBlizzArea:CreateCheckButton(L.HideQuestTooltips, true, nil, "HideQuestTooltips")
hideBlizzArea:CreateCheckButton(L.HideTooltips, true, nil, "HideTooltips")
local DisableSFX	= hideBlizzArea:CreateCheckButton(L.DisableSFX, true, nil, "DisableSFX")

local movieOptions = {
	{	text	= L.DisableWoE,	value	= "Never"},
	--{	text	= L.OnlyFight,	value	= "OnlyFight"},
	--{	text	= L.AfterFirst,	value	= "AfterFirst"},
	{	text	= L.SkipWoE, value	= "Block"},
}
local blockMovieDropDown = hideBlizzArea:CreateDropdown(L.DisableCinematics, movieOptions, "DBM", "MovieFilter2", function(value)
	DBM.Options.MovieFilter2 = value
end, 350)
blockMovieDropDown:SetPoint("TOPLEFT", DisableSFX, "BOTTOMLEFT", -15, -45)
blockMovieDropDown.myheight = 45
