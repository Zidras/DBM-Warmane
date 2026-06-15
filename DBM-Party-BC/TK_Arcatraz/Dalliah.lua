local mod = DBM:NewMod(549, "DBM-Party-BC", 15, 254)
local L = mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(20885)

mod:SetModelID(19888)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 39013 36144 36175 36142",
	"SPELL_AURA_APPLIED 39009 36173",
	"SPELL_AURA_REMOVED 39009 36173"
)

--LOG THIS, needs whirlwind CD timer
local warnGift			= mod:NewTargetNoFilterAnnounce(39009, 3, nil, "Healer", 2)

local specwarnWhirlwind	= mod:NewSpecialWarningRun(36175, "Melee", nil, nil, 4, 6)
local specwarnHeal		= mod:NewSpecialWarningInterrupt(39013, "HasInterrupt", nil, 2, 1, 2)

local timerGift			= mod:NewTargetTimer(10, 39009, nil, "Healer", 4, 5, nil, DBM_COMMON_L.HEALER_ICON)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(39013, 36144) and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specwarnHeal:Show(args.sourceName)
		specwarnHeal:Play("kickcast")
	elseif args:IsSpellID(36175, 36142) then
		specwarnWhirlwind:Show()
		specwarnWhirlwind:Play("whirlwind")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(39009, 36173) then
		warnGift:Show(args.destName)
		timerGift:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(39009, 36173) then
		timerGift:Stop(args.destName)
	end
end
