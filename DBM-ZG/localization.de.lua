if GetLocale() ~= "deDE" then return end
local L

-------------------
--  Venoxis  --
-------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization{
	name = "Hohepriester Venoxis"
}

-------------------
--  Jeklik  --
-------------------
L = DBM:GetModLocalization("Jeklik")

L:SetGeneralLocalization{
	name = "Hohepriesterin Jeklik"
}

-------------------
--  Marli  --
-------------------
L = DBM:GetModLocalization("Marli")

L:SetGeneralLocalization{
	name = "Hohepriesterin Mar'li"
}

-------------------
--  Thekal  --
-------------------
L = DBM:GetModLocalization("Thekal")

L:SetGeneralLocalization{
	name = "Hohepriester Thekal"
}

L:SetWarningLocalization({
	WarnSimulKill	= "Erster Diener tot: Auferstehung in ~ 15 Sekunden"
})

L:SetTimerLocalization({
	TimerSimulKill	= "Auferstehung"
})

L:SetOptionLocalization({
	WarnSimulKill	= "Kündigen Sie den ersten Mob an, bald die Auferstehung",
	TimerSimulKill	= "Zeige Timer für die Priesterauferstehung"
})

L:SetMiscLocalization({
	PriestDied	= "%s stirbt.",
	YellPhase2	= "Shirvallah, erfülle mich mit deinem Zorn!",
	YellKill	= "Hakkar kontrolliert mich nicht länger! Endlich Frieden!",
	Thekal		= "Hohepriester Thekal",
	Zath		= "Zelot Zath",
	LorKhan		= "Zelot Lor'Khan"
})

-------------------
--  Arlokk  --
-------------------
L = DBM:GetModLocalization("Arlokk")

L:SetGeneralLocalization{
	name = "Hohepriesterin Arlokk"
}

-------------------
--  Hakkar  --
-------------------
L = DBM:GetModLocalization("Hakkar")

L:SetGeneralLocalization{
	name = "Hakkar"
}

-------------------
--  Bloodlord  --
-------------------
L = DBM:GetModLocalization("Bloodlord")

L:SetGeneralLocalization{
	name = "Blutfürst Mandokir"
}
L:SetMiscLocalization{
	Bloodlord 	= "Blutfürst Mandokir",
	Ohgan		= "Ohgan",
	GazeYell	= "Ich behalte Euch im Auge"
}

-------------------
--  Edge of Madness  --
-------------------
L = DBM:GetModLocalization("EdgeOfMadness")

L:SetGeneralLocalization{
	name = "Rand des Wahnsinns"
}
L:SetMiscLocalization{
	Hazzarah = "Hazza'rah",
	Renataki = "Renataki",
	Wushoolay = "Wushoolay",
	Grilek = "Gri'lek"
}

-------------------
--  Gahz'ranka  --
-------------------
L = DBM:GetModLocalization("Gahzranka")

L:SetGeneralLocalization{
	name = "Gahz'ranka"
}

-------------------
--  Jindo  --
-------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization{
	name = "Jin'do der Verhexer"
}
