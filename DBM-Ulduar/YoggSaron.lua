local mod	= DBM:NewMod("YoggSaron", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230221142915")
mod:SetCreatureID(33288)
mod:RegisterCombat("combat_yell", L.YellPull)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 64059 64189 63138 63830 63802",
	"SPELL_CAST_SUCCESS 64144 64465", --64167 64163",
	"SPELL_SUMMON 62979",
	"SPELL_AURA_APPLIED 63802 63830 63881 64126 64125 63138 63894 64775 64163 64465",
	"SPELL_AURA_REMOVED 63802 63894 64163 63830 63138 63881 64465",
	"SPELL_AURA_REMOVED_DOSE 63050",
	"UNIT_HEALTH"
--	"UNIT_SPELLCAST_START boss1"
)

--General
local enrageTimer					= mod:NewBerserkTimer(900)
local timerAchieve					= mod:NewAchievementTimer(420, 3012)

-- I have hidden most NPC TimerLines and only kept stage and brain TimerLines to prevent GUI clutter.
-- Stage One: The Lucid Dream
mod:AddTimerLine(L.S1TheLucidDream)
-- Sara
-- mod:AddTimerLine(L.Sara)
local warnFervor					= mod:NewTargetAnnounce(63138, 4)

local specWarnFervor				= mod:NewSpecialWarningYou(63138, nil, nil, nil, 1, 2)

local timerFervor					= mod:NewTargetTimer(15, 63138, nil, false, 2)

mod:AddSetIconOption("SetIconOnFervorTarget", 63138, false, false, {7})
mod:AddBoolOption("ShowSaraHealth", false)

-- Guardian of Yogg-Saron
-- mod:AddTimerLine(L.GuardianofYoggSaron)
local warnGuardianSpawned			= mod:NewAnnounce("WarningGuardianSpawned", 3, 62979, nil, nil, nil, 62979)

local specWarnGuardianLow			= mod:NewSpecialWarning("SpecWarnGuardianLow", false, nil, nil, nil, nil, nil, 62979, 62979)

-- Stage Two: Descent Into Madness
mod:AddTimerLine(L.S2DescentIntoMadness)
local warnP2						= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnSanity					= mod:NewAnnounce("WarningSanity", 3, 63050, nil, nil, nil, 63050)

local specWarnSanity				= mod:NewSpecialWarning("SpecWarnSanity", nil, nil, nil, nil, nil, nil, 63050, 63050)--Warning, no voice pack support

mod:AddInfoFrameOption(63050)

-- Sara
-- mod:AddTimerLine(L.Sara)
local warnBrainLink					= mod:NewTargetAnnounce(63802, 3)

local specWarnBrainLink				= mod:NewSpecialWarningYou(63802, nil, nil, nil, 1, 2)
local specWarnMalady				= mod:NewSpecialWarningYou(63830, nil, nil, nil, 1, 2)
local specWarnMaladyNear			= mod:NewSpecialWarningClose(63830, nil, nil, nil, 1, 2)
local yellMalady					= mod:NewYell(63830)

local timerBrainLinkCD				= mod:NewCDTimer(23, 63802, nil, nil, nil, 3) -- 3s variance [23-26] + portalled players incurring in a possible ~50-80s variance (25 man NM log 2022/07/10 || S3 HM log 2022/07/21) - 25.4, 26.0 || 25.5, 24.1 ; 24.7, 23.9 ; 24.7, 23.7, 24.1
local timerMaladyCD					= mod:NewCDTimer(18.7, 63830, nil, nil, nil, 3) -- 7s variance [18-25] + portalled players incurring in a possible ~50-80s variance (25 man NM log 2022/07/10 || S3 HM log 2022/07/21 || 25m Lordaeron 2022/10/09 || 25m Lordaeron 2022/10/30) - 22.3, 22.0 || 21.3, 20.6, 20.2, 52.1, 20.4, 60.8, 20.8, 60.4, 24.8 ; 19.6, 24.5, 60.8, 22.7, 56.8, 21.5, 22.4, 46.5 || 26.0, 19.4, 63.6, 24.1, 51.3, 24.2 || 18.8, 23.0, 24.9, 52.0, 23.4

mod:AddSetIconOption("SetIconOnBrainLinkTarget", 63802, true, false, {1, 2})
mod:AddSetIconOption("SetIconOnFearTarget", 63830, true, false, {6})
mod:AddArrowOption("MaladyArrow", 63830, true)

-- Crusher Tentacle
-- mod:AddTimerLine(L.CrusherTentacle)
local warnCrusherTentacleSpawned	= mod:NewAnnounce("WarningCrusherTentacleSpawned", 2, "Interface\\Icons\\achievement_boss_yoggsaron_01", nil, nil, nil, 64139)

-- Corruptor Tentacle
-- mod:AddTimerLine(L.CorruptorTentacle)

-- Constrictor Tentacle
-- mod:AddTimerLine(L.ConstrictorTentacle)
local warnSqueeze					= mod:NewTargetNoFilterAnnounce(64125, 3)

local yellSqueeze					= mod:NewYell(64125)  -- Constrictor Tentacle

-- Descent into Madness
mod:AddTimerLine(L.DescentIntoMadness)
local warnBrainPortalSoon			= mod:NewAnnounce("WarnBrainPortalSoon", 2, 57687, nil, nil, nil, 64027) -- 10 second pre-warn

local specWarnBrainPortalSoon		= mod:NewSpecialWarning("SpecWarnBrainPortalSoon", false, nil, nil, nil, nil, nil, 57687, 64027) -- 3 second special pre-warn

local timerBrainPortal				= mod:NewTimer(20, "NextPortal", 57687, nil, nil, 5, nil, nil, nil, nil, nil, nil, nil, 64027)

-- Influence Tentacle
-- mod:AddTimerLine(L.InfluenceTentacle)

-- Laughing Skull
-- mod:AddTimerLine(L.LaughingSkull)

-- Brain of Yogg-Saron
-- mod:AddTimerLine(L.BrainofYoggSaron)
local warnMadness					= mod:NewCastAnnounce(64059, 2)

local specWarnMadnessOutNow			= mod:NewSpecialWarning("SpecWarnMadnessOutNow", nil, nil, nil, nil, nil, nil, 64059, 64059)  -- Brain of Yogg-Saron. Warning, no voice pack support

local timerMadness					= mod:NewCastTimer(60, 64059, nil, nil, nil, 5, nil, DBM_COMMON_L.DEADLY_ICON, nil, 3)  -- Brain of Yogg-Saron

-- Stage Three: True Face of Death
mod:AddTimerLine(L.S3TrueFaceofDeath)
local warnP3						= mod:NewPhaseAnnounce(3, 2, nil, nil, nil, nil, nil, 2)

-- Yogg-Saron
-- mod:AddTimerLine(L.YoggSaron)
local specWarnLunaticGaze			= mod:NewSpecialWarningLookAway(64163, nil, nil, nil, 1, 2)

local timerLunaticGaze				= mod:NewCastTimer(4, 64163, nil, nil, nil, 2, nil, DBM_COMMON_L.IMPORTANT_ICON) -- Yogg-Saron's Gaze
local timerNextLunaticGaze			= mod:NewCDTimer(8, 64163, nil, nil, nil, 2, nil, DBM_COMMON_L.IMPORTANT_ICON) -- Yogg-Saron's Gaze, Log reviewed (25 man NM  2022/07/10) - [cast_success: apply 4s cast time correction factor] 12.0, 12.0, 12.1, 12.1, 12.0, 12.0

mod:AddSetIconOption("SetIconOnBeacon", 64465, true, true, {1, 2, 3, 4, 5, 6, 7, 8})

-- Immortal Guardian
-- mod:AddTimerLine(L.ImmortalGuardian)
local warnEmpowerSoon				= mod:NewSoonAnnounce(64486, 4)

local timerEmpower					= mod:NewCDTimer(46.0, 64486, nil, nil, nil, 3) -- REVIEW! variance 45-50? (S3 HM log 2022/07/21) - 46.0, 46.0, 47.4, 48.2
local timerEmpowerDuration			= mod:NewBuffActiveTimer(10, 64486, nil, nil, nil, 3)

mod:GroupSpells(64486, 64465) -- Empowering Shadows, Shadow Beacon

-- Hard Mode
mod:AddTimerLine(DBM_COMMON_L.HEROIC_ICON..DBM_CORE_L.HARD_MODE)
-- Stage Three: True Face of Death
mod:AddTimerLine(L.S3TrueFaceofDeath)
local warnDeafeningRoarSoon			= mod:NewPreWarnAnnounce(64189, 5, 3)

local specWarnDeafeningRoar			= mod:NewSpecialWarningSpell(64189, nil, nil, nil, 1, 2)

local timerCastDeafeningRoar		= mod:NewCastTimer(2.3, 64189, nil, nil, nil, 2)
local timerNextDeafeningRoar		= mod:NewNextTimer(58, 64189, nil, nil, nil, 2) -- (S2 VOD || S3 VOD 2022/07/15 || S3 HM log 2022/07/21) - 58 || 58, 58, 58, 58, 60, 60, 60 || 60.1, 60.1, 60.1

local targetWarningsShown = {}
local brainLinkTargets = {}
local SanityBuff = DBM:GetSpellInfoNew(63050)
mod.vb.brainLinkIcon = 2
mod.vb.beaconIcon = 8
mod.vb.Guardians = 0

function mod:OnCombatStart()
	self:SetStage(1)
	self.vb.brainLinkIcon = 2
	self.vb.beaconIcon = 8
	self.vb.Guardians = 0
	enrageTimer:Start()
	timerAchieve:Start()
	table.wipe(targetWarningsShown)
	table.wipe(brainLinkTargets)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(SanityBuff)
		DBM.InfoFrame:Show(30, "playerdebuffstacks", SanityBuff, 2)--Sorted lowest first (highest first is default of arg not given)
	end
	if self.Options.ShowSaraHealth then
		if not self.Options.HealthFrame then
			DBM.BossHealth:Show(L.name)
		else
			DBM.BossHealth:AddBoss(33134, L.Sara)
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:FervorTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") and self:AntiSpam(4, 1) then
		specWarnFervor:Show()
		specWarnFervor:Play("targetyou")
	end
end

local function warnBrainLinkWarning(self)
	warnBrainLink:Show(table.concat(brainLinkTargets, "<, >"))
	table.wipe(brainLinkTargets)
	self.vb.brainLinkIcon = 2
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 64059 then	-- Induce Madness
		timerMadness:Start()
		warnMadness:Show()
		timerBrainPortal:Schedule(60) -- Log reviewed [60 schedule + 20 timer] (25 man NM log 2022/07/10 || S3 HM log 2022/07/21) - 80.0 || 80.0, 80.1 ; 80.0, 80.0, 80.0
		warnBrainPortalSoon:Schedule(70)
		specWarnBrainPortalSoon:Schedule(77)
		specWarnMadnessOutNow:Schedule(55) -- TO DO: implement brain room check?
	elseif spellId == 64189 then		--Deafening Roar
		timerNextDeafeningRoar:Start()
		warnDeafeningRoarSoon:Schedule(53)
		timerCastDeafeningRoar:Start()
		specWarnDeafeningRoar:Show()
		specWarnDeafeningRoar:Play("silencesoon")
	elseif spellId == 63138 then		--Sara's Fervor
		self:BossTargetScanner(args.sourceGUID, "FervorTarget", 0.1, 12, true, nil, nil, nil, true)
	elseif spellId == 63830 then	-- Malady of the Mind
		timerMaladyCD:Start()
	elseif spellId == 63802 then	-- Brain Link
		timerBrainLinkCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 64144 and self:GetUnitCreatureId(args.sourceGUID) == 33966 then -- Never fires on Warmane
		DBM:AddMsg("Erupt unhidden from combat log. Notify Zidras on Discord or GitHub")
		warnCrusherTentacleSpawned:Show()
	elseif spellId == 64465 then -- Shadow Beacon
		timerEmpower:Start()
		timerEmpowerDuration:Start()
		warnEmpowerSoon:Schedule(40)
--	elseif args:IsSpellID(64167, 64163) and self:AntiSpam(3, 3) then	-- Lunatic Gaze, not needed since it's running below on SAA/SAR
--		timerLunaticGaze:Start()
--		timerBrainPortal:Start(60) -- Why?
--		warnBrainPortalSoon:Schedule(50) -- Why?
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 62979 then
		self.vb.Guardians = self.vb.Guardians + 1
		warnGuardianSpawned:Show(self.vb.Guardians)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 63802 then		-- Brain Link
		self:Unschedule(warnBrainLinkWarning)
		brainLinkTargets[#brainLinkTargets + 1] = args.destName
		if self.Options.SetIconOnBrainLinkTarget then
			self:SetIcon(args.destName, self.vb.brainLinkIcon)
		end
		self.vb.brainLinkIcon = self.vb.brainLinkIcon - 1
		if args:IsPlayer() then
			specWarnBrainLink:Show()
			specWarnBrainLink:Play("linegather")
		end
		if #brainLinkTargets == 2 then
			warnBrainLinkWarning(self)
		else
			self:Schedule(0.5, warnBrainLinkWarning, self)
		end
--		if self:AntiSpam(5, 2) then
--			timerBrainLinkCD:Start()
--		end
	elseif args:IsSpellID(63830, 63881) then   -- Malady of the Mind (Death Coil)
		if self.Options.SetIconOnFearTarget then
			self:SetIcon(args.destName, 6, 30)
		end
		if args:IsPlayer() then
			specWarnMalady:Show()
			specWarnMalady:Play("targetyou")
			yellMalady:Yell()
		elseif self:CheckNearby(11, args.destName) then
			specWarnMaladyNear:Show(args.destName)
			specWarnMaladyNear:Play("runaway")
			if self.Options.MaladyArrow then
				local uId = DBM:GetRaidUnitId(args.destName)
				if uId then
					local x, y = GetPlayerMapPosition(uId)
					if x == 0 and y == 0 then
						SetMapToCurrentZone()
						x, y = GetPlayerMapPosition(uId)
					end
					DBM.Arrow:ShowRunAway(x, y, 12, 5)
				end
			end
		end
--		timerMaladyCD:Start() -- malady jumps would refire this and mess with the timer. Revert to cast_start
	elseif args:IsSpellID(64126, 64125) then	-- Squeeze
		warnSqueeze:Show(args.destName)
		if args:IsPlayer() then
			yellSqueeze:Yell()
		end
	elseif spellId == 63138 then	-- Sara's Fervor
		warnFervor:Show(args.destName)
		timerFervor:Start(args.destName)
		if self.Options.SetIconOnFervorTarget then
			self:SetIcon(args.destName, 7, 15)
		end
		if args:IsPlayer() and self:AntiSpam(4, 1) then
			specWarnFervor:Show()
			specWarnFervor:Play("targetyou")
		end
	elseif args:IsSpellID(63894, 64775) and self.vb.phase < 2 then	-- Shadowy Barrier of Yogg-Saron (this is happens when p2 starts, ~1s after IEEU, so correction factor is needed). Bugged on Warmane, 63894 is never applied (only removed), instead 64775 is applied to Sara
		-- "<114.74 19:51:51> [CLEU] SPELL_AURA_APPLIED:0xF13000816E0007D4:Sara:0xF13000816E0007D4:Sara:64775:Shadowy Barrier:BUFF:nil:", -- [5432]
		self:SetStage(2)
		timerMaladyCD:Start(17.8)	-- (25 man NM log 2022/07/10 || S3 HM log 2022/07/21) - 18 || 18.0 ; 17.9 ; 17.8
		timerBrainLinkCD:Start(23)	-- (25 man NM log 2022/07/10 || S3 HM log 2022/07/21) - 23 || 23.0 ; 23.0
		timerBrainPortal:Start(59)	-- (25 man NM log 2022/07/10 || S3 HM log 2022/07/21) - 59 || 59.8 ; 59.7 ; 59.5
		warnBrainPortalSoon:Schedule(49)
		specWarnBrainPortalSoon:Schedule(56)
		warnP2:Show()
		warnP2:Play("ptwo")
		if self.Options.ShowSaraHealth then
			DBM.BossHealth:RemoveBoss(33134)
			if not self.Options.HealthFrame then
				DBM.BossHealth:Hide()
			end
		end
	elseif spellId == 64163 then	-- Lunatic Gaze phase 3 (reduces sanity) ; 64167 Lunatic Gaze is related to Laughing Skulls, which is not important
		specWarnLunaticGaze:Show(args.sourceName)
		specWarnLunaticGaze:Play("turnaway")
		timerLunaticGaze:Start()
	elseif spellId == 64465 then -- Shadow Beacon
		if self.Options.SetIconOnBeacon then
			self:ScanForMobs(args.destGUID, 2, self.vb.beaconIcon, 1, nil, 6, "SetIconOnBeacon", true, nil, nil, true)
		end
		self.vb.beaconIcon = self.vb.beaconIcon - 1
		if self.vb.beaconIcon == 0 then
			self.vb.beaconIcon = 8
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 63802 and self.Options.SetIconOnBrainLinkTarget then		-- Brain Link
		self:SetIcon(args.destName, 0)
	elseif spellId == 63138 and self.Options.SetIconOnFervorTarget then	-- Sara's Fervor
		self:SetIcon(args.destName, 0)
	elseif spellId == 63894 then		-- Shadowy Barrier removed from Yogg-Saron (start p3)
		-- "<298.03 19:54:54> [CLEU] SPELL_AURA_REMOVED:0xF150008208000F6B:Yogg-Saron:0xF150008208000F6B:Yogg-Saron:63894:Shadowy Barrier:BUFF:nil:", -- [15528]
		self:SendSync("Phase3")			-- Sync this because you don't get it in your combat log if you are in brain room.
	elseif spellId == 64163 then	-- Lunatic Gaze phase 3 ; 64167 Lunatic Gaze is related to Laughing Skulls, which is not important
		timerNextLunaticGaze:Start() -- 12s interval - 4s cast = 8s for next cast
	elseif args:IsSpellID(63830, 63881) and self.Options.SetIconOnFearTarget then   -- Malady of the Mind (Death Coil)
		self:SetIcon(args.destName, 0)
	elseif spellId == 64465 then -- Shadow Beacon
		if self.Options.SetIconOnBeacon then
			self:ScanForMobs(args.destGUID, 2, 0, 1, nil, 6, "SetIconOnBeacon", true, nil, nil, true)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	if args.spellId == 63050 and args.destGUID == UnitGUID("player") then
		local amount = args.amount or 1
		if amount == 50 then
			warnSanity:Show(args.amount)
		elseif amount == 35 or amount == 25 or amount == 15 then
			specWarnSanity:Show(amount)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and uId == "target" and self:GetUnitCreatureId(uId) == 33136 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.3 and not targetWarningsShown[UnitGUID(uId)] then
		targetWarningsShown[UnitGUID(uId)] = true
		specWarnGuardianLow:Show()
	end
end

--[[function mod:UNIT_SPELLCAST_START(_, spellName)
	if spellName == GetSpellInfo(64189) then
		timerNextDeafeningRoar:Start()
		warnDeafeningRoarSoon:Schedule(53)
		timerCastDeafeningRoar:Start()
		specWarnDeafeningRoar:Show()
		specWarnDeafeningRoar:Play("silencesoon")
	end
end]]

function mod:OnSync(msg)
	if msg == "Phase3" then
		self:SetStage(3)
		timerBrainPortal:Cancel()
		warnBrainPortalSoon:Cancel()
		timerMaladyCD:Cancel()
		timerBrainLinkCD:Cancel()
		timerEmpower:Start(45.0) -- (S3 HM log 2022/07/21) - 45.0
		warnP3:Show()
		warnP3:Play("pthree")
		warnEmpowerSoon:Schedule(40)
		timerNextDeafeningRoar:Start(20) -- Has variance (S2 VOD || S3 VOD 2022/07/15 || S3 HM log 2022/07/21) - 21 || 22, 21.5, 20.6, 22.1, 20.0, 28, 28 || 28.1, 22.6
		warnDeafeningRoarSoon:Schedule(15)
		timerNextLunaticGaze:Start(12) -- S3 VOD review
	end
end
