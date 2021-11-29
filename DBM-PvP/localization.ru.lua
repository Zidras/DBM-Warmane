if GetLocale() ~= "ruRU" then return end

local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name = "Общие параметры"
})

L:SetTimerLocalization({
	TimerFlag		= "Флаг восстановлен",
	TimerShadow		= "Сумеречное зрение",
	TimerStart		= "Битва начнется через",
	TimerWin		= "Победа в"
})

L:SetOptionLocalization({
	AutoSpirit			= "Автоматически покидать тело",
	ColorByClass		= "Показывать имена цветом класса в таблице очков",
	HideBossEmoteFrame	= "Скрыть фрейм эмоций рейдового босса",
	ShowBasesToWin		= "Отображать базы, которые необходимо захватить",
	ShowEstimatedPoints	= "Отображать предполагаемые очки оставшиеся до победы/поражения",
	ShowFlagCarrier		= "Показать флагоносца",
	ShowRelativeGameTime= "Заполните таймер победы относительно времени начала поля боя (если он отключен, панель всегда выглядит заполненной)",
	TimerCap			= "Отсчет времени до захвата",
	TimerFlag			= "Отсчет времени до восстановления флага",
	TimerShadow			= "Отсчет времени для Сумрачного зрения",
	TimerStart			= "Отсчет времени до начала битвы",
	TimerWin			= "Отсчет времени до победы"
})

L:SetMiscLocalization({
--	BgStart60			= "Битва начнется через 1 минуту.",
--	BgStart30			= "Битва начнется через 30 секунд. Приготовиться!",
	ArenaInvite			= "Приглашение на Арену",
--	Start60				= "Одна минута до начала боя на арене!",
--	Start30				= "Битва на Арене начнется через 30 секунд!",
--	Start15				= "Пятнадцать секунд до начала схватки на арене!",
	BasesToWin			= "Захвачено баз: %d",
	WinBarText			= "Победа %s",
	Flag				= "Флаг",
--	FlagReset			= "Флаг возвращен на базу.",
--	FlagTaken			= "(.+) захватывает флаг!",
--	FlagCaptured		= "(.+) захватил флаг!",
--	FlagDropped			= "Флаг уронили!",
--	ExprFlagPickUp		= "(.+) несет флаг (%w+)!",
--	ExprFlagCaptured	= "(.+) захватывает флаг (%w+)!",
--	ExprFlagReturn		= "(.+) возвращает на базу флаг (%w+)!",
	Vulnerable1			= "Персонажи, несущие флаг, стали более уязвимы!",
	Vulnerable2			= "Персонажи, несущие флаг, стали еще более уязвимы!"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "Альтеракская долина"
})

L:SetOptionLocalization({
	AutoTurnIn	= "Автоматическая сдача заданий"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "Низина Арати"
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "Око Бури"
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "Ущелье Песни Войны"
})

------------------------------
--  Strand of the Ancients  --
------------------------------
L = DBM:GetModLocalization("StrandoftheAncients")

L:SetGeneralLocalization({
	name = "Берег Древних"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "Остров Завоеваний"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "Осадная машина готова!",
	WarnSiegeEngineSoon	= "Осадная машина через ~10 сек"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "Осадная машина готова"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "Отсчет времени до создания Осадной машины",
	WarnSiegeEngine		= "Предупреждение, когда создание Осадной машины завершено",
	WarnSiegeEngineSoon	= "Предупреждение, когда создание Осадной машины почти завершено",
	ShowGatesHealth		= "Отображать здоровье поврежденых ворот (значение здоровья может быть некорректным после захода в уже начавшееся поле боя!)"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "Поврежденные ворота",
	SiegeEngine				= "Осадная машина",
	GoblinStartAlliance		= "Видите эти взрывчатые бомбы? Используйте их на воротах, пока я ремонтирую осадную машину!",
	GoblinStartHorde		= "Я буду работать над осадной машиной, я ты меня прикрывай. Вот, можешь пользоваться этими сефориевыми бомбами, если тебе надо взорвать ворота.",
	GoblinHalfwayAlliance	= "Я на полпути! Держите Орду подальше отсюда. В инженерном училище не учат боевым действиям!",
	GoblinHalfwayHorde		= "Я примерно на полпути! Держите Альянс подальше - драки не в моем контракте!",
	GoblinFinishedAlliance	= "Моя лучшая работа на данный момент! Эта осадная машина готова к действию!",
	GoblinFinishedHorde		= "Осадная машина готова к работе!",
	GoblinBrokenAlliance	= "Он уже сломан?! Не стоит беспокоиться. Я ничего не могу исправить.",
	GoblinBrokenHorde		= "Опять сломано?! Я исправлю это ... только не ожидайте, что гарантия покроет это."
})