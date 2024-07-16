if GetLocale() ~= "ruRU" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan-Vanilla")

L:SetGeneralLocalization({
	name = "Ануб'Рекан"
})

L:SetOptionLocalization({
	ArachnophobiaTimer	= "Отсчет времени для Арахнофобия (достижение)"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Арахнофобия",
	Pull1				= "Бегите, бегите! Я люблю горячую кровь!",
	Pull2				= "Посмотрим, какие вы на вкус!"
})

----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina-Vanilla")

L:SetGeneralLocalization({
	name = "Великая вдова Фарлина"
})

L:SetWarningLocalization({
	WarningEmbraceExpire	= "Объятие Вдовы через 5 секунд"
})

L:SetOptionLocalization({
	WarningEmbraceExpire	= "Предупреждение, когда Объятие Вдовы исчезает"
})

---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna-Vanilla")

L:SetGeneralLocalization({
	name = "Мексна"
})

L:SetWarningLocalization({
	WarningSpidersSoon	= "Паученыши Мексны через 5 секунд",
	WarningSpidersNow	= "В паутине появляются паучата"
})

L:SetTimerLocalization({
	TimerSpider	= "Паученыши Мексны"
})

L:SetOptionLocalization({
	WarningSpidersSoon	= "Предупреждать перед следующим призывом Паученышей Мексны",
	WarningSpidersNow	= "Предупреждение для призыва Паученышей Мексны",
	TimerSpider			= "Отсчет времени до Паученышей Мексны"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Арахнофобия"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth-Vanilla")

L:SetGeneralLocalization({
	name = "Нот Чумной"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Телепортация",
	WarningTeleportSoon	= "Телепортация через 10 секунд"
})

L:SetTimerLocalization({
	TimerTeleport		= "Телепортация",
	TimerTeleportBack	= "Телепортация обратно"
})

L:SetOptionLocalization({
	WarningTeleportNow	= "Предупреждение о телепортации",
	WarningTeleportSoon	= "Предупреждать перед следующей телепортацией",
	TimerTeleport		= "Отсчет времени до телепортации",
	TimerTeleportBack	= "Отсчет времени до обратной телепортации"
})

L:SetMiscLocalization({
	Pull				= "Смерть чужакам!",
	Adds				= "призывает скелетов-воинов!",
	AddsTwo				= "поднимает новых скелетов!"
})

--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan-Vanilla")

L:SetGeneralLocalization({
	name = "Хейган Нечестивый"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Телепортация",
	WarningTeleportSoon	= "Телепортация через %d сек."
})

L:SetTimerLocalization({
	TimerTeleport	= "Телепортация"
})

L:SetOptionLocalization({
	WarningTeleportNow	= "Предупреждение о телепортации",
	WarningTeleportSoon	= "Предупреждать перед следующей телепортацией",
	TimerTeleport		= "Отсчет времени до телепортации"
})

L:SetMiscLocalization({
	Pull				= "Теперь вы принадлежите мне!"
})

---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb-Vanilla")

L:SetGeneralLocalization({
	name = "Лотхиб"
})

L:SetWarningLocalization({
	WarningHealSoon	= "Можно исцелять через 3 секунды",
	WarningHealNow	= "Исцеляйте сейчас"
})

L:SetOptionLocalization({
	WarningHealSoon		= "Предупреждать заранее перед 3-х секундным окном исцеления",
	WarningHealNow		= "Предупреждение для 3-х секундного окна исцеления",
	SporeDamageAlert	= "Сообщать шепотом и объявлять в рейд игроков, наносящих урон спорам\n(требуются права лидера или помощника)",
	CorruptedSorting	= "Set infoframe sorting behaviour for $spell:55593", -- translation missing
	Alphabetical		= "Sort in alphabetical order", -- translation missing
	Duration			= "Sort by duration" -- translation missing
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk-Vanilla")

L:SetGeneralLocalization({
	name = "Лоскутик"
})

L:SetOptionLocalization({
	WarningHateful	= "Объявлять цели под Ударом ненависти\n(требуются права лидера или помощника)"
})

L:SetMiscLocalization({
	yell1			= "Лоскутик хочет поиграть!",
	yell2			= "Кел'Тузад объявил Лоскутика воплощением войны!",
	HatefulStrike	= "Удар ненависти --> %s [%s]"
})

-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus-Vanilla")

L:SetGeneralLocalization({
	name = "Гроббулус"
})

-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth-Vanilla")

L:SetGeneralLocalization({
	name = "Глут"
})

----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius-Vanilla")

L:SetGeneralLocalization({
	name = "Таддиус"
})

L:SetWarningLocalization({
	WarningChargeChanged	= "Полярность изменена на %s",
	WarningChargeNotChanged	= "Полярность не изменена"
})

L:SetOptionLocalization({
	WarningChargeChanged	= "Предупреждение, когда ваша полярность изменена",
	WarningChargeNotChanged	= "Предупреждение, когда ваша полярность не изменена",
	ArrowsEnabled			= "Отображать стрелки (обычная \"2-сторонняя\" стратегия)",
	ArrowsRightLeft			= "Стрелки влево/вправо для \"4-сторонней\" стратегии",
	ArrowsInverse			= "Обратная \"4-сторонняя\" стратегия (вправо, если полярность изменена, влево, если нет)"
})

L:SetMiscLocalization({
	Yell	= "Сталагг сокрушить вас!",
	Emote	= "%s перезагружается!",
	Emote2	= "Катушка Теслы перезагружается!",
	Boss1	= "Фойген",
	Boss2	= "Сталагг",
	Charge1 = "отрицательную",
	Charge2 = "положительную"
})

----------------------------
--  Instructor Razuvious  --
----------------------------
L = DBM:GetModLocalization("Razuvious-Vanilla")

L:SetGeneralLocalization({
	name = "Инструктор Разувий"
})

L:SetWarningLocalization({
	WarningShieldWallSoon	= "Стена костей закончится через 5 секунд"
})

L:SetOptionLocalization({
	WarningShieldWallSoon	= "Предупреждать о скором исчезновении Стены костей"
})

L:SetMiscLocalization({
	Yell1 = "Покажите мне, на что способны!",
	Yell2 = "Обучение окончено! Покажите мне, что вы усвоили!",
	Yell3 = "Вспомните, чему я вас учил!",
	Yell4 = "Выше ногу! Или у тебя с этим проблемы?"
})

----------------------------
--  Gothik the Harvester  --
----------------------------
L = DBM:GetModLocalization("Gothik-Vanilla")

L:SetGeneralLocalization({
	name = "Готик Жнец"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "Волна %d: %s через 3 секунды",
	WarningWaveSpawned	= "Волна %d: %s призван",
	WarningRiderDown	= "Всадник мертв",
	WarningKnightDown	= "Рыцарь мертв",
	WarningPhase2		= "Фаза 2"
})

L:SetTimerLocalization({
	TimerWave	= "Волна %d",
	TimerPhase2	= "Фаза 2"
})

L:SetOptionLocalization({
	TimerWave			= "Отсчет времени до волны",
	TimerPhase2			= "Отсчет времени до фазы 2",
	WarningWaveSoon		= "Предупреждать перед следующей волной",
	WarningWaveSpawned	= "Предупреждение для волны призыва",
	WarningRiderDown	= "Предупреждение, когда всадник мертв",
	WarningKnightDown	= "Предупреждение, когда рыцарь мертв"
})

L:SetMiscLocalization({
	yell			= "Глупо было искать свою смерть.",
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s и %d %s",
	WarningWave3	= "%d %s, %d %s и %d %s",
	Trainee			= "Ученика",
	Knight			= "Рыцаря",
	Rider			= "Всадника"
})

---------------------
--  Four Horsemen  --
---------------------
L = DBM:GetModLocalization("Horsemen-Vanilla")

L:SetGeneralLocalization({
	name = "Четыре Всадника"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Знак %d через 3 секунды",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetOptionLocalization({
	WarningMarkSoon				= "Предупреждать перед следующими знаками",
	SpecialWarningMarkOnPlayer	= "Спец-предупреждение, когда >4 знаков на вас"
})

L:SetMiscLocalization({
	Korthazz	= "Тан Кортазз",
	Rivendare	= "Барон Ривендер",
	Blaumeux	= "Леди Бломе",
	Zeliek		= "Сэр Зелиек"
})

-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron-Vanilla")

L:SetGeneralLocalization({
	name = "Сапфирон"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon	= "Воздушная фаза через 10 секунд",
	WarningAirPhaseNow	= "Воздушная фаза",
	WarningLanded		= "Сапфирон приземляется",
	WarningDeepBreath	= "Ледяное дыхание",
	SpecWarnSapphLow	= "У Сапфирона нет сил взлететь"
})

L:SetTimerLocalization({
	TimerAir		= "Воздушная фаза",
	TimerLanding	= "Приземление",
	TimerIceBlast	= "Ледяное дыхание"
})

L:SetOptionLocalization({
	WarningAirPhaseSoon	= "Предупреждать о приближении Воздушной фазы",
	WarningAirPhaseNow	= "Объявлять Воздушную фазу",
	WarningLanded		= "Объявлять Наземную фазу",
	TimerAir			= "Отсчет времени до Воздушной фазы",
	TimerLanding		= "Отсчет времени до приземления",
	TimerIceBlast		= "Отсчет времени до Ледяного дыхания",
	WarningDeepBreath	= "Специальное объявление Ледяного Дыхания",
	SpecWarnSapphLow	= "Спец-предупреждения для 10% босса(отмена воздушной фазы)"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s глубоко вдыхает.",
	AirPhase			= "Сапфирон взмывает в воздух!",
	LandingPhase		= "Сапфирон возобновляет свою атаку!"
})

------------------
--  Kel'Thuzad  --
------------------
L = DBM:GetModLocalization("Kel'Thuzad-Vanilla")

L:SetGeneralLocalization({
	name = "Кел'Тузад"
})

L:SetWarningLocalization({
	specwarnP2Soon	= "Кел'Тузад вступает в бой через 10 секунд",
	warnAddsSoon	= "Скоро прибытие Стражей Ледяной Короны",
	WeaponsStatus	= "Cнятие оружий включено: %s (%s - %s)"
})

L:SetTimerLocalization({
	TimerPhase2	= "Фаза 2"
})

L:SetOptionLocalization({
	TimerPhase2			= "Отсчет времени до фазы 2",
	specwarnP2Soon		= "Спец-предупреждение за 10 секунд до вступления Кел'Тузада в бой",
	warnAddsSoon		= "Предупреждать заранее о Стражах Ледяной Короны",
	WeaponsStatus		= "Спец-предупреждение в начале боя если включена функция снятия/надевания оружий",
	EqUneqWeaponsKT		= "Снимать/надевать оружия перед/после контроля по таймеру. Для надевания создайте компл. экип. \"pve\". Для снятия не нужен.",
	EqUneqWeaponsKT2	= "Снимать/надевать оружия когда контроль кастуется в вас. Для надевания создайте компл. экип. \"pve\". Для снятия не нужен.",
	RemoveBuffsOnMC		= "Снимать баффы, когда на вас наложено заклинание $spell:28410. Каждый вариант является кумулятивным.",
	Gift				= "Снять $spell:48469 / $spell:48470. Минимальный подход для предотвращения сопротивления $spell:33786.",
	CCFree				= "+ Убрать $spell:48169 / $spell:48170. Учет сопротивлений заклинаний школы Теней.",
	ShortOffensiveProcs	= "+ Удалите атакующие заклинания с малой продолжительностью. Рекомендуется для безопасности рейда без ущерба для урона рейда.",
	MostOffensiveBuffs	= "+ Уберите большинство атакующих баффов (в основном для кастеров и |cFFFF7C0AСила зверя Друид|r). Максимальная безопасность рейда с потерей урона и необходимостью самовосстановления/перемещения!"
})

L:SetMiscLocalization({
	Yell		= "Соратники, слуги, солдаты холодной тьмы! Повинуйтесь зову Кел'Тузада!",
--	YellMC1		= "Теперь твоя душа связана с моей!",
--	YellMC2		= "Тебе не уйти!",
	Yell1Phase2	= "Молите о пощаде!", -- 12995
	Yell2Phase2	= "Кричите! Кричите изо всех сил!", -- 12996
	Yell3Phase2	= "Вы уже мертвы!", -- 12997
	YellPhase3	= "Господин, мне нужна помощь!", -- 12998
	YellGuardians	= "Хорошо. Воины ледяных пустошей, восстаньте! Повелеваю вам сражаться, убивать и умирать во имя своего повелителя! Не щадить никого!", -- 12994
	setMissing	= "ВНИМАНИЕ! DBM: автоматическое снимание/надевание оружия не будет работать пока вы не создадите набор экипировки pve",
	EqUneqLineDescription	= "Автоматическое оснащение/снятие оборудования"
})
