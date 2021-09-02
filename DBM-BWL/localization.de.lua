if GetLocale() ~= "deDE" then return end
local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "Razorgore der Ungezähmte"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "Adds erscheinen"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "Zeige Zeit bis die ersten Adds erscheinen"
}
L:SetMiscLocalization{
	Phase2Emote	= "flieht während die kontrollierenden Kräfte der Kugel schwinden.",
	YellEgg1 = "Ihr werdet dafür bezahlen, dass Ihr mich zu soetwas gezwungen habt!",
	YellEgg2 = "Narren! Diese Eier sind weit wertvoller als Ihr glaubt!",
	YellEgg3 = "Nein - nicht noch einer! Für diese Gräueltat werdet Ihr mit Euren Köpfen bezahlen!",
	YellPull 	= "Eindringlinge sind in die Brutstätte vorgestoßen! Schlagt Alarm! Beschützt die Eier um jeden Preis!"
}
-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name				= "Vaelastrasz der Verdorbene"
}

L:SetMiscLocalization{
	Event				= "Zu spät, Freunde! Nefarius üble Macht wirkt bereits... Ich habe mich nicht... nicht mehr unter Kontrolle.."
}
-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name	= "Brutwächter Dreschbringer"
}

L:SetMiscLocalization{
	Pull	= "Eures Gleichen sollte nicht hier sein! Ich werde Euch vernichten!"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "Feuerschwinge"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "Schattenschwinge"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "Flammenmaul"
}

-----------------------
--  Vulnerabilities  --
-----------------------
-- Chromaggus, Death Talon Overseer and Death Talon Wyrmguard
L = DBM:GetModLocalization("TalonGuards")

L:SetGeneralLocalization{
	name = "Todeskrallenwache"
}
L:SetWarningLocalization{
	WarnVulnerable = "%sverwundbarkeit"
}
L:SetOptionLocalization{
	WarnVulnerable = "Zeige Warnung für Zauberverwundbarkeit"
}
L:SetMiscLocalization{
	Fire = "Feuer",
	Nature = "Natur",
	Frost = "Frost",
	Shadow = "Schatten",
	Arcane = "Arkan",
	Holy = "Heilig"
}
------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "Chromaggus"
}
L:SetWarningLocalization{
	WarnBreath = "%s",
	WarnVulnerable = "%sverwundbarkeit"
}
L:SetTimerLocalization{
	TimerBreathCD = "Abklingzeit der %s",
	TimerBreath = "%s Zauber",
	TimerVulnCD = "Abklingzeit der Verwundbarkeit"
}
L:SetOptionLocalization{
	WarnBreath = "Zeige Warnung, wenn Chromaggus einen seiner Atem wirkt",
	WarnVulnerable = "Zeige Warnung für Zauberverwundbarkeit",
	TimerBreathCD = "Abklingzeit des Atem anzeigen",
	TimerBreath = "Zeige Atem Zauber",
	TimerVulnCD = "Zeige Abklingzeit der Verwundbarkeit"
}
L:SetMiscLocalization{
	Breath1 = "Erster Atem",
	Breath2 = "Zweiter Atem",
	VulnEmote = "%s weicht zurück, als die Haut schimmert.",
	Vuln = "Verwundbarkeit",
	Fire = "Feuer",
	Nature = "Natur",
	Frost = "Frost",
	Shadow = "Schatten",
	Arcane = "Arkan",
	Holy = "Heilig"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization{
	name = "Nefarian"
}
L:SetWarningLocalization{
	WarnAddsLeft = "%d ausstehende Tötungen",
	WarnClassCall = "%s Ruf",
	specwarnClassCall = "Klassenruf auf Dir!"
}
L:SetTimerLocalization{
	TimerClassCall = "%s Ruf endet"
}
L:SetOptionLocalization{
	TimerClassCall = "Dauer der Klassenrufe anzeigen",
	WarnAddsLeft = "Kündige verbleibend Tötungen an bis 2 Phase ausgelöst ist.",
	WarnClassCall = "Verkünde Klassenrufe",
	specwarnClassCall = "Zeige besondere Warnung wenn Du von einem Klassenruf betroffen bist"
}
L:SetMiscLocalization{
	YellP1		= "Lasst die Spiele beginnen!",
	YellP2		= "Sehr gut, meine Diener. Der Mut der Sterblichen scheint zu schwinden! Nun lasst uns sehen, wie sie sich gegen den wahren Herrscher des Blackrock behaupten werden!",
	YellP3		= "Unmöglich! Erhebt euch meine Diener! Kämpft erneut für Euren Meister!",
	YellShaman	= "Schamane, zeigt mir was eure Totems können!",
	YellPaladin	= "Paladine... ich habe gehört, dass Ihr viele Leben habt. Zeigt es mir.",
	YellDruid	= "Druiden und ihre lächerliche Gestaltwandlung. Zeigt mal was Ihr könnt!",
	YellPriest	= "Priester! Wenn Ihr weiterhin so heilt, können wir es auch gerne etwas interessanter gestalten!",
	YellWarrior	= "Krieger, Ich bin mir sicher, dass ihr kräftiger als das zuschlagen könnt!",
	YellRogue	= "Schurken? Kommt aus den Schatten und zeigt Euch!",
	YellWarlock	= "Hexenmeister, Ihr solltet nicht mit Magie spielen, die Ihr nicht versteht. Seht Ihr was ich meine?",
	YellHunter	= "Jäger und ihre lästigen Knallbüchsen!",
	YellMage	= "Auch Magier? Ihr solltet vorsichtiger sein, wenn Ihr mit Magie spielt...",
	YellDK		= "Todesritter... kommt hierher!",
	YellMonk	= "Mönche, macht Euch dieses Herumrollen denn nicht schwindlig?"--needs to be verified (wowhead-captured translation)
}
