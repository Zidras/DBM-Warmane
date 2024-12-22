if GetLocale() ~= "koKR" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "군주 매로우가르"
})

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization({
	name = "여교주 데스위스퍼"
})

L:SetTimerLocalization({
	TimerAdds	= "다음 이교도"
})

L:SetWarningLocalization({
	WarnReanimating				= "이교도 부활",			-- Reanimating an adherent or fanatic
	WarnAddsSoon				= "곧 새로운 이교도 등장",
	SpecWarnVengefulShade		= "복수의 망령 공격 - 피하세요!",--creatureid 38222
	WeaponsStatus				= "Auto Unequipping enabled: %s (%s - %s)" --Needs Translating
})

L:SetOptionLocalization({
	WarnAddsSoon				= "이교도 등장 이전에 알림 보기",
	WarnReanimating				= "이교도 부활 알림 보기",
	TimerAdds					= "다음 이교도 바 보기",
	SpecWarnVengefulShade		= "복수의 망령으로부터 공격을 받을 경우 특수 경고 보기",--creatureid 38222
	WeaponsStatus				= "Special warning at combat start if unequip/equip function is enabled", --Needs Translating
	ShieldHealthFrame			= "$spell:70842의 방어막 바와 보스 체력바를 함께 보기",
	SoundWarnCountingMC			= "Play a 5 second audio countdown for Mind Control", --Needs Translating
--	RemoveDruidBuff				= "Remove $spell:48469 / $spell:48470 24 seconds into the fight", --Needs Translating
	RemoveBuffsOnMC				= "$spell:71289를 시전하면 버프를 제거합니다. 각 옵션은 누적됩니다.",
	Gift						= "$spell:48469 / $spell:48470을 제거합니다. $spell:33786 저항을 방지하기 위한 최소한의 접근입니다.",
	CCFree						= "+ $spell:48169 / $spell:48170을 제거합니다. 그림자 학교의 주문 저항을 설명합니다.",
	ShortOffensiveProcs			= "+ 지속 시간이 짧은 공격 절차를 제거합니다. 공격대 피해 출력을 손상시키지 않으면서 공격대 안전을 위해 권장됩니다.",
	MostOffensiveBuffs			= "+ 대부분의 공격 버프를 제거합니다(주로 캐스터 및 |cFFFF7C0A야성 드루이드|r용). 손상 출력 손실로 최대 레이드 안전 및 자체 버프/변형이 필요합니다!",
	EqUneqWeapons				= "Unequip/equip weapons if $spell:71289 is cast on you. For equipping to work, create a COMPLETE (with the weapons of choice that will be equipped) equipment set named \"pve\".", --Needs Translating
	EqUneqTimer					= "Remove weapons by timer ALWAYS, not on cast (if ping is high). The option above must be enabled." --Needs Translating
})

L:SetMiscLocalization({
	YellReanimatedFanatic	= "일어나라, 순수한 모습을 기뻐하라!",
	ShieldPercent			= "마나 방벽",
--	Fanatic1				= "교단 광신자",
--	Fanatic2				= "변형된 광신자",
--	Fanatic3				= "되살아난 광신자",
	setMissing				= "주목! DBM 자동 무기 해제/장착은 pve라는 장비 세트를 생성할 때까지 작동하지 않습니다.",
	EqUneqLineDescription	= "자동 장착/장비 해제"
})

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization({
	name = "얼음왕관 비행포격선 전투"
})

L:SetWarningLocalization({
	WarnAddsSoon	= "곧 추가 병력"
})

L:SetOptionLocalization({
	WarnAddsSoon	= "추가 병력 이전에 알림 보기",
	TimerAdds		= "다음 추가 병력 바 보기"
})

L:SetTimerLocalization({
	TimerAdds		= "다음 추가 병력"
})

L:SetMiscLocalization({
	PullAlliance	= "속도를 올려라! 제군들, 곧 운명과 마주할 것이다!",
	PullHorde		= "호드의 아들딸이여, 일어나라! 오늘 우리는 증오하던 적과 전투를 벌이리라! 록타르 오가르!",
	AddsAlliance	= "약탈자, 하사관, 공격하라!",
	AddsHorde		= "해병, 하사관, 공격하라!",
	MageAlliance	= "선체가 공격받고 있다. 전투마법사를 불러 저 대포를 막아버려라!",
	MageHorde		= "선체가 공격받고 있다. 마술사를 불러 저 대포를 막아버려라!",
	KillAlliance	= "악당 놈들, 분명히 경고했다! 형제자매여, 전진!",
	KillHorde		= "얼라이언스는 기가 꺾였다. 리치 왕을 향해 전진하라!"
})

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization({
	name = "죽음의 인도자 사울팽"
})

L:SetOptionLocalization({
	RunePowerFrame		= "보스 체력 바와 함께 $spell:72371 바 보기",
--	RemoveDI			= "$spell:19752를 지웁니다. $spell:72293이 캐스팅되지 않도록 합니다."
})

L:SetMiscLocalization({
	RunePower			= "피 마력",
	PullAlliance		= "그러면 이동하자! 이동...",
	PullHorde			= "코르크론, 출발하라! 용사들이여, 뒤를 조심하게. 스컬지는..."
})

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "구린속"
})

L:SetOptionLocalization({
	AnnounceSporeIcons	= "$spell:69279 대상 공격대 징표 채팅으로 알리기\n(공대장 혹은 권한을 가진 사람만 사용 가능)",
	AchievementCheck	= "역병 예방 접종 업적 실패시 실패 내용을 공격대 대화로 알리기(공격대장 권한 필요)"
})

L:SetMiscLocalization({
	SporeSet			= "가스 포자 아이콘{rt%d} : %s",
	AchievementFailed	= ">> 업적 실패 - 역병 저항 : %s (%d 중첩) <<"
})

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization({
	name = "썩은얼굴"
})

L:SetWarningLocalization({
	WarnOozeSpawn				= "작은 수액괴물 생성",
	SpecWarnLittleOoze			= "작은 수액괴물의 공격! - 뛰세요!"--creatureid 36897
})

L:SetOptionLocalization({
	WarnOozeSpawn				= "작은 수액괴물 생성 알림 보기",
	SpecWarnLittleOoze			= "작은 수액괴물에게 공격을 받을 경우 특수 경고 보기",
	TankArrow					= "큰 수액괴물 탱커 방향 DBM 화살표 보기(테스트)"
})

L:SetMiscLocalization({
	YellSlimePipes1	= "좋은 소식이에요, 여러분! 독성 수액 배출관을 고쳤어요!",	-- Professor Putricide
	YellSlimePipes2	= "끝내 주는 소식이에요, 여러분! 수액이 다시 나오는군요!"	-- Professor Putricide
})

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization({
	name = "교수 퓨트리사이드"
})

L:SetWarningLocalization({
	WarnReengage			= "%s: 재전투"
})

L:SetTimerLocalization({
	TimerReengage			= "재전투"
})

--[[L:SetOptionLocalization({
	WarnReengage			= "Show warning for Boss re-engage", -- needs localization
	TimerReengage			= "Show timer for Boss re-engage" -- needs localization
})]]

L:SetMiscLocalization({
	YellTransform1			= "흠, 아무 느낌도 없군요. 엥?! 이건 어디서 온 거지요?",
	YellTransform2			= "이 맛은... 체리군요! 오! 이런 실례!"
})

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization({
	name = "피의 의회"
})

L:SetWarningLocalization({
	WarnTargetSwitch		= "대상 전환 : %s",
	WarnTargetSwitchSoon	= "곧 대상 전환"
})

L:SetTimerLocalization({
	TimerTargetSwitch		= "대상 전환"
})

L:SetOptionLocalization({
	WarnTargetSwitch		= "대상 전환 알림 보기",
	WarnTargetSwitchSoon	= "대상 전환 이전에 알림 보기",
	TimerTargetSwitch		= "대상 전환 바 보기",
	ActivePrinceIcon		= "활성화 된 공작에게 전술 목표 아이콘 설정(해골)",
	ShadowPrisonMetronome	= "$spell:72999를 피하기 위해 반복적인 1초 클릭 사운드 재생"
})

L:SetMiscLocalization({
	Keleseth			= "공작 켈레세스",
	Taldaram			= "공작 탈다람",
	Valanar				= "공작 발라나르",
	FirstPull			= "어리석은 필멸자들 같으니. 그리 쉽게 우리를 이겼다고 생각했어? 산레인은 리치 왕이 다스리는 불멸의 병사들이야! 이제 합쳐진 그 힘을 보여주겠어!",
	EmpoweredFlames		= "강력한 불꽃이 (%S+)"
})

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization({
	name = "피의 여왕 라나텔"
})

L:SetOptionLocalization({
	RangeFrame				= "거리 창 보기 (8 m)"
})

L:SetMiscLocalization({
	SwarmingShadows			= "어둠이 쌓이더니 (%S+)",
	YellFrenzy				= "피가 모잘라~! 앙~"
})

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization({
	name = "발리스리아 드림워커"
})

L:SetWarningLocalization({
	WarnPortalOpen	= "차원문 열림"
})

L:SetTimerLocalization({
	TimerPortalsOpen			= "차원문 열림",
	TimerPortalsClose			= "차원문 닫힘",
	TimerBlazingSkeleton		= "다음 타오르는 해골",
	TimerAbom					= "다음 누더기골렘 (%s)"
})

L:SetOptionLocalization({
	WarnPortalOpen				= "$spell:72483 열림 알림 보기",
	TimerPortalsOpen			= "차원문 열림 바 보기",
	TimerPortalsClose			= "차원문 닫힘 바 보기",
	TimerBlazingSkeleton		= "다음 타오르는 해골 바 보기"
})

L:SetMiscLocalization({
	YellPull		= "침입자들이 내부 성소로 들어왔다. 서둘러 녹색용을 파멸시켜라! 되살려 낼 때 쓸 뼈와 힘줄만 남겨라!",
	YellPortals		= "에메랄드의 꿈으로 가는 차원문을 열어두었다. 너희의 구원은 그 안에 있다..."
})

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization({
	name = "신드라고사"
})

L:SetWarningLocalization({
	WarnAirphase			= "공중 단계",
	WarnGroundphaseSoon		= "곧 신드라고사 착륙"
})

L:SetTimerLocalization({
	TimerNextAirphase		= "다음 공중 단계",
	TimerNextGroundphase	= "신드라고사 착륙",
	AchievementMystic		= "신비한 아픔 업적 가능"
})

L:SetOptionLocalization({
	WarnAirphase			= "공중 단계 알림 보기",
	WarnGroundphaseSoon		= "신드라고사 착륙 이전에 알림 보기",
	TimerNextAirphase		= "다음 공중 단계 바 보기",
	TimerNextGroundphase	= "신드라고사 착륙 바 보기",
	AnnounceFrostBeaconIcons= "$spell:70126 전술 목표 아이콘 설정 내역을 공격대 대화로 알리기(공격대장 권한 필요)",
	ClearIconsOnAirphase	= "공중 단계에서 모든 전술 목표 아이콘 제거",
	AssignWarnDirectionsCount	= "$spell:70126 대상에 위치를 지정합니다. 2단계에서 $spell:70126을 세십시오",
	AchievementCheck		= "신비한 아픔 업적 실패시 실패 내용을 공격대 대화로 알리기(공격대장 권한 필요)",
	RangeFrame				= "강화 또는 약화 효과에 맞추어 거리 창 보기(10/20m)"
})

L:SetMiscLocalization({
	YellAirphase		= "여기가 끝이다! 아무도 살아남지 못하리라!",
	YellPhase2			= "자, 주인님의 무한한 힘을 느끼고 절망에 빠져보아라!",--Now, feel my master's limitless power and despair!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "냉기 봉화 아이콘{rt%d} : %s",
	AchievementWarning	= "경고 : %s님의 신비한 강타가 5 중첩입니다.",
	AchievementFailed	= ">> 업적 실패 - 신비한 아픔 : %s (%d 중첩) <<"
})

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization({
	name = "리치 왕"
})

L:SetWarningLocalization({
	ValkyrWarning				= "발키리 납치 : %s >%s< %s",
	SpecWarnYouAreValkd			= "발키리가 납치 중!",
	WarnNecroticPlagueJump		= "괴저 역병 전이 : >%s<",
	SpecWarnValkyrLow			= "발키리 HP 55% 이하!!"
})

L:SetTimerLocalization({
	TimerRoleplay				= "이벤트 종료",
	PhaseTransition				= "다음 단계",
	TimerNecroticPlagueCleanse	= "괴저 역병 사라짐"
})

L:SetOptionLocalization({
	TimerRoleplay				= "이벤트 종료 바 보기",
	WarnNecroticPlagueJump		= "$spell:70337 전이 대상 알림",
	TimerNecroticPlagueCleanse	= "$spell:70337 사라짐 바 보기",
	PhaseTransition				= "다음 단계 바 보기",
	ValkyrWarning				= "발키리 대상 알림 보기",
	SpecWarnYouAreValkd			= "발키리에게 붙잡혔을 때 특수 경고 보기",
	AnnounceValkGrabs			= "발키리 대상 및 전술 목표 아이콘 설정 내용을 공격대 대화로 알리기(공격대장 권한 필요)",
	SpecWarnValkyrLow			= "발키리의 HP가 55%이하가 된 경우 특수 경고 보기",
	AnnouncePlagueStack			= "$spell:70337 중첩 알림 보기(10중첩 이상일때, 5 중첩마다)(공격대장 권한 필요)",
	ShowFrame					= "Show Val'Kyr Targets frame", --Needs Translating
	FrameClassColor				= "Use Class Colors in Val'Kyr Targets frame", --Needs Translating
	FrameUpwards				= "Expand Val'Kyr target frame upwards", --Needs Translating
	FrameLocked					= "Lock Val'Kyr Targets frame", --Needs Translating
	RemoveImmunes				= "Remove immunity spells before exiting Frostmourne room" --Needs Translating
})

L:SetMiscLocalization({
	LKPull					= "그러니까 성스러운 빛이 자랑하던 정의가 마침내 왔다 이건가? 폴드링, 서리한을 내려놓고 자비라도 애걸하라는 건가?",
	LKRoleplay				= "진정으로 정의에 이끌렸단 말이냐? 궁금하구나...",
	ValkGrabbedIcon			= "발키리 납치 : {rt%d} %s",
	ValkGrabbed				= "발키리 납치 : %s",
	PlagueStackWarning		= "경고: 괴저역병 - %s (%d 중첩)",
	AchievementCompleted	= ">> 업적 성공 - 괴저역병 %s (%d 중첩) <<",
	FrameTitle				= "Valkyr targets", --Needs Translating
	FrameLock				= "Frame Lock", --Needs Translating
	FrameClassColor			= "Use Class Colors", --Needs Translating
	FrameOrientation		= "Expand upwards", --Needs Translating
	FrameHide				= "Hide Frame", --Needs Translating
	FrameClose				= "Close", --Needs Translating
	FrameGUIDesc			= "발키르 프레임",
	FrameGUIMoveMe			= "발키르 프레임 이동"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ICCTrash")

L:SetGeneralLocalization({
	name = "얼음왕관 성채: 일반구간"
})

L:SetWarningLocalization({
	SpecWarnTrapL		= "함정 활성화 - 죽음에 속박된 감시자!",
	SpecWarnTrapP		= "함정 활성화 - 복수의 육신해체자!",
	SpecWarnGosaEvent	= "신드라고사 수호병 등장!"
})

L:SetOptionLocalization({
	SpecWarnTrapL		= "죽음에 속박된 감시자 함정 활성화 특수 경고 보기",
	SpecWarnTrapP		= "복수의 육신해체자 함정 활성화 특수 경고 보기",
	SpecWarnGosaEvent	= "신드라고사 수호병 특수 경고 보기"
})

L:SetMiscLocalization({
	WarderTrap1			= "거기... 누구냐?",
	WarderTrap2			= "내가... 깨어난다!",
	WarderTrap3			= "주인님의 성소를 어지럽혔구나!",
	FleshreaperTrap1	= "서둘러! 저놈들 뒤에서 습격하자!",
	FleshreaperTrap2	= "우리에게서... 벗어날 수 없다!",
	FleshreaperTrap3	= "살아있는 놈이... 여기에?!",
	SindragosaEvent		= "서리 여왕께 다가가도록 두지 않겠다. 서둘러라! 저들을 막아라!"
})
