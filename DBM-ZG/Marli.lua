local mod	= DBM:NewMod("Marli", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(14510)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 24111 24300 24109",
	"SPELL_AURA_REMOVED 24111 24300",
	"SPELL_CAST_SUCCESS 24083"
)

--TODO, enlarge dispel warning valid?
local warnSpiders		= mod:NewSpellAnnounce(24083, 2)
local warnDrain			= mod:NewTargetNoFilterAnnounce(24300, 2, nil, "RemoveMagic|Healer")
local warnCorrosive		= mod:NewTargetNoFilterAnnounce(24111, 2, nil, "RemovePoison")
local warnEnlarge		= mod:NewTargetNoFilterAnnounce(24109, 3)

local specWarnEnlarge	= mod:NewSpecialWarningDispel(24109, "MagicDispeller", nil, nil, 1, 2)

local timerDrain		= mod:NewTargetTimer(7, 24300, nil, "RemoveMagic|Healer", nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)
local timerCorrosive	= mod:NewTargetTimer(30, 24111, nil, "RemovePoison", nil, 5, nil, DBM_COMMON_L.POISON_ICON)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 24111 then
		warnCorrosive:Show(args.destName)
		timerCorrosive:Start(args.destName)
	elseif args.spellId == 24300 and args:IsDestTypePlayer() then
		warnDrain:Show(args.destName)
		timerDrain:Start(args.destName)
	elseif args.spellId == 24109 then
		if self.Options.SpecWarn24109dispel then
			specWarnEnlarge:Show(args.destName)
			specWarnEnlarge:Play("dispelboss")
		else
			warnEnlarge:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 24111 then
		timerCorrosive:Stop(args.destName)
	elseif args.spellId == 24300 and args:IsDestTypePlayer() then
		timerDrain:Stop(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 24083 then
		warnSpiders:Show()
	end
end
