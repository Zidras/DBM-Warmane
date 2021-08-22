if GetLocale() ~= "zhTW" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "北裂境巨獸"
}

L:SetWarningLocalization{
	WarningSnobold		= "極地狗頭人奴僕出現在>%s<"
}

L:SetTimerLocalization{
	TimerNextBoss		= "下一隻王到來",
	TimerEmerge			= "持續鑽地",
	TimerSubmerge		= "下一次鑽地"
}

L:SetOptionLocalization{
	WarningSnobold		= "為極地狗頭人奴僕出現顯示警告",
	PingCharge			= "當冰嚎即將衝鋒你時自動點擊小地圖",
	ClearIconsOnIceHowl	= "衝鋒前消除所有標記",
	TimerNextBoss		= "為下一隻王到來顯示計時器",
	TimerEmerge			= "為持續鑽地顯示計時器",
	TimerSubmerge		= "為下一次鑽地顯示計時器",
	IcehowlArrow		= "當冰嚎即將衝鋒在你附近時顯示DBM箭頭"
}

L:SetMiscLocalization{
	Charge				= "%%s怒視著(%S+)，並發出震耳的咆哮!",
	CombatStart			= "來自風暴群山最深邃，最黑暗的洞穴。歡迎『穿刺者』戈莫克!戰鬥吧，英雄們!",
	Phase2				= "準備面對酸喉和懼鱗的雙重夢魘吧，英雄們，快就定位!",
	Phase3				= "下一場參賽者的出場連空氣都會為之凝結:冰嚎!戰個你死我活吧，勇士們!",
	Gormok				= "『穿刺者』戈莫克",
	Acidmaw				= "酸喉",
	Dreadscale			= "懼鱗",
	Icehowl				= "冰嚎"
}

---------------------
--  Lord Jaraxxus  --
---------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "賈拉克瑟斯領主"
}

L:SetOptionLocalization{
	IncinerateShieldFrame	= "在首領血量裡顯示焚化血肉的血量"
}

L:SetMiscLocalization{
	IncinerateTarget		= "焚化血肉: %s",
	FirstPull				= "大術士威爾弗雷德·菲斯巴恩將會召喚你們的下一個挑戰者。等待他的登場吧。"
}

-------------------------
--  Faction Champions  --
-------------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "陣營勇士"
}

L:SetMiscLocalization{
	--Horde NPCs
	Gorgrim				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:32:64:64:96|t 高葛林·影斬",		-- 34458
	Birana				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:95:126.5:0:32|t 碧菈娜·風暴之蹄",	-- 34451
	Erin				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:95:126.5:0:32|t 艾琳·霧蹄",		-- 34459
	Rujkah				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:0:32:32:64|t 茹卡",				-- 34448
	Ginselle			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:32:63.5:0:32|t 金賽兒·凋擲",		-- 34449
	Liandra				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:0:32:64:96|t 黎安卓·喚日",			-- 34445
	Malithas			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:0:32:64:96|t 瑪力薩·亮刃",			-- 34456
	Caiphus				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:63.5:95:32:64|t 嚴厲的凱普司",		-- 34447
	Vivienne			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:63.5:95:32:64|t 薇薇安·黑語",		-- 34441
	Mazdinah			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:63.5:95:0:32|t 馬茲迪娜",			-- 34454
	Thrakgar			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:32:63.5:32:64|t 瑟瑞克加爾",		-- 34444
	Broln				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:32:63.5:32:64|t 伯洛連·頑角",		-- 34455
	Harkzog				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:95:126.5:32:64|t 哈克佐格",		-- 34450
	Narrhok				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:0:32:0:32|t 納霍克·破鋼者",		-- 34453
	--Alliance NPCs
	Tyrius				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:32:64:64:96|t 提瑞斯·暮刃",		-- 34461
	Kavina				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:95:126.5:0:32|t 卡薇娜·林地之歌",	-- 34460
	Melador				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:95:126.5:0:32|t 梅拉朵·谷行者",	-- 34469
	Alyssia             = "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:0:32:32:64|t 愛莉希雅·月巡者",		-- 34467
	Noozle				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:32:63.5:0:32|t 諾佐·嘯棍",			-- 34468
	Baelnor				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:0:32:64:96|t 貝爾諾·攜光者",		-- 34471
	Velanaa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:0:32:64:96|t 維蘭娜",				-- 34465
	Anthar				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:63.5:95:32:64|t 安薩·修爐匠",		-- 34466
	Brienna				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:63.5:95:32:64|t 布芮娜·夜墜",		-- 34473
	Irieth				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:63.5:95:0:32|t 艾芮絲·影步",		-- 34472
	Saamul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:32:63.5:32:64|t 薩繆爾",			-- 34470
	Shaabad				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:32:63.5:32:64|t 夏巴德",			-- 34463
	Serissa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:95:126.5:32:64|t 瑟芮莎·厲濺",		-- 34474
	Shocuul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:36:36:0:0:128:128:0:32:0:32|t 修庫爾",				-- 34475

	AllianceVictory		= "榮耀歸於聯盟!",
	HordeVictory		= "那只是讓你們知道將來必須面對的命運。為了部落!"
	--YellKill			= "膚淺而悲痛的勝利。今天痛失的生命反而令我們更加的頹弱。除了巫妖王之外，誰還能從中獲利?偉大的戰士失去了寶貴生命。為了什麼?真正的威脅就在前方 - 巫妖王在死亡的領域中等著我們。"
}

---------------------
--  Val'kyr Twins  --
---------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "華爾琪雙子"
}

L:SetTimerLocalization{
	TimerSpecialSpell		= "下一次特別技能",
	TimerAnubRoleplay		= "樓斷裂處"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon	= "特別技能即將到來",
	SpecWarnSpecial			= "快變換顏色",
	SpecWarnSwitchTarget	= "快換目標打雙子契印",
	SpecWarnKickNow			= "現在斷法",
	WarningTouchDebuff		= "光明或黑暗之觸:>%s<",
	WarningPoweroftheTwins2	= "雙子威能 - 對>%s<加大治療"
}

L:SetMiscLocalization{
	--YellPull				= "以我們的黑暗君王之名。為了巫妖王。你‧得‧死。",
	CombatStart				= "唯有同心協力，你們才能克服最後的難關。來自寒冰皇冠的深處，兩名天譴軍團最強大的副官:令人生畏的華爾琪，披著羽翼的巫妖王先驅。",
	Fjola					= "菲歐拉·光寂",
	Eydis					= "艾狄絲·暗寂",
	AnubRP					= "巫妖王遭受了迎頭痛擊!你們已經證明了你們是銀白十字軍的精銳勇士。我們將聯手攻陷冰冠城塞，並且把天譴軍團消滅殆盡!團結一心，我們將可破除所有難關。"
}

L:SetOptionLocalization{
	TimerSpecialSpell		= "為下一次特別技能顯示計時器",
	TimerAnubRoleplay		= "計時條：劇情持續時間",
	WarnSpecialSpellSoon	= "為下一次特別技能顯示預先警告",
	SpecWarnSpecial			= "當你需要變換顏色時顯示特別警告",
	SpecWarnSwitchTarget	= "當另一個首領施放雙子契印時顯示特別警告",
	SpecWarnKickNow			= "當你可以斷法時顯示特別警告",
	SpecialWarnOnDebuff		= "當你中了光明或黑暗之觸時顯示特別警告 (需切換顏色)",
	SetIconOnDebuffTarget	= "為光明或黑暗之觸的目標設置標記 (英雄模式)",
	WarningTouchDebuff		= "提示光明或黑暗之觸的目標",
	WarningPoweroftheTwins2	= "提示雙子威能的目標"
}

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 				= "阿努巴拉克"
}

L:SetTimerLocalization{
	TimerEmerge			= "下一次現身",
	TimerSubmerge		= "下一次鑽地",
	timerAdds			= "下一次中蟲出現"
}

L:SetWarningLocalization{
	WarnEmerge				= "阿努巴拉克現身了",
	WarnEmergeSoon			= "10秒後現身",
	WarnSubmerge			= "阿努巴拉克鑽進地裡了",
	WarnSubmergeSoon		= "10秒後鑽進地裡",
	warnAdds				= "奈幽掘洞者 出現了"
}

L:SetMiscLocalization{
--	YellPull			= "這裡將會是你們的墳墓!",
	Emerge				= "從地底鑽出!",
	Burrow				= "鑽進地裡!",
	PcoldIconSet		= "透骨之寒{rt%d}於%s",
	PcoldIconRemoved	= "移除標記:%s"
}

L:SetOptionLocalization{
	WarnEmerge				= "為鑽出地面顯示警告",
	WarnEmergeSoon			= "為鑽出地面顯示預先警告",
	WarnSubmerge			= "為鑽進地裡顯示警告",
	WarnSubmergeSoon		= "為鑽進地裡顯示預先警告",
	warnAdds				= "提示奈幽掘洞者出現",
	timerAdds				= "為下一次 奈幽掘洞者出現顯示計時器",
	TimerEmerge				= "為持續鑽地顯示計時器",
	TimerSubmerge			= "為下一次 鑽地顯示計時器",
	AnnouncePColdIcons		= "公佈$spell:68510目標設置的標記到團隊頻道<br/>(需要團隊隊長或助理權限)",
	AnnouncePColdIconsRemoved	= "當移除$spell:68510的標記時也提示<br/>(需要上述選項)",
	RemoveHealthBuffsInP3	= "當進入第3階段時移除耐力的增益"
}
