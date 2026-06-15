if GetLocale() ~= "koKR" then return end

local L

-------------------
--  거미 지구    --
-------------------
-------------------
--  아눕레칸     --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "아눕레칸"
})

L:SetOptionLocalization({
	ArachnophobiaTimer	= "거미의 공포 업적 가능 바 보기"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "거미의 공포 업적 가능",
	Pull1				= "그래, 도망쳐! 더 신선한 피가 솟구칠 테니!",
	Pull2				= "어디 맛 좀 볼까..."
})

---------------------
--  귀부인 펠리나  --
---------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "귀부인 펠리나"
})

L:SetWarningLocalization({
	WarningEmbraceExpire	= "귀부인의 은총 종료 5초 전"
})

L:SetOptionLocalization({
	WarningEmbraceExpire	= "귀부인의 은총 종료 이전에 알림 보기"
})

---------------
--  맥스나   --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "맥스나"
})

L:SetWarningLocalization({
	WarningSpidersSoon	= "5초 후 거미의 입맞춤",
	WarningSpidersNow	= "거미의 입맞춤"
})

L:SetTimerLocalization({
	TimerSpider		= "다음 거미의 입맞춤"
})

L:SetOptionLocalization({
	WarningSpidersSoon	= "거미의 입맞춤 이전에 알림 보기",
	WarningSpidersNow	= "거미의 입맞춤 알림 보기",
	TimerSpider			= "다음 거미의 입맞춤 바 보기"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "거미의 공포"
})

---------------
-- 역병 지구 --
---------------
---------------------
--  역병술사 노스  --
---------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "역병술사 노스"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "순간이동",
	WarningTeleportSoon	= "10초 후 순간이동"
})

L:SetTimerLocalization({
	TimerTeleport		= "다음 순간이동",
	TimerTeleportBack	= "방으로 복귀"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "순간이동 알림 보기",
	WarningTeleportSoon		= "순간이동 이전에 알림 보기",
	TimerTeleport			= "다음 순간이동 바 보기",
	TimerTeleportBack		= "방으로 복귀 바 보기"
})

L:SetMiscLocalization({
	Pull				= "죽어라, 침입자들아!",
	Adds				= "해골 전사를 소환합니다!",
	AddsTwo				= "해골을 계속 일으킵니다!"
})

--------------------------
--  부정의 헤이건  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "부정의 헤이건"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "순간이동",
	WarningTeleportSoon	= "%d초 후 순간이동"
})

L:SetTimerLocalization({
	TimerTeleport		= "다음 순간이동"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "순간이동 알림 보기",
	WarningTeleportSoon		= "순간이동 이전에 알림 보기",
	TimerTeleport			= "다음 순간이동 바 보기"
})

L:SetMiscLocalization({
	Pull				= "이제 넌 내 것이다."
})

----------------
--  로데브  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "로데브"
})

L:SetWarningLocalization({
	WarningHealSoon		= "3초 후 치유 가능",
	WarningHealNow		= "치유 가능"
})

L:SetOptionLocalization({
	WarningHealSoon		= "치유 가능 이전에 알림 보기",
	WarningHealNow		= "치유 가능 알림 보기",
	SporeDamageAlert	= "포자에게 데미지를 주는 공격대원에게 귓속말 보내기 및 알리기\n(공대장 및 경보 권한이 있을 경우)",
	CorruptedSorting	= "Set infoframe sorting behaviour for $spell:55593", -- translation missing
	Alphabetical		= "Sort in alphabetical order", -- translation missing
	Duration			= "Sort by duration" -- translation missing
})

-----------------
-- 피조물 지구 --
-----------------
-----------------
--  패치워크  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "패치워크"
})

L:SetOptionLocalization({
	WarningHateful = "증오의 일격 대상자를 공격대 채팅창에 알리기\n(만약 당신이 공대장의 권한이 있거나, 승급을 받은 유저라면 이 기능을 사용할 수 있습니다.)"
})

L:SetMiscLocalization({
	yell1 = "패치워크랑 놀아줘!",
	yell2 = "켈투자드님이 패치워크 싸움꾼으로 만들었다.",
	HatefulStrike = "증오의 일격 --> %s [%s]"
})

-----------------
--  그라불루스  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
	name = "그라불루스"
})

-------------
--  글루스  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name = "글루스"
})

----------------
--  타디우스  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "타디우스"
})

L:SetWarningLocalization({
	WarningChargeChanged	= "전하 변경 : %s",
	WarningChargeNotChanged	= "전하 유지됨"
})

L:SetOptionLocalization({
	WarningChargeChanged	= "전하가 바뀐 경우 알림 보기",
	WarningChargeNotChanged	= "전하가 바뀌지 않을 경우 알림 보기",
	ArrowsEnabled			= "극성변환 후 화살표 보기(일반 \"2 지역\" 공략용)",
	ArrowsRightLeft			= "극성변환 후 오른쪽/왼쪽 화살표 보기(\"4 지역\" 공략용)",
	ArrowsInverse			= "극성변환 후 오른쪽/왼쪽 화살표를 반대로 보기(\"4 지역\" 공략용)"
})

L:SetMiscLocalization({
	Yell	= "스탈라그, 박살낸다!",
	Emote	= "%s|1이;가; 과부하 상태가 됩니다.",
	Emote2	= "테슬라 코일!!",
	Boss1	= "퓨진",
	Boss2	= "스탈라그",
	Charge1	= "마이너스 전하",
	Charge2	= "플러스 전하",
	Arrows	= "화살표"
})

-----------------
-- 군사 지구   --
-----------------
---------------------------
--  훈련교관 라주비어스  --
---------------------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "훈련교관 라주비어스"
})

L:SetWarningLocalization({
	WarningShieldWallSoon	= "뼈 보호막 종료 5초 전"
})

L:SetOptionLocalization({
	WarningShieldWallSoon	= "뼈 보호막 종료 알림 보기"
})

L:SetMiscLocalization({
	Yell1 = "절대 봐주지 마라!",
	Yell2 = "훈련은 끝났다! 배운 걸 보여줘라!",
	Yell3 = "훈련받은 대로 해!",
	Yell4 = "다리를 후려 차라! 무슨 문제 있나?"
})

------------------------
--  영혼 착취자 고딕  --
------------------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "영혼 착취자 고딕"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "지원군 %d: %s 3초전",
	WarningWaveSpawned	= "지원군 %d: %s",
	WarningRiderDown	= "무자비한 죽음의 기병 처치",
	WarningKnightDown	= "무자비한 죽음의 기사 처치",
	WarningPhase2		= "2 단계"
})

L:SetTimerLocalization({
	TimerWave	= "지원군 #%d",
	TimerPhase2	= "2 단계"
})

L:SetOptionLocalization({
	TimerWave			= "다음 지원군 바 보기",
	TimerPhase2			= "2 단계 바 보기",
	WarningWaveSoon		= "지원군 이전에 알림 보기",
	WarningWaveSpawned	= "지원군 알림 보기",
	WarningRiderDown	= "죽음의 기병 처치 알림 보기",
	WarningKnightDown	= "죽음의 기사 처치 알림 보기",
	WarningPhase2		= "2 단계 알림 보기"
})

L:SetMiscLocalization({
	yell			= "어리석은 것들, 스스로 죽음을 자초하다니!",
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s, %d %s",
	WarningWave3	= "%d %s, %d %s, %d %s",
	Trainee			= "|4수련생:수련생;",
	Knight			= "|4죽음의 기사:죽음의 기사;",
	Rider			= "|4죽음의 기병:죽음의 기병;"
})

--------------------
--  4인의 기사단  --
--------------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "4인의 기사단"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "3초 후 징표 #%d",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetOptionLocalization({
	WarningMarkSoon				= "징표 이전에 알림 보기",
	SpecialWarningMarkOnPlayer	= "징표가 4 중첩 이상시 특수 경고 보기"
})

L:SetMiscLocalization({
	Korthazz	= "영주 코스아즈",
	Rivendare	= "남작 리븐데어",
	Blaumeux	= "여군주 블라미우스",
	Zeliek		= "젤리에크 경"
})

-------------------
-- 서리고룡 둥지 --
-------------------
--------------
--  사피론  --
--------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "사피론"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon		= "비행 단계 10초 전",
	WarningAirPhaseNow		= "비행 단계",
	WarningLanded			= "착지",
	WarningDeepBreath		= "냉기 숨결!",
	SpecWarnSapphLow		= "사피론은 날지 못한다!"
})

L:SetTimerLocalization({
	TimerAir				= "비행 단계 종료",
	TimerLanding			= "착지 중",
	TimerIceBlast			= "냉기 숨결"
})

L:SetOptionLocalization({
	WarningAirPhaseSoon		= "비행 단계 이전에 알림 보기",
	WarningAirPhaseNow		= "비행 단계 알림 보기",
	WarningLanded			= "지상 단계 알림 보기",
	TimerAir				= "비행 단계 유지시간 바 보기",
	TimerLanding			= "착지 중 바 보기",
	TimerIceBlast			= "냉기 숨결 시전 바 보기",
	WarningDeepBreath		= "냉기 숨결 특수 경고 보기",
	SpecWarnSapphLow		= "10% 실행 단계에 대한 특별 경고(공기 단계 취소)"
})

L:SetMiscLocalization({
	EmoteBreath				= "숨을 깊게 들이마십니다.",
	AirPhase				= "사피론이 공중으로 떠오릅니다!",
	LandingPhase			= "사피론이 다시 공격합니다!"
})

------------------
--  켈투자드  --
------------------
L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "켈투자드"
})

L:SetWarningLocalization({
	specwarnP2Soon		= "10초 후 2 단계",
	warnAddsSoon		= "곧 얼음왕관의 수호자",
	WeaponsStatus		= "Auto Unequipping enabled: %s (%s - %s)" --Needs Translating
})

L:SetTimerLocalization({
	TimerPhase2			= "2 단계"
})

L:SetOptionLocalization({
	TimerPhase2			= "2 단계 바 보기",
	specwarnP2Soon		= "2 단계 10초 전에 특수 경고 보기",
	warnAddsSoon		= "얼음왕관의 수호자 이전에 알림 보기",
	WeaponsStatus		= "Special warning at combat start if unequip/equip function is enabled", --Needs Translating
	EqUneqWeaponsKT		= "$spell:28410 전후에 자동으로 무기를 장착 해제하고 장착합니다. \"pve\"라는 장비 세트가 필요합니다.",
	EqUneqWeaponsKT2	= "$spell:28410이 당신에게 시전되면 자동으로 무기를 장착 해제하고 장착합니다. \"pve\"라는 장비 세트가 필요합니다.",
	RemoveBuffsOnMC		= "$spell:28410를 시전하면 버프를 제거합니다. 각 옵션은 누적됩니다.",
	Gift				= "$spell:48469 / $spell:48470을 제거합니다. $spell:33786 저항을 방지하기 위한 최소한의 접근입니다.",
	CCFree				= "+ $spell:48169 / $spell:48170을 제거합니다. 그림자 학교의 주문 저항을 설명합니다.",
	ShortOffensiveProcs	= "+ 지속 시간이 짧은 공격 절차를 제거합니다. 공격대 피해 출력을 손상시키지 않으면서 공격대 안전을 위해 권장됩니다.",
	MostOffensiveBuffs	= "+ 대부분의 공격 버프를 제거합니다(주로 캐스터 및 |cFFFF7C0A야성 드루이드|r용). 손상 출력 손실로 최대 레이드 안전 및 자체 버프/변형이 필요합니다!"
})

L:SetMiscLocalization({
	Yell		= "어둠의 문지기와 하수인, 그리고 병사들이여! 나 켈투자드가 부르니 명을 받들라!",
	Yell1Phase2	= "자비를 구하라!", -- 12995
	Yell2Phase2	= "마지막 숨이나 쉬어라!", -- 12996
	Yell3Phase2	= "최후를 맞이하라!", -- 12997
	YellPhase3	= "주인님, 도와주소서!", -- 12998
	YellGuardians	= "좋다. 얼어붙은 땅의 전사들이여, 일어나라! 너희에게 싸울 것을 명하노라. 날 위해 죽고, 날 위해 죽여라! 한 놈도 살려두지 마라!", -- 12994
	setMissing	= "주목! DBM 자동 무기 해제/장착은 pve라는 장비 세트를 생성할 때까지 작동하지 않습니다.",
	EqUneqLineDescription	= "자동 장착/장비 해제"
})
