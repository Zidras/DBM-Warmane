if GetLocale() ~= "ruRU" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization({
	name = "Ониксия"
})

--[[L:SetWarningLocalization({
	WarnWhelpsSoon		= "Скоро дракончики Ониксии"
})

L:SetTimerLocalization({
	TimerWhelps	= "Вызов дракончиков Ониксии"
})]]

L:SetOptionLocalization({
--	TimerWhelps				= "Отсчет времени до дракончиков Ониксии",
--	WarnWhelpsSoon			= "Предупреждать заранее о дракончиках Ониксии",
	SoundWTF3				= "Воспроизводить забавное озвучивание легендарного классического рейда на Ониксию (англ.)"
})

L:SetMiscLocalization({
--	YellPull = "Вот это сюрприз. Обычно, чтобы найти обед, мне приходится покидать логово.",
	YellP2 = "Эта бессмысленная возня вгоняет меня в тоску. Я сожгу вас всех!",
	YellP3 = "Похоже, вам требуется преподать еще один урок, смертные!"
})
