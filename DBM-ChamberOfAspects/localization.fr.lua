if GetLocale() ~= "frFR" then return end

local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Obscuron"
})

----------------
--  Tenebron  --
----------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Ténébron"
})

----------------
--  Vesperon  --
----------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vespéron"
})

------------------
--  Sartharion  --
------------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningTenebron			= "Ténébron Arrive",
	WarningShadron			= "Obscuron Arrive",
	WarningVesperon			= "Vespéron Arrive",
	WarningFireWall			= "Tsunami de flammes !",
	WarningVesperonPortal	= "Portail de Vespéron",
	WarningTenebronPortal	= "Portail de Ténébron",
	WarningShadronPortal	= "Portail d'Obscuron"
})

L:SetTimerLocalization({
	TimerTenebron	= "Ténébron Arrive",
	TimerShadron	= "Obscuron Arrive",
	TimerVesperon	= "Vespéron Arrive"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall		= "Joue un son pour les Tsunamis de flammes",
	AnnounceFails			= "Affiche les joueurs qui n'ont pas évité les zones de vide / Tsunamis de flammes (Nécessite l'activation des annonces et être promu ou leader)",
	TimerTenebron			= "Montre le timer pour Ténébron",
	TimerShadron			= "Montre le timer pour Obscuron",
	TimerVesperon			= "Montre le timer pour Vespéron",
	WarningFireWall			= "Montre une alerte spéciale pour les Tsunamis de flammes",
	WarningTenebron			= "Montre le timer avant que Ténébron arrive",
	WarningShadron			= "Montre le timer avant qu'Obscuron arrive",
	WarningVesperon			= "Montre le timer avant que Vespéron arrive",
	WarningTenebronPortal	= "Montre une alerte spéciale pour les portails de Ténébron",
	WarningShadronPortal	= "Montre une alerte spéciale pour les portails d'Obscuron",
	WarningVesperonPortal	= "Montre une alerte spéciale pour les portails de Vespéron"
})

L:SetMiscLocalization({
	Wall			= "lave qui entoure",
	Portal			= "commence à incanter un portail",
	NameTenebron	= "Ténébron",
	NameShadron		= "Obscuron",
	NameVesperon	= "Vespéron",
	FireWallOn		= "Tsunamis de flammes: %s",
	VoidZoneOn		= "Zone de vide : %s",
	VoidZones		= "Zones de vide ratées (cet essai): %s",
	FireWalls		= "Tsunamis de flammes ratés (cet essai): %s"
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "Baltharus l'Enfant de la guerre"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Split soon"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Show pre-warning for Split",
	RangeFrame			= "Show range frame (12 yards)"
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Saviana Ragefeu"
})

L:SetOptionLocalization({
	RangeFrame				= "Show range frame (10 yards)"
})

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "Général Zarithrian"
})

L:SetWarningLocalization({
	WarnAdds	= "New adds",
	warnCleaveArmor	= "%s on >%s< (%s)"		-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds	= "New adds",
	AddsArrive	= "Adds arrivent dans"
})

L:SetOptionLocalization({
	WarnAdds		= "Announce new adds",
	TimerAdds		= "Show timer for new adds",
	CancelBuff		= "Supprimer $spell:10278 et $spell:642 s'il est utilisé pour supprimer $spell:74367",
	AddsArrive		= "Show timer for adds arrival", --Needs Translating
	warnCleaveArmor	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(74367, GetSpellInfo(74367) or "unknown")
})

L:SetMiscLocalization({
	SummonMinions	= "Serviteurs, réduisez-les en cendres !"
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Halion le destructeur du Crépuscule"
})

L:SetWarningLocalization({
	TwilightCutterCast	= "Casting Twilight Cutter: 5 sec"
})

L:SetOptionLocalization({
	TwilightCutterCast		= "Show warning when $spell:77844 is being cast",
	AnnounceAlternatePhase	= "Show warnings/timers for phase you aren't in as well",
	SetIconOnConsumption	= "Set icons on $spell:74562 or $spell:74792 targets"--So we can use single functions for both versions of spell.
})

L:SetMiscLocalization({
	Halion					= "Halion",
	MeteorCast				= "Les cieux s'embrasent !",
	Phase2					= "Vous ne trouverez que souffrance au royaume du crépuscule ! Entrez si vous l'osez !",
	Phase3					= "Je suis la lumière et l'ombre ! Tremblez, mortels, devant le héraut d'Aile-de-mort !",
	twilightcutter			= "Méfiez-vous de l'ombre !", --"Les sphères volantes rayonnent d'énergie noire !", -- Can't use this since on Warmane it triggers twice, 5s prior and on cutter.
	Kill					= "Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"--needs translation
})