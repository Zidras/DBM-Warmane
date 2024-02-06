local mod	= DBM:NewMod("Firemaw", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240206215210")
mod:SetCreatureID(11983)
mod:SetModelID(6377)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 23339 22539",
	"SPELL_AURA_APPLIED_DOSE 23341"
)

--(ability.id = 23339 or ability.id = 22539) and type = "begincast" or ability.id = 23341 and type = "cast"
local warnWingBuffet		= mod:NewCastAnnounce(23339, 2)
local warnShadowFlame		= mod:NewCastAnnounce(22539, 2)
local warnFlameBuffet		= mod:NewStackAnnounce(23341, 3)

local timerWingBuffet		= mod:NewNextTimer(30, 23339, nil, nil, nil, 2) -- Fixed timer. (25m Onyxia: [2024-02-04]@[19:03:58]) - "Wing Buffet-23339-npc:11983-134 = pull:29.97, 30.03, 30.02, 30.02
local timerShadowFlameCD	= mod:NewCDTimer(12.68, 22539, nil, false, nil, 5, nil, nil, true) -- ~4s variance [12.68-16.58]. Added "keep" arg. (25m Onyxia: [2024-02-04]@[19:03:58]) - "Shadow Flame-22539-npc:11983-134 = pull:16.71, 16.58, 15.07, 15.49, 14.93, 16.38, 12.68

function mod:OnCombatStart(delay)
	timerShadowFlameCD:Start(16.7-delay)
	timerWingBuffet:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 23339 then
		warnWingBuffet:Show()
		timerWingBuffet:Start()
	elseif spellId == 22539 then
		warnShadowFlame:Show()
		timerShadowFlameCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 23341 and args:IsPlayer() then
		local amount = args.amount or 1
		if (amount >= 4) and (amount % 2 == 0) then--Starting at 4, every even amount warn stack
			warnFlameBuffet:Show(amount)
		end
	end
end
