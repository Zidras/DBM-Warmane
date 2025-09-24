if GetLocale() ~= "ruRU" then return end
local L

---------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk")

L:SetGeneralLocalization({
	name = "Налоракк"
})

L:SetWarningLocalization({
	WarnBear		= "Форма медведя",
	WarnBearSoon	= "Форма медведя через 5 секунд",
	WarnNormal		= "Обычная форма",
	WarnNormalSoon	= "Обычная форма через 5 секунд"
})

L:SetTimerLocalization({
	TimerBear		= "Форма медведя",
	TimerNormal		= "Обычная форма"
})

L:SetOptionLocalization({
	WarnBear		= "Show warning for Bear form",--Translate
	WarnBearSoon	= "Show pre-warning for Bear form",--Translate
	WarnNormal		= "Show warning for Normal form",--Translate
	WarnNormalSoon	= "Show pre-warning for Normal form",--Translate
	TimerBear		= "Show timer for Bear form",--Translate
	TimerNormal		= "Show timer for Normal form"--Translate
})

L:SetMiscLocalization({
	YellPull	= "Вперед, стражники! Начнем резню!",
	YellBear	= "Если вызвать чудовище, то мало не покажется, точно говорю!",
	YellNormal	= "Пропустите Налоракка!"
})

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon")

L:SetGeneralLocalization({
	name = "Акил'зон"
})

L:SetMiscLocalization({
	YellPull	= "Я – охотник! Вы – добыча!",
})

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai")

L:SetGeneralLocalization({
	name = "Джан'алаи"
})

L:SetMiscLocalization({
	YellPull	= "Духи ветра станут вашей погибелью!",
	YellBomb	= "Сгиньте в огне!",
	YellAdds	= "Где мои Наседки? Пора за яйца приниматься!"
})

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi")

L:SetGeneralLocalization({
	name = "Халаззи"
})

L:SetWarningLocalization({
	WarnSpirit	= "Призывает дух",
	WarnNormal	= "Дух исчезает"
})

L:SetOptionLocalization({
	WarnSpirit	= "Show warning for Spirit phase",--Translate
	WarnNormal	= "Show warning for Normal phase"--Translate
})

L:SetMiscLocalization({
	YellPull	= "На колени!! Склонитесь пред клыком и когтем!",
	YellSpirit	= "Со мною дикий дух...",
	YellNormal	= "О дух, вернись ко мне!"
})

--------------------------
--  Hex Lord Malacrass --
--------------------------
L = DBM:GetModLocalization("Malacrass")

L:SetGeneralLocalization({
	name = "Повелитель проклятий Малакрасс"
})

L:SetMiscLocalization({
	YellPull	= "На вас падет тень..."
})

--------------
--  Zul'jin --
--------------
L = DBM:GetModLocalization("ZulJin")

L:SetGeneralLocalization({
	name = "Зул'джин"
})

L:SetMiscLocalization({
--	YellPull	= "Nobody badduh dan me!",
	YellPhase2	= "Выучил новый фокус… прямо как братишка-медведь...",
	YellPhase3	= "От орла нигде не скрыться!",
	YellPhase4	= "Позвольте представить моих двух братцев: клык и коготь!",
	YellPhase5	= "Для того чтобы увидеть дракондора, в небо смотреть необязательно!"
})
