local mod	= DBM:NewMod("Flamegor", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240225225625")
mod:SetCreatureID(11981)
mod:SetModelID(6377)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 23339 22539",
	"SPELL_CAST_SUCCESS 23342",
	"SPELL_AURA_APPLIED 23342",
	"SPELL_AURA_REMOVED 23342"
)

--(ability.id = 23339 or ability.id = 22539) and type = "begincast" or ability.id = 23342 and type = "cast"
local warnWingBuffet		= mod:NewCastAnnounce(23339, 2)
local warnShadowFlame		= mod:NewCastAnnounce(22539, 2)
local warnFrenzy			= mod:NewSpellAnnounce(23342, 3, nil, "Tank|RemoveEnrage|Healer", 4)

local specWarnFrenzy		= mod:NewSpecialWarningDispel(23342, "RemoveEnrage", nil, nil, 1, 6)

local timerWingBuffet		= mod:NewNextTimer(30, 23339, nil, nil, nil, 2) -- Fixed timer. (25m Onyxia: [2024-02-04]@[19:03:58] || [2024-02-25]@[19:27:42]) - "Wing Buffet-23339-npc:11981-357 = pull:31.79, 30.02" || "Wing Buffet-23339-npc:11981-357 = pull:29.99, 30.02
local timerShadowFlameCD	= mod:NewNextTimer(20, 22539, nil, false, nil, 5) -- 08/02/2024 Warmane Changelog: Fixed Shadow Flame timer for Flamegor. 20 seconds. Obsolete log parse will be kept for history: ~5s variance [12.55-17.44]. (25m Onyxia: [2024-02-04]@[19:03:58]) - "Shadow Flame-22539-npc:11981-357 = pull:17.22, 12.55, 17.03, 17.74"
local timerFrenzy			= mod:NewBuffActiveTimer(10, 23342, nil, "Tank|RemoveEnrage|Healer", 4, 5, nil, DBM_COMMON_L.ENRAGE_ICON)

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

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 23342 and args:IsSrcTypeHostile() then
		if self.Options.SpecWarn23342dispel then
			specWarnFrenzy:Show(args.sourceName)
			specWarnFrenzy:Play("enrage")
		else
			warnFrenzy:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)--did not see ebon use any of these abilities
	local spellId = args.spellId
	if spellId == 23342 then
		timerFrenzy:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)--did not see ebon use any of these abilities
	local spellId = args.spellId
	if spellId == 23342 then
		timerFrenzy:Stop()
	end
end
