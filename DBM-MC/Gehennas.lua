local mod	= DBM:NewMod("Gehennas", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(12259)--, 11661

mod:SetModelID(13030)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 19716 19717",
	"SPELL_AURA_APPLIED 20277"
)

--[[
(ability.id = 19716 or ability.id = 19717) and type = "cast"
--]]
local warnRainFire	= mod:NewSpellAnnounce(19717, 2, nil, false)
local warnCurse		= mod:NewSpellAnnounce(19716, 3)
local warnFist		= mod:NewTargetAnnounce(20277, 2, nil, false, 2)

local specWarnGTFO	= mod:NewSpecialWarningGTFO(19717, nil, nil, nil, 1, 8)

local timerRoF		= mod:NewCDTimer(6, 19717, nil, false, nil, 3)
local timerCurse	= mod:NewCDTimer(26.7, 19716, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.CURSE_ICON)--26.7-30
--local timerFist		= mod:NewBuffActiveTimer(4, 20277, nil, false, 2, 3)

function mod:OnCombatStart(delay)
	timerCurse:Start(6-delay)
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE 19717",
			"SPELL_PERIODIC_MISSED 19717"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 19716 and args:IsSrcTypeHostile() then
		warnCurse:Show()
		timerCurse:Start()
	elseif args.spellId == 19717 and args:IsSrcTypeHostile() then
		warnRainFire:Show()
		timerRoF:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 20277 and args:IsDestTypePlayer() then
		warnFist:CombinedShow(0.3, args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
	if spellId == 19717 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
