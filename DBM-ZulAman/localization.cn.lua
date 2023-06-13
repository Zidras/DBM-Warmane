if GetLocale() ~= "zhCN" then return end
local L

---------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk")

L:SetGeneralLocalization({
	name = "纳洛拉克"
})

L:SetWarningLocalization({
	WarnBear		= "熊形态",
	WarnBearSoon	= "5秒后变为熊形态",
	WarnNormal		= "人形态",
	WarnNormalSoon	= "5秒后变为人形态"
})

L:SetTimerLocalization({
	TimerBear		= "熊形态",
	TimerNormal		= "人形态"
})

L:SetOptionLocalization({
	WarnBear		= "Show warning for Bear form",--Translate
	WarnBearSoon	= "Show pre-warning for Bear form",--Translate
	WarnNormal		= "Show warning for Normal form",--Translate
	WarnNormalSoon	= "Show pre-warning for Normal form",--Translate
	TimerBear		= "Show timer for Bear form",--Translate
	TimerNormal		= "Show timer for Normal form"--Translate
})

L:SetMiscLocalization({
	YellPull	= "上前去，卫兵！杀戮时间开始了！",
	YellBear	= "你们召唤野兽？你马上就要大大的后悔了！",
	YellNormal	= "纳洛拉克，变形，出发！"
})

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon")

L:SetGeneralLocalization({
	name = "埃基尔松"
})

L:SetMiscLocalization({
	YellPull	= "我是猎鹰，而你们，就是猎物！",
})

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai")

L:SetGeneralLocalization({
	name = "加亚莱"
})

L:SetMiscLocalization({
	YellPull	= "风之圣魂将是你的梦魇！",
	YellBomb	= "烧死你们！",
	YellAdds	= "雌鹰哪里去了？快去孵蛋！"
})

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi")

L:SetGeneralLocalization({
	name = "哈尔拉兹"
})

L:SetWarningLocalization({
	WarnSpirit	= "灵魂分裂",
	WarnNormal	= "灵魂消失"
})

L:SetOptionLocalization({
	WarnSpirit	= "Show warning for Spirit phase",--Translate
	WarnNormal	= "Show warning for Normal phase"--Translate
})

L:SetMiscLocalization({
	YellPull	= "在利爪与尖牙面前，下跪吧，祈祷吧，颤栗吧！",
	YellSpirit	= "狂野的灵魂与我同在……",
	YellNormal	= "灵魂，到我这里来！"
})

--------------------------
--  Hex Lord Malacrass --
--------------------------
L = DBM:GetModLocalization("Malacrass")

L:SetGeneralLocalization({
	name = "妖术领主玛拉卡斯"
})

L:SetMiscLocalization({
	YellPull	= "阴影将会降临在你们头上……"
})

--------------
--  Zul'jin --
--------------
L = DBM:GetModLocalization("ZulJin")

L:SetGeneralLocalization({
	name = "祖尔金"
})

L:SetMiscLocalization({
--	YellPull	= "Nobody badduh dan me!",
	YellPhase2	= "你看我有许多新招，变个熊……",
	YellPhase3	= "变成猎鹰，谁也别想逃出我的眼睛！",
	YellPhase4	= "现在来让你看看我的尖牙和利爪！",
	YellPhase5	= "龙鹰，不用抬头就能看见！"
})
