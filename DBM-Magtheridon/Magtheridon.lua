local mod	= DBM:NewMod("Magtheridon", "DBM-Magtheridon")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241008150020")
mod:SetCreatureID(17257)

mod:SetModelID(18527)
mod:RegisterCombat("emote", L.DBM_MAG_EMOTE_PULL)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 30528 30616",
	"SPELL_CAST_SUCCESS 30511",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Get custom voice pack sound for cubes
local warnHeal				= mod:NewSpellAnnounce(30528, 3)
local warnInfernal			= mod:NewSpellAnnounce(30511, 2)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnConflagration		= mod:NewSpellAnnounce(30757, 2)
local warnQuake				= mod:NewSpellAnnounce(30657, 2, "Interface\\Icons\\Spell_Nature_Earthquake")
local warnPhase3			= mod:NewPhaseAnnounce(3)

local specWarnBlastNova		= mod:NewSpecialWarningInterrupt(30616, nil, nil, nil, 3, 2)
local specWarnHeal			= mod:NewSpecialWarningInterrupt(30528, "HasInterrupt", nil, nil, 1, 2)

local timerHeal				= mod:NewCastTimer(2, 30528, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerPhase2			= mod:NewTimer(120, "timerP2", "Interface\\Icons\\INV_Weapon_Halberd16", nil, nil, 6)
local timerConflagration	= mod:NewCDTimer(30, 30757, nil, nil, nil, 2, nil, nil, true)
local timerQuake			= mod:NewCDTimer(50, 30657, nil, nil, nil, 2, "Interface\\Icons\\Spell_Nature_Earthquake", nil, true)
local timerBlastNovaCD		= mod:NewCDCountTimer(60, 30616, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerDebris			= mod:NewNextTimer(15, 36449, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.TANK_ICON)--Only happens once per fight, after the phase 3 yell.

mod.vb.blastNovaCounter = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.blastNovaCounter = 0
	timerPhase2:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 30528 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnHeal:Show(args.sourceName)
			specWarnHeal:Play("kickcast")
			timerHeal:Start()
		else
			warnHeal:Show()
		end
	elseif args.spellId == 30616 then
		self.vb.blastNovaCounter = self.vb.blastNovaCounter + 1
		specWarnBlastNova:Show(L.name)
		specWarnBlastNova:Play("kickcast")
		timerBlastNovaCD:Start(nil, self.vb.blastNovaCounter + 1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 30511 and self:AntiSpam(3, 1) then
		warnInfernal:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.DBM_MAG_YELL_PHASE2 or msg:find(L.DBM_MAG_YELL_PHASE2) or msg == L.DBM_MAG_ALTERNATIVE_YELL_PHASE2 or msg:find(L.DBM_MAG_ALTERNATIVE_YELL_PHASE2)) and self:GetStage(2, 1) then-- Alternative yell not in line with Blizzard: https://www.warmane.com/bugtracker/report/124104
		self:SetStage(2)
		warnPhase2:Show()
		timerBlastNovaCD:Start(nil, self.vb.blastNovaCounter + 1)
		timerPhase2:Cancel()
		timerConflagration:Start(10) -- First Conflagration cd at least 10-25 (15 sec randomness)
		timerQuake:Start(40) -- First Quake in 40 seconds
	elseif msg == L.DBM_MAG_YELL_PHASE3 or msg:find(L.DBM_MAG_YELL_PHASE3) then
		self:SetStage(3)
		warnPhase3:Show()
		--If time less than 20, extend existing timer to 20, else do nothing
		--[[if timerBlastNovaCD:GetRemaining(self.vb.blastNovaCounter + 1) < 20 then
			local elapsed, total = timerBlastNovaCD:GetTime(self.vb.blastNovaCounter + 1)
			local extend = 20 - (total-elapsed)
			DBM:Debug("timerBlastNovaCD extended by: "..extend, 2)
			timerBlastNovaCD:Stop()
			timerBlastNovaCD:Update(elapsed, total+extend, self.vb.blastNovaCounter + 1)
		end]]
		-- +18 to the timers
		timerConflagration:AddTime(18)
		timerQuake:AddTime(18)
		timerBlastNovaCD:AddTime(18, self.vb.blastNovaCounter + 1)
		timerDebris:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(30657) then
		timerQuake:Start()
		warnQuake:Show()
	-- "<99.72 20:36:19> [UNIT_SPELLCAST_SUCCEEDED] Magtheridon(31.4%-0.0%){Target:Player} -Blaze- [[boss1:Blaze::0:]]", -- [1219]
	-- "<100.03 20:36:19> [CLEU] SPELL_AURA_APPLIED#0x0F000000000A3F3A#Player#0x0F000000000A3F3A#Player#30757#Conflagration#DEBUFF#nil#", -- [1220]
	elseif spellName == GetSpellInfo(40637) then
		timerConflagration:Start()
		warnConflagration:Show()
	end
end
