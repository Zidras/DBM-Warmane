local mod	= DBM:NewMod("VoidReaver", "DBM-TheEye")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(19516)

mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS"
)

local warnOrb			= mod:NewTargetAnnounce(34172, 2, nil, false)
local warnKnockBack		= mod:NewSpellAnnounce(25778, 4)
local warnPounding		= mod:NewSpellAnnounce(34162, 3)

local specWarnOrb		= mod:NewSpecialWarningMove(34172,false)
--local yellOrb			= mod:NewYellMe(34172,false)

local timerKnockBack	= mod:NewCDTimer(20, 25778)
local timerPounding		= mod:NewCDTimer(13, 34162)

local berserkTimer		= mod:NewBerserkTimer(600)

function mod:OnCombatStart(delay)
	timerPounding:Start()
	berserkTimer:Start(-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 34172 then
		warnOrb:Show(args.destName)
		if args:IsPlayer() then
			specWarnOrb:Show()
			--yellOrb:Yell()
		end
	elseif args.spellId == 34162 then
		warnPounding:Show()
		timerPounding:Start()
	elseif args.spellId == 25778 then
		warnKnockBack:Show()
		timerKnockBack:Start()
	end
end
