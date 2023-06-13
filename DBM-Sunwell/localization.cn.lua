if GetLocale() ~= "zhCN" then return end
local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")

L:SetGeneralLocalization({
	name = "卡雷苟斯"
})

L:SetWarningLocalization({
	WarnPortal			= "传送 #%d : >%s< (%d组)",
	SpecWarnWildMagic	= "狂野魔法 - %s!"
})

L:SetOptionLocalization({
	WarnPortal			= "Show warning for $spell:46021 target",--Translate
	SpecWarnWildMagic	= "Show special warning for Wild Magic",--Translate
	ShowRespawn			= "Boss战斗未完成时显示Boss刷新计时条",
	ShowFrame			= "Show Spectral Realm frame" ,--Translate
	FrameClassColor		= "Use class colors in Spectral Realm frame",--Translate
	FrameUpwards		= "Expand Spectral Realm frame upwards",--Translate
	FrameLocked			= "Set Spectral Realm frame not movable"--Translate
})

L:SetMiscLocalization({
	Demon				= "腐蚀者萨索瓦尔",
	Heal				= "+100%治疗效果",
	Haste				= "+100%施法时间",
	Hit					= "-50%命中几率",
	Crit				= "+100%爆击伤害",
	Aggro				= "+100%威胁值",
	Mana				= "-50%技能消耗",
	FrameTitle			= "首领生命值",
	FrameLock			= "锁定框体",
	FrameClassColor		= "使用职业颜色",
	FrameOrientation	= "灵魂世界框体向上延伸",
	FrameHide			= "隐藏框体",
	FrameClose			= "Close", --Translate
	FrameGUIMoveMe		= "移动我"
})

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization({
	name = "布鲁塔卢斯"
})

L:SetOptionLocalization({
	RangeFrameActivation= "範圍框架激活",
	AlwaysOn			= "在遭遇開始時。忽略過濾器",
	OnDebuff			= "開啟減益。應用減益過濾器"
})

L:SetMiscLocalization({
	Pull			= "啊，又来了一群小绵羊！"
})

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization({
	name = "菲米丝"
})

L:SetWarningLocalization({
	WarnPhase		= "%s阶段"
})

L:SetTimerLocalization({
	TimerPhase		= "%s阶段"
})

L:SetOptionLocalization({
	WarnPhase		= "显示下一阶段的警告",
	TimerPhase		= "显示下一阶段的计时器"
})

L:SetMiscLocalization({
	Air				= "空中",
	Ground			= "地面",
	AirPhase		= "我比以前更强大了！",
	Breath			= "%s深深地吸了一口气。"
})

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name = "艾瑞达双子"
})

L:SetMiscLocalization({
	NovaWhisper		= "暗影新星！",
	ConflagWhisper	= "燃烧！",
	Nova			= "萨洛拉丝向([^%s]+)施放暗影新星。",--Verify
	Conflag			= "奥蕾塞丝向([^%s]+)施放燃烧。"--Verify
})

------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization({
	name = "穆鲁"
})

L:SetWarningLocalization({
	WarnHuman		= "暗誓精灵 (%d)",
	WarnHumanSoon	= "暗誓精灵 - 5秒后出现 (%d)",
	WarnVoid		= "虚空戒卫 (%d)",
	WarnVoidSoon	= "虚空戒卫 - 5秒后出现 (%d)",
	WarnFiend		= "黑暗魔出现"
})

L:SetTimerLocalization({
	TimerHuman		= "暗誓精灵 (%s)",
	TimerVoid		= "虚空戒卫 (%s)",
	TimerPhase		= "熵魔"
})

L:SetOptionLocalization({
	WarnHuman		= "Show warning for Humanoids",--Translate
	WarnHumanSoon	= "Show pre-warning for Humanoids",--Translate
	WarnVoid		= "Show warning for Void Sentinels",--Translate
	WarnVoidSoon	= "Show pre-warning for Void Sentinels",--Translate
	WarnFiend		= "Show warning for Fiends in phase 2",--Translate
	TimerHuman		= "Show timer for Humanoids",--Translate
	TimerVoid		= "Show timer for Void Sentinels",--Translate
	TimerPhase		= "Show time for Phase 2 transition"--Translate
})

L:SetMiscLocalization({
	Entropius		= "熵魔"
})

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization({
	name = "基尔加丹"
})

L:SetWarningLocalization({
	WarnDarkOrb		= "Dark Orbs Spawned",--Translate
	WarnBlueOrb		= "Dragon Orb activated",--Translate
	SpecWarnDarkOrb	= "Dark Orbs Spawned!",--Translate
	SpecWarnBlueOrb	= "Dragon Orbs Activated!"--Translate
})

L:SetTimerLocalization({
	TimerBlueOrb	= "Dragon Orbs activate"--Translate
})

L:SetOptionLocalization({
	WarnDarkOrb		= "Show warning for Dark Orbs",--Translate
	WarnBlueOrb		= "Show warning for Dragon Orbs",--Translate
	SpecWarnDarkOrb	= "Show special warning for Dark Orbs",--Translate
	SpecWarnBlueOrb	= "Show special warning for Dragon Orbs",--Translate
	TimerBlueOrb	= "Show timer form Dragon Orbs activate"--Translate
})

L:SetMiscLocalization({
	YellPull		= "这个消耗品已经没用了！不管它了！现在我已经做到了连萨格拉斯都没有做到的事情！我要彻底毁灭这个世界，真正成为燃烧军团的主宰者！末日已经到来啦！让这个世界就此支离破碎吧！",
	OrbYell1		= "我会将我的力量导入宝珠中！准备好！",
	OrbYell2		= "我又将能量灌入了另一颗宝珠！快去使用它！",
	OrbYell3		= "又有一颗宝珠准备好了！快点行动！",
	OrbYell4		= "这是我所能做的一切了！力量现在掌握在你们的手中！"
})
