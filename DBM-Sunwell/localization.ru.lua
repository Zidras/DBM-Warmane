if GetLocale() ~= "ruRU" then return end
local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")
DBM_CORE_L.AUTO_RANGE_OPTION_TEXT = "Показывать окно проверки дистанции (%s м) для $spell:%s"
L:SetGeneralLocalization{
	name = "Калесгос"
}

L:SetWarningLocalization{
	WarnPortal			= "Портал #%d : >%s< (Группа %d)",
	SpecWarnWildMagic	= "Дикая магия - %s!"
}

L:SetTimerLocalization{
	TimerNextPortal		= "Портал (%d)"
}

L:SetOptionLocalization{
	WarnPortal			= "Показывать предупреждение для цели $spell:46021",
	SpecWarnWildMagic	= "Показывать спец-предупреждение для Дикой Магии",
	TimerNextPortal		= "Показывать таймер портала",
	RangeFrame			= "Показывать окно проверки дистанции (10 м)",
	ShowFrame			= "Показать фрейм Призрачного мира",
	FrameClassColor		= "Использовать цвета классов в фрейме Призрачного мира",
	FrameUpwards		= "Рост фрейма Призрачного мира ВВЕРХ",
	FrameLocked			= "Зафиксировать фрейм Призрачного мира"
}

L:SetMiscLocalization{
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
	FrameClose			= "Закрыть"
}

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization{
	name = "Бруталл"
}

L:SetOptionLocalization{
	BurnIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(46394),
	RangeFrame		= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(4, 46394),
	BurnWhisper		= "Шепот целям заклинания $spell:46394 (нужен РЛ)"
}

L:SetMiscLocalization{
	Pull			= "Аа, новые овечки на заклание?",
	BurnWhisper		= "Огонь на тебе!"
}

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization{
	name = "Пророк Скверны"
}

L:SetWarningLocalization{
	WarnPhase		= "%s фаза",
	WarnPhaseSoon	= "%s фаза через 10 сек",
	WarnBreath		= "Глубокий Вздох (%d)"
}

L:SetTimerLocalization{
	TimerPhase		= "Следующая %s фаза",
	TimerBreath		= "Глубокий Вздох"
}

L:SetOptionLocalization{
	WarnPhase		= "Показывать предупреждение для следующей фазы",
	WarnPhaseSoon	= "Предупреждать заранее(10сек) о следующей фазе",
	WarnBreath		= "Показывать предупреждение для Глубокого Вздоха",
	TimerPhase		= "Показывать таймер фаз",
	TimerBreath		= "Показывать время до восстановления Глубокого Вздоха",
	VaporIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(45392),
	EncapsIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(45665),
	YellOnEncaps	= "Кричать когда на вас $spell:45665"
}

L:SetMiscLocalization{
	Air				= "воздушная",
	Ground			= "наземная",
	AirPhase		= "Я сильнее, чем когда-либо прежде!",
	Breath			= "%s глубоко вдыхает."
}

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "Близнецы"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	NovaIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(45329),
	ConflagIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(45333),
	RangeFrame		= "Показывать окно проверки дистанции (10 м)",
	NovaWhisper		= "Шепот целям заклинания $spell:45329 target (нужен РЛ)",
	ConflagWhisper	= "Шепот целям заклинания $spell:45333 target (нужен РЛ)",
}

L:SetMiscLocalization{
	NovaWhisper		= "Кольцо тьмы на тебе!",
	ConflagWhisper	= "Воспламенение на тебе!",
	Nova			= "Сакролаш начинает накладывать заклинание Кольцо Тьмы на (.+)%.",--Verify
	Conflag			= 'Алайтесс воздействует на (.+)% заклинанием "Воспламенение".'--Verify
}

------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization{
	name = "М'ууру"
}

L:SetWarningLocalization{
	WarnHuman		= "Адды-гуманоиды (%d)",
	WarnHumanSoon	= "Адды-гуманоиды in 5 sec (%d)",
	WarnVoid		= "Часовой Бездны (%d)",
	WarnVoidSoon	= "Часовой Бездны через 5 сек. (%d)",
	WarnFiend		= "Появился череп - рассейте",
	specWarnVoid	= "Мрак - РАССЕЙТЕ ЧЕРЕПА!",
	specWarnBH		= "Черная дыра - РАССЕЙТЕ ЧЕРЕПА!",
	specWarnVW		= "Часовой Бездны через 5",
	specWarnDarknessSoon = "Скоро Мрак"
}

L:SetTimerLocalization{
	TimerHuman		= "Адды-гуманоиды (%s)",
	TimerVoid		= "Часовой Бездны (%s)",
	TimerPhase		= "Энтропий"
}

L:SetOptionLocalization{
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
	TimerPhase		= "Показывать таймер перехода во 2 фазу",
	SoundWarnCountingDS = "Проигрывать звуковой отсчет 5...1 до Мрака",
}

L:SetMiscLocalization{
	Entropius		= "Энтропий"
}

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization{
	name = "Кил'джеден"
}

L:SetWarningLocalization{
	WarnDarkOrb		= "Появились темные сферы",
	WarnBlueOrb		= "Активировалась сфера дракона",
	SpecWarnDarkOrb	= "Темные сферы!",
	SpecWarnBlueOrb	= "СФера Дракона активировалась!"
}

L:SetTimerLocalization{
	TimerBlueOrb	= "Активация сферы дракона",
	TimerDarkOrb	= "Темные сферы!"
}

L:SetOptionLocalization{
	WarnDarkOrb		= "Показывать предупреждение для Темных Сфер",
	WarnBlueOrb		= "Показывать предупреждение для активации Сфер Дракона",
	SpecWarnDarkOrb	= "Спец-предупреждение для Темных Сфер",
	SpecWarnBlueOrb	= "Спец-предупреждение для активации Сфер Дракона",
	TimerBlueOrb	= "Показать таймер активации Сфер Дракона",
	RangeFrame		= "Показывать окно проверки дистанции (10 м)",
	BloomIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(45641),
	YellOnBloom		= "Кричать при $spell:45641",
	BloomWhisper	= "Шепот целям заклинания $spell:45641 (нужен РЛ)"
}

L:SetMiscLocalization{
	YellPull		= "Те, кем можно было пожертвовать, мертвы. Так тому и быть! Я добьюсь успеха там, где Саргерас потерпел поражение! Я заставлю этот жалкий мирок истекать кровью и навеки закреплю за собой место повелителя Пылающего Легиона! Пробил последний час этого мира!",
	YellBloom		= "Огненный цветок на мне!",
	BloomWhisper	= "Огненный цветок на тебе!",
	OrbYell1		= "Я наполню сферы своей энергией! Готовьтесь!",
	OrbYell2		= "Я наполнил энергией еще одну сферу! Быстрее используйте ее!",
	OrbYell3		= "Готова еще одна сфера! Торопитесь!",
	OrbYell4		= "Я отдал все, что мог. Моя энергия в ваших руках!",
	ReflectionYell1	= "Кому можно доверять?",
	ReflectionYell2 = "Враг среди вас!"
}
