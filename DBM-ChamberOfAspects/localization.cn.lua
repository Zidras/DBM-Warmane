-- author: callmejames @《凤凰之翼》 一区藏宝海湾
-- commit by: yaroot <yaroot AT gmail.com>


if GetLocale() ~= "zhCN" then return end

local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "沙德隆"
})

----------------
--  Tenebron  --
----------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "塔尼布隆"
})

----------------
--  Vesperon  --
----------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "维斯匹隆"
})

------------------
--  Sartharion  --
------------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "萨塔里奥"
})

L:SetWarningLocalization({
	WarningTenebron			= "塔尼布隆到来",
	WarningShadron			= "沙德隆到来",
	WarningVesperon			= "维斯匹隆到来",
	WarningFireWall			= "烈焰之啸",
	WarningVesperonPortal	= "维斯匹隆的传送门",
	WarningTenebronPortal	= "塔尼布隆的传送门",
	WarningShadronPortal	= "沙德隆的传送门"
})

L:SetTimerLocalization({
	TimerTenebron	= "塔尼布隆到来",
	TimerShadron	= "沙德隆到来",
	TimerVesperon	= "维斯匹隆到来"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall		= "音效：烈焰之啸",
	AnnounceFails           = "公布踩中暗影裂隙和撞上烈焰之啸的玩家到团队频道 (需要团长或助理权限)",
	TimerTenebron           = "为塔尼布隆到来显示计时条",
	TimerShadron            = "为沙德隆到来显示计时条",
	TimerVesperon           = "为维斯匹隆到来显示计时条",
	WarningFireWall         = "为烈焰之啸显示特别警报",
	WarningTenebron         = "提示塔尼布隆到来",
	WarningShadron          = "提示沙德隆到来",
	WarningVesperon         = "提示维斯匹隆到来",
	WarningTenebronPortal	= "为塔尼布隆的传送门显示特别警报",
	WarningShadronPortal	= "为沙德隆的传送门显示特别警报",
	WarningVesperonPortal	= "为维斯匹隆的传送门显示特别警报"
})

L:SetMiscLocalization({
	Wall			= "%s周围的岩浆沸腾了起来！",
	Portal			= "%s开始开启暮光传送门！",
	NameTenebron	= "塔尼布隆",
	NameShadron		= "沙德隆",
	NameVesperon	= "维斯匹隆",
	FireWallOn		= "烈焰之啸：%s",
	VoidZoneOn		= "暗影裂隙：%s",
	VoidZones		= "踩中暗影裂隙 (这一次)：%s",
	FireWalls		= "撞上烈焰之啸 (这一次)：%s"
})

------------------------
--  红玉圣殿  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "战争之子巴尔萨鲁斯"
})

L:SetWarningLocalization({
	WarningSplitSoon 	= "分裂 即将到来"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "预警：分裂",
	RangeFrame			= "范围监测器：12码"
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "塞维娅娜·怒火"
})

L:SetOptionLocalization({
	RangeFrame			= "范围监测器：10码"
})

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "萨瑞瑟里安将军"
})

L:SetWarningLocalization({
	WarnAdds		= "新的小怪",
	warnCleaveArmor	= ">%1$s<中了%2$s(%s)"	-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds		= "新的小怪",
	AddsArrive		= "小怪到来："
})

L:SetOptionLocalization({
	WarnAdds		= "通报：新的小怪",
	TimerAdds		= "计时条：新的小怪",
	CancelBuff		= "删除 $spell:10278 和 $spell:642 如果用于删除 $spell:74367",
	AddsArrive		= "计时条：小怪到来"
})

L:SetMiscLocalization({
	SummonMinions	= "让他们化为灰烬，仆从们！"
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "海里昂 暮光摧毁者"
})

L:SetWarningLocalization({
	TwilightCutterCast		= "5秒后 施放暮光撕裂射线"
})

L:SetOptionLocalization({
	TwilightCutterCast		= "警报：$spell:77844开始施放",
	AnnounceAlternatePhase	= "显示另一场地的警报/计时条",
	SetIconOnConsumption	= "标记：$spell:74562或$spell:74792的目标"--So we can use single functions for both versions of spell.
})

L:SetMiscLocalization({
	Halion					= "海里昂",
	MeteorCast				= "天空在燃烧！",
	Phase2					= "暮光的世界将会让你痛不欲生！够胆量的就进来吧！",
	Phase3					= "我就是交织的光影！凡人，在死亡之翼的使者面前颤抖吧！",
	twilightcutter			= "阴影在弥漫！", -- "黑暗能量正在这颗旋转的魔球中脉动！", -- Warmane(i服)不能用此台词作为判断条件，因为Warmane(i服)服务器端会在切割前5秒和切割开始时触发此台词两次。
	Kill					= "享受胜利吧，凡人们，这是你们最后的胜利。回归的主人将烧毁这个世界！"
})
