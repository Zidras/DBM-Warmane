local mod	= DBM:NewMod("Jindo", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
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

local timerHex				= mod:NewTargetTimer(5, 17172, nil, "RemoveMagic|Healer", nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)
local timerDelusion			= mod:NewTargetTimer(20, 24306, nil, "RemoveCurse", nil, 5, nil, DBM_COMMON_L.CURSE_ICON)

local timerBrainTotemCD		= mod:NewCDTimer(18, 24262, nil, false)
local timerHealingWardCD	= mod:NewCDTimer(14, 24309, nil, false)
local timerHexCD			= mod:NewCDTimer(12, 17172, nil, false)
local timerDelusionCD		= mod:NewCDTimer(4, 24306, nil, false)
local timerTeleportCD		= mod:NewCDTimer(15, "Teleport", nil, false)-- CC implementation is hacked, no actual spell cast, not trackable

function mod:OnCombatStart(delay)
	timerBrainTotemCD:Start(20-delay)
	timerHealingWardCD:Start(16-delay)
	timerHexCD:Start(8-delay)
	timerDelusionCD:Start(10-delay)
	timerTeleportCD:Start(5-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 24306 then
		timerDelusion:Start(args.destName)
		if args:IsPlayer() then
			specWarnDelusion:Show()
			specWarnDelusion:Play("targetyou")
		else
			warnDelusion:Show(args.destName)
		end
		timerDelusionCD:Start()
	elseif args.spellId == 17172 and args:IsDestTypePlayer() then
		timerHex:Start(args.destName)
		warnHex:Show(args.destName)
		timerHexCD:Start()
	elseif args.spellId == 24261 then
		warnBrainWash:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 17172 and args:IsDestTypePlayer() then
		timerHex:Stop(args.destName)
	elseif args.spellID == 24306 and args:IsDestTypePlayer() then
		timerDelusion:Stop(args.destName)
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
		timerHealingWardCD:Start()
	elseif args.spellId == 24262 then
		specWarnBrainTotem:Show()
		specWarnBrainTotem:Play("attacktotem")
		timerBrainTotemCD:Start()
	end
end
