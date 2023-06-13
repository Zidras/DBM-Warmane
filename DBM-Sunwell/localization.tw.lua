if GetLocale() ~= "zhTW" then return end
local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")

L:SetGeneralLocalization({
	name = "卡雷苟斯"
})

L:SetWarningLocalization({
	WarnPortal			= "第%s個傳送門:>%s<(第%d隊)",
	SpecWarnWildMagic	= "野性魔法:%s"
})

L:SetOptionLocalization({
	WarnPortal			= "為$spell:46021的目標顯示警告",
	SpecWarnWildMagic	= "為野性魔法顯示特別警告",
	ShowRespawn			= "顯示下一次首領重生計時器",
	ShowFrame			= "顯示鬼靈國度框架",
	FrameClassColor		= "在鬼靈國度框架使用職業顏色",
	FrameUpwards		= "向上延伸鬼靈國度框架",
	FrameLocked			= "鎖定鬼靈國度框架"
})

L:SetMiscLocalization({
	Demon				= "『墮落者』塞斯諾瓦",
	Heal				= "+100%治療",
	Haste				= "+100%施法時間",
	Hit					= "-50%命中機率",
	Crit				= "+100%爆擊傷害",
	Aggro				= "+100%仇恨值",
	Mana				= "-50%法術消耗",
	FrameTitle			= "鬼靈國度",
	FrameLock			= "鎖定框架",
	FrameClassColor		= "使用職業顏色",
	FrameOrientation	= "向上延伸",
	FrameHide			= "隱藏框架",
	FrameClose			= "關閉",
	FrameGUIMoveMe		= "移動"
})

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization({
	name = "布魯托魯斯"
})

L:SetOptionLocalization({
	RangeFrameActivation= "範圍框架激活",
	AlwaysOn			= "在遭遇開始時。忽略過濾器",
	OnDebuff			= "開啟減益。應用減益過濾器"
})

L:SetMiscLocalization({
	Pull			= "啊，更多待宰的小羊們!"
})

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization({
	name = "魔龍謎霧"
})

L:SetWarningLocalization({
	WarnPhase		= "%s階段"
})

L:SetTimerLocalization({
	TimerPhase		= "下一次%s階段"
})

L:SetOptionLocalization({
	WarnPhase		= "為下個階段顯示警告",
	TimerPhase		= "為下個階段顯示計時器"
})

L:SetMiscLocalization({
	Air				= "空中",
	Ground			= "地面",
	AirPhase		= "我比以前更強大了!",
	Breath			= "%s深深地吸了一口氣。"
})

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name = "埃雷達爾雙子"
})

L:SetMiscLocalization({
	Nova			= "莎珂蕾希對(.+)施放暗影新星。",
	Conflag			= "艾黎瑟絲對(.+)施放焚焰。",
	Sacrolash		= "莎珂蕾希女士",
	Alythess		= "大術士艾黎瑟絲"
})

------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization({
	name = "莫魯"
})

L:SetWarningLocalization({
	WarnHuman		= "人型小兵 (%d)",
	WarnVoid		= "虛無哨兵 (%d)",
	WarnFiend		= "黑暗惡魔出現了"
})

L:SetTimerLocalization({
	TimerHuman		= "人型小兵 (%s)",
	TimerVoid		= "虛無哨兵 (%s)",
	TimerPhase		= "安卓普斯"
})

L:SetOptionLocalization({
	WarnHuman		= "為人型小兵顯示警告",
	WarnVoid		= "為虛無哨兵顯示警告",
	WarnFiend		= "為第二階段的黑暗惡魔顯示警告",
	TimerHuman		= "為人型小兵顯示計時器",
	TimerVoid		= "為虛無哨兵顯示計時器",
	TimerPhase		= "為轉換第二階段顯示計時器"
})

L:SetMiscLocalization({
	Entropius		= "安卓普斯"
})

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization({
	name = "基爾加丹"
})

L:SetWarningLocalization({
	WarnDarkOrb		= "盾之寶珠出現",
	WarnBlueOrb		= "藍龍軍團寶珠啟用",
	SpecWarnDarkOrb	= "盾之寶珠出現!",
	SpecWarnBlueOrb	= "藍龍軍團寶珠啟用!"
})

L:SetTimerLocalization({
	TimerBlueOrb	= "藍龍軍團寶珠活動"
})

L:SetOptionLocalization({
	WarnDarkOrb		= "為盾之寶珠顯示警告",
	WarnBlueOrb		= "為藍龍軍團寶珠顯示警告",
	SpecWarnDarkOrb	= "為盾之寶珠顯示特別警告",
	SpecWarnBlueOrb	= "為藍龍軍團寶珠顯示特別警告",
	TimerBlueOrb	= "為藍龍軍團寶珠活動顯示計時器"
})

L:SetMiscLocalization({
	YellPull		= "該犧牲的都已經結束了，就任他們去吧!現在我將完成薩格拉斯都辦不到的事!我要搾乾這個悲慘的世界，並確保我成為燃燒軍團的真正主人!末日已經到來!讓這個世界開始毀滅吧!",
	OrbYell1		= "我會將我的力量導入寶珠中!準備好!",
	OrbYell2		= "我又將能量灌入了另一顆寶珠!快去使用它!",
	OrbYell3		= "又有一顆寶珠準備好了!快點行動!",
	OrbYell4		= "我已經引導出所有的力量了!力量現在掌握在你們的手裡!"
})
