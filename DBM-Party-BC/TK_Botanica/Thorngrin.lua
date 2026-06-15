local mod = DBM:NewMod(560, "DBM-Party-BC", 14, 257)
local L = mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(17978)

mod:SetModelID(14416)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 34661 34670",
	"SPELL_AURA_REMOVED 34661 34670"
)

local warnSacrifice		= mod:NewTargetNoFilterAnnounce(34661, 2)
local warnEnrage		= mod:NewSpellAnnounce(34670, 2, nil, "Healer|Tank")

local specWarnGTFO	= mod:NewSpecialWarningGTFO(34660, nil, nil, nil, 1, 8)

local timerSacrifice	= mod:NewTargetTimer(8, 34661, nil, nil, nil, 3)
local timerFrenzy		= mod:NewBuffActiveTimer(10, 34670, nil, "Healer|Tank")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 34661 then
		warnSacrifice:Show(args.destName)
		timerSacrifice:Start(args.destName)
	elseif args.spellId == 34670 then
		warnEnrage:Show(args.destName)
		timerFrenzy:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 34661 then
		timerSacrifice:Stop(args.destName)
	elseif args.spellId == 34670 then
		timerFrenzy:Stop(args.destName)
	end
end

do
	local player = UnitGUID("player")

	function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
		if spellId == 34660 and destGUID == player and self:AntiSpam(4, 1) then--Hellfire
			specWarnGTFO:Show(spellName)
			specWarnGTFO:Play("watchfeet")
		end
	end
	mod.SPELL_MISSED = mod.SPELL_DAMAGE
end
