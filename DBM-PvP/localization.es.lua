if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "Opciones generales"
})

L:SetTimerLocalization({
	TimerFlag		= "Bandera Restablecida",
	TimerShadow		= "Visión de las Sombras",
	TimerStart		= "La batalla comezara en",
	TimerWin		= "Victoria en"
})

L:SetOptionLocalization({
	AutoSpirit			= "Liberar espíritu automáticamente",
	ColorByClass		= "Mostrar nombres con el color de su clase en la tabla de estadísticas",
	HideBossEmoteFrame	= "Ocultar marco de jefe de banda y botón de ciudadela en campos de batalla",
	ShowBasesToWin		= "Mostrar bases para ganar",
	ShowEstimatedPoints	= "Mostrar recursos estimados a ganar",
	ShowFlagCarrier		= "Mostrar por donde va la bandera",
	ShowRelativeGameTime= "Llene el temporizador de victorias en relación con la hora de inicio del campo de batalla (si está deshabilitado, la barra siempre se ve llena)",
	TimerCap			= "Mostrar tiempo que tarda en conquistar",
	TimerFlag			= "Mostrar tiempo que tarda en restablecer la Bandera",
	TimerShadow			= "Mostrar tiempo para que salga Visión de las Sombras.",
	TimerStart			= "Mostrar tiempo para que comienze la Batalla",
	TimerWin			= "Mostrar tiempo para que una faccion gane la Batalla"
})

L:SetMiscLocalization({
--	BgStart60			= "La batalla comienza en 1 minuto.",
--	BgStart30			= "La batalla comienza en 30 segundos. ¡Preparaos!",
	ArenaInvite			= "Invitación a la arena",
--	Start60				= "¡Un minuto hasta que comience la batalla en la arena!",
--	Start30				= "¡Treinta segundos hasta que comience la batalla en arena!",
--	Start15				= "¡Quince segundos hasta que comience la batalla en arena!",
	BasesToWin			= "Bases necesarias para ganar: %d",
	WinBarText			= "%s ganara en",
	Flag				= "Bandera",
--	FlagReset			= "La bandera se ha restablecido.",
--	FlagTaken			= "¡ (.+) ha tomado la bandera!",
--	FlagCaptured		= "¡La .+ ha%w+ ha capturado la bandera!",
--	FlagDropped			= "¡Ha caído la bandera!",
--	ExprFlagPickUp		= "¡(.+) ha cogido la bandera de la (%w+)!",
--	ExprFlagCaptured	= "¡(.+) ha capturado la bandera de la (%w+)!",
--	ExprFlagReturn		= "¡(.+) ha devuelto la bandera de la (%w+) a su base!",
	Vulnerable1			= "¡Los portadores de las banderas se han vuelto vulnerables a los ataques!",
	Vulnerable2			= "¡Los portadores de las banderas se han vuelto más vulnerables a los ataques!"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "Valle de Alterac"
})

L:SetOptionLocalization({
	AutoTurnIn	= "Entregar misiones automáticamente"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "Cuenca de Arathi"
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "Ojo de la Tormenta"
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "Garganta Grito de Guerra"
})

------------------------
--  Isle of Conquest  --
------------------------

L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "Isla de la Conquista"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "¡Máquina de asedio lista!",
	WarnSiegeEngineSoon	= "Máquina de asedio en ~10 s"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "Máquina de asedio lista"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "Mostrar temporizador para construcción de máquinas de asedio",
	WarnSiegeEngine		= "Mostrar aviso cuando una máquina de asedio esté lista",
	WarnSiegeEngineSoon	= "Mostrar aviso cuando una máquina de asedio esté casi lista",
	ShowGatesHealth		= "Mostrar salud de puertas dañadas (¡puede dar resultados erróneos al unirse a una batalla en curso!)"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "Puertas dañadas",
	SiegeEngine				= "Máquina de asedio",
	GoblinStartAlliance		= "¿Ves esas bombas de seforio? Úsalas en las puertas mientras reparo la máquina de asedio.",
	GoblinStartHorde		= "Trabajaré en la máquina de asedio, solo cúbreme las espaldas. ¡Usa esas bombas de seforio en las puertas si las necesitas!",
	GoblinHalfwayAlliance	= "¡Estoy a medias! Mantén a la Horda alejada de aquí. ¡En la escuela de ingeniería no enseñan a luchar!",
	GoblinHalfwayHorde		= "¡Ya casi estoy! Mantén a la Alianza alejada... ¡Luchar no entra en mi contrato!",
	GoblinFinishedAlliance	= "¡Mi mejor obra! ¡Esta máquina de asedio está lista para la acción!",
	GoblinFinishedHorde		= "¡La máquina de asedio está lista para la acción!",
	GoblinBrokenAlliance	= "¿Ya está rota? No pasa nada. No es nada que no pueda arreglar.",
	GoblinBrokenHorde		= "¿Está estropeada otra vez? La arreglaré... pero no esperes que la garantía cubra esto."
})