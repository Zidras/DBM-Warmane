if GetLocale() ~= "koKR" then return end

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "거대 화염전차"
}

L:SetTimerLocalization{
}

L:SetMiscLocalization{
	YellPull	= "적대적인 존재 감지. 위협 수준 평가 체제 가동. 주 목표물과 교전. 위협 수준 재평가까지 30초.",
	YellPull2	= "Orbital countermeasures enabled.", --Needs Translating
	Emote		= "%%s 추적중 (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn				= "추적 >%s<!",
	warnNextPursueSoon		= "추적 전환 5 초전",
	SpecialPursueWarnYou	= "거대 화염전차가 당신을 추적합니다!",
	warnWardofLife			= "생명지기 덩굴손 등장"
}

L:SetOptionLocalization{
	SpecialPursueWarnYou	= "추적자 특수 경고 보기",
	PursueWarn				= "추적 플레이어 레이드 경고로 보기",
	warnNextPursueSoon		= "다음 추적 경고 보기",
	warnWardofLife			= "생명지기 덩굴손 등장 특수 경고 보기"
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "용광로 군주 이그니스"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SlagPotIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(63477)
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "칼날비늘"
}

L:SetWarningLocalization{
	warnTurretsReadySoon		= "마지막 포탑 20초 전",
	warnTurretsReady			= "마지막 포탑 준비",
	SpecWarnDevouringFlameCast	= "당신에게 파멸의 불길!",
	WarnDevouringFlameCast		= "파멸의 불길 : >%s<"
}

L:SetTimerLocalization{
	timerTurret1	= "1 번째 포탑",
	timerTurret2	= "2 번째 포탑",
	timerTurret3	= "3 번째 포탑",
	timerTurret4	= "4 번째 포탑",
	timerGrounded	= "지상 착지"
}

L:SetOptionLocalization{
	PlaySoundOnDevouringFlame	= "파멸의 불길 데미지를 받을 때 사운드 재생",
	warnTurretsReadySoon		= "포탑 사전 경고 보기",
	warnTurretsReady			= "포탑 경고 보기",
	SpecWarnDevouringFlameCast	= "파멸의 불길 대상이 되었을 때 특수 경고 보기",
	timerTurret1				= "첫번째 포탑 타이머 보기",
	timerTurret2				= "두번째 포탑 타이머 보기",
	timerTurret3				= "세번째 포탑 타이머 보기(25인)",
	timerTurret4				= "네번째 포탑 타이머 보기(25인)",
	OptionDevouringFlame		= "파멸의 불길 대상 알리기 (부정확함)",
	timerGrounded				= "지상 착지 유지 시간 보기"
}

L:SetMiscLocalization{
	YellAir				= "저희에게 잠깐 포탑을 설치할 시간을 주세요.",
	YellAir2			= "불꽃이 꺼졌습니다! 포탑을 재설치합시다!",
	YellGround			= "움직이세요! 오래 붙잡아둘 순 없을 겁니다!",
	EmotePhase2			= "완전히 땅에 내려앉았습니다!"
}

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002 해체자"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarningTTIn10Sec			= "Tympanic Tantrum in 10 sec." --Needs Translating
}

L:SetOptionLocalization{
	SetIconOnLightBombTarget		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(65121),
	SetIconOnGravityBombTarget		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(64234),
	WarningTympanicTantrumIn10Sec	= "Show special pre-warning (10 sec.) for $spell:62776 " --Needs Translating
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "무쇠 평의회"
}

L:SetWarningLocalization{
	WarningRuneofDeathIn10Sec = "RoD in ~10 sec." --Needs Translating
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	PlaySoundLightningTendrils	= "번개 덩굴일 때 소리 재생",
	SetIconOnOverwhelmingPower	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(61888),
	SetIconOnStaticDisruption	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(61912),
	AlwaysWarnOnOverload		= "과부하 일 때 지속적인 경고 알리기(타겟일 경우만)",
	PlaySoundOnOverload			= "과부화 일 때 소리 재생",
	PlaySoundDeathRune			= "죽음의 룬일 때 소리 재생",
}

L:SetMiscLocalization{
	Steelbreaker				= "강철파괴자",
	RunemasterMolgeim			= "룬술사 몰가임",
	StormcallerBrundir			= "폭풍소환사 브룬디르",
	YellPull1					= "Whether the world's greatest gnats or the world's greatest heroes, you're still only mortal!", --Needs Translating
	YellPull2					= "Nothing short of total decimation will suffice.", --Needs Translating
	YellPull3					= "You will not defeat the Assembly of Iron so easily, invaders!", --Needs Translating
	YellRuneOfDeath				= "Decipher this!", --Needs Translating
	YellRunemasterMolgeimDied	= "What have you gained from my defeat? You are no less doomed, mortals!", --Needs Translating
	YellRunemasterMolgeimDied2	= "The legacy of storms shall not be undone.", --Needs Translating
	YellStormcallerBrundirDied	= "The power of the storm lives on...", --Needs Translating
	YellStormcallerBrundirDied2	= "You rush headlong into the maw of madness!", --Needs Translating
	YellSteelbreakerDied		= "My death only serves to hasten your demise.", --Needs Translating
	YellSteelbreakerDied2		= "Impossible!" --Needs Translating
}

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "관찰자 알갈론"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "다음 붕괴의 별",
	NextCosmicSmash			= "다음 우주의 강타",
	TimerCombatStart		= "전투 시작"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "위상의 주먹 : >%s< - %d 중첩",
	WarningCosmicSmash 		= "우주의 강타 - 폭발 4초 전",
	WarnPhase2Soon			= "곧 2 페이즈",
	warnStarLow				= "붕괴의 별 체력 낮음"
}

L:SetOptionLocalization{
	WarningPhasePunch		= "위상의 주먹 대상 알리기",
	NextCollapsingStar		= "다음 붕괴의 별 시전 타이머 보기",
	WarningCosmicSmash 		= "우주의 강타 알리기",
	NextCosmicSmash			= "다음 우주의 강타 시전 타이머 보기",
	TimerCombatStart		= "전투 시작 타이머 보기",
	WarnPhase2Soon			= "2 페이즈 사전 경고 보기(23% 이하)",
	warnStarLow				= "붕괴의 별 체력이 낮을 경우 특수 경고 보기(25% 이하)"
}

L:SetMiscLocalization{
	YellPull				= "너희 행동은 비논리적이다. 이 전투에서 가능한 결말은 모두 계산되었다. 결과와 상관없이 판테온은 관찰자의 전갈을 받을 것이다.",
	YellPull2 				= "Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer's message regardless of outcome.", --Needs Translating
	YellKill				= "나는 창조주의 불길이 씻어내린 세상을 보았다. 모두 변변히 저항도 못하고 사그라졌지. 너희 필멸자의 심장이 단 한번 뛸 시간에 전 행성계가 탄생하고 무너졌다. 그러나 그 모든 시간 동안, 나는 공감이란 감정을... 몰랐다. 나는, 아무것도, 느끼지, 못했다. 무수한, 무수한 생명이 꺼졌다. 그들이 모두 너희처럼 강인했더냐? 그들이 모두 너희처럼 삶을 사랑했단 말이냐?",
	Emote_CollapsingStar	= "붕괴의 별을 시전 합니다!",
	Phase2					= "창조의 도구를 바라보아라!",
	CollapsingStar			= "Collapsing Star",
	PullCheck				= "(%d+)분 후에 알갈론이 신호 전송을 시작합니다."
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "콜로간"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerLeftArm		= "왼쪽 팔 재생성",
	timerRightArm		= "오른쪽 팔 재생성",
	achievementDisarmed	= "무장해제 업적"
}

L:SetOptionLocalization{
	timerLeftArm			= "왼쪽 팔 재생성 타이머 보기",
	timerRightArm			= "오른쪽 팔 재생성 타이머 보기",
	achievementDisarmed		= "무장해제 타이머 보기",
	SetIconOnGripTarget		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(64292),
	SetIconOnEyebeamTarget	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(63346),
	PlaySoundOnEyebeam		= "안광 집중 특수 소리 재생",
	YellOnBeam				= "Yell on $spell:63346" --Needs Translating
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "얕은 상처야!",
	Yell_Trigger_arm_right	= "꽉꽉 쥐어짜 주마!",
	YellEncounterStart		= "None shall pass!", --Needs Translating
	YellLeftArmDies			= "Just a scratch!", --Needs Translating
	YellRightArmDies		= "Only a flesh wound!", --Needs Translating
	Health_Body				= "콜로간 몸통",
	Health_Right_Arm		= "오른쪽 팔",
	Health_Left_Arm			= "왼쪽 팔",
	FocusedEyebeam			= "당신에게 안광을 집중합니다!",
	YellBeam				= "Focused Eyebeam on me!" --Needs Translating
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "아우리아야"
}

L:SetMiscLocalization{
	Defender = "수호 야수 (%d)",
	YellPull = "내버려두는 편이 나았을 텐데!"
}

L:SetTimerLocalization{
	timerDefender	= "수호 야수 활성"
}

L:SetWarningLocalization{
	SpecWarnBlast	= "수호 야수 폭발 - 차단!",
	WarnCatDied		= "수호 야수 죽음 (%d 번 남음)",
	WarnCatDiedOne	= "수호 야수 죽음 (1 번 남음)"
}

L:SetOptionLocalization{
	SpecWarnBlast	= "수호 야수 폭발 특수 경고 보기",
	WarnCatDied		= "수호 야수의 남은 부활 횟수 경고 보기",
	WarnCatDiedOne	= "마지막 수호 야수 경고 보기(1 번 남음)",
	timerDefender	= "다음 수호 야수 활성 타이머 보기"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "호디르"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	PlaySoundOnFlashFreeze	= "Play sound on $spell:61968 cast", --Needs Translating
	YellOnStormCloud		= "Yell on $spell:65133", --Needs Translating
	SetIconOnStormCloud		= "Set icons on $spell:65133 targets" --Needs Translating
}

L:SetMiscLocalization{
	YellKill	= "드디어... 드디어 그의 손아귀를... 벗어나는구나.",
	YellCloud	= "폭풍 구름! 비벼요!!"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "토림"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	TimerHardmode	= "하드 모드"
}

L:SetOptionLocalization{
	TimerHardmode	= "하드 모드를 위한 타이머 보기",
	RangeFrame		= "거리 창 보기",
	AnnounceFails	= "번개 충전을 피하지 못했을 경우 공격대에 알리기\n(번개 충전 알리기/공대장 권한이 있을 경우)"
}

L:SetMiscLocalization{
	YellPhase1	= "침입자라니! 감히 내 취미 생활을 방해하는 놈들은 쓴맛을 단단히... 잠깐... 너는...",
	YellPhase2	= "건방진 젖먹이 같으니... 감히 여기까지 기어올라와 내게 도전해? 내 손으로 쓸어버리겠다!",
	YellKill	= "무기를 거둬라! 내가 졌다!",
	ChargeOn	= "번개 충전: %s",
	Charge		= "번개 충전 실패 (현재 트라이): %s"
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "프레이야"
}

L:SetMiscLocalization{
	SpawnYell			= "얘들아, 날 도와라!",
	WaterSpirit			= "고대 물의 정령",
	Snaplasher 			= "악어덩굴손",
	StormLasher 		= "폭풍덩굴손",
	YellKill			= "내게서 그의 지배력이 걷혔다. 다시 온전한 정신을 찾았도다. 영웅들이여, 고맙다.",
	YellAdds1			= "Eonar, your servant requires aid!", --Needs Translating
	YellAdds2			= "The swarm of the elements shall overtake you!", --Needs Translating
	EmoteLGift			= "begins to grow!", --Needs Translating
	TrashRespawnTimer	= "프레이야 지역 리젠타임"
}

L:SetWarningLocalization{
	WarnSimulKill		= "첫번째 소환수 죽음 - 12초 후 부활",
	WarningBeamsSoon	= "Beams soon", --Needs Translating
	EonarsGift			= "Target Change - switch to Eonar's Gift" --Needs Translating
}

L:SetTimerLocalization{
	TimerSimulKill	= "소환수 부활"
}

L:SetOptionLocalization{
	WarnSimulKill	= "첫번째 소환수 죽음 알리기",
	PlaySoundOnFury	= "자연의 격노 특수 사운드 재생",
	WarningTremor  	= "지진 시전 특수 경고 보기 (하드 모드)",
	TimerSimulKill	= "소환수 부활 타이머 보기"
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "프레이야의 장로"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "프레이야 지역 리젠타임"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	PlaySoundOnFistOfStone	= "돌덩이 주먹 특수 사운드 재생",
	TrashRespawnTimer		= "프레이야 지역 리젠 타이머 보기"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "미미론"
}

L:SetWarningLocalization{
	MagneticCore		= "자기 증폭기 획득 : >%s<",
	WarningShockBlast	= "충격파 - 움직이세요!",
	WarnBombSpawn		= "폭탄 로봇 생성!",
	WarningFlamesIn5Sec = "Flames in 5 sec."
}

L:SetTimerLocalization{
	TimerHardmode	= "하드 모드 - 자폭장치 가동",
	TimeToPhase2	= "2 페이즈",
	TimeToPhase3	= "3 페이즈",
	TimeToPhase4	= "4 페이즈"
}

L:SetOptionLocalization{
	TimeToPhase2			= "페이즈 2 시작 알리기",
	TimeToPhase3			= "페이즈 3 시작 알리기",
	TimeToPhase4			= "페이즈 4 시작 알리기",
	MagneticCore			= "자기 증폭기 획득자 알리기",
	HealthFramePhase4		= "페이즈 4 의 체력 프레임 보기",
	AutoChangeLootToFFA		= "3 페이즈에서 루팅 옵션 자동 변경하기",
	WarnBombSpawn			= "폭탄 로봇 생성 알리기",
	TimerHardmode			= "하드 모드를 위한 타이머 보기",
	PlaySoundOnShockBlast	= "Play sound on $spell:63631", --Needs Translating
	PlaySoundOnDarkGlare	= "Play sound on $spell:63414", --Needs Translating
	ShockBlastWarningInP1	= "1 페이즈 충격파의 특수 경고 보기(근접 딜러)",
	ShockBlastWarningInP4	= "4 페이즈 충격파의 특수 경고 보기(근접 딜러)",
	RangeFrame				= "1 페이즈에서 거리 프레임 보기(6 미터)",
	SetIconOnNapalm			= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(65026),
	SetIconOnPlasmaBlast	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(62997),
	WarnFlamesIn5Sec 		= "Show special warning: Flames in 5 sec.", --Needs Translating
	SoundWarnCountingFlames = "Play a 5 second audio countdown for next flames" --Needs Translating
}

L:SetMiscLocalization{
	MobPhase1		= "거대 전차 Mk II",
	MobPhase2		= "VX-001",
	MobPhase3		= "공중지휘기",
	YellPull		= "시간이 없어, 친구들! 내가 최근에 만든 기막힌 발명품을 시험하게 도와 주겠지? 자, 마음 바꿀 생각은 말라고. XT-002를 그 꼬락서니로 만들었으니, 너흰 나한테 빚진 셈이란 걸 잊지 마!",
	YellHardPull	= "아니, 대체 왜 그런 짓을 한 게지? \"누르지 마시오.\"라고 쓰인 경고 문구 못 봤나? 자폭 장치를 활성화해 놓으면, 도대체 어떻게 발명품을 시험하지?",
	YellPhase2		= "멋지군! 참으로 경이적인 결과야! 차체 내구도 98.9 퍼센트라! 손상이라고 보기도 어렵지! 계속하자고.",
	YellPhase3		= "고맙다, 친구들! 너희 덕분에 멋진 자료를 좀 얻었어! 자, 그걸 어디 뒀더라... 아, 여기 있군.",
	YellPhase4		= "예비 시험은 이걸로 끝이다. 자 이제부터가 진짜라고!",
	YellKilled		= "It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison. overriding my primary directive. All systems seem to be functional now. Clear.", --Needs Translating
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "장군 베작스"
}

L:SetTimerLocalization{
	hardmodeSpawn = "사로나이트 원혼 생성"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "당신에게 어둠 붕괴 - 이동하세요!",
	SpecialWarningShadowCrashNear	= "당신 주변에 어둠 붕괴!",
	SpecialWarningLLNear			= ">%s< 에게 가까운 당신에게 생명력 흡수 시전!"
}

L:SetOptionLocalization{
	SetIconOnShadowCrash			= "어둠 붕괴 대상 공격대 아이콘 설정하기(해골)",
	SetIconOnLifeLeach				= "얼굴 없는 자의 징표 대상 공격대 아이콘 설정하기(엑스)",
	SpecialWarningShadowCrash		= "어둠 붕괴 특수 경고 보기(공대원 중 베작스 대상/주시 일 경우)",
	SpecialWarningShadowCrashNear	= "주변에 어둠 붕괴일 때 특수 경고 보기",
	SpecialWarningLLNear			= "생명력 흡수 주변 특수 경고 보기",
	YellOnLifeLeech					= "생명력 흡수를 당할 때 외치기",
	YellOnShadowCrash				= "어둠 붕괴일 때 외치기",
	hardmodeSpawn					= "사로나이드 원혼 생성 타이머 보기(하드모드)",
	CrashArrow						= "$spell:62660의 방향을 DBM Arrow로 표시하기(당신 주변일 경우)",
	BypassLatencyCheck				= "$spell:62660의 동기화를 사용하지 않거나 네트워크 체크를 하지 않습니다.\n(만약 DBM 사용에 문제가 생기면 사용하세요.)",
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "가까운 사로나이트 증기 구름이 합쳐집니다!",
	YellLeech			= "저에게 생명력 흡수 시전!",
	YellCrash			= "저에게 어둠 붕괴! 피하세요!"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "요그사론"
}

L:SetMiscLocalization{
	YellPull 			= "짐승의 대장을 칠 때가 곧 다가올 거예요! 놈의 졸개들에게 노여움과 미움을 쏟아부으세요!",
	YellPhase2			= "나는, 살아 있는 꿈이다.",
	Sara 				= "사라",
	WarningYellSqueeze	= "압착의 촉수에 붙잡혔어요! 살려주세요!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "요그사론의 수호자 %d 소환!",
	WarningCrusherTentacleSpawned	= "분쇄의 촉수가 생성되었습니다!",
	WarningSanity 					= "> %d < 이성이 낮습니다.",
	SpecWarnSanity 					= ">> %d << 이성이 매우 낮습니다. 채우세요!",
	SpecWarnGuardianLow				= "수호자 딜 주의하세요! - 공격 주의!",
	SpecWarnMadnessOutNow			= "광기 유발이 끝났습니다. - 밖으로 이동!",
	WarnBrainPortalSoon				= "3 초 후 내부 포탈이 열립니다.",
	SpecWarnFervor					= "당신에게 사라의 열정",
	SpecWarnFervorCast				= "당신에게 사라의 열정을 시전했습니다.",
	SpecWarnMaladyNear				= ">%s< 의 주변에 병든 정신",
	specWarnBrainPortalSoon			= "곧 내부 포탈이 열립니다!",
}

L:SetTimerLocalization{
	NextPortal	= "내부 차원문"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "요그사론의 수호자 소환 알리기",
	WarningCrusherTentacleSpawned	= "분쇄의 촉수 생성 알리기",
	WarningSanity					= "이성이 낮은 경우 경고 보기",
	SpecWarnSanity					= "이성이 매우 낮은 경우 특수 경고 보기",
	SpecWarnGuardianLow				= "수호자의 생명력이 낮을 때 특수 경고 보기(1페이즈 / 딜러)",
	WarnBrainPortalSoon				= "내부 차원문 알리기",
	SpecWarnMadnessOutNow			= "광기 유발이 끝나기 전 특수 경고 알리기",
	SetIconOnFearTarget				= "병든 정신 타겟 아이콘 설정하기",
	SpecWarnFervorCast				= "당신에게 사라의 열정을 시전 할 때 특수 경고 보기(사라 대상/주시 일 경우)",
	specWarnBrainPortalSoon			= "내부 차원문 특수 경고 알리기",
	WarningSqueeze					= "압착의 촉수의 대상이 됏을 경우 외치기",
	NextPortal						= "다음 내부 차원문 알리기",
	SetIconOnFervorTarget			= "사라의 열정 타겟 아이콘 설정하기",
	ShowSaraHealth					= "사라 체력 보기(공대원 중 사라 대상/주시 일 경우)",
	SpecWarnMaladyNear				= "병든 정신이 걸린 플레이어가 근처에 있을 경우 특수 경고 알리기(병든 정신 종료 후)",
	SetIconOnBrainLinkTarget		= "두뇌 연결 대상 공격대 아이콘 설정",
	MaladyArrow						= "$spell:63881 걸린 공대원이 주변에 있을 경우 화살표 보기"
}
