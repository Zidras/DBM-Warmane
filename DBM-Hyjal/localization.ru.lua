if GetLocale() ~= "ruRU" then return end

local L

------------------------
--  Rage Winterchill  --
------------------------
L = DBM:GetModLocalization("Rage")

L:SetGeneralLocalization{
	name = "Лютый Хлад"
}

-----------------
--  Anetheron  --
-----------------
L = DBM:GetModLocalization("Anetheron")

L:SetGeneralLocalization{
	name = "Анетерон"
}

----------------
--  Kazrogal  --
----------------
L = DBM:GetModLocalization("Kazrogal")

L:SetGeneralLocalization{
	name = "Каз'рогал"
}

---------------
--  Azgalor  --
---------------
L = DBM:GetModLocalization("Azgalor")

L:SetGeneralLocalization{
	name = "Азгалор"
}

------------------
--  Archimonde  --
------------------
L = DBM:GetModLocalization("Archimonde")

L:SetGeneralLocalization{
	name = "Архимонд"
}

----------------
-- WaveTimers --
----------------
L = DBM:GetModLocalization("HyjalWaveTimers")

L:SetGeneralLocalization{
	name 		= "Треш-мобы"
}
L:SetWarningLocalization{
	WarnWave	= "%s",
	WarnWaveSoon= "Скоро следующая волна"
}
L:SetTimerLocalization{
	TimerWave	= "Следующая волна"
}
L:SetOptionLocalization{
	WarnWave		= "Warn when a new wave is incoming",--Translate
	WarnWaveSoon	= "Warn when a new wave is incoming soon",--Translate
	DetailedWave	= "Detailed warning when a new wave is incoming (which mobs)",--Translate
	TimerWave		= "Show a timer for next wave"--Translate
}
L:SetMiscLocalization{
	HyjalZoneName	= "Вершина Хиджала",
	Thrall			= "Тралл",
	Jaina			= "Леди Джайна Праудмур",
	RageWinterchill	= "Лютый Хлад",
	Anetheron		= "Анетерон",
	Kazrogal		= "Каз'рогал",
	Azgalor			= "Азгалор",
	WaveCheck		= "Текущая атака: (%d+) из 8",
	WarnWave_0		= "Волна %s/8",
	WarnWave_1		= "Волна %s/8 - %s %s",
	WarnWave_2		= "Волна %s/8 - %s %s и %s %s",
	WarnWave_3		= "Волна %s/8 - %s %s, %s %s и %s %s",
	WarnWave_4		= "Волна %s/8 - %s %s, %s %s, %s %s и %s %s",
	WarnWave_5		= "Волна %s/8 - %s %s, %s %s, %s %s, %s %s и %s %s",
	RageGossip		= "Мои спутники и я – с вами, леди Праудмур.",
	AnetheronGossip	= "Мы готовы встретить любого, кого пошлет Архимонд, леди Праудмур.",
	KazrogalGossip	= "Я с тобой, Тралл.",
	AzgalorGossip	= "Нам нечего бояться.",
	Ghoul			= "Вурдалака",
	Abomination		= "Поганища",
	Necromancer		= "Некроманта",
	Banshee			= "Банши",
	Fiend			= "Некрорахнида",
	Gargoyle		= "Горгульи",
	Wyrm			= "Ледяной змей",
	Stalker			= "Ловчих Скверны",
	Infernal		= "Инфернала"
}
