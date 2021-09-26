if GetLocale() ~= "zhTW" then return end
local L

---------------------------
--  Hydross the Unstable --
---------------------------
L = DBM:GetModLocalization("Hydross")

L:SetGeneralLocalization{
	name = "不穩定者海卓司"
}

L:SetWarningLocalization{
	WarnMark 		= "%s:%s",
	WarnPhase		= "%s階段",
	SpecWarnMark	= "%s:%s"
}

L:SetTimerLocalization{
	TimerMark	= "下一次%s:%s"
}

L:SetOptionLocalization{
	WarnMark		= "提示印記",
	WarnPhase		= "提示階段",
	SpecWarnMark	= "為印記易傷超過100%時顯示警告",
	TimerMark		= "為下一次印記顯示計時器"
}

L:SetMiscLocalization{
	Frost	= "冰霜",
	Nature	= "自然"
}

-----------------------
--  The Lurker Below --
-----------------------
L = DBM:GetModLocalization("LurkerBelow")

L:SetGeneralLocalization{
	name = "海底潛伏者"
}

L:SetWarningLocalization{
	WarnSubmerge		= "潛入水中",
	WarnEmerge			= "浮現"
}

L:SetTimerLocalization{
	TimerSubmerge		= "潛水冷卻",
	TimerEmerge			= "浮現冷卻"
}

L:SetOptionLocalization{
	WarnSubmerge		= "為潛入水中顯示警告",
	WarnEmerge			= "為浮現顯示警告",
	TimerSubmerge		= "為潛入水中顯示計時器",
	TimerEmerge			= "為浮現顯示計時器"
}

--------------------------
--  Leotheras the Blind --
--------------------------
L = DBM:GetModLocalization("Leotheras")

L:SetGeneralLocalization{
	name = "『盲目者』李奧薩拉斯"
}

L:SetWarningLocalization{
	WarnPhase		= "%s階段"
}

L:SetTimerLocalization{
	TimerPhase	= "下一次%s階段"
}

L:SetOptionLocalization{
	WarnPhase		= "為下個階段顯示警告",
	TimerPhase		= "為下個階段顯示計時器"
}

L:SetMiscLocalization{
	Human		= "人形",
	Demon		= "惡魔",
	YellDemon	= "消失吧，微不足道的精靈。現在開始由我掌管!",
	YellPhase2	= "不...不!你做了什麼?我是主人!你沒聽見我在說話嗎?我....啊!無法...控制它。"
}

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
L = DBM:GetModLocalization("Fathomlord")

L:SetGeneralLocalization{
	name = "深淵之王卡拉薩瑞斯"
}

L:SetMiscLocalization{
	Caribdis	= "深淵守衛卡利迪斯",
	Tidalvess	= "提達費斯",
	Sharkkis	= "深淵守衛沙卡奇斯"
}

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetGeneralLocalization{
	name = "莫洛葛利姆·潮行者"
}

L:SetWarningLocalization{
	SpecWarnMurlocs	= "魚人出現!"
}

L:SetTimerLocalization{
	TimerMurlocs	= "魚人出現"
}

L:SetOptionLocalization{
	SpecWarnMurlocs	= "為魚人出現顯示特別警告",
	TimerMurlocs	= "為魚人出現顯示計時器"
}

-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetGeneralLocalization{
	name = "瓦許女士"
}

L:SetWarningLocalization{
	WarnElemental		= "污染的元素即將出現! (%s)",
	WarnStrider			= "盤牙旅行者即將出現! (%s)",
	WarnNaga			= "盤牙精英即將出現! (%s)",
	WarnShield			= "魔法屏障%d/4消失!",
	WarnLoot			= ">%s<擁有受污染的核心!",
	SpecWarnElemental	= "污染的元素 - 快換目標!"
}

L:SetTimerLocalization{
	TimerElementalActive	= "污染的元素重生",
	TimerElemental			= "污染的元素 (%d)",
	TimerStrider			= "盤牙旅行者 (%d)",
	TimerNaga				= "盤牙精英 (%d)"
}

L:SetOptionLocalization{
	WarnElemental		= "為下一次污染的元素顯示預先警告",
	WarnStrider			= "為下一次盤牙旅行者顯示預先警告",
	WarnNaga			= "為下一次盤牙精英顯示預先警告",
	WarnShield			= "為第2階段屏障消失顯示警告",
	WarnLoot			= "提示誰拾取了受污染的核心",
	TimerElementalActive	= "為下一次污染的元素出現顯示計時器",
	TimerElemental		= "為下一次污染的元素顯示計時器",
	TimerStrider		= "為下一次盤牙旅行者顯示計時器",
	TimerNaga			= "為下一次盤牙精英顯示計時器",
	SpecWarnElemental	= "為污染的元素出現顯示特別警告",
	AutoChangeLootToFFA	= "第2階段自動轉換拾取方式為自由拾取"
}

L:SetMiscLocalization{
	DBM_VASHJ_YELL_PHASE2	= "機會來了!一個活口都不要留下!",
	DBM_VASHJ_YELL_PHASE3	= "你們最好找掩護。",
	LootMsg					= "(.+)拾取了物品:.*Hitem:(%d+)"
}
