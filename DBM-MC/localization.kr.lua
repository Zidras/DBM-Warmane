if GetLocale() ~= "koKR" then return end
local L

----------------
--  Lucifron  --
----------------
L = DBM:GetModLocalization("Lucifron")

L:SetGeneralLocalization{
	name = "루시프론"
}

----------------
--  Magmadar  --
----------------
L = DBM:GetModLocalization("Magmadar")

L:SetGeneralLocalization{
	name = "마그마다르"
}

----------------
--  Gehennas  --
----------------
L = DBM:GetModLocalization("Gehennas")

L:SetGeneralLocalization{
	name = "게헨나스"
}

------------
--  Garr  --
------------
L = DBM:GetModLocalization("Garr-Classic")

L:SetGeneralLocalization{
	name = "가르"
}

--------------
--  Geddon  --
--------------
L = DBM:GetModLocalization("Geddon")

L:SetGeneralLocalization{
	name = "남작 게돈"
}

----------------
--  Shazzrah  --
----------------
L = DBM:GetModLocalization("Shazzrah")

L:SetGeneralLocalization{
	name = "샤즈라"
}

----------------
--  Sulfuron  --
----------------
L = DBM:GetModLocalization("Sulfuron")

L:SetGeneralLocalization{
	name = "설퍼론 사자"
}

----------------
--  Golemagg  --
----------------
L = DBM:GetModLocalization("Golemagg")

L:SetGeneralLocalization{
	name = "초열의 골레마그"
}

-----------------
--  Majordomo  --
-----------------
L = DBM:GetModLocalization("Majordomo")

L:SetGeneralLocalization{
	name = "청지기 이그젝큐투스"
}
L:SetTimerLocalization{
	timerShieldCD		= "다음 보호막"
}
L:SetOptionLocalization{
	timerShieldCD		= "다음 피해/반사 보호막 타이머 바 보기"
}

----------------
--  Ragnaros  --
----------------
L = DBM:GetModLocalization("Ragnaros-Classic")

L:SetGeneralLocalization{
	name = "라그나로스"
}
L:SetWarningLocalization{
	WarnSubmerge		= "잠수",
	WarnEmerge			= "등장"
}
L:SetTimerLocalization{
	TimerSubmerge		= "잠수",
	TimerEmerge			= "등장"
}
L:SetOptionLocalization{
	WarnSubmerge		= "잠수 경고 보기",
	TimerSubmerge		= "잠수 타이머 바 보기",
	WarnEmerge			= "등장 경고 보기",
	TimerEmerge			= "등장 타이머 바 보기"
}
L:SetMiscLocalization{
	Submerge	= "나의 종들아! 어서 나와 주인을 돕거라!",
	Pull		= "건방진 젖먹이! 죽고 싶어 안달이구나! 자, 보아라. 주인님께서 일어나신다!"
}

-----------------
--  MC: Trash  --
-----------------
L = DBM:GetModLocalization("MCTrash")

L:SetGeneralLocalization{
	name = "화심: 일반몹"
}
