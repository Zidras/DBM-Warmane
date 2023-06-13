local mod	= DBM:NewMod(529, "DBM-Party-BC", 1, 248)

mod:SetRevision("20220518110528")
mod:SetCreatureID(17537, 17307)

mod:SetModelID(18407)
mod:SetModelOffset(-0.2, 0, -0.3)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 30689",
	"SPELL_AURA_REMOVED 30689"
)

local warnMark		= mod:NewTargetNoFilterAnnounce(30689)

local specwarnMark	= mod:NewSpecialWarningYou(30689, nil, nil, nil, 1, 2)
local yellMark		= mod:NewYell(30689)

local timerMark		= mod:NewTargetTimer(6, 30689, nil, nil, nil, 3)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30689 then
		timerMark:Start(args.destName)
		if args:IsPlayer() then
			specwarnMark:Show()
			specwarnMark:Play("targetyou")
			yellMark:Yell()
		else
			warnMark:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 30689 then
		timerMark:Stop(args.destName)
	end
end
