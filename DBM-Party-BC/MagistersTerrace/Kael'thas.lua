local mod = DBM:NewMod(533, "DBM-Party-BC", 16, 249)
local L = mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(24664)

mod:SetModelID(22906)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 36819",
	"SPELL_CAST_SUCCESS 44194 36819",
	"SPELL_AURA_APPLIED 46165",
	"SPELL_AURA_REMOVED 46165",
	"UNIT_SPELLCAST_SUCCEEDED",
	"CHAT_MSG_MONSTER_YELL"
)

local WarnShockBarrior		= mod:NewSpellAnnounce(46165, 3)
local WarnGravityLapse		= mod:NewSpellAnnounce(44224, 2)

local specwarnPyroblast		= mod:NewSpecialWarningInterrupt(36819, "HasInterrupt", nil, 2, 1, 2)
local specwarnPhoenix		= mod:NewSpecialWarningSwitch(44194, "-Healer", nil, nil, 1, 2)

local timerPyroblast		= mod:NewCastTimer(4, 36819, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerShockBarrior		= mod:NewNextTimer(60, 46165, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerPhoenix			= mod:NewCDTimer(45, 44194, nil, nil, nil, 1)--45-70?
local timerGravityLapse		= mod:NewBuffActiveTimer(35, 44194, nil, nil, nil, 6)
local timerGravityLapseCD	= mod:NewNextTimer(13.5, 44194, nil, nil, nil, 6)

mod.vb.interruptable = false

function mod:OnCombatStart(delay)
	self.vb.interruptable = false
	self:SetStage(1)
	if self:IsHeroic() then
		timerShockBarrior:Start(-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 36819 then
		self.vb.interruptable = true
		timerPyroblast:Start()
	elseif spellId == 44224 then
		WarnGravityLapse:Show()
		timerGravityLapse:Start()
		timerGravityLapseCD:Schedule(35)--Show after current lapse has ended
		if self.vb.phase < 2 then
			self:SetStage(2)
			timerShockBarrior:Stop()
			timerPhoenix:Stop()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 44194 then
		specwarnPhoenix:Show()
		specwarnPhoenix:Play("killmob")
		timerPhoenix:Start()
	elseif args.spellId == 36819 then
		self.vb.interruptable = false
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 46165 then
		WarnShockBarrior:Show(args.destName)
		timerShockBarrior:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 46165 and self.vb.interruptable then
		specwarnPyroblast:Show(args.destName)
		specwarnPyroblast:Play("kickcast")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(47109) and self.vb.phase < 2 then--Power Feedback
		self:SetStage(2)
		timerShockBarrior:Stop()
		timerPhoenix:Stop()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.KaelP2 and self.vb.phase < 2 then
		self:SetStage(2)
		timerShockBarrior:Stop()
		timerPhoenix:Stop()
	end
end
