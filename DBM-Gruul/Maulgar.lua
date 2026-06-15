local mod	= DBM:NewMod("Maulgar", "DBM-Gruul")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(18831, 18832, 18834, 18835, 18836)

mod:SetModelID(18831)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 33238 33054 33147",
	"SPELL_CAST_START 33152 33144",
	"SPELL_CAST_SUCCESS 33131"
)

--Maulgar
local warningWhirlwind		= mod:NewSpellAnnounce(33238, 4)
--Olm
local warningFelHunter		= mod:NewSpellAnnounce(33131, 3, nil, mod:IsTank() or mod:UnitClass() == "WARLOCK")
--Krosh
local warningShield			= mod:NewTargetNoFilterAnnounce(33054, 3, nil, "MagicDispeller")
--Blindeye
local warningPWS			= mod:NewTargetNoFilterAnnounce(33147, 3, nil, false)
local warningPoH			= mod:NewCastAnnounce(33152, 4)
local warningHeal			= mod:NewCastAnnounce(33144, 4)

local specWarnWhirlwind		= mod:NewSpecialWarningRun(33238, "Melee", nil, nil, 4, 2)
local specWarnPoH			= mod:NewSpecialWarningInterrupt(33152, "HasInterrupt", nil, nil, 1, 2)
local specWarnHeal			= mod:NewSpecialWarningInterrupt(33144, "HasInterrupt", nil, nil, 1, 2)

local timerWhirlwindCD		= mod:NewCDTimer(55, 33238, nil, nil, nil, 2)
local timerWhirlwind		= mod:NewBuffActiveTimer(15, 33238, nil, nil, nil, 2)
local timerFelhunter		= mod:NewCDTimer(48.5, 33131, nil, nil, nil, 1)--Buff Active or Cd timer?
local timerPoH				= mod:NewCastTimer(4, 33152, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerHeal				= mod:NewCastTimer(2, 33144, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)

function mod:OnCombatStart(delay)
	timerWhirlwindCD:Start(58-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 33152 then--Prayer of Healing
		if self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnPoH:Show(args.sourceName)
			specWarnPoH:Play("kickcast")
			timerPoH:Start()
		else
			warningPoH:Show()
		end
	elseif args.spellId == 33144 then--Heal
		if self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnHeal:Show(args.sourceName)
			specWarnHeal:Play("kickcast")
			timerHeal:Start()
		else
			warningHeal:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 33238 then
		if self.Options.SpecWarn33238run then
			specWarnWhirlwind:Show()
			specWarnWhirlwind:Play("justrun")
		else
			warningWhirlwind:Show()
		end
		timerWhirlwind:Start()
		timerWhirlwindCD:Start()
	elseif args.spellId == 33054 and not args:IsDestTypePlayer() then
		warningShield:Show(args.destName)
	elseif args.spellId == 33147 and not args:IsDestTypePlayer() then
		warningPWS:Show(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 33131 then
		warningFelHunter:Show()
		timerFelhunter:Start()
	end
end
