if GetLocale() ~= "koKR" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia-Vanilla")

L:SetGeneralLocalization({
	name = "오닉시아"
})

--[[L:SetWarningLocalization({
	WarnWhelpsSoon		= "곧 새끼용 등장"
})

L:SetTimerLocalization({
	TimerWhelps		= "새끼용"
})]]

L:SetOptionLocalization({
--	TimerWhelps				= "새끼용 등장 바 보기",
--	WarnWhelpsSoon			= "새끼용 등장 이전에 알림 보기",
	SoundWTF3				= "독특한 레이드를 즐기기 위한 웃긴 소리 재생(가급적 비활성화 추천)"
})

L:SetMiscLocalization({
--	YellPull	= "How fortuitous. Usually, I must leave my lair in order to feed.",
	YellP2		= "쓸데없이 힘을 쓰는 것도 지루하군. 네 녀석들 머리 위에서 모조리 불살라 주마!",
	YellP3		= "혼이 더 나야 정신을 차리겠구나!"
})
