if GetLocale() ~= "ruRU" then return end

local L

-------------------------
--  Hellfire Ramparts  --
-----------------------------
--  Watchkeeper Gargolmar  --
-----------------------------
L = DBM:GetModLocalization(527)

L:SetGeneralLocalization{
	name 		= "Начальник стражи Гарголмар"
}

--------------------------
--  Omor the Unscarred  --
--------------------------
L = DBM:GetModLocalization(528)

L:SetGeneralLocalization{
	name 		= "Омор Неодолимый"
}

------------------------
--  Nazan & Vazruden  --
------------------------
L = DBM:GetModLocalization(529)

L:SetGeneralLocalization{
	name 		= "Назан & Вазруден"
}

-------------------------
--  The Blood Furnace  --
-------------------------
--  The Maker  --
-----------------
L = DBM:GetModLocalization(555)

L:SetGeneralLocalization{
	name 		= "Мастер"
}

---------------
--  Broggok  --
---------------
L = DBM:GetModLocalization(556)

L:SetGeneralLocalization{
	name 		= "Броггок"
}

----------------------------
--  Keli'dan the Breaker  --
----------------------------
L = DBM:GetModLocalization(557)

L:SetGeneralLocalization{
	name 		= "Кели'дан Разрушитель"
}

---------------------------
--  The Shattered Halls  --
--------------------------------
--  Grand Warlock Nethekurse  --
--------------------------------
L = DBM:GetModLocalization(566)

L:SetGeneralLocalization{
	name 		= "Главный чернокнижник Пустоклят"
}

--------------------------
--  Blood Guard Porung  --
--------------------------
L = DBM:GetModLocalization(728)

L:SetGeneralLocalization{
	name 		= "Кровавый страж Порунг"
}

--------------------------
--  Warbringer O'mrogg  --
--------------------------
L = DBM:GetModLocalization(568)

L:SetGeneralLocalization{
	name 		= "О'мрогг Завоеватель"
}

----------------------------------
--  Warchief Kargath Bladefist  --
----------------------------------
L = DBM:GetModLocalization(569)

L:SetGeneralLocalization{
	name 		= "Вождь Каргат Острорук"
}

L:SetWarningLocalization({
	warnHeathen			= "Страж-язычник",
	warnReaver			= "Стражник-разоритель",
	warnSharpShooter	= "Меткий стрелок-страж",
})

L:SetTimerLocalization({
	timerHeathen		= "Страж-язычник: %s",
	timerReaver			= "Стражник-разоритель: %s",
	timerSharpShooter	= "Меткий стрелок-страж: %s"
})

L:SetOptionLocalization({
	warnHeathen			= "Показывать предупреждение для Страж-язычник",
	timerHeathen		= "Показывать таймер для Страж-язычник",
	warnReaver			= "Показывать предупреждение для Стражник-разоритель",
	timerReaver			= "Показывать таймер для Стражник-разоритель",
	warnSharpShooter	= "Показывать предупреждение для Меткий стрелок-страж",
	timerSharpShooter	= "Показывать таймер для Меткий стрелок-страж"
})

------------------
--  Slave Pens  --
--------------------------
--  Mennu the Betrayer  --
--------------------------
L = DBM:GetModLocalization(570)

L:SetGeneralLocalization{
	name 		= "Менну Предатель"
}

---------------------------
--  Rokmar the Crackler  --
---------------------------
L = DBM:GetModLocalization(571)

L:SetGeneralLocalization{
	name 		= "Рокмар Трескун"
}

------------------
--  Quagmirran  --
------------------
L = DBM:GetModLocalization(572)

L:SetGeneralLocalization{
	name 		= "Зыбун"
}

--------------------
--  The Underbog  --
--------------------
--  Hungarfen  --
-----------------
L = DBM:GetModLocalization(576)

L:SetGeneralLocalization{
	name 		= "Топеглад"
}

---------------
--  Ghaz'an  --
---------------
L = DBM:GetModLocalization(577)

L:SetGeneralLocalization{
	name 		= "Газ'ан"
}

--------------------------
--  Swamplord Musel'ek  --
--------------------------
L = DBM:GetModLocalization(578)

L:SetGeneralLocalization{
	name 		= "Владыка болот Мусел'ек"
}

-------------------------
--  The Black Stalker  --
-------------------------
L = DBM:GetModLocalization(579)

L:SetGeneralLocalization{
	name 		= "Черная Охотница"
}

----------------------
--  The Steamvault  --
---------------------------
--  Hydromancer Thespia  --
---------------------------
L = DBM:GetModLocalization(573)

L:SetGeneralLocalization{
	name 		= "Гидромантка Теспия"
}

-----------------------------
--  Mekgineer Steamrigger  --
-----------------------------
L = DBM:GetModLocalization(574)

L:SetGeneralLocalization{
	name 		= "Анжинер Паропуск"
}

L:SetWarningLocalization({
	warnSummon	= "Механик паровой оснастки - Смени Цель"
})

L:SetOptionLocalization({
	warnSummon	= "Показывать предупреждение для Механик паровой оснастки"
})

L:SetMiscLocalization({
	Mechs	= "Эй, ребята, тут надо кое-что настроить!"
})

--------------------------
--  Warlord Kalithresh  --
--------------------------
L = DBM:GetModLocalization(575)

L:SetGeneralLocalization{
	name 		= "Полководец Калитреш"
}

-----------------------
--  Auchenai Crypts  --
--------------------------------
--  Shirrak the Dead Watcher  --
--------------------------------
L = DBM:GetModLocalization(523)

L:SetGeneralLocalization{
	name 		= "Ширрак Страж Мертвых"
}

-----------------------
--  Exarch Maladaar  --
-----------------------
L = DBM:GetModLocalization(524)

L:SetGeneralLocalization{
	name 		= "Экзарх Маладаар"
}

------------------
--  Mana-Tombs  --
------------------
--    Trash     --
------------------
L = DBM:GetModLocalization("AuctTombsTrash")

L:SetGeneralLocalization{
	name 		= "Трэш"
}

-------------------
--  Pandemonius  --
-------------------
L = DBM:GetModLocalization(534)

L:SetGeneralLocalization{
	name 		= "Пандемоний"
}

---------------
--  Tavarok  --
---------------
L = DBM:GetModLocalization(535)

L:SetGeneralLocalization{
	name 		= "Таварок"
}

----------------------------
--  Nexus-Prince Shaffar  --
----------------------------
L = DBM:GetModLocalization(537)

L:SetGeneralLocalization{
	name 		= "Принц Шаффар"
}

-----------
--  Yor  --
-----------
L = DBM:GetModLocalization(536)

L:SetGeneralLocalization{
	name 		= "Йор"
}

---------------------
--  Sethekk Halls  --
-----------------------
--  Darkweaver Syth  --
-----------------------
L = DBM:GetModLocalization(541)

L:SetGeneralLocalization{
	name 		= "Темнопряд Сит"
}

L:SetWarningLocalization({
	warnSummon	= "Призыв Элементалей"
})

L:SetOptionLocalization({
	warnSummon	= "Показывать предупреждение для призванных элементалей"
})

------------
--  Anzu  --
------------
L = DBM:GetModLocalization(542)

L:SetGeneralLocalization{
	name 		= "Анзу"
}

L:SetWarningLocalization({
	warnBrood	= "Потомок Анзу",
	warnStoned	= "%s returned to stone"
})

L:SetOptionLocalization({
	warnBrood	= "Показывать предупреждение для Потомок Анзу",
	warnStoned	= "Показывать предупреждение для spirits returning to stone"
})

L:SetMiscLocalization({
    BirdStone	= "%s returns to stone."
})

------------------------
--  Talon King Ikiss  --
------------------------
L = DBM:GetModLocalization(543)

L:SetGeneralLocalization{
	name 		= "Король воронов Айкисс"
}

------------------------
--  Shadow Labyrinth  --
--------------------------
--  Ambassador Hellmaw  --
--------------------------
L = DBM:GetModLocalization(544)

L:SetGeneralLocalization{
	name 		= "Посол Гиблочрев"
}

------------------------------
--  Blackheart the Inciter  --
------------------------------
L = DBM:GetModLocalization(545)

L:SetGeneralLocalization{
	name 		= "Черносерд Подстрекатель"
}

--------------------------
--  Grandmaster Vorpil  --
--------------------------
L = DBM:GetModLocalization(546)

L:SetGeneralLocalization{
	name 		= "Великий мастер Ворпил"
}

--------------
--  Murmur  --
--------------
L = DBM:GetModLocalization(547)

L:SetGeneralLocalization{
	name 		= "Бормотун"
}

-------------------------------
--  Old Hillsbrad Foothills  --
-------------------------------
--  Lieutenant Drake  --
------------------------
L = DBM:GetModLocalization(538)

L:SetGeneralLocalization{
	name 		= "Лейтенант Дрейк"
}

-----------------------
--  Captain Skarloc  --
-----------------------
L = DBM:GetModLocalization(539)

L:SetGeneralLocalization{
	name 		= "Капитан Скарлок"
}

--------------------
--  Epoch Hunter  --
--------------------
L = DBM:GetModLocalization(540)

L:SetGeneralLocalization{
	name 		= "Охотник Вечности"
}

------------------------
--  The Black Morass  --
------------------------
--  Chrono Lord Deja  --
------------------------
L = DBM:GetModLocalization(552)

L:SetGeneralLocalization{
	name 		= "Повелитель времени Дежа"
}

----------------
--  Temporus  --
----------------
L = DBM:GetModLocalization(553)

L:SetGeneralLocalization{
	name 		= "Темпорус"
}

--------------
--  Aeonus  --
--------------
L = DBM:GetModLocalization(554)

L:SetGeneralLocalization{
	name 		= "Эонус"
}

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "Таймеры Порталов (ПВ)"
})

L:SetWarningLocalization({
    WarnWavePortalSoon	= "Скоро новый портал",
    WarnWavePortal		= "Портал %d",
    WarnBossPortal		= "Появился босс"
})

L:SetTimerLocalization({
	TimerNextPortal		= "Портал %d"
})

L:SetOptionLocalization({
    WarnWavePortalSoon	= "Показывать предварительное предупреждение для нового портала",
    WarnWavePortal		= "Показывать предупреждение для нового портала",
    WarnBossPortal		= "Показывать предупреждение для появления босса",
	TimerNextPortal		= "Показывать таймер для следующего портала (после Босса)",
	ShowAllPortalTimers	= "Показывать таймеры для всех порталов (неточно)"
})

L:SetMiscLocalization({
	Shielddown			= "Нет! Будь проклята эта жалкая смертная оболочка!"
})

--------------------
--  The Mechanar  --
-----------------------------
--  Gatewatcher Gyro-Kill  --
-----------------------------
L = DBM:GetModLocalization("Gyrokill")--Not in EJ

L:SetGeneralLocalization({
	name = "Страж ворот Точеный Нож"
})

-----------------------------
--  Gatewatcher Iron-Hand  --
-----------------------------
L = DBM:GetModLocalization("Ironhand")--Not in EJ

L:SetGeneralLocalization({
	name = "Страж ворот Стальная Клешня"
})

L:SetMiscLocalization({
	JackHammer	= "%s угрожающе поднимает свой молот..."
})

------------------------------
--  Mechano-Lord Capacitus  --
------------------------------
L = DBM:GetModLocalization(563)

L:SetGeneralLocalization{
	name 		= "Механолорд Конденсарон"
}

------------------------------
--  Nethermancer Sepethrea  --
------------------------------
L = DBM:GetModLocalization(564)

L:SetGeneralLocalization{
	name 		= "Пустомант Сепетрея"
}

--------------------------------
--  Pathaleon the Calculator  --
--------------------------------
L = DBM:GetModLocalization(565)

L:SetGeneralLocalization{
	name 		= "Паталеон Вычислитель"
}

--------------------
--  The Botanica  --
--------------------------
--  Commander Sarannis  --
--------------------------
L = DBM:GetModLocalization(558)

L:SetGeneralLocalization{
	name 		= "Командир Сараннис"
}

------------------------------
--  High Botanist Freywinn  --
------------------------------
L = DBM:GetModLocalization(559)

L:SetGeneralLocalization{
	name 		= "Верховный ботаник Фрейвин"
}

-----------------------------
--  Thorngrin the Tender  --
-----------------------------
L = DBM:GetModLocalization(560)

L:SetGeneralLocalization{
	name 		= "Скалезуб Скорбный"
}

-----------
--  Laj  --
-----------
L = DBM:GetModLocalization(561)

L:SetGeneralLocalization{
	name 		= "Ладж"
}

---------------------
--  Warp Splinter  --
---------------------
L = DBM:GetModLocalization(562)

L:SetGeneralLocalization{
	name 		= "Узлодревень"
}

--------------------
--  The Arcatraz  --
----------------------------
--  Zereketh the Unbound  --
----------------------------
L = DBM:GetModLocalization(548)

L:SetGeneralLocalization{
	name 		= "Зерекет Бездонный"
}

-----------------------------
--  Dalliah the Doomsayer  --
-----------------------------
L = DBM:GetModLocalization(549)

L:SetGeneralLocalization{
	name 		= "Даллия Глашатай Судьбы"
}

---------------------------------
--  Wrath-Scryer Soccothrates  --
---------------------------------
L = DBM:GetModLocalization(550)

L:SetGeneralLocalization{
	name 		= "Провидец Гнева Соккорат"
}

-------------------------
--  Harbinger Skyriss  --
-------------------------
L = DBM:GetModLocalization(551)

L:SetGeneralLocalization{
	name 		= "Предвестник Скайрисс"
}

L:SetWarningLocalization({
	warnSplitSoon	= "Иллюзия Предвестника Скоро",
	warnSplit		= "Иллюзия Предвестника"
})

L:SetOptionLocalization({
	warnSplitSoon	= "Показывать предупреждение для Иллюзия Предвестника скоро",
	warnSplit		= "Показывать предупреждение для Иллюзия Предвестника"
})

L:SetMiscLocalization({
	Split	= "Мы бесчисленны, как звезды! Мы заполоним вселенную!"
})

--------------------------
--  Magisters' Terrace  --
--------------------------
--  Selin Fireheart  --
-----------------------
L = DBM:GetModLocalization(530)

L:SetGeneralLocalization{
	name 		= "Селин Огненное Сердце"
}

L:SetWarningLocalization({
    warningFelCrystal	= "Кристалл Скверны - Смени Цель"
})

L:SetTimerLocalization({
	timerFelCrystal		= "~Кристалл Скверны"
})

L:SetOptionLocalization({
	warningFelCrystal	= "Показывать особое предупреждение смены целей для Кристалл Скверны",
    timerFelCrystal		= "Показывать таймер для Кристалл Скверны"
})

----------------
--  Vexallus  --
----------------
L = DBM:GetModLocalization(531)

L:SetGeneralLocalization{
	name 		= "Вексалиус"
}

L:SetWarningLocalization({
	warnEnergy	= "Чистая энергия - Смени Цель"
})

L:SetOptionLocalization({
	warnEnergy	= "Показывать предупреждение для Чистая энергия"
})

--------------------------
--  Priestess Delrissa  --
--------------------------
L = DBM:GetModLocalization(532)

L:SetGeneralLocalization{
	name 		= "Жрица Делрисса"
}

L:SetMiscLocalization({
	DelrissaEnd		= "На это... я... не рассчитывала..."
})

------------------------------------
--  Kael'thas Sunstrider (Party)  --
------------------------------------
L = DBM:GetModLocalization(533)

L:SetGeneralLocalization{
	name 		= "Кель'тас Солнечный Скиталец (Группа)"
}

L:SetMiscLocalization({
	KaelP2	= "Я переверну ваш мир... вверх... дном."
})
