if GetLocale() ~= "esES" then return end
local L

-----------------
-- Anub'Rekhan --
-----------------
L = DBM:GetModLocalization("Anub'Rekhan-Vanilla")

L:SetGeneralLocalization({
	name = "Anub'Rekhan"
})

L:SetOptionLocalization({
	ArachnophobiaTimer	= "Mostrar temporizador para el logro 'Aracnofobia'"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Logro: Aracnofobia",
	Pull1				= "¡Eso, corred! ¡Así la sangre circula más rápido!",
	Pull2				= "Solo un bocado..."
})

-------------------------
-- Gran Viuda Faerlina --
-------------------------
L = DBM:GetModLocalization("Faerlina-Vanilla")

L:SetGeneralLocalization({
	name = "Gran Viuda Faerlina"
})

L:SetWarningLocalization({
	WarningEmbraceExpire	= "Abrazo de la viuda expirando en 5 s"
})

L:SetOptionLocalization({
	WarningEmbraceExpire	= "Mostrar aviso previo para cuando expire Abrazo de la viuda"
})

L:SetMiscLocalization({
	Pull					= "¡Arrodíllate ante mí, sabandija!"--Not actually pull trigger, but often said on pull
})

-------------
-- Maexxna --
-------------
L = DBM:GetModLocalization("Maexxna-Vanilla")

L:SetGeneralLocalization({
	name = "Maexxna"
})

L:SetWarningLocalization({
	WarningSpidersSoon	= "Arañitas de Maexxna en 5 s",
	WarningSpidersNow	= "Arañitas de Maexxna"
})

L:SetTimerLocalization({
	TimerSpider	= "Siguientes arañitas"
})

L:SetOptionLocalization({
	WarningSpidersSoon	= "Mostrar aviso previo para cuando aparezcan Arañitas de Maexxna",
	WarningSpidersNow	= "Mostrar aviso cuando aparezcan Arañitas de Maexxna",
	TimerSpider			= "Mostrar temporizador para las siguientes Arañitas de Maexxna"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Logro: Aracnofobia"
})

-----------------------
-- Noth el Pesteador --
-----------------------
L = DBM:GetModLocalization("Noth-Vanilla")

L:SetGeneralLocalization({
	name = "Noth el Pesteador"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teletransporte",
	WarningTeleportSoon	= "Teletransporte en 10 s"
})

L:SetTimerLocalization({
	TimerTeleport		= "Teletransporte: Balcón",
	TimerTeleportBack	= "Teletransporte: Suelo"
})

L:SetOptionLocalization({
	WarningTeleportNow	= "Mostrar aviso para Teletransporte",
	WarningTeleportSoon	= "Mostrar aviso previo para Teletransporte",
	TimerTeleport		= "Mostrar temporizador para el siguiente Teletransporte: Balcón",
	TimerTeleportBack	= "Mostrar temporizador para Teletransporte: Suelo"
})

L:SetMiscLocalization({
	Pull				= "¡Muere, intruso!",
	Adds				= "invoca a guerreros esqueletos!",
	AddsTwo				= "alza más esqueletos!"
})

----------------------
-- Heigan el Impuro --
----------------------
L = DBM:GetModLocalization("Heigan-Vanilla")

L:SetGeneralLocalization({
	name = "Heigan el Impuro"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teletransporte",
	WarningTeleportSoon	= "Teletransporte en %d s"
})

L:SetTimerLocalization({
	TimerTeleport	= "Teletransporte"
})

L:SetOptionLocalization({
	WarningTeleportNow	= "Mostrar aviso para Teletransporte",
	WarningTeleportSoon	= "Mostrar aviso previo para Teletransporte",
	TimerTeleport		= "Mostrar aviso para Teletransporte"
})

L:SetMiscLocalization({
	Pull				= "Ahora me perteneces."
})

-------------
-- Loatheb --
-------------
L = DBM:GetModLocalization("Loatheb-Vanilla")

L:SetGeneralLocalization({
	name = "Loatheb"
})

L:SetWarningLocalization({
	WarningHealSoon	= "Sanación posible en 3 s",
	WarningHealNow	= "¡Sanad ahora!"
})

L:SetOptionLocalization({
	WarningHealSoon		= "Mostrar aviso previo para la franja de sanación",
	WarningHealNow		= "Mostrar aviso para la franja de sanación",
	SporeDamageAlert	= "Enviar susurros y avisar a la banda de los jugadores que estén dañando esporas\n(necesita 'anunciar' activado y lider/ayudante)",
	CorruptedSorting	= "Set infoframe sorting behaviour for $spell:55593", -- translation missing
	Alphabetical		= "Sort in alphabetical order", -- translation missing
	Duration			= "Sort by duration" -- translation missing
})

---------------
-- Remendejo --
---------------
L = DBM:GetModLocalization("Patchwerk-Vanilla")

L:SetGeneralLocalization({
	name = "Remendejo"
})

L:SetOptionLocalization({
	WarningHateful = "Avisar por chat de banda los Golpes de Odio (necesitas ser ayudante o lider para eso)"
})

L:SetMiscLocalization({
	yell1 = "¡Remendejo quiere jugar!",
	yell2 = "¡Remendejo es la encarnación de guerra de Kel'Thuzad!",
	HatefulStrike = "Golpe de Odio --> %s [%s]"
})

---------------
-- Grobbulus --
---------------
L = DBM:GetModLocalization("Grobbulus-Vanilla")

L:SetGeneralLocalization({
	name = "Grobbulus"
})

-----------
-- Gluth --
-----------
L = DBM:GetModLocalization("Gluth-Vanilla")

L:SetGeneralLocalization({
	name = "Gluth"
})

--------------
-- Thaddius --
--------------
L = DBM:GetModLocalization("Thaddius-Vanilla")

L:SetGeneralLocalization({
	name = "Thaddius"
})

L:SetWarningLocalization({
	WarningChargeChanged	= "Polaridad cambiada a %s",
	WarningChargeNotChanged	= "Tu polaridad no ha cambiado"
})

L:SetOptionLocalization({
	WarningChargeChanged	= "Mostrar aviso especial cuando tu polaridad cambie",
	WarningChargeNotChanged	= "Mostrar aviso especial cuando tu polaridad no cambie",
	ArrowsEnabled			= "Mostrar flechas (estrategia típica de dos grupos)",
	ArrowsRightLeft			= "Mostrar flechas de izquierda y derecha (estrategia de cuatro grupos; muestra la flecha izquierda si cambia la polaridad, y la derecha si no cambia)",
	ArrowsInverse			= "Mostrar flechas de izquierda y derecha inversas (estrategia de cuatro grupos; muestra la flecha derecha si cambia la polaridad, y la izquierda si no cambia)"
})

L:SetMiscLocalization({
	Yell	= "¡Stalagg aplasta!",
	Emote	= "¡%s se sobrecarga!",
	Emote2	= "¡Espiral Tesla se sobrecarga!",
	Boss1	= "Feugen",
	Boss2	= "Stalagg",
	Charge1 = "negativo",
	Charge2 = "positivo"
})

--------------------------
-- Instructor Razuvious --
--------------------------
L = DBM:GetModLocalization("Razuvious-Vanilla")

L:SetGeneralLocalization({
	name = "Instructor Razuvious"
})

L:SetWarningLocalization({
	WarningShieldWallSoon	= "Barrera de huesos termina en 5 s"
})

L:SetOptionLocalization({
	WarningShieldWallSoon	= "Mostrar aviso previo para cuando termine $spell:29061"
})

L:SetMiscLocalization({
	Yell1 = "¡No tengáis piedad!",
	Yell2 = "¡El tiempo de practicar ha pasado! ¡Quiero ver lo que habéis aprendido!",
	Yell3 = "¡Poned en práctica lo que os he enseñado!",
	Yell4 = "Un barrido con pierna... ¿Tienes algún problema?"
})

--------------------------
-- Gothik el Cosechador --
--------------------------
L = DBM:GetModLocalization("Gothik-Vanilla")

L:SetGeneralLocalization({
	name = "Gothik el Cosechador"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "Oleada %d: %s en 3 s",
	WarningWaveSpawned	= "Oleada %d: %s",
	WarningRiderDown	= "Jinete muerto",
	WarningKnightDown	= "Caballero muerto",
	WarningPhase2		= "Fase 2"
})

L:SetTimerLocalization({
	TimerWave	= "Oleada %d",
	TimerPhase2	= "Fase 2"
})

L:SetOptionLocalization({
	TimerWave			= "Mostrar temporizador para la siguiente oleada de esbirros",
	TimerPhase2			= "Mostrar temporizador para el cambio a Fase 2",
	WarningWaveSoon		= "Mostrar aviso previo para la siguiente oleada de esbirros",
	WarningWaveSpawned	= "Mostrar aviso cuando comience una oleada de esbirros",
	WarningRiderDown	= "Mostrar aviso cuando muera un Jinete inflexible",
	WarningKnightDown	= "Mostrar aviso cuando muera un Caballero de la Muerte inflexible"
})

L:SetMiscLocalization({
	yell			= "Tú mismo has buscado tu final.",
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s y %d %s",
	WarningWave3	= "%d %s, %d %s y %d %s",
	Trainee			= "practicantes",
	Knight			= "caballeros",
	Rider			= "jinetes"
})

------------------------
-- Los Cuatro Jinetes --
------------------------
L = DBM:GetModLocalization("Horsemen-Vanilla")

L:SetGeneralLocalization({
	name = "Los Cuatro Jinetes"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Marca %d en 3 s",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetOptionLocalization({
	WarningMarkSoon				= "Mostrar aviso previo para las marcas",
	SpecialWarningMarkOnPlayer	= "Mostrar aviso especial cuando estés afectado por más de cuatro marcas"
})

L:SetMiscLocalization({
	Korthazz	= "Señor feudal Korth'azz",
	Rivendare	= "Barón Osahendido",
	Blaumeux	= "Lady Blaumeux",
	Zeliek		= "Sir Zeliek"
})

---------------
-- Sapphiron --
---------------
L = DBM:GetModLocalization("Sapphiron-Vanilla")

L:SetGeneralLocalization({
	name = "Sapphiron"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon	= "Fase aérea en 10 s",
	WarningAirPhaseNow	= "Fase aérea",
	WarningLanded		= "Fase en tierra",
	WarningDeepBreath	= "Aliento de Escarcha",
	SpecWarnSapphLow	= "¡Sapphiron no puede volar!"
})

L:SetTimerLocalization({
	TimerAir		= "Fase aérea",
	TimerLanding	= "Fase en tierra",
	TimerIceBlast	= "Aliento de Escarcha"
})

L:SetOptionLocalization({
	WarningAirPhaseSoon	= "Mostrar aviso previo para el cambio a fase aérea",
	WarningAirPhaseNow	= "Anunciar cambio a fase aérea",
	WarningLanded		= "Anunciar cambio a fase en tierra",
	TimerAir			= "Mostrar temporizador para el cambio a fase aérea",
	TimerLanding		= "Mostrar temporizador para el cambio a fase en tierra",
	TimerIceBlast		= "Mostrar temporizador para $spell:28524",
	WarningDeepBreath	= "Mostrar aviso especial para $spell:28524",
	SpecWarnSapphLow	= "Advertencia especial para fase de ejecución del 10% (cancelación de fase de aire)"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s respira hondo.",
	AirPhase			= "¡Sapphiron se eleva en el aire!",
	LandingPhase		= "¡Sapphiron reanuda su ataque!"
})

----------------
-- Kel'Thuzad --
----------------
L = DBM:GetModLocalization("Kel'Thuzad-Vanilla")

L:SetGeneralLocalization({
	name = "Kel'Thuzad"
})

L:SetWarningLocalization({
	specwarnP2Soon	= "Fase 2 en 10 s",
	warnAddsSoon	= "Guardianes de Corona de Hielo en breve",
	WeaponsStatus	= "Desequipar automático habilitado: %s (%s - %s)"
})

L:SetTimerLocalization({
	TimerPhase2	= "Fase 2"
})

L:SetOptionLocalization({
	TimerPhase2			= "Mostrar temporizador para el cambio a Fase 2",
	specwarnP2Soon		= "Mostrar aviso especial 10 s antes del cambio a Fase 2",
	warnAddsSoon		= "Mostrar aviso previo para cuando aparezcan los Guardianes de Corona de Hielo",
	WeaponsStatus		= "Advertencia especial al inicio del combate si la función desequipar/equipar está habilitada",
	EqUneqWeaponsKT		= "Desequipar y equipar armas automáticamente con temporizador, antes y después del $spell:28410. Requiere equipamiento llamado \"pve\"",
	EqUneqWeaponsKT2	= "Desequipar y equipar armas automáticamente cuando se lanza $spell:28410 sobre USTED. Requiere equipamiento llamado \"pve\"",
	RemoveBuffsOnMC		= "Elimina los buffs cuando $spell:28410 es lanzado sobre ti. Cada opción es acumulativa",
	Gift				= "Eliminar $spell:48469 / $spell:48470. Enfoque mínimo para evitar que $spell:33786 se resista",
	CCFree				= "+ Eliminar $spell:48169 / $spell:48170. Tener en cuenta las resistencias de los hechizos de la escuela Sombra",
	ShortOffensiveProcs	= "+ Elimina los procs ofensivos de baja duración. Recomendado para la seguridad de la raid sin comprometer la producción de daño de la raid",
	MostOffensiveBuffs	= "+ Elimina la mayoría de los buffs ofensivos (principalmente para los Casters y los |cFFFF7C0ADruidas Ferales|r). Máxima seguridad en la incursión con la pérdida de daño y la necesidad de auto-buff/cambio de forma"
})

L:SetMiscLocalization({
	Yell		= "¡Esbirros, sirvientes, soldados de la fría oscuridad! ¡Obedeced la llamada de Kel'Thuzad!",
	Yell1Phase2	= "¡Pedid misericordia!", -- 12995
	Yell2Phase2	= "¡Gritad antes de vuestro último suspiro!", -- 12996
	Yell3Phase2	= "¡Vuestra hora ha llegado!", -- 12997
	YellPhase3	= "¡Maestro, necesito ayuda!", -- 12998
	YellGuardians	= "Muy bien. ¡Guerreros del desierto helado! ¡Levantaos, os ordeno luchar, matar y morir por vuestro maestro! ¡Que no sobreviva ninguno!", -- 12994
	setMissing	= "¡ATENCIÓN! El desequipamiento / equipamiento automático de armas de DBM no funcionará hasta que cree un equipamiento llamado pve",
	EqUneqLineDescription	= "Equipar/desequipar automático"
})
