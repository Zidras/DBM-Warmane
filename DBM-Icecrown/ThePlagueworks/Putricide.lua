local mod	= DBM:NewMod("Putricide", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4408 $"):sub(12, -3))
mod:SetCreatureID(36678)
mod:SetMinSyncRevision(3860)
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"UNIT_HEALTH boss1"
)

local warnSlimePuddle				= mod:NewSpellAnnounce(70341, 2)
local warnUnstableExperimentSoon	= mod:NewSoonAnnounce(70351, 3)
local warnUnstableExperiment		= mod:NewSpellAnnounce(70351, 4)
local warnVolatileOozeAdhesive		= mod:NewTargetAnnounce(70447, 3)
local warnGaseousBloat				= mod:NewTargetAnnounce(70672, 3)
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2)
local warnPhase3Soon				= mod:NewPrePhaseAnnounce(3)
local warnPhase2					= mod:NewPhaseAnnounce(2, 2)
local warnPhase3					= mod:NewPhaseAnnounce(3, 2)
local warnTearGas					= mod:NewSpellAnnounce(71617, 2)		-- Phase transition normal
local warnChokingGasBombSoon		= mod:NewPreWarnAnnounce(71255, 5, 3, nil, "Tank|Melee")
local warnChokingGasBomb			= mod:NewSpellAnnounce(71255, 3, nil, "Tank|Melee")		-- Phase 2 ability
local warnMutatedPlague				= mod:NewStackAnnounce(72451, 3, nil, "Tank|Healer|RemoveEnrage") -- Phase 3 ability
local warnUnboundPlague				= mod:NewTargetAnnounce(70911, 3, nil, false, nil, nil, nil, true)		-- Heroic Ability

local specWarnVolatileOozeAdhesive	= mod:NewSpecialWarningYou(70447, nil, nil, nil, 1, 2)
local specWarnVolatileOozeAdhesiveT	= mod:NewSpecialWarningMoveTo(70447, nil, nil, nil, 1, 2)
local specWarnGaseousBloat			= mod:NewSpecialWarningRun(70672, nil, nil, nil, 1, 2)
local specWarnChokingGasBomb		= mod:NewSpecialWarningMove(71255, "Melee|Tank", nil, nil, 1, 2)
local specWarnMalleableGooCast		= mod:NewSpecialWarningSpell(72295, "Ranged|Healer", nil, nil, 2, 2)
local specWarnOozeVariable			= mod:NewSpecialWarningYou(70352)		-- Heroic Ability
local specWarnGasVariable			= mod:NewSpecialWarningYou(70353)		-- Heroic Ability
local specWarnUnboundPlague			= mod:NewSpecialWarningYou(70911, nil, nil, nil, 1, 2)		-- Heroic Ability
local yellUnboundPlague				= mod:NewYellMe(70911, false)

local timerGaseousBloat				= mod:NewTargetTimer(20, 70672, nil, nil, nil, 3)			-- Duration of debuff
local timerSlimePuddleCD			= mod:NewCDTimer(35, 70341, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)				-- Approx
local timerUnstableExperimentCD		= mod:NewNextTimer(38, 70351, nil, nil, nil, 1, nil, DBM_CORE_L.DEADLY_ICON)			-- Used every 38 seconds exactly except after phase changes
local timerChokingGasBombCD			= mod:NewNextTimer(35.5, 71255, nil, nil, nil, 3)
local timerMalleableGooCD			= mod:NewCDTimer(20, 72295, nil, nil, nil, 3)
local timerTearGas					= mod:NewBuffFadesTimer(16, 71615, nil, nil, nil, 6)
local timerPotions					= mod:NewBuffActiveTimer(30, 71621, nil, nil, nil, 6)
local timerMutatedPlagueCD			= mod:NewCDTimer(10, 72451, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)				-- 10 to 11
local timerUnboundPlagueCD			= mod:NewNextTimer(90, 70911, nil, nil, nil, 3, nil, DBM_CORE_L.HEROIC_ICON)
local timerUnboundPlague			= mod:NewBuffActiveTimer(12, 70911, nil, nil, nil, 3)		-- Heroic Ability: we can't keep the debuff 60 seconds, so we have to switch at 12-15 seconds. Otherwise the debuff does to much damage!

-- buffs from "Drink Me"
local timerMutatedSlash				= mod:NewTargetTimer(20, 70542, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerRegurgitatedOoze			= mod:NewTargetTimer(20, 70539, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)

local soundSpecWarnMalleableGoo		= mod:NewSound(72295, nil, "Ranged|Healer")
local ttsMalleableSoon 				= mod:NewSoundSoon(72295, nil, "Ranged|Healer")
local soundSpecWarnChokingGasBomb	= mod:NewSound(71255, nil, "Tank|Melee")
local ttsChokingSoon 				= mod:NewSoundSoon(71255, nil, "Tank|Melee")
local ttsSlimePuddle 				= mod:NewSound(70341)
local ttsNextPhaseSoon 				= mod:NewSound("TTS NextPhaseSoon")

local berserkTimer			= select(3, DBM:GetMyPlayerInfo()) == "Lordaeron" and mod:NewBerserkTimer(480) or mod:NewBerserkTimer(600)

mod:AddBoolOption("OozeAdhesiveIcon")
mod:AddBoolOption("GaseousBloatIcon")
mod:AddBoolOption("MalleableGooIcon")
mod:AddBoolOption("UnboundPlagueIcon")
mod:AddBoolOption("GooArrow")

local PuddleTime = 0
local GooTime = 0
local ChokingTime = 0
local UnstableTime = 0
local UnboundTime = 0
mod.vb.warned_preP2 = false
mod.vb.warned_preP3 = false
mod.vb.chokingTimeRemaining = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	berserkTimer:Start(-delay)
	timerSlimePuddleCD:Start(10-delay)
	timerUnstableExperimentCD:Start(30-delay)
	warnUnstableExperimentSoon:Schedule(25-delay)
	local PuddleTime = 0
	local GooTime = 0
	local ChokingTime = 0
	local UnstableTime = 0
	local UnboundTime = 0
	self.vb.warned_preP2 = false
	self.vb.warned_preP3 = false
	self.vb.chokingTimeRemaining = 0
	if self:IsDifficulty("heroic10", "heroic25") then
		timerUnboundPlagueCD:Start(10-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(70351, 71966, 71967, 71968) then
		warnUnstableExperimentSoon:Cancel()
		warnUnstableExperiment:Show()
		timerUnstableExperimentCD:Start()
		warnUnstableExperimentSoon:Schedule(33)
	elseif args.spellId == 71617 then				--Tear Gas (Normal phase2+3 change start)
		warnTearGas:Show()
		warnUnstableExperimentSoon:Cancel()
		warnChokingGasBombSoon:Cancel()
		timerUnstableExperimentCD:Cancel()
		timerMalleableGooCD:Cancel()
		timerSlimePuddleCD:Cancel()
		timerChokingGasBombCD:Cancel()
		timerUnboundPlagueCD:Cancel()
	elseif args:IsSpellID(72851, 72852) then		--Create Concoction (Heroic phase2 change)
		if self:IsDifficulty("heroic10", "heroic25") then
			self:ScheduleMethod(36, "NextPhase")
			timerPotions:Start()
			warnUnstableExperimentSoon:Cancel()
			timerUnstableExperimentCD:Cancel()
			timerSlimePuddleCD:Cancel()
			timerUnboundPlagueCD:Cancel()
		end
	elseif args:IsSpellID(73121, 73122) then		--Guzzle Potions (Heroic phase3 change)
		if self:IsDifficulty("heroic10") then
			self:ScheduleMethod(36, "NextPhase")
			timerPotions:Start()
			timerUnstableExperimentCD:Cancel()
			ttsMalleableSoon:Cancel()
			ttsChokingSoon:Cancel()
			warnUnstableExperimentSoon:Cancel()
			timerMalleableGooCD:Cancel()
			timerSlimePuddleCD:Cancel()
			timerChokingGasBombCD:Cancel()
			timerUnboundPlagueCD:Cancel()
		elseif mod:IsDifficulty("heroic25") then
			self:ScheduleMethod(26, "NextPhase")
			timerPotions:Start(20)
			timerUnstableExperimentCD:Cancel()
			ttsMalleableSoon:Cancel()
			ttsChokingSoon:Cancel()
			warnUnstableExperimentSoon:Cancel()
			timerMalleableGooCD:Cancel()
			timerSlimePuddleCD:Cancel()
			timerChokingGasBombCD:Cancel()
			timerUnboundPlagueCD:Cancel()
		end
	end
end

function mod:NextPhase()
	self:SetStage(0)
	if self.vb.phase == 2 then
		warnPhase2:Show()
		timerSlimePuddleCD:Start(65-(GetTime()-PuddleTime))
		timerUnstableExperimentCD:Start(69-(GetTime()-UnstableTime))
		timerMalleableGooCD:Start(9.5)		
		ttsMalleableSoon:Schedule(9.5-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable_soon.mp3")
		timerChokingGasBombCD:Start(21)
		ttsChokingSoon:Schedule(21-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\choking_soon.mp3")
		if self:IsDifficulty("heroic10", "heroic25") then
			timerUnboundPlagueCD:Start(120-(GetTime()-UnboundTime))
		end
	elseif self.vb.phase == 3 then
		warnPhase3:Show()
		timerSlimePuddleCD:Start(65-(GetTime()-PuddleTime))
		timerMalleableGooCD:Start(50-(GetTime()-GooTime))
		ttsMalleableSoon:Schedule((50-(GetTime()-GooTime))-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable_soon.mp3")
		timerChokingGasBombCD:Start(66-(GetTime()-ChokingTime))
		ttsChokingSoon:Schedule((66-(GetTime()-ChokingTime))-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\choking_soon.mp3")
		if self:IsDifficulty("heroic10", "heroic25") then
			timerUnboundPlagueCD:Start(120-(GetTime()-UnboundTime))		--this requires more analysis
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 70341 and self:AntiSpam(5, 1) then
		warnSlimePuddle:Show()
		ttsSlimePuddle:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\puddle_cast.mp3")
		timerSlimePuddleCD:Start()
		PuddleTime = GetTime()
	elseif args.spellId == 71255 then
		warnChokingGasBomb:Show()
		specWarnChokingGasBomb:Show()
		soundSpecWarnChokingGasBomb:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\choking.mp3")
		ttsChokingSoon:Cancel()
		ttsChokingSoon:Schedule(35.5-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\choking_soon.mp3")
		timerChokingGasBombCD:Start()
		warnChokingGasBombSoon:Schedule(30.5)
		ChokingTime = GetTime()
	elseif args:IsSpellID(72855, 72856, 70911) then
		timerUnboundPlagueCD:Start()
		UnboundTime = GetTime()
	elseif args:IsSpellID(72615, 72295, 74280, 74281) then
		specWarnMalleableGooCast:Show()
		timerMalleableGooCD:Start()
		soundSpecWarnMalleableGoo:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable.mp3")
		ttsMalleableSoon:Cancel()
		ttsMalleableSoon:Schedule(20-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\malleable_soon.mp3")
		GooTime = GetTime()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70447, 72836, 72837, 72838) then--Green Slime
		if args:IsPlayer() then--Still worth warning 100s because it does still do knockback
			specWarnVolatileOozeAdhesive:Show()
		elseif not self:IsTank() then
			specWarnVolatileOozeAdhesiveT:Show(args.destName)
			specWarnVolatileOozeAdhesiveT:Play("helpsoak")
		else
			warnVolatileOozeAdhesive:Show(args.destName)
		end
		if self.Options.OozeAdhesiveIcon then
			self:SetIcon(args.destName, 8, 8)
		end
	elseif args:IsSpellID(70672, 72455, 72832, 72833) then	--Red Slime
		timerGaseousBloat:Start(args.destName)
		if args:IsPlayer() then
			specWarnGaseousBloat:Show()
			specWarnGaseousBloat:Play("justrun")
			specWarnGaseousBloat:ScheduleVoice(1.5, "keepmove")
		else
			warnGaseousBloat:Show(args.destName)
		end
		if self.Options.GaseousBloatIcon then
			self:SetIcon(args.destName, 7, 20)
		end
	elseif args:IsSpellID(71615, 71618) then	--71615 used in 10 and 25 normal, 71618?
		timerTearGas:Start()
	elseif args:IsSpellID(72451, 72463, 72671, 72672) then	-- Mutated Plague
		warnMutatedPlague:Show(args.destName, args.amount or 1)
		timerMutatedPlagueCD:Start()
	elseif args.spellId == 70542 then
		timerMutatedSlash:Show(args.destName)
	elseif args:IsSpellID(70539, 72457, 72875, 72876) then
		timerRegurgitatedOoze:Show(args.destName)
	elseif args:IsSpellID(70352, 74118) then	--Ooze Variable
		if args:IsPlayer() then
			specWarnOozeVariable:Show()
			warnUnstableExperimentSoon:Cancel()
			timerUnstableExperimentCD:Cancel()
			timerMalleableGooCD:Cancel()
			timerSlimePuddleCD:Cancel()
			if self.vb.phase == 2 then
				self.vb.chokingTimeRemaining = timerChokingGasBombCD:GetRemaining()
			end
			timerChokingGasBombCD:Cancel()
			timerUnboundPlagueCD:Cancel()
		end
	elseif args:IsSpellID(70353, 74119) then	-- Gas Variable
		if args:IsPlayer() then
			specWarnGasVariable:Show()
			warnUnstableExperimentSoon:Cancel()
			timerUnstableExperimentCD:Cancel()
			timerMalleableGooCD:Cancel()
			timerSlimePuddleCD:Cancel()
			if self.vb.phase == 2 then
				self.vb.chokingTimeRemaining = timerChokingGasBombCD:GetRemaining()
			end
			timerChokingGasBombCD:Cancel()
			timerUnboundPlagueCD:Cancel()
		end
	elseif args:IsSpellID(72855, 72856, 70911) then	 -- Unbound Plague
		if self.Options.UnboundPlagueIcon then
			self:SetIcon(args.destName, 5, 20)
		end
		if args:IsPlayer() then
			specWarnUnboundPlague:Show()
			specWarnUnboundPlague:Play("targetyou")
			timerUnboundPlague:Start()
			yellUnboundPlague:Yell()
		else
			warnUnboundPlague:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(72451, 72463, 72671, 72672) then	-- Mutated Plague
		warnMutatedPlague:Show(args.destName, args.amount or 1)
		timerMutatedPlagueCD:Start()
	elseif args.spellId == 70542 then
		timerMutatedSlash:Show(args.destName)
	end
end

function mod:SPELL_AURA_REFRESH(args)
	if args:IsSpellID(70539, 72457, 72875, 72876) then
		timerRegurgitatedOoze:Show(args.destName)
	elseif args.spellId == 70542 then
		timerMutatedSlash:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70447, 72836, 72837, 72838) then
		if self.Options.OozeAdhesiveIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(70672, 72455, 72832, 72833) then
		timerGaseousBloat:Cancel(args.destName)
		if self.Options.GaseousBloatIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(72855, 72856, 70911) then 						-- Unbound Plague
		timerUnboundPlague:Stop(args.destName)
		if self.Options.UnboundPlagueIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 71615 and self:AntiSpam(5, 2) then 	-- Tear Gas Removal
		self:NextPhase()
	elseif args:IsSpellID(70539, 72457, 72875, 72876) then
		timerRegurgitatedOoze:Cancel(args.destName)
	elseif args.spellId == 70542 then
		timerMutatedSlash:Cancel(args.destName)
	end
end

--values subject to tuning depending on dps and his health pool
function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not self.vb.warned_preP2 and self:GetUnitCreatureId(uId) == 36678 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.83 then
		self.vb.warned_preP2 = true
		warnPhase2Soon:Show()
		ttsNextPhaseSoon:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\NextPhaseSoon.mp3")
	elseif self.vb.phase == 2 and not self.vb.warned_preP3 and self:GetUnitCreatureId(uId) == 36678 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.38 then
		self.vb.warned_preP3 = true
		warnPhase3Soon:Show()
		ttsNextPhaseSoon:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\NextPhaseSoon.mp3")
	end
end