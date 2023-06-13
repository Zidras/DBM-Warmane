if GetLocale() ~= "ruRU" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "Малигос"
})

L:SetMiscLocalization({
	YellPull	= "Мое терпение лопнуло! Пора от вас избавиться!",
	EmoteSpark	= "Искра мощи появляется из ближайшей расселины!",
	YellPhase2	= "Я надеялся быстро с вами покончить",
--	EmoteBreath	= "%s делает глубокий вдох...",
	YellBreath	= "Пока я дышу, вам не добиться своего!",
	YellPhase3	= "Вот и ваши благодетели появились",
--	EnoughScream	= "ХВАТИТ! Раз вы хотите магии Азерота, то вы ее получите!"
	EmoteSurge	= "%s уставился на вас!"
})
