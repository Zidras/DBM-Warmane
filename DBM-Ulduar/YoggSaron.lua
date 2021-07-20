local mod	= DBM:NewMod("YoggSaron", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4338 $"):sub(12, -3))
mod:SetCreatureID(33288)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_AURA_REMOVED_DOSE",
	"UNIT_HEALTH",
	"CHAT_MSG_MONSTER_YELL"
)

mod:SetUsedIcons(6, 7, 8)

local warnMadness 					= mod:NewCastAnnounce(64059, 2)
local warnFervorCast 				= mod:NewCastAnnounce(63138, 3)
local warnSqueeze					= mod:NewTargetAnnounce(64125, 3)
local warnFervor					= mod:NewTargetAnnounce(63138, 4)
local warnDeafeningRoarSoon			= mod:NewPreWarnAnnounce(64189, 5, 3)
local warnGuardianSpawned 			= mod:NewAnnounce("WarningGuardianSpawned", 3, 62979)
local warnCrusherTentacleSpawned	= mod:NewAnnounce("WarningCrusherTentacleSpawned", 2)
local warnP2 						= mod:NewPhaseAnnounce(2, 2)
local warnP3 						= mod:NewPhaseAnnounce(3, 2)
local warnSanity 					= mod:NewAnnounce("WarningSanity", 3, 63050)
local warnBrainLink 				= mod:NewTargetAnnounce(63802, 3)
local warnBrainPortalSoon			= mod:NewAnnounce("WarnBrainPortalSoon", 2)
local warnEmpowerSoon				= mod:NewSoonAnnounce(64486, 4)

local specWarnGuardianLow 			= mod:NewSpecialWarning("SpecWarnGuardianLow", false)
local specWarnBrainLink 			= mod:NewSpecialWarningYou(63802)
local specWarnSanity 				= mod:NewSpecialWarning("SpecWarnSanity")
local specWarnMadnessOutNow			= mod:NewSpecialWarning("SpecWarnMadnessOutNow")
local specWarnBrainPortalSoon		= mod:NewSpecialWarning("specWarnBrainPortalSoon", false)
local specWarnDeafeningRoar			= mod:NewSpecialWarningSpell(64189)
local specWarnFervor				= mod:NewSpecialWarningYou(63138)
local specWarnFervorCast			= mod:NewSpecialWarning("SpecWarnFervorCast", mod:IsMelee())
local specWarnMalady				= mod:NewSpecialWarningYou(63830, nil, nil, nil, 1, 2)
local specWarnMaladyNear			= mod:NewSpecialWarning("SpecWarnMaladyNear", true)

local enrageTimer					= mod:NewBerserkTimer(900)
local timerFervor					= mod:NewTargetTimer(15, 63138)
local timerMaladyCD					= mod:NewCDTimer(18.1, 63830, nil, nil, nil, 3)
local timerBrainLinkCD				= mod:NewCDTimer(32, 63802, nil, nil, nil, 3)
local brainportal					= mod:NewTimer(20, "NextPortal", 57687, nil, nil, 5)
local timerLunaricGaze				= mod:NewCastTimer(4, 64163, nil, nil, nil, 2)
local timerNextLunaricGaze			= mod:NewCDTimer(8.5, 64163, nil, nil, nil, 2)
local timerEmpower					= mod:NewCDTimer(46, 64465, nil, nil, nil, 3)
local timerEmpowerDuration			= mod:NewBuffActiveTimer(10, 64465, nil, nil, nil, 3)
local timerMadness 					= mod:NewCastTimer(60, 64059, nil, nil, nil, 5, nil, DBM_CORE_L.DEADLY_ICON, nil, 3)
local timerCastDeafeningRoar		= mod:NewCastTimer(2.3, 64189, nil, nil, nil, 2)
local timerNextDeafeningRoar		= mod:NewNextTimer(30, 64189, nil, nil, nil, 2)
local timerAchieve					= mod:NewAchievementTimer(420, 3012, "TimerSpeedKill")

mod:AddBoolOption("WarningSqueeze", true, "announce")
mod:AddBoolOption("ShowSaraHealth")
mod:AddBoolOption("SetIconOnFearTarget")
mod:AddBoolOption("SetIconOnFervorTarget")
mod:AddBoolOption("SetIconOnBrainLinkTarget")
mod:AddBoolOption("MaladyArrow")
mod:AddSetIconOption("SetIconOnBeacon", 64465, true, true)
mod:AddInfoFrameOption(63050)

local targetWarningsShown			= {}
local beaconIcon = 8
local brainLinkTargets = {}
local SanityBuff = DBM:GetSpellInfoNew(63050)
local brainLinkIcon = 7
local Guardians = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	Guardians = 0
	beaconIcon = 8
	enrageTimer:Start()
	timerAchieve:Start()
	table.wipe(targetWarningsShown)
	table.wipe(brainLinkTargets)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(SanityBuff)
		DBM.InfoFrame:Show(6, "playerdebuffstacks", SanityBuff, 2)--Sorted lowest first (highest first is defualt of arg not given)
	end
	if self.Options.ShowSaraHealth and not self.Options.HealthFrame then
		DBM.BossHealth:Show(L.name)
	end
	if self.Options.ShowSaraHealth then
		DBM.BossHealth:AddBoss(33134, L.Sara)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:FervorTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") and self:AntiSpam(4, 1) then
		specWarnFervorCast:Show()
	end
end

function mod:warnBrainLink()
	warnBrainLink:Show(table.concat(brainLinkTargets, "<, >"))
	timerBrainLinkCD:Start()--VERIFY ME
	table.wipe(brainLinkTargets)
	brainLinkIcon = 7
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 64059 then	-- Induce Madness
		timerMadness:Start()
		warnMadness:Show()
		brainportal:Schedule(60)
		warnBrainPortalSoon:Schedule(78)
		specWarnBrainPortalSoon:Schedule(78)
		specWarnMadnessOutNow:Schedule(55)
	elseif args.spellId == 64189 then		--Deafening Roar
		timerNextDeafeningRoar:Start()
		warnDeafeningRoarSoon:Schedule(55)
		timerCastDeafeningRoar:Start()
		specWarnDeafeningRoar:Show()
	elseif args.spellId == 63138 then		--Sara's Fervor
		self:BossTargetScanner(args.sourceGUID, "FervorTarget", 0.1, 12, true, nil, nil, nil, true)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 64144 and self:GetUnitCreatureId(args.sourceGUID) == 33966 then
		warnCrusherTentacleSpawned:Show()
	elseif args.spellId == 64465 then
		timerEmpower:Start()
		timerEmpowerDuration:Start()
		warnEmpowerSoon:Schedule(40)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 62979 then
		Guardians = Guardians + 1
		warnGuardianSpawned:Show(Guardians)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 63802 then		-- Brain Link
		self:UnscheduleMethod("warnBrainLink")
		brainLinkTargets[#brainLinkTargets + 1] = args.destName
		if self.Options.SetIconOnBrainLinkTarget then
			self:SetIcon(args.destName, brainLinkIcon, 30)
			brainLinkIcon = brainLinkIcon - 1
		end
		if args:IsPlayer() then
			specWarnBrainLink:Show()
		end
		mod:ScheduleMethod(0.2, "warnBrainLink")
	elseif args:IsSpellID(63830, 63881) then   -- Malady of the Mind (Death Coil)
		if self.Options.SetIconOnFearTarget then
			self:SetIcon(args.destName, 8, 30)
		end
		if args:IsPlayer() then
			specWarnMalady:Show()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnMaladyNear:Show(args.destName)
					if self.Options.MaladyArrow then
						local x, y = GetPlayerMapPosition(uId)
						if x == 0 and y == 0 then
							SetMapToCurrentZone()
							x, y = GetPlayerMapPosition(uId)
						end
						DBM.Arrow:ShowRunAway(x, y, 12, 5)
					end
				end
			end
		end
	elseif args:IsSpellID(64126, 64125) then	-- Squeeze
		warnSqueeze:Show(args.destName)
		if args:IsPlayer() and self.Options.WarningSqueeze then
			SendChatMessage(L.WarningYellSqueeze, "SAY")
		end
	elseif args.spellId == 63138 then	-- Sara's Fervor
		warnFervor:Show(args.destName)
		timerFervor:Start(args.destName)
		if self.Options.SetIconOnFervorTarget then
			self:SetIcon(args.destName, 7, 15)
		end
		if args:IsPlayer() and self:AntiSpam(4, 1) then
			specWarnFervor:Show()
		end
	elseif args.spellId == 63894 then	-- Shadowy Barrier of Yogg-Saron (this is happens when p2 starts)
		self:SetStage(2)
		timerMaladyCD:Start(13)--VERIFY ME
		timerBrainLinkCD:Start(19)--VERIFY ME
		brainportal:Start(57)
		warnBrainPortalSoon:Schedule(53)
		specWarnBrainPortalSoon:Schedule(53)
		warnP2:Show()
		if self.Options.ShowSaraHealth then
			DBM.BossHealth:RemoveBoss(33134)
			if not self.Options.HealthFrame then
				DBM.BossHealth:Hide()
			end
		end
	elseif args:IsSpellID(64167, 64163) then	-- Lunatic Gaze (reduces sanity)
		timerLunaricGaze:Start()
	elseif args.spellId == 64465 then
		if self.Options.SetIconOnBeacon then
			self:ScanForMobs(args.sourceGUID, 2, beaconIcon, 1, 0.2, 10, "SetIconOnBeacon")
		end
		beaconIcon = beaconIcon - 1
		if beaconIcon == 0 then
			beaconIcon = 8
		end
		timerEmpower:Start()
		timerEmpowerDuration:Start()
		warnEmpowerSoon:Schedule(40)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 63802 and self.Options.SetIconOnBrainLinkTarget then		-- Brain Link
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 63138 and self.Options.SetIconOnFervorTarget then	-- Sara's Fervor
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 63894 then		-- Shadowy Barrier removed from Yogg-Saron (start p3)
		self:SendSync("Phase3")			-- Sync this because you don't get it in your combat log if you are in brain room.
		self:SetStage(3)
	elseif args:IsSpellID(64167, 64163) and self:AntiSpam(3, 2) then	-- Lunatic Gaze
		timerNextLunaricGaze:Start()
	elseif args:IsSpellID(63830, 63881) and self.Options.SetIconOnFearTarget then   -- Malady of the Mind (Death Coil)
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 64465 then
		if self.Options.SetIconOnBeacon then
			self:ScanForMobs(args.sourceGUID, 2, 0, 1, 0.2, 12, "SetIconOnBeacon")
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	if args.spellId == 63050 and args.destGUID == UnitGUID("player") then
		if args.amount == 50 then
			warnSanity:Show(args.amount)
		elseif args.amount == 25 or args.amount == 15 or args.amount == 5 then
			warnSanity:Show(args.amount)
			specWarnSanity:Show(args.amount)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and uId == "target" and self:GetUnitCreatureId(uId) == 33136 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.3 and not targetWarningsShown[UnitGUID(uId)] then
		targetWarningsShown[UnitGUID(uId)] = true
		specWarnGuardianLow:Show()
	end
end

function mod:OnSync(msg)
	if msg == "Phase3" then
		self:SetStage(3)
		brainportal:Cancel()
		warnBrainPortalSoon:Cancel()
		timerMaladyCD:Cancel()
		timerBrainLinkCD:Cancel()
		timerEmpower:Start()
		warnP3:Show()
		warnEmpowerSoon:Schedule(40)
		timerNextDeafeningRoar:Start(30)
		warnDeafeningRoarSoon:Schedule(25)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == "ПАДИТЕ НИЦ ПЕРЕД БОГОМ СМЕРТИ!" or msg:find("ПАДИТЕ НИЦ ПЕРЕД БОГОМ СМЕРТИ!")) or (msg == "BOW DOWN BEFORE THE GOD OF DEATH!" or msg:find("BOW DOWN BEFORE THE GOD OF DEATH!")) then
		self:SetStage(2)
		timerMaladyCD:Start(13)--VERIFY ME
		timerBrainLinkCD:Start(19)--VERIFY ME
		brainportal:Start(57)
		warnBrainPortalSoon:Schedule(53)
		specWarnBrainPortalSoon:Schedule(53)
		warnP2:Show()
		if self.Options.ShowSaraHealth then
			DBM.BossHealth:RemoveBoss(33134)
			if not self.Options.HealthFrame then
				DBM.BossHealth:Hide()
			end
		end
	end
end