if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia-Vanilla")

L:SetGeneralLocalization({
	name = "Onyxia"
})

--[[L:SetWarningLocalization({
	WarnWhelpsSoon		= "Crías de Onyxia en breve"
})

L:SetTimerLocalization({
	TimerWhelps	= "Crías de Onyxia"
})]]

L:SetOptionLocalization({
--	TimerWhelps				= "Mostrar temporizador para las siguientes Crías de Onyxia",
--	WarnWhelpsSoon			= "Mostrar aviso previo para las siguientes Crías de Onyxia",
	SoundWTF3				= "Reproducir sonidos graciosos de cierta banda legendaria"
})

L:SetMiscLocalization({
--	YellPull = "Qué casualidad. Generalmente, debo salir de mi guarida para poder comer.",
	YellP2 = "Este ejercicio sin sentido me aburre. ¡Os inceneraré a todos desde arriba!",
	YellP3 = "¡Parece ser que vais a necesitar otra lección, mortales!"
})
