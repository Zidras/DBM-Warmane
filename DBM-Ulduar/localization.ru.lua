if GetLocale() ~= "ruRU" then return end

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization({
	name = "Огненный Левиафан"
})

L:SetWarningLocalization({
	PursueWarn				= "Преследуется >%s<",
	warnNextPursueSoon		= "Смена цели через 5 секунд",
	SpecialPursueWarnYou	= "Вас преследуют - бегите",
	warnWardofLife			= "Призыв Защитника жизни"
})

L:SetOptionLocalization({
	SpecialPursueWarnYou	= "Спец-предупреждение, когда на вас $spell:62374",
	PursueWarn				= "Объявлять цели заклинания $spell:62374",
	warnNextPursueSoon		= "Предупреждать заранее о следующем $spell:62374",
	warnWardofLife			= "Спец-предупреждение для призыва Защитника жизни"
})

L:SetMiscLocalization({
	YellPull	= "Обнаружены противники. Запуск протокола оценки угрозы. Главная цель выявлена. Повторный анализ через 30 секунд.",
	Emote		= "%%s наводится на (%S+)%."
})

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization({
	name = "Повелитель Горнов Игнис"
})

L:SetOptionLocalization({
	soundConcAuraMastery	= "Воспроизвести звук $spell:31821, чтобы отменить эффекты $spell:63472 (только для |cFFF48CBAПаладин|r, который является владельцем $spell:19746)"
})

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization({
	name = "Острокрылая"
})

L:SetWarningLocalization({
	warnTurretsReadySoon		= "Гарпунные пушки будут собраны через 20 секунд",
	warnTurretsReady			= "Гарпунные пушки собраны"
})

L:SetTimerLocalization({
	timerTurret1	= "Гарпунная пушка 1",
	timerTurret2	= "Гарпунная пушка 2",
	timerTurret3	= "Гарпунная пушка 3",
	timerTurret4	= "Гарпунная пушка 4",
	timerGrounded	= "на земле"
})

L:SetOptionLocalization({
	warnTurretsReadySoon		= "Пред-предупреждение для пушек",
	warnTurretsReady			= "Предупреждение для пушек",
	timerTurret1				= "Отсчет времени до пушки 1",
	timerTurret2				= "Отсчет времени до пушки 2",
	timerTurret3				= "Отсчет времени до пушки 3 (25 чел.)",
	timerTurret4				= "Отсчет времени до пушки 4 (25 чел.)",
	timerGrounded				= "Отсчет времени для наземной фазы"
})

L:SetMiscLocalization({
	YellAir				= "Дайте время подготовить пушки.",
	YellAir2			= "Огонь прекратился! Надо починить пушки!",
	YellGround			= "Быстрее! Сейчас она снова взлетит!",
	EmotePhase2			= "%%s обессилела и больше не может летать!"
})

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization({
	name = "Разрушитель XT-002"
})

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization({
	name = "Железное собрание"
})

L:SetOptionLocalization({
	AlwaysWarnOnOverload		= "Всегда предупреждать при $spell:63481<br/>(иначе, только когда босс в цели)"
})

L:SetMiscLocalization({
	Steelbreaker		= "Сталелом",
	RunemasterMolgeim	= "Мастер рун Молгейм",
	StormcallerBrundir	= "Буревестник Брундир"
--	YellPull1			= "Кто бы вы ни были – жалкие бродяги или великие герои... Вы всего лишь смертные!",
--	YellPull2			= "Я буду спокоен, лишь когда окончательно истреблю вас.",
--	YellPull3			= "Чужаки! Вам не одолеть Железное Собрание!",
--	YellRuneOfDeath		= "Расшифруйте вот это!",
--	YellRunemasterMolgeimDied = "И что вам дало мое поражение? Вы все так же обречены, смертные.",
--	YellRunemasterMolgeimDied2 = "Наследие бурь не умрет вместе со мной.",
--	YellStormcallerBrundirDied = "Никто не превзойдет силу шторма.",
--	YellStormcallerBrundirDied2 = "Вас ждет бездна безумия!",
--	YellSteelbreakerDied = "Мое поражение лишь приблизит вашу погибель.",
--	YellSteelbreakerDied2 = "Не может быть!"
})

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization({
	name = "Алгалон Наблюдатель"
})

L:SetTimerLocalization({
	NextCollapsingStar		= "Вспыхивающая звезда",
})

L:SetWarningLocalization({
	warnStarLow				= "У Вспыхивающей звезды мало здоровья"
})

L:SetOptionLocalization({
	NextCollapsingStar		= "Отсчет времени до появления Вспыхивающей звезды",
	warnStarLow				= "Спец-предупреждение, когда у Вспыхивающей звезды мало здоровья (на ~25%)"
})

L:SetMiscLocalization({
--	FirstPull				= "Взгляните на мир моими глазами: узрите необъятную вселенную, непостижимую даже для величайших умов.",
--	YellPull				= "Ваши действия нелогичны. Все возможные исходы этой схватки просчитаны. Пантеон получит сообщение от Наблюдателя в любом случае.",
	YellKill				= "Я видел миры, охваченные пламенем Творцов. Их жители гибли, не успев издать ни звука. Я был свидетелем того, как галактики рождались и умирали в мгновение ока. И все время я оставался холодным... и безразличным. Я. Не чувствовал. Ничего. Триллионы загубленных судеб. Неужели все они были подобны вам? Неужели все они так же любили жизнь?",
	Emote_CollapsingStar	= "%s призывает взрывающиеся звезды!",
	Phase2					= "Узрите чудо созидания!",
	CollapsingStar			= "Вспыхивающая звезда"
})

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization({
	name = "Кологарн"
})

L:SetTimerLocalization({
	timerLeftArm		= "Возрождение левой руки",
	timerRightArm		= "Возрождение правой руки",
	achievementDisarmed	= "Обезоружен"
})

L:SetOptionLocalization({
	timerLeftArm			= "Отсчет времени до Возрождения левой руки",
	timerRightArm			= "Отсчет времени до Возрождения правой руки",
	achievementDisarmed		= "Отсчет времени для достижения Обезоружен"
})

L:SetMiscLocalization({
--	Yell_Trigger_arm_left	= "Царапина...",
--	Yell_Trigger_arm_right	= "Всего лишь плоть!",
--	YellEncounterStart		= "Вам не пройти!",
--	YellLeftArmDies			= "Царапина...",
--	YellRightArmDies		= "Всего лишь плоть!",
	Health_Body				= "Кологарн",
	Health_Right_Arm		= "Правая рука",
	Health_Left_Arm			= "Левая рука",
	FocusedEyebeam			= "%s устремляет на вас свой взгляд!"
})

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization({
	name = "Ауриайа"
})

L:SetWarningLocalization({
	WarnCatDied		= "Дикий эащитник погибает (осталось %d жизней)",
	WarnCatDiedOne	= "Дикий эащитник погибает (осталась 1 жизнь)"
})

-- L:SetTimerLocalization({
-- 	timerDefender	= "Возрождение Дикого защитника"
-- })

L:SetOptionLocalization({
	WarnCatDied		= "Предупреждение, когда Дикий защитник погибает",
	WarnCatDiedOne	= "Предупреждение, когда у Дикого защитника остается 1 жизнь"
--	timerDefender	= "Отсчет времени до возрождения Дикого защитника"
})

L:SetMiscLocalization({
	Defender = "Дикий эащитник (%d)",
	YellPull = "Вы зря сюда заявились!"
})

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization({
	name = "Ходир"
})

L:SetMiscLocalization({
	Pull		= "Вы будете наказаны за это вторжение!",
	YellKill	= "Наконец-то я... свободен от его оков…"
})

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization({
	name = "Торим"
})

L:SetTimerLocalization({
	TimerHardmode	= "Сложный режим"
})

L:SetOptionLocalization({
	specWarnHardmode	= "Спецпредупреждение о включении режима Сложный режим",
	TimerHardmode		= "Отсчет времени для сложного режима",
	AnnounceFails		= "Объявлять игроков, попавших под $spell:62017, в рейд-чат<br/>(требуются права лидера или помощника)"
})

L:SetMiscLocalization({
	YellPhase1				= "Незваные гости! Вы заплатите за то, что посмели вмешаться... Погодите, вы...",
	YellPhase2				= "Бесстыжие выскочки, вы решили бросить вызов мне лично? Я сокрушу вас всех!",
	YellKill				= "Придержите мечи! Я сдаюсь.",
	YellHardModeActive		= "Это невозможно! Торим, не сомневайся – твоих врагов ждет ледяная смерть!",
	YellHardModeFailed		= "Эти жалкие смертные мне не ровня! Уничтожьте их!",
	ChargeOn				= "Разряд молнии: %s",
	Charge					= "Попали под Разряд молнии (в этом бою): %s"
})

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization({
	name = "Фрейя"
})

L:SetWarningLocalization({
	WarnSimulKill	= "Первый помощник погиб - воскрешение через ~12 сек."
})

L:SetTimerLocalization({
	TimerSimulKill	= "Воскрешение"
})

L:SetOptionLocalization({
	WarnSimulKill	= "Объявлять, когда первый монстр погибает",
	TimerSimulKill	= "Отсчет времени до воскрешения монстров"
})

L:SetMiscLocalization({
	SpawnYell			= "Помогите мне, дети мои!",
	WaterSpirit			= "Древний дух воды",
	Snaplasher			= "Хватоплет",
	StormLasher			= "Грозовой плеточник",
	YellKill			= "Он больше не властен надо мной. Мой взор снова ясен. Благодарю вас, герои.",
	YellAdds1			= "Эонар, твоей прислужнице нужна помощь!",
	YellAdds2			= "Вас захлестнет сила стихий!",
	EmoteLGift			= "начинает расти!", -- |cFF00FFFFДар Хранительницы жизни|r начинает расти!
	TrashRespawnTimer	= "Возрождение монстров",
	YellPullNormal		= "Нужно защитить Оранжерею!",
	YellPullHard		= "Древни, дайте мне силы!"
})

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization({
	name = "Древни Фрейи"
})

L:SetOptionLocalization({
	TrashRespawnTimer	= "Отсчет времени до возрождения монстров"
})

L:SetMiscLocalization({
	TrashRespawnTimer	= "Возрождение монстров",
})

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization({
	name = "Мимирон"
})

L:SetWarningLocalization({
	MagneticCore		= "Магнитное ядро у |3-1(>%s<)",
	WarnBombSpawn		= "Бомбот"
})

L:SetTimerLocalization({
	TimerHardmode	= "Сложный режим - Самоуничтожение",
	TimeToPhase2	= "Фаза 2",
	TimeToPhase3	= "Фаза 3",
	TimeToPhase4	= "Фаза 4"
})

L:SetOptionLocalization({
	TimeToPhase2			= "Отсчет времени для фазы 2",
	TimeToPhase3			= "Отсчет времени для фазы 3",
	TimeToPhase4			= "Отсчет времени для фазы 4",
	MagneticCore			= "Объявлять подобравших Магнитное ядро",
	AutoChangeLootToFFA		= "Смена режима добычи на Каждый за себя в фазе 3",
	WarnBombSpawn			= "Предупреждение о Бомботах",
	TimerHardmode			= "Отсчет времени для сложного режима"
})

L:SetMiscLocalization({
	MobPhase1		= "Левиафан II",
	MobPhase2		= "VX-001 <Противопехотная пушка>",
	MobPhase3		= "Воздушное судно",
	MobPhase4		= "В-0-7-ТРОН",
	YellPull		= "У нас мало времени, друзья! Вы поможете испытать новейшее и величайшее из моих изобретений. И учтите: после того, что вы натворили с XT-002, отказываться просто некрасиво.",
	YellHardPull	= "Отсчет времени до самоуничтожения начат.",
	YellPhase2		= "ПРЕВОСХОДНО! Просто восхитительный результат! Целостность обшивки – 98,9 процента! Почти что ни царапинки! Продолжаем!",
	YellPhase3		= "Спасибо, друзья! Благодаря вам я получил ценнейшие сведения! Так, а куда же я дел... – ах, вот куда.",
	YellPhase4		= "Фаза предварительной проверки завершена. Пора начать главный тест!",
	YellKilled		= "Очевидно, я совершил небольшую ошибку в расчетах. Пленный злодей затуманил мой разум и заставил меня отклониться от инструкций. Сейчас все системы в норме. Конец связи.",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
})

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization({
	name = "Генерал Везакс"
})

L:SetTimerLocalization({
	hardmodeSpawn = "Саронитовый враг"
})

L:SetOptionLocalization({
	hardmodeSpawn					= "Отсчет времени до появления Саронитового врага (сложный режим)",
	CrashArrow						= "Показывать стрелку, когда $spell:62660 около вас"
})

L:SetMiscLocalization({
	EmoteSaroniteVapors	= "Поблизости начинают возникать саронитовые испарения!"
})

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization({
	name = "Йогг-Сарон"
})

L:SetWarningLocalization({
	WarningGuardianSpawned			= "Страж %d",
	WarningCrusherTentacleSpawned	= "Тяжелое щупальце",
	WarningSanity					= "Осталось %d Здравомыслия",
	SpecWarnSanity					= "Осталось %d Здравомыслия",
	SpecWarnGuardianLow				= "Прекратите атаковать этого Стража",
	SpecWarnMadnessOutNow			= "Доведение до помешательства заканчивается - выбегайте",
	WarnBrainPortalSoon				= "Провал Безумия через 10 секунды",
	SpecWarnBrainPortalSoon			= "Скоро Провал Безумия"
})

L:SetTimerLocalization({
	NextPortal	= "Провал Безумия"
})

L:SetOptionLocalization({
	WarningGuardianSpawned			= "Предупреждение о появлении Стража",
	WarningCrusherTentacleSpawned	= "Предупреждение о появлении Тяжелого щупальца",
	WarningSanity					= "Предупреждение, когда у вас мало $spell:63050",
	SpecWarnSanity					= "Спец-предупреждение, когда у вас очень мало $spell:63050",
	SpecWarnGuardianLow				= "Спец-предупреждение, когда у Стража (в фазе 1) мало здоровья (для бойцов)",
	WarnBrainPortalSoon				= "Предупреждать заранее о Провале Безумия",
	SpecWarnMadnessOutNow			= "Спец-предупреждение незадолго до окончания $spell:64059",
	SpecWarnBrainPortalSoon			= "Спец-предупреждение о следующем Провале Безумия",
	NextPortal						= "Отсчет времени до следующего Провала Безумия",
	ShowSaraHealth					= "Показывать здоровье Сары в фазе 1 (должна быть в цели или фокусе хотя бы у одного члена рейда)",
	MaladyArrow						= "Показывать стрелку, когда $spell:63881 около вас"
})

L:SetMiscLocalization({
	YellPull			= "Скоро мы сразимся с главарем этих извергов! Обратите гнев и ненависть против его прислужников!",
	S1TheLucidDream		= "Фаза 1: осознанный сон",
	Sara				= "Сара",
	GuardianofYoggSaron	= "Страж Йогг-Сарона",
	S2DescentIntoMadness= "Фаза 2: Провал Безумия",
	CrusherTentacle		= "Тяжелое щупальце",
	CorruptorTentacle	= "Щупальце разложения",
	ConstrictorTentacle	= "Удушающее щупальце",
	DescentIntoMadness	= "Провал Безумия",
	InfluenceTentacle	= "Чувствительное щупальце",
	LaughingSkull		= "Веселый череп",
	BrainofYoggSaron	= "Мозг Йогг-Сарона",
	S3TrueFaceofDeath	= "Фаза 3: истинный лик смерти",
	YoggSaron			= "Йогг-Сарон",
	ImmortalGuardian	= "Бессмертный страж"
})
