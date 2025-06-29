local mod	= DBM:NewMod("LichKing", "DBM-Icecrown", 5)
local L		= mod:GetLocalizedStrings()

local UnitGUID, UnitName, GetSpellInfo = UnitGUID, UnitName, GetSpellInfo
local UnitInRange, UnitIsUnit, UnitInVehicle, IsInRaid = UnitInRange, UnitIsUnit, UnitInVehicle, DBM.IsInRaid

mod:SetRevision("20250530223932")
mod:SetCreatureID(36597)
mod:SetUsedIcons(2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20250523112110)
mod:SetMinSyncRevision(20250530223932)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 68981 74270 74271 74272 72259 74273 74274 74275 72143 72146 72147 72148 72262 70358 70498 70541 73779 73780 73781 72762 73539 73650 72350 69242 73800 73801 73802",
	"SPELL_CAST_SUCCESS 70337 73912 73913 73914 69409 73797 73798 73799 69200 68980 74325 74326 74327 73654 74295 74296 74297",
	"SPELL_DISPEL",
	"SPELL_AURA_APPLIED 28747 72754 73708 73709 73710 73650",
	"SPELL_AURA_APPLIED_DOSE 70338 73785 73786 73787",
	"SPELL_SUMMON 69037 70372",
	"SPELL_DAMAGE 68983 73791 73792 73793",
	"SPELL_MISSED 68983 73791 73792 73793",
	"UNIT_HEALTH target focus",
	"UNIT_AURA_UNFILTERED",
	--"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_DIED"

)


-- General
local timerCombatStart		= mod:NewCombatTimer(54.55)
local berserkTimer			= mod:NewBerserkTimer(900)

mod:AddBoolOption("RemoveImmunes")
mod:AddMiscLine(L.FrameGUIDesc)
mod:AddBoolOption("ShowFrame", true)
mod:AddBoolOption("FrameLocked", false)
mod:AddBoolOption("FrameClassColor", true, nil, function()
	mod:UpdateColors()
end)
mod:AddBoolOption("FrameUpwards", false, nil, function()
	mod:ChangeFrameOrientation()
end)
mod:AddButton(L.FrameGUIMoveMe, function() mod:CreateFrame() end, nil, 130, 20)

-- Stage One
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1))
local warnShamblingSoon				= mod:NewSoonAnnounce(70372, 2) --Phase 1 Add
local warnShamblingHorror			= mod:NewSpellAnnounce(70372, 3) --Phase 1 Add
local warnDrudgeGhouls				= mod:NewSpellAnnounce(70358, 2) --Phase 1 Add
local warnShamblingEnrage			= mod:NewTargetNoFilterAnnounce(72143, 3, nil, "Tank|Healer|RemoveEnrage") --Phase 1 Add Ability
local warnNecroticPlague			= mod:NewTargetNoFilterAnnounce(70337, 3) --Phase 1+ Ability
local warnNecroticPlagueJump		= mod:NewAnnounce("WarnNecroticPlagueJump", 4, 70337, nil, nil, nil, 70337) --Phase 1+ Ability
local warnInfest					= mod:NewCountAnnounce(70541, 3, nil, "Healer|RaidCooldown") --Phase 1 & 2 Ability
local warnTrapCast					= mod:NewTargetDistanceAnnounce(73539, 4, nil, nil, nil, nil, nil, nil, true) --Phase 1 Heroic Ability

local specWarnNecroticPlague		= mod:NewSpecialWarningMoveAway(70337, nil, nil, nil, 1, 2) --Phase 1+ Ability
local specWarnInfest				= mod:NewSpecialWarningCount(70541, nil, nil, nil, 1) --Phase 1+ Ability
local specWarnTrap					= mod:NewSpecialWarningYou(73539, nil, nil, nil, 3, 2, 3) --Heroic Ability
local yellTrap						= mod:NewYellMe(73539)
local specWarnTrapNear				= mod:NewSpecialWarningClose(73539, nil, nil, nil, 3, 2, 3) --Heroic Ability
local specWarnEnrage				= mod:NewSpecialWarningSpell(72143, "Tank")
local specWarnEnrageLow				= mod:NewSpecialWarningSpell(28747, false)

local timerInfestCD					= mod:NewCDCountTimer(22, 70541, nil, "Healer|RaidCooldown", nil, 5, nil, DBM_COMMON_L.HEALER_ICON, true)
local timerNecroticPlagueCleanse	= mod:NewTimer(5, "TimerNecroticPlagueCleanse", 70337, "Healer", nil, 5, DBM_COMMON_L.HEALER_ICON, nil, nil, nil, nil, nil, nil, 70337)
local timerNecroticPlagueCD			= mod:NewCDTimer(30, 70337, nil, nil, nil, 3, nil, DBM_COMMON_L.DISEASE_ICON, true)
local timerEnrageCD					= mod:NewCDCountTimer("d20", 72143, nil, "Tank|RemoveEnrage", nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON)
local timerShamblingHorror			= mod:NewNextTimer(60, 70372, nil, nil, nil, 1)
local timerDrudgeGhouls				= mod:NewNextTimer(30, 70358, nil, nil, nil, 1)
local timerTrapCD					= mod:NewNextTimer(15.5, 73539, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON, nil, 1, 4)

local soundInfestSoon				= mod:NewSoundSoon(70541, nil, "Healer|RaidCooldown")
local soundNecroticOnYou			= mod:NewSoundYou(70337)

mod:AddSetIconOption("NecroticPlagueIcon", 70337, true, 0, {5})
mod:AddSetIconOption("TrapIcon", 73539, true, 0, {8})
mod:AddArrowOption("TrapArrow", 73539, true)
mod:AddBoolOption("AnnouncePlagueStack", false, nil, nil, nil, nil, 70337)

-- Stage Two
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2))
local warnPhase2					= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local valkyrGrabWarning				= mod:NewAnnounce("ValkyrWarning", 3, 71844, nil, nil, nil, 69037)--Phase 2 Ability
local warnDefileSoon				= mod:NewSoonCountAnnounce(72762, 3)	--Phase 2+ Ability
local warnSoulreaper				= mod:NewTargetCountAnnounce(69409, 4) --Phase 2+ Ability
local warnDefileCast				= mod:NewTargetCountDistanceAnnounce(72762, 4, nil, nil, nil, nil, nil, nil, true) --Phase 2+ Ability
local warnSummonValkyr				= mod:NewCountAnnounce(69037, 3, 71844) --Phase 2 Add

local specWarnYouAreValkd			= mod:NewSpecialWarning("SpecWarnYouAreValkd", nil, nil, nil, 1, 2, nil, 71844, 69037) --Phase 2+ Ability
local specWarnDefileCast			= mod:NewSpecialWarningMoveAway(72762, nil, nil, nil, 3, 2) --Phase 2+ Ability
local yellDefile					= mod:NewYellMe(72762)
local specWarnDefileNear			= mod:NewSpecialWarningClose(72762, nil, nil, nil, 1, 2) --Phase 2+ Ability
local specWarnSoulreaper			= mod:NewSpecialWarningDefensive(69409, nil, nil, nil, 1, 2) --Phase 2+ Ability
local specwarnSoulreaper			= mod:NewSpecialWarningTarget(69409, true) --phase 2+
local specWarnSoulreaperOtr			= mod:NewSpecialWarningTaunt(69409, false, nil, nil, 1, 2) --phase 2+; disabled by default, not standard tactic
local specWarnValkyrLow				= mod:NewSpecialWarning("SpecWarnValkyrLow", nil, nil, nil, 1, 2, nil, 71844, 69037)

local timerSoulreaper				= mod:NewTargetTimer(5.1, 69409, nil, "Tank|Healer|TargetedCooldown")
local timerSoulreaperCD				= mod:NewCDCountTimer(33.1, 69409, nil, "Tank|Healer|TargetedCooldown", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerDefileCD					= mod:NewCDCountTimer(32.5, 72762, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON, true, 1, 4)
local timerSummonValkyr				= mod:NewCDCountTimer(45.2, 69037, nil, nil, nil, 1, 71844, DBM_COMMON_L.DAMAGE_ICON, true, 2, 3)

local soundDefileOnYou				= mod:NewSoundYou(72762)
local soundSoulReaperSoon			= mod:NewSoundSoon(69409, nil, "Tank|Healer|TargetedCooldown")

mod:AddSetIconOption("DefileIcon", 72762, true, 0, {8})
mod:AddSetIconOption("ValkyrIcon", 69037, true, 5, {2, 3, 4})
mod:AddArrowOption("DefileArrow", 72762, true)
mod:AddBoolOption("AnnounceValkGrabs", false, nil, nil, nil, nil, 69037)

-- Stage Three
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(3))
local warnPhase3					= mod:NewPhaseAnnounce(3, 2, nil, nil, nil, nil, nil, 2)
local warnSummonVileSpirit			= mod:NewSpellAnnounce(70498, 2) --Phase 3 Add
local warnHarvestSoul				= mod:NewTargetNoFilterAnnounce(68980, 3) --Phase 3 Ability
local warnRestoreSoul				= mod:NewCastAnnounce(73650, 2) --Phase 3 Heroic

local specWarnHarvestSoul			= mod:NewSpecialWarningYou(68980, nil, nil, nil, 1, 2) --Phase 3+ Ability
local specWarnHarvestSouls			= mod:NewSpecialWarningSpell(73654, nil, nil, nil, 1, 2, 3) --Heroic Ability

local timerHarvestSoul				= mod:NewTargetTimer(6, 68980)
local timerHarvestSoulCD			= mod:NewNextTimer(75, 68980, nil, nil, nil, 6)
local timerVileSpirit				= mod:NewNextTimer(30, 70498, nil, nil, nil, 1)
local timerRestoreSoul				= mod:NewCastTimer(40, 73650, nil, nil, nil, 6)
local timerRoleplay					= mod:NewTimer(165, "TimerRoleplay", 72350, nil, nil, 6)

mod:AddSetIconOption("HarvestSoulIcon", 68980, false, 0, {6})

-- Intermission
mod:AddTimerLine(DBM_COMMON_L.INTERMISSION)
local warnRemorselessWinter			= mod:NewSpellAnnounce(68981, 3) --Phase Transition Start Ability
local warnQuake						= mod:NewSpellAnnounce(72262, 4) --Phase Transition End Ability
local warnRagingSpirit				= mod:NewTargetNoFilterAnnounce(69200, 3) --Transition Add
--local warnIceSpheresTarget			= mod:NewTargetAnnounce(69103, 3, 69712, nil, 69090) -- Ne marche pas sur WOE car les sphères n'ont pas de cibles.
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2)
local warnPhase3Soon				= mod:NewPrePhaseAnnounce(3)

local specWarnRagingSpirit			= mod:NewSpecialWarningYou(69200, nil, nil, nil, 1, 2) --Transition Add
--local specWarnIceSpheresYou			= mod:NewSpecialWarningMoveAway(69103, nil, 69090, nil, 1, 2) -- Ne marche pas sur WOE car les sphères n'ont pas de cibles.
local specWarnGTFO					= mod:NewSpecialWarningGTFO(68983, nil, nil, nil, 1, 8)

local timerPhaseTransition			= mod:NewTimer(62.5, "PhaseTransition", 72262, nil, nil, 6)
local timerRagingSpiritCD			= mod:NewNextCountTimer(17, 69200, nil, nil, nil, 1)
local timerSoulShriekCD				= mod:NewCDTimer(12, 69242, nil, nil, nil, 1)

mod:AddRangeFrameOption(8, 72133)
mod:AddSetIconOption("RagingSpiritIcon", 69200, false, 0, {7})

-- P1 variables
mod.vb.warned_preP2 = false
mod.vb.infestCount = 0

-- Intermission variables

mod.vb.ragingSpiritCount = 0

-- P2 variables
mod.vb.warned_preP3 = false
mod.vb.defileCount = 0
mod.vb.soulReaperCount = 0
mod.vb.valkyrWaveCount = 0
mod.vb.valkIcon = 2

local shamblingHorrorsGUIDs = {}
-- local iceSpheresGUIDs = {}
local warnedValkyrGUIDs = {}
local valkyrTargets = {}
local plagueHop = DBM:GetSpellInfo(70338)

local plagueExpires = {}
local grabIcon = 2

local warnedAchievement = false
local lastPlague

local function RemoveImmunes(self)
	if self.Options.RemoveImmunes then -- cancelaura bop bubble iceblock Dintervention
		--CancelUnitBuff("player", (GetSpellInfo(10278))) -- WOE EDIT : La bop ne cancel pas le retour de la FM
		CancelUnitBuff("player", (GetSpellInfo(642)))
		CancelUnitBuff("player", (GetSpellInfo(45438)))
		CancelUnitBuff("player", (GetSpellInfo(19752)))
	end
end

local function NextPhase(self, delay)
	self.vb.infestCount = 0
	self.vb.defileCount = 0
	self.vb.valkyrWaveCount = 0
	self.vb.soulReaperCount = 0
	if self.vb.phase == 1 then
		berserkTimer:Start(-delay)
		warnShamblingSoon:Schedule(15-delay)
		timerShamblingHorror:Start(20-delay)
		timerDrudgeGhouls:Start(10-delay)
		if self:IsHeroic() then
			timerTrapCD:Start(-delay)
		end
		timerNecroticPlagueCD:Start(-delay)
		timerInfestCD:Start(5.0-delay, self.vb.infestCount+1)
	elseif self.vb.phase == 2 then
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		if self.Options.ShowFrame then
			self:CreateFrame()
		end
		timerSummonValkyr:Start(16, self.vb.valkyrWaveCount+1)
		timerSoulreaperCD:Start(40, self.vb.soulReaperCount+1)
		soundSoulReaperSoon:Schedule(40-2.5, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\soulreaperSoon.mp3")
		timerDefileCD:Start(37.5, self.vb.defileCount+1)
		timerInfestCD:Start(13.9, self.vb.infestCount+1)
		soundInfestSoon:Schedule(13.9-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\infestSoon.mp3")
		warnDefileSoon:Schedule(33, self.vb.defileCount+1)
		warnDefileSoon:ScheduleVoice(33, "scatter")
		self:RegisterShortTermEvents(
			"UNIT_ENTERING_VEHICLE",
			"UNIT_EXITING_VEHICLE"
		)
	elseif self.vb.phase == 3 then
		warnPhase3:Show()
		warnPhase3:Play("pthree")
		timerVileSpirit:Start(20)
		timerSoulreaperCD:Start(37.5, self.vb.soulReaperCount+1)
		soundSoulReaperSoon:Schedule(37.5-2.5, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\soulreaperSoon.mp3")
		timerDefileCD:Start(32+5, self.vb.defileCount+1) -- TESTING RE CALIBRATING FOR STARTING P3
		warnDefileSoon:Schedule(32--[[-5]], self.vb.defileCount+1)
		warnDefileSoon:ScheduleVoice(32--[[-5]], "scatter")
		timerHarvestSoulCD:Start(11.1)
	end
end

local function leftFrostmourne(self)
	DBM:Debug("Left Frostmourne")
	DBM:AddSpecialEventToTranscriptorLog("Left Frostmourne")
	timerHarvestSoulCD:Start(58)
	timerDefileCD:Start(1.5, self.vb.defileCount+1) -- As soon as the group leaves FM
	warnDefileSoon:Show(self.vb.defileCount+1)
	warnDefileSoon:Play("scatter")
	timerSoulreaperCD:Start(9.5, self.vb.soulReaperCount+1)
	soundSoulReaperSoon:Schedule(9.5-3, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\soulreaperSoon.mp3")
	timerVileSpirit:Start(15.5)
end

local function RestoreWipeTime(self)
	self:SetWipeTime(5) --Restore it after frostmourn room.
end

function mod:OnCombatStart(delay)
	self:DestroyFrame()
	self:SetStage(1)
	self.vb.valkIcon = 2
	self.vb.warned_preP2 = false
	self.vb.warned_preP3 = false
	self.vb.ragingSpiritCount = 0
	NextPhase(self, delay)
	table.wipe(shamblingHorrorsGUIDs)
--	table.wipe(iceSpheresGUIDs)
	table.wipe(warnedValkyrGUIDs)
	table.wipe(plagueExpires)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	self:DestroyFrame()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:DefileTarget(targetname, uId)
	if not targetname and not uId then return end
	if self.Options.DefileIcon then
		self:SetIcon(targetname, 8, 4)
	end
	if targetname == UnitName("player") then
		specWarnDefileCast:Show()
		specWarnDefileCast:Play("runout")
		soundDefileOnYou:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\defileOnYou.mp3")
		yellDefile:Yell()
	elseif self:CheckNearby(12, targetname) then
		specWarnDefileNear:Show(targetname)
	end
	warnDefileCast:Show(self.vb.defileCount, targetname, DBM.RangeCheck:GetDistance(uId)) -- Always show announcement, regardless of distance
	if self.Options.DefileArrow then
		local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
		DBM.Arrow:ShowRunAway(x, y, 10, 5)
	end
end

function mod:TrapTarget(targetname, uId)
	if not targetname and not uId then return end
	if self.Options.TrapIcon then
		self:SetIcon(targetname, 8, 4)
	end
	if targetname == UnitName("player") then
		specWarnTrap:Show()
		specWarnTrap:Play("watchstep")
		yellTrap:Yell()
	elseif self:CheckNearby(12, targetname) then
		specWarnTrapNear:Show(targetname)
		specWarnTrapNear:Play("watchstep")
	end
	warnTrapCast:Show(targetname, DBM.RangeCheck:GetDistance(uId)) -- Always show announcement, regardless of distance 
	if self.Options.TrapArrow then
		local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
		DBM.Arrow:ShowRunAway(x, y, 10, 5)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if args:IsSpellID(68981, 74270, 74271, 74272) or args:IsSpellID(72259, 74273, 74274, 74275) then -- Remorseless Winter (phase transition start)
		self:SetStage(self.vb.phase + 0.5)
		self.vb.ragingSpiritCount = 1
		warnRemorselessWinter:Show()
		timerPhaseTransition:Start()
		if self.vb.phase == 1.5 then
			timerRagingSpiritCD:Start(12, self.vb.ragingSpiritCount)
		else
			timerRagingSpiritCD:Start(7, self.vb.ragingSpiritCount)
		end
		warnShamblingSoon:Cancel()
		timerShamblingHorror:Cancel()
		timerDrudgeGhouls:Cancel()
		timerSummonValkyr:Cancel()
		timerInfestCD:Cancel()
		soundInfestSoon:Cancel()
		timerNecroticPlagueCD:Cancel()
		timerTrapCD:Cancel()
		timerDefileCD:Cancel()
		warnDefileSoon:Cancel()
		warnDefileSoon:CancelVoice()
		timerSoulreaperCD:Cancel()
		soundSoulReaperSoon:Cancel()
		--self:RegisterShortTermEvents(
		--	"UPDATE_MOUSEOVER_UNIT",
		--	"UNIT_TARGET_UNFILTERED" -- WOE EDIT, LES SPHERES N'ONT PAS DE CIBLES.
		--)
		self:DestroyFrame()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif args:IsSpellID(72143, 72146, 72147, 72148) then -- Shambling Horror enrage effect.
		local shamblingCount = DBM:tIndexOf(shamblingHorrorsGUIDs, args.sourceGUID)
		warnShamblingEnrage:Show(args.sourceName)
		specWarnEnrage:Show()
		timerEnrageCD:Stop(shamblingCount, args.sourceGUID) -- Stop/Unschedule required for multi arg timers, instead of Restart/Cancel - Core bug with mismatched args
		timerEnrageCD:Unschedule(nil, shamblingCount, args.sourceGUID)
		timerEnrageCD:Start(nil, shamblingCount, args.sourceGUID)
		timerEnrageCD:Schedule(25, nil, shamblingCount, args.sourceGUID)
	elseif spellId == 72262 then -- Quake (phase transition end)
		self.vb.ragingSpiritCount = 0
		warnQuake:Show()
		timerRagingSpiritCD:Cancel()
		self:SetStage(self.vb.phase + 0.5) -- Return back to whole number
		self:UnregisterShortTermEvents()
		NextPhase(self) -- keep this after UnregisterShortTermEvents for P2 vehicle events
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 70358 then -- Drudge Ghouls
		warnDrudgeGhouls:Show()
		timerDrudgeGhouls:Start()
	elseif spellId == 70498 then -- Vile Spirits
		warnSummonVileSpirit:Show()
		timerVileSpirit:Start()
	elseif args:IsSpellID(70541, 73779, 73780, 73781) then -- Infest
		self.vb.infestCount = self.vb.infestCount + 1
		warnInfest:Show(self.vb.infestCount)
		specWarnInfest:Show(self.vb.infestCount)
		timerInfestCD:Start(nil, self.vb.infestCount+1)
		soundInfestSoon:Cancel()
		soundInfestSoon:Schedule(22.5-2, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\infestSoon.mp3")
	elseif spellId == 72762 then -- Defile
		self.vb.defileCount = self.vb.defileCount + 1
		self:BossTargetScanner(36597, "DefileTarget", 0.02, 15)
		warnDefileSoon:Cancel()
		warnDefileSoon:CancelVoice()
		warnDefileSoon:Schedule(27, self.vb.defileCount+1)
		warnDefileSoon:ScheduleVoice(27, "scatter")
		timerDefileCD:Start(nil, self.vb.defileCount+1)
	elseif spellId == 73539 then -- Shadow Trap (Heroic)
		self:ScheduleMethod(0.01, "BossTargetScanner", args.sourceGUID, "TrapTarget", 0.02, 15, nil, nil, nil, lastPlague, nil, nil, true)
		timerTrapCD:Start()
	elseif spellId == 73650 then -- Restore Soul (Heroic)
		warnRestoreSoul:Show()
		timerRestoreSoul:Start()
		self:Schedule(40, leftFrostmourne, self) -- Always 40s
		if self.Options.RemoveImmunes then
			self:Schedule(39.99, RemoveImmunes, self)
		end
	elseif spellId == 72350 then -- Fury of Frostmourne
		self:SetWipeTime(190)
		self:Stop()
		self:ClearIcons()
		timerRoleplay:Start()
	elseif args:IsSpellID(69242, 73800, 73801, 73802) then -- Soul Shriek Raging spirits
		timerSoulShriekCD:Start(args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(70337, 73912, 73913, 73914) then -- Necrotic Plague (SPELL_AURA_APPLIED is not fired for this spell) -- WOE EDIT : A vérifier, mais le débuff est bien lancé par le boss.
		lastPlague = args.destName
		warnNecroticPlague:Show(lastPlague)
		timerNecroticPlagueCD:Start()
		timerNecroticPlagueCleanse:Start()
		if args:IsPlayer() then
			specWarnNecroticPlague:Show()
			soundNecroticOnYou:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\necroticOnYou.mp3")
		end
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(lastPlague, 5, 5)
		end
	elseif args:IsSpellID(69409, 73797, 73798, 73799) then -- Soul reaper (MT debuff)
		self.vb.soulReaperCount = self.vb.soulReaperCount + 1
		timerSoulreaperCD:Cancel()
		warnSoulreaper:Show(self.vb.soulReaperCount, args.destName)
		timerSoulreaper:Start(args.destName)
		timerSoulreaperCD:Start(nil, self.vb.soulReaperCount+1)
		soundSoulReaperSoon:Schedule(30.5-2.5, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\soulreaperSoon.mp3")
		if not args:IsPlayer() then -- If not player, to avoid spam on tank if option is enabled
			specwarnSoulreaper:Show(args.destName)
		end
		if args:IsPlayer() then
			specWarnSoulreaper:Show()
			specWarnSoulreaper:Play("defensive")
		else
			specWarnSoulreaperOtr:Show(args.destName)
			specWarnSoulreaperOtr:Play("tauntboss")
		end
	elseif spellId == 69200 then -- Raging Spirit
		--timerRagingSpiritCD:Start(nil, self.vb.ragingSpiritCount)
		self.vb.ragingSpiritCount = self.vb.ragingSpiritCount + 1
		timerSoulShriekCD:Start(17, args.destName)
		if args:IsPlayer() then
			specWarnRagingSpirit:Show()
			specWarnRagingSpirit:Play("targetyou")
		else
			warnRagingSpirit:Show(args.destName)
		end
		if self.Options.RagingSpiritIcon then
			self:SetIcon(args.destName, 7, 5)
		end
		if not ((self.vb.phase == 1.5 and self.vb.ragingSpiritCount >= 4) or (self.vb.phase == 2.5 and self.vb.ragingSpiritCount >= 5)) then
			timerRagingSpiritCD:Start(nil, self.vb.ragingSpiritCount)
		end
	elseif args:IsSpellID(68980, 74325, 74326, 74327) then -- Harvest Soul
		timerHarvestSoul:Start(args.destName)
		timerHarvestSoulCD:Start()
		if args:IsPlayer() then
			specWarnHarvestSoul:Show()
			specWarnHarvestSoul:Play("targetyou")
		else
			warnHarvestSoul:Show(args.destName)
		end
		if self.Options.HarvestSoulIcon then
			self:SetIcon(args.destName, 6, 5)
		end
	elseif args:IsSpellID(73654, 74295, 74296, 74297) then -- Harvest Souls (Heroic)
		specWarnHarvestSouls:Show()
		timerVileSpirit:Cancel()
		timerSoulreaperCD:Cancel()
		soundSoulReaperSoon:Cancel()
		timerDefileCD:Cancel()
		warnDefileSoon:Cancel()
		warnDefileSoon:CancelVoice()
		self:SetWipeTime(50)--We set a 45 sec min wipe time to keep mod from ending combat if you die while rest of raid is in frostmourn
		self:Schedule(50, RestoreWipeTime, self)
	end
end

function mod:SPELL_DISPEL(args)
	local extraSpellId = args.extraSpellId
	if type(extraSpellId) == "number" and (extraSpellId == 70337 or extraSpellId == 73912 or extraSpellId == 73913 or extraSpellId == 73914 or extraSpellId == 70338 or extraSpellId == 73785 or extraSpellId == 73786 or extraSpellId == 73787) then
		lastPlague = nil
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 28747 then -- Shambling Horror enrage effect on low hp
		specWarnEnrageLow:Show()
	elseif args:IsSpellID(72754, 73708, 73709, 73710) and args:IsPlayer() and self:AntiSpam(2, 1) then		-- Defile Damage
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
		soundDefileOnYou:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\defileOnYou.mp3")
	elseif spellId == 73650 and self:AntiSpam(3, 2) then		-- Restore Soul (Heroic)
		DBM:AddMsg("Restore Soul SPELL_AURA_APPLIED unhidden from combat log. Notify Zidras on Discord or GitHub")
		timerHarvestSoulCD:Start(60)
		timerVileSpirit:Start(10)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(70338, 73785, 73786, 73787) then	--Necrotic Plague (hop IDs only since they DO fire for >=2 stacks, since function never announces 1 stacks anyways don't need to monitor LK casts/Boss Whispers here)
		if self.Options.AnnouncePlagueStack and DBM:GetRaidRank() > 0 then
			if args.amount % 10 == 0 or (args.amount >= 10 and args.amount % 5 == 0) then		-- Warn at 10th stack and every 5th stack if more than 10
				SendChatMessage(L.PlagueStackWarning:format(args.destName, (args.amount or 1)), "RAID")
			elseif (args.amount or 1) >= 30 and not warnedAchievement then						-- Announce achievement completed if 30 stacks is reached
				SendChatMessage(L.AchievementCompleted:format(args.destName, (args.amount or 1)), "RAID_WARNING")
				warnedAchievement = true
			end
		end
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 69037 then -- Summon Val'kyr
		if self.Options.ShowFrame then
			self:CreateFrame()
		end
		if self.Options.ValkyrIcon then
			self:ScanForMobs(args.destGUID, 2, self.vb.valkIcon, 1, nil, 12, "ValkyrIcon")
		end
		self.vb.valkIcon = self.vb.valkIcon + 1

	elseif spellId == 70372 then -- Shambling Horror
		tinsert(shamblingHorrorsGUIDs, args.destGUID)
		local shamblingCount = DBM:tIndexOf(shamblingHorrorsGUIDs, args.destGUID)
		warnShamblingSoon:Cancel()
		warnShamblingHorror:Show()
		warnShamblingSoon:Schedule(55)
		timerShamblingHorror:Start()
		timerEnrageCD:Start(12.3, shamblingCount, args.destGUID)
		timerEnrageCD:Schedule(12.3+2, nil, shamblingCount, args.destGUID)
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
	if (spellId == 68983 or spellId == 73791 or spellId == 73792 or spellId == 73793) and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then		-- Remorseless Winter
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_HEALTH(uId)
	if self:IsHeroic() and self:GetUnitCreatureId(uId) == 36609 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.53 and not warnedValkyrGUIDs[UnitGUID(uId)] then
		warnedValkyrGUIDs[UnitGUID(uId)] = true
		specWarnValkyrLow:Show()
		specWarnValkyrLow:Play("stopattack")
	end
	if self.vb.phase == 1 and not self.vb.warned_preP2 and self:GetUnitCreatureId(uId) == 36597 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.73 then
		self.vb.warned_preP2 = true
		warnPhase2Soon:Show()
	elseif self.vb.phase == 2 and not self.vb.warned_preP3 and self:GetUnitCreatureId(uId) == 36597 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.43 then
		self.vb.warned_preP3 = true
		warnPhase3Soon:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.LKPull or msg:find(L.LKPull) then
		self:SendSync("CombatStart")
		if self.Options.ShowFrame then
			self:CreateFrame()
		end
	elseif msg == L.ValkSumm or msg:find(L.ValkSumm) then
		table.wipe(valkyrTargets)	-- reset valkyr cache for next round
		grabIcon = 2
		self.vb.valkIcon = 2
		self.vb.valkyrWaveCount = self.vb.valkyrWaveCount + 1
		warnSummonValkyr:Show(self.vb.valkyrWaveCount)
		timerSummonValkyr:Start(nil, self.vb.valkyrWaveCount+1)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 37698 then--Shambling Horror
		local shamblingCount = DBM:tIndexOf(shamblingHorrorsGUIDs, args.sourceGUID)
		timerEnrageCD:Stop(shamblingCount, args.sourceGUID)
		timerEnrageCD:Unschedule(nil, shamblingCount, args.sourceGUID)
	elseif cid == 36701 then -- Raging Spirit
		timerSoulShriekCD:Cancel(args.sourceGUID)
	end
end

function mod:UNIT_AURA_UNFILTERED(uId)
	local name = DBM:GetUnitFullName(uId)
	if (not name) or (name == lastPlague) then return end
	local _, _, _, _, _, _, expires, _, _, _, spellId = DBM:UnitDebuff(uId, plagueHop)
	if not spellId or not expires then return end
	if (spellId == 73787 or spellId == 70338 or spellId == 73785 or spellId == 73786) and expires > 0 and not plagueExpires[expires] then
		plagueExpires[expires] = true
		warnNecroticPlagueJump:Show(name)
		timerNecroticPlagueCleanse:Restart()
		if name == UnitName("player") and not mod:IsTank() then
			specWarnNecroticPlague:Show()
			soundNecroticOnYou:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\necroticOnYou.mp3")
		end
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(uId, 5, 5)
		end
	end
end

function mod:UNIT_ENTERING_VEHICLE(uId)
	local unitName = UnitName(uId)
	DBM:Debug("UNIT_ENTERING_VEHICLE Val'kyr check for "..  unitName .. " (" .. uId .. "): UnitInVehicle is returning " .. (UnitInVehicle(uId) or "nil") .. " and UnitInRange is returning " .. (UnitInRange(uId) or "nil") .. " with distance: " .. DBM.RangeCheck:GetDistance(uId) .."yd. Checking if it is already cached: " .. (valkyrTargets[unitName] and "true" or "nil."), 3)
	if UnitInVehicle(uId) and not valkyrTargets[unitName] then
		valkyrGrabWarning:Show(DBM:GetUnitRoleIcon(uId), unitName, DBM:IconNumToTexture(grabIcon)) -- roleIcon, name, raid target icon
		valkyrTargets[unitName] = true
		local raidIndex = UnitInRaid(uId)
		local name, _, subgroup, _, _, fileName = GetRaidRosterInfo(raidIndex + 1)
		if name == unitName then
			local grp = subgroup
			local class = fileName
			self:AddEntry(name, grp or 0, class, grabIcon)
		end
		if UnitIsUnit(uId, "player") then
			specWarnYouAreValkd:Show()
			specWarnYouAreValkd:Play("targetyou")
		end
		if DBM:IsInGroup() and self.Options.AnnounceValkGrabs and DBM:GetRaidRank() > 1 then
			local channel = (IsInRaid() and "RAID") or "PARTY"
			if self.Options.ValkyrIcon then
				SendChatMessage(L.ValkGrabbedIcon:format(grabIcon, unitName), channel)
			else
				SendChatMessage(L.ValkGrabbed:format(unitName), channel)
			end
		end
		grabIcon = grabIcon + 1
	end
end

function mod:UNIT_EXITING_VEHICLE(uId)
	local unitName = UnitName(uId)
	DBM:Debug(unitName .. " (" .. uId .. ") has exited a vehicle. Confirming API: " .. (UnitInVehicle(uId) or "nil"))
	if valkyrTargets[unitName] then
		valkyrTargets[unitName] = nil
		self:RemoveEntry(unitName)
	end
end

--[[function mod:UPDATE_MOUSEOVER_UNIT() -- WOE EDIT : NE MARCHE PAS CAR SPHERE PAS DE CIBLE
	if DBM:GetUnitCreatureId("mouseover") == 36633 then -- Ice Sphere
		local sphereGUID = UnitGUID("mouseover")
		local sphereTarget = UnitName("mouseovertarget")
		if sphereGUID and sphereTarget and not iceSpheresGUIDs[sphereGUID] then
			local sphereString = ("%s\t%s"):format(sphereTarget, sphereGUID)
			self:SendSync("SphereTarget", sphereString)
		end
	end
end

function mod:UNIT_TARGET_UNFILTERED(uId)
	if DBM:GetUnitCreatureId(uId.."target") == 36633 then -- Ice Sphere
		local sphereGUID = UnitGUID(uId.."target")
		local sphereTarget = UnitName(uId.."targettarget")
		if sphereGUID and sphereTarget and not iceSpheresGUIDs[sphereGUID] then
			iceSpheresGUIDs[sphereGUID] = sphereTarget
			warnIceSpheresTarget:Show(sphereTarget)
			if sphereTarget == UnitName("player") then
				specWarnIceSpheresYou:Show()
				specWarnIceSpheresYou:Play("iceorbmove")
			end
		end
	end
end]]

function mod:OnSync(msg, target)
	if msg == "CombatStart" then
		timerCombatStart:Start()
	--elseif msg == "SphereTarget" then
		--local sphereTarget, sphereGUID = strsplit("\t", target)
		--if sphereTarget and sphereGUID and not iceSpheresGUIDs[sphereGUID] then
			--iceSpheresGUIDs[sphereGUID] = sphereTarget
			--warnIceSpheresTarget:Show(sphereTarget)
			--if sphereTarget == UnitName("player") then
			--	specWarnIceSpheresYou:Show()
			--	specWarnIceSpheresYou:Play("iceorbmove")
			--end
		--end
	end
end
