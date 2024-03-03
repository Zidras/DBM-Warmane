local mod	= DBM:NewMod("Gahzranka", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(15114)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 16099 22421"
)

local warnBreath	= mod:NewCastAnnounce(16099)
local warnGeyser	= mod:NewCastAnnounce(22421)

local timerBreathCD	= mod:NewCDTimer(8, 16099, nil, false) -- every 5-20 secs
local timerGeyserCD	= mod:NewCDTimer(22, 22421, nil, false) -- every 22-32 secs

function mod:OnCombatStart(delay)
	timerBreathCD:Start(8-delay)
	timerGeyserCD:Start(25-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 16099 then
		warnBreath:Show()
		timerBreathCD:Start()
	elseif args.spellId == 22421 then
		warnGeyser:Show()
		timerGeyserCD:Start()
	end
end
