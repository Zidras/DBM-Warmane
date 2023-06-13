-- Mini Dragon(projecteurs AT gmail.com) Brilla@金色平原
-- Last update: 2019/08/22

if GetLocale() ~= "zhCN" then return end
local L

-------------------
--  Venoxis  --
-------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization({
	name = "高阶祭司温诺希斯"
})

L:SetOptionLocalization({
	RangeFrame		= "显示范围框"
})

-------------------
--  Jeklik  --
-------------------
L = DBM:GetModLocalization("Jeklik")

L:SetGeneralLocalization({
	name = "高阶祭司耶克里克"
})

-------------------
--  Marli  --
-------------------
L = DBM:GetModLocalization("Marli")

L:SetGeneralLocalization({
	name = "高阶祭司玛尔里"
})

-------------------
--  Thekal  --
-------------------
L = DBM:GetModLocalization("Thekal")

L:SetGeneralLocalization({
	name = "高阶祭司塞卡尔"
})

L:SetWarningLocalization({
	WarnSimulKill	= "大约15秒内复活"
})

L:SetTimerLocalization({
	TimerSimulKill	= "复活术"
})

L:SetOptionLocalization({
	WarnSimulKill	= "通告第一个怪物倒下,马上将复活",
	TimerSimulKill	= "显示牧师复活计时器"
})

L:SetMiscLocalization({
	PriestDied	= "%s死了。",
	YellPhase2	= "西瓦尔拉，让我感受你的愤怒吧！", --TBD
	YellKill	= "哈卡再也不能束缚我了！我终于可以安息了！", --TBD
	Thekal		= "高阶祭司塞卡尔",
	Zath		= "狂热者扎斯",
	LorKhan		= "狂热者洛卡恩"
})

-------------------
--  Arlokk  --
-------------------
L = DBM:GetModLocalization("Arlokk")

L:SetGeneralLocalization({
	name = "高阶祭司娅尔罗"
})

-------------------
--  Hakkar  --
-------------------
L = DBM:GetModLocalization("Hakkar")

L:SetGeneralLocalization({
	name = "哈卡"
})

-------------------
--  Bloodlord  --
-------------------
L = DBM:GetModLocalization("Bloodlord")

L:SetGeneralLocalization({
	name = "血领主曼多基尔"
})

L:SetMiscLocalization({
	Bloodlord	= "血领主曼多基尔",
	Ohgan		= "奥根"
})

-------------------
--  Edge of Madness  --
-------------------
L = DBM:GetModLocalization("EdgeOfMadness")

L:SetGeneralLocalization({
	name = "疯狂之缘"
})

L:SetMiscLocalization({
	Hazzarah = "哈札拉尔",
	Renataki = "雷纳塔基",
	Wushoolay = "乌苏雷",
	Grilek = "格里雷克"
})

-------------------
--  Gahz'ranka  --
-------------------
L = DBM:GetModLocalization("Gahzranka")

L:SetGeneralLocalization({
	name = "加兹兰卡"
})

-------------------
--  Jindo  --
-------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization({
	name = "妖术师金度"
})
