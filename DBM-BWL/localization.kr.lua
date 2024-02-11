if GetLocale() ~= "koKR" then return end
local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization({
	name = "폭군 서슬송곳니"
})

L:SetTimerLocalization({
	TimerAddsSpawn	= "추가 병력 등장"
})

L:SetOptionLocalization({
	TimerAddsSpawn	= "첫번째 추가 병력 등장 바 보기"
})

L:SetMiscLocalization({
	Phase2Emote	= "수정 구슬에서 통제력이 빠져나가자 %s|1이;가; 도망칩니다.",
	YellPull	= "침입자들이 들어왔다! 어떤 희생이 있더라도 알을 반드시 수호하라!"
})

-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization({
	name = "타락한 밸라스트라즈"
})

L:SetMiscLocalization({
	Event	= "너무 늦었어! 네파리우스의 타락이 뿌리를 내려... 난... 나 자신을 통제할 수가 없어."
})

-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization({
	name = "용기대장 래쉬레이어"
})

L:SetMiscLocalization({
	Pull	= "너희 같은 놈들이 올 곳은 아닌데... 죽음을 자초했구나!"
})

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization({
	name = "화염아귀"
})

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization({
	name = "에본로크"
})

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization({
	name = "플레임고르"
})

-----------------------
--  Vulnerabilities  --
-----------------------
-- Chromaggus, Death Talon Overseer and Death Talon Wyrmguard
L = DBM:GetModLocalization("TalonGuards")

L:SetGeneralLocalization({
	name = "죽음의발톱 수호병"
})

L:SetWarningLocalization({
	WarnVulnerable		= "%s 약화"
})

L:SetOptionLocalization({
	WarnVulnerable		= "주문 속성 약화 경고 보기"
})

L:SetMiscLocalization({
	Fire		= "화염",
	Nature		= "자연",
	Frost		= "냉기",
	Shadow		= "암흑",
	Arcane		= "비전",
	Holy		= "신성"
})

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization({
	name = "크로마구스"
})

L:SetWarningLocalization({
	WarnVulnerable	= "%s 약화"
})

L:SetTimerLocalization({
	TimerBreathCD	= "%s 쿨타임",
	TimerBreath		= "%s 시전",
	TimerVulnCD		= "약화 쿨타임"
})

L:SetOptionLocalization({
	WarnBreath		= "크로마구스가 숨결 시전 시 경고 보기",
	WarnVulnerable	= "주문 속성 약화 경고 보기",
	TimerBreathCD	= "숨결 쿨타임 보기",
	TimerBreath		= "숨결 시전 보기",
	TimerVulnCD		= "약화 쿨타임 보기"
})

L:SetMiscLocalization({
	Breath1	= "1번 숨결",
	Breath2	= "2번 숨결",
	VulnEmote	= "%s|1이;가; 가죽을 빛내며 주춤 물러섭니다.",
	Vuln		= "약화 속성",
	Fire		= "화염",
	Nature		= "자연",
	Frost		= "냉기",
	Shadow		= "암흑",
	Arcane		= "비전",
	Holy		= "신성"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization({
	name = "네파리안"
})

L:SetWarningLocalization({
	WarnAddsLeft		= "%d킬 남음",
	WarnClassCall		= "%s 지목",
	specwarnClassCall	= "당신이 직업 지목 대상입니다!"
})

L:SetTimerLocalization({
	TimerClassCall		= "%s 지목 종료"
})

L:SetOptionLocalization({
	TimerClassCall		= "직업 지목 지속 시간 타이머 바 보기",
	WarnAddsLeft		= "2페이즈 전환까지 남은 쫄 킬 수 알림",
	WarnClassCall		= "직업 지목 알림 보기",
	specwarnClassCall	= "직업 지목 대상일 때 특수 알림 보기"
})

L:SetMiscLocalization({
	YellP1			= "경기를 시작하게!",
	YellP2			= "잘했다! 적들의 사기가 떨어지고 있다! 검은바위 첨탑의 군주에게 도전한 대가를 치르게 해주자!",
	YellP3			= "말도 안 돼! 일어나라! 다시 한 번 너희 주인을 섬겨라!",
	YellShaman		= "주술사, 네 놈의 토템이 얼마나 쓸모 있는지 한번 보자!",
	YellPaladin		= "성기사여... 네 목숨은 여러 개라고 하던데 어디 한번 보여 다오.",
	YellDruid		= "드루이드 녀석, 그 바보 같은 변신을 했다고 내가 모를 줄 알았더냐? 받아라!",
	YellPriest		= "사제야, 그렇게 치유를 계속할 테냐?! 그럼 어디 좀 더 재미있게 만들어 줄까!",
	YellWarrior		= "전사들이로군, 네가 그보다 더 강하게 내려 칠 수 있다는 걸 알고 있다! 어디 한번 제대로 쳐 보란 말이다!",
	YellRogue		= "도적들인가? 숨어 다니지만 말고 나와서 나와 맞서라!",
	YellWarlock		= "흑마법사여, 네가 이해하지도 못하는 마법을 가지고 장난을 쳐서야 쓰나... 바로 이런 꼴이 되어 버렸지 않는가!",
	YellHunter		= "사냥꾼 놈에다 그 장난감 같은 총이라니, 정말 거슬리는구나!",
	YellMage		= "네가 마법사냐? 마법을 가지고 장난칠 상대를 고를 때는 좀 더 신중했어야지...",
	YellDK			= "죽음의 기사여... 당장 이리 와라!"
})
