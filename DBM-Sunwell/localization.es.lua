if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")

L:SetGeneralLocalization({
	name = "Kalecgos"
})

L:SetWarningLocalization({
	WarnPortal			= "Portal %d: >%s< (grupo %d)",
	SpecWarnWildMagic	= "¡Magia salvaje - %s!"
})

L:SetOptionLocalization({
	WarnPortal			= "Anunciar objetivo de $spell:46021",
	SpecWarnWildMagic	= "Mostrar aviso especial para Magia salvaje",
	ShowRespawn			= "Mostrar temporizador para la reaparición de jefe tras cada derrota",
	ShowFrame			= "Mostrar marco del reino espectral" ,
	FrameClassColor		= "Usar colores de clase en el marco del reino espectral",
	FrameUpwards		= "Expandir marco del reino espectral hacia arriba",
	FrameLocked			= "Bloquear marco del reino espectral"
})

L:SetMiscLocalization({
	Demon				= "Sathrovarr el Corruptor",
	Heal				= "Sanación realizada +100%",
	Haste				= "Celeridad con hechizos +100%",
	Hit					= "Golpe -50%",
	Crit				= "Daño crítico +100%",
	Aggro				= "Generación de amenaza +100%",
	Mana				= "Costes -50%",
	FrameTitle			= "Reino espectral",
	FrameLock			= "Bloquear marco",
	FrameClassColor		= "Usar colores de clase",
	FrameOrientation	= "Expandir hacia arriba",
	FrameHide			= "Ocultar marco",
	FrameClose			= "Cerrar",
	FrameGUIMoveMe		= "Posición"
})

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization({
	name = "Brutallus"
})

L:SetOptionLocalization({
	RangeFrameActivation= "Activación del marco de rango",
	AlwaysOn			= "Al inicio del encuentro. Ignora el filtro",
	OnDebuff			= "En debuff. Aplica filtro de debuff"
})

L:SetMiscLocalization({
	Pull			= "¡Ah, más corderos al matadero!"
})

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization({
	name = "Brumavil"
})

L:SetWarningLocalization({
	WarnPhase		= "Fase %s"
})

L:SetTimerLocalization({
	TimerPhase		= "Siguiente fase %s"
})

L:SetOptionLocalization({
	WarnPhase		= "Anunciar cambios de fase",
	TimerPhase		= "Mostrar temporizador para los cambios de fase"
})

L:SetMiscLocalization({
	Air				= "aérea",
	Ground			= "en tierra",
	AirPhase		= "¡Soy más fuerte que nunca!",
	Breath			= "%s respira hondo."
})

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name = "Las gemelas eredar"
})

L:SetMiscLocalization({
	Nova			= "dirige Nova de las Sombras hacia (.+)%.",
	Conflag			= "dirige Conflagración hacia (.+)%.",
	Sacrolash		= "Lady Sacrolash",
	Alythess		= "Bruja suprema Alythess"
})

------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization({
	name = "M'uru"
})

L:SetWarningLocalization({
	WarnHuman		= "Humanoides (%d)",
	WarnVoid		= "Centinela del vacío (%d)",
	WarnFiend		= "Maligno oscuro"
})

L:SetTimerLocalization({
	TimerHuman		= "Siguientes humanoides (%s)",
	TimerVoid		= "Siguiente centinela (%s)",
	TimerPhase		= "Entropius"
})

L:SetOptionLocalization({
	WarnHuman		= "Mostrar aviso cuando aparezcan humanoides",
	WarnVoid		= "Mostrar aviso cuando aparezca un Centinela del vacío",
	WarnFiend		= "Mostrar aviso cuando aparezcan Malignos oscuros en Fase 2",
	TimerHuman		= "Mostrar temporizador para los siguientes humanoides",
	TimerVoid		= "Mostrar temporizador para el siguiente Centinela del vacío",
	TimerPhase		= "Mostrar temporizador para la transición a Fase 2"
})

L:SetMiscLocalization({
	Entropius		= "Entropius"
})

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization({
	name = "Kil'jaeden"
})

L:SetWarningLocalization({
	WarnDarkOrb		= "Orbes escudo",
	WarnBlueOrb		= "Orbe azul activado",
	SpecWarnBlueOrb	= "¡Orbe azul activado!",
	SpecWarnDarkOrb	= "¡Orbes escudo!"
})

L:SetTimerLocalization({
	TimerBlueOrb	= "Orbe azules activo"
})

L:SetOptionLocalization({
	WarnDarkOrb		= "Mostrar aviso cuando aparezcan Orbes escudo",
	WarnBlueOrb		= "Mostrar aviso cuando se active un orbe azul",
	SpecWarnDarkOrb	= "Mostrar aviso especial cuando aparezcan Orbes escudo",
	SpecWarnBlueOrb	= "Mostrar aviso especial cuando se active un orbe azul",
	TimerBlueOrb	= "Mostrar temporizador para la activación de los orbes azules"
})

L:SetMiscLocalization({
	YellPull		= "Los prescindibles han muerto. ¡Qué así sea! ¡Ahora triunfaré donde Sargeras no lo logró! ¡Desangraré este despreciable mundo y me aseguraré mi puesto como verdadero maestro de la Legión Ardiente! ¡El final ha llegado! ¡Dejad que se desvele el misterio de este mundo!",
	OrbYell1		= "¡Canalizaré mi poder en los orbes! ¡Preparaos!",
	OrbYell2		= "¡He otorgado mi poder a otro orbe! ¡Usadlo rápido!",
	OrbYell3		= "¡Otro orbe preparado! ¡Daos prisa!",
	OrbYell4		= "¡He canalizado todo lo que puedo! ¡El poder está en vuestras manos!"
})
