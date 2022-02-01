local mod	= DBM:NewMod("Krikthir", "DBM-Party-WotLK", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(28684)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 52592 59368"
)

local warnCurse	= mod:NewSpellAnnounce(52592, 2, nil, false)

local specWarnCurse	= mod:NewSpecialWarningYou(52592, nil, nil, nil, 1, 2)
local yellCurse		= mod:NewYell(52592)

local timerCurseCD	= mod:NewCDTimer(10, 52592, nil, nil, nil, 2)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(52592, 59368) then
		timerCurseCD:Start()
		if args:IsPlayer() then
			specWarnCurse:Show()
			specWarnCurse:Play("targetyou")
			yellCurse:Yell()
		else
			warnCurse:Show()
		end
	end
end