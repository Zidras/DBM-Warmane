if GetLocale() ~= "koKR" then return end
local L

---------------
-- Kurinnaxx --
---------------
L = DBM:GetModLocalization("Kurinnaxx")

L:SetGeneralLocalization{
	name 		= "쿠린낙스"
}
------------
-- Rajaxx --
------------
L = DBM:GetModLocalization("Rajaxx")

L:SetGeneralLocalization{
	name 		= "장군 라작스"
}
L:SetWarningLocalization{
	WarnWave	= "공격 #%s"
}
L:SetOptionLocalization{
	WarnWave	= "다음 공격 알림"
}
L:SetMiscLocalization{
	Wave12		= "그들이 오고 있다. 자신의 몸을 지키도록 하라!",
	Wave12Alt	= "Remember, Rajaxx, when I said I'd kill you last?",
	Wave3		= "응보의 날이 다가왔다! 암흑이 적들의 마음을 지배하리라!",
	Wave4		= "더는 돌벽과 성문 뒤에서 기다릴 수 없다! 복수의 기회를 놓칠 수 없다. 우리가 분노를 터뜨리는 날 용족은 두려움에 떨리라.",
	Wave5		= "적에게 공포와 죽음의 향연을!",
	Wave6		= "스태그헬름은 흐느끼며 목숨을 구걸하리라. 그 아들놈이 그랬던 것처럼! 천 년의 한을 풀리라! 오늘에서야!",
	Wave7		= "판드랄! 때가 왔다! 에메랄드의 꿈속에 숨어서 기도나 올려라!",
	Wave8		= "건방진... 내 친히 너희를 처치해주마!"
}

----------
-- Moam --
----------
L = DBM:GetModLocalization("Moam")

L:SetGeneralLocalization{
	name 		= "모암"
}

----------
-- Buru --
----------
L = DBM:GetModLocalization("Buru")

L:SetGeneralLocalization{
	name 		= "먹보 부루"
}
L:SetWarningLocalization{
	WarnPursue		= "추적 : >%s<",
	SpecWarnPursue	= "당신을 추적!",
	WarnDismember	= "%s : >%s< (%s)"
}
L:SetOptionLocalization{
	WarnPursue		= "추적 대상 알림 보기",
	SpecWarnPursue	= "추적 대상이 된 경우 특수 알림 보기"
}
L:SetMiscLocalization{
	PursueEmote 	= "노려봅니다!"
}

-------------
-- Ayamiss --
-------------
L = DBM:GetModLocalization("Ayamiss")

L:SetGeneralLocalization{
	name 		= "사냥꾼 아야미스"
}

--------------
-- Ossirian --
--------------
L = DBM:GetModLocalization("Ossirian")

L:SetGeneralLocalization{
	name 		= "무적의 오시리안"
}
L:SetWarningLocalization{
	WarnVulnerable	= "%s"
}
L:SetTimerLocalization{
	TimerVulnerable	= "%s"
}
L:SetOptionLocalization{
	WarnVulnerable	= "약화 알림 보기",
	TimerVulnerable	= "약화 바 보기"
}

----------------
-- AQ20 Trash --
----------------
L = DBM:GetModLocalization("AQ20Trash")

L:SetGeneralLocalization{
	name = "안퀴20 일반몹"
}
