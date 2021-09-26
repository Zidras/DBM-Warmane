if GetLocale() ~= "koKR" then return end

local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--   샤드론  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "샤드론"
})

---------------
--  테네브론  --
---------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "테네브론"
})

---------------
--  베스페론  --
---------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "베스페론"
})

---------------
--  살타리온  --
---------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "살타리온"
})

L:SetWarningLocalization({
	WarningTenebron			= "테네브론 진입",
	WarningShadron			= "샤드론 진입",
	WarningVesperon			= "베스페론 진입",
	WarningFireWall			= "화염의 벽!",
	WarningVesperonPortal	= "베스페론의 차원문 생성!!",
	WarningTenebronPortal	= "테네브론의 차원문 생성!!",
	WarningShadronPortal	= "샤드론의 차원문 생성!!"
})

L:SetTimerLocalization({
	TimerTenebron		= "테네브론 진입",
	TimerShadron		= "샤드론 진입",
	TimerVesperon		= "베스페론 진입"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall		= "화염의 벽 특수 소리 듣기",
	AnnounceFails			= "화염의 벽 및 어둠의 균열을 피하지 못한 공대원을 대화창에 알리기(승급 권한 필요)",
	TimerTenebron			= "테네브론 진입 바 보기",
	TimerShadron			= "샤드론 진입 바 보기",
	TimerVesperon			= "베스페론 진입 바 보기",
	WarningFireWall			= "화염의 벽 특수 경고 보기",
	WarningTenebron			= "테네브론 진입 알림",
	WarningShadron			= "샤드론 진입 알림",
	WarningVesperon			= "베스페론 진입 알림",
	WarningTenebronPortal	= "테네브론의 차원문 특수 경고 보기",
	WarningShadronPortal	= "샤드론의 차원문 특수 경고 보기",
	WarningVesperonPortal	= "베스페론의 차원문 특수 경고 보기"
})

L:SetMiscLocalization({
	Wall			= "둘러싼 용암이 끓어오릅니다!",
	Portal			= "황혼의 차원문을 엽니다!!",
	NameTenebron	= "테네브론",
	NameShadron		= "샤드론",
	NameVesperon	= "베스페론",
	FireWallOn		= "용암 파도 : %s",
	VoidZoneOn		= "어둠의 균열 : %s",
	VoidZones		= "어둠의 균열 실패(현재 시도): %s",
	FireWalls		= "용암 파도 실패(현재 시도): %s"
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "전쟁의 아들 발타루스"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "곧 분리"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "분리 이전에 알림 보기",
	RangeFrame			= "거리 창 보기 (12 미터)"
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "사비아나 레이지파이어"
})

L:SetOptionLocalization({
	RangeFrame				= "거리 창 보기 (10 미터)"
})

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "장군 자리스리안"
})

L:SetWarningLocalization({
	WarnAdds			= "지원 병력",
	warnCleaveArmor		= "%s : >%s< (%s)"	-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds	= "다음 지원 병력"
})

L:SetOptionLocalization({
	WarnAdds		= "지원 병력 알림 보기",
	TimerAdds		= "다음 지원 병력 바 보기",
	CancelBuff		= "$spell:74367 을 제거하는 데 사용되는 경우 $spell:10278 및 $spell:642 를 제거합니다.",
	AddsArrive		= "Show timer for adds arrival", --Needs Translating
})

L:SetMiscLocalization({
	SummonMinions	= "저놈들을 재로 만들어버려라!"
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "황혼의 파괴자 할리온"
})

L:SetWarningLocalization({
	TwilightCutterCast	= "주문시전 황혼 절단기 : 5 초"
})

L:SetOptionLocalization({
	TwilightCutterCast		= "$spell:74769 시전 알림 보기",
	AnnounceAlternatePhase	= "다른 위상 우두머리 알림/바 보기",
	SetIconOnConsumption	= "$spell:74562 또는 $spell:74792 대상에게 전술 목표 아이콘 설정"
})

L:SetMiscLocalization({
	Halion					= "할리온",
	MeteorCast				= "하늘이 타오른다!",
	Phase2					= "황혼 세계에서는 고통만이 있으리라! 자신 있다면 들어와 봐라!",
	Phase3					= "나는 빛이자 어둠이다! 필멸자들아, 데스윙의 사자 앞에 무릎 꿇어라!",
	twilightcutter			= "어둠을 경계하라!", --"주위를 회전하는 구슬들이 고동치며 어둠의 기운을 내뿜습니다!", -- Can't use this since on Warmane it triggers twice, 5s prior and on cutter.
	Kill					= "필멸자들아, 승리를 만끽해라. 그것이 마지막일 테니. 주인님이 돌아오시면 이 세상은 불타버리리라!"
})
