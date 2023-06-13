if GetLocale() ~= "ruRU" then return end

local L

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization({
	name = "Ловчий Аттумен"
})



--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization({
	name = "Мороуз"
})

L:SetWarningLocalization({
	DBM_MOROES_VANISH_FADED	= "Исчезновение рассеивается"
})

L:SetOptionLocalization({
	DBM_MOROES_VANISH_FADED	= "Показывать предупреждение рассеивания исчезновения"
})

-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization({
	name = "Благочестивая дева"
})

-- Romulo and Julianne
L = DBM:GetModLocalization("RomuloAndJulianne")

L:SetGeneralLocalization({
	name = "Ромуло и Джулианна"
})

L:SetMiscLocalization({
	Event				= "Сегодня... мы увидим историю любви!",
	RJ_Pull				= "Что ты за дьявол, что меня так мучишь?",
	DBM_RJ_PHASE2_YELL	= "Приди же, ласковая ночь, верни мне моего Ромуло!",
	Romulo				= "Ромуло",
	Julianne			= "Джулианна"
})

-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization({
	name = "Злой и страшный серый волк"
})



L:SetMiscLocalization({
	DBM_BBW_YELL_1			= "Кем бы мне тут закусить?"
})

-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization({
	name = "Страна Оз"
})

L:SetWarningLocalization({
	DBM_OZ_WARN_TITO		= "Тито",
	DBM_OZ_WARN_ROAR		= "Хохотун",
	DBM_OZ_WARN_STRAWMAN	= "Балбес",
	DBM_OZ_WARN_TINHEAD		= "Медноголовый",
	DBM_OZ_WARN_CRONE		= "Ведьма"
})

L:SetTimerLocalization({
	DBM_OZ_WARN_TITO		= "Тито",
	DBM_OZ_WARN_ROAR		= "Хохотун",
	DBM_OZ_WARN_STRAWMAN	= "Балбес",
	DBM_OZ_WARN_TINHEAD		= "Медноголовый"
})

L:SetOptionLocalization({
	AnnounceBosses			= "Показывать предупреждения появления босса",
	ShowBossTimers			= "Показывать таймер появления босса"
})

L:SetMiscLocalization({
	DBM_OZ_YELL_DOROTHEE	= "Тито, мы просто обязаны найти дорогу домой! Старый волшебник – наша единственная надежда. Пугало, Рычун, Нержавей, вы... ой, к нам кто-то пришел!",
	DBM_OZ_YELL_ROAR		= "Я вас не боюсь! Совсем! Хотите сражаться? Хотите, да? Ну же! Я буду драться, даже если мне свяжут лапы за спиной!",
	DBM_OZ_YELL_STRAWMAN	= "И что же мне с вами делать? Никак не соображу.",
	DBM_OZ_YELL_TINHEAD		= "Мне очень нужно сердце. Может, забрать твое?",
	DBM_OZ_YELL_CRONE		= "Горе вам, всем и каждому, мои крошки!"
})

-- Curator
L = DBM:GetModLocalization("Curator")

L:SetGeneralLocalization({
	name = "Смотритель"
})

L:SetWarningLocalization({
	warnAdd		= "Адд появился"
})

L:SetOptionLocalization({
	warnAdd		= "Показывать предупреждение когда адд появился"
})

-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization({
	name = "Терестиан Больное Копыто"
})

L:SetMiscLocalization({
	Kilrek					= "Кил'рек",
	DChains					= "Демонические цепи"
})

-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization({
	name = "Тень Арана"
})

L:SetWarningLocalization({
	DBM_ARAN_DO_NOT_MOVE	= "Венец пламени - Не двигайтесь!"
})

L:SetTimerLocalization({
	timerSpecial			= "Особая способность КД"
})

L:SetOptionLocalization({
	timerSpecial			= "Показывать таймер перезарядки особой способности",
	DBM_ARAN_DO_NOT_MOVE	= "Показывать особое предупреждение для $spell:30004"
})

--Netherspite
L = DBM:GetModLocalization("Netherspite")

L:SetGeneralLocalization({
	name = "Гнев Пустоты"
})

L:SetWarningLocalization({
	warningPortal			= "Фаза Порталов",
	warningBanish			= "Фаза Изгнания"
})

L:SetTimerLocalization({
	timerPortalPhase	= "Фаза Порталов заканчивается",
	timerBanishPhase	= "Фаза Изгнания заканчивается"
})

L:SetOptionLocalization({
	warningPortal			= "Показывать предупреждение для Фазы Порталов",
	warningBanish			= "Показывать предупреждение для Фазы Изгнания",
	timerPortalPhase		= "Показывать таймер длительности Фазы Порталов",
	timerBanishPhase		= "Показывать таймер длительности Фазы Изгнания"
})

L:SetMiscLocalization({
	DBM_NS_EMOTE_PHASE_2	= "%s впадает в предельную ярость!",
	DBM_NS_EMOTE_PHASE_1	= "%s издает крик, отступая, открывая путь Пустоте."
})

--Chess
L = DBM:GetModLocalization("Chess")

L:SetGeneralLocalization({
	name = "Шахматы"
})

L:SetTimerLocalization({
	timerCheat	= "Жульничество КД"
})

L:SetOptionLocalization({
	timerCheat	= "Показывать таймер перезарядки Жульничества"
})

L:SetMiscLocalization({
	EchoCheats	= "Эхо Медива жульничает!"
})

--Prince Malchezaar
L = DBM:GetModLocalization("Prince")

L:SetGeneralLocalization({
	name = "Принц Малчезар"
})

L:SetMiscLocalization({
	DBM_PRINCE_YELL_P2		= "Глупцы! Время – это огонь, сжигающий вас!",
	DBM_PRINCE_YELL_P3		= "Как вы осмелились бросить вызов столь колоссальной мощи?",
	DBM_PRINCE_YELL_INF1	= "Мне открыты все реальности, все измерения!",
	DBM_PRINCE_YELL_INF2	= "Вы противостоите не только Малчезару, но и всем подвластным мне легионам!"
})

-- Nightbane
L = DBM:GetModLocalization("NightbaneRaid")

L:SetGeneralLocalization({
	name = "Ночная Погибель (Рейд)"
})

L:SetWarningLocalization({
	DBM_NB_AIR_WARN			= "Воздушная Фаза"
})

L:SetTimerLocalization({
	timerAirPhase			= "Воздушная Фаза"
})

L:SetOptionLocalization({
	DBM_NB_AIR_WARN			= "Показывать предупреждение Воздушной Фазы",
	timerAirPhase			= "Показывать таймер длительности Воздушной Фазы"
})

L:SetMiscLocalization({
	DBM_NB_EMOTE_PULL		= "Древнее существо пробуждается вдалеке...",
	DBM_NB_YELL_AIR			= "Жалкие букашки! Я изжарю вас с воздуха!",
	DBM_NB_YELL_GROUND		= "Довольно! Я сойду на землю и сам раздавлю тебя!",
	DBM_NB_YELL_GROUND2		= "Ничтожества! Я вам покажу мою силу поближе!"
})

-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization({
	name = "Шадикит Скользящий"
})

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization({
	name = "Хиакисс Скрытень"
})

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization({
	name = "Рокад Опустошитель"
})
