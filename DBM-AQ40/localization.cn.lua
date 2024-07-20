-- Mini Dragon(projecteurs AT gmail.com) Brilla@金色平原
-- 枫聖@光芒 & Aoikaze@无畏
-- Last update: 2020/09/01

if GetLocale() ~= "zhCN" then return end
local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization({
	name = "预言者斯克拉姆"
})

L:SetMiscLocalization({
	YellKillSkeram = "你是在逃避必然的命运！"
})

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization({
	name = "安其拉三宝"
})

L:SetMiscLocalization({
	Yauj = "亚尔基公主",
	Vem = "维姆",
	Kri = "克里勋爵"
})

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization({
	name = "沙尔图拉"
})

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization({
	name = "顽强的范克瑞斯"
})

--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization({
	name = "维希度斯"
})

L:SetWarningLocalization({
	WarnFreeze	= "冰冻进度:%d/3",
	WarnShatter	= "打碎进度:%d/3"
})

L:SetOptionLocalization({
	WarnFreeze	= "提示冰冻状态",
	WarnShatter	= "提示打碎状态"
})

L:SetMiscLocalization({
	Slow	 = "的速度慢下来了！",
	Freezing = "冻结了！",
	Frozen	 = "变成了坚硬的固体！",
	Phase4	 = "开始出现裂缝！",
	Phase5	 = "看起来就要碎裂了！",
	--Phase6   = "爆炸." --Checking the battle video, I didn't find this sentence. this emotion not exists in CN client. --by Aoikaze
	HitsRemain	= "剩余攻击",
	Frost		= "冰霜",
	Physical	= "物理"
})

-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization({
	name = "哈霍兰公主"
})

---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization({
	name = "双子皇帝"
})

L:SetMiscLocalization({
	Veklor = "维克洛尔大帝",
	Veknil = "维克尼拉斯大帝"
})

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization({
	name = "克苏恩"
})

L:SetWarningLocalization({
	WarnEyeTentacle			= "眼球触须",
	WarnClawTentacle2		= "利爪触须",
	WarnGiantEyeTentacle	= "巨眼触须",
	WarnGiantClawTentacle	= "巨钩触须",
	SpecWarnWeakened		= "克苏恩的力量被削弱了！"
})

L:SetTimerLocalization({
	TimerEyeTentacle		= "下一次眼球触须",
	TimerClawTentacle		= "下一次利爪触须",
	TimerGiantEyeTentacle	= "下一次巨眼触须",
	TimerGiantClawTentacle	= "下一次巨钩触须",
	TimerWeakened			= "虚弱结束"
})

L:SetOptionLocalization({
	WarnEyeTentacle			= "为眼球触须显示警报",
	WarnClawTentacle2		= "为利爪触须显示警报",
	WarnGiantEyeTentacle	= "为巨眼触须显示警报",
	WarnGiantClawTentacle	= "为巨钩触须显示警报",
	WarnWeakened			= "当克苏恩虚弱時显示警报",
	SpecWarnWeakened		= "当克苏恩虚弱時显示特別警报",
	TimerEyeTentacle		= "为下一次眼球触须显示计时器",
	TimerClawTentacle		= "为下一次利爪触须显示计时器",
	TimerGiantEyeTentacle	= "为下一次巨眼触须显示计时器",
	TimerGiantClawTentacle	= "为下一次巨钩触须显示计时器",
	TimerWeakened			= "为克苏恩虚弱時间显示计时器",
	RangeFrame				= "显示距离框架(10码)"
})

L:SetMiscLocalization({
	Stomach		= "内场",
	Eye			= "克苏恩之眼",
	FleshTent	= "血肉触须",--Localized so it shows on frame in users language, not senders
	Weakened	= "削弱了",
	NotValid	= "AQ40 击杀信息： %s 可选Boss未击杀。"
})

----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization({
	name = "奥罗"
})

L:SetWarningLocalization({
	WarnSubmerge		= "钻地",
	WarnEmerge			= "现身"
})

L:SetTimerLocalization({
	TimerSubmerge		= "强制钻地",
	TimerEmerge			= "现身"
})

L:SetOptionLocalization({
	WarnSubmerge		= "为钻地显示警报",
	TimerSubmerge		= "为钻地显示计时器，提示何时强制钻地。注意：如果近战都离开了奥罗近战范围，它随时可能钻地。",
	WarnEmerge			= "为现身显示警报",
	TimerEmerge			= "为现身显示计时器"
})

----------------
-- AQ40 Trash --
----------------
L = DBM:GetModLocalization("AQ40Trash")

L:SetGeneralLocalization({
	name = "AQ40：全程计时"
})
