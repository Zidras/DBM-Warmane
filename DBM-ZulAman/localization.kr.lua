if GetLocale() ~= "koKR" then return end
local L

---------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk")

L:SetGeneralLocalization{
	name = "날로라크"
}

L:SetWarningLocalization{
	WarnBear		= "곰 형상",
	WarnBearSoon	= "5초 후 곰 형상",
	WarnNormal		= "일반 형상",
	WarnNormalSoon	= "5초 후 일반 형상"
}

L:SetTimerLocalization{
	TimerBear		= "곰 형상",
	TimerNormal		= "일반 형상"
}

L:SetOptionLocalization{
	WarnBear		= "곰 형상 경고 보기",
	WarnBearSoon	= "곰 형상 사전 경고 보기",
	WarnNormal		= "일반 형상 경고 보기",
	WarnNormalSoon	= "일반 형상 사전 경고 보기",
	TimerBear		= "곰 형상 타이머 바 보기",
	TimerNormal		= "일반 형상 타이머 바 보기"
}

L:SetMiscLocalization{
	YellBear 	= "너희들이 짐승을 불러냈다. 놀랄 준비나 해라!",
	YellNormal	= "날로라크 나가신다!"
}

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon")

L:SetGeneralLocalization{
	name = "아킬존"
}

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai")

L:SetGeneralLocalization{
	name = "잔알라이"
}

L:SetMiscLocalization{
	YellBomb	= "태워버리겠다!",
	YellAdds	= "다 어디 갔지? 당장 알을 부화시켜!"
}

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi")

L:SetGeneralLocalization{
	name = "할라지"
}

L:SetWarningLocalization{
	WarnSpirit	= "영혼 단계",
	WarnNormal	= "일반 단계"
}

L:SetOptionLocalization{
	WarnSpirit	= "영혼 단계 경고 보기",
	WarnNormal	= "일반 단계 경고 보기"
}

L:SetMiscLocalization{
	YellSpirit	= "야생의 혼이 내 편이다...",
	YellNormal	= "혼이여, 이리 돌아오라!"
}

--------------------------
--  Hex Lord Malacrass --
--------------------------
L = DBM:GetModLocalization("Malacrass")

L:SetGeneralLocalization{
	name = "주술군주 말라크라스"
}

L:SetMiscLocalization{
	YellPull	= "너희에게 그림자가 드리우리라..."
}

--------------
--  Zul'jin --
--------------
L = DBM:GetModLocalization("ZulJin")

L:SetGeneralLocalization{
	name = "줄진"
}

L:SetMiscLocalization{
	YellPhase2	= "새로운 기술을 익혔지... 내 형제, 곰처럼...",
	YellPhase3	= "독수리의 눈을 피할 수는 없다!",
	YellPhase4	= "내 새로운 형제, 송곳니와 발톱을 보아라!",
	YellPhase5	= "용매를 하늘에서만 찾을 필요는 없다!"
}
