if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------------------
--  Hydross the Unstable --
---------------------------
L = DBM:GetModLocalization("Hydross")

L:SetGeneralLocalization{
	name = "Hydross el Inestable"
}

L:SetWarningLocalization{
	WarnMark 		= "%s: %s",
	WarnPhase		= "Fase de %s",
	SpecWarnMark	= "%s: %s"
}

L:SetTimerLocalization{
	TimerMark	= "Next %s : %s"
}

L:SetOptionLocalization{
	WarnMark		= "Mostrar aviso para las marcas",
	WarnPhase		= "Anunciar cambios de fase",
	SpecWarnMark	= "Mostrar aviso cuando el daño del perjuicio de las marcas esté por encima del 100%",
	TimerMark		= "Mostrar temporizador para las siguientes marcas",
	RangeFrame		= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format(10)
}

L:SetMiscLocalization{
	Frost	= "Escarcha",
	Nature	= "Naturaleza"
}

-----------------------
--  The Lurker Below --
-----------------------
L = DBM:GetModLocalization("LurkerBelow")

L:SetGeneralLocalization{
	name = "El Rondador de abajo"
}

L:SetWarningLocalization{
	WarnSubmerge		= "Sumersión",
	WarnEmerge			= "Emersión"
}

L:SetTimerLocalization{
	TimerSubmerge		= "Sumersión TdR",
	TimerEmerge			= "Emersión TdR"
}

L:SetOptionLocalization{
	WarnSubmerge		= "Mostrar aviso cuando el jefe se sumerja",
	WarnEmerge			= "Mostrar aviso cuando el jefe regrese a la superficie",
	TimerSubmerge		= "Mostrar temporizador para cuando el jefe de sumerja",
	TimerEmerge			= "Mostrar temporizador para cuando el jefe regrese a la superficie"
}

--------------------------
--  Leotheras the Blind --
--------------------------
L = DBM:GetModLocalization("Leotheras")

L:SetGeneralLocalization{
	name = "Leotheras el Ciego"
}

L:SetWarningLocalization{
	WarnPhase		= "Fase %s"
}

L:SetTimerLocalization{
	TimerPhase	= "Siguiente fase %s "
}

L:SetOptionLocalization{
	WarnPhase		= "Anunciar cambios de fase",
	TimerPhase		= "Mostrar temporizador para la siguiente fase"
}

L:SetMiscLocalization{
	Human		= "humana",
	Demon		= "demoníaca",
	YellDemon	= "Desaparece, elfo pusilánime. ¡Yo mando ahora!",
	YellPhase2	= "¿Qué has hecho? ¡Yo soy el maestro!"
}

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
L = DBM:GetModLocalization("Fathomlord")

L:SetGeneralLocalization{
	name = "Señor de las profundidades Karathress"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	Caribdis	= "Guardia de las profundidades Caribdis",
	Tidalvess	= "Guardia de las profundidades Tidalvess",
	Sharkkis	= "Guardia de las profundidades Sharkkis"
}

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetGeneralLocalization{
	name = "Morogrim Levantamareas"
}

L:SetWarningLocalization{
	WarnMurlocs		= "Múrlocs",
	SpecWarnMurlocs	= "Múrlocs"
}

L:SetTimerLocalization{
	TimerMurlocs	= "Siguientes múrlocs"
}

L:SetOptionLocalization{
	WarnMurlocs		= "Mostrar aviso cuando aparezcan múrlocs",
	SpecWarnMurlocs	= "Mostrar aviso especial cuando aparezcan múrlocs",
	TimerMurlocs	= "Mostrar temporizador para los siguientes múrlocs",
	GraveIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(38049)
}

L:SetMiscLocalization{
}

-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetGeneralLocalization{
	name = "Lady Vashj"
}

L:SetWarningLocalization{
	WarnElemental		= "Elemental corrupto (%s) en breve",
	WarnStrider			= "Zancudo (%s) en breve",
	WarnNaga			= "Élite (%s) en breve",
	WarnShield			= "Escudo: %d/4",
	WarnLoot			= "Núcleo máculo en >%s<",
	SpecWarnElemental	= "Elemental corrupto - ¡cambia de objetivo!"
}

L:SetTimerLocalization{
	TimerElementalActive	= "Elemental corrupto activo",
	TimerElemental			= "Siguiente Elemental corrupto (%d)",
	TimerStrider			= "Siguiente Zancudo (%d)",
	TimerNaga				= "Siguiente Élite (%d)"
}

L:SetOptionLocalization{
	WarnElemental		= "Mostrar aviso previo para el siguiente Elemental corrupto",
	WarnStrider			= "Mostrar aviso previo para el siguiente Zancudo Colmillo Torcido",
	WarnNaga			= "Mostrar aviso especial para el siguiente Élite Colmillo Torcido",
	WarnShield			= "Mostrar aviso cuando disminuya el escudo de la fase 2",
	WarnLoot			= "Mostrar aviso cuando un jugador despoje un Núcleo máculo",
	TimerElementalActive	= "Mostrar temporizador para la duración restante de los Elementales corruptos",
	TimerElemental		= "Mostrar temporizador para el siguiente Elemental corrupto",
	TimerStrider		= "Mostrar temporizador para el siguiente Zancudo Colmillo Torcido",
	TimerNaga			= "Mostrar temporizador para el siguiente Élite Colmillo Torcido",
	SpecWarnElemental	= "Mostrar aviso previo especial para cuando aparezca un Elemental corrupto",
	RangeFrame			= "Mostrar marco de distancia (10 m)",
	ChargeIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(38280),
	AutoChangeLootToFFA	= "Cambiar modo de botín a libre en Fase 2"
}

L:SetMiscLocalization{
	DBM_VASHJ_YELL_PHASE2	= "¡Ha llegado el momento! ¡Que no quede ni uno en pie!",
	DBM_VASHJ_YELL_PHASE3	= "Os vendrá bien cubriros.",
	LootMsg					= "([^%s]+).*Hitem:(%d+)"
}
