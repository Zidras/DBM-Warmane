if GetLocale() ~= "esES" then return end
local L

-------------------
--  Venoxis  --
-------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization({
	name = "Sumo Sacerdote Venoxis"
})

-------------------
--  Jeklik  --
-------------------
L = DBM:GetModLocalization("Jeklik")

L:SetGeneralLocalization({
	name = "Suma Sacerdotisa Jeklik"
})

-------------------
--  Marli  --
-------------------
L = DBM:GetModLocalization("Marli")

L:SetGeneralLocalization({
	name = "Suma Sacerdotisa Mar'li"
})

-------------------
--  Thekal  --
-------------------
L = DBM:GetModLocalization("Thekal")

L:SetGeneralLocalization({
	name = "Sumo Sacerdote Thekal"
})

L:SetWarningLocalization({
	WarnSimulKill	= "Primer esbirro muerto - Resurrección en ~15 segundos"
})

L:SetTimerLocalization({
	TimerSimulKill	= "Resurrección"
})

L:SetOptionLocalization({
	WarnSimulKill	= "Anunciar primer esbirro muerto",
	TimerSimulKill	= "Mostrar tiempo para resurrección de sacerdote"
})

L:SetMiscLocalization({
	PriestDied	= "%s muere.",
	YellPhase2	= "Shirvallah, ¡lléname de tu IRA!",
	YellKill	= "¡Estoy libre de Hakkar! ¡Por fin tengo paz!",
	Thekal		= "Sumo Sacerdote Thekal",
	Zath		= "Integrista Zath",
	LorKhan		= "Integrista Lor'Khan"
})

-------------------
--  Arlokk  --
-------------------
L = DBM:GetModLocalization("Arlokk")

L:SetGeneralLocalization({
	name = "Suma Sacerdotisa Arlokk"
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
	name = "Señor sangriento Mandokir"
})

L:SetMiscLocalization({
	Bloodlord	= "Señor sangriento Mandokir",
	Ohgan		= "Ohgan",
	GazeYell	= "Te estoy vigilando"
})

-------------------
--  Edge of Madness  --
-------------------
L = DBM:GetModLocalization("EdgeOfMadness")

L:SetGeneralLocalization({
	name = "Extremo de la Locura"
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
	name = "Jin'do el Malhechor"
})
