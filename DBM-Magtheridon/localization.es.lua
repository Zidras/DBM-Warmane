if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization{
	name = "Magtheridon"
}

L:SetTimerLocalization{
	timerP2	= "Fase 2"
}

L:SetOptionLocalization{
	timerP2	= "Mostrar temporizador para el cambio a Fase 2"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "¡Las cuerdas de %s empiezan a aflojarse!",
	DBM_MAG_YELL_PHASE2		= "¡He... sido... liberado!",
	DBM_MAG_YELL_PHASE3		= "¡No me dejaré encerrar tan fácilmente! ¡Que tiemblen las paredes de esta prisión... y se derrumben!"
}