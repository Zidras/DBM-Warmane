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
	TimerStart		= "La batalla comienza en",
	TimerWin		= "Victoria en"
})

L:SetOptionLocalization({
	AutoSpirit			= "Liberar espíritu automáticamente",
	ColorByClass		= "Mostrar nombres con el color de su clase en la tabla de estadísticas",
	HideBossEmoteFrame	= "Ocultar marco de jefe de banda y botón de ciudadela en campos de batalla",
	ShowBasesToWin		= "Mostrar bases para ganar",
	ShowEstimatedPoints	= "Mostrar recursos estimados a ganar",
	ShowFlagCarrier		= "Mostrar el nombre del portador de la bandera",
	ShowGatesHealth		= "Mostrar salud de puertas dañadas (¡puede dar resultados erróneos al unirse a una batalla en curso!)",
	ShowRelativeGameTime= "Llene el temporizador de victorias en relación con la hora de inicio del campo de batalla (si está deshabilitado, la barra siempre se ve llena)",
	TimerCap			= "Mostrar tiempo que tarda en conquistar",
	TimerFlag			= "Mostrar tiempo que tarda en restablecer la Bandera",
	TimerShadow			= "Mostrar tiempo para que salga Visión de las Sombras.",
	TimerStart			= "Mostrar tiempo para que comienze la Batalla",
	TimerWin			= "Mostrar tiempo para que una faccion gane la Batalla"
})

L:SetMiscLocalization({
	--BG 2 minutes
	BgStart120TC		= "¡La batalla comienza en dos minutos!",
	--BG 1 minute
	BgStart60TC			= "¡La batalla comienza en un minuto!",
	BgStart60AlteracTC	= "1 minuto para que dé comienzo la batalla por el Valle de Alterac.",
	BgStart60SotA2TC	= "La ronda 2 de la batalla por la Playa de los Ancestros comenzará en 1 minuto.",
	BgStart60WarsongTC	= "La batalla por la Garganta Grito de Guerra comenzará en 1 minuto.",
	-- BG 30 seconds
	BgStart30TC			= "¡La batalla comienza en treinta segundos!",
	BgStart30AlteracTC	= "30 segundos para que dé comienzo la batalla por el Valle de Alterac.",
	BgStart30SotA2TC	= "La ronda 2 comenzará en 30 segundos. ¡Preparaos!",
	BgStart30WarsongTC	= "La batalla por la Garganta Grito de Guerra comenzará en 30 segundos. ¡Preparaos!",
	--
	ArenaInvite			= "Invitación a la arena",
	Start60TC			= "¡Un minuto hasta que dé comienzo la batalla en arena!",
	Start30TC			= "¡Treinta segundos hasta que comience la batalla de arena!",
	Start15TC			= "¡Quince segundos para que comience la batalla de arena!",
	BasesToWin			= "Bases necesarias para ganar: %d",
	WinBarText			= "%s ganará en",
	-- Flag carrying system
	Flag				= "Bandera",
	FlagResetTC			= "La bandera se ha restablecido.",
	FlagTakenTC			= "¡(.+) ha tomado la bandera!",
	FlagCapturedTC		= "¡La (%w+) ha capturado la bandera!",
	FlagDroppedTC		= "¡Ha caído la bandera!",
	--
	ExprFlagPickUpTC	= "¡(.+) ha cogido la bandera de la (%w+)!",
	ExprFlagCapturedTC	= "¡(.+) ha capturado la bandera de la (%w+)!",
	ExprFlagReturnTC	= "¡(.+) ha devuelto la bandera de la (%w+) a su base!",
	ExprFlagDroppedTC	= "¡(.+) ha dejado caer la bandera de la (%w+)!",
	Vulnerable1			= "¡Los portadores de las banderas se han vuelto vulnerables a los ataques!",
	Vulnerable2			= "¡Los portadores de las banderas se han vuelto más vulnerables a los ataques!",
	-- Gates
	GatesHealthFrame				= "Puertas dañadas",
	HordeGateFront					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t Puerta Principal",
	HordeGateFrontDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t Puerta Principal",
	HordeGateWest					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t Puerta Oeste",
	HordeGateWestDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t Puerta Oeste",
	HordeGateEast					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t Puerta Este",
	HordeGateEastDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t Puerta Este",
	AllianceGateFront				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t Puerta Principal",
	AllianceGateFrontDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t Puerta Principal",
	AllianceGateWest				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t Puerta Oeste",
	AllianceGateWestDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t Puerta Oeste",
	AllianceGateEast				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t Puerta Este",
	AllianceGateEastDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t Puerta Este",
	-- Strands of the Ancients Gates emotes
	GreenEmeraldAttacked			= "¡Están atacando la Puerta de la Esmeralda Verde!",
	GreenEmeraldDestroyed			= "¡La Puerta de la Esmeralda Verde ha sido destruida!",
	BlueSapphireAttacked			= "¡Están atacando la Puerta del Zafiro Azul!",
	BlueSapphireDestroyed			= "¡La Puerta del Zafiro Azul ha sido destruida!",
	PurpleAmethystAttacked			= "¡Están atacando la Puerta de la Amatista Púrpura!",
	PurpleAmethystDestroyed			= "¡La Puerta de la Amatista Púrpura ha sido destruida!",
	RedSunAttacked					= "¡Están atacando la Puerta del Sol Rojo!",
	RedSunDestroyed					= "¡La Puerta del Sol Rojo ha sido destruida!",
	YellowMoonAttacked				= "¡Están atacando la Puerta de la Luna Amarilla!",
	YellowMoonDestroyed				= "¡La Puerta de la Luna Amarilla ha sido destruida!",
	ChamberAncientRelicsAttacked	= "¡Están atacando la Cámara de las Reliquias!",
	ChamberAncientRelicsDestroyed	= "¡Han atravesado la fortaleza! ¡La reliquia de titán es vulnerable!",
	-- Isle of Conquest Gates CHAT_MSG_BG_SYSTEM_NEUTRAL messages
	HordeGateFrontDestroyedTC		= "La puerta principal de la fortaleza de la Horda ha sido destruida.",
	HordeGateWestDestroyedTC		= "La puerta oeste de la fortaleza de la Horda ha sido destruida.",
	HordeGateEastDestroyedTC		= "La puerta este de la fortaleza de la Horda ha sido destruida.",
	AllianceGateFrontDestroyedTC	= "La puerta principal de la fortaleza de la Alianza ha sido destruida.",
	AllianceGateWestDestroyedTC		= "La puerta oeste de la fortaleza de la Alianza ha sido destruida.",
	AllianceGateEastDestroyedTC		= "La puerta este de la fortaleza de la Alianza ha sido destruida.",
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

------------------------------
--  Strand of the Ancients  --
------------------------------
L = DBM:GetModLocalization("StrandoftheAncients")

L:SetGeneralLocalization({
	name = "Playa de los Ancestros"
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
	WarnSiegeEngineSoon	= "Mostrar aviso cuando una máquina de asedio esté casi lista"
})

L:SetMiscLocalization({
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
