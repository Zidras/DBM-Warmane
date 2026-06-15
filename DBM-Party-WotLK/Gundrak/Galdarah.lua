local mod	= DBM:NewMod("Galdarah", "DBM-Party-WotLK", 5)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(29306)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 59824 59829",
	"CHAT_MSG_MONSTER_YELL"
)

local warnPhase1		= mod:NewAnnounce("TimerPhase1", 4, "Interface\\Icons\\Spell_Shadow_ShadesOfDarkness")
local warnPhase2		= mod:NewAnnounce("TimerPhase2", 4, "Interface\\Icons\\Spell_Shadow_ShadesOfDarkness")

local specWarnSlash		= mod:NewSpecialWarningMove(59824)

local timerStomp		= mod:NewCDTimer(20, 59829)
local timerSlash		= mod:NewCDTimer(21, 59824)
local timerCharge		= mod:NewCDTimer(21, 59827)
local timerPhase1		= mod:NewTimer(52, "TimerPhase1", 72262)
local timerPhase2		= mod:NewTimer(52, "TimerPhase2", 72262)

function mod:OnCombatStart()
	self:SetStage(1)
	timerSlash:Start()
	timerPhase2:Start(52)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 59824 then
		timerSlash:Start()
		specWarnSlash:Show()
	elseif args.spellId == 59829 then
		timerStomp:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2_1 or msg:find(L.YellPhase2_1) or msg == L.YellPhase2_2 or msg:find(L.YellPhase2_2) then
		if self.vb.phase == 1 then
			self:SetStage(2)
			timerPhase2:Cancel()
			warnPhase2:Show()
			timerPhase1:Start(52)
			timerSlash:Cancel()
			timerStomp:Cancel()
			timerCharge:Cancel()
			timerStomp:Start(25)
			timerCharge:Start(21)
		elseif self.vb.phase == 2 then
			self:SetStage(1)
			timerPhase1:Cancel()
			warnPhase1:Show()
			timerPhase2:Start(52)
			timerSlash:Cancel()
			timerStomp:Cancel()
			timerCharge:Cancel()
			timerSlash:Start()
		end
	end
end
