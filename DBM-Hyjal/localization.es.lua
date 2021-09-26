if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------------------
--  Rage Winterchill  --
------------------------
L = DBM:GetModLocalization("Rage")

L:SetGeneralLocalization{
	name = "Ira Fríoinvierno"
}

-----------------
--  Anetheron  --
-----------------
L = DBM:GetModLocalization("Anetheron")

L:SetGeneralLocalization{
	name = "Anetheron"
}

----------------
--  Kazrogal  --
----------------
L = DBM:GetModLocalization("Kazrogal")

L:SetGeneralLocalization{
	name = "Kaz'rogal"
}

---------------
--  Azgalor  --
---------------
L = DBM:GetModLocalization("Azgalor")

L:SetGeneralLocalization{
	name = "Azgalor"
}

------------------
--  Archimonde  --
------------------
L = DBM:GetModLocalization("Archimonde")

L:SetGeneralLocalization{
	name = "Archimonde"
}

----------------
-- WaveTimers --
----------------
L = DBM:GetModLocalization("HyjalWaveTimers")

L:SetGeneralLocalization{
	name 		= "Oleadas"
}
L:SetWarningLocalization{
	WarnWave	= "%s",
}
L:SetTimerLocalization{
	TimerWave	= "Siguiente oleada"
}
L:SetOptionLocalization{
	WarnWave		= "Mostrar aviso cuando se aproxime una oleada",
	DetailedWave	= "Mostrar aviso detallado con los tipos y número de enemigos cuando se aproxime una oleada",
	TimerWave		= "Mostrar temporizador para la siguiente oleada"
}
L:SetMiscLocalization{
	HyjalZoneName	= "La Cima Hyjal",
	Thrall			= "Thrall",
	Jaina			= "Lady Jaina Valiente",
	GeneralBoss		= "Se aproxima un jefe",
	RageWinterchill	= "Se aproxima Ira Fríoinvierno",
	Anetheron		= "Se aproxima Anetheron",
	Kazrogal		= "Se aproxima Kazrogal",
	Azgalor			= "Se aproxima Azgalor",
	WarnWave_0		= "Oleada %s/8",
	WarnWave_1		= "Oleada %s/8 - %s %s",
	WarnWave_2		= "Oleada %s/8 - %s %s y %s %s",
	WarnWave_3		= "Oleada %s/8 - %s %s, %s %s y %s %s",
	WarnWave_4		= "Oleada %s/8 - %s %s, %s %s, %s %s y %s %s",
	WarnWave_5		= "Oleada %s/8 - %s %s, %s %s, %s %s, %s %s y %s %s",
	RageGossip		= "Mis compañeros y yo estamos contigo, Lady Valiente.",
	AnetheronGossip	= "Estamos listos para cualquier cosa que Archimonde nos mande, Lady Valiente.",
	KazrogalGossip	= "Estoy contigo, Thrall.",
	AzgalorGossip	= "No tenemos nada que temer.",
	Ghoul			= "Necrófagos",
	Abomination		= "Abominaciones",
	Necromancer		= "Nigromantes",
	Banshee			= "Almas en pena",
	Fiend			= "Malignos de cripta",
	Gargoyle		= "Gárgolas",
	Wyrm			= "Vermis de escarcha",
	Stalker			= "Acechadores viles",
	Infernal		= "Infernales"
}
