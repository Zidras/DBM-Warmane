if GetLocale() ~= "koKR" then return end
local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization({
	name = "예언자 스케람"
})

L:SetMiscLocalization({
	YellKillSkeram = "이런다고 피할 수는 없다!"
})

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization({
	name = "벌레 3형제"
})

L:SetMiscLocalization({
	Yauj	= "공주 야우즈",
	Vem	= "벰",
	Kri	= "군주 크리"
})

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization({
	name = "전투감시병 살투라"
})

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization({
	name = "불굴의 판크리스"
})

--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization({
	name = "비시디우스"
})

L:SetWarningLocalization({
	WarnFreeze	= "빙결 : %d/3",
	WarnShatter	= "분해 : %d/3"
})

L:SetOptionLocalization({
	WarnFreeze	= "빙결 알림 보기",
	WarnShatter	= "분해 알림 보기"
})

L:SetMiscLocalization({
	Slow	= "느려지기 시작했습니다!",
	Freezing= "얼어붙고 있습니다!",
	Frozen	= "단단하게 얼었습니다!",
	Phase4	= "분해되기 시작합니다!",
	Phase5	= "부서질 것 같습니다!",
	Phase6	= "폭발",

	HitsRemain	= "냉기 타격 남은 횟수",
	Frost		= "냉기",
	Physical	= "물리"
})

-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization({
	name = "공주 후후란"
})

---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization({
	name = "쌍둥이 제왕"
})

L:SetMiscLocalization({
	Veklor = "제왕 베클로어",
	Veknil = "제왕 베크닐라쉬"
})

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization({
	name = "쑨"
})

L:SetWarningLocalization({
	WarnEyeTentacle			= "눈 달린 촉수",
	WarnClawTentacle2		= "갈고리 촉수",
	WarnGiantEyeTentacle		= "눈 달린 거대한 촉수",
	WarnGiantClawTentacle		= "거대한 발톱 촉수",
	SpecWarnWeakened		= "쑨 약화됨!"
})

L:SetTimerLocalization({
	TimerEyeTentacle		= "눈 달린 촉수",
	TimerClawTentacle		= "갈고리 촉수",
	TimerGiantEyeTentacle		= "눈 달린 거대한 촉수",
	TimerGiantClawTentacle		= "거대한 발톱 촉수",
	TimerWeakened			= "쑨 약화 종료"
})

L:SetOptionLocalization({
	WarnEyeTentacle			= "눈 달린 촉수 경고 보기",
	WarnClawTentacle2		= "갈고리 촉수 경고 보기",
	WarnGiantEyeTentacle		= "눈 달린 거대한 촉수 경고 보기",
	WarnGiantClawTentacle		= "거대한 발톱 촉수 경고 보기",
	SpecWarnWeakened		= "보스 약화시 특수 경고 보기",
	TimerEyeTentacle		= "다음 눈 달린 촉수 타이머 바 보기",
	TimerClawTentacle		= "다음 갈고리 촉수 타이머 바 보기",
	TimerGiantEyeTentacle		= "다음 눈 달린 거대한 촉수 타이머 바 보기",
	TimerGiantClawTentacle		= "다음 거대한 발톱 촉수 타이머 바 보기",
	TimerWeakened			= "보스 약화 지속시간 타이머 바 보기",
	RangeFrame				= "거리 창 보기 (10m)"
})

L:SetMiscLocalization({
	Stomach		= "뱃속",
	Eye			= "쑨의 눈",
	FleshTent	= "식인 촉수",--Localized so it shows on frame in users language, not senders
	Weakened	= "약해집니다!",
	NotValid	= "안퀴40 레이드를 일부만 클리어 했습니다. 부차적인 네임드가 %s마리 남아있습니다."
})

----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization({
	name = "아우로"
})

L:SetWarningLocalization({
	WarnSubmerge		= "잠수",
	WarnEmerge			= "등장",
})

L:SetTimerLocalization({
	TimerSubmerge		= "강제 잠수",
	TimerEmerge			= "등장"
})

L:SetOptionLocalization({
	WarnSubmerge		= "잠수 경고 보기",
	TimerSubmerge		= "잠수가 강제로 될 때 타이머 바를 표시합니다. 알림: 아우로는 현재 대상이 평타 사거리에 있더라도 여전히 아무때나 잠수를 할 수 있습니다.",
	WarnEmerge			= "등장 경고 보기",
	TimerEmerge			= "등장 타이머 바 보기"
})

----------------
-- AQ40 Trash --
----------------
L = DBM:GetModLocalization("AQ40Trash")

L:SetGeneralLocalization({
	name = "안퀴40 일반몹"
})
