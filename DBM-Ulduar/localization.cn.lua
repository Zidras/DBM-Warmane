if GetLocale() ~= "zhCN" then return end
local L
-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization({
	name				= "烈焰巨兽"
})

L:SetWarningLocalization({
	PursueWarn			= "追踪 -> >%s<",
	warnNextPursueSoon	= "5秒后 更换目标",
	SpecialPursueWarnYou= "你被追踪 - 快跑",
	warnWardofLife		= "生命结界 出现"
})

L:SetOptionLocalization({
	SpecialPursueWarnYou= "当你被追踪时显示特别警报",
	PursueWarn			= "提示追踪的目标",
	warnNextPursueSoon	= "为下一次追踪显示提前警报",
	warnWardofLife		= "为生命结界出现显示特别警报"
})

L:SetMiscLocalization({
	YellPull			= "检测到敌对实体。威胁评定协议启动。向主要目标发动攻击。30秒后重新评估。",
	Emote				= "%%s开始追赶(%S+)%。"
})

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization({
	name = "掌炉者伊格尼斯"
})

L:SetOptionLocalization({
	soundConcAuraMastery	= "播放$spell:31821的声音来否定$spell:63472的效果（只针对$spell:19746的主人|cFFF48CBA圣骑士|r"
})

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization({
	name = "锋鳞"
})

L:SetWarningLocalization({
	warnTurretsReadySoon		= "20秒后 最后一座炮塔完成",
	warnTurretsReady			= "最后一座炮塔已完成",
	SpecWarnDevouringFlameCast	= "你中了噬体烈焰",
	WarnDevouringFlameCast		= "噬体烈焰 -> >%s<"
})

L:SetTimerLocalization({
	timerTurret1			= "炮塔1",
	timerTurret2			= "炮塔2",
	timerTurret3			= "炮塔3",
	timerTurret4			= "炮塔4",
	timerGrounded			= "地面阶段"
})

L:SetOptionLocalization({
	warnTurretsReadySoon	= "为炮塔显示提前警报",
	warnTurretsReady		= "为炮塔显示警报",
	timerTurret1			= "为炮塔1显示计时条",
	timerTurret2			= "为炮塔2显示计时条",
	timerTurret3			= "为炮塔3显示计时条 (25人)",
	timerTurret4			= "为炮塔4显示计时条 (25人)",
	timerGrounded			= "为地面阶段显示计时条"
})

L:SetMiscLocalization({
	YellAir				= "给我们一点时间，做好建筑炮台的准备。",
	YellAir2			= "火灭了！准备重建炮台！",
	YellGround			= "快一点！她马上就要挣脱了！",
	EmotePhase2			= "%%s被永久地禁锢在地面上！"
})

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization({
	name = "XT-002拆解者"
})

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization({
	name = "钢铁议会"
})

L:SetOptionLocalization({
	AlwaysWarnOnOverload		= "总是对$spell:63481显示警报(否则只有当目标是唤雷者的时候显示)"
})

L:SetMiscLocalization({
	Steelbreaker			= "断钢者",
	RunemasterMolgeim		= "符文大师莫尔基姆",
	StormcallerBrundir		= "唤雷者布隆迪尔"
})

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization({
	name				= "观察者奥尔加隆"
})

L:SetWarningLocalization({
	warnStarLow			= "坍缩星血量低"
})

L:SetTimerLocalization({
	NextCollapsingStar		= "下一次 坍缩星",
})

L:SetOptionLocalization({
	NextCollapsingStar		= "为下一次坍缩星显示计时条",
	warnStarLow			= "当坍缩星血量低(大约25%)时显示特别警报"
})

L:SetMiscLocalization({
--	HealthInfo			= "为星星疗伤",
--	FirstPull			= "通过我的双眼来观察你们的世界吧：一个广袤无垠的宇宙，即使是你们当中最睿智的人，也无法理解这一切。",
--	YellPull			= "你们的行动不合逻辑。这场战斗所有可能产生的结果都已被计算在内。无论结果如何，万神殿都会收到观察者发出的信息。",
	YellKill			= "我曾见证过无数个世界被造物者的烈焰吞噬，那些世界中的人们甚至来不及发出一声悲鸣就永远消逝了。整个星球从诞生到毁灭，不过是弹指一挥间。但是从始至终，我都没有为之动容……我，毫无，感觉。千亿的生命被毁灭。他们是否都像你们一样坚强？他们是否都像你们一样热爱生命？",
	Emote_CollapsingStar= "%s开始召唤坍缩之星！",
	Phase2				= "看吧，这创世的神器！!",
	CollapsingStar		= "坍缩之星"
})

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization({
	name = "科隆加恩"
})

L:SetTimerLocalization({
	timerLeftArm		= "左臂重生",
	timerRightArm		= "右臂重生",
	achievementDisarmed	= "成就计时：断其臂膀"
})

L:SetOptionLocalization({
	timerLeftArm		= "为左臂重生显示计时条",
	timerRightArm		= "为右臂重生显示计时条",
	achievementDisarmed	= "为成就：断其臂膀显示计时条"
})

L:SetMiscLocalization({
--	Yell_Trigger_arm_left = "不疼不痒！",
--	Yell_Trigger_arm_right = "只是轻伤而已！",
	Health_Body			= "科隆加恩身体",
	Health_Right_Arm	= "右臂",
	Health_Left_Arm		= "左臂",
	FocusedEyebeam		= "在注视着你"
})

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization({
	name				= "欧尔莉亚"
})

L:SetWarningLocalization({
	WarnCatDied			= "野性防御者倒下(剩余%d只)",
	WarnCatDiedOne			= "野性防御者倒下(剩下最后一只)"
})

-- L:SetTimerLocalization({
-- 	timerDefender		= "野性防御者复活"
-- })

L:SetOptionLocalization({
	WarnCatDied				= "当野性防御者死亡时显示警报",
	WarnCatDiedOne			= "当野性防御者剩下最后一只时显示警报"
--	timerDefender			= "当野性防御者准备复活时显示计时条"
})

L:SetMiscLocalization({
	Defender			= "野性防御者(%d)",
	YellPull			= "有些东西，最好永远都不去碰！"
})

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization({
	name				= "霍迪尔"
})

L:SetMiscLocalization({
	Pull				= "你要为你的罪行受到惩罚！",
	YellKill			= "我……我终于从他的魔掌中……解脱了。"
})

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization({
	name				= "托里姆"
})

L:SetTimerLocalization({
	TimerHardmode		= "困难模式"
})

L:SetOptionLocalization({
	specWarnHardmode	= "特殊警报：困难模式",
	TimerHardmode		= "为困难模式显示计时条",
	AnnounceFails		= "公布中了闪电充能的玩家到团队频道<br/>(需要团长或助理权限)"
})

L:SetMiscLocalization({
	YellPhase1			= "入侵者！你们这些凡人竟敢坏了我的兴致，看我怎么……等等，你们……",
	YellPhase2			= "狂妄的小崽子们，竟敢在我的地盘上挑战我？我要亲自碾碎你们！",
	YellKill			= "住手！我认输了！",
	YellHardModeActive	= "这不可能！托里姆陛下，我要让您的敌人在严寒中死去！",
	YellHardModeFailed	= "这些可悲的凡人毫无威胁，根本不值得我动手。干掉他们！",
	ChargeOn			= "闪电充能 -> %s",
	Charge				= "中了闪电充能(这一次): %s"
})

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization({
	name				= "弗蕾亚"
})

L:SetWarningLocalization({
	WarnSimulKill		= "第一只元素死亡 - 约12秒后复活"
})

L:SetTimerLocalization({
	TimerSimulKill		= "复活"
})

L:SetOptionLocalization({
	WarnSimulKill			= "提示第一只元素死亡",
	TimerSimulKill			= "为三元素复活显示计时条"
})

L:SetMiscLocalization({
	SpawnYell			= "孩子们，帮帮我！",
	WaterSpirit			= "古代水之精魂",
	Snaplasher			= "迅疾鞭笞者",
	StormLasher			= "风暴鞭笞者",
	YellKill			= "他对我的控制已经不复存在了。我又一次恢复了理智。谢谢你们，英雄们。",
	YellAdds1			= "艾欧娜尔，您的仆人需要帮助！",
	YellAdds2			= "元素之潮会击垮你们！",
	EmoteLGift			= "开始生长！", -- |cFF00FFFF生命缚誓者的礼物|r开始生长！
	TrashRespawnTimer	= "弗蕾亚的小怪重生",
	YellPullNormal		= "必须保卫温室！",
	YellPullHard		= "长老们，将你们的力量赐予我！"
})

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization({
	name				= "弗蕾亚的长者"
})

L:SetOptionLocalization({
	TrashRespawnTimer	= "为弗蕾亚的小怪重生显示计时条"
})

L:SetMiscLocalization({
	TrashRespawnTimer	= "弗蕾亚的小怪重生"
})

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization({
	name				= "米米尔隆"
})

L:SetWarningLocalization({
	MagneticCore			= ">%s< 拿到了磁核",
	WarnBombSpawn			= "炸弹机器人出现了"
})

L:SetTimerLocalization({
	TimerHardmode			= "困难模式 - 自毁程序",
	TimeToPhase2			= "第2阶段开始",
	TimeToPhase3			= "第3阶段开始",
	TimeToPhase4			= "第4阶段开始"
})

L:SetOptionLocalization({
	TimeToPhase2			= "为第2阶段开始显示计时条",
	TimeToPhase3			= "为第3阶段开始显示计时条",
	TimeToPhase4			= "为第4阶段开始显示计时条",
	MagneticCore			= "提示磁核的拾取者",
	AutoChangeLootToFFA		= "在第 3 阶段将战利品模式切换为对所有人免费",
	WarnBombSpawn			= "为炸弹机器人显示警报",
	TimerHardmode			= "为困难模式显示计时条"
})

L:SetMiscLocalization({
	MobPhase1			= "巨兽二型",
	MobPhase2			= "VX-001",
	MobPhase3			= "空中指挥单位",
	MobPhase4			= "V-07-TR-0N", -- don't localize
	YellPull			= "我们时间不多了，朋友们！来帮忙测试一下我所发明的最新型、最强大的机体吧。在你们改变主意之前，请允许我提醒一下，你们把XT-002搞得一团糟，应该算是欠我个人情吧。",
	YellHardPull		= "自毁程序已经启动。",
	YellPhase2			= "太棒了！测试结果非常好！外壳完整率百分之九十八点九！几乎没有划伤！继续。",
	YellPhase3			= "非常感谢，朋友们！你们的帮助使我获得了一些极其珍贵的数据！下面，我要让你们——咦，我把它放哪去了？哦！这里。",
	YellPhase4			= "初步测试阶段完成。真正的测试开始啦！",
	YellKilled			= "看起来我的计算有一点小小的偏差。监狱中的恶魔侵蚀了我的思维，篡改了我的主要指令。所有系统都已恢复正常。完毕。",
	LootMsg				= "(.+)获得了物品：.*Hitem:(%d+)"
})

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization({
	name				= "维扎克斯将军"
})

L:SetTimerLocalization({
	hardmodeSpawn		= "萨隆邪铁畸体 出现"
})

L:SetOptionLocalization({
	hardmodeSpawn		= "为萨隆邪铁畸体出现显示计时条 (困难模式)",
	CrashArrow			= "当你附近的人中了$spell:62660时显示DBM箭头",
})

L:SetMiscLocalization({
	EmoteSaroniteVapors	= "一团萨隆邪铁蒸汽在附近聚集起来！"
})

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization({
	name				= "尤格萨隆"
})

L:SetWarningLocalization({
	WarningGuardianSpawned			= "尤格萨隆的卫士 %d 出现了",
	WarningCrusherTentacleSpawned	= "重压触须 出现了",
	WarningSanity					= "剩余理智：%d",
	SpecWarnSanity					= "剩余理智：%d",
	SpecWarnGuardianLow				= "停止攻击这只守护者",
	SpecWarnMadnessOutNow			= "疯狂诱导即将结束 - 立刻传送出去",
	WarnBrainPortalSoon				= "10秒后 脑部传送门",
	SpecWarnBrainPortalSoon			= "脑部传送门 即将出现"
})

L:SetTimerLocalization({
	NextPortal						= "下一次 脑部传送门"
})

L:SetOptionLocalization({
	WarningGuardianSpawned			= "为尤格萨隆的卫士出现显示警报",
	WarningCrusherTentacleSpawned	= "为重压触须出现显示警报",
	WarningSanity					= "当理智剩下50时显示警报",
	SpecWarnSanity					= "当理智过低(35,25,15)时显示特别警报",
	SpecWarnGuardianLow				= "当尤格萨隆的卫士(第1阶段)血量过低时显示特别警报 (输出职业用)",
	WarnBrainPortalSoon				= "为脑部传送门显示提前警报",
	SpecWarnMadnessOutNow			= "为疯狂诱导结束前显示特别警报",
	SpecWarnBrainPortalSoon			= "为下一次脑部传送门显示特别警报",
	NextPortal						= "为下一次传送门显示计时条",
	ShowSaraHealth					= "显示萨拉在第1阶段的血量 (必须至少有一名团队成员设置首领为焦点目标)",
	MaladyArrow						= "当你附近的人中了$spell:63881时显示DBM箭头"
})

L:SetMiscLocalization({
	YellPull			= "攻击这头野兽要害的时刻即将来临！将你们的愤怒和仇恨倾泻到它的爪牙身上！",
	S1TheLucidDream		= "第一阶段：清醒的梦境",
	Sara				= "萨拉",
	GuardianofYoggSaron	= "尤格-萨隆的卫士",
	S2DescentIntoMadness= "第二阶段：坠入疯狂",
	CrusherTentacle		= "重压触须",
	CorruptorTentacle	= "腐蚀触须",
	ConstrictorTentacle	= "缠绕触须",
	DescentIntoMadness	= "疯狂阶梯",
	InfluenceTentacle	= "感应触须",
	LaughingSkull		= "嘲笑之颅",
	BrainofYoggSaron	= "尤格-萨隆的大脑",
	S3TrueFaceofDeath	= "第三阶段：死亡的真正面貌",
	YoggSaron			= "尤格-萨隆",
	ImmortalGuardian	= "不朽守护者"
})
