local mod	= DBM:NewMod("Azgalor", "DBM-Hyjal")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(17842)

mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
)

local warnSilence		= mod:NewSpellAnnounce(31344, 3)
local warnDoom			= mod:NewTargetAnnounce(31347, 4)

local timerDoom			= mod:NewTargetTimer(20, 31347)
local timerSilence		= mod:NewBuffFadesTimer(5, 31344)
local timerSilenceCD	= mod:NewCDTimer(18, 31344)

local specWarnFire		= mod:NewSpecialWarningMove(31340)
local specWarnDoom		= mod:NewSpecialWarningYou(31347)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddBoolOption("DoomIcon", true)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31340 and args:IsPlayer() and self:AntiSpam() then
		specWarnFire:Show()
	elseif args.spellId == 31347 then
		warnDoom:Show(args.destName)
		timerDoom:Start(args.destName)
		if args:IsPlayer() then
			specWarnDoom:Show()
		end
		if self.Options.DoomIcon then
			self:SetIcon(args.destName, 8)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 31347 then
		if self.Options.DoomIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31344 then
		warnSilence:Show()
		timerSilence:Start()
		timerSilenceCD:Start()
	end
end
