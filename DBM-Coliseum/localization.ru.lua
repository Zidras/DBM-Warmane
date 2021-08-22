if GetLocale() ~= "ruRU" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Чудовища Нордскола"
}

L:SetWarningLocalization{
	WarningSnobold		= "Призыв снобольда-вассала на >%s<",
}

L:SetTimerLocalization{
	TimerNextBoss		= "Прибытие следующего босса",
	TimerEmerge			= "Появление",
	TimerSubmerge		= "Зарывание"
}

L:SetOptionLocalization{
	WarningSnobold		= "Предупреждение о призыве Снобольда-вассала",
	PingCharge			= "Показать на миникарте место, куда попадает Ледяной Рев, если он избрал вас целью",
	ClearIconsOnIceHowl	= "Снимать все иконки перед Топотом",
	TimerNextBoss		= "Отсчет времени до появления следующего противника",
	TimerEmerge			= "Отсчет времени до появления",
	TimerSubmerge		= "Отсчет времени до зарывания",
	IcehowlArrow		= "Показывать стрелку, когда Ледяной Рев готовится сделать рывок на цель рядом с вами"
}

L:SetMiscLocalization{
	Charge				= "^%%s глядит на (%S+) и испускает гортанный вой!",
	CombatStart			= "Из самых глубоких и темных пещер Грозовой Гряды был призван Гормок Пронзающий Бивень! В бой, герои!",
	Phase2				= "Приготовьтесь к схватке с близнецами-чудовищами, Кислотной Утробой и Жуткой Чешуей!",
	Phase3				= "В воздухе повеяло ледяным дыханием следующего бойца: на арену выходит Ледяной Рев! Сражайтесь или погибните, чемпионы!",
	Gormok				= "Гормок Пронзающий Бивень",
	Acidmaw				= "Кислотная Утроба",
	Dreadscale			= "Жуткая Чешуя",
	Icehowl				= "Ледяной Рев"
}

---------------------
--  Lord Jaraxxus  --
---------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Лорд Джараксус"
}

L:SetOptionLocalization{
	IncinerateShieldFrame	= "Показать здоровье босса с индикатором здоровья для Испепеления плоти"
}

L:SetMiscLocalization{
	IncinerateTarget		= "Испепеление плоти: %s",
	FirstPull				= "Сейчас великий чернокнижник Вилфред Непопамс призовет вашего нового противника. Готовьтесь к бою!"
}

-------------------------
--  Faction Champions  --
-------------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Чемпионы фракций"
}

L:SetMiscLocalization{
	--Horde NPCs
	Gorgrim				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:64:64:96|t Горгрим Темный Раскол",			-- 34458
	Birana				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Бирана Штормовое Копыто",		-- 34451
	Erin				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Эрин Мглистое Копыто",			-- 34459
	Rujkah				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t Руж'ка",							-- 34448
	Ginselle			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:0:32|t Гинзелль Отразительница Гнили",	-- 34449
	Liandra				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Лиандра Зовущая Солнце",			-- 34445
	Malithas			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Малитас Сияющий Клинок",			-- 34456
	Caiphus				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Каифа Неумолимый",				-- 34447
	Vivienne			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Вивьен Шепот Тьмы",			-- 34441
	Mazdinah			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:0:32|t Маз'дина",						-- 34454
	Thrakgar			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Тракгар",						-- 34444
	Broln				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Бролн Крепкий Рог",			-- 34455
	Harkzog				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:32:64|t Харкзог",						-- 34450
	Narrhok				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:0:32|t Наррок Крушитель Стали",			-- 34453
	--Alliance NPCs
	Tyrius				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:64:64:96|t Тирий Клинок Сумерек",			-- 34461
	Kavina				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Кавина Песня Рощи",			-- 34460
	Melador				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Меладор Дальний Гонец",		-- 34469
	Alyssia             = "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t Алисса Лунопард",					-- 34467
	Noozle				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:0:32|t Нуззл Чудодей",					-- 34468
	Baelnor				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Бельнор Светоносный",				-- 34471
	Velanaa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Веланаа",							-- 34465
	Anthar				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Антар Очистительный Горн",		-- 34466
	Brienna				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Бриенна Приход Ночи",			-- 34473
	Irieth				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:0:32|t Ириэт Шаг Сквозь Тень",			-- 34472
	Saamul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Саамул",						-- 34470
	Shaabad				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Шаабад",						-- 34463
	Serissa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:32:64|t Серисса Мрачная Кропильщица",	-- 34474
	Shocuul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:0:32|t Шокул",							-- 34475

	AllianceVictory		= "СЛАВА АЛЬЯНСУ!",
	HordeVictory		= "Это было лишь пробой того, что ждет нас в будущем! ЗА ОРДУ!"
	--YellKill			= "Пустая и горькая победа. После сегодняшних потерь мы стали слабее как целое. Кто еще, кроме Короля-лича, выиграет от подобной глупости? Пали великие воины. И ради чего? Истинная опасность еще впереди – нас ждет битва с Королем-личом."
}

---------------------
--  Val'kyr Twins  --
---------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "Валь'киры-близнецы"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Следующая спец-способность",
	TimerAnubRoleplay	= "Представление перед падением"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Скоро спец-способность",
	SpecWarnSpecial				= "Смена цвета",
	SpecWarnSwitchTarget		= "Смена цели",
	SpecWarnKickNow				= "Прерывание",
	WarningTouchDebuff			= "Отрицательный эффект на |3-5(>%s<)",
	WarningPoweroftheTwins2		= "Сила близнецов - больше исцеления на |3-3(>%s<)",
}

L:SetMiscLocalization{
	--YellPull	= "Во имя темного повелителя. Во имя Короля-лича. Вы. Умрете.",
	CombatStart	= "Лишь сплотившись, вы сможете пройти последнее испытание. Из глубин Ледяной Короны навстречу вам подымаются две могучие воительницы Плети: жуткие валь'киры, крылатые вестницы Короля-лича!",
	Fjola		= "Фьола Погибель Света",
	Eydis		= "Эйдис Погибель Тьмы",
	AnubRP		= "Король-лич понес тяжелую потерю! Вы проявили себя как бесстрашные герои Серебряного Авангарда! Мы вместе нанесем удар по Цитадели Ледяной Короны и разнесем в клочья остатки Плети! Нет такого испытания, которое мы бы не могли пройти сообща!"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Отсчет времени до перезарядки спец-способности",
	TimerAnubRoleplay			= "Таймер представления перед падением (после победы)",
	WarnSpecialSpellSoon		= "Предупреждение о следующуюей спец-способность",
	SpecWarnSpecial				= "Спец-предупреждение для смены цветов",
	SpecWarnSwitchTarget		= "Спец-предупреждение для других, когда босс читает заклинание",
	SpecWarnKickNow				= "Спец-предупреждение, когда вы должы прервать заклинание",
	SpecialWarnOnDebuff			= "Спец-предупреждение, когда отрицательный эффект",
	SetIconOnDebuffTarget		= "Установить метку на получившего отрицательный эффект (героический режим)",
	WarningTouchDebuff			= "Объявлять цели, получившие отрицательный эффект",
	WarningPoweroftheTwins2		= "Объявлять цель под воздействем Силы близнецов",
}

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name					= "Ануб'арак"
}

L:SetTimerLocalization{
	TimerEmerge				= "Появление через",
	TimerSubmerge			= "Зарывание через",
	timerAdds				= "Призыв помощников через"
}

L:SetWarningLocalization{
	WarnEmerge				= "Ануб'арак появляется",
	WarnEmergeSoon			= "Появление через 10 сек",
	WarnSubmerge			= "Ануб'арак зарывается",
	WarnSubmergeSoon		= "Зарывание через 10 сек",
	warnAdds				= "Новые помощники"
}

L:SetMiscLocalization{
--	YellPull			= "Это место станет вашей могилой!",
	Emerge				= "вылезает на поверхность!",
	Burrow				= "зарывается в землю!",
	PcoldIconSet		= "Метка холода {rt%d} установлена на: %s",
	PcoldIconRemoved	= "Метка холода снята с: %s"
}

L:SetOptionLocalization{
	WarnEmerge				= "Предупреждение о появлении",
	WarnEmergeSoon			= "Предупреждать заранее о появлении",
	WarnSubmerge			= "Предупреждение о зарывании",
	WarnSubmergeSoon		= "Предупреждать заранее о зарывании",
	warnAdds				= "Предупреждение о призыве помощников",
	timerAdds				= "Отсчет времени до призыва помощников",
	TimerEmerge				= "Отсчет времени до появления",
	TimerSubmerge			= "Отсчет времени до зарывания",
	AnnouncePColdIcons		= "Объявлять метки целей заклинания $spell:68510 в рейд-чат<br/>(требуются права лидера или помощника)",
	AnnouncePColdIconsRemoved	= "Объявлять также о снятии меток с целей заклинания $spell:68510<br/>(требуется предыдущая опция)",
	RemoveHealthBuffsInP3	= "Удалять усиления здоровья в начале фазы 3"
}
