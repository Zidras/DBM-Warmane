if GetLocale() ~= "koKR" then return end

local L

---------------
--  Malygos  --
---------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "말리고스"
})

L:SetMiscLocalization({
	YellPull		= "더는 참을 수가 없구나. 다 없애 버리겠다!",
	EmoteSpark		= "마력의 불꽃이 근처에 있는 틈에서 올라옵니다!",
	YellPhase2		= "되도록 빨리 끝내 주고 싶었다만",
	YellBreath		= "내가 숨 쉬는 한, 너희는 이길 수 없다!",
	YellPhase3		= "네놈들의 후원자가 나타났구나",
	EmoteSurge		= "%s|1이;가; 당신을 주시합니다!"
})
