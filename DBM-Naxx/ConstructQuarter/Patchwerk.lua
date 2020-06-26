local mod	= DBM:NewMod("Patchwerk", "DBM-Naxx", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2869 $"):sub(12, -3))
mod:SetCreatureID(16028)

mod:RegisterCombat("yell", L.yell1, L.yell2)

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)

mod:AddBoolOption("WarningHateful", false, "announce")
mod:AddBoolOption("RemoveHealthBuffsOnCombatStart", false)

local enrageTimer	= mod:NewBerserkTimer(360)
local timerAchieve	= mod:NewAchievementTimer(180, 1857, "TimerSpeedKill")

local function announceStrike(target, damage)
	SendChatMessage(L.HatefulStrike:format(target, damage), "RAID")
end

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerAchieve:Start(-delay)
	if self.Options.RemoveHealthBuffsOnCombatStart then
		mod:ScheduleMethod(0.1, "RemoveBuffs")
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(28308, 59192) and self.Options.WarningHateful and DBM:GetRaidRank() >= 1 then
		announceStrike(args.destName, args.amount or 0)
	end
end

function mod:SPELL_MISSED(args)
	if args:IsSpellID(28308, 59192) and self.Options.WarningHateful and DBM:GetRaidRank() >= 1 then
		announceStrike(args.destName, getglobal("ACTION_SPELL_MISSED_"..(args.missType)) or "")
	end	
end

function mod:RemoveBuffs()
	CancelUnitBuff("player", (GetSpellInfo(47440)))		-- Commanding Shout (Rank 3)
	CancelUnitBuff("player", (GetSpellInfo(47439)))		-- Commanding Shout (Rank 2)
	CancelUnitBuff("player", (GetSpellInfo(45517)))		-- Commanding Shout (Rank 1)
	CancelUnitBuff("player", (GetSpellInfo(469)))		-- Commanding Shout (Rank 1)
	CancelUnitBuff("player", (GetSpellInfo(48161)))		-- Power Word: Fortitude (Rank 8)
	CancelUnitBuff("player", (GetSpellInfo(25389)))		-- Power Word: Fortitude (Rank 7)
	CancelUnitBuff("player", (GetSpellInfo(10938)))		-- Power Word: Fortitude (Rank 6)
	CancelUnitBuff("player", (GetSpellInfo(10937)))		-- Power Word: Fortitude (Rank 5)
	CancelUnitBuff("player", (GetSpellInfo(2791)))		-- Power Word: Fortitude (Rank 4)
	CancelUnitBuff("player", (GetSpellInfo(1245)))		-- Power Word: Fortitude (Rank 3)
	CancelUnitBuff("player", (GetSpellInfo(1244)))		-- Power Word: Fortitude (Rank 2)
	CancelUnitBuff("player", (GetSpellInfo(1243)))		-- Power Word: Fortitude (Rank 1)
	CancelUnitBuff("player", (GetSpellInfo(48162)))		-- Prayer of Fortitude (Rank 4)
	CancelUnitBuff("player", (GetSpellInfo(25392)))		-- Prayer of Fortitude (Rank 3)
	CancelUnitBuff("player", (GetSpellInfo(21564)))		-- Prayer of Fortitude (Rank 2)
	CancelUnitBuff("player", (GetSpellInfo(21562)))		-- Prayer of Fortitude (Rank 1)
	CancelUnitBuff("player", (GetSpellInfo(72590)))		-- Runescroll of Fortitude
end

