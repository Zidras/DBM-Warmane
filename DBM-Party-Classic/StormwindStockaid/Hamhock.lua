local mod	= DBM:NewMod("Hamhock", "DBM-Party-Classic", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(1717)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 6742"
)

--TODO, add timer for chain lightning if it's not spam cast
local warningBloodlust				= mod:NewTargetNoFilterAnnounce(6742, 2)

mod:AddRangeFrameOption("10")

function mod:OnCombatStart()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 6742 and args:IsDestTypeHostile() then
		warningBloodlust:Show(args.destName)
	end
end
