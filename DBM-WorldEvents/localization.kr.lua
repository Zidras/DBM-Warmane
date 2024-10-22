if GetLocale() ~= "koKR" then return end
local L

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetTimerLocalization({
	HummelActive	= "훔멜 활성화",
	BaxterActive	= "벡스터 활성화",
	FryeActive		= "프라이 활성화"
})

L:SetOptionLocalization({
	TrioActiveTimer		= "각 보스 활성화 타이머 바 보기"
})

L:SetMiscLocalization({
	SayCombatStart		= "저들이 내가 누군지와 왜 이 일을 하는지 말해주려고 귀찮게 하든가?"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	name = "아훈"
})

L:SetWarningLocalization({
	Emerged			= "등장",
	specWarnAttack	= "아훈 약화 - 공격 시작!"
})

L:SetTimerLocalization({
	SubmergeTimer	= "잠복",
	EmergeTimer		= "등장"
})

L:SetOptionLocalization({
	Emerged			= "등장 경고 보기",
	specWarnAttack	= "아훈 약화 특별 경고 보기",
	SubmergeTimer	= "잠복 타이머 바 보기",
	EmergeTimer		= "등장 타이머 바 보기"
})

L:SetMiscLocalization({
	Pull			= "얼음 기둥이 녹아 내렸다!"
})

--------------------
-- Coren Direbrew --
--------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "코렌 다이어브루"
})

L:SetWarningLocalization({
	specWarnBrew		= "다른 맥주가 넘어오기 전에 가방에 있는 맥주를 사용하세요!",
	specWarnBrewStun	= "힌트: 기절했습니다. 다음엔 맥주를 꼭 마시세요!"
})

L:SetOptionLocalization({
	specWarnBrew		= "$spell:47376 특별 경고 보기",
	specWarnBrewStun	= "$spell:47340 특별 경고 보기"
})

L:SetMiscLocalization({
	YellBarrel			= "나에게 맥주통!"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "저주받은 기사"
})

L:SetWarningLocalization({
	WarnPhase				= "%d단계",
	warnHorsemanSoldiers	= "고동치는 호박 생성",
	warnHorsemanHead		= "저주받은 기사의 머리 등장"
})

L:SetOptionLocalization({
	WarnPhase				= "단계 전환 경고 보기",
	warnHorsemanSoldiers	= "고동치는 호박 등장 경고 보기",
	warnHorsemanHead		= "저주받은 기사 머리 등장 경고 보기"
})

L:SetMiscLocalization({
	HorsemanSummon			= "기사여 일어나라...", -- CONFIRM! local SQL has different string: 기사여, 일어나라...
	HorsemanHead			= "냉큼 이리 와라, 이 얼간아!",
	HorsemanSoldiers		= "일어나라, 병사들이여. 나가서 싸워라! 이 쇠락한 기사에게 승리를 안겨다오!",
	SayCombatEnd			= "죽음은 이미 겪어 보았노라. 이제 어떤 모험이 날 기다리는가?"
})
