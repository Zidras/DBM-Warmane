local mod	= DBM:NewMod("NovosTheSummoner", "DBM-Party-WotLK", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3635 $"):sub(12, -3))
mod:SetCreatureID(26631)
mod:SetZone()

mod:RegisterCombat("yell", L.YellPull)
mod:RegisterKill("yell", L.YellKill)
mod:SetWipeTime(25)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_SUCCESS"
)

local WarnCrystalHandler 	= mod:NewAnnounce("WarnCrystalHandler")
local warnPhase2			= mod:NewPhaseAnnounce(2)
local timerInsanity			= mod:NewCDTimer(35, 57496)
local timerFrenzy			= mod:NewCDTimer(16, 39249)
local timerCrystalHandler 	= mod:NewTimer(20, "timerCrystalHandler")

local CrystalHandlers = 4

function mod:OnCombatStart(delay)
	timerCrystalHandler:Start(25.5-delay)
	timerInsanity:Start(20)
	timerFrenzy:Start(10)
	CrystalHandlers = 4
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.HandlerYell then
		CrystalHandlers = CrystalHandlers - 1
		if CrystalHandlers > 0 then
			WarnCrystalHandler:Show(CrystalHandlers)
			timerCrystalHandler:Start()
		else
			WarnCrystalHandler:Show(CrystalHandlers)
		end
	elseif msg == L.Phase2 then
		warnPhase2:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 57496 then
		timerInsanity:Start()
	elseif args.spellId == 59829 then
		timerFrenzy:Start()
	end
end