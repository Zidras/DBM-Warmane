if GetLocale() ~= "koKR" then return end
local L

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization({
	name = "사냥꾼 어튜멘"
})



--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization({
	name = "모로스"
})

L:SetWarningLocalization({
	DBM_MOROES_VANISH_FADED	= "소멸 끝"
})

L:SetOptionLocalization({
	DBM_MOROES_VANISH_FADED	= "소멸 끝 경고 보기"
})

-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization({
	name = "고결의 여신"
})

-- Romulo and Julianne
L = DBM:GetModLocalization("RomuloAndJulianne")

L:SetGeneralLocalization({
	name = "로밀로와 줄리엔"
})

L:SetMiscLocalization({
	Event				= "오늘 밤... 금지된 사랑의 이야기를 파헤쳐 보겠습니다!",
	RJ_Pull				= "당신들은 대체 누구시기에 절 이리도 괴롭히나요?",
	DBM_RJ_PHASE2_YELL	= "정다운 밤이시여. 어서 와서 나의 로밀로를 돌려주소서!",
	Romulo				= "로밀로",
	Julianne			= "줄리엔"
})

-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization({
	name = "커다란 나쁜 늑대"
})

L:SetMiscLocalization({
	DBM_BBW_YELL_1			= "잡아 먹기 좋으라고 그런거지!"
})

-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization({
	name = "오즈의 마법사"
})

L:SetWarningLocalization({
	DBM_OZ_WARN_TITO		= "티토",
	DBM_OZ_WARN_ROAR		= "어흥이",
	DBM_OZ_WARN_STRAWMAN	= "허수아비",
	DBM_OZ_WARN_TINHEAD		= "양철나무꾼",
	DBM_OZ_WARN_CRONE		= "마녀"
})

L:SetTimerLocalization({
	DBM_OZ_WARN_TITO		= "티토",
	DBM_OZ_WARN_ROAR		= "어흥이",
	DBM_OZ_WARN_STRAWMAN	= "허수아비",
	DBM_OZ_WARN_TINHEAD		= "양철나무꾼"
})

L:SetOptionLocalization({
	AnnounceBosses			= "우두머리 등장 경고 보기",
	ShowBossTimers			= "우두머리 등장 타이머 바 보기"
})

L:SetMiscLocalization({
	DBM_OZ_YELL_DOROTHEE	= "티토야, 우린 집으로 갈 방법을 찾아야 해! 늙은 마법사가 우릴 도와줄 수 있을 거야! 허수아비, 사자, 양철통아... 우리? 오... 맙소사, 손님들이 온 것 같아!",
	DBM_OZ_YELL_ROAR		= "하나도 안 무섭다고! 덤벼! 앞발 두 개를 몽땅 꺼내서 할퀴어주마!",
	DBM_OZ_YELL_STRAWMAN	= "너희를 어떻게 해주면 좋을까? 아무 생각도 나지 않아!",
	DBM_OZ_YELL_TINHEAD		= "나도 심장 갖고 싶어. 너희들 것 나한테 주면 안 될까?",
	DBM_OZ_YELL_CRONE		= "곧 모두 다 끝장날 것이다!"
})

-- Curator
L = DBM:GetModLocalization("Curator")

L:SetGeneralLocalization({
	name = "전시 관리인"
})

L:SetWarningLocalization({
	warnAdd		= "쫄 등장"
})

L:SetOptionLocalization({
	warnAdd		= "쫄 등장 경고 보기"
})

-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization({
	name = "테레스티안 일후프"
})

L:SetMiscLocalization({
	Kilrek					= "킬렉",
	DChains					= "악마의 사슬"
})

-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization({
	name = "아란의 망령"
})

L:SetWarningLocalization({
	DBM_ARAN_DO_NOT_MOVE	= "화염의 고리 - 이동 금지!"
})

L:SetTimerLocalization({
	timerSpecial			= "특수 기술 쿨타임"
})

L:SetOptionLocalization({
	timerSpecial			= "특수 기술 쿨타임 타이머 바 보기",
	DBM_ARAN_DO_NOT_MOVE	= "$spell:30004 특수 경고 보기"
})

--Netherspite
L = DBM:GetModLocalization("Netherspite")

L:SetGeneralLocalization({
	name = "황천의 원령"
})

L:SetWarningLocalization({
	warningPortal			= "차원문 단계",
	warningBanish			= "추방 단계"
})

L:SetTimerLocalization({
	timerPortalPhase	= "차원문 단계 종료",
	timerBanishPhase	= "추방 단계 종료"
})

L:SetOptionLocalization({
	warningPortal			= "차원문 단계 알림 보기",
	warningBanish			= "추방 단계 알림 보기",
	timerPortalPhase		= "차원문 단계 지속시간 타이머 바 보기",
	timerBanishPhase		= "추방 단계 지속시간 타이머 바 보기"
})

L:SetMiscLocalization({
	DBM_NS_EMOTE_PHASE_2	= "%s|1이;가; 황천의 기운을 받고 분노에 휩싸입니다!",
	DBM_NS_EMOTE_PHASE_1	= "%s|1이;가; 물러나며 고함을 지르더니 황천의 문을 엽니다."
})

--Chess
L = DBM:GetModLocalization("Chess")

L:SetGeneralLocalization({
	name = "체스 이벤트"
})

L:SetTimerLocalization({
	timerCheat	= "속임수 쿨타임"
})

L:SetOptionLocalization({
	timerCheat	= "속임수 쿨타임 타이머 바 보기"
})

L:SetMiscLocalization({
	EchoCheats	= "메디브의 메아리!"
})

--Prince Malchezaar
L = DBM:GetModLocalization("Prince")

L:SetGeneralLocalization({
	name = "공작 말체자르"
})

L:SetMiscLocalization({
	DBM_PRINCE_YELL_P2		= "바보 같으니! 시간은 너의 몸을 태우는 불길이 되리라!",
	DBM_PRINCE_YELL_P3		= "어찌 감히 이렇게 압도적인 힘에 맞서기를 꿈꾸느냐?",
	DBM_PRINCE_YELL_INF1	= "모든 차원과 실체가 나를 향해 열려 있노라!",
	DBM_PRINCE_YELL_INF2	= "이 말체자르님은 혼자가 아니시다. 너희는 나의 군대와 맞서야 한다!"
})

-- Nightbane
L = DBM:GetModLocalization("NightbaneRaid")

L:SetGeneralLocalization({
	name = "파멸의 어둠"
})

L:SetWarningLocalization({
	DBM_NB_AIR_WARN			= "공중 단계"
})

L:SetTimerLocalization({
	timerAirPhase			= "공중 단계"
})

L:SetOptionLocalization({
	DBM_NB_AIR_WARN			= "공중 단계 경고 보기",
	timerAirPhase			= "공중 단계 지속시간 타이머 바 보기"
})

L:SetMiscLocalization({
	DBM_NB_EMOTE_PULL		= "멀리에서 고대의 존재가 깨어납니다...",
	DBM_NB_YELL_AIR			= "이 더러운 기생충들, 내가 하늘에서 너희의 씨를 말리리라!",
	DBM_NB_YELL_GROUND		= "그만! 내 친히 내려가서 너희를 짓이겨주마!",
	DBM_NB_YELL_GROUND2		= "하루살이 같은 놈들! 나의 힘을 똑똑히 보여주겠다!"
})

-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization({
	name = "활강의 샤디키스"
})

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization({
	name = "잠복꾼 히아키스"
})

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization({
	name = "파괴자 로카드"
})
