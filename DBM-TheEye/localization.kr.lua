if GetLocale() ~= "koKR" then return end
local L

-----------
--  Alar --
-----------
L = DBM:GetModLocalization("Alar")

L:SetGeneralLocalization({
	name = "알라르"
})

L:SetTimerLocalization({
	NextPlatform	= "최대 단상 시간"
})

L:SetOptionLocalization({
	NextPlatform	= "알라르가 단상에 머무를 수 있는 시간 타이머 바 보기 (더 빨리 떠날수는 있지만 더 늦게 떠나진 않음)"
})

------------------
--  Void Reaver --
------------------
L = DBM:GetModLocalization("VoidReaver")

L:SetGeneralLocalization({
	name = "공허의 절단기"
})

--------------------------------
--  High Astromancer Solarian --
--------------------------------
L = DBM:GetModLocalization("Solarian")

L:SetGeneralLocalization({
	name = "고위 점성술사 솔라리안"
})

L:SetWarningLocalization({
	WarnSplit		= "분리",
	WarnSplitSoon	= "5초 후 분리",
	WarnAgent		= "요원 등장",
	WarnPriest		= "사제와 솔라리안 등장",

})

L:SetTimerLocalization({
	TimerSplit		= "다음 분리",
	TimerAgent		= "요원 등장",
	TimerPriest		= "사제와 솔라리안 등장"
})

L:SetOptionLocalization({
	WarnSplit		= "분리 경고 보기",
	WarnSplitSoon	= "분리 사전 경고 보기",
	WarnAgent		= "요원 등장 경고 보기",
	WarnPriest		= "사제와 솔라리안 등장 경고 보기",
	TimerSplit		= "분리 타이머 바 보기",
	TimerAgent		= "요원 등장 타이머 바 보기",
	TimerPriest		= "사제와 솔라리안 등장 타이머 바 보기"
})

L:SetMiscLocalization({
	YellSplit1		= "그 오만한 콧대를 꺾어주마!",
	YellSplit2		= "한 줌의 희망마저 짓밟아주마!",
	YellPhase2		= "나는 공허의"
})

---------------------------
--  Kael'thas Sunstrider --
---------------------------
L = DBM:GetModLocalization("KaelThas")

L:SetGeneralLocalization({
	name = "캘타스 선스트라이더"
})

L:SetWarningLocalization({
	WarnGaze		= "주시: >%s<",
	WarnMobDead		= "%s 처치",
	WarnEgg			= "불사조 알 생성",
	SpecWarnGaze	= "당신을 주시 - 도망치세요!",
	SpecWarnEgg		= "불사조 알 생성 - 점사!"
})

L:SetTimerLocalization({
	TimerPhase		= "다음 단계",
	TimerNextGaze	= "새 주시 대상",
	TimerRebirth	= "불사조 환생"
})

L:SetOptionLocalization({
	WarnGaze		= "탈라드레드의 주시 대상 경고 보기",
	WarnMobDead		= "2단계 무기 처치 경고 보기",
	WarnEgg			= "불사조 알 생성시 경고 보기",
	SpecWarnGaze	= "주시 대상일 때 특수 경고 보기",
	SpecWarnEgg		= "불사조 알 생성시 특수 경고 보기",
	TimerPhase		= "다음 단계 타이머 바 보기",
	TimerPhase1mob	= "1단계 조언가 활성화 타이머 바 보기",
	TimerNextGaze	= "탈라드레드의 주시 대상 변경 타이머 바 보기",
	TimerRebirth	= "불사조 알 환생 남은 시간 타이머 바 보기",
	GazeIcon		= "탈라드레드의 주시 대상에 공격대 징표 설정"
})

L:SetMiscLocalization({
	YellPhase2	= "보다시피 내 무기고에는 굉장한 무기가 아주 많지.",
	YellPhase3	= "네놈들을 과소평가했나 보군. 모두를 한꺼번에 상대하라는 건 불공평한 처사지만, 나의 백성도 공평한 대접을 받은 적 없기는 매한가지. 받은 대로 돌려주겠다.",
	YellPhase4	= "때론 직접 나서야 할 때도 있는 법이지. 발라모어 샤날!",
	YellPhase5	= "이대로 물러날 내가 아니다! 반드시 내가 설계한 미래를 실현하리라! 이제 진정한 힘을 느껴 보아라!",
	YellSang	= "최고의 조언가를 상대로 잘도 버텨냈군. 허나 그 누구도 붉은 망치의 힘에는 대항할 수 없지. 보아라, 군주 생귀나르를!",
	YellCaper	= "카퍼니안, 놈들이 여기 온 것을 후회하게 해 줘라.",
	YellTelo	= "좋아, 그 정도 실력이면 수석기술자 텔로니쿠스를 상대해 볼만하겠어.",
	EmoteGaze	= "노려봅니다!",
	Thaladred	= "암흑의 인도자 탈라드레드",
	Sanguinar	= "군주 생귀나르",
	Capernian	= "대점성술사 카퍼니안",
	Telonicus	= "수석기술자 텔로니쿠스",
	Bow			= "황천매듭 장궁",
	Axe			= "참상의 도끼",
	Mace		= "우주 에너지 주입기(둔기)",
	Dagger		= "무한의 비수(단검)",
	Sword		= "차원 절단기(도검)",
	Shield		= "위상 변화의 보루 방패",
	Staff		= "붕괴의 지팡이",
	Egg			= "불사조 알"
})
