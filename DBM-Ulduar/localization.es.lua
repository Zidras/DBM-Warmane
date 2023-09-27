if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization({
	name = "Leviatán de llamas"
})

L:SetWarningLocalization({
	PursueWarn				= "Persiguiendo a >%s<",
	warnNextPursueSoon		= "Cambio de objetivo en 5 s",
	SpecialPursueWarnYou	= "El leviatán te persigue - ¡huye!",
	warnWardofLife			= "Guarda de vida"
})

L:SetOptionLocalization({
	SpecialPursueWarnYou	= "Mostrar aviso especial cuando te afecte $spell:62374",
	PursueWarn				= "Anunciar objetivos de $spell:62374",
	warnNextPursueSoon		= "Mostrar aviso previo para el siguiente $spell:62374",
	warnWardofLife			= "Mostrar aviso especial cuando aparezcan Guardas de vida"
})

L:SetMiscLocalization({
	YellPull	= "Entidades hostiles detectadas. Protocolo de evaluación de amenaza activado. Objetivo principal fijado. Tiempo restante para re-evaluación: 30 segundos.",
	Emote		= "%%s persigue a (%S+)%."
})

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization({
	name = "Ignis el Maestro de la Caldera"
})

L:SetOptionLocalization({
	soundConcAuraMastery	= "Reproducir el sonido de $spell:31821 para anular los efectos de $spelll:63472 (sólo para el |cFFF48CBAPaladín|r que es el propietario de $spell:19746)"
})

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization({
	name = "Tajoescama"
})

L:SetWarningLocalization({
	warnTurretsReadySoon		= "Última torreta lista en 20 s",
	warnTurretsReady			= "Última torreta lista"
})

L:SetTimerLocalization({
	timerTurret1	= "Torreta 1",
	timerTurret2	= "Torreta 2",
	timerTurret3	= "Torreta 3",
	timerTurret4	= "Torreta 4",
	timerGrounded	= "En tierra"
})

L:SetOptionLocalization({
	warnTurretsReadySoon		= "Mostrar aviso previo para cuando las torretas estén listas",
	warnTurretsReady			= "Mostrar aviso cuando las torretas estén listas",
	timerTurret1				= "Mostrar temporizador para la primera torreta",
	timerTurret2				= "Mostrar temporizador para la segunda torreta",
	timerTurret3				= "Mostrar temporizador para la tercera torreta (25 jugadores)",
	timerTurret4				= "Mostrar temporizador para la cuarta torreta (25 jugadores)",
	timerGrounded				= "Mostrar temporizador para la duración de la fase en tierra"
})

L:SetMiscLocalization({
	YellAir						= "Danos un momento para que nos preparemos para construir las torretas.",
	YellAir2					= "Listos para salir, ¡impedid que esos enanos se peguen a nuestra espalda!",
	YellGround					= "¡Moveos! ¡No seguirá mucho más en el suelo!",
	EmotePhase2					= "¡%%s ha aterrizado permanentemente!"
})

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization({
	name = "Desarmador XA-002"
})

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization({
	name = "La Asamblea de Hierro"
})

L:SetOptionLocalization({
	AlwaysWarnOnOverload		= "Mostrar siempre aviso para $spell:63481 (de lo contrario, solo se muestra cuando eres el objetivo)"
})

L:SetMiscLocalization({
	Steelbreaker		= "Rompeacero",
	RunemasterMolgeim	= "Maestro de runas Molgeim",
	StormcallerBrundir	= "Clamatormentas Brundir"
})

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization({
	name = "Algalon el Observador"
})

L:SetWarningLocalization({
	warnStarLow				= "Estrella en colapso a poca salud"
})

L:SetTimerLocalization({
	NextCollapsingStar		= "Siguiente Estrella en colapso",
})

L:SetOptionLocalization({
	NextCollapsingStar		= "Mostrar temporizador para la siguiente Estrella en colapso",
	warnStarLow				= "Mostrar aviso especial cuando una Estrella en colapso tenga la salud baja (25%)"
})

L:SetMiscLocalization({
--	FirstPull				= "Mirad vuestro mundo a través de mis ojos: un universo tan vasto que es inconmensurable, incompresible incluso para vuestras grandes mentes.", -- esES
--	FirstPull				= "Vean su mundo a través de mis ojos: un universo tan vasto que es inconmensurable... Incomprensible aún para sus mentes más brillantes.", -- esMX
--	YellPull				= "Vuestros actos carecen de lógica. Se ha calculado cualquier posible resultado de este encuentro. El Panteón recibirá el mensaje del Observador sean cuales sean las consecuencias.", -- esES
--	YellPull				= "Tus acciones son ilógicas. Todos los resultados posibles de este encuentro han sido calculados. El Panteón recibirá el mensaje del Observador más allá del resultado.", -- esMX
	YellKill				= "He visto mundos hundirse en las llamas de los Creadores, como se desvanecían sus habitantes sin apenas un gemido. He visto sistemas planetarios enteros crearse y ser arrasados en lo que vuestros mortales corazones laten una sola vez. Y mi corazón permaneció desprovisto de emoción... de empatía. Yo... no... sentí... nada. Millones de vidas malgastadas ¿Acaso compartían vuestra tenacidad? ¿Amaban la vida como vosotros?", -- esES
--	YellKill				= "He visto mundos enteros bañados en las llamas del Creador, a sus habitantes esfumarse dejando menos que un quejido. Sistemas planetarios nacen y son arrasados en lo que les lleva a sus corazones mortales dar un latido. Y aún después de todo, mi propio corazón carece de emoción... de compasión. Nunca. He. Sentido. Nada. Un millón de millones de vidas desperdiciadas. ¿Acaso todas ellas llevaban dentro tu tenacidad? ¿Todas amaban la vida como tú?", -- esMX
	Emote_CollapsingStar	= "¡%s comienza a invocar estrellas en colapso!",
	Phase2					= "¡Observad las herramientas de la creación!", -- esES
--	Phase2					= "¡Contempla las herramientas de la creación!", -- esMX
	CollapsingStar			= "Estrella en colapso"
})

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization({
	name = "Kologarn"
})

L:SetTimerLocalization({
	timerLeftArm		= "Brazo izquierdo reaparece",
	timerRightArm		= "Brazo derecho reaparece",
	achievementDisarmed	= "Logro: Desarmado"
})

L:SetOptionLocalization({
	timerLeftArm			= "Mostrar temporizador para la regeneración del Brazo izquierdo",
	timerRightArm			= "Mostrar temporizador para la regeneración del Brazo derecho",
	achievementDisarmed		= "Mostrar temporizador para el logro 'Desarmado'"
})

L:SetMiscLocalization({
--	Yell_Trigger_arm_left	= "¡No es más que un arañazo!",
--	Yell_Trigger_arm_right	= "¡Una herida superficial!",
	Health_Body				= "Kologarn",
	Health_Right_Arm		= "Brazo derecho",
	Health_Left_Arm			= "Brazo izquierdo",
	FocusedEyebeam			= "sus ojos en ti"
})

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization({
	name = "Auriaya"
})

L:SetWarningLocalization({
	WarnCatDied		= "Defensor feral muerto (%d vidas restantes)",
	WarnCatDiedOne	= "Defensor feral muerto (1 vida restante)"
})

-- L:SetTimerLocalization({
-- 	timerDefender	= "Defensor feral activo"
-- })

L:SetOptionLocalization({
	WarnCatDied		= "Mostrar aviso cuando muera el Defensor feral",
	WarnCatDiedOne	= "Mostrar aviso cuando el Defensor feral solo tenga una vida restante"
--	timerDefender	= "Mostrar temporizador para cuando aparezca o reviva el Defensor feral"
})

L:SetMiscLocalization({
	Defender = "Defensor feral (%d)",
	YellPull = "¡Es mejor dejar ciertas cosas tal como están!"
})

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization({
	name = "Hodir"
})

L:SetMiscLocalization({
	Pull		= "¡Sufriréis por esta intromisión!",
--	Pull		= "¡Sufrirás por esta ofensa!" -- esMX
	YellKill	= "Estoy... estoy libre de sus garras... al fin."
})

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization({
	name = "Thorim"
})

L:SetTimerLocalization({
	TimerHardmode	= "Modo difícil"
})

L:SetOptionLocalization({
	specWarnHardmode	= "Mostrar anuncio especial cuando el Modo difícil se ha activado",
	TimerHardmode		= "Mostrar temporizador para el modo difícil",
	AnnounceFails		= "Anunciar jugadores que reciban daño de $spell:62017 en el chat de banda (requiere líder o ayudante)"
})

L:SetMiscLocalization({
	YellPhase1			= "¡Intrusos! Vosotros, mortales que osáis interferir en mi diversión, pagaréis... Un momento...",
	YellPhase2			= "Gusanos impertinentes, ¿cómo osáis desafiarme en mi pedestal? ¡Os machacaré con mis propias manos!",
	YellKill			= "¡Guardad las armas! ¡Me rindo!",
	YellHardModeActive	= "¡Imposible! ¡Thorim, mi señor, llevaré a tus enemigos a una muerte gélida!", -- esES
--	YellHardModeActive	= "¡Imposible! ¡Señor Thorim, daré a sus enemigos una muerte glacial!", -- esMX
	YellHardModeFailed	= "Esos patéticos mortales son inofensivos, no están a mi altura. ¡Deshazte de ellos!", -- esES
--	YellHardModeFailed	= "Estos patéticos mortales son inofensivos, por debajo de mi casta. ¡Deshazte de ellos!", -- esMX
	ChargeOn			= "Carga relámpago: %s",
	Charge				= "Fallos en Carga relámpago (en este intento): %s"
})

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization({
	name = "Freya"
})

L:SetWarningLocalization({
	WarnSimulKill	= "Primer esbirro muerto - Resurrección en ~12 segundos"
})

L:SetTimerLocalization({
	TimerSimulKill	= "Resurrección"
})

L:SetOptionLocalization({
	WarnSimulKill	= "Anunciar primer esbirro muerto",
	TimerSimulKill	= "Mostrar temporizador para la resurrección de esbirros"
})

L:SetMiscLocalization({
	SpawnYell			= "¡Hijos, ayudadme!",
	WaterSpirit			= "Espíritu de agua antiguo",
	Snaplasher			= "Quiebrazotador",
	StormLasher			= "Azotador de tormenta",
	YellKill			= "Su control sobre mí se disipa. Vuelvo a ver con claridad. Gracias, héroes.",
	YellAdds1			= "¡Eonar, tus sirvientes requieren tu ayuda!", -- esES
--	YellAdds1			= "¡Eonar, tu siervo necesita ayuda!", -- esMX
	YellAdds2			= "¡El azote de los elementos podrá con vosotros!", -- esES
--	YellAdds2			= "¡La horda de elementos te atrapará!", -- esMX
	EmoteLGift			= "comienza a crecer!", -- ¡Un |cFF00FFFFDon de la Protectora|r comienza a crecer!
	TrashRespawnTimer	= "Reaparicion de Adds de Freya",
	YellPullNormal		= "¡Debemos proteger el Invernadero!", -- esES
--	YellPullNormal		= ¡Hay que proteger el Conservatorio! -- esMX
	YellPullHard		= "¡Ancestros, otorgadme vuestro poder!" -- esES
--	YellPullHard		= "¡Ancestros, concédanme su fuerza!" -- esMX
})

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization({
	name = "Ancestros de Freya"
})

L:SetOptionLocalization({
	TrashRespawnTimer	= "Mostrar tiempo para reaparición de adds"
})

L:SetMiscLocalization({
	TrashRespawnTimer	= "Reaparicion de Adds de Freya"
})

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization({
	name = "Mimiron"
})

L:SetWarningLocalization({
	MagneticCore		= ">%s< tiene Núcleo magnético",
	WarnBombSpawn		= "Bombabot"
})

L:SetTimerLocalization({
	TimerHardmode	= "Autodestrucción",
	TimeToPhase2	= "Fase 2",
	TimeToPhase3	= "Fase 3",
	TimeToPhase4	= "Fase 4"
})

L:SetOptionLocalization({
	TimeToPhase2			= "Mostrar temporizador para el cambio a Fase 2",
	TimeToPhase3			= "Mostrar temporizador para el cambio a Fase 3",
	TimeToPhase4			= "Mostrar temporizador para el cambio a Fase 4",
	MagneticCore			= "Anunciar jugadores que despojen Núcleos magnéticos",
	AutoChangeLootToFFA		= "Cambiar el loot a Botín Libre en la fase 3",
	WarnBombSpawn			= "Mostrar aviso cuando aparezcan Bombabots",
	TimerHardmode			= "Mostrar temporizador para la autodestrucción del modo difícil"
})

L:SetMiscLocalization({
	MobPhase1		= "Mk II de leviatán",
	MobPhase2		= "VX-001",
	MobPhase3		= "Unidad de mando aérea",
	MobPhase4		= "V-07-TR-0N", -- don't localize nor change it to V-07-TR-ON for esMX (typo)
	YellPull		= "¡No tenemos mucho tiempo, amigos! Vais a ayudarme a probar mi última y mayor creación. Ahora, antes de que cambiéis de parecer, recordad que en cierta forma, me lo debéis después del desastre que causasteis con el XA-002.",
	YellHardPull	= "Secuencia de autodestrucción iniciada.", -- esES
--	YellHardPull	= "Fase de autodestrucción iniciada." -- esMX
	YellPhase2		= "¡Contemplad el cañón de asalto antipersonal VX-001! Puede que queráis poneros a cubierto.",
	YellPhase3		= "¡Gracias amigos! ¡Vuestros esfuerzos me han proporcionado unos datos fantásticos! Veamos, ¿dónde puse?...ah, ahí está.",
	YellPhase4		= "Fase de prueba preliminar completada. ¡Ahora comienza la verdadera prueba!",
	YellKilled		= "Parece que me he equivocado en los cálculos. Permití que el demonio de la prisión corrompiera mi mente y se sobrepusiera a mi directiva principal. Ahora parece que todos los sistemas funcionan. Evidente.", -- esES
--	YellKilled		= "Aparentemente cometí un error de cálculos. Permití que mi mente fuera corrompida por el enemigo en la prisión, descartando mi directiva primaria. Todos los sistemas parecen estar funcionando nuevamente. Cambio." -- esMX
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
})

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization({
	name = "General Vezax"
})

L:SetTimerLocalization({
	hardmodeSpawn = "Animus de saronita"
})

L:SetOptionLocalization({
	hardmodeSpawn		= "Mostrar temporizador para cuando aparezca el Animus de saronita (modo difícil)",
	CrashArrow			= "Mostrar flecha cuando $spell:62660 ocurra cerca de ti"
})

L:SetMiscLocalization({
	EmoteSaroniteVapors	= "¡Cerca se forma una nube de vapores de saronita!"
})

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization({
	name = "Yogg-Saron"
})

L:SetWarningLocalization({
	WarningGuardianSpawned			= "Guardián (%d)",
	WarningCrusherTentacleSpawned	= "Tentáculo triturador",
	WarningSanity					= "%d de Cordura restante",
	SpecWarnSanity					= "%d de Cordura restante",
	SpecWarnGuardianLow				= "Guardián a poca salud - ¡deja de atacar!",
	SpecWarnMadnessOutNow			= "Inducir a la locura en breve - ¡sal ya!",
	WarnBrainPortalSoon				= "Portales en 10 s",
	SpecWarnBrainPortalSoon			= "Portal en breve"
})

L:SetTimerLocalization({
	NextPortal	= "Siguientes portales"
})

L:SetOptionLocalization({
	WarningGuardianSpawned			= "Mostrar aviso cuando aparezca un Guardián de Yogg-Saron",
	WarningCrusherTentacleSpawned	= "Mostrar aviso cuando aparezca un Tentáculo triturador",
	WarningSanity					= "Mostrar aviso cuando te quede poca $spell:63050",
	SpecWarnSanity					= "Mostrar aviso especial cuando te quede muy poca $spell:63050",
	SpecWarnGuardianLow				= "Mostrar aviso especial cuando a un Guardián de Yogg-Saron le quede poca vida (solo para DPS)",
	WarnBrainPortalSoon				= "Mostrar aviso previo para los siguientes portales",
	SpecWarnMadnessOutNow			= "Mostrar aviso especial cuando $spell:64059 esté a punto de lanzarse",
	SpecWarnBrainPortalSoon			= "Mostrar aviso especial para los siguientes portales",
	NextPortal						= "Mostrar temporizador para los siguientes portales",
	ShowSaraHealth					= "Mostrar barra de vida de Sara en Fase 1",
	MaladyArrow						= "Mostrar flecha cuando $spell:63881 ocurra cerca de ti"
})

L:SetMiscLocalization({
	YellPull			= "¡Pronto llegará la hora de golpear la cabeza del monstruo! ¡Centrad vuestra ira y odio en sus esbirros!",
	S1TheLucidDream		= "Fase 1: El sueño lúcido",
	Sara				= "Sara",
	GuardianofYoggSaron	= "Guardián de Yogg-Saron",
	S2DescentIntoMadness= "Fase 2: El Descenso a la Locura",
	CrusherTentacle		= "Tentáculo triturador",
	CorruptorTentacle	= "Tentáculo corruptor",
	ConstrictorTentacle	= "Tentáculo constrictor",
	DescentIntoMadness	= "El Descenso a la Locura",
	InfluenceTentacle	= "Tentáculo cimbreante",
	LaughingSkull		= "Calavera jocosa",
	BrainofYoggSaron	= "Cerebro de Yogg-Saron",
	S3TrueFaceofDeath	= "Fase 3: El auténtico rostro de la muerte",
	YoggSaron			= "Yogg-Saron",
	ImmortalGuardian	= "Guardián inmortal"
})
