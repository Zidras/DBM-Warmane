if GetLocale() ~= "deDE" then return end

local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Shadron"
})

----------------
--  Tenebron  --
----------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Tenebron"
})

----------------
--  Vesperon  --
----------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vesperon"
})

------------------
--  Sartharion  --
------------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningTenebron			= "Tenebron kommt",
	WarningShadron			= "Shadron kommt",
	WarningVesperon			= "Vesperon kommt",
	WarningFireWall			= "Feuerwand",
	WarningVesperonPortal	= "Vesperons Portal",
	WarningTenebronPortal	= "Tenebrons Portal",
	WarningShadronPortal	= "Shadrons Portal"
})

L:SetTimerLocalization({
	TimerTenebron	= "Tenebron kommt",
	TimerShadron	= "Shadron kommt",
	TimerVesperon	= "Vesperon kommt"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall		= "Spiele Sound bei Feuerwand",
	AnnounceFails			= "Verkünde Spieler im SZ-Chat, die bei Feuerwand und Schattenspalt scheitern (benötigt aktivierte Mitteilungen und Leiter-/Assistentenstatus)",
	TimerTenebron			= "Zeige Zeit bis Tenebron in den Kampf eingreift",
	TimerShadron			= "Zeige Zeit bis Shadron in den Kampf eingreift",
	TimerVesperon			= "Zeige Zeit bis Vesperon in den Kampf eingreift",
	WarningFireWall			= "Spezialwarnung für Feuerwand",
	WarningTenebron			= "Verkünde das Eingreifen von Tenebron in den Kampf",
	WarningShadron			= "Verkünde das Eingreifen von Shadron in den Kampf",
	WarningVesperon			= "Verkünde das Eingreifen von Vesperon in den Kampf",
	WarningTenebronPortal	= "Spezialwarnung für Tenebrons Portal",
	WarningShadronPortal	= "Spezialwarnung für Shadrons Portal",
	WarningVesperonPortal	= "Spezialwarnung für Vesperons Portal"
})

L:SetMiscLocalization({
	Wall			= "Die Lava um %s brodelt!",
	Portal			= "%s beginnt, ein Portal des Zwielichts zu öffnen!",
	NameTenebron	= "Tenebron",
	NameShadron		= "Shadron",
	NameVesperon	= "Vesperon",
	FireWallOn		= "Feuerwand: %s",
	VoidZoneOn		= "Schattenspalt: %s",
	VoidZones		= "Fehler bei Schattenspalt (dieser Versuch): %s",
	FireWalls		= "Fehler bei Feuerwand (dieser Versuch): %s"
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "Baltharus der Kriegsjünger"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Aufspaltung bald"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Zeige Vorwarnung für Aufspaltung",
	RangeFrame			= "Zeige Abstandsfenster (12m)"
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Saviana Flammenschlund"
})

L:SetOptionLocalization({
	RangeFrame				= "Zeige Abstandsfenster (10m)"
})

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "General Zarithrian"
})

L:SetWarningLocalization({
	WarnAdds	= "Neue Adds",
	warnCleaveArmor	= "%s auf >%s< (%s)"	-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds	= "Neue Adds",
	AddsArrive	= "Adds kommen an in"
})

L:SetOptionLocalization({
	WarnAdds		= "Verkünde neue Adds",
	TimerAdds		= "Zeige Zeit bis neue Adds erscheinen",
	CancelBuff		= "Entferne $spell:10278 und $spell:642, wenn verwendet, um $spell:74367 zu entfernen",
	AddsArrive		= "Timer für die Ankunft der Adds anzeigen"
})

L:SetMiscLocalization({
	SummonMinions	= "Äschert sie ein, Lakaien!"
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Halion der Zwielichtzerstörer"
})

L:SetWarningLocalization({
	TwilightCutterCast	= "Wirkt Zwielichtschnitter: 5 sec"
})

L:SetOptionLocalization({
	TwilightCutterCast		= "Zeige Warnung, wenn $spell:74769 gewirkt wird",
	AnnounceAlternatePhase	= "Zeige auch Warnungen/Timer für Phasen, in denen du dich nicht befindest",
	SetIconOnConsumption	= "Setze Zeichen auf Ziele von $spell:74562 und $spell:74792"
})

L:SetMiscLocalization({
	Halion					= "Halion",
	MeteorCast				= "Die Himmel brennen!",
	Phase2					= "Ihr werdet im Reich des Zwielichts nur Leid finden! Tretet ein, wenn ihr es wagt!",
	Phase3					= "Ich bin das Licht und die Dunkelheit! Zittert, Sterbliche, vor dem Herold Todesschwinges!",
	twilightcutter			= "Hütet euch vor dem Schatten!", --"Die kreisenden Sphären pulsieren vor dunkler Energie!" -- Can't use this since on Warmane it triggers twice, 5s prior and on cutter.
	Kill					= "Genießt euren Sieg, Sterbliche, denn es war euer letzter. Bei der Rückkehr des Meisters wird diese Welt brennen!"
})