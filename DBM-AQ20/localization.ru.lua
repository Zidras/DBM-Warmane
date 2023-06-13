if GetLocale() ~= "ruRU" then return end

local L

---------------
-- Kurinnaxx --
---------------
L = DBM:GetModLocalization("Kurinnaxx")

L:SetGeneralLocalization({
	name		= "Куриннакс"
})

------------
-- Rajaxx --
------------
L = DBM:GetModLocalization("Rajaxx")

L:SetGeneralLocalization({
	name		= "Генерал Раджакс"
})

L:SetWarningLocalization({
	WarnWave	= "Волна %s",
})

L:SetOptionLocalization({
	WarnWave	= "Показывать предупреждение о следующей волне"
})

L:SetMiscLocalization({
	Wave1		= "Они пришли. Постарайся не дать себя убить, ",
	Wave12Alt	= "Раджакс, напомни, когда я в последний раз обещал тебя убить?",
	Wave3		= "Час возмездия близок! Да охватит мрак сердца наших врагов!",
	Wave4		= "Мы не будем больше ждать за закрытыми дверьми и каменными стенами! Мы не будем больше отказываться от возмездия! Даже драконы содрогнутся перед нашим гневом!",
	Wave5		= "Пусть наши враги трепещут! Смерть им!",
	Wave6		= "Олений Шлем будет скулить и молить о пощаде, в точности как его сопливый сынок! Тысячелетняя несправедливость сегодня закончится!",
	Wave7		= "Фэндрал! Твой час пробил! Иди же, прячься в изумрудном сне и молись, чтобы мы до тебя не добрались!",
	Wave8		= "Настырная тварь! Я сам тебя убью!"
})

----------
-- Moam --
----------
L = DBM:GetModLocalization("Moam")

L:SetGeneralLocalization({
	name		= "Моам"
})

----------
-- Buru --
----------
L = DBM:GetModLocalization("Buru")

L:SetGeneralLocalization({
	name		= "Буру Ненасытный"
})

L:SetWarningLocalization({
	WarnPursue		= "Преследует >%s<",
	SpecWarnPursue	= "Преследует вас!",
	WarnDismember	= "%s на >%s< (%s)"
})

L:SetOptionLocalization({
	WarnPursue		= "Называть преследуемые цели",
	SpecWarnPursue	= "Показывать специальное предупреждение, когда преследование на вас",
	WarnDismember	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(96)
})

L:SetMiscLocalization({
	PursueEmote	= "%s смотрит на"
})

-------------
-- Ayamiss --
-------------
L = DBM:GetModLocalization("Ayamiss")

L:SetGeneralLocalization({
	name		= "Аямисса Охотница"
})

--------------
-- Ossirian --
--------------
L = DBM:GetModLocalization("Ossirian")

L:SetGeneralLocalization({
	name		= "Оссириан Неуязвимый"
})

L:SetWarningLocalization({
	WarnVulnerable	= "%s"
})

L:SetTimerLocalization({
	TimerVulnerable	= "%s"
})

L:SetOptionLocalization({
	WarnVulnerable	= "Объявлять слабость",
	TimerVulnerable	= "Показывать таймер до слабости"
})

----------------
-- AQ20 Trash --
----------------
L = DBM:GetModLocalization("AQ20Trash")

L:SetGeneralLocalization({
	name = "АК20: Треш"
})
