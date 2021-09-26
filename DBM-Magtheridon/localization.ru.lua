if GetLocale() ~= "ruRU" then return end

local L

-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization{
	name = "Магтеридон"
}

L:SetTimerLocalization{
	timerP2	= "Фаза 2"
}

L:SetOptionLocalization{
	timerP2	= "Показывать таймер начала Фазы 2"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "Сдерживающая сила %sа начинает ослабевать!",
	DBM_MAG_YELL_PHASE2		= "Я... свободен!",
	DBM_MAG_YELL_PHASE3		= "Пусть стены темницы содрогнутся... и падут!"
}