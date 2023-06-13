if GetLocale() ~= "frFR" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "Malygos"
})

L:SetMiscLocalization({
	YellPull		= "Ma patience a ses limites. Je vais me débarrasser de vous !",
	EmoteSpark		= "de puissance surgit",
	YellPhase2		= "Je pensais mettre rapidement fin à vos existences",
	YellBreath		= "Vous n'arriverez à rien tant qu'il me restera un souffle !",
	YellPhase3		= "Vos bienfaiteurs font enfin leur entrée, mais ils arrivent trop tard !",
	EmoteSurge		= "%s fixe le regard sur vous !"
})
