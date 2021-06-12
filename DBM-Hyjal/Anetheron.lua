local mod	= DBM:NewMod("Anetheron", "DBM-Hyjal")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(17808)

mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnSwarm			= mod:NewSpellAnnounce(31306, 3)
local warnSleep			= mod:NewTargetAnnounce(31298, 2)
local warnInferno		= mod:NewTargetAnnounce(31299, 4)

local timerSwarm		= mod:NewBuffFadesTimer(20, 31306)
local timerSleepCD		= mod:NewCDTimer(19, 31298)
local timerInferno		= mod:NewCDTimer(51, 31299)

local specWarnInferno	= mod:NewSpecialWarningYou(31299)

function mod:InfernoTarget()
	local targetname = self:GetBossTarget(17808)
	if not targetname then return end
	warnInferno:Show(targetname)
	timerInferno:Start()
	if targetname == UnitName("player") then
		specWarnInferno:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31306 and args:IsPlayer() then
		timerSwarm:Start()
	elseif args.spellId == 31298 and args:IsPlayer() then
		timerSleepCD:Start()
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 31306 and args:IsPlayer() then
		timerSwarm:Cancel()
	elseif args.spellId == 31298 and args:IsPlayer() then
		timerSleepCD:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 31299 then
		self:ScheduleMethod(0.15, "InfernoTarget")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31306 then
		warnSwarm:Show()
	elseif args.spellId == 31298 then
		timerSleepCD:Start()
	end
end

