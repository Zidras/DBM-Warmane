if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization({
	name = "Attumen el Montero"
})



--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization({
	name = "Moroes"
})

L:SetWarningLocalization({
	DBM_MOROES_VANISH_FADED	= "Esfumarse ha terminado"
})

L:SetOptionLocalization({
	DBM_MOROES_VANISH_FADED	= "Mostrar aviso cuando termine Esfumarse"
})

-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization({
	name = "Doncella de Virtud"
})

-- Romulo and Julianne
L = DBM:GetModLocalization("RomuloAndJulianne")

L:SetGeneralLocalization({
	name = "Romulo y Julianne"
})

L:SetMiscLocalization({
	Event				= "¡Esta noche... vamos a explorar un relato de amor prohibido!",
	RJ_Pull				= "¿Qué demonio sois que me atormentáis de questa manera?",
	DBM_RJ_PHASE2_YELL	= "Adelante, gentil noche, ¡devuélveme a mi Romulo!",
	Romulo				= "Romulo",
	Julianne			= "Julianne"
})

-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization({
	name = "El Lobo Feroz"
})



L:SetMiscLocalization({
	DBM_BBW_YELL_1			= "¡Para poseerte mejor!"
})

-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization({
	name = "Mago de Oz"
})

L:SetWarningLocalization({
	DBM_OZ_WARN_TITO		= "Tito",
	DBM_OZ_WARN_ROAR		= "Rugido",
	DBM_OZ_WARN_STRAWMAN	= "Espantapájaros",
	DBM_OZ_WARN_TINHEAD		= "Cabezalata",
	DBM_OZ_WARN_CRONE		= "La Vieja Bruja"
})

L:SetTimerLocalization({
	DBM_OZ_WARN_TITO		= "Tito",
	DBM_OZ_WARN_ROAR		= "Rugido",
	DBM_OZ_WARN_STRAWMAN	= "Espantapájaros",
	DBM_OZ_WARN_TINHEAD		= "Cabezalata"
})

L:SetOptionLocalization({
	AnnounceBosses			= "Show warnings for boss spawns",
	ShowBossTimers			= "Show timers for boss spawns"
})

L:SetMiscLocalization({
	DBM_OZ_YELL_DOROTHEE	= "¡Oh, Tito, solo tenemos que buscar la manera de volver a casa! ¡El viejo zahorí puede ser nuestra única esperanza! Espantapájaros, Rugido, Cabezalata, podeis- esperad... ¡Oh, caray, mirad tenemos visita!",--sic
	DBM_OZ_YELL_ROAR		= "¡No os tengo miedo! ¿Queréis pelea? ¿Eh? ¡Vamos, con las garras a la espalda os reto!",
	DBM_OZ_YELL_STRAWMAN	= "¿Ahora que tengo que hacer contigo? No me puedo decidir.",--sic
	DBM_OZ_YELL_TINHEAD		= "¿Me vendría bien un corazón Digamos, ¿el tuyo?",--sic
	DBM_OZ_YELL_CRONE		= "¡Pronto acabará todo!"--There seems to be two lines, but I only ever see this one in Spanish; the one in the English localization file is the other possible pull line.
})

-- Curator
L = DBM:GetModLocalization("Curator")

L:SetGeneralLocalization({
	name = "Curator"
})

L:SetWarningLocalization({
	warnAdd		= "Centellas astrales"
})

L:SetOptionLocalization({
	warnAdd		= "Mostrar aviso cuando aparezcan las Centellas astrales"
})

-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization({
	name = "Terestian Pezuña Enferma"
})

L:SetMiscLocalization({
	Kilrek					= "Kil'rek",
	DChains					= "Cadenas demoníacas"
})

-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization({
	name = "Sombra de Aran"
})

L:SetWarningLocalization({
	DBM_ARAN_DO_NOT_MOVE	= "Corona de llamas - ¡no te muevas!"
})

L:SetTimerLocalization({
	timerSpecial			= "Facultad especial TdR"
})

L:SetOptionLocalization({
	timerSpecial			= "Mostrar temporizador para el tiempo de reutilización de las facultades especiales",
	DBM_ARAN_DO_NOT_MOVE	= "Mostrar aviso especial para $spell:30004"
})

--Netherspite
L = DBM:GetModLocalization("Netherspite")

L:SetGeneralLocalization({
	name = "Rencor Abisal"
})

L:SetWarningLocalization({
	warningPortal			= "Fase de portales",
	warningBanish			= "Fase de destierro"
})

L:SetTimerLocalization({
	timerPortalPhase	= "Fase de portales",
	timerBanishPhase	= "Fase de destierro"
})

L:SetOptionLocalization({
	warningPortal			= "Anunciar cambio a fase de portales",
	warningBanish			= "Anunciar cambio a fase de destierro",
	timerPortalPhase		= "Mostrar temporizador para la duración de la fase de portales",
	timerBanishPhase		= "Mostrar temporizador para la duración de la fase de destierro"
})

L:SetMiscLocalization({
	DBM_NS_EMOTE_PHASE_2	= "¡%s monta en cólera alimentada por el vacío!",
	DBM_NS_EMOTE_PHASE_1	= "%s cries out in withdrawal, opening gates to the nether."
})

--Chess
L = DBM:GetModLocalization("Chess")

L:SetGeneralLocalization({
	name = "Chess Event"
})

L:SetTimerLocalization({
	timerCheat	= "Medivh hace trampas (TdR)"
})

L:SetOptionLocalization({
	timerCheat	= "Mostrar temporizador para cuando el Eco de Medivh haga trampas"
})

L:SetMiscLocalization({
	EchoCheats	= "¡Eco de Medivh hace trampas!"
})

--Prince Malchezaar
L = DBM:GetModLocalization("Prince")

L:SetGeneralLocalization({
	name = "Príncipe Malchezaar"
})

L:SetMiscLocalization({
	DBM_PRINCE_YELL_P2		= "¡Estúpidos! El tiempo es el fuego en el que arderéis!",--sic
	DBM_PRINCE_YELL_P3		= "¿Cómo podéis esperar rebelaros ante un poder tan aplastante?",
	DBM_PRINCE_YELL_INF1	= "¡Todas las realidades, todas las dimensiones están abiertas a mí!",
	DBM_PRINCE_YELL_INF2	= "¡No solo os enfrentáis a Malechezaar, sino a todas las legiones bajo mi mando!"
})

-- Nightbane
L = DBM:GetModLocalization("NightbaneRaid")

L:SetGeneralLocalization({
	name = "Nocturno"
})

L:SetWarningLocalization({
	DBM_NB_AIR_WARN			= "Fase aérea"
})

L:SetTimerLocalization({
	timerAirPhase			= "Fase aérea"
})

L:SetOptionLocalization({
	DBM_NB_AIR_WARN			= "Anunciar cambio a fase aérea",
	timerAirPhase			= "Mostrar temporizador para la duración de la fase aérea"
})

L:SetMiscLocalization({
	DBM_NB_EMOTE_PULL		= "Un ser antiguo se despierta en la distancia...",
	DBM_NB_YELL_AIR			= "Miserable alimaña. ¡Te exterminaré desde el aire!",
	DBM_NB_YELL_GROUND		= "¡Ya basta! Voy a aterrizar y a aplastarte yo mismo.",
	DBM_NB_YELL_GROUND2		= "¡Insectos! ¡Os enseñaré mi fuerza de cerca!"
})

-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization({
	name = "Shadikith el Planeador"
})

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization({
	name = "Hyakiss el Acechador"
})

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization({
	name = "Rokad el Devastador"
})
