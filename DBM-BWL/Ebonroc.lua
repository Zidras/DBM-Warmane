local mod	= DBM:NewMod("Ebonroc", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240209130416")
mod:SetCreatureID(14601)
mod:SetModelID(6377)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 23339 22539",
	"SPELL_AURA_APPLIED 23340",
	"SPELL_AURA_REMOVED 23340"
)

--(ability.id = 23339 or ability.id = 22539) and type = "begincast"
local warnWingBuffet	= mod:NewCastAnnounce(23339, 2)
local warnShadowFlame	= mod:NewCastAnnounce(22539, 2)
local warnShadow		= mod:NewTargetNoFilterAnnounce(23340, 4, nil, "Tank|Healer")

local specWarnShadowYou	= mod:NewSpecialWarningYou(23340, nil, nil, nil, 1, 2)
local specWarnShadow	= mod:NewSpecialWarningTaunt(23340, nil, nil, nil, 1, 2)

local timerWingBuffet	= mod:NewNextTimer(30, 23339, nil, nil, nil, 2) -- Fixed timer. (25m Onyxia: [2024-02-04]@[19:03:58]) - "Wing Buffet-23339-npc:14601-356 = pull:29.98, 30.03
local timerShadowFlameCD= mod:NewNextTimer(20, 22539, nil, false, nil, 5) -- 08/02/2024 Warmane Changelog: Fixed Shadow Flame timer for Ebonroc. 20 seconds. Obsolete log parse will be kept for history: ~5s variance [14.02-19.44]. (25m Onyxia: [2024-02-04]@[19:03:58]) - "Shadow Flame-22539-npc:14601-356 = pull:13.31, 19.44, 17.96, 14.02, 16.53
local timerShadow		= mod:NewTargetTimer(8, 23340, nil, "Tank|Healer", 2, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerShadowFlameCD:Start(-delay)
	timerWingBuffet:Start(-delay)
end

function mod:SPELL_CAST_START(args)--did not see ebon use any of these abilities
	local spellId = args.spellId
	if spellId == 23339 then
		warnWingBuffet:Show()
		timerWingBuffet:Start()
	elseif spellId == 22539 then
		warnShadowFlame:Show()
		timerShadowFlameCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 23340 then
		if args:IsPlayer() then
			specWarnShadowYou:Show()
			specWarnShadowYou:Play("targetyou")
		else
			if self.Options.SpecWarn23340taunt and (self:IsTank() or not DBM.Options.FilterTankSpec) then
				specWarnShadow:Show(args.destName)
				specWarnShadow:Play("tauntboss")
			else
				warnShadow:Show(args.destName)
			end
		end
		timerShadow:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 23340 then
		timerShadow:Stop(args.destName)
	end
end
