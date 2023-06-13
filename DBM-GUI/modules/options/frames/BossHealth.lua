local L = DBM_GUI_L
local DBM = DBM

local hpPanel = DBM_GUI.Cat_Frames:CreateNewPanel(L.Panel_HPFrame, "option")

local hpArea = hpPanel:CreateArea(L.Area_HPFrame, nil, 150, true)

hpArea:CreateCheckButton(L.HP_Enabled, true, nil, "AlwaysShowHealthFrame")
local growbttn = hpArea:CreateCheckButton(L.HP_GrowUpwards, true)
growbttn:SetScript("OnShow",  function(self) self:SetChecked(DBM.Options.HealthFrameGrowUp) end)
growbttn:SetScript("OnClick", function(self)
		DBM.Options.HealthFrameGrowUp = not not self:GetChecked()
		DBM.BossHealth:UpdateSettings()
end)


local BarWidthSlider = hpArea:CreateSlider(L.BarWidth, 150, 275, 1)
BarWidthSlider:SetPoint("TOPLEFT", hpArea.frame, "TOPLEFT", 20, -105)
BarWidthSlider:SetScript("OnShow", function(self) self:SetValue(DBM.Options.HealthFrameWidth or 100) end)
BarWidthSlider:HookScript("OnValueChanged", function(self)
		DBM.Options.HealthFrameWidth = self:GetValue()
		DBM.BossHealth:UpdateSettings()
end)

local resetbutton = hpArea:CreateButton(L.Reset, 120, 16)
resetbutton:SetPoint('BOTTOMRIGHT', hpArea.frame, "BOTTOMRIGHT", -5, 5)
resetbutton:SetNormalFontObject(GameFontNormalSmall);
resetbutton:SetHighlightFontObject(GameFontNormalSmall);
resetbutton:SetScript("OnClick", function()
		DBM.Options.HPFramePoint = DBM.DefaultOptions.HPFramePoint
		DBM.Options.HPFrameX = DBM.DefaultOptions.HPFrameX
		DBM.Options.HPFrameY = DBM.DefaultOptions.HPFrameY
		DBM.Options.HealthFrameGrowUp = DBM.DefaultOptions.HealthFrameGrowUp
		DBM.Options.HealthFrameWidth = DBM.DefaultOptions.HealthFrameWidth
		DBM.BossHealth:UpdateSettings()
end)

local function createDummyFunc(i) return function() return i end end
local showbutton = hpArea:CreateButton(L.HP_ShowDemo, 120, 16)
showbutton:SetPoint('BOTTOM', resetbutton, "TOP", 0, 5)
showbutton:SetNormalFontObject(GameFontNormalSmall);
showbutton:SetHighlightFontObject(GameFontNormalSmall);
showbutton:SetScript("OnClick", function()
		DBM.BossHealth:Show("Health Frame")
		DBM.BossHealth:AddBoss(createDummyFunc(25), "TestBoss 1")
		DBM.BossHealth:AddBoss(createDummyFunc(50), "TestBoss 2")
		DBM.BossHealth:AddBoss(createDummyFunc(75), "TestBoss 3")
		DBM.BossHealth:AddBoss(createDummyFunc(100), "TestBoss 4")
end)
