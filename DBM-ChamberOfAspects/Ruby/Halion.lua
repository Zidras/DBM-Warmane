local mod	= DBM:NewMod("Halion", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250318212740")
mod:SetCreatureID(39863)--40142 (twilight form)
mod:SetUsedIcons(7, 3)
mod:SetMinSyncRevision(20250318212740)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Kill)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 74806 75954 75955 75956 74525 74526 74527 74528",
	"SPELL_CAST_SUCCESS 74792 74562 74531",
	"SPELL_AURA_APPLIED 74792 74562",
	"SPELL_AURA_REMOVED 74792 74562",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UPDATE_WORLD_STATES",
	"UNIT_HEALTH boss1 boss2"
)

-- General
local berserkTimer					= mod:NewBerserkTimer(480)

mod:AddBoolOption("AnnounceAlternatePhase", false, "announce")

-- Stage One - Physical Realm (100%)
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1)..": "..L.PhysicalRealm)
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2)
local warningFieryCombustion		= mod:NewTargetNoFilterAnnounce(74562, 4)
local warningMeteor					= mod:NewSpellAnnounce(74648, 3)
local warningFieryBreath			= mod:NewSpellAnnounce(74525, 2, nil, "Tank|Healer")

local specWarnFieryCombustion		= mod:NewSpecialWarningRun(74562, nil, nil, nil, 4, 2)
local yellFieryCombustion			= mod:NewYellMe(74562)
local specWarnMeteorStrike			= mod:NewSpecialWarningMove(74648, nil, nil, nil, 1, 2)

local timerFieryCombustionCD		= mod:NewNextTimer(25, 74562, nil, nil, nil, 3)
local timerMeteorCD					= mod:NewNextTimer(38, 74648, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerMeteorCast				= mod:NewCastTimer(7, 74648)
local timerFieryBreathCD			= mod:NewCDTimer(18, 74525, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON, true)
local timerTailLashCD				= mod:NewCDTimer(12, 74531, nil, nil, nil, 2)

mod:AddSetIconOption("SetIconOnFireConsumption", 74562, true, false, {7})--Red x for Fire

-- Stage Two - Twilight Realm (75%)
local twilightRealmName = DBM:GetSpellInfo(74807)
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2)..": "..twilightRealmName)
local warnPhase3Soon				= mod:NewPrePhaseAnnounce(3)
local warnPhase2					= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warningSoulConsumption		= mod:NewTargetNoFilterAnnounce(74792, 4)
local warningShadowBreath			= mod:NewSpellAnnounce(74806, 2, nil, "Tank|Healer")
local warningTwilightCutter			= mod:NewAnnounce("TwilightCutterCast", 4, 74769, nil, nil, nil, 74769)

local specWarnSoulConsumption		= mod:NewSpecialWarningRun(74792, nil, nil, nil, 4, 2)
local yellSoulConsumption			= mod:NewYellMe(74792)
local specWarnTwilightCutter		= mod:NewSpecialWarningSpell(74769, nil, nil, nil, 3, 2)

local timerSoulConsumptionCD		= mod:NewNextTimer(25.5, 74792, nil, nil, nil, 3) 
--local timerTwilightCutterCast		= mod:NewCastTimer(5, 74769, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerTwilightCutter			= mod:NewBuffActiveTimer(9, 74769, nil, nil, nil, 6)
local timerTwilightCutterCD			= mod:NewNextTimer(15, 74769, nil, nil, nil, 6)
local timerShadowBreathCD			= mod:NewCDTimer(16, 74806, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON, true)

mod:AddSetIconOption("SetIconOnShadowConsumption", 74792, true, false, {3})--Purple diamond for shadow

-- Stage Three - Corporeality (50%)
local twilightDivisionName = DBM:GetSpellInfo(75063)
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(3)..": "..twilightDivisionName)
local warnPhase3					= mod:NewPhaseAnnounce(3, 2, nil, nil, nil, nil, nil, 2)

local specWarnCorporeality			= mod:NewSpecialWarningCount(74826, nil, nil, nil, 1, 2)

mod.vb.warned_preP2 = false
mod.vb.warned_preP3 = false
local playerInShadowRealm = false
local fieryCombustionCLEU = false -- Assigning a bool for CLEU check to prevent double timer starts from CLEU & Sync
local fieryBreathCLEU = false -- Assigning a bool for CLEU check to prevent double timer starts from CLEU & Sync
local soulConsumptionCLEU = false -- Assigning a bool for CLEU check to prevent double timer starts from CLEU & Sync
local shadowBreathCLEU = false -- Assigning a bool for CLEU check to prevent double timer starts from CLEU & Sync
local previousCorporeality = 0

local function clearKeepTimers(self) -- Attempt to clear "keep" negative timers that are not relevant to the realm and would otherwise tick to infinity
--	if not self.AnnounceAlternatePhase then return end
	if timerShadowBreathCD:GetRemaining() < 0 then timerShadowBreathCD:Stop() end
	if timerFieryBreathCD:GetRemaining() < 0 then timerFieryBreathCD:Stop() end
end

function mod:OnCombatStart(delay)
	self.vb.warned_preP2 = false
	self.vb.warned_preP3 = false
	self:SetStage(1)
	playerInShadowRealm = false
	fieryCombustionCLEU = false
	fieryBreathCLEU = false
	soulConsumptionCLEU = false
	shadowBreathCLEU = false
	previousCorporeality = 0
	berserkTimer:Start(-delay)
	timerMeteorCD:Start(18-delay) 
	timerFieryCombustionCD:Start(15-delay) 
	timerFieryBreathCD:Start(10-delay) 
	timerTailLashCD:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.HealthFrame then
		DBM.BossHealth:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74806, 75954, 75955, 75956) then
		warningShadowBreath:Show()
		timerShadowBreathCD:Start()
		shadowBreathCLEU = true
		if self:LatencyCheck() then
			self:SendSync("ShadowBreathCD")
		end
	elseif args:IsSpellID(74525, 74526, 74527, 74528) then
		warningFieryBreath:Show()
		timerFieryBreathCD:Start()
		fieryBreathCLEU = true
		if self:LatencyCheck() then
			self:SendSync("FieryBreathCD")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)--We use spell cast success for debuff timers in case it gets resisted by a player we still get CD timer for next one
	local spellId = args.spellId
	--[[if spellId == 74792 then
		timerSoulConsumptionCD:Start()
		soulConsumptionCLEU = true
		if self:LatencyCheck() then
			self:SendSync("ShadowCD") -- WAY OF ELENDIL = SPELL_CAST_SUCCESS doesn't trigger for those spells
		end
	elseif spellId == 74562 then
		timerFieryCombustionCD:Start()
		fieryCombustionCLEU = true
		if self:GetStage(1, 2) and self:LatencyCheck() then -- useless on phase 1 since everyone is in the same realm
			self:SendSync("FieryCD")
		end]]
	if spellId == 74531 then -- Tail Lash
		timerTailLashCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)--We don't use spell cast success for actual debuff on >player< warnings since it has a chance to be resisted.
	local spellId = args.spellId
	if spellId == 74792 then
		timerSoulConsumptionCD:Start()
		soulConsumptionCLEU = true
		if self:LatencyCheck() then
			self:SendSync("ShadowCD")
		end
		if self:LatencyCheck() then
			self:SendSync("ShadowTarget", args.destName)
		end
		if args:IsPlayer() then
			specWarnSoulConsumption:Show()
			specWarnSoulConsumption:Play("runout")
			yellSoulConsumption:Yell()
		end
		if not self.Options.AnnounceAlternatePhase then
			warningSoulConsumption:Show(args.destName)
		end
		if self.Options.SetIconOnShadowConsumption then
			self:SetIcon(args.destName, 3)
		end
	elseif spellId == 74562 then
		timerFieryCombustionCD:Start()
		fieryCombustionCLEU = true
		if self:GetStage(1, 2) and self:LatencyCheck() then -- useless on phase 1 since everyone is in the same realm
			self:SendSync("FieryCD")
		end
		if self:LatencyCheck() then
			self:SendSync("FieryTarget", args.destName)
		end
		if args:IsPlayer() then
			specWarnFieryCombustion:Show()
			specWarnFieryCombustion:Play("runout")
			yellFieryCombustion:Yell()
		end
		if not self.Options.AnnounceAlternatePhase then
			warningFieryCombustion:Show(args.destName)
		end
		if self.Options.SetIconOnFireConsumption then
			self:SetIcon(args.destName, 7)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 74792 then
		if self.Options.SetIconOnShadowConsumption then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 74562 then
		if self.Options.SetIconOnFireConsumption then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, destGUID, _, _, spellId)
	if (spellId == 75952 or spellId == 75951 or spellId == 75950 or spellId == 75949 or spellId == 75948 or spellId ==  75947) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnMeteorStrike:Show()
		specWarnMeteorStrike:Play("runaway")
	-- Physical/Shadow Realm detection:
	-- OnCombatStarts already defines playerInShadowRealm as false.
	-- Code below is meant to handle P2 and P3
	elseif (self:GetCIDFromGUID(sourceGUID) == 39863 or self:GetCIDFromGUID(destGUID) == 39863) and self.Options.HealthFrame and playerInShadowRealm then -- check if Physical Realm boss exists and playerInShadowRealm is still cached as true
		playerInShadowRealm = false
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(39863, L.NormalHalion)
	elseif (self:GetCIDFromGUID(sourceGUID) == 40142 or self:GetCIDFromGUID(destGUID) == 40142) and self.Options.HealthFrame and not playerInShadowRealm then -- check if Shadow Realm boss exists
		playerInShadowRealm = true
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(40142, L.TwilightHalion)
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_HEALTH(uId)
	if not self.vb.warned_preP2 and self:GetUnitCreatureId(uId) == 39863 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.79 then
		self.vb.warned_preP2 = true
		warnPhase2Soon:Show()
	elseif not self.vb.warned_preP3 and self:GetUnitCreatureId(uId) == 40142 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
		self:SendSync("Phase3soon")
	end
end

function mod:UPDATE_WORLD_STATES()
	for i = 1, GetNumWorldStateUI() do
		local _, state, text = GetWorldStateUIInfo(i)
		if state == 1 and strfind(text, "%%") then
			local corporeality = tonumber(strmatch(text, "%d+"))
			if corporeality > 0 and previousCorporeality ~= corporeality then
				specWarnCorporeality:Show(corporeality)
				previousCorporeality = corporeality
				if corporeality > 60 then -- only voice for >= 70%, 60% is still manageable so default to the selected SA sound
					if self:IsTank() then
						specWarnCorporeality:Play("defensive")
					end
				end
				if corporeality < 40 then
					if self:IsDps() then
						specWarnCorporeality:Play("dpsstop")
					end
				elseif corporeality == 40 then
					if self:IsDps() then
						specWarnCorporeality:Play("dpsslow")
					end
				elseif corporeality == 60 then
					if self:IsDps() then
						specWarnCorporeality:Play("dpsmore")
					end
				elseif corporeality > 60 then
					if self:IsDps() then
						specWarnCorporeality:Play("dpshard")
					end
				end
			end
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		self:SendSync("Phase2")
	elseif msg == L.Phase3 or msg:find(L.Phase3) then
		self:SendSync("Phase3")
	elseif msg == L.MeteorCast or msg:find(L.MeteorCast) then--There is no CLEU cast trigger for meteor, only yell
		warningMeteor:Play("meteorrun")
		if not self.Options.AnnounceAlternatePhase then
			warningMeteor:Show()
			timerMeteorCast:Start()--7 seconds from boss yell the meteor impacts.
			timerMeteorCD:Start()
		end
		if self:LatencyCheck() then
			self:SendSync("Meteor")
		end
	elseif msg == L.twilightcutter or msg:find(L.twilightcutter) then
			specWarnTwilightCutter:Schedule(0)
			specWarnTwilightCutter:ScheduleVoice(0, "farfromline")
		if not self.Options.AnnounceAlternatePhase then
			timerTwilightCutterCD:Cancel()
			warningTwilightCutter:Schedule(25)
			timerTwilightCutter:Schedule(0) --Delay it since it happens 5 seconds after the emote // WOE = Pas de délai sur l'emote
			timerTwilightCutterCD:Schedule(15)
		end
		if self:LatencyCheck() then
			self:SendSync("TwilightCutter")
		end
	end
end

function mod:OnSync(msg, target)
	if msg == "TwilightCutter" then
		if self.Options.AnnounceAlternatePhase then 
			timerTwilightCutterCD:Cancel()
			warningTwilightCutter:Schedule(25)
			timerTwilightCutter:Schedule(0)--Delay it since it happens 5 seconds after the emote // WOE = Pas de délai sur l'emote
			timerTwilightCutterCD:Schedule(15)
		end
	elseif msg == "Meteor" then
		if self.Options.AnnounceAlternatePhase then
			warningMeteor:Show()
			timerMeteorCast:Start()
			timerMeteorCD:Start()
		end
	elseif msg == "ShadowTarget" then
		if self.Options.AnnounceAlternatePhase then
			warningSoulConsumption:Show(target)
		end
	elseif msg == "FieryTarget" then
		if self.Options.AnnounceAlternatePhase then
			warningFieryCombustion:Show(target)
		end
	elseif msg == "ShadowCD" then
		if self.Options.AnnounceAlternatePhase and not soulConsumptionCLEU then
			soulConsumptionCLEU = false -- reset state for next CLEU/sync check
			timerSoulConsumptionCD:Start()
		end
	elseif msg == "ShadowBreathCD" then
		if self.Options.AnnounceAlternatePhase and not shadowBreathCLEU then
			shadowBreathCLEU = false -- reset state for next CLEU/sync check
			warningShadowBreath:Show()
			timerShadowBreathCD:Start()
		end
	elseif msg == "FieryBreathCD" then
		if self.Options.AnnounceAlternatePhase and not fieryBreathCLEU then
			fieryBreathCLEU = false -- reset state for next CLEU/sync check
			warningFieryBreath:Show()
			timerFieryBreathCD:Start()
		end
	elseif msg == "FieryCD" and self:GetStage(1, 2) then -- block old comms that run this for the entirety of the raid, which is useless on phase 1 since everyone is in the same realm
		if self.Options.AnnounceAlternatePhase and not fieryCombustionCLEU then
			fieryCombustionCLEU = false -- reset state for next CLEU/sync check
			timerFieryCombustionCD:Start()
		end
	elseif msg == "Phase2" and self:GetStage(2, 1) then
		self:SetStage(2)
		timerFieryBreathCD:Cancel()
		timerMeteorCD:Cancel()
		timerFieryCombustionCD:Cancel()
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerShadowBreathCD:Start() 
		timerSoulConsumptionCD:Start(22.8)
		timerTwilightCutterCD:Start(40)
		warningTwilightCutter:Schedule(35)

		self:Schedule(20, clearKeepTimers, self)
	elseif msg == "Phase3" and self:GetStage(3, 1) then
		self:SetStage(3)
		warnPhase3:Show()
		warnPhase3:Play("pthree")
		timerMeteorCD:Start(23.2) 
		timerFieryCombustionCD:Start(17.8) 
		self:Schedule(20, clearKeepTimers, self)
	elseif msg == "Phase3soon" and not self.vb.warned_preP3 then
		self.vb.warned_preP3 = true
		warnPhase3Soon:Show()
	end
end
