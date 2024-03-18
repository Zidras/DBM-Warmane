local mod	= DBM:NewMod("Magtheridon", "DBM-Magtheridon")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(17257)

mod:SetModelID(18527)
mod:RegisterCombat("emote", L.DBM_MAG_EMOTE_PULL)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 30528 30616",
	"SPELL_CAST_SUCCESS 30511",
	"SPELL_AURA_APPLIED 30757",
	"SPELL_AURA_REFRESH 30757",
	"UNIT_SPELLCAST_SUCCEEDED",
	"CHAT_MSG_MONSTER_YELL"
)

--Get custom voice pack sound for cubes
local warningHeal			= mod:NewSpellAnnounce(30528, 3)
local warningInfernal		= mod:NewSpellAnnounce(30511, 2)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnPhase3			= mod:NewPhaseAnnounce(3)

local specWarnBlastNova		= mod:NewSpecialWarningInterrupt(30616, nil, nil, nil, 3, 2)
local specWarnHeal			= mod:NewSpecialWarningInterrupt(30528, "HasInterrupt", nil, nil, 1, 2)

local timerHeal				= mod:NewCastTimer(2, 30528, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerPhase2			= mod:NewTimer(120+3, "timerP2", "135566", nil, nil, 6)
local timerBlastNovaCD		= mod:NewCDCountTimer(54+0.35, 30616, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerDebris			= mod:NewNextTimer(15, 36449, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.TANK_ICON)--Only happens once per fight, after the phase 3 yell.

local timerQuakeCD			= mod:NewCDTimer(53+2.65, 30657, nil, nil, nil, 2)
local specWarnGTFO			= mod:NewSpecialWarningGTFO(30757, nil, nil, nil, 1, 8)

mod.vb.blastNovaCounter = 1
local quakeName = DBM:GetSpellInfo(30657)

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.blastNovaCounter = 1
	timerPhase2:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 30528 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnHeal:Show(args.sourceName)
			specWarnHeal:Play("kickcast")
			timerHeal:Start()
		else
			warningHeal:Show()
		end
	elseif args.spellId == 30616 then
		self.vb.blastNovaCounter = self.vb.blastNovaCounter + 1
		specWarnBlastNova:Show(L.name)
		specWarnBlastNova:Play("kickcast")
		timerBlastNovaCD:Start(nil, self.vb.blastNovaCounter)
		timerQuakeCD:AddTime(10)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 30511 and self:AntiSpam(3, 1) then
		warningInfernal:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == quakeName then
		timerBlastNovaCD:AddTime(7, self.vb.blastNovaCounter)
		timerQuakeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30757 and args:IsPlayer() and self:AntiSpam(3, 3) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_MAG_YELL_PHASE2 or msg:find(L.DBM_MAG_YELL_PHASE2) then
		self:SetStage(2)
		warnPhase2:Show()
		timerBlastNovaCD:Start(55.65+3, self.vb.blastNovaCounter)
		timerQuakeCD:Start(28.3+3)
		timerPhase2:Cancel()
	elseif msg == L.DBM_MAG_YELL_PHASE3 or msg:find(L.DBM_MAG_YELL_PHASE3) then
		self:SetStage(3)
		warnPhase3:Show()
		--If time less than 20, extend existing timer to 20, else do nothing
--		if timerBlastNovaCD:GetRemaining(self.vb.blastNovaCounter) < 20 then
--			local elapsed, total = timerBlastNovaCD:GetTime(self.vb.blastNovaCounter)
--			local extend = 20 - (total-elapsed)
--			DBM:Debug("timerBlastNovaCD extended by: "..extend, 2)
--			timerBlastNovaCD:Stop()
--			timerBlastNovaCD:Update(elapsed, total+extend, self.vb.blastNovaCounter)
--		end
		timerBlastNovaCD:AddTime(18, self.vb.blastNovaCounter)
		timerQuakeCD:AddTime(18)
		timerDebris:Start()
	end
end
