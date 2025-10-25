local mod	= DBM:NewMod("Razorscale", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20251020234840")
mod:SetCreatureID(33186)
mod:SetEncounterID(746)

mod:RegisterCombat("combat_yell", L.YellAir)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 63317 64021 63236",
	"SPELL_AURA_APPLIED 64771",
	"SPELL_AURA_APPLIED_DOSE 64771",
	"SPELL_DAMAGE 64733 64704",
	"SPELL_MISSED 64733 64704",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

-- General
local enrageTimer					= mod:NewBerserkTimer(600)

-- Stage One
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1))
local warnTurretsReadySoon			= mod:NewAnnounce("warnTurretsReadySoon", 1, 48642)
local warnTurretsReady				= mod:NewAnnounce("warnTurretsReady", 3, 48642)
local warnDevouringFlame			= mod:NewTargetAnnounce(63236, 2, nil, false)--Very spammy, requires turning on AND disabling target filter. Power user setting

local specWarnDevouringFlame		= mod:NewSpecialWarningMove(64733, nil, nil, nil, 1, 2)
local specWarnDevouringFlameYou		= mod:NewSpecialWarningYou(64733, false, nil, nil, 1, 2)
local specWarnDevouringFlameNear	= mod:NewSpecialWarningClose(64733, false, nil, nil, 1, 2)
local yellDevouringFlame			= mod:NewYell(64733)

local timerTurret1					= mod:NewTimer(54, "timerTurret1", 48642, nil, nil, 5, DBM_COMMON_L.IMPORTANT_ICON) -- Fixed timer: 54s. Then +21 on every subsequent turret. (Lordaeron: 25m review2022/07/10 || 10m [2025-09-06]@[20:43:48] || 25m [2025-10-20]@[19:41:45]) - "?-Harpoon Turret is ready for use!-npc:Razorscale Controller = pull:54.05/[Stage 1/0.00] 54.05, 21.05, 102.27, 21.08, Stage 2/34.38" || "?-Harpoon Turret is ready for use!-npc:Razorscale Controller = pull:54.08/[Stage 1/0.00] 54.08, 21.02, 21.07, 21.05, Stage 2/49.28"
local timerTurret2					= mod:NewTimer(75, "timerTurret2", 48642, nil, nil, 5, DBM_COMMON_L.IMPORTANT_ICON)
local timerTurret3					= mod:NewTimer(96, "timerTurret3", 48642, nil, nil, 5, DBM_COMMON_L.IMPORTANT_ICON)
local timerTurret4					= mod:NewTimer(117, "timerTurret4", 48642, nil, nil, 5, DBM_COMMON_L.IMPORTANT_ICON)

-- Stage Two
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2))
local warnFuseArmor					= mod:NewStackAnnounce(64771, 2, nil, "Tank")

local specWarnFuseArmor				= mod:NewSpecialWarningStack(64771, nil, 2, nil, nil, 1, 6)
local specWarnFuseArmorOther		= mod:NewSpecialWarningTaunt(64771, nil, nil, nil, 1, 2)

local timerDeepBreathCooldown		= mod:NewCDTimer(20.1, 64021, nil, nil, nil, 5) -- ~3s variance (25 man log review 2022/07/10) - 23.0, 20.1
local timerDeepBreathCast			= mod:NewCastTimer(2.5, 64021)
local timerGrounded					= mod:NewTimer(45, "timerGrounded", nil, nil, nil, 6)
local timerFuseArmorCD				= mod:NewCDTimer(10.1, 64771, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON) -- 10s variance (25 man log review 2022/07/10) - 10.1, 20.1

mod:GroupSpells(63236, 64733) -- Devouring Flame (cast and damage)

local combattime = 0
local isGrounded = false

function mod:FlameTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnDevouringFlameYou:Show()
		specWarnDevouringFlameYou:Play("targetyou")
		yellDevouringFlame:Yell()
	elseif self:CheckNearby(11, targetname) then
		specWarnDevouringFlameNear:Show(targetname)
		specWarnDevouringFlameNear:Play("runaway")
	else
		warnDevouringFlame:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	isGrounded = false
	enrageTimer:Start(-delay)
	combattime = GetTime()
	if self:IsDifficulty("normal10") then
		warnTurretsReadySoon:Schedule(54-delay)
		warnTurretsReady:Schedule(75-delay)
		timerTurret1:Start(-delay)
		timerTurret2:Start(-delay)
	else
		warnTurretsReadySoon:Schedule(96-delay)
		warnTurretsReady:Schedule(117-delay)
		timerTurret1:Start(-delay) -- 54sec
		timerTurret2:Start(-delay) -- +21
		timerTurret3:Start(-delay) -- +21
		timerTurret4:Start(-delay) -- +21
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(63317, 64021) then	-- Flame Breath
		timerDeepBreathCast:Start()
		timerDeepBreathCooldown:Start()
	elseif args.spellId == 63236 then
		self:BossTargetScanner(args.sourceGUID, "FlameTarget", 0.1, 12)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 64771 then		-- Fuse Armor
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnFuseArmor:Show(args.amount)
				specWarnFuseArmor:Play("stackhigh")
			else
				local _, _, _, _, _, _, expireTime = DBM:UnitDebuff("player", args.spellName)
				local remaining
				if expireTime then
					remaining = expireTime-GetTime()
				end
				if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 12) then
					specWarnFuseArmorOther:Show(args.destName)
					specWarnFuseArmorOther:Play("tauntboss")
				else
					warnFuseArmor:Show(args.destName, amount)
				end
			end
		else
			warnFuseArmor:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if (spellId == 64733 or spellId == 64704) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnDevouringFlame:Show()
		specWarnDevouringFlame:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(emote)
	if emote == L.EmotePhase2 or emote:find(L.EmotePhase2) then
		-- phase2
		self:SetStage(2)
		isGrounded = true
		timerTurret1:Stop()
		timerTurret2:Stop()
		timerTurret3:Stop()
		timerTurret4:Stop()
		timerGrounded:Stop()
		timerFuseArmorCD:Start(19) -- REVIEW! variance? (25 man log review 2022/07/10) - 19
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if isGrounded and (msg == L.YellAir or msg == L.YellAir2) and GetTime() - combattime > 30 then
		DBM:AddSpecialEventToTranscriptorLog("Air Phase")
		isGrounded = false -- warmane resets the timers idk why
		if self:IsDifficulty("normal10") then -- not sure?
			warnTurretsReadySoon:Schedule(40)
			warnTurretsReady:Schedule(61)
			timerTurret1:Start(40)
			timerTurret2:Start(61) -- +21
		else
			warnTurretsReadySoon:Schedule(123)
			warnTurretsReady:Schedule(133)
			timerTurret1:Start(70) -- Lordaeron 25m 20250112: "?-Harpoon Turret is ready for use!-npc:Razorscale Controller = pull:54.09/[Stage 1/0.00] 54.09, 21.09, 21.05, 21.09, 130.14, 21.06, 21.05, 21.04, Stage 2/8.36"
			timerTurret2:Start(91)
			timerTurret3:Start(112)
			timerTurret4:Start(133)
		end
	elseif msg == L.YellGround then
		DBM:AddSpecialEventToTranscriptorLog("Ground Phase")
		timerGrounded:Start()
		isGrounded = true
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(64821) then--Fuse Armor
		timerFuseArmorCD:Start()
	end
end
