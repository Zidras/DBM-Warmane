if GetLocale() ~= "zhCN" then return end

local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "常规设置"
})

L:SetTimerLocalization({
	TimerFlag		= "重置",
	TimerShadow		= "暗影之眼",
	TimerStart		= "显示开始计时",
	TimerWin		= "显示获胜计时"
})

L:SetOptionLocalization({
	AutoSpirit			= "自动释放灵魂",
	ColorByClass		= "得分板上玩家按职业着色",
	HideBossEmoteFrame	= "在战场时隐藏团队首领表情框体/公会信息等",
	ShowBasesToWin		= "显示获胜需要占领的资源点",
	ShowEstimatedPoints	= "显示战斗开始/结束时双方资源统计",
	ShowFlagCarrier		= "显示旗帜携带者",
	ShowGatesHealth		= "生命值框：城门破损状况（中途加入战场，该数据可能不准确）",
	ShowRelativeGameTime= "计时条：战场开始到获胜的计时（如果禁用，则计时条总是看起来满了）",
	TimerCap			= "计时条：占领资源",
	TimerFlag			= "计时条：旗帜重置",
	TimerShadow			= "计时条：暗影之眼",
	TimerStart			= "显示开始计时",
	TimerWin			= "计时条：胜利时间"
})

L:SetMiscLocalization({
	--BG 2 minutes
	BgStart120TC		= "战斗将在2分钟后开始！",
	--BG 1 minute
	BgStart60TC			= "战斗将在1分钟后开始！",
	BgStart60AlteracTC	= "奥特兰克山谷的战斗将在1分钟之后开始。",
	BgStart60SotA2TC	= "远古海滩的第2轮比赛将在1分钟后开始。",
	BgStart60WarsongTC	= "战歌峡谷战斗将在1分钟内开始。",
	-- BG 30 seconds
	BgStart30TC			= "战斗将在30秒后开始！",
	BgStart30AlteracTC	= "奥特兰克山谷的战斗将在30秒之后开始。",
	BgStart30SotA2TC	= "第2轮比赛将在30秒后开始。备战！",
	BgStart30WarsongTC	= "战歌峡谷战斗将在30秒钟内开始。做好准备！",
	--
	ArenaInvite			= "竞技场邀请",
	Start60TC			= "竞技场战斗将在一分钟后开始！",
	Start30TC			= "竞技场战斗将在三十秒后开始！",
	Start15TC			= "竞技场战斗将在十五秒后开始！",
	BasesToWin			= "胜利需要占领资源点: %d",
	WinBarText			= "%s 获胜",
	-- Flag carrying system
	Flag				= "旗帜",
	FlagResetTC			= "旗帜被重新放置了。",
	FlagTakenTC			= "(.+) 夺走了旗帜！",
	FlagCapturedTC		= ".+夺得了旗帜！",
	FlagDroppedTC		= "旗帜被扔掉了！",
	--
	ExprFlagPickUpATC	= "联盟的旗帜被(.+)拔起了",
	ExprFlagPickUpHTC	= "(.+)拾起了部落军旗！",
	ExprFlagCapturedTC	= "(.+)获得了.+军旗！",
	ExprFlagReturnTC	= "(.+)将.+军旗放回到旗座上了！",
	ExprFlagDroppedATC	= "联盟的旗帜被(.+)丢掉了！", -- Alliance TrinityCore string was too different to use patterns
	ExprFlagDroppedHTC	= "(.+)掉落了部落军旗！", -- Horde
	Vulnerable1			= "旗帜携带者已变的容易受到攻击！",
	Vulnerable2			= "旗帜携带者越来越容易受到攻击！",
	-- Gates
	GatesHealthFrame				= "城门破损状况",
	HordeGateFront					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t 前门",
	HordeGateFrontDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t 前门",
	HordeGateWest					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t 西大门",
	HordeGateWestDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t 西大门",
	HordeGateEast					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t 东大门",
	HordeGateEastDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t 东大门",
	AllianceGateFront				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t 前门",
	AllianceGateFrontDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t 前门",
	AllianceGateWest				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t 西大门",
	AllianceGateWestDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t 西大门",
	AllianceGateEast				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t 东大门",
	AllianceGateEastDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t 东大门",
-- Strands of the Ancients Gates emotes
	GreenEmeraldAttacked			= "翡翠之门遭到攻击！",
	GreenEmeraldDestroyed			= "翡翠之门被摧毁了！",
	BlueSapphireAttacked			= "蓝玉之门遭到攻击！",
	BlueSapphireDestroyed			= "蓝玉之门被摧毁了！",
	PurpleAmethystAttacked			= "紫晶之门遭到攻击！",
	PurpleAmethystDestroyed			= "紫晶之门被摧毁了！",
	RedSunAttacked					= "红日之门遭到攻击！",
	RedSunDestroyed					= "红日之门被摧毁了！",
	YellowMoonAttacked				= "金月之门遭到攻击！",
	YellowMoonDestroyed				= "金月之门被摧毁了！",
	ChamberAncientRelicsAttacked	= "宝库遭到了攻击！",
	ChamberAncientRelicsDestroyed	= "宝库被攻破了！泰坦圣物失去了保护！",
	-- Isle of Conquest Gates CHAT_MSG_BG_SYSTEM_NEUTRAL messages
	HordeGateFrontDestroyedTC		= "部落要塞的前门被摧毁了！",
	HordeGateWestDestroyedTC		= "部落要塞的西门被摧毁了！",
	HordeGateEastDestroyedTC		= "部落要塞的东门被摧毁了！",
	AllianceGateFrontDestroyedTC	= "联盟要塞的前门被摧毁了！",
	AllianceGateWestDestroyedTC		= "联盟要塞的西门被摧毁了！",
	AllianceGateEastDestroyedTC		= "联盟要塞的东门被摧毁了！",
})


----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "奥特兰克山谷"
})

L:SetOptionLocalization({
	AutoTurnIn	= "自动递交任务物品"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "阿拉希盆地"
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "风暴之眼"
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "战歌峡谷"
})

------------------------------
--  Strand of the Ancients  --
------------------------------
L = DBM:GetModLocalization("StrandoftheAncients")

L:SetGeneralLocalization({
	name = "远古海滩"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("IsleofConquest")

L:SetWarningLocalization({
	WarnSiegeEngine		= "攻城机具准备好了！",
	WarnSiegeEngineSoon	= "10秒后 攻城机具就绪"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "攻城机具修复"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "计时条：攻城器的建造",
	WarnSiegeEngine		= "警报：攻城器准备就绪",
	WarnSiegeEngineSoon	= "预警：攻城器准备就绪"
})

L:SetMiscLocalization({
	SiegeEngine				= "攻城器",
	GoblinStartAlliance		= "看到那些爆盐炸弹了吗？当我维修攻城机具的时候用它们来轰破大门！",
	GoblinStartHorde		= "修理攻城机具的工作就交给我，帮我看着点就够了。如果你想要轰破大门的话，尽管把那些爆盐炸弹拿去用吧！",
	GoblinHalfwayAlliance	= "我已经修好一半了！别让部落靠近。工程学院可没有教我们如何作战喔！",
	GoblinHalfwayHorde		= "我已经修好一半了！别让联盟靠近 - 我的合约里可没有作战这一条！",
	GoblinFinishedAlliance	= "我有史以来最得意的作品！这台攻城机具已经可以上场啰！",
	GoblinFinishedHorde		= "这台攻城机具已经可以上场啦！",
	GoblinBrokenAlliance	= "这么快就坏啦？！别担心，再坏的情况我都可以修得好。",
	GoblinBrokenHorde		= "又坏掉了吗？！让我来修理吧……但别指望产品的保固会帮你支付这一切。"
})
