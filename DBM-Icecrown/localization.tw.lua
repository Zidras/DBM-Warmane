if GetLocale() ~= "zhTW" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "瑪洛嘉領主"
})

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization({
	name = "亡語女士"
})

L:SetTimerLocalization({
	TimerAdds	= "新的小怪"
})

L:SetWarningLocalization({
	WarnReanimating				= "小怪再活化",
	WarnAddsSoon				= "新的小怪即將到來",
	SpecWarnVengefulShade		= "你被復仇的暗影盯上了 - 快跑開",
	WeaponsStatus				= "自動武器卸載/裝備已啟用: %s (%s - %s)"
})

L:SetOptionLocalization({
	WarnAddsSoon				= "為新的小怪出現顯示預先警告",
	WarnReanimating				= "當小怪再活化時顯示警告",
	TimerAdds					= "為新的小怪顯示計時器",
	SpecWarnVengefulShade		= "當你被復仇的暗影盯上時顯示特別警告",
	WeaponsStatus				= "戰鬥開始時提示自動武器卸載/裝備功能已啟用",
	ShieldHealthFrame			= "為$spell:70842顯示首領血量框架",
--	RemoveDruidBuff				= "戰鬥開始24秒後自動移除野性印記/野性賜福",
	RemoveBuffsOnMC				= "當 $spell:71289 對你施放時移除增益。每個選項都是累積的。",
	Gift						= "移除 $spell:48469 / $spell:48470。防止 $spell:33786 抵抗的最小方法。",
	CCFree						= "+ 移除 $spell:48169 / $spell:48170。說明影子學派的法術抗性。",
	ShortOffensiveProcs			= "+ 移除持續時間較短的攻擊性觸發。推薦用於團隊安全而不影響團隊傷害輸出。",
	MostOffensiveBuffs			= "+ 移除大部分攻擊性增益（主要針對施法者和 |cFFFF7C0A野性戰鬥德魯伊|r）。最大的團隊安全性，損失輸出並需要自我反擊/變形！",
	EqUneqWeapons				= "當支配心智對你施放時，自動卸載當前武器並再結束後重新裝備。若要讓自動裝備成功運作，請使用裝備管理員功能創建一個名為\"pve\"的全套含武器裝備集",
	EqUneqTimer					= "永遠依據計時器移除武器，而非當首領唱法時。(假如延遲很高的話)強烈建議將此選項勾選"
})

L:SetMiscLocalization({
	YellReanimatedFanatic	= "起來，在純粹的形態中感受狂喜!",
	ShieldPercent			= "法力屏障",
--	Fanatic1				= "神教狂熱者",
--	Fanatic2				= "畸形的狂熱者",
--	Fanatic3				= "再活化的狂熱者",
	setMissing				= "注意力！ 在您創建名為 pve 的裝備集之前，DBM 自動武器卸載/裝備將不起作用，pve裝備集為全套裝備及武器",
	EqUneqLineDescription	= "自動裝備/取消裝備"
})

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization({
	name = "寒冰皇冠空中艦艇戰"
})

L:SetWarningLocalization({
	WarnAddsSoon	= "新的小怪即將到來"
})

L:SetOptionLocalization({
	WarnAddsSoon		= "為新的小怪出現顯示預先警告",
	TimerAdds			= "為新的小怪顯示計時器"
})

L:SetTimerLocalization({
	TimerAdds			= "新的小怪"
})

L:SetMiscLocalization({
	PullAlliance	= "發動引擎!小夥子們，我們即將面對命運啦!",
	PullHorde		= "起來吧，部落的子女!今天我們要和最可恨的敵人作戰!為了部落!",
	AddsAlliance	= "劫奪者，士官們，攻擊!",
	AddsHorde		= "海員們，士官們，攻擊!",
	MageAlliance	= "船體受到傷害，找個戰鬥法師來，搞定那些火砲!",
	MageHorde		= "船體受損，找個巫士到這裡來，搞定那些火砲!",
	KillAlliance	= "別說我沒警告過你，無賴!兄弟姊妹們，向前衝!",
	KillHorde		= "聯盟已經動搖了。向巫妖王前進!"
})

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization({
	name				= "死亡使者薩魯法爾"
})

L:SetOptionLocalization({
	RunePowerFrame		= "顯示首領血量及$spell:72371條",
--	RemoveDI			= "清除 $spell:19752 如果用於防止 $spell:72293"
})

L:SetMiscLocalization({
	RunePower			= "血魄威能",
	PullAlliance		= "每個你殺死的部落士兵 -- 每條死去的聯盟狗，都讓巫妖王的軍隊隨之增長。此時此刻華爾琪都還在把你們倒下的同伴復活成天譴軍。",
	PullHorde			= "柯爾克隆，前進!勇士們，要當心，天譴軍團已經..."
})

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "膿腸"
})

L:SetOptionLocalization({
	AnnounceSporeIcons	= "公佈$spell:69279目標設置的標記到團隊頻道<br/>(需要團隊隊長)",
	AchievementCheck	= "公佈 '流感疫苗短缺' 成就失敗到團隊頻道<br/>(需助理權限)"
})

L:SetMiscLocalization({
	SporeSet			= "氣體孢子{rt%d}: %s",
	AchievementFailed	= ">> 成就失敗: %s中了%d層孢子 <<"
})

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization({
	name = "腐臉"
})

L:SetWarningLocalization({
	WarnOozeSpawn				= "小軟泥怪出現了",
	SpecWarnLittleOoze			= "你被小軟泥怪盯上了 - 快跑開"
})

L:SetOptionLocalization({
	WarnOozeSpawn				= "為小軟泥的出現顯示警告",
	SpecWarnLittleOoze			= "當你被小軟泥怪盯上時顯示特別警告",
	TankArrow					= "為大軟泥怪副坦顯示DBM箭頭 (測試中)"
})

L:SetMiscLocalization({
	YellSlimePipes1	= "大夥聽著，好消息!我修好了劇毒軟泥管!",
	YellSlimePipes2	= "大夥聽著，超級好消息!軟泥又開始流動了!"
})

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization({
	name = "普崔希德教授"
})

L:SetWarningLocalization({
	WarnReengage			= "%s: 重新加入"
})

L:SetTimerLocalization({
	TimerReengage			= "重新加入"
})

--[[L:SetOptionLocalization({
	WarnReengage			= "Show warning for Boss re-engage", -- needs localization
	TimerReengage			= "Show timer for Boss re-engage" -- needs localization
})]]

L:SetMiscLocalization({
	YellTransform1			= "嗯，我看不出來有何不同。啊?!這些東西從哪來的?",
	YellTransform2			= "嚐起來像是...櫻桃!喔!抱歉!"
})

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization({
	name = "血親王議會"
})

L:SetWarningLocalization({
	WarnTargetSwitch		= "轉換目標到: %s",
	WarnTargetSwitchSoon	= "轉換目標即將到來"
})

L:SetTimerLocalization({
	TimerTargetSwitch		= "轉換目標"
})

L:SetOptionLocalization({
	WarnTargetSwitch		= "為轉換目標顯示警告",
	WarnTargetSwitchSoon	= "為轉換目標顯示預先警告",
	TimerTargetSwitch		= "為轉換目標顯示冷卻計時器",
	ActivePrinceIcon		= "設置標記在強化的親王身上(頭顱)",
	ShadowPrisonMetronome	= "播放重複的 1 秒點擊聲音以避免 $spell:72999"
})

L:SetMiscLocalization({
	Keleseth			= "凱雷希斯親王",
	Taldaram			= "泰爾達朗親王",
	Valanar				= "瓦拉納爾親王",
	FirstPull			= "愚蠢的凡人。你以為我們會如此輕易被擊敗?煞婪一族是巫妖王的永恆士兵!現在你將面對他們聯合的力量!",
	EmpoweredFlames		= "煉獄烈焰加速靠近(%S+)!"
})

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization({
	name = "血腥女王菈娜薩爾"
})

L:SetMiscLocalization({
	SwarmingShadows			= "暗影聚集並旋繞在(%S+)四周!",
	YellFrenzy				= "我餓了!"
})

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization({
	name = "瓦莉絲瑞雅·夢行者"
})

L:SetWarningLocalization({
	WarnPortalOpen	= "傳送門開啟"
})

L:SetTimerLocalization({
	TimerPortalsOpen			= "傳送門開啟",
	TimerPortalsClose			= "傳送門關閉",
	TimerBlazingSkeleton		= "下一次 熾熱骷髏",
	TimerAbom					= "下一次 憎惡體 (%s)"
})

L:SetOptionLocalization({
	WarnPortalOpen				= "當夢魘之門開啟時顯示警告",
	TimerPortalsOpen			= "當夢魘之門開啟時顯示計時器",
	TimerPortalsClose			= "顯示夢魘之門從場上關閉前的計時器",
	TimerBlazingSkeleton		= "為下一次熾熱骷髏出現顯示計時器"
})

L:SetMiscLocalization({
	YellPull		= "入侵者已經突破了內部聖所。加快摧毀綠龍的速度!只要留下骨頭和肌腱來復活!",
	YellPortals		= "我打開了一道傳送門通往夢境。你們的救贖就在其中，英雄們..."
})

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization({
	name = "辛德拉苟莎"
})

L:SetWarningLocalization({
	WarnAirphase			= "空中階段",
	WarnGroundphaseSoon		= "辛德拉苟莎 即將著陸"
})

L:SetTimerLocalization({
	TimerNextAirphase		= "下一次空中階段",
	TimerNextGroundphase	= "下一次地上階段",
	AchievementMystic		= "清除秘能連擊疊加"
})

L:SetOptionLocalization({
	WarnAirphase				= "提示空中階段",
	WarnGroundphaseSoon			= "為地上階段顯示預先警告",
	TimerNextAirphase			= "為下一次 空中階段顯示計時器",
	TimerNextGroundphase		= "為下一次 地上階段顯示計時器",
	AnnounceFrostBeaconIcons	= "公佈$spell:70126目標設置的標記到團隊頻道<br/>(需要團隊隊長)",
	ClearIconsOnAirphase		= "空中階段前清除所有標記",
	AssignWarnDirectionsCount	= "为 $spell:70126 目标分配方向并指望第二阶段",
	AchievementCheck			= "公佈 '吃到飽' 成就警告到團隊頻道<br/>(需助理權限)",
	RangeFrame					= "根據最後首領使用的技能跟玩家減益顯示動態距離框(10/20碼)"
})

L:SetMiscLocalization({
	YellAirphase		= "你們的入侵將在此終止!誰也別想存活!",
	YellPhase2			= "現在，絕望地感受我主無限的力量吧!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "冰霜信標{rt%d}: %s",
	AchievementWarning	= "警告: %s中了5層秘能連擊",
	AchievementFailed	= ">> 成就失敗: %s中了%d層秘能連擊 <<"
})

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization({
	name = "巫妖王"
})

L:SetWarningLocalization({
	ValkyrWarning			= "%s >%s< %s 給抓住了!",
	SpecWarnYouAreValkd		= "你給抓住了",
	WarnNecroticPlagueJump	= "亡域瘟疫跳到>%s<身上",
	SpecWarnValkyrLow		= "華爾琪血量低於55%"
})

L:SetTimerLocalization({
	TimerRoleplay				= "角色扮演",
	PhaseTransition				= "轉換階段",
	TimerNecroticPlagueCleanse	= "淨化亡域瘟疫"
})

L:SetOptionLocalization({
	TimerRoleplay				= "為角色扮演事件顯示計時器",
	WarnNecroticPlagueJump		= "提示$spell:73912跳躍後的目標",
	TimerNecroticPlagueCleanse	= "為淨化第一次堆疊前的亡域瘟疫顯示計時器",
	PhaseTransition				= "為轉換階段顯示計時器",
	ValkyrWarning				= "提示誰給華爾琪影衛抓住了",
	SpecWarnYouAreValkd			= "當你給華爾琪影衛抓住時顯示特別警告",
	AnnounceValkGrabs			= "提示誰被華爾琪影衛抓住到團隊頻道<br/>(需開啟團隊廣播及助理權限)",
	SpecWarnValkyrLow			= "當華爾琪血量低於55%時顯示特別警告",
	AnnouncePlagueStack			= "提示$spell:73912層數到團隊頻道 (10層, 10層後每5層提示一次)<br/>(需開啟助理權限)",
	ShowFrame					= "顯示華爾琪目標框架",
	FrameClassColor				= "在華爾琪目標框架中顯示職業顏色",
	FrameUpwards				= "使華爾琪目標框架向上延伸而非向下顯示",
	FrameLocked					= "鎖定華爾琪目標框架",
	RemoveImmunes				= "離開霜之哀傷前自動移除無敵技能"
})

L:SetMiscLocalization({
	LKPull					= "聖光所謂的正義終於來了嗎?我是否該把霜之哀傷放下，祈求你的寬恕呢，弗丁?",
	LKRoleplay				= "你們的原動力真的是正義感嗎?我很懷疑...",
	ValkGrabbedIcon			= "華爾琪影衛{rt%d}抓住了%s",
	ValkGrabbed				= "華爾琪影衛抓住了%s",
	PlagueStackWarning		= "警告: %s中了%d層亡域瘟疫",
	AchievementCompleted	= ">> 成就成功: %s中了%d層亡域瘟疫 <<",
	FrameTitle				= "華爾琪鎖定目標",
	FrameLock				= "框架鎖定",
	FrameClassColor			= "使用職業顏色",
	FrameOrientation		= "向上延伸",
	FrameHide				= "隱藏框架",
	FrameClose				= "關閉",
	FrameGUIDesc			= "華爾琪框架",
	FrameGUIMoveMe			= "移動華爾琪框架"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ICCTrash")

L:SetGeneralLocalization({
	name = "冰冠城塞小怪"
})

L:SetWarningLocalization({
	SpecWarnTrapL		= "觸發陷阱! - 亡縛守衛被釋放了",
	SpecWarnTrapP		= "觸發陷阱! - 復仇的血肉收割者到來",
	SpecWarnGosaEvent	= "辛德拉苟莎夾道攻擊開始!"
})

L:SetOptionLocalization({
	SpecWarnTrapL		= "當觸發陷阱時顯示特別警告",
	SpecWarnTrapP		= "當觸發陷阱時顯示特別警告",
	SpecWarnGosaEvent	= "為辛德拉苟莎夾道攻擊顯示特別警告"
})

L:SetMiscLocalization({
	WarderTrap1			= "誰...在那兒...?",
	WarderTrap2			= "我...甦醒了!",
	WarderTrap3			= "主人的聖所受到了打擾!",
	FleshreaperTrap1	= "快，我們要從後面奇襲他們!",
	FleshreaperTrap2	= "你無法逃避我們!",
	FleshreaperTrap3	= "生人...在此?",
	SindragosaEvent		= "你一定不能靠近冰霜之后。快，阻止他們!"
})
