if GetLocale() ~= "zhTW" then return end

local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "基本選項"
})

L:SetTimerLocalization({
	TimerFlag		= "旗幟重生",
	TimerShadow		= "暗影視界",
	TimerStart		= "戰鬥即將開始",
	TimerWin		= "勝利在"
})

L:SetOptionLocalization({
	AutoSpirit			= "自動釋放靈魂",
	ColorByClass		= "在得分視窗中設置玩家名為職業顏色",
	HideBossEmoteFrame	= "在戰場時隱藏團隊首領表情框架&要塞/公會提示",
	ShowBasesToWin		= "顯示勝利需要的基地數量",
	ShowEstimatedPoints	= "顯示戰鬥結束時雙方資源預計值",
	ShowFlagCarrier		= "顯示旗幟攜帶者",
	ShowGatesHealth		= "顯示受損大門的耐久值(當加入一個正在進行的戰場大門耐久值可能會不準確！)",
	ShowRelativeGameTime= "相對於BG開始時間的獲勝計時器（如果禁用，則欄總是看起來滿了）",
	TimerCap			= "顯示奪取計時器",
	TimerFlag			= "顯示旗幟重生計時器",
	TimerShadow			= "顯示暗影視界計時器",
	TimerStart			= "顯示開始計時器",
	TimerWin			= "顯示勝利計時器",
})

L:SetMiscLocalization({
	--BG 2 minutes
	BgStart120TC		= "戰鬥在2分鐘內開始!",
	--BG 1 minute
	BgStart60TC			= "戰鬥在1分鐘內開始!",
	BgStart60AlteracTC	= "奧特蘭克山谷一分鐘後開始戰鬥。",
	BgStart60SotA2TC	= "遠祖灘頭的第2回合戰鬥將在1分鐘後開始。",
	BgStart60WarsongTC	= "戰歌峽谷戰鬥將在1分鐘內開始。",
	-- BG 30 seconds
	BgStart30TC			= "戰鬥在30秒內開始!",
	BgStart30AlteracTC	= "奧特蘭克山谷30秒後開始戰鬥。",
	BgStart30SotA2TC	= "第2回合將在30秒後開始。做好準備!",
	BgStart30WarsongTC	= "戰歌峽谷戰鬥將在30秒鐘內開始。做好準備!",
	--
	ArenaInvite			= "競技場邀請",
	Start60TC			= "1分鐘後競技場戰鬥開始!",
	Start30TC			= "30秒後競技場戰鬥開始!",
	Start15TC			= "15秒後競技場戰鬥開始!",
	BasesToWin			= "勝利需要基地: %d",
	WinBarText			= "%s 勝利",
	-- Flag carrying system
	Flag				= "旗幟",
	FlagResetTC			= "旗幟已重置。",
	FlagTakenTC			= "(.+)已經奪走了旗幟!",
	FlagCapturedTC		= ".+已奪得旗幟!",
	FlagDroppedTC		= "旗幟已經掉落!",
	--
	ExprFlagPickUpATC	= "聯盟的旗幟被(.+)拔掉了!",
	ExprFlagPickUpHTC	= "部落的旗幟被(.+)拔起了!",
	ExprFlagCapturedTC	= "(.+)奪取了.+的旗幟!",
	ExprFlagReturnTC	= ".+的旗幟被(.+)歸還到它的基地了!",
	ExprFlagDroppedTC	= ".+的旗幟被(.+)丟掉了!",
	Vulnerable1			= "旗幟攜帶者變得脆弱了！",
	Vulnerable2			= "旗幟攜帶者變得更加的脆弱了！",
	-- Gates
	GatesHealthFrame				= "受損的大門",
	HordeGateFront					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t 前門",
	HordeGateFrontDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t 前門",
	HordeGateWest					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t 西門",
	HordeGateWestDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t 西門",
	HordeGateEast					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t 東門",
	HordeGateEastDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t 東門",
	AllianceGateFront				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t 前門",
	AllianceGateFrontDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t 前門",
	AllianceGateWest				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t 西門",
	AllianceGateWestDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t 西門",
	AllianceGateEast				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t 東門",
	AllianceGateEastDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t 東門",
	-- Strands of the Ancients Gates emotes
	GreenEmeraldAttacked			= "碧翠之門遭到攻擊!",
	GreenEmeraldDestroyed			= "碧翠之門被摧毀!",
	BlueSapphireAttacked			= "藍晶之門遭到攻擊!",
	BlueSapphireDestroyed			= "藍晶之門被摧毀!",
	PurpleAmethystAttacked			= "紫晶之門遭到攻擊!",
	PurpleAmethystDestroyed			= "紫晶之門被摧毀!",
	RedSunAttacked					= "紅日之門遭到攻擊!",
	RedSunDestroyed					= "紅日之門被摧毀!",
	YellowMoonAttacked				= "黃月之門遭到攻擊!",
	YellowMoonDestroyed				= "黃月之門被摧毀!",
	ChamberAncientRelicsAttacked	= "聖物間遭受攻擊!",
	ChamberAncientRelicsDestroyed	= "聖物間已經被攻破了!泰坦聖物十分危急!",
	-- Isle of Conquest Gates CHAT_MSG_BG_SYSTEM_NEUTRAL messages
	HordeGateFrontDestroyedTC		= "部落要塞的正門已經被摧毀了!",
	HordeGateWestDestroyedTC		= "部落要塞的西門已經被摧毀了!",
	HordeGateEastDestroyedTC		= "部落要塞的東門已經被摧毀了!",
	AllianceGateFrontDestroyedTC	= "聯盟要塞的正門已經被摧毀了!",
	AllianceGateWestDestroyedTC		= "聯盟要塞的西門已經被摧毀了!",
	AllianceGateEastDestroyedTC		= "聯盟要塞的東門已經被摧毀了!",
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name		= "奧特蘭克山谷"
})

L:SetOptionLocalization({
	AutoTurnIn	= "自動繳交任務物品"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name				= "阿拉希盆地"
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name				= "暴風之眼"
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name				= "戰歌峽谷"
})

------------------------------
--  Strand of the Ancients  --
------------------------------
L = DBM:GetModLocalization("StrandoftheAncients")

L:SetGeneralLocalization({
	name = "遠祖灘頭"
})

------------------------
--  Isle of Conquest  --
------------------------

L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name				= "征服之島"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "攻城機具準備好了！",
	WarnSiegeEngineSoon	= "0秒後 攻城機具"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "攻城機具修復"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "為攻城機具的修復顯示計時器",
	WarnSiegeEngine		= "當攻城機具準備好時顯示警告",
	WarnSiegeEngineSoon	= "當攻城機具接近準備好時顯示警告"
})

L:SetMiscLocalization({
	SiegeEngine				= "攻城機具",
	GoblinStartAlliance		= "看到那些爆鹽炸彈了嗎?當我維修攻城機具的時候用它們來轟破大門！",
	GoblinStartHorde		= "修理攻城機具的工作就交給我，幫我看著點就夠了。如果你想要轟破大門的話，儘管把那些爆鹽炸彈拿去用吧！",
	GoblinHalfwayAlliance	= "我已經修好一半了!別讓部落靠近。工程學院可沒有教我們如何作戰喔！",
	GoblinHalfwayHorde		= "我已經修好一半了!別讓聯盟靠近 - 我的合約裡可沒有作戰這一條！",
	GoblinFinishedAlliance	= "我有史以來最得意的作品!這台攻城機具已經可以上場囉！",
	GoblinFinishedHorde		= "這台攻城機具已經可以上場啦！",
	GoblinBrokenAlliance	= "這麼快就壞啦?!別擔心，再壞的情況我都可以修得好。",
	GoblinBrokenHorde		= "又壞掉了嗎?!讓我來修理吧…但別指望產品的保固會幫你支付這一切。"
})
