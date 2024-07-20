if GetLocale() ~= "zhCN" then return end
local L
----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "玛洛加尔领主"
})

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization({
	name = "亡语者女士"
})

L:SetTimerLocalization({
	TimerAdds = "新的小怪"
})

L:SetWarningLocalization({
	WarnReanimating = "小怪再活化",
	WarnAddsSoon = "新的小怪即将到来",
	SpecWarnVengefulShade = "怨毒之影目标是你 - 快躲开", --creatureid 38222 -- Modified by Emi
	WeaponsStatus = "自动卸下武器开启: %s (%s - %s)" -- Modified by Emi
})

L:SetOptionLocalization({
	WarnAddsSoon = "为新的小怪出现显示预先警告",
	WarnReanimating = "当小怪再活化时显示警告",
	TimerAdds = "为新的小怪显示计时器",
	SpecWarnVengefulShade = "当怨毒之影攻击你时显示特殊警报", -- Modified by Emi
	WeaponsStatus = "如果卸下/装备武器功能启用，在战斗开始时显示特殊警报", -- Modified by Emi
	ShieldHealthFrame = "显示 Boss 血条，并为 $spell:70842 显示专门血条", -- Modified by Emi
	SoundWarnCountingMC = "为心灵控制播放5秒声音倒数", -- Modified by Emi
--	RemoveDruidBuff = "Remove $spell:48469 / $spell:48470 24 seconds into the fight",
	RemoveBuffsOnMC = "当$spell:71289对你施法时，移除BUFF。每个选项都是累积的。",
	Gift = "移除$spell:48469 / $spell:48470。防止$spell:33786抵制的最简单方法。",
	CCFree = "+ 删除$spell:48169 / $spell:48170。考虑到阴影法术的抵抗。", -- Modified by Emi
	ShortOffensiveProcs = "+ 删除持续时间短的攻击性程序。建议在不影响突击队伤害输出的情况下保证团队的安全。", -- Modified by Emi
	MostOffensiveBuffs = "+ 移除大部分攻击性BUFF（主要针对施法者和|cFFFF7C0A野性德鲁伊|r）。在损失伤害输出和需要自我补血/移形换影的情况下，最大限度地保证了团队的安全！", -- Modified by Emi
	EqUneqWeapons = "如果$spell:71289 对你施放，自动卸下/装备武器。要使这一功能正常工作，请创建一个名为\"pve\"的完整套装（要包含你需要装备的武器）。", -- Modified by Emi
	EqUneqTimer = "不论目标是否是你，总是按照心控计时卸下/装备武器（建议在高延迟时使用）。必须在前一选项开启的情况下使用。" -- Modified by Emi
})

L:SetMiscLocalization({
	YellReanimatedFanatic = "来吧，为纯粹的形态欢喜吧！",
--	Fanatic1 = "教派狂热者",
--	Fanatic2 = "畸形的狂热者",
--	Fanatic3 = "被复活的狂热者",
	setMissing = "注意力！ 在您创建名为 pve 的装备集之前，DBM 自动武器卸载/装备将不起作用",
	EqUneqLineDescription	= "自动装备/取消装备"
})

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization({
	name = "冰冠炮舰战斗"
})

L:SetWarningLocalization({
	WarnAddsSoon = "新的小怪即将到来"
})

L:SetOptionLocalization({
	WarnAddsSoon = "为新的小怪出现显示预先警告",
	TimerAdds = "为新的小怪显示计时器"
})

L:SetTimerLocalization({
	TimerAdds = "新的小怪"
})

L:SetMiscLocalization({
	PullAlliance = "启动引擎！小伙子们，向命运之战前进！",
	PullHorde = "来吧！部落忠诚勇敢的儿女们！今天是部落仇敌灭亡的日子！LOK'TAR OGAR！",
	AddsAlliance = "将士们，给我进攻！",
	AddsHorde = "将士们，给我进攻！",
	MageAlliance = "我们的船体受损了，赶快叫个战斗法师来轰掉那些大炮！",
	MageHorde = "我们的船体受伤了，赶快叫个法师来干掉那些大炮！",
	KillAlliance = "我早就警告过你，恶棍！兄弟姐妹们，前进！",
	KillHorde = "联盟不行了。向巫妖王进攻！",
})

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization({
	name = "死亡使者萨鲁法尔"
})

L:SetOptionLocalization({
	RunePowerFrame = "显示首领血量及$spell:72371条",
--	RemoveDI = "如果用于阻止 $spell:72293 施法，则清除 $spell:19752"
})

L:SetMiscLocalization({
	RunePower = "鲜血能量",
	PullAlliance = "你每消灭一名部落士兵，或是杀死一只联盟狗。巫妖王的军力就会增长一分。瓦格里正在把你们的阵亡者变为天灾战士。",
	PullHorde = "库卡隆，行动！勇士们，提高警惕。天灾军团已经……"
})

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "烂肠"
})

L:SetOptionLocalization({
	AnnounceSporeIcons = "公布$spell:69279目标设置的标记到团队频道<br/>(需要团队队长)",
	AchievementCheck = "公布 '勤通风，多喝水' 成就失败到团队频道<br/>(需助理权限)" -- Modified by Emi
})

L:SetMiscLocalization({
	SporeSet = "气体孢子{rt%d}: %s",
	AchievementFailed = ">> 成就失败: %s中了%d层孢子 <<"
})

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization({
	name = "腐面"
})

L:SetWarningLocalization({
	WarnOozeSpawn = "小软泥怪出现了",
	SpecWarnLittleOoze = "你被小软泥怪盯上了 - 快跑开"
})

L:SetOptionLocalization({
	WarnOozeSpawn = "为小软泥的出现显示警告",
	SpecWarnLittleOoze = "当你被小软泥怪盯上时显示特別警告",
	TankArrow = "为软泥坦克显示DBM箭头（测试功能）" -- Modified by Emi
})

L:SetMiscLocalization({
	YellSlimePipes1 = "好消息！各位！我修好了毒性软泥管道！",
	YellSlimePipes2 = "重大喜讯！各位！软泥又开始流动啦！"
})

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization({
	name = "普崔塞德教授"
})

L:SetWarningLocalization({
	WarnReengage = "%s: 重新激活" -- more accurate translation
})

L:SetTimerLocalization({
	TimerReengage = "重新激活" -- more accurate translation
})

L:SetOptionLocalization({
	WarnReengage = "为Boss重新激活显示警告",
	TimerReengage = "为Boss重新激活显示计时器"
})

L:SetMiscLocalization({
	YellTransform1 = "嗯，什么感觉也没有。什么？！这是哪儿来的？",
	YellTransform2 = "味道像……樱桃！哦！见笑了！"
})

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization({
	name = "血王子议会"
})

L:SetWarningLocalization({
	WarnTargetSwitch = "转换目标到: %s",
	WarnTargetSwitchSoon = "转换目标即将到来"
})

L:SetTimerLocalization({
	TimerTargetSwitch = "转换目标"
})

L:SetOptionLocalization({
	WarnTargetSwitch = "为转换目标显示警告",
	WarnTargetSwitchSoon = "为转换目标显示临近警告", -- Modified by Emi
	TimerTargetSwitch = "为转换目标显示计时器", -- more accurate translation
	ActivePrinceIcon = "在強化的王子身上设置标记(骷髅)", -- Modified by Emi
	ShadowPrisonMetronome = "播放一个重复的1秒钟的点击声，以避免$spell:72999"
})

L:SetMiscLocalization({
	Keleseth = "凯雷塞斯王子",
	Taldaram = "塔达拉姆王子",
	Valanar = "瓦拉纳王子",
	FirstPull = "愚蠢的凡人。你以为能轻易打败我们？萨莱因是巫妖王永生的战士！现在他们将合力撕碎你！",
	EmpoweredFlames = "强能烈焰飞快地冲向(%S+)！"
})

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization({
	name = "鲜血女王兰娜瑟尔"
})

L:SetMiscLocalization({
	SwarmingShadows = "蜂拥的阴影在(%S+)的四周积聚！",
	YellFrenzy = "我该去咬人啦!"
})

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization({
	name = "踏梦者瓦莉瑟瑞娅"
})

L:SetWarningLocalization({
	WarnPortalOpen = "传送门开启"
})

L:SetTimerLocalization({
	TimerPortalsOpen = "传送门开启",
	TimerPortalsClose = "传送门关闭", -- Modified by Emi
	TimerBlazingSkeleton = "下一次炽热骷髅",
	TimerAbom = "下一次憎恶体 (%s)"
})

L:SetOptionLocalization({
	WarnPortalOpen = "当梦魇之门开启时显示警告",
	TimerPortalsOpen = "为梦魇之门开启显示计时器", -- Modified by Emi
	TimerPortalsClose = "为梦魇之门关闭显示计时器", -- Modified by Emi
	TimerBlazingSkeleton = "为下一次炽热骷髅出现显示计时器"
})

L:SetMiscLocalization({
	YellPull = "入侵者闯入了内室。加紧毁掉那条绿龙！留下龙筋龙骨用来复生！",
	YellPortals = "我打开了进入梦境的传送门。英雄们，救赎就在其中……",
})

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization({
	name = "辛达苟萨"
})

L:SetWarningLocalization({
	WarnAirphase = "空中阶段",
	WarnGroundphaseSoon = "辛达苟萨 即将着陆"
})

L:SetTimerLocalization({
	TimerNextAirphase = "下一次空中阶段",
	TimerNextGroundphase = "下一次地上阶段",
	AchievementMystic = "清除秘能连击叠加"
})

L:SetOptionLocalization({
	WarnAirphase = "提示空中阶段",
	WarnGroundphaseSoon = "为地上阶段显示预先警告",
	TimerNextAirphase = "为下一次 空中阶段显示计时器",
	TimerNextGroundphase = "为下一次 地上阶段显示计时器",
	AnnounceFrostBeaconIcons = "公布$spell:70126目标设置的标记到团队频道<br/>(需要团队队长)",
	ClearIconsOnAirphase = "空中阶段前清除所有标记",
	AssignWarnDirectionsCount = "为 $spell:70126 目标分配方向并在第 2 阶段进行计数",
	AchievementCheck = "公布 '极限' 成就警告到团队频道<br/>(需助理权限)", -- Modified by Emi
	RangeFrame = "根据最后首领使用的技能跟玩家减益显示动态距离框(10/20码)"
})

L:SetMiscLocalization({
	YellAirphase = "你们的入侵结束了！无人可以生还！",
	YellPhase2 = "绝望吧，体会主人那无穷无尽的力量吧！",
	YellAirphaseDem = "Rikk zilthuras rikk zila Aman adare tiriosh ", --Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem = "Zar kiel xi romathIs zilthuras revos ruk toralar ", --Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet = "冰霜道标{rt%d}: %s",
	AchievementWarning = "警告: %s中了5层秘法打击",
	AchievementFailed = ">> 成就失败: %s中了%d层秘法打击 <<"
})

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization({
	name = "巫妖王"
})

L:SetWarningLocalization({
	ValkyrWarning = "%s >%s< %s 被抓住了!",
	SpecWarnYouAreValkd = "你被抓住了",
	WarnNecroticPlagueJump = "死疽跳到>%s<身上", -- Modified by Emi
	SpecWarnValkyrLow = "瓦基里安血量低于55%"
})

L:SetTimerLocalization({
	TimerRoleplay = "角色扮演",
	PhaseTransition = "转换阶段",
	TimerNecroticPlagueCleanse = "驱散死疽" -- Modified by Emi
})

L:SetOptionLocalization({
	TimerRoleplay = "为角色扮演事件显示计时器",
	WarnNecroticPlagueJump = "提示$spell:73912跳跃后的目标",
	TimerNecroticPlagueCleanse = "为驱散第一层死疽显示计时器", -- Modified by Emi
	PhaseTransition = "为转换阶段显示计时器",
	ValkyrWarning = "提示谁给瓦格里暗影戒卫者抓住了", -- Modified by Emi
	SpecWarnYouAreValkd = "当你给瓦格里暗影戒卫者抓住时显示特別警告", -- Modified by Emi
	AnnounceValkGrabs = "提示谁被瓦格里暗影戒卫者抓住到团队频道<br/>(需开启团队广播及助理权限)", -- Modified by Emi
	SpecWarnValkyrLow = "当瓦格里血量低于55%时显示特別警告", -- Modified by Emi
	AnnouncePlagueStack = "提示$spell:73912层数到团队频道 (10层, 10层后每5层提示一次)<br/>(需开启助理权限)",
	ShowFrame = "显示瓦格里者抓人框架", -- Modified by Emi
	FrameClassColor = "在瓦格里者抓人框架中显示职业颜色", -- Modified by Emi
	FrameUpwards = "瓦格里框架向上生长", -- Modified by Emi
	FrameLocked = "锁定瓦格里框架", -- Modified by Emi
	RemoveImmunes = "在离开霜之哀伤时移除无敌类Buff" -- Modified by Emi
})

L:SetMiscLocalization({
	LKPull = "怎么，自诩正义的圣光终于来了？我是不是该丢下霜之哀伤，恳求您的宽恕呢，弗丁？",
	LKRoleplay = "真的是正义在驱使你吗？我很好奇……",
	ValkGrabbedIcon = "瓦格里影卫{rt%d}抓住了%s",
	ValkGrabbed = "瓦格里影卫抓住了%s",
	PlagueStackWarning = "警告: %s中了%d层死疽", -- Modified by Emi
	AchievementCompleted = ">> 成就成功: %s中了%d层死疽 <<", -- Modified by Emi
	FrameTitle = "瓦格里目标", -- Modified by Emi
	FrameLock = "框架锁定", -- Modified by Emi
	FrameClassColor = "显示职业颜色", -- Modified by Emi
	FrameOrientation = "向上生长", -- Modified by Emi
	FrameHide = "隐藏框架", -- Modified by Emi
	FrameClose = "关闭", -- Modified by Emi
	FrameGUIDesc = "瓦格里框架",
	FrameGUIMoveMe = "移动瓦格里框架"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ICCTrash")

L:SetGeneralLocalization({
	name = "冰冠堡垒小怪" -- Modified by Emi
})

L:SetWarningLocalization({
	SpecWarnTrapL = "触发陷阱! - 亡缚守卫被释放了",
	SpecWarnTrapP = "触发陷阱! - 复仇的血肉收割者到来",
	SpecWarnGosaEvent = "辛达苟萨夹道攻击开始!"
})

L:SetOptionLocalization({
	SpecWarnTrapL = "当触发陷阱时显示特別警告",
	SpecWarnTrapP = "当触发陷阱时显示特別警告",
	SpecWarnGosaEvent = "为辛达苟萨夹道攻击显示特別警告"
})

L:SetMiscLocalization({
	WarderTrap1 = "那里是谁？",
	WarderTrap2 = "我醒了!",
	WarderTrap3 = "有人闯进了主人的房间！",
	FleshreaperTrap1 = "快点，我们会在背后伏击他们！",
	FleshreaperTrap2 = "你逃不出我们的手心！",
	FleshreaperTrap3 = "这里有活人？！",
	SindragosaEvent = "绝不能让他们靠近冰霜女王。快，阻止他们！"
})
