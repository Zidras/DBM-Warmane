if GetLocale() ~= "koKR" then return end
local L

-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization({
	name = "마그테리돈"
})

L:SetTimerLocalization({
	timerP2	= "2단계"
})

L:SetOptionLocalization({
	timerP2	= "2단계 시작 바 보기"
})

L:SetMiscLocalization({
	DBM_MAG_EMOTE_PULL		= "%s의 속박이 약해지기 시작합니다!",
	DBM_MAG_YELL_PHASE2		= "내가... 풀려났도다!",
	DBM_MAG_YELL_PHASE3		= "그렇게 쉽게 당할 내가 아니다! 이 감옥의 벽이 흔들리고... 무너지리라!"
})
