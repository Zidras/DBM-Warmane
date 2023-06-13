if GetLocale() ~= "esES" or GetLocale() ~= "esMX" then return end
local L

-----------------
--  Najentus  --
-----------------
L = DBM:GetModLocalization("Najentus")

L:SetGeneralLocalization({
	name = "Gran señor de la guerra Naj'entus"
})

L:SetOptionLocalization({
	RangeFrame	= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format(8)
})

L:SetMiscLocalization({
	HealthInfo	= "Salud de los jugadores"
})

----------------
-- Supremus --
----------------
L = DBM:GetModLocalization("Supremus")

L:SetGeneralLocalization({
	name = "Supremus"
})

L:SetWarningLocalization({
	WarnPhase		= "Fase de %s",
	WarnKite		= "Mirada en >%s<"
})

L:SetTimerLocalization({
	TimerPhase		= "Siguiente fase de %s"
})

L:SetOptionLocalization({
	WarnPhase		= "Anunciar cambios de fase",
	WarnKite		= "Anunciar objetivos de Mirada",
	TimerPhase		= "Mostrar temporizador para los cambios de fase",
	KiteIcon		= "Poner icono en el objetivo de Mirada"
})

L:SetMiscLocalization({
	PhaseTank		= "golpea el suelo enfadado!",
	PhaseKite		= "El suelo comienza a abrirse.",
	ChangeTarget	= "adquiere un nuevo objetivo!",
	Kite			= "persecución",
	Tank			= "tanqueo"
})

-------------------------
--  Shape of Akama  --
-------------------------
L = DBM:GetModLocalization("Akama")

L:SetGeneralLocalization({
	name = "Sombra de Akama"
})

-------------------------
--  Teron Gorefiend  --
-------------------------
L = DBM:GetModLocalization("TeronGorefiend")

L:SetGeneralLocalization({
	name = "Teron Sanguino"
})

L:SetTimerLocalization({
	TimerVengefulSpirit		= "Fantasma: %s"
})

L:SetOptionLocalization({
	TimerVengefulSpirit		= "Mostrar temporizador para la duración de la forma de fantasma"
})

----------------------------
--  Gurtogg Bloodboil  --
----------------------------
L = DBM:GetModLocalization("Bloodboil")

L:SetGeneralLocalization({
	name = "Gurtogg Sangre Hirviente"
})

--------------------------
--  Essence Of Souls  --
--------------------------
L = DBM:GetModLocalization("Souls")

L:SetGeneralLocalization({
	name = "Relicario de Almas"
})

L:SetWarningLocalization({
	WarnMana		= "Sin maná en 30 s"
})

L:SetTimerLocalization({
	TimerMana		= "Sin maná"
})

L:SetOptionLocalization({
	WarnMana		= "Mostrar aviso previo para cuando el maná máximo de los jugadores llegue a cero en Fase 2",
	TimerMana		= "Mostrar temporizador para cuando el maná máximo de los jugadores llegue a cero en Fase 2"
})

L:SetMiscLocalization({
	Suffering		= "Esencia de sufrimiento",
	Desire			= "Esencia de deseo",
	Anger			= "Esencia de inquina"
})

-----------------------
--  Mother Shahraz --
-----------------------
L = DBM:GetModLocalization("Shahraz")

L:SetGeneralLocalization({
	name = "Madre Shahraz"
})

L:SetTimerLocalization({
	timerAura	= "%s"
})

L:SetOptionLocalization({
	timerAura	= "Mostrar temporizador para la siguiente Aura centelleante"
})

----------------------
--  Illidari Council  --
----------------------
L = DBM:GetModLocalization("Council")

L:SetGeneralLocalization({
	name = "El Consejo Illidari"
})

L:SetWarningLocalization({
	Immune			= "Malande inmune a %s durante 15 s"
})

L:SetOptionLocalization({
	Immune			= "Mostrar aviso cuando Manalde se vuelva inmune al daño físico o de hechizos"
})

L:SetMiscLocalization({
	Gathios			= "Gathios el Despedazador",
	Malande			= "Lady Malande",
	Zerevor			= "Sumo abisálico Zerevor",
	Veras			= "Veras Sombra Oscura",
	Melee			= "físico",
	Spell			= "hechizos"
})

-------------------------
--  Illidan Stormrage --
-------------------------
L = DBM:GetModLocalization("Illidan")

L:SetGeneralLocalization({
	name = "Illidan Tempestira"
})

L:SetWarningLocalization({
	WarnHuman		= "Fase humanoide",
	WarnDemon		= "Fase demoníaca"
})

L:SetTimerLocalization({
	TimerNextHuman		= "Siguiente fase humanoide",
	TimerNextDemon		= "Siguiente fase demoníaca"
})

L:SetOptionLocalization({
	WarnHuman		= "Anunciar cambio a fase humanoide",
	WarnDemon		= "Anunciar cambio a fase demoníaca",
	TimerNextHuman	= "Mostrar temporizador para la siguiente fase humanoide",
	TimerNextDemon	= "Mostrar temporizador para la siguiente fase demoníaca",
	RangeFrame		= "Mostrar marco de distancia (10 m) en las fases 3 y 4"
})

L:SetMiscLocalization({
	Pull			= "Akama. Tu hipocresía no me sorprende. Debí acabar contigo y con tus malogrados hermanos hace tiempo.",
	Eyebeam			= "¡Mirad los ojos del Traidor!",
	Demon			= "¡Observad el poder...del demonio interior!",--sic
	Phase4			= "¿Esto es todo, mortales? ¿Es esta toda la furia que podéis reunir?",
	S1YouAreNotPrepared	= "Fase 1: No estáis preparados",
	S2FlamesOfAzzinoth	= "Fase 2: Las llamas de Azzinoth",
	S3TheDemonWithin	= "Fase 3: El demonio interior",
	S4TheLongHunt		= "Fase 4: La gran cacería"
})
