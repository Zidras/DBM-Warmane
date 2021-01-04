local mod	= DBM:NewMod("ConstructorAndController", "DBM-Party-WotLK", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2469 $"):sub(12, -3))
mod:SetCreatureID(24201)
mod:SetZone()

mod:RegisterCombat("combat", 24200, 24201)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON",
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START"
)

local warningEnfeeble	= mod:NewTargetAnnounce(43650, 2)
local warningSummon		= mod:NewSpellAnnounce(52611, 3)
local timerEnfeeble		= mod:NewTargetTimer(6, 43650)
local timerGrip			= mod:NewCDTimer(27, 53276)
local timerUdari		= mod:NewCDTimer(21, 72326)

function mod:OnCombatStart()
	timerGrip:Start(25)
	timerUdari:Start(12)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(43650) then
		warningEnfeeble:Show(args.destName)
		timerEnfeeble:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(43650) then
		timerEnfeeble:Cancel(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(52611) and (args.GUID == 24201 or args.GUID == 24000) then
		warningSummon:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 53276 then
		timerGrip:Start()
	elseif args.spellId == 72326 then
		timerUdari:Start()
	end
end

mod.SPELL_CAST_START = mod.SPELL_CAST_SUCCESS