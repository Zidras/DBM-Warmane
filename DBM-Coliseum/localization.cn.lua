-- author: callmejames @《凤凰之翼》 一区藏宝海湾
-- commit by: yaroot <yaroot AT gmail.com>
-- modified by: Diablohu < 178.com / ngacn.cc / dreamgen.cn >
-- Simplified Chinese by hihihaheho@Warmane-Icecrown

if GetLocale() ~= "zhCN" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "诺森德猛兽"
}

L:SetWarningLocalization{
	WarningSnobold		= "狗头人奴隶 出现了"
}

L:SetTimerLocalization{
	TimerNextBoss		= "下一场战斗",
	TimerEmerge			= "钻地结束",
	TimerSubmerge		= "钻地"
}

L:SetOptionLocalization{
	WarningSnobold		= "为狗头人奴隶出现显示警报",
	PingCharge			= "当冰吼即将向你你冲锋时自动点击小地图",
	ClearIconsOnIceHowl	= "冲锋前清除所有标记",
	TimerNextBoss		= "显示下一场战斗倒计时",
	TimerEmerge			= "显示钻地计时",
	TimerSubmerge		= "显示钻地结束计时",
	IcehowlArrow		= "当冰吼即将向你附近冲锋时显示DBM箭头"
}

L:SetMiscLocalization{
	Charge				= "%%s等着(%S+)，发出一阵震耳欲聋的怒吼！",
	CombatStart			= "他来自风暴峭壁最幽深，最黑暗的洞穴，穿刺者戈莫克！准备战斗，英雄们！",
	Phase2				= "做好准备，英雄们，两头猛兽已经进入了竞技场！它们是酸喉和恐鳞！",
	Phase3				= "当下一名斗士出场时，空气都会为之冻结！它是冰吼，胜或是死，勇士们！",
	Gormok				= "穿刺者戈莫克",
	Acidmaw				= "酸喉",
	Dreadscale			= "恐鳞",
	Icehowl				= "冰吼"
}

---------------------
--  Lord Jaraxxus  --
---------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "加拉克苏斯大王"
}

L:SetOptionLocalization{
	IncinerateShieldFrame	= "在首领血量里显示血肉成灰目标的血量"
}

L:SetMiscLocalization{
	IncinerateTarget		= "血肉成灰 -> %s",
	FirstPull				= "大术士威尔弗雷德·菲斯巴恩将会召唤你们的下一个挑战者。等待他的登场吧。"
}

-------------------------
--  Faction Champions  --
-------------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "阵营冠军"
}

L:SetMiscLocalization{
	--Horde NPCs
	Gorgrim				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:64:64:96|t 戈瑞姆·影斩",				-- 34458
	Birana				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t 比莱纳·雷蹄",				-- 34451
	Erin				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t 伊林·雾蹄",				-- 34459
	Rujkah				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t 鲁姬卡",						-- 34448
	Ginselle			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:0:32|t 凋零者吉塞尔",				-- 34449
	Liandra				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t 莉安德拉·唤日者",				-- 34445
	Malithas			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t 玛里萨斯·辉刃",				-- 34456
	Caiphus				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t 严肃的凯普斯",				-- 34447
	Vivienne			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t 暗语者维维尼",				-- 34441
	Mazdinah			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:0:32|t 玛兹迪娜",					-- 34454
	Thrakgar			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t 萨卡加尔",					-- 34444
	Broln				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t 布罗恩·粗角",				-- 34455
	Harkzog				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:32:64|t 德拉克道格",				-- 34450
	Narrhok				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:0:32|t 断钢者纳霍克",					-- 34453
	--Alliance NPCs
	Tyrius				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:64:64:96|t 泰利乌斯·达斯布雷德",		-- 34461
	Kavina				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t 卡雯娜·林歌",				-- 34460
	Melador				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t 麦拉多·深谷游者",			-- 34469
	Alyssia             = "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t 阿莱希娅·月行者",				-- 34467
	Noozle				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:0:32|t 努兹尔·啸钉",				-- 34468
	Baelnor				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t 圣光使者巴尔诺",				-- 34471
	Velanaa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t 维兰纳",						-- 34465
	Anthar				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t 安塔尔·缮炉者",			-- 34466
	Brienna				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t 布瑞娜·沉夜",				-- 34473
	Irieth				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:0:32|t 伊锐丝·影踪",				-- 34472
	Saamul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t 萨缪尔",					-- 34470
	Shaabad				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t 沙拜德",					-- 34463
	Serissa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:32:64|t 塞瑞莎·术轮",				-- 34474
	Shocuul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:0:32|t 索库尔",						-- 34475

	AllianceVictory			= "荣耀属于联盟！",
	HordeVictory			= "这只是一个小小的开始。为了部落！",
	--YellKill			= "肤浅且可悲的胜利。今天的内耗让我们又一次被削弱了。这种愚蠢的行为只能让巫妖王受益！伟大的战士们就这样白白牺牲，而真正的威胁却步步逼近。巫妖王正计算着我们的死期。"
}

---------------------
--  Val'kyr Twins  --
---------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "瓦格里双子"
}

L:SetTimerLocalization{
	TimerSpecialSpell		= "下一次 特殊技能",
	TimerAnubRoleplay		= "坠落"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon	= "特殊技能 即将到来",
	SpecWarnSpecial			= "立刻变换颜色",
	SpecWarnSwitchTarget	= "立刻切换目标攻击双生相协",
	SpecWarnKickNow			= "立刻打断",
	WarningTouchDebuff		= "光明或黑暗之触 -> >%s<",
	WarningPoweroftheTwins2	= "双生之能 - 加大治疗 -> >%s<"
}

L:SetMiscLocalization{
	--YellPull = "以黑暗之主的名义。为了巫妖王。你必死无疑。",
	CombatStart	= "你们只有团结才能战胜最终的挑战。来自于冰冠冰川的深处，天灾军团最强的战将：巫妖王的双翼使者，恐怖的瓦格里！",
	Fjola		= "光明邪使菲奥拉",
	Eydis		= "黑暗邪使艾蒂丝",
	AnubRP		= "这是对巫妖王的一次重创！你的实力绝不亚于银色北伐军的勇士。很快，我们将携手攻入冰冠堡垒，消灭天灾军团的残余！只要心齐，我们必将胜利！"
}

L:SetOptionLocalization{
	TimerSpecialSpell		= "为下一次特殊技能显示计时器",
	TimerAnubRoleplay		= "计时条：地板破裂前的剧情",
	WarnSpecialSpellSoon	= "为下一次特殊技能显示提前警报",
	SpecWarnSpecial			= "当你需要变换颜色时显示特殊警报",
	SpecWarnSwitchTarget	= "当另一个首领施放双子相协时显示特殊警报",
	SpecWarnKickNow			= "当你可以打断时显示特殊警报",
	SpecialWarnOnDebuff		= "当你中了光明或黑暗之触时显示特殊警报(需切换颜色)",
	SetIconOnDebuffTarget	= "为光明或黑暗之触的目标设置标记(英雄模式)",
	WarningTouchDebuff		= "提示光明或黑暗之触的目标",
	WarningPoweroftheTwins2	= "提示双生之能的目标"
}

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 				= "阿努巴拉克"
}

L:SetTimerLocalization{
	TimerEmerge			= "钻地结束",
	TimerSubmerge		= "钻地",
	timerAdds			= "下一次 掘地者出现"
}

L:SetWarningLocalization{
	WarnEmerge			= "阿努巴拉克钻出地面了",
	WarnEmergeSoon		= "10秒后 钻出地面",
	WarnSubmerge		= "阿努巴拉克钻进地里了",
	WarnSubmergeSoon	= "10秒后 钻进地里",
	warnAdds			= "掘地者 出现了"
}

L:SetMiscLocalization{
	Emerge				= "钻入了地下！",
	Burrow				= "从地面上升起来了！",
	PcoldIconSet		= "刺骨之寒{rt%d} -> %s",
	PcoldIconRemoved	= "移除标记 -> %s"
}

L:SetOptionLocalization{
	WarnEmerge			= "为钻出地面显示警报",
	WarnEmergeSoon		= "为钻出地面显示提前警报",
	WarnSubmerge		= "为钻进地里显示警报",
	WarnSubmergeSoon	= "为钻进地里显示提前警报",
	warnAdds			= "提示掘地者出现",
	timerAdds			= "为下一次掘地者出现显示计时器",
	TimerEmerge			= "为首领钻地显示计时器",
	TimerSubmerge		= "为下一次钻地显示计时器",
	AnnouncePColdIcons	= "公布$spell:68510目标设置的标记到团队频道<br/>(需要团长或助理权限)",
	AnnouncePColdIconsRemoved	= "当移除$spell:68510的标记时也提示<br/>(需要上述选项)",
	RemoveHealthBuffsInP3	= "在第 3 阶段开始时移除健康增益"
}
