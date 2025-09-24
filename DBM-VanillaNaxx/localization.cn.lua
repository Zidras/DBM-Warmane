﻿-- author: callmejames @《凤凰之翼》 一区藏宝海湾
-- commit by: yaroot <yaroot AT gmail.com>
-- Mini Dragon(projecteurs AT gmail.com) Brilla@金色平原
-- Last update: 2019/08/22

if GetLocale() ~= "zhCN" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan-Vanilla")

L:SetGeneralLocalization({
	name				= "阿努布雷坎"
})

L:SetOptionLocalization({
	ArachnophobiaTimer		= "为蜘蛛克星(成就)显示计时条"
})

L:SetMiscLocalization({
	ArachnophobiaTimer		= "蜘蛛克星",
	Pull1					= "对，跑吧！那样伤口出血就更多了！",
	Pull2					= "一些小点心……",
--	Pull3					= "你们逃不掉的。"
})

----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina-Vanilla")

L:SetGeneralLocalization({
	name				= "黑女巫法琳娜"
})

L:SetWarningLocalization({
	WarningEmbraceExpire		= "黑女巫的拥抱5秒后结束"
})

L:SetOptionLocalization({
	WarningEmbraceExpire		= "为黑女巫的拥抱结束显示提前警报"
})

L:SetMiscLocalization({
	Pull					= "跪下求饶吧，诺夫！"--Not actually pull trigger, but often said on pull
})

---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna-Vanilla")

L:SetGeneralLocalization({
	name					= "迈克斯纳"
})

L:SetWarningLocalization({
	WarningSpidersSoon		= "迈克斯纳之子 5秒后出现",
	WarningSpidersNow		= "迈克斯纳之子出现了"
})

L:SetTimerLocalization({
	TimerSpider				= "下一次 迈克斯纳之子"
})

L:SetOptionLocalization({
	WarningSpidersSoon		= "为迈克斯纳之子显示提前警报",
	WarningSpidersNow		= "为迈克斯纳之子显示警报",
	TimerSpider				= "为下一次迈克斯纳之子显示计时条"
})

L:SetMiscLocalization({
	ArachnophobiaTimer		= "蜘蛛克星"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth-Vanilla")

L:SetGeneralLocalization({
	name					= "药剂师诺斯"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "传送",
	WarningTeleportSoon		= "10秒后 传送"
})

L:SetTimerLocalization({
	TimerTeleport			= "传送",
	TimerTeleportBack		= "传送回来"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "为传送显示警报",
	WarningTeleportSoon		= "为传送显示预警",
	TimerTeleport			= "为传送显示计时条",
	TimerTeleportBack		= "为传送回来显示计时条"
})

L:SetMiscLocalization({
	Pull				= "死吧，入侵者！",
	Adds				= "召唤出骷髅战士！",
	AddsTwo				= "召唤出更多的骷髅！"
})

--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan-Vanilla")

L:SetGeneralLocalization({
	name				= "肮脏的希尔盖"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "传送",
	WarningTeleportSoon		= "%d秒后 传送"
})

L:SetTimerLocalization({
	TimerTeleport			= "传送"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "为传送显示警报",
	WarningTeleportSoon		= "为传送显示提前警报",
	TimerTeleport			= "为传送显示计时条"
})

L:SetMiscLocalization({
	Pull				= "你是我的了。"
})

---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb-Vanilla")

L:SetGeneralLocalization({
	name				= "洛欧塞布"
})

L:SetWarningLocalization({
	WarningHealSoon			= "3秒后可以治疗",
	WarningHealNow			= "现在治疗"
})

L:SetOptionLocalization({
	WarningHealSoon			= "为3秒后可以治疗显示提前警报",
	WarningHealNow			= "为现在治疗显示警报",
	SporeDamageAlert		= "在团队中提示谁杀死了孢子并发送悄悄话给该玩家\n(需要团长或助理权限)",
	CorruptedSorting		= "Set infoframe sorting behaviour for $spell:55593", -- translation missing
	Alphabetical			= "Sort in alphabetical order", -- translation missing
	Duration				= "Sort by duration" -- translation missing
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk-Vanilla")

L:SetGeneralLocalization({
	name				= "帕奇维克"
})

L:SetOptionLocalization({
	WarningHateful		= "公布仇恨打击的目标到团队频道\n(需要团长或助理权限)"
})

L:SetMiscLocalization({
	yell1				= "帕奇维克要跟你玩！",
	yell2				= "帕奇维克是克尔苏加德的战神！",
	HatefulStrike		= "仇恨打击 --> %s [%s]"
})

-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus-Vanilla")

L:SetGeneralLocalization({
	name = "格罗布鲁斯"
})

-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth-Vanilla")

L:SetGeneralLocalization({
	name = "格拉斯"
})

----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius-Vanilla")

L:SetGeneralLocalization({
	name				= "塔迪乌斯"
})

L:SetWarningLocalization({
	WarningChargeChanged		= "极性变为%s",
	WarningChargeNotChanged		= "极性没有改变"
})

L:SetOptionLocalization({
	WarningChargeChanged		= "当你的极性改变时显示特别警报",
	WarningChargeNotChanged		= "当你的极性没有改变时显示特别警报",
	ArrowsEnabled			= "显示箭头 (正常 \"两边\" 站位打法)",
	ArrowsRightLeft			= "显示左/右箭头 给 \"四角\" 站位打法 (如果极性改变显示左箭头, 没变显示右箭头)",
	ArrowsInverse			= "显示反转的 \"四角\" 站位打法 (如果极性改变显示右箭头, 没变显示左箭头)"
})

L:SetMiscLocalization({
	Yell				= "斯塔拉格要碾碎你！",
	Emote				= "%s超载了！",
	Emote2				= "电磁圈超载了！",
	Boss1				= "费尔根",
	Boss2				= "斯塔拉格",
	Charge1				= "负极",
	Charge2				= "正极"
})

----------------------------
--  Instructor Razuvious  --
----------------------------
L = DBM:GetModLocalization("Razuvious-Vanilla")

L:SetGeneralLocalization({
	name				= "教官拉苏维奥斯"
})

L:SetWarningLocalization({
	WarningShieldWallSoon		= "5秒后 盾墙结束"
})

L:SetOptionLocalization({
	WarningShieldWallSoon		= "为盾墙结束显示提前警报"
})

L:SetMiscLocalization({
	Yell1				= "仁慈无用！",
	Yell2				= "练习时间到此为止！都拿出真本事来！",
	Yell3				= "按我教导的去做！",
	Yell4				= "绊腿……有什么问题吗？"
})

----------------------------
--  Gothik the Harvester  --
----------------------------
L = DBM:GetModLocalization("Gothik-Vanilla")

L:SetGeneralLocalization({
	name				= "收割者戈提克"
})

L:SetWarningLocalization({
	WarningWaveSoon			= "3秒后 第%d波: %s",
	WarningWaveSpawned		= "第%d波: %s 出现了",
	WarningRiderDown		= "骑兵已死亡",
	WarningKnightDown		= "死亡骑士已死亡",
	WarningPhase2			= "第二阶段"
})

L:SetTimerLocalization({
	TimerWave			= "第 %d 波",
	TimerPhase2			= "第2阶段"
})

L:SetOptionLocalization({
	TimerWave			= "为下一波小怪显示计时条",
	TimerPhase2			= "为第二阶段显示计时条",
	WarningWaveSoon			= "为小怪出现显示提前警报",
	WarningWaveSpawned		= "为小怪出现显示警报",
	WarningRiderDown		= "当冷酷的骑兵死亡时显示警报",
	WarningKnightDown		= "当冷酷的死亡骑士死亡时显示警报"
})

L:SetMiscLocalization({
	yell				= "你们这些蠢货已经主动步入了陷阱。",
	WarningWave1		= "%d %s",
	WarningWave2		= "%d %s 和 %d %s",
	WarningWave3		= "%d %s, %d %s 和 %d %s",
	Trainee				= "学徒",
	Knight				= "死亡骑士",
	Rider				= "骑兵"
})

---------------------
--  Four Horsemen  --
---------------------
L = DBM:GetModLocalization("Horsemen-Vanilla")

L:SetGeneralLocalization({
	name				= "四骑士"
})

L:SetOptionLocalization({
	WarningMarkSoon			= "为印记显示提前警报",
	SpecialWarningMarkOnPlayer	= "当你印记叠加多于四层时显示特别警报"
})

L:SetWarningLocalization({
	WarningMarkSoon			= "3秒后 印记 %d",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetMiscLocalization({
	Korthazz			= "库尔塔兹领主",
	Rivendare			= "瑞文戴尔男爵",
	Blaumeux			= "女公爵布劳缪克丝",
	Zeliek				= "瑟里耶克爵士"
})

-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron-Vanilla")

L:SetGeneralLocalization({
	name				= "萨菲隆"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon		= "10秒后 空中阶段",
	WarningAirPhaseNow		= "空中阶段",
	WarningLanded			= "萨菲隆降落了",
	WarningDeepBreath		= "冰霜吐息",
	SpecWarnSapphLow		= "萨菲隆不能飞！"
})

L:SetTimerLocalization({
	TimerAir				= "空中阶段",
	TimerLanding			= "降落",
	TimerIceBlast			= "冰霜吐息"
})

L:SetOptionLocalization({
	WarningAirPhaseSoon		= "为空中阶段显示提前警报",
	WarningAirPhaseNow		= "提示空中阶段",
	WarningLanded			= "提示地上阶段",
	TimerAir				= "为空中阶段显示计时条",
	TimerLanding			= "为降落显示计时条",
	TimerIceBlast			= "为冰霜吐息显示计时条",
	WarningDeepBreath		= "为冰霜吐息显示特别警报",
	SpecWarnSapphLow		= "10%执行阶段特别警告（取消空中阶段）"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s深深地吸了一口气。",
	AirPhase			= "萨菲隆缓缓升空！",
	LandingPhase		= "萨菲隆再次发动了攻击！"
})

------------------
--  Kel'Thuzad  --
------------------
L = DBM:GetModLocalization("Kel'Thuzad-Vanilla")

L:SetGeneralLocalization({
	name				= "克尔苏加德"
})

L:SetWarningLocalization({
	specwarnP2Soon		= "10秒后克尔苏加德开始攻击",
	warnAddsSoon		= "寒冰皇冠卫士即将出现",
	WeaponsStatus		= "自动卸下武器开启: %s (%s - %s)"
})

L:SetTimerLocalization({
	TimerPhase2			= "第二阶段"
})

L:SetOptionLocalization({
	TimerPhase2			= "为第二阶段显示计时条",
	specwarnP2Soon		= "为克尔苏加德攻击前10秒显示特别警报",
	warnAddsSoon		= "为寒冰皇冠卫士显示提前警报",
	WeaponsStatus		= "如果卸下/装备武器功能启用，在战斗开始时显示特殊警报",
	EqUneqWeaponsKT		= "在 $spell:28410 之前和之后自动取消装备和装备武器。 需要名为“pve”的装备套装",
	EqUneqWeaponsKT2	= "对你施放 $spell:28410 时自动解除和装备武器。 需要名为“pve”的装备套装",
	RemoveBuffsOnMC		= "当$spell:28410对你施法时，移除BUFF。每个选项都是累积的。",
	Gift				= "移除$spell:48469 / $spell:48470。防止$spell:33786抵制的最简单方法。",
	CCFree				= "+ 删除$spell:48169 / $spell:48170。考虑到阴影学派中法术的抵抗。",
	ShortOffensiveProcs	= "+ 删除持续时间短的攻击性程序。建议在不影响突击队伤害输出的情况下保证突击队的安全。",
	MostOffensiveBuffs	= "+ 移除大部分攻击性BUFF（主要针对施法者和|cFFFF7C0A野性德鲁伊|r）。在损失伤害输出和需要自我补血/移形换影的情况下，最大限度地保证了突击队的安全！"
})

L:SetMiscLocalization({
	Yell				= "仆从们，侍卫们，隶属于黑暗与寒冷的战士们！听从克尔苏加德的召唤！",
	Yell1Phase2			= "祈祷我的慈悲吧！", -- 12995
	Yell2Phase2			= "呼出你的最后一口气！", -- 12996
	Yell3Phase2			= "你的末日临近了！", -- 12997
	YellPhase3			= "主人，我需要帮助！", -- 12998
	YellGuardians		= "很好，冰荒废土的战士们，起来吧！我命令你们为主人而战斗，杀戮，直到死亡！一个活口都不要留！", -- 12994
	setMissing			= "注意力！ 在您创建名为 pve 的装备集之前，DBM 自动武器卸载/装备将不起作用",
	EqUneqLineDescription	= "自动装备/取消装备"
})
