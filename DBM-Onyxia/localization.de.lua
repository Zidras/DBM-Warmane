if GetLocale() ~= "deDE" then return end
local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization({
	name = "Onyxia"
})

--[[L:SetWarningLocalization({
	WarnWhelpsSoon		= "Welpen erscheinen bald"
})

L:SetTimerLocalization({
	TimerWhelps	= "Welpen erscheinen"
})]]

L:SetOptionLocalization({
--	TimerWhelps				= "Zeige Zeit bis Welpen erscheinen",
--	WarnWhelpsSoon			= "Zeige Vorwarnung für Erscheinen der Welpen",
	SoundWTF3				= "Spiele witzige Sounds eines legendären Classic-Onyxia-Schlachtzuges"
})

L:SetMiscLocalization({
--	YellPull = "Was für ein Zufall. Normalerweise muss ich meinen Unterschlupf verlassen, um etwas zu essen.",
	YellP2 = "Diese sinnlose Anstrengung langweilt mich. Ich werde Euch alle von oben verbrennen!",
	YellP3 = "Mir scheint, dass Ihr noch eine Lektion braucht, sterbliche Wesen!"
})
