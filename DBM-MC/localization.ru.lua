if GetLocale() ~= "ruRU" then return end

local L

----------------
--  Lucifron  --
----------------
L = DBM:GetModLocalization("Lucifron")

L:SetGeneralLocalization({
	name = "Люцифрон"
})

----------------
--  Magmadar  --
----------------
L = DBM:GetModLocalization("Magmadar")

L:SetGeneralLocalization({
	name = "Магмадар"
})

----------------
--  Gehennas  --
----------------
L = DBM:GetModLocalization("Gehennas")

L:SetGeneralLocalization({
	name = "Гееннас"
})

------------
--  Garr  --
------------
L = DBM:GetModLocalization("Garr-Classic")

L:SetGeneralLocalization({
	name = "Гарр (Classic)"
})

--------------
--  Geddon  --
--------------
L = DBM:GetModLocalization("Geddon")

L:SetGeneralLocalization({
	name = "Барон Геддон"
})

----------------
--  Shazzrah  --
----------------
L = DBM:GetModLocalization("Shazzrah")

L:SetGeneralLocalization({
	name = "Шаззрах"
})

----------------
--  Sulfuron  --
----------------
L = DBM:GetModLocalization("Sulfuron")

L:SetGeneralLocalization({
	name = "Предвестник Сульфурон"
})

----------------
--  Golemagg  --
----------------
L = DBM:GetModLocalization("Golemagg")

L:SetGeneralLocalization({
	name = "Големагг Испепелитель"
})

-----------------
--  Majordomo  --
-----------------
L = DBM:GetModLocalization("Majordomo")

L:SetGeneralLocalization({
	name = "Мажордом Экзекутус"
})

L:SetTimerLocalization({
	timerShieldCD		= "Следующий Щит"
})

L:SetOptionLocalization({
	timerShieldCD		= "Показывать таймер для следующего Щита (Damage/Reflect)"
})

----------------
--  Ragnaros  --
----------------
L = DBM:GetModLocalization("Ragnaros-Classic")

L:SetGeneralLocalization({
	name = "Рагнарос (Classic)"
})

L:SetWarningLocalization({
	WarnSubmerge		= "Погружение",
	WarnSubmergeSoon	= "Скоро погружение",
	WarnEmerge			= "Появление",
	WarnEmergeSoon		= "Скоро появление"
})

L:SetTimerLocalization({
	TimerCombatStart	= "Начало боя",
	TimerSubmerge		= "Погружение",
	TimerEmerge			= "Появление"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Показывать время до начала боя",
	WarnSubmerge		= "Показывать предупреждение о погружении",
	WarnSubmergeSoon	= "Показывать предварительное предупреждение о погружении",
	TimerSubmerge		= "Показывать время до погружения",
	WarnEmerge			= "Показывать предупреждение о появлении",
	WarnEmergeSoon		= "Показывать предварительное предупреждение о появлении",
	TimerEmerge			= "Показывать время до появления"
})

L:SetMiscLocalization({
	Submerge	= "ПРИДИТЕ, МОИ СЛУГИ! ЗАЩИТИТЕ СВОЕГО ХОЗЯИНА!",
	Submerge2	= "ТЫ НЕ МОЖЕШЬ ПОБЕДИТЬ ЖИВОЙ ЖАР! ПРИДИТЕ, СЛУГИ ОГНЯ! ПРИДИТЕ, ТВОРЕНИЯ НЕНАВИСТИ! ВАШ ГОСПОДИН ПРИЗЫВАЕТ ВАС!",
	Pull		= "Нахальные щенки! Вы сами обрекли себя на смерть! Узрите же Повелителя в гневе!"
})

-----------------
--  MC: Trash  --
-----------------
L = DBM:GetModLocalization("MCTrash")

L:SetGeneralLocalization({
	name = "ОН: Треш"
})
