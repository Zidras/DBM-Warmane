if GetLocale() ~= "ruRU" then return end

local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization({
	name = "Пророк Скерам"
})

L:SetMiscLocalization({
	YellKillSkeram = "Вы лишь откладываете неизбежное!"
})

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization({
	name = "Семейство жуков"
})

L:SetMiscLocalization({
	Yauj = "Принцесса Яудж",
	Vem = "Вем",
	Kri = "Лорд Кри"
})

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization({
	name = "Боевой страж Сартура"
})

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization({
	name = "Фанкрисс Непреклонный"
})

--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization({
	name = "Нечистотон"
})

L:SetWarningLocalization({
	WarnFreeze	= "Заморожен: %d/3",
	WarnShatter	= "Расколот: %d/3"
})

L:SetOptionLocalization({
	WarnFreeze	= "Объявлять статус Заморозки",
	WarnShatter	= "Объявлять статус Раскола"
})

L:SetMiscLocalization({
	Slow		= "замедляется!",
	Freezing	= "замораживается!",
	Frozen		= "застывает!",
	Phase4		= "начинает раскалываться!",
	Phase5		= "едва держится!",
	Phase6		= "взрывается!",

	HitsRemain	= "Ударов Осталось",
	Frost		= "Лёд",
	Physical	= "Физический урон"
})

-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization({
	name = "Принцесса Хухуран"
})

---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization({
	name = "Императоры-близнецы"
})

L:SetMiscLocalization({
	Veklor = "Император Век'лор",
	Veknil = "Император Век'нилаш"
})

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization({
	name = "К'Тун"
})

L:SetWarningLocalization({
	WarnEyeTentacle	= "Глазной отросток",
	WarnClawTentacle2	= "Когтещупальце",
	WarnGiantEyeTentacle	= "Огромное глазастое щупальце",
	WarnGiantClawTentacle	= "Гигантский когтещуп",
	WarnWeakened		= "К'Тун ослаблен!"
})

L:SetTimerLocalization({
	TimerEyeTentacle	= "Глазной отросток",
	TimerGiantEyeTentacle	= "Огромное глазастое щупальце",
	TimerClawTentacle	= "Когтещупальце",
	TimerGiantClawTentacle	= "Гигантский когтещуп",
	TimerWeakened		= "Ослаблен закончен"
})

L:SetOptionLocalization({
	WarnEyeTentacle			= "Показывать предупреждение для Глазного отростка",
	WarnClawTentacle2		= "Показывать предупреждение для Когтещупальца",
	WarnGiantEyeTentacle	= "Показывать предупреждение для Огромного глазастого щупальца",
	WarnGiantClawTentacle	= "Показывать предупреждение для Гигантского когтещупа",
	SpecWarnWeakened		= "Показывать специальное предупреждение, когда босс ослаблен",
	TimerEyeTentacle		= "Показывать таймер до следующего Глазного отростка",
	TimerClawTentacle		= "Показывать таймер до следующего Когтещупальца",
	TimerGiantEyeTentacle	= "Показывать таймер до следующего Огромного глазастого щупальца",
	TimerGiantClawTentacle	= "Показывать таймер до следующего Гигантского когтещупа",
	TimerWeakened			= "Показывать таймер продолжительности ослабления босса",
	RangeFrame				= "Показывать индикатор расстояния (10)"
})

L:SetMiscLocalization({
	Stomach		= "Живот",
	Eye			= "Око К'Туна",
	FleshTent	= "Мясистое щупальце",--Localized so it shows on frame in users language, not senders
	Weakened	= "ослаблен!",
	NotValid	= "АК40 частично зачищен. %s необязательные боссы остались."
})

----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization({
	name = "Оуро"
})

L:SetWarningLocalization({
	WarnSubmerge		= "Закапывание",
	WarnEmerge			= "Появление"
})

L:SetTimerLocalization({
	TimerSubmerge		= "Закапывание",
	TimerEmerge			= "Появление"
})

L:SetOptionLocalization({
	WarnSubmerge		= "Показывать предупреждение о закапывании",
	TimerSubmerge		= "Показывать таймер до закапывания",
	WarnEmerge			= "Показывать предупреждение о появлении",
	TimerEmerge			= "Показывать таймер до появления"
})

----------------
-- AQ40 Trash --
----------------
L = DBM:GetModLocalization("AQ40Trash")

L:SetGeneralLocalization({
	name = "АК40: Треш"
})
