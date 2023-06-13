if GetLocale() ~= "frFR" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization({
	name = "Onyxia"
})

--[[L:SetWarningLocalization({
	WarnWhelpsSoon		= "Les Jeunes dragonnets onyxien arrivent bientôt"
})

L:SetTimerLocalization({
	TimerWhelps = "Arrivée des Jeunes dragonnets onyxien"
})]]

L:SetOptionLocalization({
--	TimerWhelps				= "Montre le timer pour l'arrivée des Jeunes dragonnets onyxien",
--	WarnWhelpsSoon			= "Montre une pré-alerte avant l'arrivée des Jeunes dragonnets onyxien",
	SoundWTF3				= "Joue des sons amusants du légendaire raid classic d'Onyxia"
})

L:SetMiscLocalization({
--	YellPull = "Quelle chance ! D'habitude, je dois quitter mon repaire pour me nourrir.",
	YellP2 = "exercice dénué de sens",
	YellP3 = "semble que vous ayez besoin"
})
