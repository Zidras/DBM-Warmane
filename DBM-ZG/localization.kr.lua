if GetLocale() ~= "koKR" then return end
local L

-------------------
--  Venoxis  --
-------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization({
	name = "대사제 베녹시스"
})

-------------------
--  Jeklik  --
-------------------
L = DBM:GetModLocalization("Jeklik")

L:SetGeneralLocalization({
	name = "대여사제 제클릭"
})

-------------------
--  Marli  --
-------------------
L = DBM:GetModLocalization("Marli")

L:SetGeneralLocalization({
	name = "대여사제 말리"
})

-------------------
--  Thekal  --
-------------------
L = DBM:GetModLocalization("Thekal")

L:SetGeneralLocalization({
	name = "대사제 데칼"
})

L:SetWarningLocalization({
	WarnSimulKill	= "첫 쫄 잡음 - 약 15초 후 부활"
})

L:SetTimerLocalization({
	TimerSimulKill	= "부활"
})

L:SetOptionLocalization({
	WarnSimulKill	= "첫 쫄이 잡히면 잠시 후 부활 알림",
	TimerSimulKill	= "사제 부활 타이머 바 보기"
})

L:SetMiscLocalization({
	PriestDied	= "%s 죽었습니다.",
	YellPhase2	= "시르밸라시여, 분노를 채워 주소서!",
	YellKill	= "학카르의 구속이 끝났다! 이젠 평안히 잠들리라!",
	Thekal		= "대사제 데칼",
	Zath		= "광신도 자스",
	LorKhan		= "광신도 로르칸"
})

-------------------
--  Arlokk  --
-------------------
L = DBM:GetModLocalization("Arlokk")

L:SetGeneralLocalization({
	name = "대여사제 알로크"
})

-------------------
--  Hakkar  --
-------------------
L = DBM:GetModLocalization("Hakkar")

L:SetGeneralLocalization({
	name = "영혼약탈자 학카르"
})

-------------------
--  Bloodlord  --
-------------------
L = DBM:GetModLocalization("Bloodlord")

L:SetGeneralLocalization({
	name = "혈군주 만도키르"
})

L:SetMiscLocalization({
	Bloodlord	= "혈군주 만도키르",
	Ohgan		= "오간"
})

-------------------
--  Edge of Madness  --
-------------------
L = DBM:GetModLocalization("EdgeOfMadness")

L:SetGeneralLocalization({
	name = "광란의 경계"
})

L:SetMiscLocalization({
	Hazzarah = "하자라",
	Renataki = "레나타키",
	Wushoolay = "우슐레이",
	Grilek = "그리렉"
})

-------------------
--  Gahz'ranka  --
-------------------
L = DBM:GetModLocalization("Gahzranka")

L:SetGeneralLocalization({
	name = "가즈란카"
})

-------------------
--  Jindo  --
-------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization({
	name = "주술사 진도"
})
