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
	ShowGatesHealth		= "Отображать здоровье поврежденых ворот (значение здоровья может быть некорректным после захода в уже начавшееся поле боя!)",
	ShowRelativeGameTime= "Заполните таймер победы относительно времени начала поля боя (если он отключен, панель всегда выглядит заполненной)",
	TimerCap			= "Отсчет времени до захвата",
	TimerFlag			= "Отсчет времени до восстановления флага",
	TimerShadow			= "Отсчет времени для Сумрачного зрения",
	TimerStart			= "Отсчет времени до начала битвы",
	TimerWin			= "Отсчет времени до победы"
})

L:SetMiscLocalization({
	--BG 2 minutes
	BgStart120TC		= "Битва начнется через 2 минуты!",
	--BG 1 minute
	BgStart60TC			= "Битва начнется через минуту!",
	BgStart60OLD		= "Битва начнется через 60 секунд.",
	BgStart60AlteracTC	= "До начала сражения за Альтеракскую долину остается 1 минута.",
	BgStart60SotAOLD	= "Сражение за Берег Древних начнется через 1 минуту.",
	BgStart60SotA2TC	= "Второй раунд сражения за Берег Древних начнется через 1 минуту.",
	BgStart60WarsongTC	= "Битва за Ущелье Песни Войны начнется через 1 минуту.",
	BgStart60ArathiOLD	= "Битва за Низину Арати начнется через минуту.",
	-- BG 30 seconds
	BgStart30TC			= "Битва начнется через 30 секунд!",
	BgStart30OLD		= "Битва начнется через 30 секунд.",
	BgStart30AlteracTC	= "30 секунд до начала битвы в Альтеракской долине.",
	BgStart30SotAOLD	= "Сражение за Берег Древних начнется через 30 секунд. Готовьтесь!",
	BgStart30SotA2TC	= "Второй раунд начинается через 30 секунд. Приготовьтесь!",
	BgStart30WarsongTC	= "Битва за Ущелье Песни Войны начнется через 30 секунд. Приготовиться!",
	BgStart30ArathiOLD	= "Битва за Низину Арати начнется через 30 секунд.",
	--
	ArenaInvite			= "Приглашение на Арену",
	Start60TC			= "Одна минута до начала боя на арене!",
	Start30TC			= "Тридцать секунд до начала боя на арене !",
	Start15TC			= "Пятнадцать секунд до начала боя на арене!",
	BasesToWin			= "Захвачено баз: %d",
	WinBarText			= "Победа %s",
	-- Flag carrying system
	Flag				= "Флаг",
	FlagResetTC			= "Флаг возвращен на базу.",
	FlagTakenTC			= "(.+) захватывает флаг!",
	FlagCapturedTC		= ".+ захватил.* флаг!",
	FlagDroppedTC		= "Флаг уронили!",
	--
	ExprFlagPickUpATC	= "Флаг Альянса у |3-1((.+))!",
	ExprFlagPickUpHTC	= "(.+) несет флаг Орды!",
	ExprFlagCapturedTC	= "(.+) захватывает флаг .+!",
	ExprFlagReturnTC	= "(.+) возвращает на базу флаг .+!",
	ExprFlagDroppedTC	= "(.+) роняет флаг .+!",
	Vulnerable1			= "Персонажи, несущие флаг, стали более уязвимы!",
	Vulnerable2			= "Персонажи, несущие флаг, стали еще более уязвимы!",
	-- Alterac/IsleOfConquest bosses
	InfoFrameHeader		= "Здоровье босса",
	HordeBoss			= "Босс Орды",
	AllianceBoss		= "Босс Альянса",
	Galvangar			= "Гальвангар",
	Balinda				= "Балинда",
	Ivus				= "Ивус",
	Lokholar			= "Локолар",
	-- Gates
	GatesHealthFrame				= "Поврежденные ворота",
	HordeGateFront					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t Главные врата",
	HordeGateFrontDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t Главные врата",
	HordeGateWest					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t Западные врата",
	HordeGateWestDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t Западные врата",
	HordeGateEast					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t Восточные врата",
	HordeGateEastDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t Восточные врата",
	AllianceGateFront				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t Главные врата",
	AllianceGateFrontDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t Главные врата",
	AllianceGateWest				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t Западные врата",
	AllianceGateWestDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t Западные врата",
	AllianceGateEast				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t Восточные врата",
	AllianceGateEastDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t Восточные врата",
	-- Strands of the Ancients Gates emotes
	GreenEmeraldAttacked			= "Врата Зеленого Изумруда подверглись нападению!",
	GreenEmeraldDestroyed			= "Врата Зеленого Изумруда разрушены!",
	BlueSapphireAttacked			= "Врата Синего Сапфира подверглись нападению!",
	BlueSapphireDestroyed			= "Врата Синего Сапфира разрушены!",
	PurpleAmethystAttacked			= "Врата Лилового Аметиста подверглись нападению!",
	PurpleAmethystDestroyed			= "Врата Лилового Аметиста разрушены!",
	RedSunAttacked					= "Врата Красного Солнца подверглись нападению!",
	RedSunDestroyed					= "Врата Красного Солнца разрушены!",
	YellowMoonAttacked				= "Врата Желтой Луны подверглись нападению!",
	YellowMoonDestroyed				= "Врата Желтой Луны разрушены!",
	ChamberAncientRelicsAttacked	= "Крепость атакуют!",
	ChamberAncientRelicsDestroyed	= "В стене пролом! Реликвии грозит опасность!",
	-- Isle of Conquest Gates CHAT_MSG_BG_SYSTEM_NEUTRAL messages
	HordeGateFrontDestroyedTC		= "Главные врата крепости Орды разрушены!",
	HordeGateWestDestroyedTC		= "Западные врата крепости Орды разрушены!",
	HordeGateEastDestroyedTC		= "Восточные врата крепости Орды разрушены!",
	AllianceGateFrontDestroyedTC	= "Главные врата крепости Альянса разрушены!",
	AllianceGateWestDestroyedTC		= "Западные врата крепости Альянса разрушены!",
	AllianceGateEastDestroyedTC		= "Восточные врата крепости Альянса разрушены!",
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
	WarnSiegeEngineSoon	= "Предупреждение, когда создание Осадной машины почти завершено"
})

L:SetMiscLocalization({
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
