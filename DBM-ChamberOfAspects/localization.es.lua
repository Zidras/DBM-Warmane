if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

---------------------------
-- El Sagrario Obsidiana --
---------------------------
-------------
-- Shadron --
-------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Shadron"
})

--------------
-- Tenebron --
--------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Tenebron"
})

--------------
-- Vesperon --
--------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Vesperon"
})

----------------
-- Sartharion --
----------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Sartharion"
})

L:SetWarningLocalization({
	WarningTenebron			= "Tenebron se aproxima",
	WarningShadron			= "Shadron se aproxima",
	WarningVesperon			= "Vesperon se aproxima",
	WarningFireWall			= "¡Muro de Fuego!",
	WarningVesperonPortal	= "¡Portal de Vesperon!",
	WarningTenebronPortal	= "¡Portal de Tenebron!",
	WarningShadronPortal	= "¡Portal de Shadron!"
})

L:SetTimerLocalization({
	TimerTenebron	= "Tenebron llega",
	TimerShadron	= "Shadron llega",
	TimerVesperon	= "Vesperon llega"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall		= "Reproducir sonido para \"Muro de Fuego\"",
	AnnounceFails			= "Anunciar jugadores que reciban daño de &spell:57491 y $spell:57579 en el chat de banda (requiere líder o ayudante)",
	TimerTenebron			= "Mostrar temporizador para la llegada de Tenebron",
	TimerShadron			= "Mostrar temporizador para la llegada de Shadron",
	TimerVesperon			= "Mostrar temporizador para la llegada de Vesperon",
	WarningFireWall			= "Mostrar aviso especial para $spell:57491",
	WarningTenebron			= "Anunciar cuando Tenebron se aproxime",
	WarningShadron			= "Anunciar cuando Shadron se aproxime",
	WarningVesperon			= "Anunciar cuando Vesperon se aproxime",
	WarningTenebronPortal	= "Mostrar aviso especial cuando aparezca el portal de Tenebron",
	WarningShadronPortal	= "Mostrar aviso especial cuando aparezca el portal de Shadron",
	WarningVesperonPortal	= "Mostrar aviso especial cuando aparezca el portal de Vesperon"
})

L:SetMiscLocalization({
	Wall			= "¡La lava se arremolina alrededor de %s!",
	Portal			= "%s comienza a abrir un Portal Crepuscular",
	NameTenebron	= "Tenebron",
	NameShadron		= "Shadron",
	NameVesperon	= "Vesperon",
	FireWallOn		= "Tsunami de llamas: %s",
	VoidZoneOn		= "Fisura de las Sombras: %s",
	VoidZones		= "Fallos en Fisura de las Sombras (en este intento): %s",
	FireWalls		= "Fallos en Tsunami de llamas (en este intento): %s"
})

----------------------
-- El Sagrario Rubí --
----------------------
-----------------------------
-- Baltharus el Batallante --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "Baltharus el Batallante"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Separación en breve"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Mostrar aviso previo para la separación de banda",
	RangeFrame			= "Mostrar marco de distancia (12 yardas)"
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Saviana Furia Ardiente"
})

L:SetOptionLocalization({
	RangeFrame				= "Mostrar marco de distancia (10 yardas)"
})

------------------------
-- General Zarithrian --
------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "General Zarithrian"
})

L:SetWarningLocalization({
	WarnAdds	= "Ónices clamallamas",
	warnCleaveArmor	= "%s en >%s< (%s)"		-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds	= "Siguientes Ónices clamallamas",
	AddsArrive	= "Adds llegan en"
})

L:SetOptionLocalization({
	WarnAdds		= "Anunciar cuando aparezcan Ónices clamallamas",
	TimerAdds		= "Mostrar temporizador para los siguientes Ónices clamallamas",
	CancelBuff		= "Eliminar $spell:10278 y $spell:642 si se usa para eliminar $spell:74367",
	AddsArrive		= "Mostrar temporizador para a llegada de adds", --Needs Translating
})

L:SetMiscLocalization({
	SummonMinions	= "¡Reducidlos a cenizas, esbirros!"
})

------------
-- Halion --
------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Halion el Destructor Crepuscular"
})

L:SetWarningLocalization({
	TwilightCutterCast	= "Lanzando Corte Crepuscular en 5 s"
})

L:SetOptionLocalization({
	TwilightCutterCast		= "Mostrar aviso cuando se esté lanzando $spell:74769",
	AnnounceAlternatePhase	= "Mostrar avisos y temporizadores que no pertenezcan a tu fase actual",
	SetIconOnConsumption	= "Poner iconos en los objetivos de $spell:74562 y $spell:74792"--So we can use single functions for both versions of spell.
})

L:SetMiscLocalization({
	Halion					= "Halion",
	MeteorCast				= "¡Los cielos arden!",
	Phase2					= "En el reino del crepúsculo solo encontraréis sufrimiento. ¡Entrad si os atrevéis!",
	Phase3					= "¡Yo soy la luz y la oscuridad! ¡Temed, mortales, la llegada de Alamuerte!",
	twilightcutter			= "¡Temed la sombra!", -- ¡Las esferas que orbitan emiten energía oscura!", -- Can't use this since on Warmane it triggers twice, 5s prior and on cutter.
	Kill					= "Disfrutad la victoria, mortales, porque será la última. ¡Este mundo arderá cuando vuelva el maestro!"
})
