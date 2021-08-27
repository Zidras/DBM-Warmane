if GetLocale() ~= "ruRU" then return end

local L

local optionWarning		= "Предупреждение для %s"
local optionPreWarning	= "Предупреждать заранее о %s"

----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "Принц Талдарам"
})

-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "Старейшина Надокс"
})

---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Джедога Искательница Теней"
})

---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "Глашатай Волаж"
})

----------------
--  Amanitar  --
----------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "Аманитар"
})

-------------------
--  Azjol-Nerub  --
---------------------------------
--  Krik'thir the Gatewatcher  --
---------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "Крик'тир Хранитель Врат"
})

----------------
--  Hadronox  --
----------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "Хадронокс"
})

-------------------------
--  Anub'arak (Party)  --
-------------------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Ануб'арак (группа)"
})

---------------------------------------
--  Caverns of Time: Old Stratholme  --
---------------------------------------
--  Meathook  --
----------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "Мясной Крюк"
})

--------------------------------
--  Salramm the Fleshcrafter  --
--------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "Салрамм Плоторез"
})

-------------------------
--  Chrono-Lord Epoch  --
-------------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Хронолорд Эпох"
})

-----------------
--  Mal'Ganis  --
-----------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "Мал'Ганис"
})

L:SetMiscLocalization({
	Outro	= "Твое путешествие начинается, юный принц. Собирай свои войска и отправляйся в царство вечных снегов, в Нордскол. Там мы и уладим все наши дела, там ты узнаешь свою судьбу."
})

-------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Волны Стратхольма"
})

L:SetWarningLocalization({
	WarningWaveNow = "Волна %d: призыв %s"
})

L:SetTimerLocalization({
	TimerWaveIn		= "Следующая волна (6)",
	TimerRoleplay	= "Вступительное представление"
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("новой волны"),
	TimerWaveIn		= "Отсчет времени до cледующей волны (после босса 5-ой волны)",
	TimerRoleplay	= "Отсчет времени для вступительного представления"
})

L:SetMiscLocalization({
	Meathook	= "Мясной Крюк",
	Salramm		= "Салрамм Плоторез",
	Devouring	= "Всепожирающий вурдалак",
	Enraged		= "Разъярившийся вурдалак",
	Necro		= "Некромант",
	Fiend		= "Некрорахнид",
	Stalker		= "Кладбищенский ловец",
	Abom		= "Лоскутное создание",
	Acolyte		= "Послушник",
	Wave1		= "%d %s",
	Wave2		= "%d %s и %d %s",
	Wave3		= "%d %s, %d %s и %d %s",
	Wave4		= "%d %s, %d %s, %d %s и %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Атаки Плети: (%d+)/10",
	Roleplay	= "Я рад, что ты пришел, Утер!",
	Roleplay2	= "Похоже, все готовы. Помните, эти люди заражены чумой и скоро умрут. Мы должны очистить Стратхольм и защитить Лордерон от Плети. Вперед."
})

------------------------
--  Drak'Tharon Keep  --
------------------------
--  Trollgore  --
-----------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "Кровотролль"
})

--------------------------
--  Novos the Summoner  --
--------------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "Новос Призыватель"
})

L:SetWarningLocalization({
	WarnCrystalHandler	= "Хрустальный укротитель (%d осталось)"
})

L:SetTimerLocalization({
	timerCrystalHandler	= "Хрустальный укротитель"
})

L:SetOptionLocalization({
	WarnCrystalHandler	= "Предупреждение при появлении Хрустального укротителя",
	timerCrystalHandler	= "Отсчет времени до появления следующего Хрустального укротителя"
})

L:SetMiscLocalization({
	YellPull		= "Вам холодно? Это дыхание скорой смерти.",
	HandlerYell		= "Защищайте меня! Быстрее, будьте вы прокляты!",
	Phase2			= "Неужели вы не понимаете всей бесполезности происходящего?",
	YellKill		= "Ваши усилия… напрасны."
})

-----------------
--  King Dred  --
-----------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "Король Дред"
})

-----------------------------
--  The Prophet Tharon'ja  --
-----------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "Пророк Тарон'джа"
})

---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "Слад'ран"
})

---------------
--  Moorabi  --
---------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "Мураби"
})

-------------------------
--  Drakkari Colossus  --
-------------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "Колосс Драккари"
})

L:SetWarningLocalization({
	WarningElemental	= "Фаза 2. Элементаль",
	WarningStone		= "Фаза 1. Колосс"
})

L:SetOptionLocalization({
	WarningElemental	= "Предупреждение для Фаза 2. Элементаль",
	WarningStone		= "Предупреждение для Фаза 1. Колосс"
})

-----------------
--  Gal'darah  --
-----------------
L = DBM:GetModLocalization("Galdarah")

L:SetGeneralLocalization({
	name = "Гал'дара"
})

L:SetWarningLocalization({
	TimerPhase2		= "Фаза 2: Аватара Акали",
	TimerPhase1		= "Фаза 1: Верховный пророк Акали"
})

L:SetTimerLocalization({
	TimerPhase2		= "Фаза 2: Аватара Акали",
	TimerPhase1		= "Фаза 1: Верховный пророк Акали"
})

L:SetOptionLocalization({
	TimerPhase2		= "Предупреждение для Фаза 2: Аватара Акали",
	TimerPhase1		= "Предупреждение для Фаза 1: Верховный пророк Акали"
})

L:SetMiscLocalization({
	YellPhase2_1	= "После этого ничего не останется!",
	YellPhase2_2	= "Хотите увидеть cилу? Я покажу вам... силу!"
})

-------------------------
--  Eck the Ferocious  --
-------------------------
L = DBM:GetModLocalization("Eck")

L:SetGeneralLocalization({
	name = "Эк Свирепый"
})

--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
L = DBM:GetModLocalization("Gjarngrin")

L:SetGeneralLocalization({
	name = "Генерал Бьярнгрин"
})

-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "Ионар"
})

---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization("Volkhan")

L:SetGeneralLocalization({
	name = "Волхан"
})

-------------
--  Loken  --
-------------
L = DBM:GetModLocalization("Kronus")

L:SetGeneralLocalization({
	name = "Локен"
})

----------------------
--  Halls of Stone  --
-----------------------
--  Maiden of Grief  --
-----------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "Дева Скорби"
})

------------------
--  Krystallus  --
------------------
L = DBM:GetModLocalization("Krystallus")

L:SetGeneralLocalization({
	name = "Кристаллус"
})

------------------------------
--  Sjonnir the Ironshaper  --
------------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "Сьоннир Литейщик"
})

--------------------------------------
--  Brann Bronzebeard Escort Event  --
--------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "Эскорт Бранна"
})

L:SetWarningLocalization({
	WarningPhase	= "Фаза %d"
})

L:SetTimerLocalization({
	timerEvent	= "Оставшееся время"
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("фаз"),
	timerEvent		= "Отсчет времени продолжительности события"
})

L:SetMiscLocalization({
	Pull	= "Теперь будьте внимательны! Не успеете и глазом моргнуть, как…",
	Phase1	= "Обнаружено вторжение в систему. Приоритетность работ по анализу исторических архивов понижена. Ответные меры инициированы.",
	Phase2	= "Порог допустимой угрозы превышен. Астрономический архив отключен. Уровень безопасности повышен.",
	Phase3	= "Критическое значение уровня угрозы. Перенаправление анализа Бездны. Инициирование протокола очищения.",
	Kill	= "Внимание: меры предосторожности деактивированы. Начинаю стирание памяти и…"
})

-----------------
--  The Nexus  --
-----------------
--  Anomalus  --
----------------
L = DBM:GetModLocalization("Anomalus")

L:SetGeneralLocalization({
	name = "Аномалус"
})

-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Орморок Воспитатель Дерев"
})

----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Великая ведунья Телестра"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Скоро Разделение",
	WarningSplitNow		= "Разделение",
	WarningMerge		= "Слияние"
})
L:SetOptionLocalization({
	WarningSplitSoon	= "Предупреждать заранее о Разделении",
	WarningSplitNow		= "Предупреждать о Разделении",
	WarningMerge		= "Предупреждать о Слиянии"
})

L:SetMiscLocalization({
	SplitTrigger1		= "Меня на вас хватит!",
	SplitTrigger2		= "Вы получите больше, чем заслуживаете!",
	MergeTrigger		= "Ну а теперь, покончим с этим!"
})

-------------------
--  Keristrasza  --
-------------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "Керистраза"
})

-----------------------------------
--  Commander Kolurg/Stoutbeard  --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Неизвестный"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Командир Колург"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Командир Пивобород"
end

L:SetGeneralLocalization({
	name = commander
})

------------------
--  The Oculus  --
-------------------------------
--  Drakos the Interrogator  --
-------------------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "Дракос Дознаватель"
})


L:SetOptionLocalization({
	MakeitCountTimer	= "Отсчет времени для Вам всем зачтется (достижение)"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Вам всем зачтется"
})

----------------------
--  Mage-Lord Urom  --
----------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "Маг-лорд Уром"
})

L:SetMiscLocalization({
	CombatStart		= "Несчастные слепые глупцы!"
})

--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Варос Заоблачный Странник"
})

---------------------------
--  Ley-Guardian Eregos  --
---------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Хранитель энергии Эрегос"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Вам всем зачтется"
})

--------------------
--  Utgarde Keep  --
-----------------------
--  Prince Keleseth  --
-----------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "Принц Келесет"
})

--------------------------------
--  Skarvald the Constructor  --
--  & Dalronn the Controller  --
--------------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "Скарвальд и Далронн"
})

----------------------------
--  Ingvar the Plunderer  --
----------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ингвар Расхититель"
})

L:SetMiscLocalization({
	YellIngvarPhase2	= "Я вернулся! Еще один шанс раскроить вам головы!",
	YellCombatEnd		= "Нет! Я смогу это сделать… я смогу…"
})

------------------------
--  Utgarde Pinnacle  --
--------------------------
--  Skadi the Ruthless  --
--------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "Скади Безжалостный"
})

L:SetMiscLocalization({
	CombatStart		= "Что за недоноски осмелились вторгнуться сюда? Поживее, братья мои! Угощение тому, кто принесет мне их головы!",
	Phase2			= "Ничтожные лакеи! Ваши трупы послужат хорошей закуской для моего нового дракона!"
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "Король Имирон"
})

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Свала Вечноскорбящая"
})

L:SetTimerLocalization({
	timerRoleplay		= "Свала Вечноскорбящая активируется"
})

L:SetOptionLocalization({
	timerRoleplay		= "Отсчет времени для представления перед активацией Свалы Вечноскорбящей"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "Мой господин! Я сделала, как вы велели, и теперь молю вас о благословении!"
})

-----------------------
--  Gortok Palehoof  --
-----------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Горток Бледное Копыто"
})

-----------------------
--  The Violet Hold  --
-----------------------
--  Cyanigosa  --
-----------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "Синигоса"
})

L:SetMiscLocalization({
	CyanArrived	= "Вы доблестно обороняетесь, но этот город должен быть стерт с лица земли, и я лично исполню волю Малигоса!"
})

--------------
--  Erekem  --
--------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "Эрекем"
})

---------------
--  Ichoron  --
---------------
L = DBM:GetModLocalization("Ichoron")

L:SetGeneralLocalization({
	name = "Гнойрон"
})

-----------------
--  Lavanthor  --
-----------------
L = DBM:GetModLocalization("Lavanthor")

L:SetGeneralLocalization({
	name = "Лавантор"
})

--------------
--  Moragg  --
--------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "Морагг"
})

--------------
--  Xevozz  --
--------------
L = DBM:GetModLocalization("Xevoss")

L:SetGeneralLocalization({
	name = "Ксевозз"
})

-------------------------------
--  Zuramat the Obliterator  --
-------------------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "Зурамат Уничтожитель"
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Таймеры порталов"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Скоро новый портал",
	WarningPortalNow	= "Портал #%d",
	WarningBossNow		= "Прибытие Босса"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Портал #%d" ,
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("нового портала"),
	WarningPortalSoon		= optionPreWarning:format("новом портале"),
	WarningBossNow			= optionWarning:format("прибытия босса"),
	TimerPortalIn			= "Отсчет времени до следующего портала (после босса)",
	ShowAllPortalTimers		= "Отсчет времени для всех порталов (неточный)"
})

L:SetMiscLocalization({
	yell1		= "Эй, стражи! Уходим! Славные герои обо всем позаботятся. За мной!",
	Sealbroken	= "Мы прорвались через тюремные ворота! Дорога в Даларан открыта! Теперь мы наконец прекратим войну Нексуса!",
	WavePortal	= "Открыто порталов: (%d+)/18"
})

-----------------------------
--  Trial of the Champion  --
-----------------------------
--  The Black Knight  --
------------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "Черный рыцарь"
})

L:SetOptionLocalization({
	AchievementCheck		= "Объявлять о провале достижения 'Бывало и хуже' в чат группы"
})

L:SetMiscLocalization({
	Pull				= "Великолепно. Сегодня вы в честной борьбе заслужили…",
	AchievementFailed	= ">> ДОСТИЖЕНИЕ ПРОВАЛЕНО: %s получил урон от Взрыва вурдалака <<",
	YellCombatEnd		= "Нет! Я не могу... снова... проиграть."
})

-----------------------
--  Grand Champions  --
-----------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Абсолютные чемпионы"
})

L:SetMiscLocalization({
	YellCombatEnd	= "Вы отлично сражались! Следующим испытанием станет битва с одним из членов Авангарда. Вы проверите свои силы в схватке с достойным соперником."
})

----------------------------------
--  Argent Confessor Paletress  --
----------------------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "Исповедница Пейлтресс"
})

L:SetMiscLocalization({
	YellCombatEnd	= "Превосходно!"
})

-----------------------
--  Eadric the Pure  --
-----------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "Эдрик Чистый"
})

L:SetMiscLocalization({
	YellCombatEnd	= "Я сдаюсь! Я побежден. Отличная работа. Можно теперь убегать?"
})

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "Ик и Крик"
})

----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Начальник кузни Гархлад"
})

L:SetOptionLocalization({
	AchievementCheck			= "Объявлять предупреждения о достижении 'Не жди до одиннадцати!' в чат группы"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s швыряет в вас глыбой саронита!",
	AchievementWarning	= "Предупреждение: %s получил %d стаков Вечной мерзлоты",
	AchievementFailed	= ">> ДОСТИЖЕНИЕ ПРОВАЛЕНО: %s получил %d стаков Вечной мерзлоты <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Повелитель Плети Тираний"
})

L:SetMiscLocalization({
	CombatStart	= "Увы, бесстрашные герои, ваша навязчивость ускорила развязку. Вы слышите громыхание костей и скрежет стали за вашими спинами? Это предвестники скорой погибели.",
	HoarfrostTarget	= "Ледяной змей Иней смотрит на (%S+), готовя морозную атаку!",
	YellCombatEnd	= "Не может быть... Иней… Предупреди…"
})

----------------------
--  Forge of Souls  --
----------------------
--  Bronjahm  --
----------------
L = DBM:GetModLocalization("Bronjahm")

L:SetGeneralLocalization({
	name = "Броньям"
})

-------------------------
--  Devourer of Souls  --
-------------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "Пожиратель Душ"
})

---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Таймеры волн"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Скоро новая волна",
	WarnNewWave		= "%s вступает в бой"
})

L:SetTimerLocalization({
	TimerNextWave	= "Следующая волна"
})

L:SetOptionLocalization({
	WarnNewWave			= "Предупреждение о вступлении босса в бой",
	WarnNewWaveSoon		= "Предупреждать заранее о новой волне (после босса 5-ой волны)",
	ShowAllWaveWarnings	= "Предупреждения для всех волн",
	TimerNextWave		= "Отсчет времени до следующей волны (после босса 5-ой волны)",
	ShowAllWaveTimers	= "Предупреждения и отсчет времени для всех волн (неточный)"
})

L:SetMiscLocalization({
	Falric		= "Фалрик",
	WaveCheck	= "Отражено атак призраков = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization("Falric")

L:SetGeneralLocalization({
	name = "Фалрик"
})

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization("Marwyn")

L:SetGeneralLocalization({
	name = "Марвин"
})

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization("LichKingEvent")

L:SetGeneralLocalization({
	name = "Побег от Короля-лича"
})

L:SetTimerLocalization({
	achievementEscape	= "Время для побега"
})

L:SetOptionLocalization({
	WarnWave	= "Предупреждение для прибывающих волн"
})

L:SetMiscLocalization({
	Ghoul			= "Гневный вурдалак",		--creature id 36940. Not sure how to use these in function above to simplify locals though. :\
	Abom			= "Неуклюжее поганище",		--creature id 37069
	WitchDoctor		= "Воскрешенный ведьмак",	--creature id 36941
	Wave1			= "^Бежать некуда.$",
	Wave2			= "Покоритесь леденящей смерти!",
	Wave3			= "Вы в ловушке!",
	Wave4			= "Как долго вы сможете сопротивляться?"
})
