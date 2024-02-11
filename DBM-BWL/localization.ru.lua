if GetLocale() ~= "ruRU" then return end

local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization({
	name = "Бритвосмерт Неукротимый"
})

L:SetTimerLocalization({
	TimerAddsSpawn	= "Появление аддов"
})

L:SetOptionLocalization({
	TimerAddsSpawn	= "Показывать таймер до первого появления аддов"
})

L:SetMiscLocalization({
	Phase2Emote = "убегает, как только сила сферы пошла на спад.",
	YellPull = "Враги в инкубаторе! Бейте тревогу! Защищайте яйца любой ценой!"
})

-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization({
	name = "Валестраз Порочный"
})

L:SetMiscLocalization({
	Event = "Умоляю, смертные! Бегите! Бегите, пока я еще могу себя удержать! Черный огонь бушует в моем сердце! Я должен... дать ему волю!"
})

-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization({
	name = "Предводитель драконов Разящий Бич"
})

L:SetMiscLocalization({
	Pull = "Таких, как вы, здесь быть не должно! Смерть грозит лишь вам!"
})

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization({
	name = "Огнечрев"
})

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization({
	name = "Черноскал"
})

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization({
	name = "Пламегор"
})

-----------------------
--  Vulnerabilities  --
-----------------------
-- Chromaggus, Death Talon Overseer and Death Talon Wyrmguard
L = DBM:GetModLocalization("TalonGuards")

L:SetGeneralLocalization({
	name = "Стражи Когтя Смерти"
})

L:SetWarningLocalization({
	WarnVulnerable		= "Уязвимость к %s"
})

L:SetOptionLocalization({
	WarnVulnerable		= "Показывать предупреждение об уязвимости к заклинаниям"
})

L:SetMiscLocalization({
	Fire		= "Огню",
	Nature		= "силам Природы",
	Frost		= "магии Льда",
	Shadow		= "Темной магии",
	Arcane		= "Тайной магии",
	Holy		= "Светлой магии"
})

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization({
	name = "Хромаггус"
})

L:SetWarningLocalization({
	WarnBreathSoon	= "Скоро дыхание",
	WarnBreath		= "%s",
	WarnVulnerable	= "Уязвимость к %s",
	WarnPhase2Soon	= "Скоро 2-ая фаза"
})

L:SetTimerLocalization({
	TimerBreathCD	= "%s восстановление",
	TimerBreath		= "Применение %s",
	TimerVulnCD		= "Восстановление уязвимости"
})

L:SetOptionLocalization({
	WarnBreathSoon	= "Предварительное предупреждение Дыхания Хромаггуса",
	WarnBreath		= "Показывать предупреждение о дыханиях Хромаггуса",
	WarnVulnerable	= "Показывать предупреждение об уязвимости к заклинаниям",
	TimerBreathCD	= "Показывать время восстановления дыханий",
	TimerBreath		= "Показывать применение Дыхания",
	TimerVulnCD		= "Показывать восстановление уязвимости",
	WarnPhase2Soon	= "Предупреждать о второй фазе"
})

L:SetMiscLocalization({
	Breath1		= "Первое Дыхание",
	Breath2		= "Второе Дыхание",
	VulnEmote	= "%s изменяется, мерцая.",
	Vuln		= "Уязвимость",
	Fire		= "Огню",
	Nature		= "силам Природы",
	Frost		= "магии Льда",
	Shadow		= "Темной магии",
	Arcane		= "Тайной магии",
	Holy		= "Светлой магии"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization({
	name = "Нефариан"
})

L:SetWarningLocalization({
	WarnAddsLeft		= "Осталось %d убийств",
	WarnClassCallSoon	= "Скоро вызов класса",
	WarnClassCall		= "Дебафф на %s",
	WarnPhaseSoon		= "Скоро фаза %s",
	WarnPhase			= "Фаза %s",
	specwarnClassCall	= "Классовый зов на тебе!"
})

L:SetTimerLocalization({
	TimerClassCall		= "%s зов заканчивается"
})

L:SetOptionLocalization({
	TimerClassCall		= "Показывать таймер классовых вызовов",
	WarnClassCallSoon	= "Предупреждение классовых вызовов",
	WarnClassCall		= "Объявлять классовый вызов",
	WarnPhaseSoon		= "Объявлять, когда следующая фаза скоро начнется",
	WarnPhase			= "Объявлять смену фаз",
	specwarnClassCall	= "Показывать специальное предупреждение, когда вы подвержены классовому зову"
})

L:SetMiscLocalization({
	YellP1		= "Пусть состязания начнутся!",
	YellP2		= "Браво, слуги мои! Смертные утрачивают мужество! Поглядим же, как они справятся с истинным владыкой Черной горы!!!",
	YellP3		= "Не может быть! Восстаньте, мои прислужники! Послужите господину еще раз!",
	YellShaman	= "Шаманы, покажите, на что способны ваши тотемы!",
	YellPaladin	= "Паладины... Я слышал, у вас несколько жизней. Докажите.",
	YellDruid	= "Друиды и их дурацкие превращения... Ну что ж, поглядим!",
	YellPriest	= "Жрецы! Если вы собираетесь продолжать так лечить, то давайте хоть немного разнообразим процесс!",
	YellWarrior	= "Я знаю, воины, вы можете бить сильнее! Ну-ка, покажите!",
	YellRogue = "Разбойники? Хватит прятаться, покажитесь!",
	YellWarlock	= "Чернокнижники, ну не беритесь вы за волшебство, которого сами не понимаете! Видите, что получилось?",
	YellHunter	= "Охотники со своими жалкими пугачами!",
	YellMage	= "И маги тоже? Осторожнее надо быть, когда играешь с магией...",
	YellDK		= "Рыцари смерти! Сюда!"
})
