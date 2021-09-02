-- yleaf(yaroot@gmail.com)
-- Mini Dragon(projecteurs@gmail.com)
-- Last update: 2017/07/18

if GetLocale() ~= "zhCN" then return end
local L

-----------------
--  Najentus  --
-----------------
L = DBM:GetModLocalization("Najentus")

L:SetGeneralLocalization{
	name = "高阶督军纳因图斯"
}

L:SetMiscLocalization{
	HealthInfo	= "Health Info"
}

----------------
-- Supremus --
----------------
L = DBM:GetModLocalization("Supremus")

L:SetGeneralLocalization{
	name = "苏普雷姆斯"
}

L:SetWarningLocalization{
	WarnPhase		= "%s Phase",--Translate
}

L:SetTimerLocalization{
	TimerPhase		= "Next %s phase"--Translate
}

L:SetOptionLocalization{
	WarnPhase		= "Show warning for next phase",
	TimerPhase		= "Show time for next phase",
	KiteIcon		= "Set icon on Kite target"
}

L:SetMiscLocalization{
	PhaseTank		= "愤怒地击打着地面！",--Check if Backwards
	PhaseKite		= "地面崩裂了！",--Check if Backwards
	ChangeTarget	= "锁定了一个新目标！",
	Kite			= "Kite",--Translate
	Tank			= "Tank"--Translate
}

-------------------------
--  Shape of Akama  --
-------------------------
L = DBM:GetModLocalization("Akama")

L:SetGeneralLocalization{
	name = "阿卡玛之影"
}

-------------------------
--  Teron Gorefiend  --
-------------------------
L = DBM:GetModLocalization("TeronGorefiend")

L:SetGeneralLocalization{
	name = "塔隆·血魔"
}

L:SetTimerLocalization{
	TimerVengefulSpirit		= "Ghost : %s"--Translate
}

L:SetOptionLocalization{
	TimerVengefulSpirit		= "Show timer for Ghost durations"--Translate
}

L:SetMiscLocalization{
}

----------------------------
--  Gurtogg Bloodboil  --
----------------------------
L = DBM:GetModLocalization("Bloodboil")

L:SetGeneralLocalization{
	name = "古尔图格·血沸"
}

--------------------------
--  Essence Of Souls  --
--------------------------
L = DBM:GetModLocalization("Souls")

L:SetGeneralLocalization{
	name = "灵魂之匣"
}

L:SetWarningLocalization{
	WarnMana		= "30秒后法力消耗殆尽"
}

L:SetTimerLocalization{
	TimerMana		= "法力吸取"
}

L:SetOptionLocalization{
	WarnMana		= "Show warning from zero mana in Phase 2",--Translate
	TimerEnrage		= "Show timer for Enrage"--Translate
}

L:SetMiscLocalization{
	Suffering		= "Essence of Suffering",--Translate
	Desire			= "Essence of Desire",--Translate
	Anger			= "Essence of Anger",--Translate
	Phase1End		= "I don't want to go back!",
	Phase2End		= "I won't be far!"
}

-----------------------
--  Mother Shahraz --
-----------------------
L = DBM:GetModLocalization("Shahraz")

L:SetGeneralLocalization{
	name = "莎赫拉丝主母"
}

L:SetTimerLocalization{
	timerAura	= "%s"
}

L:SetOptionLocalization{
	timerAura	= "Show timer for Prismatic Aura"
}

----------------------
--  Illidari Council  --
----------------------
L = DBM:GetModLocalization("Council")

L:SetGeneralLocalization{
	name = "伊利达雷议会"
}

L:SetGeneralLocalization{
	name = "Illidari Council"
}

L:SetWarningLocalization{
	Immune			= "Malande - %s immune for 15 sec"
}

L:SetOptionLocalization{
	Immune			= "Show warning when Manalde becomes spell or melee immune"
}

L:SetMiscLocalization{
	Gathios			= "击碎者加西奥斯",
	Malande			= "女公爵玛兰德",
	Zerevor			= "高阶灵术师塞勒沃尔",
	Veras			= "薇尔莱丝·深影",
	Melee			= "近战",
	Spell			= "法术"
}

-------------------------
--  Illidan Stormrage --
-------------------------
L = DBM:GetModLocalization("Illidan")

L:SetGeneralLocalization{
	name = "伊利丹·怒风"
}

L:SetWarningLocalization{
	WarnHuman		= "普通形态",
	WarnDemon		= "恶魔形态"
}

L:SetTimerLocalization{
	TimerNextHuman		= "下一个普通形态",
	TimerNextDemon		= "下一个恶魔形态"
}

L:SetOptionLocalization{
	WarnHuman		= "Show warning for 普通形态",
	WarnDemon		= "Show warning for 恶魔形态",
	TimerNextHuman	= "Show time for 下一个普通形态",
	TimerNextDemon	= "Show time for 下一个恶魔形态",
	RangeFrame		= "为阶段3和阶段4显示10码距离提示"
}

L:SetMiscLocalization{
	Pull			= "阿卡玛。你的两面三刀并没有让我感到意外。我早就应该把你和你那些畸形的同胞全部杀掉。",
	Eyebeam			= "直视背叛者的双眼吧！",
	Demon			= "感受我体内的恶魔之力吧！",
	Phase4			= "你们就这点本事吗？这就是你们全部的能耐？"
}
