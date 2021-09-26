local mod	= DBM:NewMod("Jindo", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(11380)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 24306 17172 24261",
	"SPELL_AURA_REMOVED 17172",
	"SPELL_CAST_SUCCESS 24466",
	"SPELL_SUMMON 24309 24262"
)

local warnDelusion			= mod:NewTargetNoFilterAnnounce(24306, 2, nil, "RemoveCurse")
local warnHex				= mod:NewTargetNoFilterAnnounce(17172, 2, nil, "RemoveMagic|Healer")
local warnBrainWash			= mod:NewTargetNoFilterAnnounce(24261, 4)
local warnBanish			= mod:NewTargetNoFilterAnnounce(24466, 2)

local specWarnHealingWard	= mod:NewSpecialWarningSwitch(24309, "Dps", nil, nil, 1, 2)
local specWarnBrainTotem	= mod:NewSpecialWarningSwitch(24262, "Dps", nil, nil, 1, 2)
local specWarnDelusion		= mod:NewSpecialWarningYou(24306, nil, nil, nil, 1, 2)--Don't remember why this has special warning, but trusting 2011 me

local timerHex				= mod:NewTargetTimer(5, 17172, nil, "RemoveMagic|Healer", nil, 5, nil, DBM_CORE_L.MAGIC_ICON)
local timerDelusion			= mod:NewTargetTimer(20, 24306, nil, "RemoveCurse", nil, 5, nil, DBM_CORE_L.CURSE_ICON)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 24306 then
		timerDelusion:Start(args.destName)
		if args:IsPlayer() then
			specWarnDelusion:Show()
			specWarnDelusion:Play("targetyou")
		else
			warnDelusion:Show(args.destName)
		end
	elseif args.spellId == 17172 and args:IsDestTypePlayer() then
		timerHex:Start(args.destName)
		warnHex:Show(args.destName)
	elseif args.spellId == 24261 then
		warnBrainWash:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 17172 and args:IsDestTypePlayer() then
		timerHex:Stop(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 24466 and args:IsSrcTypeHostile() then
		warnBanish:Show(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 24309 and args:IsDestTypeHostile() then
		specWarnHealingWard:Show()
		specWarnHealingWard:Play("attacktotem")
	elseif args.spellId == 24262 then
		specWarnBrainTotem:Show()
		specWarnBrainTotem:Play("attacktotem")
	end
end
