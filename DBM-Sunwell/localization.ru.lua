if GetLocale() ~= "ruRU" then return end
local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")

L:SetGeneralLocalization({
	name = "Калесгос"
})

L:SetWarningLocalization({
	WarnPortal			= "Портал #%d : >%s< (Группа %d)",
	SpecWarnWildMagic	= "Дикая магия - %s!"
})

L:SetOptionLocalization({
	WarnPortal			= "Показывать предупреждение для цели $spell:46021",
	SpecWarnWildMagic	= "Показывать спец-предупреждение для Дикой Магии",
	ShowRespawn			= "Отсчет времени до появления босса после вайпа",
	ShowFrame			= "Показать фрейм Призрачного мира",
	FrameClassColor		= "Использовать цвета классов в фрейме Призрачного мира",
	FrameUpwards		= "Рост фрейма Призрачного мира ВВЕРХ",
	FrameLocked			= "Зафиксировать фрейм Призрачного мира"
})

L:SetMiscLocalization({
	Demon				= "Сатроварр Осквернитель",
	Heal				= "+100% хила",
	Haste				= "+100% касттайм",
	Hit					= "-50% меткости",
	Crit				= "+100% крит урон",
	Aggro				= "+100% угрозы",
	Mana				= "-50% исп маны",
	FrameTitle			= "Призрачный мир",
	FrameLock			= "Закрепить рамку",
	FrameClassColor		= "Использовать цвета классов",
	FrameOrientation	= "Рост вверх",
	FrameHide			= "Скрыть рамку",
	FrameClose			= "Закрыть",
	FrameGUIMoveMe		= "Передвинь меня"
})

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization({
	name = "Бруталл"
})

L:SetOptionLocalization({
	RangeFrameActivation= "Активация рамки диапазона",
	AlwaysOn			= "В начале встречи. Игнорирует фильтр",
	OnDebuff			= "При дебаффе. Применяет фильтр дебаффа"
})

L:SetMiscLocalization({
	Pull			= "Аа, новые овечки на заклание?"
})

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization({
	name = "Пророк Скверны"
})

L:SetWarningLocalization({
	WarnPhase		= "%s фаза"
})

L:SetTimerLocalization({
	TimerPhase		= "Следующая %s фаза"
})

L:SetOptionLocalization({
	WarnPhase		= "Показывать предупреждение для следующей фазы",
	TimerPhase		= "Показывать таймер фаз"
})

L:SetMiscLocalization({
	Air				= "воздушная",
	Ground			= "наземная",
	AirPhase		= "Я сильнее, чем когда-либо прежде!",
	Breath			= "%s глубоко вдыхает."
})

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name = "Близнецы"
})

L:SetMiscLocalization({
	NovaWhisper		= "Кольцо тьмы на тебе!",
	ConflagWhisper	= "Воспламенение на тебе!",
	Nova			= "заклинание Кольцо Тьмы на",
	Conflag			= "направляет \"Воспламенение\" на",
})

------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization({
	name = "М'ууру"
})

L:SetWarningLocalization({
	WarnHuman		= "Адды-гуманоиды (%d)",
	WarnHumanSoon	= "Адды-гуманоиды in 5 sec (%d)",
	WarnVoid		= "Часовой Бездны (%d)",
	WarnVoidSoon	= "Часовой Бездны через 5 сек. (%d)",
	WarnFiend		= "Появился череп - рассейте",
	specWarnVoid	= "Мрак - РАССЕЙТЕ ЧЕРЕПА!",
	specWarnBH		= "Черная дыра - РАССЕЙТЕ ЧЕРЕПА!",
	specWarnVW		= "Часовой Бездны через 5",
	specWarnDarknessSoon = "Скоро Мрак"
})

L:SetTimerLocalization({
	TimerHuman		= "Адды-гуманоиды (%s)",
	TimerVoid		= "Часовой Бездны (%s)",
	TimerPhase		= "Энтропий"
})

L:SetOptionLocalization({
	WarnHuman		= "Показывать предупреждение для аддов-гуманоидов",
	WarnHumanSoon	= "Предупреждать заранее(5 сек) об аддах-гуманоидах",
	WarnVoid		= "Показывать предупреждение для Часовых Бездны",
	WarnVoidSoon	= "Предупреждать заранее(5 сек) о Часовых Бездны",
	WarnFiend		= "Показывать предупреждение для рассеивания черепов на 2 фазе",
	specWarnVoid	= "Показывать спец-предупреждение для Мрака(рассеивания)",
	specWarnBH		= "Показывать спец-предупреждение для черной дыры(рассеивания)",
	specWarnVW		= "Показывать спец-предупреждение перед Часовым Бездны",
	specWarnDarknessSoon = "Показывать спец-предупреждение перед Мраком",
	TimerHuman		= "Показывать таймер аддов-гуманоидов",
	TimerVoid		= "Показывать таймер Часовых Бездны",
	TimerPhase		= "Показывать таймер перехода во 2 фазу"
})

L:SetMiscLocalization({
	Entropius		= "Энтропий"
})

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization({
	name = "Кил'джеден"
})

L:SetWarningLocalization({
	WarnDarkOrb		= "Появились темные сферы",
	WarnBlueOrb		= "Активировалась сфера дракона",
	SpecWarnDarkOrb	= "Темные сферы!",
	SpecWarnBlueOrb	= "СФера Дракона активировалась!"
})

L:SetTimerLocalization({
	TimerBlueOrb	= "Активация сферы дракона",
	TimerDarkOrb	= "Темные сферы!"
})

L:SetOptionLocalization({
	WarnDarkOrb		= "Показывать предупреждение для Темных Сфер",
	WarnBlueOrb		= "Показывать предупреждение для активации Сфер Дракона",
	SpecWarnDarkOrb	= "Спец-предупреждение для Темных Сфер",
	SpecWarnBlueOrb	= "Спец-предупреждение для активации Сфер Дракона",
	TimerBlueOrb	= "Показать таймер активации Сфер Дракона",
})

L:SetMiscLocalization({
	YellPull		= "Те, кем можно было пожертвовать, мертвы. Так тому и быть! Я добьюсь успеха там, где Саргерас потерпел поражение! Я заставлю этот жалкий мирок истекать кровью и навеки закреплю за собой место повелителя Пылающего Легиона! Пробил последний час этого мира!",
	OrbYell1		= "Я наполню сферы своей энергией! Готовьтесь!",
	OrbYell2		= "Я наполнил энергией еще одну сферу! Быстрее используйте ее!",
	OrbYell3		= "Готова еще одна сфера! Торопитесь!",
	OrbYell4		= "Я отдал все, что мог. Моя энергия в ваших руках!"
})
