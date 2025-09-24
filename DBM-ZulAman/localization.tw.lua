if GetLocale() ~= "zhTW" then return end
local L

---------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk")

L:SetGeneralLocalization({
	name = "納羅拉克"
})

L:SetWarningLocalization({
	WarnBear		= "熊階段",
	WarnBearSoon	= "5秒後 熊階段",
	WarnNormal		= "普通階段",
	WarnNormalSoon	= "5秒後 普通階段"
})

L:SetTimerLocalization({
	TimerBear		= "熊階段",
	TimerNormal		= "普通階段"
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
	YellPull	= "上前去，衛兵!殺戮時間開始了!",
	YellBear	= "你們既然將野獸召喚出來，就將付出更多的代價!",
	YellNormal	= "沒有人可以擋在納羅拉克的面前!"
})

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon")

L:SetGeneralLocalization({
	name = "阿奇爾森"
})

L:SetMiscLocalization({
	YellPull	= "我是掠食者!而你們，就是獵物!",
})

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai")

L:SetGeneralLocalization({
	name = "賈納雷"
})

L:SetMiscLocalization({
	YellPull	= "風之聖魂將是你的夢魘!",
	YellBomb	= "燒死你們!",
	YellAdds	= "雌鷹哪裡去啦?快去孵蛋!"
})

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi")

L:SetGeneralLocalization({
	name = "Халаззи"
})

L:SetWarningLocalization({
	WarnSpirit	= "靈魂出現了",
	WarnNormal	= "靈魂消失了"
})

L:SetOptionLocalization({
	WarnSpirit	= "Show warning for Spirit phase",--Translate
	WarnNormal	= "Show warning for Normal phase"--Translate
})

L:SetMiscLocalization({
	YellPull	= "在利爪與尖牙面前下跪吧，祈禱吧，顫慄吧!",
	YellSpirit	= "狂野的靈魂與我同在......",
	YellNormal	= "靈魂，回到我這裡來!"
})

--------------------------
--  Hex Lord Malacrass --
--------------------------
L = DBM:GetModLocalization("Malacrass")

L:SetGeneralLocalization({
	name = "妖術領主瑪拉克雷斯"
})

L:SetMiscLocalization({
	YellPull	= "Da shadow gonna fall on you...."--Translate
})

--------------
--  Zul'jin --
--------------
L = DBM:GetModLocalization("ZulJin")

L:SetGeneralLocalization({
	name = "祖爾金"
})

L:SetMiscLocalization({
--	YellPull	= "Nobody badduh dan me!",
	YellPhase2	= "賜給我一些新的力量……讓我像熊一樣……",
	YellPhase3	= "在雄鷹之下無所遁形!",
	YellPhase4	= "讓我來介紹我的新兄弟:尖牙和利爪!",
	YellPhase5	= "你不需要仰望天空才看得到龍鷹!"
})
