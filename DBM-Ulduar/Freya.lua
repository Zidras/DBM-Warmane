local mod	= DBM:NewMod("Freya", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4133 $"):sub(12, -3))

mod:SetCreatureID(32906)
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 62437 62859",
	"SPELL_CAST_SUCCESS 62678 62673 62619 63571 62589 64650 63601",
	"SPELL_AURA_APPLIED 62283 62438 62439 62861 62862 62930 62451 62865",
	"SPELL_AURA_REMOVED 62519 62861 62438 63571 62589",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

-- Trash: 33430 Guardian Lasher (flower)
-- 33355 (nymph)
-- 33354 (tree)

--
-- Elder Stonebark (ground tremor / fist of stone)
-- Elder Brightleaf (unstable sunbeam)

local warnPhase2			= mod:NewPhaseAnnounce(2, 3)
local warnSimulKill			= mod:NewAnnounce("WarnSimulKill", 1)
local warnFury				= mod:NewTargetAnnounce(63571, 2)
local warnRoots				= mod:NewTargetNoFilterAnnounce(62438, 2)
local warnUnstableBeamSoon	= mod:NewSoonAnnounce(62865, 3) -- Hard mode Sun Beam

local specWarnLifebinder	= mod:NewSpecialWarningSwitch(62869, "Dps", nil, nil, 1, 2)
local specWarnFury			= mod:NewSpecialWarningMoveAway(63571, nil, nil, nil, 1, 2)
local yellFury				= mod:NewYell(63571)
local yellRoots				= mod:NewYell(62438)
local specWarnTremor		= mod:NewSpecialWarningCast(62859, "SpellCaster", nil, 2, 1, 2)	-- Hard mode
local specWarnUnstableBeam	= mod:NewSpecialWarningMove(62865, nil, nil, nil, 1, 2)	-- Hard mode
local specWarnBombs			= mod:NewSpecialWarningMove(64587)

local timerEnrage 			= mod:NewBerserkTimer(600)
local timerAlliesOfNature	= mod:NewNextTimer(60, 62678, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)--No longer has CD, they spawn instant last set is dead, and not a second sooner, except first set
local timerSimulKill		= mod:NewTimer(12, "TimerSimulKill", nil, nil, nil, 5, DBM_CORE_L.DAMAGE_ICON)
local timerFury				= mod:NewTargetTimer(10, 63571)
local timerTremorCD 		= mod:NewCDTimer(26, 62859, 62859, nil, nil, nil, 2)--22.9-47.8
local timerLifebinderCD		= mod:NewCDTimer(40, 62584, nil, nil, nil, 1)
local timerRootsCD			= mod:NewCDTimer(14, 62439, nil, nil, nil, 3)
local timerUnstableBeamCD	= mod:NewCDTimer(15, 62451) -- Hard mode Sun Beam
local timerNextBombs		= mod:NewNextTimer(11, 64587)

mod:AddSetIconOption("SetIconOnFury", 63571, false, false, {7, 8})
mod:AddSetIconOption("SetIconOnRoots", 62438, false, false, {6, 5, 4})
mod:AddRangeFrameOption(8, 63571)

local adds = {}
mod.vb.altIcon = true
mod.vb.iconId = 6
mod.vb.waves = 0

function mod:OnCombatStart(delay)
	self.vb.altIcon = true
	self.vb.iconId = 6
	self.vb.waves = 0
	self:SetStage(1)
	timerEnrage:Start()
	table.wipe(adds)
	timerAlliesOfNature:Start(10-delay)
	timerLifebinderCD:Start(25)
end

function mod:OnCombatEnd(wipe)
	timerNextBombs:Cancel()
	specWarnBombs:Cancel()
	if not wipe then
		if DBM.Bars:GetBar(L.TrashRespawnTimer) then
			DBM.Bars:CancelBar(L.TrashRespawnTimer)
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
		specWarnTremor:Show()
		specWarnTremor:Play("stopcast")
		timerTremorCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(62678, 62673) then -- Summon Allies of Nature
		self.vb.waves = self.vb.waves + 1
		if self.vb.waves < 6 then
			timerAlliesOfNature:Start()
		end
	elseif args.spellId == 62619 and self:GetUnitCreatureId(args.sourceName) == 33228 then -- Pheromones spell, cast by newly spawned Eonar's Gift second they spawn to allow melee to dps them while protector is up.
		specWarnLifebinder:Show()
		specWarnLifebinder:Play("targetchange")
		timerLifebinderCD:Start()
	elseif args:IsSpellID(63571, 62589) then -- Nature's Fury
		if self.Options.SetIconOnFury then
			self.vb.altIcon = not self.vb.altIcon	--Alternates between Skull and X
			self:SetIcon(args.destName, self.vb.altIcon and 7 or 8, 10)
		end
		if args:IsPlayer() then -- only cast on players; no need to check destFlags
			specWarnFury:Show()
			specWarnFury:Play("runout")
			yellFury:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		else
			warnFury:Show(args.destName)
		end
		timerFury:Start(args.destName)
	elseif args.spellId == 64650 then -- Nature Bomb
		if self:AntiSpam(1, 64650) and self:IsInCombat() then
			timerNextBombs:Start(9.95)
			specWarnBombs:Cancel()
			specWarnBombs:Schedule(9.95)
		end
	elseif args.spellId == 63601 then
		--if self.vb.phase == 2 then
			timerRootsCD:Start()
		--end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62283, 62438, 62439, 62861, 62862, 62930) then --  Roots
		warnRoots:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			yellRoots:Yell()
		end
		self.vb.iconId = self.vb.iconId - 1
		if self.Options.SetIconOnRoots then
			self:SetIcon(args.destName, self.vb.iconId, 15)
		end
		timerRootsCD:Start()
	elseif args:IsSpellID(62451, 62865) then
		if self:AntiSpam(10, 2) then
			timerUnstableBeamCD:Start()
			warnUnstableBeamSoon:Schedule(12)
		end
		if args:IsPlayer() then
			specWarnUnstableBeam:Show()
			specWarnUnstableBeam:Play("runaway")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
    if args.spellId == 62519 then
		warnPhase2:Show()
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
		for i, v in pairs(adds) do
			counter = counter + 1
		end
		if counter == 0 then
			timerSimulKill:Stop()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SpawnYell then
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

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, mob)
	-- localize this
	if strmatch(msg, L.EmoteLGift) then
		specWarnLifebinder:Show()
		timerLifebinderCD:Start()
	end
end
