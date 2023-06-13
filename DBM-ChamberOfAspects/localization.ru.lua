if GetLocale() ~= "ruRU" then return end

local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "Шадрон"
})

L:SetMiscLocalization({
	YellShadronPull	= "Я не боюсь ничего! Тем более – вас!",
})

----------------
--  Tenebron  --
----------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "Тенеброн"
})

L:SetMiscLocalization({
	YellTenebronPull	= "Вам здесь не место! Ваше место среди усопших!",
})

----------------
--  Vesperon  --
----------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "Весперон"
})

L:SetMiscLocalization({
	YellVesperonPull	= "Вы безобидны, ничтожные создания. Покажите, на что вы способны!",
})

------------------
--  Sartharion  --
------------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "Сартарион"
})

L:SetWarningLocalization({
	WarningTenebron			= "Прибытие Тенеброна",
	WarningShadron			= "Прибытие Шадрона",
	WarningVesperon			= "Прибытие Весперона",
	WarningFireWall			= "Огненная стена",
	WarningWhelpsSoon		= "Скоро дракончики тенеброна",
	WarningPortalSoon		= "Скоро портал Шадрон",
	WarningReflectSoon		= "Весперон: Скоро отражение",
	WarningVesperonPortal	= "Портал Весперона",
	WarningTenebronPortal	= "Портал Тенеброна",
	WarningShadronPortal	= "Портал Шадрона"
})

L:SetTimerLocalization({
	TimerTenebron			= "Прибытие Тенеброна",
	TimerShadron			= "Прибытие Шадрона",
	TimerVesperon			= "Прибытие Весперона",
	TimerTenebronWhelps		= "Тенебронские дракончики",
	TimerShadronPortal		= "Портал Шадрона",
	TimerVesperonPortal		= "Портал Весперона",
	TimerVesperonPortal2	= "Портал Весперона 2"
})

L:SetOptionLocalization({
	AnnounceFails			= "Объявлять игроков, потерпевших неудачу в Огненной стене и Расщелине тьмы<br/>(требуются права лидера или помощника)",
	TimerTenebron			= "Отсчет времени до прибытия Тенеброна",
	TimerShadron			= "Отсчет времени до прибытия Шадрона",
	TimerVesperon			= "Отсчет времени до прибытия Весперона",
	TimerTenebronWhelps		= "Показать таймер для тенебронских дракончиков",
	TimerShadronPortal		= "Показать таймер для портала Шадрона",
	TimerVesperonPortal		= "Показать таймер для портала Весперон",
	TimerVesperonPortal2	= "Показать таймер для портала Весперон 2",
	WarningFireWall			= "Cпец-предупреждение для Огненной стены",
	WarningTenebron			= "Объявлять прибытие Тенеброна",
	WarningShadron			= "Объявлять прибытие Шадрона",
	WarningVesperon			= "Объявлять прибытие Весперона",
	WarningWhelpsSoon		= "Скоро анонсируйте тенебронских дракончиков",
	WarningPortalSoon		= "Анонсируйте портал Шадрон в ближайшее время",
	WarningReflectSoon		= "Анонсировать Весперон, размышлять в ближайшее время",
	WarningTenebronPortal	= "Cпец-предупреждение для порталов Тенеброна",
	WarningShadronPortal	= "Cпец-предупреждение для порталов Шадрона",
	WarningVesperonPortal	= "Cпец-предупреждение для порталов Весперона"
})

L:SetMiscLocalization({
	YellSarthPull	= "Моя обязанность – оберегать эти яйца, и вы сгорите, прежде чем хоть пальцем тронете их!",
	Wall			= "Лава вокруг %s начинает бурлить!",
	Portal			= "%s открывает сумрачный портал!",
	NameTenebron	= "Тенеброн",
	NameShadron		= "Шадрон",
	NameVesperon	= "Весперон",
	FireWallOn		= "Огненная стена: %s",
	VoidZoneOn		= "Расщелина тьмы: %s",
	VoidZones		= "Потерпели неудачу в Расщелине тьмы (за эту попытку): %s",
	FireWalls		= "Потерпели неудачу в Огненной стене (за эту попытку): %s"
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "Балтар Рожденный в Битве"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Скоро разделение"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Предупреждать заранее о разделении"
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "Савиана Огненная Пропасть"
})

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "Генерал Заритриан"
})

L:SetWarningLocalization({
	WarnAdds	= "Новые помощники",
	warnCleaveArmor	= "%s на |3-5(>%s<) (%s)"		-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds	= "Новые помощники",
	AddsArrive	= "Прибытие помощников"
})

L:SetOptionLocalization({
	WarnAdds		= "Объявлять новых помощников",
	TimerAdds		= "Отсчет времени до новых помощников",
	CancelBuff		= "Удалить $spell:10278 и $spell:642, если используется для удаления $spell:74367",
	AddsArrive		= "Отсчет времени до прибытия помощников"
})

L:SetMiscLocalization({
	SummonMinions	= "Слуги! Обратите их в пепел!"
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "Халион Сумеречный Разрушитель"
})

L:SetWarningLocalization({
	TwilightCutterCast	= "Применение заклинания Лезвие сумерек: 5 сек"
})

L:SetOptionLocalization({
	TwilightCutterCast		= "Предупреждать о применении заклинания $spell:77844",
	AnnounceAlternatePhase	= "Показывать предупреждения и таймеры для обоих миров",
	SetIconOnConsumption	= "Устанавливать метки на цели заклинаний $spell:74562 или $spell:74792"--So we can use single functions for both versions of spell.
})

L:SetMiscLocalization({
	Halion					= "Халион",
	PhysicalRealm			= "Реальный мир",
	MeteorCast				= "Небеса в огне!",
	Phase2					= "В мире сумерек вы найдете лишь страдания! Входите, если посмеете!",
	Phase3					= "Я есть свет и я есть тьма! Трепещите, ничтожные, перед посланником Смертокрыла!",
	twilightcutter			= "Остерегайтесь теней!", --"Во вращающихся сферах пульсирует темная энергия!",
	Kill					= "Это ваша последняя победа. Насладитесь сполна ее вкусом. Ибо когда вернется мой господин, этот мир сгинет в огне!"
})
