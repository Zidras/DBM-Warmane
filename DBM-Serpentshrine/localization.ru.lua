if GetLocale() ~= "ruRU" then return end
local L

---------------------------
--  Hydross the Unstable --
---------------------------
L = DBM:GetModLocalization("Hydross")

L:SetGeneralLocalization({
	name = "Гидросс Нестабильный"
})

L:SetWarningLocalization({
	WarnMark		= "%s : %s",
	WarnPhase		= "%s Phase",--Translate
	SpecWarnMark	= "%s : %s"
})

L:SetTimerLocalization({
	TimerMark	= "Next %s : %s"--Translate
})

L:SetOptionLocalization({
	WarnMark		= "Объявить знаки",
	WarnPhase		= "Объявить фазы",
	SpecWarnMark	= "Show warning when Marks debuff damage over 100%",--Translate
	TimerMark		= "Show timer for next Marks"--Translate
})

L:SetMiscLocalization({
	Frost		= "Гидросса",
	Nature		= "порчи",
	YellPull	= "Я не позволю вам вмешиваться!"
})

-----------------------
--  The Lurker Below --
-----------------------
L = DBM:GetModLocalization("LurkerBelow")

L:SetGeneralLocalization({
	name = "Скрытень из глубин"
})

L:SetWarningLocalization({
	WarnSubmerge		= "Погружение",
	WarnSubmergeSoon	= "Погружение in 10 sec",--Verify
	WarnEmerge			= "Появление",
	WarnEmergeSoon		= "Появление in 10 sec"--Verify
})

L:SetTimerLocalization({
	TimerSubmerge		= "Погружение",
	TimerEmerge			= "Появление"
})

L:SetOptionLocalization({
	WarnSubmerge		= "Show warning when submerge",--Translate
	WarnSubmergeSoon	= "Show pre-warning for submerge",--Translate
	WarnEmerge			= "Show warning when emerge",--Translate
	WarnEmergeSoon		= "Show pre-warning for emerge",--Translate
	TimerSubmerge		= "Show time for submerge",--Translate
	TimerEmerge			= "Show time for emerge"--Translate
})

L:SetMiscLocalization({
	Spout	= "Скрытень из глубин глубоко вздыхает!"
})

--------------------------
--  Leotheras the Blind --
--------------------------
L = DBM:GetModLocalization("Leotheras")

L:SetGeneralLocalization({
	name = "Леотерас Слепец"
})

L:SetWarningLocalization({
	WarnPhase		= "%s Phase",--Translate
	WarnPhaseSoon	= "%s Phase in 5 sec"--Translate
})

L:SetTimerLocalization({
	TimerPhase	= "Next %s Phase"--Translate
})

L:SetOptionLocalization({
	WarnPhase		= "Show warning for next phase",--Translate
	WarnPhaseSoon	= "Show pre-warning for next phase",--Translate
	TimerPhase		= "Show time for next phase"--Translate
})

L:SetMiscLocalization({
	Human		= "Human",--Translate
	Demon		= "Demon",--Translate
	YellDemon	= "Прочь, жалкий эльф. Настало мое время!",
	YellPhase2	= "Нет... нет! Что вы наделали? Я – главный! Слышишь меня? Я... Ааааах! Мне его... не удержать.",
	YellPull	= "Наконец-то мое заточение окончено!"
})

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
L = DBM:GetModLocalization("Fathomlord")

L:SetGeneralLocalization({
	name = "Повелитель глубин Каратресс"
})

L:SetMiscLocalization({
	Caribdis	= "Fathom-Guard Caribdis",--Translate
	Tidalvess	= "Fathom-Guard Tidalvess",--Translate
	Sharkkis	= "Fathom-Guard Sharkkis",--Translate
	YellPull	= "Стража, к бою! У нас гости..."
})

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetGeneralLocalization({
	name = "Морогрим Волноступ"
})

L:SetWarningLocalization({
	WarnMurlocs		= "Мурлоки",
	SpecWarnMurlocs	= "Мурлоки!"
})

L:SetTimerLocalization({
	TimerMurlocs	= "Мурлоки"
})

L:SetOptionLocalization({
	WarnMurlocs		= "Объявить Мурлоки",
	SpecWarnMurlocs	= "Show special warning when Murlocs spawning",--Translate
	TimerMurlocs	= "Show timer for Murlocs spawning"--Translate
})

L:SetMiscLocalization({
	Grave			= "%s отправляет своих врагов в водяные могилы!",
	Murlocs			= "Сильный толчок землетрясения насторожил мурлоков поблизости!"
})

-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetGeneralLocalization({
	name = "Леди Вайш"
})

L:SetWarningLocalization({
	WarnElemental		= "Нечистый элементаль через 5 секунд (%s)",
	WarnStrider			= "Долгоног через 5 секунд (%s)",
	WarnNaga			= "Нага через 5 секунд (%s)",
	WarnShield			= "Магический барьер - деактивировано %d/4",
	WarnLoot			= ">%s< получил порченую магму",
	SpecWarnElemental	= "Нечистый элементаль через 5 секунд!"
})

L:SetTimerLocalization({
	TimerElemental		= "Нечистый элементаль (%d)",--Verify
	TimerStrider		= "Долгоног (%d)",--Verify
	TimerNaga			= "Нага (%d)"--Verify
})

L:SetOptionLocalization({
	WarnElemental		= "Show pre-warning for next Tainted Elemental",--Translate
	WarnStrider			= "Show pre-warning for next Strider",--Translate
	WarnNaga			= "Show pre-warning for next Naga",--Translate
	WarnShield			= "Show warning for Phase 2 shield down",--Translate
	WarnLoot			= "Объявить наличие порченой магмы",
	TimerElemental		= "Show time for next Tainted Elemental",--Translate
	TimerStrider		= "Show time for next Strider",--Translate
	TimerNaga			= "Show time for next Strider",--Translate
	SpecWarnElemental	= "Show special warning when Tainted Elemental coming",--Translate
	AutoChangeLootToFFA		= "Смена режима добычи на Каждый за себя в фазе 2"
})

L:SetMiscLocalization({
	DBM_VASHJ_YELL_PHASE2				= "Время пришло! Не оставляйте никого в живых!",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
})
