local mod	= DBM:NewMod("Galdarah", "DBM-Party-WotLK", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(29306)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL"
)

local timerTopot		= mod:NewCDTimer(20, 59829)
local timerVihr			= mod:NewCDTimer(21, 59824)
local timerCharge		= mod:NewCDTimer(21, 59827)
local specVihr			= mod:NewSpecialWarningMove(59824)
local specFlames		= mod:NewSpecialWarningMove(66682)
local timerNextFlames	= mod:NewNextTimer(11, 66682)
local soundFlames3		= mod:NewSound3(66682, nil, mod:IsRanged() or mod:IsHealer())
local phasetimer1		= mod:NewTimer(52, "TimerPhase1", 72262)
local phasewarn1		= mod:NewAnnounce("TimerPhase1", 4, "Interface\\Icons\\Spell_Shadow_ShadesOfDarkness")
local phasetimer2		= mod:NewTimer(52, "TimerPhase2", 72262)
local phasewarn2		= mod:NewAnnounce("TimerPhase2", 4, "Interface\\Icons\\Spell_Shadow_ShadesOfDarkness")

function mod:Flames_G(time)	-- Flames
	if self:IsInCombat() then
		local timer = time or 11
		timerNextFlames:Start(timer)
		self:ScheduleMethod(timer, "Flames_G")
		soundFlames3:Schedule(timer-3)
		specFlames:Schedule(timer)
	end
end

function mod:OnCombatStart(delay)
	timerVihr:Start()
	self:SetStage(1)
	phasetimer2:Start(52)
	self:Flames_G(7)
end

function mod:OnCombatEnd()
	self:UnscheduleMethod("Flames_G")
	timerNextFlames:Cancel()
	soundFlames3:Cancel()
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 59824 then
		timerVihr:Start()
		specVihr:Show()
	elseif args.spellId == 59829 then
		timerTopot:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2_1 or msg:find(L.YellPhase2_1) or msg == L.YellPhase2_2 or msg:find(L.YellPhase2_2) then
		if self.vb.phase == 1 then
			self:SetStage(2)
			phasetimer2:Cancel()
			phasewarn2:Show()
			phasetimer1:Start(52)
			timerVihr:Cancel()
			timerTopot:Cancel()
			timerCharge:Cancel()
			timerTopot:Start(25)
			timerCharge:Start(21)
		elseif self.vb.phase == 2 then
			phasetimer1:Cancel()
			phasewarn1:Show()
			phasetimer2:Start(52)
			timerVihr:Cancel()
			timerTopot:Cancel()
			timerCharge:Cancel()
			timerVihr:Start()
		end
	end
end