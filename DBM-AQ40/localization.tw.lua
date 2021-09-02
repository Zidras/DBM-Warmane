if GetLocale() ~= "zhTW" then return end
local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization{
	name = "預言者斯克拉姆"
}

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization{
	name = "異種蠍皇族"
}
L:SetMiscLocalization{
	Yauj = "亞爾基公主",
	Vem = "維姆",
	Kri = "克里勳爵"
}

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization{
	name = "沙爾圖拉"
}

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization{
	name = "不屈的范克里斯"
}

--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization{
	name = "維希度斯"
}
L:SetWarningLocalization{
	WarnFreeze	= "冰凍:%d/3",
	WarnShatter	= "打碎:%d/3"
}
L:SetOptionLocalization{
	WarnFreeze	= "提示冰凍狀態",
	WarnShatter	= "提示打碎狀態"
}
L:SetMiscLocalization{
	Slow	= "開始減速!",   --Translation problem, this is an exclamation mark in English, please do not modify it.
	Freezing= "凍住了！",
	Frozen	= "變成冰凍的固體!",  --Translation problem, this is an exclamation mark in English, please do not modify it.
	Phase4 	= "開始爆裂!",  --Translation problem, this is an exclamation mark in English, please do not modify it.
	Phase5 	= "看來準備好毀滅了！",
	Phase6 	= "爆炸。",
	HitsRemain	= "剩餘攻擊",
	Frost		= "冰霜",
	Physical	= "物理"
}
-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization{
	name = "哈霍蘭公主"
}
---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization{
	name = "雙子帝王"
}
L:SetMiscLocalization{
	Veklor = "維克洛爾大帝",
	Veknil = "維克尼拉斯大帝"
}

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization{
	name = "克蘇恩"
}
L:SetWarningLocalization{
	WarnEyeTentacle			= "眼球觸鬚",
	WarnClawTentacle2		= "利爪觸鬚",
	WarnGiantEyeTentacle	= "巨型眼球觸鬚",
	WarnGiantClawTentacle	= "巨型利爪觸鬚",
	WarnWeakened			= "克蘇恩變得虛弱了"
}
L:SetTimerLocalization{
	TimerEyeTentacle		= "下一次眼球觸鬚",
	TimerClawTentacle		= "下一次利爪觸鬚",
	TimerGiantEyeTentacle	= "下一次巨型眼球觸鬚",
	TimerGiantClawTentacle	= "下一次巨型利爪觸鬚",
	TimerWeakened			= "虛弱結束"
}
L:SetOptionLocalization{
	WarnEyeTentacle			= "為眼球觸鬚顯示警告",
	WarnClawTentacle2		= "為利爪觸鬚顯示警告",
	WarnGiantEyeTentacle	= "為巨型眼球觸鬚顯示警告",
	WarnGiantClawTentacle	= "為巨型利爪觸鬚顯示警告",
	SpecWarnWeakened		= "當首領虛弱時顯示特別警告",
	TimerEyeTentacle		= "為下一次眼球觸鬚顯示計時器",
	TimerClawTentacle		= "為下一次利爪觸鬚顯示計時器",
	TimerGiantEyeTentacle	= "為下一次巨型眼球觸鬚顯示計時器",
	TimerGiantClawTentacle	= "為下一次巨型利爪觸鬚顯示計時器",
	TimerWeakened			= "為首領虛弱時間顯示計時器",
	RangeFrame				= "顯示距離框架(10碼)"
}
L:SetMiscLocalization{
	Stomach		= "內場",
	Eye			= "克蘇恩之眼",
	FleshTent	= "血肉觸鬚",--Localized so it shows on frame in users language, not senders
	Weakened 	= "變弱了",
	NotValid	= "AQ40 擊殺信息： %s 首領未擊殺。"
}
----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization{
	name = "奧羅"
}
L:SetWarningLocalization{
	WarnSubmerge		= "鑽地",
	WarnEmerge			= "現身"
}
L:SetTimerLocalization{
	TimerSubmerge		= "強制鑽地",
	TimerEmerge			= "現身"
}
L:SetOptionLocalization{
	WarnSubmerge		= "為鑽地顯示警告",
	TimerSubmerge		= "為鑽地顯示計時器，確定何時將強制執行合併。 注意：如果近戰離開目標範圍，他仍然可以隨時鑽地。",
	WarnEmerge			= "為現身顯示警告",
	TimerEmerge			= "為現身顯示計時器"
}
---------------
-- AQ40 Trash --
----------------
L = DBM:GetModLocalization("AQ40Trash")

L:SetGeneralLocalization{
	name = "AQ40：全程計時"
}
