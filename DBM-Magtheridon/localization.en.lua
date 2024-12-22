local L

-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization({
	name = "Magtheridon"
})

L:SetTimerLocalization({
	timerP2	= "Phase 2"
})

L:SetOptionLocalization({
	timerP2	= "Show timer for start of phase 2"
})

L:SetMiscLocalization({
	DBM_MAG_EMOTE_PULL		= "%s's bonds begin to weaken!",
	DBM_MAG_YELL_PHASE2		= "I... am... unleashed!",
	DBM_MAG_ALTERNATIVE_YELL_PHASE2 = "Thank you for releasing me. Now... die!", -- https://www.warmane.com/bugtracker/report/124104
	DBM_MAG_YELL_PHASE3		= "I will not be taken so easily! Let the walls of this prison tremble... and fall!"
})
