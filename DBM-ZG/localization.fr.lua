if GetLocale() ~= "frFR" then return end
local L

-------------------
--  Venoxis  --
-------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization({
	name = "Grand prêtre Venoxis"
})

-------------------
--  Jeklik  --
-------------------
L = DBM:GetModLocalization("Jeklik")

L:SetGeneralLocalization({
	name = "Grande prêtresse Jeklik"
})

-------------------
--  Marli  --
-------------------
L = DBM:GetModLocalization("Marli")

L:SetGeneralLocalization({
	name = "Grande prêtresse Mar'li"
})

-------------------
--  Thekal  --
-------------------
L = DBM:GetModLocalization("Thekal")

L:SetGeneralLocalization({
	name = "Grand prêtre Thekal"
})

L:SetWarningLocalization({
	WarnSimulKill	= "Premier serviteur mort - Résurrection en ~15 secondes"
})

L:SetTimerLocalization({
	TimerSimulKill	= "Résurrection"
})

L:SetOptionLocalization({
	WarnSimulKill	= "Annoncez le premier serviteur mort",
	TimerSimulKill	= "Montre le timer pour la résurrection des prêtres"
})

L:SetMiscLocalization({
	PriestDied	= "%s meurt.",
	YellPhase2	= "Shirvallah, que ta RAGE m’envahisse !",
	YellKill	= "Hakkar ne me domine plus ! Je connais enfin la paix !",
	Thekal		= "Grand prêtre Thekal",
	Zath		= "Zélote Zath",
	LorKhan		= "Zélote Lor'Khan"
})

-------------------
--  Arlokk  --
-------------------
L = DBM:GetModLocalization("Arlokk")

L:SetGeneralLocalization({
	name = "Grande prêtresse Arlokk"
})

-------------------
--  Hakkar  --
-------------------
L = DBM:GetModLocalization("Hakkar")

L:SetGeneralLocalization({
	name = "Hakkar"
})

-------------------
--  Bloodlord  --
-------------------
L = DBM:GetModLocalization("Bloodlord")

L:SetGeneralLocalization({
	name = "Seigneur sanglant Mandokir"
})

L:SetMiscLocalization({
	Bloodlord	= "Seigneur sanglant Mandokir",
	Ohgan		= "Ohgan",
	GazeYell	= "je vous ai à l'œil"
})

-------------------
--  Edge of Madness  --
-------------------
L = DBM:GetModLocalization("EdgeOfMadness")

L:SetGeneralLocalization({
	name = "Frontière de la folie"
})

L:SetMiscLocalization({
	Hazzarah = "Hazza'rah",
	Renataki = "Renataki",
	Wushoolay = "Wushoolay",
	Grilek = "Gri'lek"
})

-------------------
--  Gahz'ranka  --
-------------------
L = DBM:GetModLocalization("Gahzranka")

L:SetGeneralLocalization({
	name = "Gahz'ranka"
})

-------------------
--  Jindo  --
-------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization({
	name = "Jin'do le Maléficieur"
})
