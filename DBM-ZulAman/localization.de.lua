if GetLocale() ~= "deDE" then return end
local L

---------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk")

L:SetGeneralLocalization{
	name = "Nalorakk"
}

L:SetWarningLocalization{
	WarnBear		= "Bärform",
	WarnBearSoon	= "Bärform in 5 Sek",
	WarnNormal		= "Normale Form",
	WarnNormalSoon	= "Normale Form in 5 Sek"
}

L:SetTimerLocalization{
	TimerBear		= "Bär",
	TimerNormal		= "Normale Form"
}

L:SetOptionLocalization{
	WarnBear		= "Show warning for Bear form",--Translate
	WarnBearSoon	= "Show pre-warning for Bear form",--Translate
	WarnNormal		= "Show warning for Normal form",--Translate
	WarnNormalSoon	= "Show pre-warning for Normal form",--Translate
	TimerBear		= "Show timer for Bear form",--Translate
	TimerNormal		= "Show timer for Normal form"--Translate
}

L:SetMiscLocalization{
	YellBear 	= "Ihr provoziert die Bestie, jetzt werdet Ihr sie kennenlernen!",
	YellNormal	= "Macht Platz für Nalorakk!"
}

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon")

L:SetGeneralLocalization{
	name = "Akil'zon"
}

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai")

L:SetGeneralLocalization{
	name = "Jan'alai"
}

L:SetMiscLocalization{
	YellBomb	= "Jetzt sollt Ihr brennen!",
	YellAdds	= "Wo is' meine Brut? Was ist mit den Eiern?"
}

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi")

L:SetGeneralLocalization{
	name = "Halazzi"
}

L:SetWarningLocalization{
	WarnSpirit	= "Geist spawned",
	WarnNormal	= "Geist despawned"
}

L:SetOptionLocalization{
	WarnSpirit	= "Show warning for Spirit phase",--Translate
	WarnNormal	= "Show warning for Normal phase"--Translate
}

L:SetMiscLocalization{
	YellSpirit	= "Ich kämpfe mit wildem Geist...",
	YellNormal	= "Geist, zurück zu mir!"
}

--------------------------
--  Hex Lord Malacrass --
--------------------------
L = DBM:GetModLocalization("Malacrass")

L:SetGeneralLocalization{
	name = "Hexlord Malacrass"
}

L:SetMiscLocalization{
	YellPull	= "Der Schatten wird Euch verschlingen..."
}

--------------
--  Zul'jin --
--------------
L = DBM:GetModLocalization("ZulJin")

L:SetGeneralLocalization{
	name = "Zul'jin"
}

L:SetMiscLocalization{
	YellPhase2	= "Sagt 'Hallo' zu Bruder Bär...",
	YellPhase3	= "Niemand versteckt sich vor dem Adler!",
	YellPhase4	= "Lernt meine Brüder kennen: Reißzahn und Klaue!",
	YellPhase5	= "Was starrt Ihr in die Luft? Der Drachenfalke steht schon vor Euch!"
}
