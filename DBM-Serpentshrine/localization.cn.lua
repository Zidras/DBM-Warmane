if GetLocale() ~= "zhCN" then return end
local L

---------------------------
--  Hydross the Unstable --
---------------------------
L = DBM:GetModLocalization("Hydross")

L:SetGeneralLocalization({
	name = "不稳定的海度斯"
})

L:SetWarningLocalization({
	WarnMark		= "%s : %s",
	WarnPhase		= "%s 阶段",--Translate
	SpecWarnMark	= "%s : %s"
})

L:SetTimerLocalization({
	TimerMark	= "下一次 %s : %s"--Translate
})

L:SetOptionLocalization({
	WarnMark		= "警报印记",
	WarnPhase		= "警报阶段变化",
	SpecWarnMark	= "显示：当印记到100%时警报",--Translate
	TimerMark		= "显示下一次印记时间"--Translate
})

L:SetMiscLocalization({
	Frost		= "冰霜阶段",
	Nature		= "自然阶段",
	YellPull	= "我不能允许你们介入！"
})

-----------------------
--  The Lurker Below --
-----------------------
L = DBM:GetModLocalization("LurkerBelow")

L:SetGeneralLocalization({
	name = "鱼斯拉"
})

L:SetWarningLocalization({
	WarnSubmerge		= "下潜",
	WarnSubmergeSoon	= "下潜 10 秒",--Translate
	WarnEmerge			= "重新出现",
	WarnEmergeSoon		= "重新出现 10 秒"--Translate
})

L:SetTimerLocalization({
	TimerSubmerge		= "下潜",
	TimerEmerge			= "重新出现"
})

L:SetOptionLocalization({
	WarnSubmerge		= "显示下潜警报",--Translate
	WarnSubmergeSoon	= "显示下潜预警",--Translate
	WarnEmerge			= "显示重新出现警报",--Translate
	WarnEmergeSoon		= "显示重新出现预警",--Translate
	TimerSubmerge		= "显示下潜时间",--Translate
	TimerEmerge			= "显示重新出现时间"--Translate
})

L:SetMiscLocalization({
	Spout	= "%s深深吸了一口气！"
})

--------------------------
--  Leotheras the Blind --
--------------------------
L = DBM:GetModLocalization("Leotheras")

L:SetGeneralLocalization({
	name = "盲眼者莱欧瑟拉斯"
})

L:SetWarningLocalization({
	WarnPhase		= "%s 阶段",--Translate
	WarnPhaseSoon	= "%s 阶段转换 5 秒"--Translate
})

L:SetTimerLocalization({
	TimerPhase	= "下一次 %s 阶段"--Translate
})

L:SetOptionLocalization({
	WarnPhase		= "显示下一阶段的警报",--Translate
	WarnPhaseSoon	= "显示下一阶段预警",--Translate
	TimerPhase		= "显示下一阶段时间"--Translate
})

L:SetMiscLocalization({
	Human		= "人形态",--Translate
	Demon		= "恶魔形态",--Translate
	YellDemon	= "滚开吧，脆弱的精灵。现在我说了算！",
	YellPhase2	= "不……不！你在干什么？我才是主宰！你听到没有？我……啊啊啊啊！控制……不住了。",
	YellPull	= "我的放逐终于结束了！"
})

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
L = DBM:GetModLocalization("Fathomlord")

L:SetGeneralLocalization({
	name = "深水领主卡拉瑟雷斯"
})

L:SetMiscLocalization({
	Caribdis	= "深水卫士卡莉蒂丝",--Translate
	Tidalvess	= "深水卫士泰达维斯 ",--Translate
	Sharkkis	= "深水卫士沙克基斯",--Translate
	YellPull	= "卫兵！提高警惕！我们有客人来了……"
})

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetGeneralLocalization({
	name = "莫洛格里·踏潮者"
})

L:SetWarningLocalization({
	WarnMurlocs		= "鱼人群出现",
	SpecWarnMurlocs	= "鱼人群出现!"
})

L:SetTimerLocalization({
	TimerMurlocs	= "鱼人群"
})

L:SetOptionLocalization({
	WarnMurlocs		= "警报鱼人群",
	SpecWarnMurlocs	= "鱼人群出现时显示特殊警报",--Translate
	TimerMurlocs	= "显示鱼人群出现计时"--Translate
})

L:SetMiscLocalization({
	Grave			= "%s把他的敌人送入了水下的坟墓！",
	Murlocs			= "猛烈的地震警告了附近的鱼人们！"
})

-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetGeneralLocalization({
	name = "瓦丝琪"
})

L:SetWarningLocalization({
	WarnElemental		= "被污染的元素 - 5秒后出现 (%s)",
	WarnStrider			= "盘牙巡逻者 - 5秒后出现 (%s)",
	WarnNaga			= "盘牙精英 - 5秒后出现 (%s)",
	WarnShield			= "护盾 - %d/4被击碎",
	WarnLoot			= ">%s<获得了污染之核",
	SpecWarnElemental	= "被污染的元素 - 5秒后出现!"
})

L:SetTimerLocalization({
	TimerElemental		= "被污染的元素 (%d)",--Verify
	TimerStrider		= "盘牙巡逻者 (%d)",--Verify
	TimerNaga			= "盘牙精英 (%d)"--Verify
})

L:SetOptionLocalization({
	WarnElemental		= "显示被污染的元素出现的预警",--Translate
	WarnStrider			= "显示盘牙巡逻者出现的预警",--Translate
	WarnNaga			= "显示盘牙精英出现的预警",--Translate
	WarnShield			= "显示第2阶段护盾警报 ",--Translate
	WarnLoot			= "警报是谁拾取了污染之核",
	TimerElemental		= "显示下一个被污染的元素出现的时间",--Translate
	TimerStrider		= "显示下一个盘牙巡逻者出现的时间",--Translate
	TimerNaga			= "显示盘牙精英出现的时间",--Translate
	SpecWarnElemental	= "显示特别警报：当被污染的元素到来时",--Translate
	AutoChangeLootToFFA	= "第3阶段自动转换拾取方式为自由拾取"
})

L:SetMiscLocalization({
	DBM_VASHJ_YELL_PHASE2	= "机会来了！一个活口都不要留下！",
	LootMsg				= "(.+)获得了物品：.*Hitem:(%d+)"
})
