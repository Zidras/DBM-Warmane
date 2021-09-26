if GetLocale() ~= "zhTW" then return end

local L

-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization{
	name = "瑪瑟里頓"
}

L:SetTimerLocalization{
	timerP2	= "第2階段"
}

L:SetOptionLocalization{
	timerP2	= "為第2階段開始顯示計時器"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "%s的束縛開始變弱!",
	DBM_MAG_YELL_PHASE2		= "我...被...釋放了!",
	DBM_MAG_YELL_PHASE3		= "我不會這麼輕易就被擊敗!讓這座監獄的牆壁震顫...然後崩塌!"
}