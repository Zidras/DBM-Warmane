local mod	= DBM:NewMod("Freya", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220709133644")

mod:SetCreatureID(32906)
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)
mod:RegisterEventsInCombat(
	"SPELL_CAST_START 62437 62859",
	"SPELL_CAST_SUCCESS 62678 62873 62619 63571 62589 64650 63601 62451 62865",
	"SPELL_AURA_APPLIED 62283 62438 62439 62861 62862 62930 62451 62865",
	"SPELL_AURA_REMOVED 62519 62861 62438 63571 62589",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

-- Trash: 33430 Guardian Lasher (flower)
-- 33355 (nymph)
-- 33354 (tree)

--
-- Elder Stonebark (ground tremor / fist of stone)
-- Elder Brightleaf (unstable sunbeam)

-- General
local warnSimulKill			= mod:NewAnnounce("WarnSimulKill", 1)

local timerEnrage			= mod:NewBerserkTimer(600)

-- Stage One
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1))
local warnNatureFury		= mod:NewTargetAnnounce(63571, 2)

local specWarnLifebinder	= mod:NewSpecialWarningSwitch(62869, "Dps", nil, nil, 1, 2)
local specWarnNatureFury	= mod:NewSpecialWarningMoveAway(63571, nil, nil, nil, 1, 2)
local yellNatureFury		= mod:NewYell(63571)

local timerAlliesOfNature	= mod:NewNextTimer(60, 62678, nil, nil, nil, 1, 62947, DBM_COMMON_L.IMPORTANT_ICON..DBM_COMMON_L.DAMAGE_ICON)--No longer has CD, they spawn instant last set is dead, and not a second sooner, except first set
local timerSimulKill		= mod:NewTimer(12, "TimerSimulKill", nil, nil, nil, 5, DBM_COMMON_L.DAMAGE_ICON, nil, nil, nil, nil, nil, nil, 62678)
local timerNatureFury		= mod:NewTargetTimer(10, 63571, nil, nil, nil, 3)
local timerLifebinderCD		= mod:NewCDTimer(40, 62584, nil, nil, nil, 1, nil, DBM_COMMON_L.IMPORTANT_ICON) -- 10s variance (S2 VOD review)

mod:AddRangeFrameOption(8, 63571)
mod:AddSetIconOption("SetIconOnFury", 63571, false, false, {7, 8})

-- Stage Two
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2))
local warnPhase2			= mod:NewPhaseAnnounce(2, 3, nil, nil, nil, nil, nil, 2)

local specWarnNatureBomb	= mod:NewSpecialWarningMove(64587)

local timerNextNatureBomb	= mod:NewNextTimer(11, 64587)

-- Hard Mode
mod:AddTimerLine(DBM_COMMON_L.HEROIC_ICON..DBM_CORE_L.HARD_MODE)
local warnUnstableBeamSoon	= mod:NewSoonAnnounce(62865, 3) -- Hard mode Sun Beam Elder Brightleaf Alive
local warnIronRoots			= mod:NewTargetNoFilterAnnounce(62438, 2) -- Hard mode Elder Ironbranch Alive

local yellIronRoots			= mod:NewYell(62438)
local specWarnGroundTremor	= mod:NewSpecialWarningCast(62859, "SpellCaster", nil, 2, 1, 2)	-- Hard mode Elder Stonebark Alive
local specWarnUnstableBeam	= mod:NewSpecialWarningMove(62865, nil, nil, nil, 1, 2)	-- Hard mode Elder Brightleaf Alive

local timerGroundTremorCD	= mod:NewCDTimer(25.5, 62859, nil, nil, nil, 2)--22.9-47.8
local timerIronRootsCD		= mod:NewCDTimer(12, 62438, nil, nil, nil, 3) -- 4s variance (could be 10s) (2022/07/05 log review) - 12, 16
local timerUnstableBeamCD	= mod:NewCDTimer(15, 62865, nil, nil, nil, 2) -- Hard mode Sun Beam. 5s variance [15-20] (2022/07/05 log review) - 18.7, 16.6

mod:AddSetIconOption("SetIconOnRoots", 62438, false, false, {6, 5, 4})

local adds = {}
mod.vb.altIcon = true
mod.vb.iconId = 6
mod.vb.waves = 0
mod.vb.isHardMode = false

function mod:OnCombatStart(delay)
	self.vb.altIcon = true
	self.vb.iconId = 6
	self.vb.waves = 0
	self:SetStage(1)
	timerEnrage:Start(-delay)
	table.wipe(adds)
	timerAlliesOfNature:Start(10-delay)
	timerLifebinderCD:Start(25-delay)
end

function mod:OnCombatEnd(wipe)
	timerNextNatureBomb:Cancel()
	specWarnNatureBomb:Cancel()
	if not wipe then
		if DBT:GetBar(L.TrashRespawnTimer) then
			DBT:CancelBar(L.TrashRespawnTimer)
		end
	end
	if self.Options.HealthFrame then
		DBM.BossHealth:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62437, 62859) then
		specWarnGroundTremor:Show()
		specWarnGroundTremor:Play("stopcast")
		timerGroundTremorCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(62678, 62873) then -- REVIEW! Summon Allies of Nature, never fired on Warmane. Instead there are Summon Wave spells: 62688 (confirmed), 62685 and 62686. To be confirmed adequacy via logs
		DBM:AddMsg("Summon Allies of Nature unhidden from combat log. Notify Zidras on Discord or GitHub")
		self.vb.waves = self.vb.waves + 1
		if self.vb.waves < 6 then
			timerAlliesOfNature:Start()
		end
	elseif args.spellId == 62619 and self:GetUnitCreatureId(args.sourceName) == 33228 then -- Pheromones spell, cast by newly spawned Eonar's Gift second they spawn to allow melee to dps them while protector is up.
		DBM:AddMsg("Pheromones unhidden from combat log. Notify Zidras on Discord or GitHub") -- REVIEW! Pheromones never fired on Warmane. Instead there is only an emote event.
		specWarnLifebinder:Show()
		specWarnLifebinder:Play("targetchange")
		timerLifebinderCD:Start()
	elseif args:IsSpellID(63571, 62589) then -- Nature's Fury
		if self.Options.SetIconOnFury then
			self.vb.altIcon = not self.vb.altIcon	--Alternates between Skull and X
			self:SetIcon(args.destName, self.vb.altIcon and 7 or 8, 10)
		end
		if args:IsPlayer() then -- only cast on players; no need to check destFlags
			specWarnNatureFury:Show()
			specWarnNatureFury:Play("runout")
			yellNatureFury:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		else
			warnNatureFury:Show(args.destName)
		end
		timerNatureFury:Start(args.destName)
	elseif spellId == 64650 then -- Nature Bomb
		if self:AntiSpam(1, 64650) and self:IsInCombat() then
			timerNextNatureBomb:Start(9.95)
			specWarnNatureBomb:Cancel()
			specWarnNatureBomb:Schedule(9.95)
		end
	elseif spellId == 63601 then -- Strengthened Iron Roots
		DBM:AddMsg("Strengthened Iron Roots unhidden from combat log. Notify Zidras on Discord or GitHub") -- REVIEW! Strengthened Iron Roots never fired on Warmane. Instead there is only an emote event.
		--if self.vb.phase == 2 then
			timerIronRootsCD:Start()
		--end
	elseif args:IsSpellID(62451, 62865) then -- Unstable Energy (Sun Beam)
		timerUnstableBeamCD:Start()
		warnUnstableBeamSoon:Schedule(12)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62283, 62438, 62439, 62861, 62862, 62930) then --  Roots
		warnIronRoots:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			yellIronRoots:Yell()
		end
		self.vb.iconId = self.vb.iconId - 1
		if self.Options.SetIconOnRoots then
			self:SetIcon(args.destName, self.vb.iconId, 15)
		end
	elseif args:IsSpellID(62451, 62865) and args:IsPlayer() then
		specWarnUnstableBeam:Show()
		specWarnUnstableBeam:Play("runaway")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62519 then
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		self:SetStage(2)
	elseif args:IsSpellID(62861, 62438) then
		if self.Options.SetIconOnRoots then
			self:RemoveIcon(args.destName)
		end
		self.vb.iconId = self.vb.iconId + 1
	elseif args:IsSpellID(63571, 62589) then -- Nature's Fury
		if self.Options.SetIconOnFury then
			self:RemoveIcon(args.destName)
		end
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 33202 or cid == 32916 or cid == 32919 then
		if self.Options.HealthFrame then
			DBM.BossHealth:RemoveBoss(cid)
		end
		if self:AntiSpam(17, 1) then
			timerSimulKill:Start()
			warnSimulKill:Show()
		end
		adds[cid] = nil
		local counter = 0
		for _, _ in pairs(adds) do
			counter = counter + 1
		end
		if counter == 0 then
			timerSimulKill:Stop()
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(62438) then
		timerIronRootsCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPullNormal then -- Yell fires before IEEU, so set HM variable here instead of OnCombatStart
		self.vb.isHardMode = false
	elseif msg == L.YellPullHard then
		self.vb.isHardMode = true
		timerGroundTremorCD:Start(11) -- 6s variance (could be more, insufficient data). 2022/07/05 10m Lord transcriptor log || 2021 S2 cleu + VOD review) - 16 || 11, 13, 17
	elseif msg == L.SpawnYell then
		timerAlliesOfNature:Start()
		if self.Options.HealthFrame then
			if not adds[33202] then DBM.BossHealth:AddBoss(33202, L.WaterSpirit) end -- ancient water spirit
			if not adds[32916] then DBM.BossHealth:AddBoss(32916, L.Snaplasher) end  -- snaplasher
			if not adds[32919] then DBM.BossHealth:AddBoss(32919, L.StormLasher) end -- storm lasher
		end
		adds[33202] = true
		adds[32916] = true
		adds[32919] = true
	elseif msg == L.YellAdds1 then
		timerAlliesOfNature:Start()
	elseif msg == L.YellAdds2 then
		timerAlliesOfNature:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if strmatch(msg, L.EmoteLGift) then
		specWarnLifebinder:Show()
		specWarnLifebinder:Play("targetchange")
		timerLifebinderCD:Start()
	end
end