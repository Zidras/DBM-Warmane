local mod	= DBM:NewMod("LeyGuardianEregos", "DBM-Party-WotLK", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(27656)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 51162 51170"
)

local warningShift		= mod:NewSpellAnnounce(51162, 4)
local warningShiftEnd	= mod:NewEndAnnounce(51162, 1)
local warningEnraged	= mod:NewSpellAnnounce(51170, 3)

local timerEnraged		= mod:NewBuffActiveTimer(12, 51170, nil, nil, nil, 6)
local timerShift		= mod:NewBuffActiveTimer(18, 51162, nil, nil, nil, 6)


function mod:OnCombatEnd(wipe)
	if not wipe then
		if DBT:GetBar(L.MakeitCountTimer) then
			DBT:CancelBar(L.MakeitCountTimer)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 51162 then
		warningShift:Show()
		warningShiftEnd:Schedule(18)
		timerShift:Start()
	elseif args.spellId == 51170 then
		warningEnraged:Show()
		timerEnraged:Start()
	end
end
