if GetLocale() ~= "ruRU" then return end

DBM_HOW_TO_USE_MOD					= "Добро пожаловать в DBM. Наберите /dbm help чтобы получить список поддерживаемых команд. Для доступа к настройкам наберите /dbm в чате. Загрузите конкретные зоны вручную чтобы настроить определенных боссов по вашему вкусу. DBM установит настройки по умолчанию для вашей специализации, но вы возможно захотите настроить их более тонко."
DBM_SILENT_REMINDER					= "Напоминание: DBM всё еще в тихом режиме."

DBM_CORE_UPDATEREMINDER_URL			= "https://github.com/ArsumPB/DBM-wowcircle"

DBM_COPY_URL_DIALOG					= "Копировать ссылку"

DBM_CORE_NEED_SUPPORT				= "Вы - программист или хороший переводчик? Команда разработчиков DBM нуждается в вашей помощи. Присоединяйтесь к нам -  зайдите или отправьте сообщение на tandanu@deadlybossmods.com или nitram@deadlybossmods.com."

DBM_CORE_LOAD_MOD_ERROR				= "Ошибка при загрузке DBM для %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Загружен DBM для \"%s\", введите /dbm для вызова настроек!"
DBM_CORE_LOAD_GUI_ERROR				= "Не удалось загрузить GUI: %s"

DBM_CORE_COMBAT_STARTED				= "%s вступает в бой. Удачи! :)";
DBM_CORE_BOSS_DOWN					= "%s погибает спустя %s!"
DBM_CORE_BOSS_DOWN_LONG				= "%s погибает спустя %s! Последний бой длился %s, лучший бой длился %s."
DBM_CORE_BOSS_DOWN_NEW_RECORD		= "%s погибает спустя %s! Это новая запись! (Предшествующая запись была %s)"
DBM_CORE_COMBAT_ENDED				= "Бой с %s длился %s"

DBM_CORE_TIMER_FORMAT_SECS			= "%d сек"
DBM_CORE_TIMER_FORMAT_MINS			= "%d мин"
DBM_CORE_TIMER_FORMAT				= "%d мин %d сек"

DBM_CORE_MIN						= "мин"
DBM_CORE_MIN_FMT					= "%d мин"
DBM_CORE_SEC						= "сек"
DBM_CORE_SEC_FMT					= "%d сек"
DBM_CORE_DEAD						= "мертв"
DBM_CORE_OK							= "ОК"

DBM_CORE_GENERIC_WARNING_BERSERK	= "Берсерк через %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Берсерк"
DBM_CORE_OPTION_TIMER_BERSERK		= "Отсчет времени до $spell:26662"
DBM_CORE_OPTION_HEALTH_FRAME		= "Отображать здоровье босса"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Индикаторы"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Предупреждения"
DBM_CORE_OPTION_CATEGORY_MISC		= "Прочее"
DBM_CORE_OPTION_CATEGORY_TIMERS			= "Индикаторы"
--Sub cats for "announce" object
DBM_CORE_OPTION_CATEGORY_WARNINGS		= "Общие предупреждения"
DBM_CORE_OPTION_CATEGORY_WARNINGS_YOU	= "Персональные предупреждения"
DBM_CORE_OPTION_CATEGORY_WARNINGS_OTHER	= "Предупреждения для цели"
DBM_CORE_OPTION_CATEGORY_WARNINGS_ROLE	= "Предупреждения для роли"

DBM_CORE_OPTION_CATEGORY_SOUNDS			= "Звуки"
--Misc object broken down into sub cats
DBM_CORE_OPTION_CATEGORY_DROPDOWNS		= "Dropdowns"--Still put in MISC sub grooup, just used for line separators since multiple of these on a fight (or even having on of these at all) is rare.
DBM_CORE_OPTION_CATEGORY_YELLS			= "Крики"
DBM_CORE_OPTION_CATEGORY_ICONS			= "Метки"
DBM_CORE_AUTO_RESPONDED				= "Авто-ответ."
DBM_CORE_STATUS_WHISPER				= "%s: %s, %d/%d человек живые"
DBM_CORE_AUTO_RESPOND_WHISPER		= "%s сейчас не может ответить, в бою с %s (%s, %d/%d человек живые)"
DBM_CORE_WHISPER_COMBAT_END_KILL	= "%s одержал победу над %s!"
DBM_CORE_WHISPER_COMBAT_END_WIPE	= "%s потерпел поражение от %s"

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - версии"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM не установлен"
DBM_CORE_VERSIONCHECK_FOOTER		= "Найдено %d |4игрок:игрока:игроков; с установленным Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Ваша версия Deadly Boss Mods устарела! Пожалуйста, посетите https://github.com/ArsumPB/DBM-wowcircle для загрузки последней версии."

DBM_CORE_UPDATEREMINDER_HEADER		= "Ваша версия Deadly Boss Mods устарела.\n Версия %s (r%d) доступна для загрузки здесь:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Нажмите CTRL+C, чтобы скопировать ссылку загрузки в буфер обмена."
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Всплывающее сообщение при наличии новой версии"

DBM_CORE_MOVABLE_BAR				= "Перетащите!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h транслирует DBM Timer: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Отменить этот DBM Timer]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Игнорировать DBM Timer от %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Вы действительно хотите проигнорировать DBM Timer данного сеанса от %s?"
DBM_PIZZA_ERROR_USAGE				= "Использование: /dbm [broadcast] timer <time> <text>"

DBM_CORE_ERROR_DBMV3_LOADED			= "Deadly Boss Mods запущен дважды, поскольку установлены DBMv3 и DBMv4 и включены!\nНажмите кнопку \"ОК\" для отключения DBMv3 и перезагрузки интерфейса.\nНаведите порядок в вашей папке AddOns, удалите старые папки DBMv3."

DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+щелчок или щелкните правой кнопкой мыши, чтобы переместить"

DBM_CORE_RANGECHECK_HEADER			= "Проверка дистанции (%d м)"
DBM_CORE_RANGECHECK_SETRANGE		= "Настройка дистанции"
DBM_CORE_RANGECHECK_SOUNDS			= "Звуки"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Звуковой сигнал, когда игрок находится в диапазоне"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Звуковой сигнал для всех остальных игроков в диапазоне"
DBM_CORE_RANGECHECK_SOUND_0			= "Без звука"
DBM_CORE_RANGECHECK_SOUND_1			= "По умолчанию"
DBM_CORE_RANGECHECK_SOUND_2			= "Раздражающий звуковой сигнал"
DBM_CORE_RANGECHECK_HIDE			= "Скрыть"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d м"
DBM_CORE_RANGECHECK_LOCK			= "Закрепить полосу"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Окна"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Отображать только радар"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Отображать только текствое окно"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Отображать оба варианта"
DBM_CORE_RANGERADAR_HEADER			= "Радар (%d метров)"
DBM_CORE_RANGECHECK_OPTION_SPEED	= "Скорость обновления (/reload)"
DBM_CORE_RANGECHECK_OPTION_SLOW		= "Медленная 0.5 сек (наименее CPU интенсивное)"
DBM_CORE_RANGECHECK_OPTION_AVERAGE	= "Средняя 0.25 сек "
DBM_CORE_RANGECHECK_OPTION_FAST		= "Быстрая 0.05 сек (почти real-time)"
DBM_LFG_INVITE						= "Приглашение в подземелье"
DBM_LFG_CD                          = "Восстановление ПП"
DBM_PHASE							= "%d-я фаза"

DBM_CORE_SLASHCMD_HELP				= {
	"Доступные (/) команды:",
	"/dbm pull: начинает отсчет атаки (псевдоним: /pull)",
	"/dbm version: выполнение проверки используемой рейдом версии (псевдоним: ver)",
	"/dbm ver2: выполнение проверки используемой рейдом версии (отчет в рейд чат)",
	"/dbm unlock: отображение перемещаемой строки состояния таймера (псевдоним: move)",
	"/dbm timer <x> <text>: начинает отсчет <x> сек. Pizza Timer с именем <text>",
	"/dbm broadcast timer <x> <text>: транслирует <x> сек. Pizza Timer с именем <text> в рейд (требуются права лидера или помощника)",
	"/dbm break <min>: начинает отсчет отдыха на <min> мин., транслирует отсчет отдыха всем членам рейда с DBM (требуются права лидера или помощника).",
	"/dbm help: вывод этой справки",
}

DBM_ERROR_NO_PERMISSION				= "У вас недостаточно прав, для выполнение этой операции."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Скрыть"

DBM_CORE_ALLIANCE					= "Альянс"
DBM_CORE_HORDE						= "Орда"

DBM_CORE_UNKNOWN					= "неизвестно"

DBM_CORE_BREAK_START				= "Перерыв начинается -- у вас есть %s мин.!"
DBM_CORE_BREAK_MIN					= "Перерыв заканчивается через %s мин.!"
DBM_CORE_BREAK_SEC					= "Перерыв заканчивается через %s сек.!"
DBM_CORE_TIMER_BREAK				= "Перерыв!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "Перерыв закончился"

DBM_CORE_TIMER_PULL					= "Атака"
DBM_CORE_ANNOUNCE_PULL				= "Атака через %d сек."
DBM_CORE_ANNOUNCE_PULL_NOW			= "Атака!"
DBM_CORE_ANNOUNCE_PULL_TARGET		= "Атакуем %s через %d сек. (отправил %s)"
DBM_CORE_ANNOUNCE_PULL_NOW_TARGET	= "Атакуем %s!"
DBM_CORE_GEAR_WARNING_WEAPON		= "Внимание: Проверьте надето ли у вас корректное оружие."
DBM_CORE_GEAR_FISHING_POLE			= "Удочки"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Быстрое убийство"


-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.you 			= "%s на тебе"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target 		= "%s на |3-5(>%%s<)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetsource   = ">%%s< применяется %s на >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) на |3-5(>%%s<)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell 			= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.ends			= "%s заканчивается"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.endtarget		= "%s заканчивается: >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.fades			= "%s спадает"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds			= "Осталось %s: %%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast 			= "Применение заклинания %s: %.1f сек"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon 			= "Скоро %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.sooncount		= "Скоро %s (%%s)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn		= "%s через %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.bait			= "Скоро %s - байти"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage			= "Фаза %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prestage		= "Скоро фаза %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count 			= "%s (%%s)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack 			= "%s на |3-5(>%%s<) (%%d)"

local prewarnOption = "Предупреждать заранее о $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.you 			= "Объявлять когда $spell:%s на тебе"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target 		= "Объявлять цели заклинания |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetsource	= "Объявлять цели заклинания $spell:%s (с источником)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "Объявлять цели заклинания $spell:%s (со счетчиком)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell 		= "Предупреждение для $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.ends			= "Предупреждать об окончании $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.endtarget	= "Предупреждать об окончании $spell:%s (цель)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades		= "Предупреждать о спадении $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds			= "Объявлять сколько осталось $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast 		= "Предупреждать о применении заклинания $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon 		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.sooncount	= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn 		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.bait			= "Предупреждать заранее (чтобы байтить) для $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stage 		= "Объявлять фазу %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stagechange	= "Объявлять смены фаз"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prestage 	= "Предупреждать заранее о фазе %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count 		= "Предупреждение для $spell:%s (со счетчиком)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack 		= "Объявлять количество стаков $spell:%s"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell				= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends				= "%s заканчивается"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades				= "%s спадает"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon				= "Скоро %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.sooncount			= "Скоро %s (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.bait				= "Скоро %s - байти"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.prewarn			= "%s через %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel 			= "%s на |3-5(>%%s<) - рассейте заклинание"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - прервите >%%s<!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - прервите >%%s<! (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you 				= "%s на вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youcount			= "%s (%%s) на вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youpos			= "%s (Позиция: %%s) на вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soakpos			= "%s (Позиция погл.: %%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target 			= "%s на |3-5(>%%s<)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetcount		= "%s (%%s) на >%%s< "
DBM_CORE_AUTO_SPEC_WARN_TEXTS.defensive			= "%s - защититесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.taunt				= "%s на >%%s< - затаунти"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close 			= "%s на |3-5(>%%s<) около вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move 				= "%s - отбегите"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.keepmove			= "%s - продолжайте двигаться"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stopmove			= "%s - остановитесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodge				= "%s - избегайте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodgecount		= "%s (%%s) - избегайте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodgeloc			= "%s - избегайте от %%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveaway			= "%s - отбегите от остальных"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveawaycount		= "%s (%%s) - отбегите от остальных"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveto			= "%s - бегите к >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soak				= "%s - перекройте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.jump				= "%s - подпрыгните"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run 				= "%s - убегайте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast 				= "%s - прекратите чтение заклинаний"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.lookaway			= "%s на %%s - отвернитесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect 			= "%s на |3-5(>%%s<) - прекратите атаку"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count 			= "%s! (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack 			= "На вас %%d стаков от %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch 			= "%s - переключитесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switchcount 		= "%s - переключитесь (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.gtfo				= "Под вами %%s - выбегите"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.adds				= "Прибыли адды - смените цель"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.addscustom		= "Прибыли адды - %%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetchange		= "Смена цели - переключитесь на %%s"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell 			= "Спец-предупреждение для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends 			= "Спец-предупреждение об окончании $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades 			= "Спец-предупреждение о спадении $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon 			= "Спец-предупреждение что скоро $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.sooncount		= "Спец-предупреждение (со счетчиком) для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.bait			= "Спец-предупреждение (для байта) для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.prewarn 		= "Спец-предупреждение за %s сек. до $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel 			= "Спец-предупреждение для рассеивания/похищения заклинания $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt		= "Спец-предупреждение для прерывания заклинания $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount	= "Спец-предупреждение (со счетчиком) для прерывания заклинания $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you 			= "Спец-предупреждение, когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youcount		= "Спец-предупреждение (со счетчиком), когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youpos			= "Спец-предупреждение (с позицией) когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soakpos			= "Спец-предупреждение (с позицией) для помощи с поглощением $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target 			= "Спец-предупреждение, когда на ком-то $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetcount		= "Спец-предупреждение (со счетчиком), когда на ком-то $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.defensive 		= "Спец-предупреждение для использования защитных способностей от $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.taunt 			= "Спец-предупреждение \"затаунти\", когда на другом танке $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close 			= "Спец-предупреждение, когда на ком-то рядом с вами $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move 			= "Спец-предупреждение \"отбегите\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.keepmove 		= "Спец-предупреждение \"продолжайте двигаться\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stopmove 		= "Спец-предупреждение \"остановитесь\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge 			= "Спец-предупреждение \"избегайте\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodgecount		= "Спец-предупреждение \"избегайте\" (со счетчиком) для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodgeloc		= "Спец-предупреждение \"избегайте\" (с местом) для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway		= "Спец-предупреждение \"отбегите от остальных\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveawaycount	= "Спец-предупреждение \"отбегите от остальных\" (со счетчиком) для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveto			= "Спец-предупреждение \"бегите к кому-то\", на ком $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soak			= "Спец-предупреждение \"перекройте\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.jump			= "Спец-предупреждение \"подпрыгните\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run 			= "Спец-предупреждение \"убегайте\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast 			= "Спец-предупреждение \"прекратите чтение заклинаний\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.lookaway		= "Спец-предупреждение \"отвернитесь\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect 		= "Спец-предупреждение \"прекратите атаку\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 			= "Спец-предупреждение (со счетчиком) для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack 			= "Спец-предупреждение, когда на вас >=%d стаков $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch			= "Спец-предупреждение о смене цели для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount 	= "Спец-предупреждение (со счетчиком) о смене цели для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.gtfo 			= "Спец-предупреждение выбегите из войды на земле"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.adds			= "Спец-предупреждение сменить цель для прибывающих аддов"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.addscustom		= "Спец-предупреждение для прибывающих аддов"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetchange	= "Спец-предупреждение для смены приоритетной цели"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target 		= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast 			= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.castcount		= "%s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.castsource	= "%s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s заканчивается" --Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades			= "%s спадает" --Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.ai			= "%s ИИ"
DBM_CORE_AUTO_TIMER_TEXTS.cd 			= "Восст. %s"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "Восст. %s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource		= "Восст. %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cdspecial		= "Восст. спец-способности"
DBM_CORE_AUTO_TIMER_TEXTS.next 			= "След. %s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount		= "След. %s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "След. %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.nextspecial	= "След. спец-способность"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.stage			= "След. фаза"
DBM_CORE_AUTO_TIMER_TEXTS.adds			= "Прибытие аддов"
DBM_CORE_AUTO_TIMER_TEXTS.addscustom	= "Прибытие аддов (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.roleplay		= GUILD_INTEREST_RP

DBM_CORE_AUTO_TIMER_OPTIONS.target 		= "Отсчет времени действия дебаффа $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cast 		= "Отсчет времени применения заклинания $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.castcount	= "Отсчет времени применения заклинания (со счетчиком) для $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.castsource	= "Отсчет времени применения заклинания (с источником) для $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.active 		= "Отсчет времени действия $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "Отсчет времени до спадения $spell:%s с игроков"
DBM_CORE_AUTO_TIMER_OPTIONS.ai			= "Отсчет времени до восстановления $spell:%s (ИИ)"
DBM_CORE_AUTO_TIMER_OPTIONS.cd 			= "Отсчет времени до восстановления $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount 	= "Отсчет времени до восстановления $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "Отсчет времени до восстановления $spell:%s (с источником)"
DBM_CORE_AUTO_TIMER_OPTIONS.cdspecial	= "Отсчет времени до восстановления спец-способности"
DBM_CORE_AUTO_TIMER_OPTIONS.next 		= "Отсчет времени до следующего $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount 	= "Отсчет времени до следующего $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "Отсчет времени до следующего $spell:%s (с источником)"
DBM_CORE_AUTO_TIMER_OPTIONS.nextspecial	= "Отсчет времени до следующей спец-способности"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement = "Отсчет времени для %s"
DBM_CORE_AUTO_TIMER_OPTIONS.stage		= "Отсчет времени до следующей фазы"
DBM_CORE_AUTO_TIMER_OPTIONS.adds		= "Отсчет времени до прибытия аддов"
DBM_CORE_AUTO_TIMER_OPTIONS.addscustom	= "Отсчет времени до прибытия аддов"
DBM_CORE_AUTO_TIMER_OPTIONS.roleplay	= "Отсчет времени для ролевой игры"

DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "Устанавливать метки на цели заклинания $spell:%s"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "Устанавливать метки на $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT			= "Показывать стрелку DBM к цели, на которой $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2		= "Показывать стрелку DBM от цели, на которой $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT3		= "Показывать стрелку DBM к определенному месту для $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.shortyell= "Кричать когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.yell		= "Кричать (с именем игрока), когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.yellme	= "Кричать, когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.count	= "Кричать (со счетчиком), когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.fade		= "Кричать (с обратный отсчетом), когда $spell:%s спадает"
DBM_CORE_AUTO_YELL_OPTION_TEXT.shortfade= "Кричать (с обратный отсчетом) когда $spell:%s спадает"
DBM_CORE_AUTO_YELL_OPTION_TEXT.iconfade	= "Кричать (с обратный отсчетом и меткой) когда $spell:%s спадает"
DBM_CORE_AUTO_YELL_OPTION_TEXT.position	= "Кричать (с позицией), когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.combo	= "Кричать (с пользовательским текстом) когда на вас $spell:%s и в тоже время другие заклинания"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortyell	= "%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yell	= "%s на " .. UnitName("player") .. "!"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yellme	= "%s на мне!"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.count	= "%s на " .. UnitName("player") .. "! (%%d)"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.fade	= "%s спадает через %%d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortfade	= "%%d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.iconfade	= "{rt%%2$d}%%1$d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.position = "%s %%s на {rt%%d}"..UnitName("player").."{rt%%d}"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.combo	= "%s и %%s"--Spell name (from option, plus spellname given in arg)
DBM_CORE_AUTO_YELL_CUSTOM_FADE			= "%s спал"
DBM_CORE_AUTO_HUD_OPTION_TEXT			= "Показывать HudMap для $spell:%s"
DBM_CORE_AUTO_HUD_OPTION_TEXT_MULTI		= "Показывать HudMap для различных механик"
DBM_CORE_AUTO_NAMEPLATE_OPTION_TEXT		= "Показывать Nameplate Auras для $spell:%s"
DBM_CORE_AUTO_RANGE_OPTION_TEXT			= "Показывать окно проверки дистанции (%s м) для $spell:%s"--string used for range so we can use things like "5/2" as a value for that field
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT	= "Показывать окно проверки дистанции (%s м)"--For when a range frame is just used for more than one thing
DBM_CORE_AUTO_RRANGE_OPTION_TEXT		= "Показывать обратное окно проверки дистанции (%s) для $spell:%s"--Reverse range frame (green when players in range, red when not)
DBM_CORE_AUTO_RRANGE_OPTION_TEXT_SHORT	= "Показывать обратное окно проверки дистанции (%s)"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT	= "Показывать информационное окно для $spell:%s"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT2	= "Показывать информационное окно для обзора боя"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT	= "Проигрывать звук проверки готовности когда пулят босса (даже если он не является целью)"


DBM_CORE_AUTO_ICONS_OPTION_TEXT		= "Устанавливать метки на цели заклинания $spell:%d"
DBM_CORE_AUTO_SOUND_OPTION_TEXT		= "Звуковой сигнал при $spell:%d"
DBM_CORE_AUTO_SOUND_OPTION_TEXT5	= "5-секундный звуковой отсчет до $spell:%d"
DBM_CORE_AUTO_SOUND_OPTION_TEXT3	= "3-секундный звуковой отсчет до $spell:%d"

-- New special warnings
DBM_CORE_MOVE_WARNING_BAR			= "Индикатор предупреждения"
DBM_CORE_MOVE_WARNING_MESSAGE		= "Спасибо за использование Deadly Boss Mods"
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Индикатор спец-предупреждения"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Специальное предупреждение"


DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED	= "Проверка дистанции %d м. недоступна в этой зоне.\nДоступные дистанции - 10, 11, 15 и 28 м."

DBM_ARROW_MOVABLE					= "Стрелку можно перемещать"
DBM_ARROW_NO_RAIDGROUP				= "Данная функция работает только в рейд-группах и внутри рейдовых подземелий."
DBM_ARROW_ERROR_USAGE	= {
	"Использование DBM-Arrow:",
	"/dbm arrow <x> <y>: создает стрелку, указывающую в определенную точку (0 < x/y < 100)",
	"/dbm arrow <player>: создает стрелку, указывающую на определенного игрока в вашей группе или рейде",
	"/dbm arrow hide: скрывает стрелку",
	"/dbm arrow move: разрешает перемещение стрелки",
}

DBM_SPEED_KILL_TIMER_TEXT	= "Рекордная победа"
DBM_CORE_TIMER_RESPAWN		= "Появление %s"

DBM_REQ_INSTANCE_ID_PERMISSION		= "%s запрашивает разрешение на просмотр ваших текущих сохранений подземелий.\nВы хотите предоставить %s такое право? Этот игрок получит возможность запрашивать эту информацию без уведомления в течение вашей текущей игровой сессии."
DBM_ERROR_NO_RAID					= "Вы должны состоять в рейдовой группе для использования этой функции."
DBM_INSTANCE_INFO_REQUESTED			= "Отослан запрос на просмотр текущих сохранений подземелий у членов рейда.\nОбратите внимание, что игроки будут уведомлены об этом и могут отклонить ваш запрос."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "На запрос ответили %d игроков из %d пользователей DBM: %d послали данные, %d отклонили запрос. Ожидание ответа продлено на %d секунд..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Получен ответ ото всех членов рейда"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Игрок: %s ТипРезультата: %s Инстанс: %s ID: %s Сложность: %d Размер: %d Прогресс: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, сложность %s:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, прогресс %d: %s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    прогресс %d: %s"
DBM_INSTANCE_INFO_NOLOCKOUT			= "Ваша рейдовая группа не имеет сохранений подземелий."
DBM_INSTANCE_INFO_STATS_DENIED		= "Отклонили запрос: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Отошли от компьютера: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Установлена устаревшая версия DBM: %s"
DBM_INSTANCE_INFO_RESULTS			= "Результаты сканирования сохранений. Обратите внимание, что инстансы могут появляться более одного раза, если в вашем рейде есть игроки с локализованными клиентами WoW."
--DBM_INSTANCE_INFO_SHOW_RESULTS		= "Игроки, которые еще не ответили: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Показать текущие результаты]|r|h"
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Игроки, которые еще не ответили: %s"

DBM_CORE_LAG_CHECKING				= "Проверка задержки у рейда..."
DBM_CORE_LAG_HEADER					= "Deadly Boss Mods - Результаты проверки задержки"
DBM_CORE_LAG_ENTRY					= "%s: глобальная задержка [%d ms] / локальная задержка [%d ms]"
DBM_CORE_LAG_FOOTER					= "Нет ответа: %s"

DBM_CORE_DUR_CHECKING				= "Проверка прочности у рейда..."
DBM_CORE_DUR_HEADER					= "Deadly Boss Mods - результаты проверки прочности"
DBM_CORE_DUR_ENTRY					= "%s: прочность [%d процентов] / экипировка сломана [%s]"
DBM_CORE_LAG_FOOTER					= "Нет ответа: %s"

--LDB
DBM_LDB_TOOLTIP_HELP1	= "Левый клик чтобы открыть DBM"
