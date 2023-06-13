if GetLocale() ~= "zhTW" then return end
local L

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization({
	name = "獵人阿圖曼"
})



--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization({
	name = "摩洛"
})

L:SetWarningLocalization({
	DBM_MOROES_VANISH_FADED	= "消失退去"
})

L:SetOptionLocalization({
	DBM_MOROES_VANISH_FADED	= "為消失退去顯示警告"
})

-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization({
	name = "貞潔聖女"
})

-- Romulo and Julianne
L = DBM:GetModLocalization("RomuloAndJulianne")

L:SetGeneralLocalization({
	name = "羅慕歐與茱麗葉"
})

L:SetMiscLocalization({
	Event				= "今晚...我們要探索一個禁忌之愛的故事。",
	RJ_Pull				= "你是什麼樣的惡魔，讓我這樣的痛苦?",
	DBM_RJ_PHASE2_YELL	= "來吧，溫和的夜晚;把我的羅慕歐還給我!",
	Romulo				= "羅慕歐",
	Julianne			= "茱麗葉"
})

-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization({
	name = "大野狼"
})

L:SetMiscLocalization({
	DBM_BBW_YELL_1	= "我想把你吃掉!"
})

-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization({
	name = "綠野仙蹤"
})

L:SetWarningLocalization({
	DBM_OZ_WARN_TITO		= "多多",
	DBM_OZ_WARN_ROAR		= "獅子",
	DBM_OZ_WARN_STRAWMAN	= "稻草人",
	DBM_OZ_WARN_TINHEAD		= "機器人",
	DBM_OZ_WARN_CRONE		= "老巫婆"
})

L:SetTimerLocalization({
	DBM_OZ_WARN_TITO		= "多多",
	DBM_OZ_WARN_ROAR		= "獅子",
	DBM_OZ_WARN_STRAWMAN	= "稻草人",
	DBM_OZ_WARN_TINHEAD		= "機器人"
})

L:SetOptionLocalization({
	AnnounceBosses			= "為新的首領出現顯示警告",
	ShowBossTimers			= "為新的首領出現顯示計時器"
})

L:SetMiscLocalization({
	DBM_OZ_YELL_DOROTHEE	= "喔多多，我們一定要找到回家的路!那個老巫師是我們唯一的希望!稻草人、獅子、機器人，你會 - 等等哦...天呀，快看，我們有訪客!",
	DBM_OZ_YELL_ROAR		= "我不是害怕你!你想要戰鬥嗎?啊，你是嗎?來! 我將把兩支爪子放在背後跟你戰鬥!",
	DBM_OZ_YELL_STRAWMAN	= "現在我該與你做什麼?我完全不能決定。",
	DBM_OZ_YELL_TINHEAD		= "我真的能使用心。嘿，我能有你的心嗎?",
	DBM_OZ_YELL_CRONE		= "為你們每一個人感到不幸，我的小美人們!"
})

-- Curator
L = DBM:GetModLocalization("Curator")

L:SetGeneralLocalization({
	name = "館長"
})

L:SetWarningLocalization({
	warnAdd		= "小怪重生"
})

L:SetOptionLocalization({
	warnAdd		= "為小怪重生顯示警告"
})

-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization({
	name = "泰瑞斯提安·疫蹄"
})

L:SetMiscLocalization({
	Kilrek	= "基瑞克",
	DChains	= "惡魔鍊"
})

-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization({
	name = "埃蘭之影"
})

L:SetWarningLocalization({
	DBM_ARAN_DO_NOT_MOVE	= "烈焰火圈，不要動！"
})

L:SetTimerLocalization({
	timerSpecial			= "特別技能冷卻"
})

L:SetOptionLocalization({
	timerSpecial			= "為特別技能冷卻顯示計時器",
	DBM_ARAN_DO_NOT_MOVE	= "為$spell:30004顯示特別警告"
})

--Netherspite
L = DBM:GetModLocalization("Netherspite")

L:SetGeneralLocalization({
	name = "尼德斯"
})

L:SetWarningLocalization({
	warningPortal			= "光線門階段",
	warningBanish			= "放逐階段"
})

L:SetTimerLocalization({
	timerPortalPhase	= "光線門階段",
	timerBanishPhase	= "放逐階段"
})

L:SetOptionLocalization({
	warningPortal			= "為光線門階段顯示警告",
	warningBanish			= "為放逐階段顯示警告",
	timerPortalPhase		= "為光線門階段持續時間顯示計時器",
	timerBanishPhase		= "為放逐門階段持續時間顯示計時器"
})

L:SetMiscLocalization({
	DBM_NS_EMOTE_PHASE_2	= "%s陷入一陣狂怒!",
	DBM_NS_EMOTE_PHASE_1	= "%s大聲呼喊撤退，打開通往虛空的門。"
})

--Chess
L = DBM:GetModLocalization("Chess")

L:SetGeneralLocalization({
	name = "西洋棋事件"
})

L:SetTimerLocalization({
	timerCheat	= "作弊冷卻"
})

L:SetOptionLocalization({
	timerCheat	= "為作弊冷卻使用計時器"
})

L:SetMiscLocalization({
	EchoCheats	= "麥迪文的回音作弊!"
})

--Prince Malchezaar
L = DBM:GetModLocalization("Prince")

L:SetGeneralLocalization({
	name = "莫克札王子"
})

L:SetMiscLocalization({
	DBM_PRINCE_YELL_P2		= "頭腦簡單的笨蛋!你在燃燒的是時間的火焰!",
	DBM_PRINCE_YELL_P3		= "你怎能期望抵抗這樣勢不可擋的力量?",
	DBM_PRINCE_YELL_INF1	= "所有的實體，所有的空間對我來說都是開放的!",
	DBM_PRINCE_YELL_INF2	= "你挑戰的不只是莫克札，而是我所率領的整個軍隊!"
})

-- Nightbane
L = DBM:GetModLocalization("NightbaneRaid")

L:SetGeneralLocalization({
	name = "夜禍"
})

L:SetWarningLocalization({
	DBM_NB_AIR_WARN			= "空中階段"
})

L:SetTimerLocalization({
	timerAirPhase			= "空中階段"
})

L:SetOptionLocalization({
	DBM_NB_AIR_WARN			= "為空中階段顯示警告",
	timerAirPhase			= "為空中階段持續時間顯示計時器"
})

L:SetMiscLocalization({
	DBM_NB_EMOTE_PULL		= "一個古老的生物在遠處甦醒過來...",
	DBM_NB_YELL_AIR		= "悲慘的害蟲。我將讓你消失在空氣中!",
	DBM_NB_YELL_GROUND		= "夠了!我要親自挑戰你!",
	DBM_NB_YELL_GROUND2	= "昆蟲!給你們近距離嚐嚐我的厲害!"
})

-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization({
	name = "滑翔者‧薛迪依斯"
})

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization({
	name = "潛伏者‧亞奇斯"
})

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization({
	name = "劫掠者‧拉卡"
})
