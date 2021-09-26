local mod	= DBM:NewMod("Hydross", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(21216)

mod:SetModelID(20162)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 38235 38246",
	"SPELL_AURA_REMOVED 38246",
	"SPELL_CAST_SUCCESS 38215 38216 38217 38219 38220 38221 38218 38231 40584 38222 38230 40583 25035"
)

--[[
(ability.id = 38215 or ability.id = 38216 or ability.id = 38217 or ability.id = 38219 or ability.id = 38220 or ability.id = 38221
 or ability.id = 38218 or ability.id = 38231 or ability.id = 40584 or ability.id = 38222 or ability.id = 38230 or ability.id = 40583
 or ability.id = 25035) and type = "cast"
--]]
local warnMark		= mod:NewAnnounce("WarnMark", 3, 38215)
local warnPhase		= mod:NewAnnounce("WarnPhase", 4)
local warnTomb		= mod:NewTargetNoFilterAnnounce(38235, 3)
local warnSludge	= mod:NewTargetNoFilterAnnounce(38246, 2)--Maybe filter it some if spammy?

local specWarnMark	= mod:NewSpecialWarning("SpecWarnMark")

local timerMark		= mod:NewTimer(15, "TimerMark", 38215, nil, nil, 2)
local timerSludge	= mod:NewTargetTimer(24, 38246, nil, nil, nil, 3)

local berserkTimer	= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("10")

local markOfH, markOfC = DBM:GetSpellInfo(38215), DBM:GetSpellInfo(38219)
local damage = {
	[38215] = "10%", [38216] = "25%", [38217] = "50%", [38218] = "100%", [38231] = "250%", [40584] = "500%",
	[38219] = "10%", [38220] = "25%", [38221] = "50%", [38222] = "100%", [38230] = "250%", [40583] = "500%",
}

local damageNext = {
	[38215] = "25%", [38216] = "50%", [38217] = "100%", [38218] = "250%", [38231] = "500%", [40584] = "500%",
	[38219] = "25%", [38220] = "50%", [38221] = "100%", [38222] = "250%", [38230] = "500%", [40583] = "500%",
}

function mod:OnCombatStart(delay)
	timerMark:Start(16-delay, markOfH, "10%")
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show()
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 38235 then
		warnTomb:CombinedShow(0.3, args.destName)
	elseif args.spellId == 38246 then
		warnSludge:Show(args.destName)
		timerSludge:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 38246 then
		timerSludge:Stop(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(38215, 38216, 38217, 38219, 38220, 38221) then
		warnMark:Show(args.spellName, damage[args.spellId] or "10%")
		timerMark:Cancel()
		timerMark:Show(args.spellName, damageNext[args.spellId] or "10%")
	elseif args:IsSpellID(38218, 38231, 40584, 38222, 38230, 40583) then
		warnMark:Show(args.spellName, damage[args.spellId] or "10%")
		specWarnMark:Show(args.spellName, damage[args.spellId] or "10%")
		timerMark:Cancel()
		timerMark:Show(args.spellName, damageNext[args.spellId] or "10%")
	elseif args.spellId == 25035 and self:AntiSpam(2) then
		timerMark:Cancel()
		if args:GetSrcCreatureID() == 22035 then
			warnPhase:Show(L.Frost)
			timerMark:Start(15.4, markOfH, "10%")
		elseif args:GetSrcCreatureID() == 22036 then
			warnPhase:Show(L.Nature)
			timerMark:Start(15.4, markOfC, "10%")
		end
	end
end
