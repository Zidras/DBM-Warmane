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

L:SetWarningLocalization({
	SpecialLocust		= "메뚜기 떼!",
	WarningLocustFaded	= "메뚜기 떼 종료"
})

L:SetOptionLocalization({
	SpecialLocust		= "메뚜기 떼 특수 경고 보기",
	WarningLocustFaded	= "메뚜기 떼 종료 알림 보기",
	ArachnophobiaTimer	= "거미의 공포 업적 가능 바 보기"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "거미의 공포 업적 가능",
	Pull1				= "Yes, run! It makes the blood pump faster!",--확인필요
	Pull2				= "Just a little taste..."--확인필요
})

---------------------
--  귀부인 펠리나  --
---------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "귀부인 펠리나"
})

L:SetWarningLocalization({
	WarningEmbraceExpire	= "귀부인의 은총 종료 5초 전",
	WarningEmbraceExpired	= "귀부인의 은총 종료"
})

L:SetOptionLocalization({
	WarningEmbraceExpire	= "귀부인의 은총 종료 이전에 알림 보기",
	WarningEmbraceExpired	= "귀부인의 은총 종료 알림 보기"
})

L:SetMiscLocalization({
	Pull					= "Kneel before me, worm!"--Not actually pull trigger, but often said on pull
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
	WarningTeleportSoon	= "20초 후 순간이동"
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
	Pull				= "Die, trespasser!"--확인필요
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
	Pull				= "You are mine now."--확인필요
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
	WarningHealNow		= "치유 가능 알림 보기"
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

L:SetMiscLocalization({
	yell1 = "패치워크랑 놀아줘!",
	yell2 = "켈투자드님이 패치워크 싸움꾼으로 만들었다."
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
	Emote	= "%s 광폭화!",
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
	Yell1 = "Show them no mercy!",--확인필요
	Yell2 = "The time for practice is over! Show me what you have learned!",--확인필요
	Yell3 = "Do as I taught you!",--확인필요
	Yell4 = "Sweep the leg... Do you have a problem with that?"--확인필요
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
	WarningMarkNow				= "징표 #%d",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetOptionLocalization({
	WarningMarkSoon				= "징표 이전에 알림 보기",
	WarningMarkNow				= "징표 알림 보기",
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
	WarningDeepBreath		= "냉기 숨결!"
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
	WarningIceblock			= "얼음 방패 대상이 된 경우 대화로 알리기"
})

L:SetMiscLocalization({
	EmoteBreath				= "숨을 깊게 들이마십니다.",
	WarningYellIceblock		= "저 얼음 방패! 제 뒤에 숨으세요!!"
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
	warnAddsSoon		= "곧 얼음왕관의 수호자"
})

L:SetTimerLocalization({
	TimerPhase2			= "2 단계"
})

L:SetOptionLocalization({
	TimerPhase2			= "2 단계 바 보기",
	specwarnP2Soon		= "2 단계 10초 전에 특수 경고 보기",
	warnAddsSoon		= "얼음왕관의 수호자 이전에 알림 보기"
})

L:SetMiscLocalization({
	Yell 				= "어둠의 문지기와 하수인, 그리고 병사들이여! 나 켈투자드가 부르니 명을 받들라!"
})
