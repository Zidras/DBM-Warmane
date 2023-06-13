if GetLocale() ~= "ruRU" then return end

local L

-----------
--  Alar --
-----------
L = DBM:GetModLocalization("Alar")

L:SetGeneralLocalization({
	name = "Ал'ар"
})

L:SetTimerLocalization({
	NextPlatform	= "Следующая платформа"
})

L:SetOptionLocalization({
	NextPlatform	= "Показывать таймер, когда Ал'ар меняет платформу"
})

------------------
--  Void Reaver --
------------------
L = DBM:GetModLocalization("VoidReaver")

L:SetGeneralLocalization({
	name = "Страж Бездны"
})

--------------------------------
--  High Astromancer Solarian --
--------------------------------
L = DBM:GetModLocalization("Solarian")

L:SetGeneralLocalization({
	name = "Верховный звездочет Солариан"
})

L:SetWarningLocalization({
	WarnSplit		= "*** Приспешники на подходе ***",
	WarnSplitSoon	= "*** Разделение через 5 секунд ***",
	WarnAgent		= "*** Пособники появились ***",
	WarnPriest		= "*** Жрецы и Солариан появились ***"

})

L:SetTimerLocalization({
	TimerSplit		= "Разделение",
	TimerAgent		= "Пособники",
	TimerPriest		= "Жрецы и Солариан"
})

L:SetOptionLocalization({--Translate
	WarnSplit		= "Show warning for Split",
	WarnSplitSoon	= "Show pre-warning for Split",
	WarnAgent		= "Show warning for Agents spawn",
	WarnPriest		= "Show warning for Priests and Solarian spawn",
	TimerSplit		= "Show timer for Split",
	TimerAgent		= "Show timer for Agents spawn",
	TimerPriest		= "Show timer for Priests and Solarian spawn",
	WrathWhisper	= "Сообщить шепотом цели, если Гнев на нем"
})

L:SetMiscLocalization({
	WrathWhisper	= "Гнев на вас!",
	YellSplit1		= "Я навсегда избавлю вас от мании величия!",
	YellSplit2		= "Вы безнадежно слабы!	",
	YellPhase2		= "Я сольюсь... с БЕЗДНОЙ!"
})

---------------------------
--  Kael'thas Sunstrider --
---------------------------
L = DBM:GetModLocalization("KaelThas")

L:SetGeneralLocalization({
	name = "Кель'тас Солнечный Скиталец"
})

L:SetWarningLocalization({
	WarnGaze		= "*** Таладред бросает взор на >%s< ***",
	WarnMobDead		= "%s down",--Translate
	WarnEgg			= "*** Феникс убит - появляется яйцо ***",
	SpecWarnGaze	= "Бегите!",
	SpecWarnEgg		= "*** Феникс убит - появляется яйцо ***"
})

L:SetTimerLocalization({
	TimerPhase		= "Следующая Фаза",
	TimerPhase1mob	= "%s",
	TimerNextGaze	= "Восстановление взгляда",
	TimerRebirth	= "Возрождение"
})

L:SetOptionLocalization({--Translate
	WarnGaze		= "Show warning for Thaladred's Gaze target",
	WarnMobDead		= "Show warning for Phase 2 mob down",
	WarnEgg			= "Show warning when Phoenix Egg spawn",
	SpecWarnGaze	= "Show special warning when Gaze on you",
	SpecWarnEgg		= "Show special warning when Phoenix Egg spawn",
	TimerPhase		= "Show time for next phase",
	TimerPhase1mob	= "Show time for Phase 1 mob active",
	TimerNextGaze	= "Show timer for Thaladred's Gaze target changes",
	TimerRebirth	= "Show timer for Phoenix Egg rebirth remaining",
	RangeFrame		= "Контрольное окно придельной дистанции",
	GazeWhisper		= "Сообщить шепотом цели, если Таладред на нем",
	GazeIcon		= "Установить метку на цель Таладред"
})

L:SetMiscLocalization({
--	YellPull1	= "Энергия. Сила. Мои люди без них не могут... Эта зависимость возникла после уничтожения Солнечного Колодца. Добро пожаловать... в будущее. Мне очень жаль, но вы не сможете ничего изменить. Теперь меня никто не остановит! Селама ашаль-аноре!",
	YellPhase2	= "Как видите, оружия у меня предостаточно...",
	YellPhase3	= "Возможно, я недооценил вас. Было бы несправедливо заставлять вас драться с четырьмя советниками сразу, но... Мои люди тоже никогда не знали справедливости. Я лишь возвращаю долг.",
	YellPhase4	= "Увы, иногда приходится брать все в свои руки. Баламоре шаналь!",
	YellPhase5	= "Я не затем ступил на этот путь, чтобы остановиться на полдороги! Мои планы должны сбыться  и они сбудутся! Узрите же истинную мощь!",
	YellSang	= "Вы справились с моими лучшими советниками... Но перед мощью Кровавого Молота не устоит никто. Узрите лорда Сангвинара!",
	YellCaper	= "Каперниан проследит, чтобы вы не задержались здесь надолго.",
	YellTelo	= "Неплохо, теперь вы можете потягаться с моим главным инженером Телоникусом.",
	EmoteGaze	= "смотрит на ([^%s]+)!",
	GazeWhisper	= "Таладред бросает взор на ВАС! Бегите!",
	Thaladred	= "Таладред Светокрад",
	Sanguinar	= "Лорд Сангвинар",
	Capernian	= "Великий Звездочет Каперниан",
	Telonicus	= "Старший инженер Телоникус",
	Bow			= "Длинный лук Края Пустоты",
	Axe			= "Сокрушение",
	Mace		= "Вселенский вдохновитель",
	Dagger		= "Клинки Бесконечности",
	Sword		= "Астральный тесак",
	Shield		= "Фазовый щит",
	Staff		= "Посох Распыления",
	Egg			= "Яйцо феникса"
})
