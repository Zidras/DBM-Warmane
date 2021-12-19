local mod	= DBM:NewMod("LichKing", "DBM-Icecrown", 5)
local L		= mod:GetLocalizedStrings()

local UnitGUID, UnitName, GetSpellInfo = UnitGUID, UnitName, GetSpellInfo

mod:SetRevision(("$Revision: 4425 $"):sub(12, -3))
mod:SetCreatureID(36597)
mod:SetUsedIcons(2, 3, 4, 5, 6, 7, 8)
mod:SetMinSyncRevision(3913)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DISPEL",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"UNIT_HEALTH",
	"UNIT_AURA",
	"UNIT_EXITING_VEHICLE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnRemorselessWinter = mod:NewSpellAnnounce(68981, 3) --Phase Transition Start Ability
local warnQuake				= mod:NewSpellAnnounce(72262, 4) --Phase Transition End Ability
local warnRagingSpirit		= mod:NewTargetAnnounce(69200, 3) --Transition Add
local warnShamblingSoon		= mod:NewSoonAnnounce(70372, 2) --Phase 1 Add
local warnShamblingHorror	= mod:NewSpellAnnounce(70372, 3) --Phase 1 Add
local warnDrudgeGhouls		= mod:NewSpellAnnounce(70358, 2) --Phase 1 Add
local warnShamblingEnrage	= mod:NewTargetAnnounce(72143, 3, nil, "Tank|Healer|RemoveEnrage") --Phase 1 Add Ability
local warnNecroticPlague	= mod:NewTargetAnnounce(70337, 3) --Phase 1+ Ability
local warnNecroticPlagueJump= mod:NewAnnounce("WarnNecroticPlagueJump", 4, 70337) --Phase 1+ Ability
local warnInfest			= mod:NewSpellAnnounce(73779, 3, nil, "Healer|RaidCooldown") --Phase 1 & 2 Ability
local warnIceSpheresTarget	= mod:NewTargetAnnounce(69103, 3, 69712, nil, 69090) -- icon: spell_frost_frozencore; shortText "Ice Sphere"
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local valkyrWarning			= mod:NewAnnounce("ValkyrWarning", 3, 71844)--Phase 2 Ability
local warnDefileSoon		= mod:NewSoonAnnounce(72762, 3)	--Phase 2+ Ability
local warnSoulreaper		= mod:NewSpellAnnounce(73797, 4) --Phase 2+ Ability
local warnDefileCast		= mod:NewTargetAnnounce(72762, 4) --Phase 2+ Ability
local warnSummonValkyr		= mod:NewSpellAnnounce(69037, 3, 71844) --Phase 2 Add
local warnPhase3Soon		= mod:NewPrePhaseAnnounce(3)
local warnPhase3			= mod:NewPhaseAnnounce(3)
local warnSummonVileSpirit	= mod:NewSpellAnnounce(70498, 2) --Phase 3 Add
local warnHarvestSoul		= mod:NewTargetAnnounce(68980, 3) --Phase 3 Ability
local warnTrapCast			= mod:NewTargetAnnounce(73539, 4) --Phase 1 Heroic Ability
local warnRestoreSoul		= mod:NewCastAnnounce(73650, 2) --Phase 3 Heroic

local specWarnSoulreaper	= mod:NewSpecialWarningDefensive(69409, nil, nil, nil, 1, 2) --Phase 1+ Ability
local specWarnNecroticPlague= mod:NewSpecialWarningMoveAway(70337, nil, nil, nil, 1, 2) --Phase 1+ Ability
local specWarnRagingSpirit	= mod:NewSpecialWarningYou(69200, nil, nil, nil, 1, 2) --Transition Add
local specWarnIceSpheresYou	= mod:NewSpecialWarningMoveAway(69103, nil, 69090, nil, 1, 2) -- shortText "Ice Sphere"
local specWarnYouAreValkd	= mod:NewSpecialWarning("SpecWarnYouAreValkd", nil, nil, nil, 1, 2) --Phase 2+ Ability
local specWarnDefileCast	= mod:NewSpecialWarningMoveAway(72762, nil, nil, nil, 3, 2) --Phase 2+ Ability
local yellDefile			= mod:NewYellMe(72762)
local specWarnDefileNear	= mod:NewSpecialWarningClose(72762, nil, nil, nil, 1, 2) --Phase 2+ Ability
local specWarnDefile		= mod:NewSpecialWarningMove(72762, nil, nil, nil, 1, 2) --Phase 2+ Ability
local specWarnWinter		= mod:NewSpecialWarningMove(68983, nil, nil, nil, 1, 2) --Transition Ability
local specWarnHarvestSoul	= mod:NewSpecialWarningYou(68980, nil, nil, nil, 1, 2) --Phase 3+ Ability
local specWarnInfest		= mod:NewSpecialWarningSpell(70541, nil, nil, nil, 2) --Phase 1+ Ability
local specwarnSoulreaper	= mod:NewSpecialWarningTarget(73797, true) --phase 2+
local specWarnSoulreaperOtr	= mod:NewSpecialWarningTaunt(69409, false, nil, nil, 1, 2) --phase 2+; disabled by default, not standard tactic
local specWarnTrap			= mod:NewSpecialWarningYou(73539, nil, nil, nil, 3, 2) --Heroic Ability
local yellTrap				= mod:NewYellMe(73539)
local specWarnTrapNear		= mod:NewSpecialWarningClose(73539, nil, nil, nil, 3, 2) --Heroic Ability
local specWarnHarvestSouls	= mod:NewSpecialWarningSpell(73654, nil, nil, nil, 1, 2) --Heroic Ability
local specWarnValkyrLow		= mod:NewSpecialWarning("SpecWarnValkyrLow", nil, nil, nil, 1, 2)
local specWarnEnrage		= mod:NewSpecialWarningSpell(72143, "Tank")
local specWarnEnrageLow		= mod:NewSpecialWarningSpell(28747, false)

local timerCombatStart		= mod:NewCombatTimer(55)
local timerPhaseTransition	= mod:NewTimer(62.5, "PhaseTransition", 72262, nil, nil, 6)
local timerSoulreaper	 	= mod:NewTargetTimer(5.1, 69409, nil, "Tank|Healer|TargetedCooldown")
local timerSoulreaperCD	 	= mod:NewNextTimer(30.5, 69409, nil, "Tank|Healer|TargetedCooldown", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerHarvestSoul	 	= mod:NewTargetTimer(6, 68980)
local timerHarvestSoulCD	= mod:NewNextTimer(75, 68980, nil, nil, nil, 6)
local timerInfestCD			= mod:NewNextTimer(22.5, 70541, nil, "Healer|RaidCooldown", nil, 5, nil, DBM_CORE_L.HEALER_ICON, nil, nil, 4)
local timerNecroticPlagueCleanse = mod:NewTimer(5, "TimerNecroticPlagueCleanse", 70337, "Healer", nil, 5, DBM_CORE_L.HEALER_ICON)
local timerNecroticPlagueCD	= mod:NewNextTimer(30, 70337, nil, nil, nil, 3)
local timerDefileCD			= mod:NewNextTimer(32.5, 72762, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON, nil, 2, 4)
local timerEnrageCD			= mod:NewCDTimer(20, 72143, nil, "Tank|RemoveEnrage", nil, 5, nil, DBM_CORE_L.ENRAGE_ICON)
local timerShamblingHorror 	= mod:NewNextTimer(60, 70372, nil, nil, nil, 1)
local timerDrudgeGhouls 	= mod:NewNextTimer(20, 70358, nil, nil, nil, 1)
local timerRagingSpiritCD	= mod:NewNextTimer(22, 69200, nil, nil, nil, 1)
local timerSoulShriekCD		= mod:NewCDTimer(12, 69242, nil, nil, nil, 1)
local timerSummonValkyr 	= mod:NewCDTimer(45, 71844, nil, nil, nil, 1)
local timerVileSpirit 		= mod:NewNextTimer(30.5, 70498, nil, nil, nil, 1)
local timerTrapCD		 	= mod:NewNextTimer(15.5, 73539, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON, nil, nil, 4)
local timerRestoreSoul 		= mod:NewCastTimer(40, 73650, nil, nil, nil, 6)
local timerRoleplay			= mod:NewTimer(162, "TimerRoleplay", 72350, nil, nil, 6)

local soundInfestSoon		= mod:NewSoundSoon(70541, nil, "Healer|RaidCooldown")
local soundNecroticOnYou	= mod:NewSoundYou(70337)
local soundDefileOnYou		= mod:NewSoundYou(72762)
local soundSoulReaperSoon	= mod:NewSoundSoon(69409, nil, "Tank|Healer|TargetedCooldown")

local berserkTimer			= mod:NewBerserkTimer(900)

mod:AddBoolOption("DefileIcon")
mod:AddBoolOption("NecroticPlagueIcon")
mod:AddBoolOption("RagingSpiritIcon", false)
mod:AddBoolOption("TrapIcon")
mod:AddSetIconOption("ValkyrIcon", 71844, true, true)
mod:AddBoolOption("HarvestSoulIcon", false)
mod:AddBoolOption("AnnounceValkGrabs", false)
mod:AddBoolOption("AnnouncePlagueStack", false, "announce")
mod:AddBoolOption("TrapArrow")
mod:AddBoolOption("RemoveImmunes")
mod:AddBoolOption("ShowFrame", true)
mod:AddBoolOption("FrameLocked", false)
mod:AddBoolOption("FrameClassColor", true, nil, function()
	mod:UpdateColors()
end)
mod:AddBoolOption("FrameUpwards", false, nil, function()
	mod:ChangeFrameOrientation()
end)
mod:AddEditboxOption("FramePoint", "CENTER")
mod:AddEditboxOption("FrameX", 150)
mod:AddEditboxOption("FrameY", -50)

local warnedAchievement = false
mod.vb.warned_preP2 = false
mod.vb.warned_preP3 = false
local iceSpheresGUIDs = {}
local warnedValkyrGUIDs = {}
local plagueHop = DBM:GetSpellInfo(70338)--Hop spellID only, not cast one.
local plagueExpires = {}
local lastPlague

local soulshriek = GetSpellInfo(69242)
local summonIceSphere = GetSpellInfo(69103)

function mod:RemoveImmunes()
	if mod.Options.RemoveImmunes then -- cancelaura bop bubble iceblock Dintervention
		CancelUnitBuff("player", (GetSpellInfo(10278)))
		CancelUnitBuff("player", (GetSpellInfo(642)))
		CancelUnitBuff("player", (GetSpellInfo(45438)))
		CancelUnitBuff("player", (GetSpellInfo(19752)))
	end
end

local function NextPhase(self)
	self:SetStage(0)
	if self.vb.phase == 1 then
		berserkTimer:Start()
		warnShamblingSoon:Schedule(15)
		timerShamblingHorror:Start(20)
		timerDrudgeGhouls:Start(10)
		if self:IsHeroic() then
			timerTrapCD:Start()
			timerNecroticPlagueCD:Start(30)
		else
			timerNecroticPlagueCD:Start(27)
		end
	elseif self.vb.phase == 2 then
		warnPhase2:Show()
		warnPhase2:Play("phasechange")
		if self.Options.ShowFrame then
			self:CreateFrame()
		end
		timerSummonValkyr:Start(20)
		timerSoulreaperCD:Start(40)
		soundSoulReaperSoon:Schedule(40-2.5, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\soulreaperSoon.mp3")
		timerDefileCD:Start(38)
		timerInfestCD:Start(14)
		soundInfestSoon:Schedule(14-2, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\infestSoon.mp3")
		warnDefileSoon:Schedule(33)
		warnDefileSoon:ScheduleVoice(33, "scatter") -- Voice Pack - Scatter.ogg: "Spread!"
	elseif self.vb.phase == 3 then
		warnPhase3:Show()
		warnPhase3:Play("phasechange")
		timerVileSpirit:Start(17)
		timerSoulreaperCD:Start(37.5)
		soundSoulReaperSoon:Schedule(37.5-2.5, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\soulreaperSoon.mp3")
		timerDefileCD:Start(33.5)
		timerHarvestSoulCD:Start(14)
		warnDefileSoon:Schedule(30)
		warnDefileSoon:ScheduleVoice(30, "scatter")
	end
end

local function RestoreWipeTime(self)
	self:SetWipeTime(5) --Restore it after frostmourn room.
end

function mod:OnCombatStart(delay)
	self:DestroyFrame()
	self.vb.phase = 0
	self.vb.warned_preP2 = false
	self.vb.warned_preP3 = false
	NextPhase(self)
	table.wipe(iceSpheresGUIDs)
	table.wipe(warnedValkyrGUIDs)
	table.wipe(plagueExpires)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	self:DestroyFrame()
end

function mod:DefileTarget(targetname, uId)
	if not targetname then return end
	warnDefileCast:Show(targetname)
	if self.Options.DefileIcon then
		self:SetIcon(targetname, 8, 4)
	end
	if targetname == UnitName("player") then
		specWarnDefileCast:Show()
		specWarnDefileCast:Play("runout")
		soundDefileOnYou:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\defileOnYou.mp3")
		yellDefile:Yell()
	else
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnDefileNear:Show(targetname)
			end
		end
	end
end

function mod:TrapTarget(targetname, uId)
	if not targetname then return end
	warnTrapCast:Show(targetname)
	if self.Options.TrapIcon then
		self:SetIcon(targetname, 8, 4)
	end
	if uId and targetname then
		if targetname == UnitName("player") then
			specWarnTrap:Show()
			specWarnTrap:Play("watchstep")
			yellTrap:Yell()
		else
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnTrapNear:Show(targetname)
				specWarnTrapNear:Play("watchstep")
			end
		end
		if self.Options.TrapArrow then
			local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
			DBM.Arrow:ShowRunAway(x, y, 10, 5)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68981, 74270, 74271, 74272) or args:IsSpellID(72259, 74273, 74274, 74275) then -- Remorseless Winter (phase transition start)
		warnRemorselessWinter:Show()
		timerPhaseTransition:Start()
		timerRagingSpiritCD:Start(6)
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
		self:DestroyFrame()
	elseif args:IsSpellID(72143, 72146, 72147, 72148) then -- Shambling Horror enrage effect.
		timerEnrageCD:Cancel(args.sourceGUID)
		warnShamblingEnrage:Show(args.sourceName)
		specWarnEnrage:Show()
		timerEnrageCD:Start(args.sourceGUID)
		timerEnrageCD:Schedule(21,args.sourceGUID)
	elseif args.spellId == 72262 then -- Quake (phase transition end)
		warnQuake:Show()
		timerRagingSpiritCD:Cancel()
		NextPhase(self)
		self:UnregisterShortTermEvents()
	elseif args.spellId == 70372 then -- Shambling Horror
		warnShamblingSoon:Cancel()
		warnShamblingHorror:Show()
		warnShamblingSoon:Schedule(55)
		timerShamblingHorror:Start()
	elseif args.spellId == 70358 then -- Drudge Ghouls
		warnDrudgeGhouls:Show()
		timerDrudgeGhouls:Start()
	elseif args.spellId == 70498 then -- Vile Spirits
		warnSummonVileSpirit:Show()
		timerVileSpirit:Start()
	elseif args:IsSpellID(70541, 73779, 73780, 73781) then -- Infest
		warnInfest:Show()
		specWarnInfest:Show()
		timerInfestCD:Start()
		soundInfestSoon:Cancel()
		soundInfestSoon:Schedule(22.5-2, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\infestSoon.mp3")
	elseif args.spellId == 72762 then -- Defile
		self:BossTargetScanner(36597, "DefileTarget", 0.02, 15)
		warnDefileSoon:Cancel()
		warnDefileSoon:CancelVoice()
		warnDefileSoon:Schedule(27)
		warnDefileSoon:ScheduleVoice(27, "scatter")
		timerDefileCD:Start()
	elseif args.spellId == 73539 then -- Shadow Trap (Heroic)
		self:BossTargetScanner(36597, "TrapTarget", 0.02, 15)
		timerTrapCD:Start()
	elseif args.spellId == 73650 then -- Restore Soul (Heroic)
		warnRestoreSoul:Show()
		timerRestoreSoul:Start()
		if mod.Options.RemoveImmunes then
			self:ScheduleMethod(39.99, "RemoveImmunes")
		end
	elseif args.spellId == 72350 then -- Fury of Frostmourne
		self:SetWipeTime(190) --Change min wipe time mid battle to force dbm to keep module loaded for this long out of combat roleplay, hopefully without breaking mod.
		self:Stop()
		self:ClearIcons()
		timerRoleplay:Start()
	elseif args:IsSpellID(69242,73800,73801,73802) then -- Soul Shriek Raging spirits
		timerSoulShriekCD:Start(args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(70337, 73912, 73913, 73914) then -- Necrotic Plague (SPELL_AURA_APPLIED is not fired for this spell)
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
		timerSoulreaperCD:Cancel()
		warnSoulreaper:Show(args.destName)
		specwarnSoulreaper:Show(args.destName)
		timerSoulreaper:Start(args.destName)
		timerSoulreaperCD:Start()
		soundSoulReaperSoon:Schedule(30.5-2.5, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\soulreaperSoon.mp3")
		if args:IsPlayer() then
			specWarnSoulreaper:Show()
			specWarnSoulreaper:Play("defensive")
		else
			specWarnSoulreaperOtr:Show(args.destName)
			specWarnSoulreaperOtr:Play("tauntboss")
		end
	elseif args.spellId == 69200 then -- Raging Spirit
		timerSoulShriekCD:Start(20, args.destName)
		if args:IsPlayer() then
			specWarnRagingSpirit:Show()
			specWarnRagingSpirit:Play("targetyou")
		else
			warnRagingSpirit:Show(args.destName)
		end
		if self.vb.phase == 1 then
			timerRagingSpiritCD:Start()
		else
			timerRagingSpiritCD:Start(17)
		end
		if self.Options.RagingSpiritIcon then
			self:SetIcon(args.destName, 7, 5)
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
		--specWarnHarvestSouls:Play("phasechange")
		timerHarvestSoulCD:Start(107) -- Custom edit to make Harvest Souls timers work again
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
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 70337 or args.extraSpellId == 73912 or args.extraSpellId == 73913 or args.extraSpellId == 73914 or args.extraSpellId == 70338 or args.extraSpellId == 73785 or args.extraSpellId == 73786 or args.extraSpellId == 73787) then
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(72143, 72146, 72147, 72148) then -- Shambling Horror enrage effect.
		timerEnrageCD:Cancel(args.sourceGUID)
		warnShamblingEnrage:Show(args.destName)
		timerEnrageCD:Start(args.sourceGUID)
	elseif args.spellId == 28747 then -- Shambling Horror enrage effect on low hp
		specWarnEnrageLow:Show()
	elseif args:IsSpellID(72754, 73708, 73709, 73710) and args:IsPlayer() and self:AntiSpam(2, 1) then		-- Defile Damage
		specWarnDefile:Show()
		specWarnDefile:Play("runaway")
		soundDefileOnYou:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\defileOnYou.mp3")
	elseif args.spellId == 73650 and self:AntiSpam(3, 2) then		-- Restore Soul (Heroic)
		timerHarvestSoulCD:Start(60)
		timerVileSpirit:Start(10)--May be wrong too but we'll see, didn't have enough log for this one.
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

do
	local valkyrTargets = {}
	local grabIcon = 2
	local lastValk = 0
	local UnitIsUnit, UnitInVehicle, IsInRaid = UnitIsUnit, UnitInVehicle, IsInRaid

	local function scanValkyrTargets(self)
		if (time() - lastValk) < 10 then    -- scan for like 10secs
			for uId in DBM:GetGroupMembers() do        -- for every raid member check ..
				if UnitInVehicle(uId) and not valkyrTargets[uId] then      -- if person #i is in a vehicle and not already announced
					valkyrWarning:Show(UnitName(uId))  -- GetRaidRosterInfo(i) returns the name of the person who got valkyred
					valkyrTargets[uId] = true          -- this person has been announced
					local raidIndex = UnitInRaid(uId)
					local name, _, subgroup, _, _, fileName = GetRaidRosterInfo(raidIndex + 1)
					if name == UnitName(uId) then
						local grp = subgroup
						local class = fileName
						mod:AddEntry(name, grp or 0, class, grabIcon)
					end
					if UnitIsUnit(uId, "player") then
						specWarnYouAreValkd:Show()
						specWarnYouAreValkd:Play("targetyou")
					end
					if IsInGroup() and self.Options.AnnounceValkGrabs and DBM:GetRaidRank() > 1 then
						if self.Options.ValkyrIcon then
							SendChatMessage(L.ValkGrabbedIcon:format(grabIcon, UnitName(uId)), "RAID")
						else
							SendChatMessage(L.ValkGrabbed:format(UnitName(uId)), "RAID")
						end
					end
					grabIcon = grabIcon + 1
				end
			end
			self:Schedule(0.5, scanValkyrTargets, self)  -- check for more targets in a few
		else
			table.wipe(valkyrTargets)       -- no more valkyrs this round, so lets clear the table
			grabIcon = 2
		end
	end

	function mod:SPELL_SUMMON(args)
		if args.spellId == 69037 then -- Summon Val'kyr
			if self.Options.ShowFrame then
				self:CreateFrame()
			end
			if time() - lastValk > 15 then -- show the warning and timer just once for all three summon events
				warnSummonValkyr:Show()
				timerSummonValkyr:Start()
				lastValk = time()
				scanValkyrTargets(self)
				if self.Options.ValkyrIcon then
					local cid = self:GetCIDFromGUID(args.destGUID)
					if self:IsDifficulty("normal25", "heroic25") then
						self:ScanForMobs(cid, 1, 2, 3, 0.1, 20, "ValkyrIcon")
					else
						self:ScanForMobs(cid, 1, 2, 1, 0.1, 20, "ValkyrIcon")
					end
				end
			end
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if (spellId == 68983 or spellId == 73791 or spellId == 73792 or spellId == 73793) and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then		-- Remorseless Winter
		specWarnWinter:Show()
		specWarnWinter:Play("runaway")
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHeroic() and self:GetUnitCreatureId(uId) == 36609 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.55 and not warnedValkyrGUIDs[UnitGUID(uId)] then
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
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 37698 then--Shambling Horror
		timerEnrageCD:Cancel(args.sourceGUID)
	elseif cid == 36701 then -- Raging Spirit
		timerSoulShriekCD:Cancel(args.sourceGUID)
	end
end

function mod:UNIT_AURA(uId)
	local name = DBM:GetUnitFullName(uId)
	if (not name) or (name == lastPlague) then return end
	local _, _, _, _, _, _, expires, _, _, _, spellId = DBM:UnitDebuff(uId, plagueHop)
	if not spellId or not expires then return end
	if (spellId == 73787 or spellId == 70338 or spellId == 73785 or spellId == 73786) and expires > 0 and not plagueExpires[expires] then
		plagueExpires[expires] = true
		warnNecroticPlagueJump:Show(name)
		timerNecroticPlagueCleanse:Start()
		if name == UnitName("player") and not mod:IsTank() then
			specWarnNecroticPlague:Show()
			soundNecroticOnYou:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\necroticOnYou.mp3")
		end
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(uId, 5, 5)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == soulshriek and mod:LatencyCheck() then
		self:SendSync("SoulShriek", UnitGUID(uId))
	elseif spellName == summonIceSphere then
		self:RegisterShortTermEvents(
			"UPDATE_MOUSEOVER_UNIT",
			"UNIT_TARGET"
		)
	end
end

function mod:UNIT_EXITING_VEHICLE(uId)
	mod:RemoveEntry(UnitName(uId))
end

function mod:UPDATE_MOUSEOVER_UNIT()
	if DBM:GetUnitCreatureId("mouseover") == 36633 then -- Ice Sphere
		local sphereGUID = UnitGUID("mouseover")
		local sphereTarget = UnitName("mouseovertarget")
		if sphereGUID and sphereTarget and not iceSpheresGUIDs[sphereGUID] then
			iceSpheresGUIDs[sphereGUID] = sphereTarget
			self:SendSync("SphereTarget", sphereTarget, sphereGUID)
		end
	end
end

function mod:UNIT_TARGET(uId)
	if DBM:GetUnitCreatureId(uId.."target") == 36633 then -- Ice Sphere
		local sphereGUID = UnitGUID(uId.."target")
		local sphereTarget = UnitName(uId.."targettarget")
		if sphereGUID and sphereTarget and not iceSpheresGUIDs[sphereGUID] then
			iceSpheresGUIDs[sphereGUID] = sphereTarget
			warnIceSpheresTarget:Show(sphereTarget)
			if sphereTarget == UnitName("player") then
				specWarnIceSpheresYou:Show()
				specWarnIceSpheresYou:Play("161411") -- Ice orb. Move away!
			end
		end
	end
end

function mod:OnSync(msg, target, guid)
	if msg == "CombatStart" then
		timerCombatStart:Start()
	elseif msg == "SoulShriek" then
		timerSoulShriekCD:Start(target)
	elseif msg == "SphereTarget" and not iceSpheresGUIDs[guid] then
		iceSpheresGUIDs[guid] = target
		warnIceSpheresTarget:Show(target)
		if target == UnitName("player") then
			specWarnIceSpheresYou:Show()
			specWarnIceSpheresYou:Play("161411") -- Ice orb. Move away!
		end
	end
end