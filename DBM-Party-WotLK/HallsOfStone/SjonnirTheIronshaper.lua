local mod	= DBM:NewMod("SjonnirTheIronshaper", "DBM-Party-WotLK", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(27978)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 59848 50840 59861 51849 50834 59846"
)

local warningCharge		= mod:NewTargetAnnounce(50834, 2)
local warningRing		= mod:NewSpellAnnounce(50840, 3)

local specWarnCharge	= mod:NewSpecialWarningMoveAway(50834, nil, nil, nil, 1, 2)
local yellCharge		= mod:NewYell(50834)

local timerCharge		= mod:NewTargetTimer(10, 50834)
local timerChargeCD		= mod:NewCDTimer(25, 50834, nil, nil, nil, 3)
local timerRingCD		= mod:NewCDTimer(25, 50840, nil, nil, nil, 2)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(59848, 50840, 59861, 51849) then
		warningRing:Show()
		timerRingCD:Start()
	elseif args:IsSpellID(50834, 59846) then
		if args:IsPlayer() then
			specWarnCharge:Show()
			specWarnCharge:Play("runout")
			yellCharge:Yell()
		else
			warningCharge:Show(args.destName)
		end
		timerCharge:Start(args.destName)
		timerChargeCD:Start()
	end
end
