if GetLocale() ~= "zhCN" then return end

local L

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name = "药剂师三人组"
})

L:SetTimerLocalization({
	HummelActive		= "汉摩尔加入战斗",
	BaxterActive		= "拜克斯特加入战斗",
	FryeActive		= "弗莱加入战斗"
})

L:SetOptionLocalization({
	TrioActiveTimer		= "计时条：药剂师何时加入战斗"
})

L:SetMiscLocalization({
	SayCombatStart		= "他们顾得上告诉你我是谁或者我在做些什么吗？"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	name = "埃霍恩"
})

L:SetWarningLocalization({
--	Submerged		= "埃霍恩已隐没",
	Emerged			= "埃霍恩已现身",
	specWarnAttack	= "埃霍恩拥有易伤 - 现在攻击!"
})

L:SetTimerLocalization({
	SubmergeTimer	= "隐没",
	EmergeTimer		= "现身",
	TimerCombat		= "战斗开始"
})

L:SetOptionLocalization({
--	Submerged		= "当埃霍恩隐没时显示警报",
	Emerged			= "警报：埃霍恩现身",
	specWarnAttack	= "特殊警报：埃霍恩拥有易伤",
	SubmergeTimer	= "计时条：隐没",
	EmergeTimer		= "计时条：现身",
	TimerCombat		= "为战斗开始显示计时条"
})

L:SetMiscLocalization({
	Pull			= "冰石已经溶化了!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "科林·烈酒"
})

L:SetWarningLocalization({
	specWarnBrew		= "在他再丢你一个前喝掉酒！",
	specWarnBrewStun	= "提示：你疯狂了，记得下一次喝啤酒！"
})

L:SetOptionLocalization({
	specWarnBrew		= "特殊警报：$spell:47376",
	specWarnBrewStun	= "特殊警报：$spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "我中了空桶！"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "无头骑士"
})

L:SetWarningLocalization({
	WarnPhase				= "第%d阶段",
	warnHorsemanSoldiers	= "跃动的南瓜出现了",
	warnHorsemanHead		= "打脑袋！",
	specWarnHorsemanHead	= "旋风斩 - 转换目标!"
})

L:SetOptionLocalization({
	WarnPhase				= "警报：阶段转换",
	warnHorsemanSoldiers	= "警报：跃动的南瓜出现",
	warnHorsemanHead		= "特殊警报：无头骑士的脑袋出现",
	specWarnHorsemanHead	= "为旋风斩显示特别警报(第二次及最后的头颅出现)"
})

L:SetMiscLocalization({ -- 2024/10/22: On Warmane SQL, there are no translations of these broadcasts to zhCN, so defaulted to English.
--	HorsemanSummon			= "无头骑士来了……",
--	HorsemanHead			= "过来这里，你这白痴!", -- local SQL has different string - 白痴，到这边来！
--	HorsemanSoldiers		= "士兵们，起来战斗吧！为死去的骑士带来胜利的荣耀！", -- 23861
--	SayCombatEnd			= "我也曾面对过这样的末路。还有什么新的冒险在等着呢?" -- 23455 (local SQL has different string - 我曾经经历过这样的结局。这次会有新意吗？)
})
