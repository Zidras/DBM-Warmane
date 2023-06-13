if GetLocale() ~= "deDE" then return end
local L

------------------------
--  Rage Winterchill  --
------------------------
L = DBM:GetModLocalization("Rage")

L:SetGeneralLocalization({
	name = "Furor Winterfrost"
})

-----------------
--  Anetheron  --
-----------------
L = DBM:GetModLocalization("Anetheron")

L:SetGeneralLocalization({
	name = "Anetheron"
})

----------------
--  Kazrogal  --
----------------
L = DBM:GetModLocalization("Kazrogal")

L:SetGeneralLocalization({
	name = "Kaz'rogal"
})

---------------
--  Azgalor  --
---------------
L = DBM:GetModLocalization("Azgalor")

L:SetGeneralLocalization({
	name = "Azgalor"
})

------------------
--  Archimonde  --
------------------
L = DBM:GetModLocalization("Archimonde")

L:SetGeneralLocalization({
	name = "Archimonde"
})

----------------
-- WaveTimers --
----------------
L = DBM:GetModLocalization("HyjalWaveTimers")

L:SetGeneralLocalization({
	name		= "Wellen (HdZ 3)"
})

L:SetWarningLocalization({
	WarnWave	= "%s",
})

L:SetTimerLocalization({
	TimerWave	= "Nächste Welle"
})

L:SetOptionLocalization({
	WarnWave		= "Warne, wenn eine neue Welle kommt",
	DetailedWave	= "Detaillierte Warnung, wenn eine neue Welle kommt (welche Mobs)",
	TimerWave		= "Zeige Zeit bis nächste Welle"
})

L:SetMiscLocalization({
	HyjalZoneName	= "Hyjalgipfel",
	Thrall			= "Thrall",
	Jaina			= "Lady Jaina Prachtmeer",
	GeneralBoss		= "Boss kommt",
	RageWinterchill	= "Furor Winterfrost kommt",
	Anetheron		= "Anetheron kommt",
	Kazrogal		= "Kaz'rogal kommt",
	Azgalor			= "Azgalor kommt",
	WaveCheck		= "Derzeitige Welle = (%d+) von 8",
	WarnWave_0		= "Welle %s/8",
	WarnWave_1		= "Welle %s/8 - %s %s",
	WarnWave_2		= "Welle %s/8 - %s %s und %s %s",
	WarnWave_3		= "Welle %s/8 - %s %s, %s %s und %s %s",
	WarnWave_4		= "Welle %s/8 - %s %s, %s %s, %s %s und %s %s",
	WarnWave_5		= "Welle %s/8 - %s %s, %s %s, %s %s, %s %s und %s %s",
	RageGossip		= "Meine Gefährten und ich werden Euch zur Seite stehen, Lady Prachtmeer.",
	AnetheronGossip	= "Was auch immer Archimonde gegen uns ins Feld schicken mag, wir sind bereit, Lady Prachtmeer.",
	KazrogalGossip	= "Ich werde Euch zur Seite stehen, Thrall!",
	AzgalorGossip	= "Wir haben nichts zu befürchten.",
	Ghoul			= "Ghule",
	Abomination		= "Monstrositäten",
	Necromancer		= "Nekromanten",
	Banshee			= "Banshees",
	Fiend			= "Gruftbestien",
	Gargoyle		= "Gargoyles",
	Wyrm			= "Frostwyrm",
	Stalker			= "Teufelspirscher",
	Infernal		= "Höllenbestien"
})
