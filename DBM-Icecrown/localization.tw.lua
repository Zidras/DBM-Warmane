if GetLocale() ~= "zhTW" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "城塞大門小怪"
}

L:SetWarningLocalization{
	SpecWarnTrap		= "觸發陷阱! - 亡縛守衛被釋放了"
}

L:SetOptionLocalization{
	SpecWarnTrap			= "當觸發陷阱時顯示特別警告",
	SetIconOnDarkReckoning	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
}

L:SetMiscLocalization{
	WarderTrap1		= "誰…在那兒…?",
	WarderTrap2		= "我…甦醒了!",
	WarderTrap3		= "主人的聖所受到了打擾!"
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "大寶及臭皮"
}

L:SetWarningLocalization{
	WarnMortalWound	= "%s: >%s< (%s)",
	SpecWarnTrap	= "觸發陷阱! - 復仇的血肉收割者 到來"
}

L:SetOptionLocalization{
	SpecWarnTrap	= "當觸發陷阱時顯示特別警告",
	WarnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
}

L:SetMiscLocalization{
	FleshreaperTrap1		= "快，我們要從後面奇襲他們!",
	FleshreaperTrap2		= "你無法逃避我們!",
	FleshreaperTrap3		= "The living? Here?!"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name = "赤紅大廳小怪"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

---------------------------
--  Trash - Frostwing Hall  --
---------------------------
L = DBM:GetModLocalization("FrostwingHallTrash")

L:SetGeneralLocalization{
	name = "霜翼大廳小怪"
}

L:SetWarningLocalization{
	SpecWarnGosaEvent	= "辛德拉苟莎夾道攻擊開始!"
}

L:SetTimerLocalization{
	GosaTimer			= "時間剩餘"
}

L:SetOptionLocalization{
	SpecWarnGosaEvent	= "為辛德拉苟莎夾道攻擊顯示特別提示",
	GosaTimer			= "為辛德拉苟莎夾道攻擊顯示持續時間計時器"
}

L:SetMiscLocalization{
	SindragosaEvent		= "你們不能靠近冰霜之后。快，阻止他們!"
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "瑪洛嘉領主"
}

L:SetTimerLocalization{
	TimerBoneSpikeUp	= "Spikes up in...", --Needs Translating
	TimerWhirlwindStart	= "Whirlwind starts in..." --Needs Translating
}

L:SetOptionLocalization{
	SetIconOnImpale		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "亡語女士"
}

L:SetTimerLocalization{
	TimerAdds	= "新的小怪"
}

L:SetWarningLocalization{
	WarnReanimating				= "小怪再活化",
	WarnAddsSoon				= "新的小怪 即將到來",
	SpecWarnVengefulShade		= "你被復仇的暗影盯上了 - 快跑開",
	WeaponsStatus				= "Auto Unequipping enabled" --Needs Translating
}

L:SetOptionLocalization{
	WarnAddsSoon				= "為新的小怪出現顯示預先警告",
	WarnReanimating				= "當小怪再活化時顯示警告",
	TimerAdds					= "為新的小怪顯示計時器",
	SpecWarnVengefulShade		= "當你被復仇的暗影盯上時顯示特別警告",
	WeaponsStatus				= "Special warning at combat start if unequip/equip function is enabled", --Needs Translating
	ShieldHealthFrame			= "為$spell:70842顯示首領血量框架",
	SetIconOnDominateMind		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901),
	SoundWarnCountingMC			= "Play a 5 second audio countdown for Mind Control", --Needs Translating
	RemoveDruidBuff				= "Remove MotW / GotW 24 seconds into the fight", --Needs Translating
	EqUneqWeapons				= "Unequip/equip weapons if MC is cast on you. For equipping to work, create an equipment set called 'pve'.", --Needs Translating
	EqUneqTimer					= "Remove weapons by timer ALWAYS, not on cast (if ping is high). The option above must be enabled.", --Needs Translating
	BlockWeapons				= "Completely block the unequip/equip functions above" --Needs Translating
}

L:SetMiscLocalization{
	YellReanimatedFanatic	= "起來，在純粹的形態中感受狂喜!",
	ShieldPercent			= "法力屏障",
	Fanatic1				= "神教狂熱者",
	Fanatic2				= "畸形的狂熱者",
	Fanatic3				= "再活化的狂熱者",
	setMissing				= "ATTENTION! DBM automatic weapon unequipping/equipping will not work until you create a equipment set named pve" --Needs Translating
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "砲艇戰"
}

L:SetWarningLocalization{
	WarnAddsSoon	= "新的小怪 即將到來"
}

L:SetOptionLocalization{
	WarnAddsSoon		= "為新的小怪出現顯示預先警告",
	TimerAdds			= "為新的小怪顯示計時器"
}

L:SetTimerLocalization{
	TimerAdds			= "新的小怪"
}

L:SetMiscLocalization{
	PullAlliance	= "發動引擎!小夥子們，我們即將面對命運啦!",
	PullHorde		= "起來吧，部落的子女!今天我們要和最可恨的敵人作戰!為了部落!",
	AddsAlliance	= "劫奪者，士官們，攻擊!",
	AddsHorde		= "海員們，士官們，攻擊!",
	KillAlliance	= "別說我沒警告過你，無賴!兄弟姊妹們，向前衝!",
	KillHorde		= "聯盟已經動搖了。向巫妖王前進!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name 				= "死亡使者薩魯法爾"
}

L:SetOptionLocalization{
	BoilingBloodIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	RangeFrame			= "顯示距離框 (12碼)",
	RunePowerFrame		= "顯示首領血量及$spell:72371條"
}

L:SetMiscLocalization{
	RunePower			= "血魄威能",
	PullAlliance		= "每個你殺死的部落士兵 -- 每條死去的聯盟狗，都讓巫妖王的軍隊隨之增長。此時此刻華爾琪都還在把你們倒下的同伴復活成天譴軍。",
	PullHorde			= "柯爾克隆，前進!勇士們，要當心，天譴軍團已經……"
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "膿腸"
}

L:SetOptionLocalization{
	RangeFrame			= "顯示距離框 (8碼)",
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279),
	AnnounceSporeIcons	= "公佈$spell:69279目標設置的標記到團隊頻道\n(需開啟團隊廣播及助理權限)",
	AchievementCheck	= "公佈 '流感疫苗短缺' 成就失敗到團隊頻道\n(需助理權限)"
}

L:SetMiscLocalization{
	SporeSet			= "氣體孢子{rt%d}: %s",
	AchievementFailed	= ">> 成就失敗: %s中了%d層孢子 <<"
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "腐臉"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "小軟泥怪 出現了",
	SpecWarnLittleOoze			= "你被小軟泥怪盯上了 - 快跑開"
}

L:SetOptionLocalization{
	WarnOozeSpawn				= "為小軟泥的出現顯示警告",
	SpecWarnLittleOoze			= "當你被小軟泥怪盯上時顯示特別警告",
	RangeFrame					= "顯示距離框 (8碼)",
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	TankArrow					= "為大軟泥怪副坦顯示DBM箭頭 (測試中)"
}

L:SetMiscLocalization{
	YellSlimePipes1	= "大夥聽著，好消息!我修好了劇毒軟泥管!",
	YellSlimePipes2	= "大夥聽著，超級好消息!軟泥又開始流動了!"
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "普崔希德教授"
}

L:SetOptionLocalization{
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72856),
	MalleableGooIcon			= "為第一個中$spell:72295的目標設置標記",
	GooArrow					= "當你附近的人中了$spell:72295時顯示DBM箭頭"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "血親王議會"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "轉換目標到: %s",
	WarnTargetSwitchSoon	= "轉換目標 即將到來"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "轉換目標"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "為轉換目標顯示警告",
	WarnTargetSwitchSoon	= "為轉換目標顯示預先警告",
	TimerTargetSwitch		= "為轉換目標顯示冷卻計時器",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "設置標記在強力的親王身上 (頭顱)",
	RangeFrame				= "顯示距離框 (12碼)",
	VortexArrow				= "當你附近的人中了$spell:72037時顯示DBM箭頭"
}

L:SetMiscLocalization{
	Keleseth			= "凱雷希斯親王",
	Taldaram			= "泰爾達朗親王",
	Valanar				= "瓦拉納爾親王",
	--FirstPull			= "Foolish mortals. You thought us defeated so easily? The San'layn are the Lich King's immortal soldiers! Now you shall face their might combined!", -- Needs Translating
	EmpoweredFlames		= "煉獄烈焰加速靠近(%S+)!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "血腥女王菈娜薩爾"
}

L:SetOptionLocalization{
	SetIconOnDarkFallen		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838),
	RangeFrame				= "顯示距離框 (8碼)"
}

L:SetMiscLocalization{
	SwarmingShadows			= "暗影聚集並旋繞在(%S+)四周!",
	YellFrenzy				= "我餓了!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "瓦莉絲瑞雅·夢行者"
}

L:SetWarningLocalization{
	WarnCorrosion	= "%s: >%s< (%d)",
	WarnPortalOpen	= "傳送門開啟"
}

L:SetTimerLocalization{
	TimerPortalsOpen			= "傳送門開啟",
	TimerPortalsClose			= "Portals close", --Needs Translating
	TimerBlazingSkeleton		= "下一次 熾熱骷髏",
	TimerAbom					= "下一次 憎惡體?",
	TimerSuppresserOne			= "1st wave of Suppressers", --Needs Translating
	TimerSuppresserTwo			= "2nd wave of Suppressers", --Needs Translating
	TimerSuppresserThree		= "3rd wave of Suppressers", --Needs Translating
	TimerSuppresserFour			= "4th wave of Suppressers" --Needs Translating
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "為熾熱骷髏設置標記 (頭顱)",
	WarnPortalOpen			= "當夢魘之門開啟時顯示警告",
	TimerPortalsOpen		= "當夢魘之門開啟時顯示計時器",
	TimerPortalsClose			= "Show timer when Nightmare Portals are closed", --Needs Translating
	TimerBlazingSkeleton		= "為下一次熾熱骷髏出現顯示計時器",
	TimerAbom			= "為下一次貪吃的憎惡體出現顯示計時器 (測試中)",
	Suppressers					= "Show special warning for new Suppressers", --Needs Translating
	TimerSuppresserOne			= "1st wave of Suppressers", --Needs Translating
	TimerSuppresserTwo			= "2nd wave of Suppressers", --Needs Translating
	TimerSuppresserThree		= "3rd wave of Suppressers", --Needs Translating
	TimerSuppresserFour			= "4th wave of Suppressers" --Needs Translating
}

L:SetMiscLocalization{
	YellPull		= "入侵者已經突破了內部聖所。加快摧毀綠龍的速度!只要留下骨頭和肌腱來復活!",
	YellPortals		= "我打開了一道傳送門通往夢境。你們的救贖就在其中，英雄們……"
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "辛德拉苟莎"
}

L:SetWarningLocalization{
	WarnAirphase			= "空中階段",
	WarnGroundphaseSoon		= "辛德拉苟莎 即將著陸"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "下一次 空中階段",
	TimerNextGroundphase	= "下一次 地上階段",
	AchievementMystic		= "清除秘能連擊疊加"
}

L:SetOptionLocalization{
	WarnAirphase				= "提示空中階段",
	WarnGroundphaseSoon			= "為地上階段顯示預先警告",
	TimerNextAirphase			= "為下一次 空中階段顯示計時器",
	TimerNextGroundphase		= "為下一次 地上階段顯示計時器",
	AnnounceFrostBeaconIcons	= "公佈$spell:70126目標設置的標記到團隊頻道\n(需開啟團隊廣播及助理權限)",
	SetIconOnFrostBeacon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase		= "空中階段前清除所有標記",
	AchievementCheck			= "公佈 '吃到飽' 成就警告到團隊頻道\n(需助理權限)",
	RangeFrame					= "顯示距離框 (普通10碼, 困難20碼)"
}

L:SetMiscLocalization{
	YellAirphase		= "你們的入侵將在此終止!誰也別想存活!",
	YellPhase2			= "現在，絕望地感受我主無限的力量吧!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "冰霜信標{rt%d}: %s",
	AchievementWarning	= "警告: %s中了5層秘能連擊",
	AchievementFailed	= ">> 成就失敗: %s中了%d層秘能連擊 <<"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "巫妖王"
}

L:SetWarningLocalization{
	ValkyrWarning			= ">%s< 給抓住了!",
	SpecWarnYouAreValkd		= "你給抓住了",
	WarnNecroticPlagueJump	= "亡域瘟疫跳到>%s<身上",
	SpecWarnValkyrLow		= "華爾琪血量低於55%"
}

L:SetTimerLocalization{
	TimerRoleplay				= "角色扮演",
	PhaseTransition				= "轉換階段",
	TimerNecroticPlagueCleanse	= "淨化亡域瘟疫"
}

L:SetOptionLocalization{
	TimerRoleplay				= "為角色扮演事件顯示計時器",
	WarnNecroticPlagueJump		= "提示$spell:73912跳躍後的目標",
	TimerNecroticPlagueCleanse	= "為淨化第一次堆疊前的亡域瘟疫顯示計時器",
	PhaseTransition				= "為轉換階段顯示計時器",
	ValkyrWarning				= "提示誰給華爾琪影衛抓住了",
	SpecWarnYouAreValkd			= "當你給華爾琪影衛抓住時顯示特別警告",
	DefileIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	NecroticPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912),
	RagingSpiritIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	HarvestSoulIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74327),
	TrapArrow					= "當你附近的人中了$spell:73539時顯示DBM箭頭",
	AnnounceValkGrabs			= "提示誰被華爾琪影衛抓住到團隊頻道\n(需開啟團隊廣播及助理權限)",
	SpecWarnValkyrLow			= "當華爾琪血量低於55%時顯示特別警告",
	AnnouncePlagueStack			= "提示$spell:73912層數到團隊頻道 (10層, 10層後每5層提示一次)\n(需開啟助理權限)",
	ShowFrame					= "Show Val'Kyr Targets frame", --Needs Translating
	FrameClassColor				= "Use Class Colors in Val'Kyr Targets frame", --Needs Translating
	FrameUpwards				= "Expand Val'Kyr target frame upwards", --Needs Translating
	FrameLocked					= "Lock Val'Kyr Targets frame", --Needs Translating
	RemoveImmunes				= "Remove immunity spells before exiting Frostmourne room" --Needs Translating
}

L:SetMiscLocalization{
	LKPull					= "聖光所謂的正義終於來了嗎？我是否該把霜之哀傷放下，祈求你的寬恕呢，弗丁？",
	LKRoleplay				= "你們的原動力真的是正義感嗎？我很懷疑……",
	ValkGrabbedIcon			= "華爾琪影衛{rt%d}抓住了 %s",
	ValkGrabbed				= "華爾琪影衛抓住了 %s",
	PlagueStackWarning		= "警告: %s中了%d層亡域瘟疫",
	AchievementCompleted	= ">> 成就成功: %s中了%d層亡域瘟疫 <<",
	FrameTitle				= "Valkyr targets",
	FrameLock				= "Frame Lock",
	FrameClassColor			= "Use Class Colors",
	FrameOrientation		= "Expand upwards",
	FrameHide				= "Hide Frame",
	FrameClose				= "Close"
}
