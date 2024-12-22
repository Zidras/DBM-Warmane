local mod	= DBM:NewMod("Sartura", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240716174010")
mod:SetCreatureID(15516)

mod:SetModelID(15516)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 26083 8269",
	"UNIT_HEALTH mouseover focus target",
	"SPELL_AURA_APPLIED 26083",
	"SPELL_AURA_REMOVED 26083"
)

--Add sundering cleave?
local warnEnrageSoon	= mod:NewSoonAnnounce(8269, 2)
local warnEnrage		= mod:NewSpellAnnounce(8269, 4)
local warnWhirlwind		= mod:NewSpellAnnounce(26083, 3)

local specWarnWhirlwind	= mod:NewSpecialWarningRun(26083, false, nil, nil, 4, 2)

local WhirlwindCD		= mod:NewCDTimer(20, 26083, nil, nil, nil, 2)


mod.vb.prewarn_enrage = false

function mod:OnCombatStart(delay)
	self.vb.prewarn_enrage = false
	WhirlwindCD:Start(12)


function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 26083 and args:IsSrcTypeHostile() and self:AntiSpam(4, 1) then
		if self:CheckInterruptFilter(args.sourceGUID, true) and self.Options.SpecWarn26083run then
			specWarnWhirlwind:Show()
			specWarnWhirlwind:Play("justrun")
		else
			warnWhirlwind:Show()
		end
	elseif args.spellId == 8269 and args:IsSrcTypeHostile() then
		warnEnrage:Show()
	end
end
mod.SPELL_AURA_APPLIED = mod.SPELL_CAST_SUCCESS

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 15516 and not self.vb.prewarn_enrage and UnitHealthMax(uId) and UnitHealthMax(uId) > 0 and (UnitHealth(uId) / UnitHealthMax(uId)) <= 0.35 then
		warnEnrageSoon:Show()
		self.vb.prewarn_enrage = true
	end
end
