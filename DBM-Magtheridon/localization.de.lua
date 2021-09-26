if GetLocale() ~= "deDE" then return end
local L

-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization{
	name = "Magtheridon"
}

L:SetTimerLocalization{
	timerP2	= "Phase 2"
}

L:SetOptionLocalization{
	timerP2	= "Zeige Zeit bis Phase 2 beginnt"
}

L:SetMiscLocalization{
	DBM_MAG_EMOTE_PULL		= "Die Fesseln von %s werden schwächer!",
	DBM_MAG_YELL_PHASE2		= "Ich... bin... frei!",
	DBM_MAG_YELL_PHASE3		= "Ich lasse mich nicht so leicht bezwingen! Lasst die Mauern dieses Kerkers erzittern... und einstürzen!"
}