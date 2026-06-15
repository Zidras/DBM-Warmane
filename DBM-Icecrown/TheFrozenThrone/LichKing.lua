local mod	= DBM:NewMod("LichKing", "DBM-Icecrown", 5)
local L		= mod:GetLocalizedStrings()

local UnitGUID, UnitName, GetSpellInfo = UnitGUID, UnitName, GetSpellInfo
local UnitInRange, UnitIsUnit, UnitInVehicle, IsInRaid = UnitInRange, UnitIsUnit, UnitInVehicle, DBM.IsInRaid

mod:SetRevision("20250812223135")
mod:SetCreatureID(36597)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7)
mod:SetHotfixNoticeRev(20250414000000)
mod:SetMinSyncRevision(20220921000000)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 68981 74270 74271 74272 72259 74273 74274 74275 72143 72146 72147 72148 72262 70358 70498 70541 73779 73780 73781 72762 73539 73650 72350 69242 73800 73801 73802", -- Split into CLEU specific and UNIT_SPELLCAST_START
--	"SPELL_CAST_START 72143 72146 72147 72148 73650 69242 73800 73801 73802", -- CLEU specific
	"SPELL_CAST_SUCCESS 70337 73912 73913 73914 69409 73797 73798 73799 69200 68980 74325 74326 74327 73654 74295 74296 74297", -- Split into CLEU relevant and UNIT_SPELLCAST_SUCCEEDED. Most were kept since they rely on CLEU payload
--	"SPELL_CAST_SUCCESS 70337 73912 73913 73914 69409 73797 73798 73799 69200 68980 74325 74326 74327", -- CLEU relevant
	"SPELL_DISPEL",
	"SPELL_AURA_APPLIED 28747 72754 73708 73709 73710", -- 73650 commented out, no longer needed
	"SPELL_AURA_APPLIED_DOSE 70338 73785 73786 73787",
--	"SPELL_AURA_REMOVED 73655", -- 68980 74325 is 10N and 25N, not needed for FM
	"SPELL_SUMMON 69037 70372",
	"SPELL_DAMAGE 68983 73791 73792 73793",
	"SPELL_MISSED 68983 73791 73792 73793",
	"UNIT_HEALTH target focus",
	"UNIT_AURA_UNFILTERED",
	"UNIT_DIED",
--	"UNIT_SPELLCAST_START boss1",
	"UNIT_SPELLCAST_SUCCEEDED" -- unfiltered as of 14/04/2025, since Warmane broke boss1 units
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

-- switching to faster less cpu wasting UNIT_TARGET scanning method is not reliable, since this event only fires for LK if is target/focus. Such approach would require syncs to minimize risk of not catching the mechanic, with the downside of the performance gain being questionable
--Shadow Trap UNIT_TARGET looks reliable
-- "<29.57 21:04:20> [UNIT_SPELLCAST_START] The Lich King(player1) - Summon Shadow Trap - 0.5s [[boss1:Summon Shadow Trap::0:]]", -- [2616]
-- "<29.57 21:04:20> [DBM_Debug] Boss target scan started for 36597:2:", -- [2617]
-- "<29.57 21:04:20> [DBM_TimerStart] Timer73539next:Next Summon Shadow Trap:15.5:Interface\\Icons\\Spell_Shadow_GatherShadows:next:73539:3:LichKing:nil:nil:Summon Shadow Trap:nil:", -- [2618]
-- "<29.58 21:04:20> [CLEU] SPELL_CAST_START:0xF130008EF5000861:The Lich King:0x0000000000000000:nil:73539:Summon Shadow Trap:nil:nil:", -- [2619]
-- "<29.58 21:04:20> [UNIT_TARGET] boss1#The Lich King#Target: player2#TargetOfTarget: The Lich King", -- [2621]
-- "<29.60 21:04:20> [DBM_Debug] BossTargetScanner has ended for 36597:2:", -- [2622]

--Defile UNIT_TARGET is NOT reliable (one log only fired 2 UNIT_TARGET out of 7 defiles)
--no UNIT_TARGET for defile
-- "<247.54 21:12:30> [UNIT_SPELLCAST_START] The Lich King(player1) - Defile - 2s [[boss1:Defile::0:]]", -- [20743]
-- "<247.54 21:12:30> [DBM_Debug] Boss target scan started for 36597:2:", -- [20744]
-- "<247.54 21:12:30> [DBM_TimerStart] Timer72762next:Next Defile:32.5:Interface\\Icons\\Ability_Rogue_EnvelopingShadows:next:72762:3:LichKing:nil:nil:Defile:nil:", -- [20745]
-- "<247.54 21:12:30> [CLEU] SPELL_CAST_START:0xF130008EF5000861:The Lich King:0x0000000000000000:nil:72762:Defile:nil:nil:", -- [20746]
-- "<247.57 21:12:30> [DBM_Announce] Defile on >player3<:Interface\\Icons\\Ability_Rogue_EnvelopingShadows:target:72762:LichKing:false:", -- [20747]
-- "<247.57 21:12:30> [DBM_Debug] BossTargetScanner has ended for 36597:2:", -- [20748]

--with UNIT_TARGET for defile
-- "<529.67 21:17:12> [UNIT_SPELLCAST_START] The Lich King(player1) - Defile - 2s [[boss1:Defile::0:]]", -- [42820]
-- "<529.67 21:17:12> [DBM_Debug] Boss target scan started for 36597:2:", -- [42821]
-- "<529.67 21:17:12> [DBM_TimerStart] Timer72762next:Next Defile:32.5:Interface\\Icons\\Ability_Rogue_EnvelopingShadows:next:72762:3:LichKing:nil:nil:Defile:nil:", -- [42822]
-- "<529.67 21:17:12> [CLEU] SPELL_CAST_START:0xF130008EF5000861:The Lich King:0x0000000000000000:nil:72762:Defile:nil:nil:", -- [42823]
-- "<529.67 21:17:12> [UNIT_TARGET] boss1#The Lich King#Target: player4#TargetOfTarget: The Lich King", -- [42825]
-- "<529.70 21:17:12> [DBM_Announce] Defile on >player4<:Interface\\Icons\\Ability_Rogue_EnvelopingShadows:target:72762:LichKing:false:", -- [42826]
-- "<529.70 21:17:12> [DBM_Debug] BossTargetScanner has ended for 36597:2:", -- [42827]

local myRealm = select(3, DBM:GetMyPlayerInfo())

-- General
local timerCombatStart		= mod:NewCombatTimer(55)
local berserkTimer			= mod:NewBerserkTimer(myRealm == "Lordaeron" and mod:IsNormal() and 720 or 900)

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

local timerInfestCD					= mod:NewCDCountTimer(21.2, 70541, nil, "Healer|RaidCooldown", nil, 5, nil, DBM_COMMON_L.HEALER_ICON, true) -- 4s variance [21-25] Added "keep" arg. (10N Icecrown 2022/08/25 || 25H Lordaeron 2022/09/03) - 23.1, 22.9, 22.8, Stage 2/84.3, 12.4/96.8, 23.6, 22.2, 21.7, 22.1, 22.7, 22.0, 23.5, 22.0 || 23.0, 21.2, 24.5, 22.8, 22.1, Stage 2/72.4, 12.5/84.9, 22.1, 21.2, 23.9, 23.3, 22.7, 23.1, 22.9, 23.5 ; 22.6, 21.2, 24.8, 22.9, 22.5, Stage 2/72.4, 12.5/84.9, 21.3, 21.6, 22.4, 21.5
local timerNecroticPlagueCleanse	= mod:NewTimer(5, "TimerNecroticPlagueCleanse", 70337, "Healer", nil, 5, DBM_COMMON_L.HEALER_ICON, nil, nil, nil, nil, nil, nil, 70337)
local timerNecroticPlagueCD			= mod:NewCDTimer(30, 70337, nil, nil, nil, 3, nil, DBM_COMMON_L.DISEASE_ICON, true) -- 3s variance [30.1-32.9] Added "keep" arg. (10N Icecrown 2022/08/20 || 10N Icecrown 2022/08/25 || 25H Lordaeron 2022/09/03) - 32.8, 31.6 ; 32.7 ; 31.2;  31.7, 32.7 || 30.2 || 32.3, 32.9 ; 31.3, 31.9 ; 32.9, 30.4 ; 30.7, 31.7 ; 30.1, 30.2 ; 32.6, 31.2 ; 31.1 ; 32.5, 30.3, 31.7
local timerEnrageCD					= mod:NewCDCountTimer("d20", 72143, nil, "Tank|RemoveEnrage", nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON--[[, true]]) -- String timer starting with "d" means "allowDouble". 5s variance [20.1-24.7]. Disabled "keep" arg since cast can be stun-skipped. (25H Lordaeron 2022/09/03) - 20.5, 24.7
local timerShamblingHorror			= mod:NewNextTimer(60, 70372, nil, nil, nil, 1)
local timerDrudgeGhouls				= mod:NewNextTimer(30, 70358, nil, nil, nil, 1)
local timerTrapCD					= mod:NewNextTimer(15.5, 73539, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON, nil, 1, 4) -- Fixed timer, confirmed on log review 2022/09/03

local soundInfestSoon				= mod:NewSoundSoon(70541, nil, "Healer|RaidCooldown")
local soundNecroticOnYou			= mod:NewSoundYou(70337)

mod:AddSetIconOption("NecroticPlagueIcon", 70337, true, 0, {1})
mod:AddSetIconOption("TrapIcon", 73539, true, 0, {7})
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
local timerSoulreaperCD				= mod:NewCDCountTimer(30.5, 69409, nil, "Tank|Healer|TargetedCooldown", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerDefileCD					= mod:NewCDCountTimer(32, 72762, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON, true, 1, 4) -- REVIEW! ~3s variance [32-34.7]. Added "keep" arg, but might need sync for Normal Harvest Soul since CLEU could be OOR - need Normal log from a harvested soul - (25H Lordaeron 2022/09/26_wipe1 || 25H Lordaeron 2022/09/26_wipe2 || 25H Lordaeron 2022/09/26_wipe3 || 25H Lordaeron 2022/09/26_wipe4 || 25H Lordaeron 2022/09/26_wipe5 || 25H Lordaeron 2022/09/26_wipe6 || 10N Lordaeron 2022/10/08) - 33.8, 34.2, 32.3, 34.0, 32.8 || 32.4, 34.5, 33.6, 34.4, 33.7 || 33.4, 32.1, 33.0, 32.5, 33.5, 33.3, 33.5 || 33.6, 33.4, 33.0 || Stage 2/37.5, 32.2, 32.0, 33.0, 33.5, 32.1, 32.1, 33.4, Stage 2.5/25.8, Stage 3/62.5, 64.0/126.6/152.4, 32.7, 73.6, 32.6, 74.5 || 32.6, 34.7, 32.5, 34.2, 33.7 || Stage 2/37.5, 32.1, 32.8, Stage 2.5/24.2, Stage 3/62.5, 32.9/95.5/119.6, 32.7, 32.7, 32.9
local timerSummonValkyr				= mod:NewCDCountTimer(45.2, 69037, nil, nil, nil, 1, 71844, DBM_COMMON_L.DAMAGE_ICON, true, 2, 3) -- 5s variance [45-50]. Added "keep" arg (25H Lordaeron 2022/09/21_wipe1 || 25H Lordaeron 2022/09/21_wipe2 || 25H Lordaeron 2022/09/21_kill) - 46.5, 47.1, 45.2 || 50.0, 46.8, 46.2 || 47.8, 48.1, 47.8

local soundDefileOnYou				= mod:NewSoundYou(72762)
local soundSoulReaperSoon			= mod:NewSoundSoon(69409, nil, "Tank|Healer|TargetedCooldown")

mod:AddSetIconOption("DefileIcon", 72762, true, 0, {7})
mod:AddSetIconOption("ValkyrIcon", 69037, true, 5, {2, 3, 4}) -- Despite icon convention, keep 2,3,4 for grabIcon backwards compatibility, since iconSetter may be an old DBM/BW user, and detect target marker on a loop would be too CPU heavy for just this
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
local timerVileSpirit				= mod:NewNextTimer(30.5, 70498, nil, nil, nil, 1)
local timerRestoreSoul				= mod:NewCastTimer(40, 73650, nil, nil, nil, 6)
local timerRoleplay					= mod:NewTimer(162, "TimerRoleplay", 72350, nil, nil, 6)

mod:AddSetIconOption("HarvestSoulIcon", 68980, false, 0, {5})

-- Intermission
mod:AddTimerLine(DBM_COMMON_L.INTERMISSION)
local warnRemorselessWinter			= mod:NewSpellAnnounce(68981, 3) --Phase Transition Start Ability
local warnQuake						= mod:NewSpellAnnounce(72262, 4) --Phase Transition End Ability
local warnRagingSpirit				= mod:NewTargetNoFilterAnnounce(69200, 3) --Transition Add
local warnIceSpheresTarget			= mod:NewTargetAnnounce(69103, 3, 69712, nil, 69090) -- icon: spell_frost_frozencore; shortText "Ice Sphere"
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2)
local warnPhase3Soon				= mod:NewPrePhaseAnnounce(3)

local specWarnRagingSpirit			= mod:NewSpecialWarningYou(69200, nil, nil, nil, 1, 2) --Transition Add
local specWarnIceSpheresYou			= mod:NewSpecialWarningMoveAway(69103, nil, 69090, nil, 1, 2) -- shortText "Ice Sphere"
local specWarnGTFO					= mod:NewSpecialWarningGTFO(68983, nil, nil, nil, 1, 8)

local timerPhaseTransition			= mod:NewTimer(62.5, "PhaseTransition", 72262, nil, nil, 6)
local timerRagingSpiritCD			= mod:NewNextCountTimer(20, 69200, nil, nil, nil, 1)
local timerSoulShriekCD				= mod:NewCDTimer(12, 69242, nil, nil, nil, 1)

mod:AddRangeFrameOption(8, 72133)
mod:AddSetIconOption("RagingSpiritIcon", 69200, false, 0, {6})

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
local iceSpheresGUIDs = {}
local ragingSpiritsGUIDs = {}
local warnedValkyrGUIDs = {}
local valkyrTargets = {}
local plagueHop = DBM:GetSpellInfo(70338)--Hop spellID only, not cast one.
-- local soulshriek = GetSpellInfo(69242)
local plagueExpires = {}
local grabIcon = 2
--	local lastValk = 0
--	local maxValks = mod:IsDifficulty("normal25", "heroic25") and 3 or 1
local warnedAchievement = false
local lastPlague

--[[
local function numberOfValkyrTargets(tbl)
	if not tbl then return 0 end
	local count = 0
	for _ in pairs(tbl) do
		count = count + 1
	end
	return count
end

local function scanValkyrTargets(self)
	if numberOfValkyrTargets(valkyrTargets) < maxValks and (time() - lastValk) < 10 then	-- scan for like 10secs, but exit earlier if all the valks have spawned and grabbed their players
		for uId in DBM:GetGroupMembers() do		-- for every raid member check ..
			DBM:Debug("Valkyr check for "..  UnitName(uId) ..": UnitInVehicle is returning " .. (UnitInVehicle(uId) or "nil") .. " and UnitInRange is returning " .. (UnitInRange(uId) or "nil") .. " with distance: " .. DBM.RangeCheck:GetDistance(uId) .."yd. Checking if it is already cached: " .. (valkyrTargets[uId] and "true" or "nil."), 3)
			if UnitInVehicle(uId) and not valkyrTargets[uId] then	  -- if person #i is in a vehicle and not already announced
				valkyrGrabWarning:Show(UnitName(uId))
				valkyrTargets[uId] = true
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
				if DBM:IsInGroup() and self.Options.AnnounceValkGrabs and DBM:GetRaidRank() > 1 then
					local channel = (IsInRaid() and "RAID") or "PARTY"
					if self.Options.ValkyrIcon then
						SendChatMessage(L.ValkGrabbedIcon:format(grabIcon, UnitName(uId)), channel)
					else
						SendChatMessage(L.ValkGrabbed:format(UnitName(uId)), channel)
					end
				end
				grabIcon = grabIcon + 1--Makes assumption discovery order of vehicle grabs will match combat log order, since there is a delay
			end
		end
		self:Schedule(0.5, scanValkyrTargets, self)  -- check for more targets in a few
	else
		table.wipe(valkyrTargets)	   -- no more valkyrs this round, so lets clear the table
		grabIcon = 2
		self.vb.valkIcon = 2
	end
end
--]]

local function RemoveImmunes(self)
	if self.Options.RemoveImmunes then -- cancelaura bop bubble iceblock Dintervention
		CancelUnitBuff("player", (GetSpellInfo(10278)))
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
		timerNecroticPlagueCD:Start(-delay) -- no difference between N and H. (10N Icecrown 2022/08/20 || 10N Icecrown 2022/08/25 || 25H Lordaeron 2022/09/03) - 31.1; 32.6 || 31.6 || 30.7; 32.1; 31.0; 32.7; 30.4; 31.7; 31.5; 32.8; 30.8
		timerInfestCD:Start(5.0-delay, self.vb.infestCount+1) -- Fixed timer, confirmed on log review 2022/09/03
	elseif self.vb.phase == 2 then
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		if self.Options.ShowFrame then
			self:CreateFrame()
		end
		timerSummonValkyr:Start(17, self.vb.valkyrWaveCount+1) -- (25H Lordaeron 2022/09/21_wipe1 || 25H Lordaeron 2022/09/21_wipe2 || 25H Lordaeron 2022/09/21_kill || 25H Lordaeron 2022/09/26_wipe3 || 25H Lordaeron 2022/09/26_wipe6) - 17.5 || 17.5 || 17.4 || 17.3 || 17.0
		timerSoulreaperCD:Start(40, self.vb.soulReaperCount+1)
		soundSoulReaperSoon:Schedule(40-2.5, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\soulreaperSoon.mp3")
		timerDefileCD:Start(37.5, self.vb.defileCount+1)
		timerInfestCD:Start(12.2, self.vb.infestCount+1) -- 0.3s variance [12.2-12.5] (10N Icecrown 2022/08/25 || 25H Lordaeron 2022/09/03) - 12.4 || 12.5; 12.5; 12.5; 12.2; 12.5; 12.5; 12.5
		soundInfestSoon:Schedule(12.2-2, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\infestSoon.mp3")
		warnDefileSoon:Schedule(33, self.vb.defileCount+1)
		warnDefileSoon:ScheduleVoice(33, "scatter") -- Voice Pack - Scatter.ogg: "Spread!"
		self:RegisterShortTermEvents(
			"UNIT_ENTERING_VEHICLE",
			"UNIT_EXITING_VEHICLE"
		)
	elseif self.vb.phase == 3 then
		warnPhase3:Show()
		warnPhase3:Play("pthree")
		timerVileSpirit:Start(17)
		timerSoulreaperCD:Start(37.5, self.vb.soulReaperCount+1)
		soundSoulReaperSoon:Schedule(37.5-2.5, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\soulreaperSoon.mp3")
		timerDefileCD:Start(nil, self.vb.defileCount+1)
		warnDefileSoon:Schedule(32-5, self.vb.defileCount+1)
		warnDefileSoon:ScheduleVoice(32-5, "scatter")
		timerHarvestSoulCD:Start(13.6) -- REVIEW! variance? (25H Lordaeron 2022/10/21 || 25H Lordaeron 2022/11/16) - 13.6 || 14.0
--		if self:IsHeroic() then
--			self:RegisterShortTermEvents(
--				"ZONE_CHANGED"
--			)
--		end
	end
end

local function leftFrostmourne(self)
	DBM:Debug("Left Frostmourne")
	DBM:AddSpecialEventToTranscriptorLog("Left Frostmourne")
	timerHarvestSoulCD:Start(58.72) -- Subtract [58.72]s from Exit FM to next CAST_SUCCESS diff. Timestamps: Harvest cast success > Enter Frostmourne (SAA 73655) > Exit FM (SAR 73655) > Harvest cast. (25H Lordaeron [2023-08-23]@[22:14:48]) - "Harvest Souls-74297-npc:36597-3706 = pull:452.4/Stage 3/14.0, 107.3, 107.2" => '107.3 calculation as follows': 452.42 > 458.44 [6.02] > 500.97 [42.53/48.55] > 559.69 [58.72/101.25/107.27]
	timerDefileCD:Start(1.5, self.vb.defileCount+1) -- As soon as the group leaves FM
	warnDefileSoon:Show(self.vb.defileCount+1)
	warnDefileSoon:Play("scatter") -- Voice Pack - Scatter.ogg: "Spread!"
	timerSoulreaperCD:Start(3.5, self.vb.soulReaperCount+1) -- After Defile cast (+2s)
	soundSoulReaperSoon:Schedule(3.5-2.5, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\soulreaperSoon.mp3")
	timerVileSpirit:Start(7.81) -- (25H Lordaeron [2023-09-13]@[22:13:36]) - "Vile Spirits-70498-npc:36597-4244 = pull:518.95/Left Frostmourne/7.81, 40.11, Left Frostmourne/59.17, 7.81/66.98, 39.97, Left Frostmourne/59.45"
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
	table.wipe(iceSpheresGUIDs)
	table.wipe(ragingSpiritsGUIDs)
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
		self:SetIcon(targetname, 7, 4)
	end
	if targetname == UnitName("player") then
		specWarnDefileCast:Show()
		specWarnDefileCast:Play("runout")
		soundDefileOnYou:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\defileOnYou.mp3")
		yellDefile:Yell()
	elseif self:CheckNearby(11, targetname) then
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
		self:SetIcon(targetname, 7, 4)
	end
	if targetname == UnitName("player") then
		specWarnTrap:Show()
		specWarnTrap:Play("watchstep")
		yellTrap:Yell()
	elseif self:CheckNearby(15, targetname) then
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
		self:SetStage(self.vb.phase + 0.5) -- Intermission. Use + 0.5 workaround to differentiate between intermissions.
		self.vb.ragingSpiritCount = 1
		warnRemorselessWinter:Show()
		timerPhaseTransition:Start()
		if self.vb.phase == 1.5 then
			timerRagingSpiritCD:Start(6, self.vb.ragingSpiritCount) -- Fixed timer, confirmed after log review 2022/09/26: 6.0 for first intermission
		else
			timerRagingSpiritCD:Start(5, self.vb.ragingSpiritCount) -- Fixed timer, confirmed after log review 2022/09/26: 5.0 for second intermission
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
		self:RegisterShortTermEvents(
			"UPDATE_MOUSEOVER_UNIT",
			"UNIT_TARGET_UNFILTERED"
		)
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
		timerEnrageCD:Schedule(25, nil, shamblingCount, args.sourceGUID) -- has to be the highest possible timer
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
		self:BossTargetScanner(36597, "TrapTarget", 0.02, 10)
		timerTrapCD:Start()
	elseif spellId == 73650 then -- Restore Soul (Heroic)
		warnRestoreSoul:Show()
		timerRestoreSoul:Start()
		self:Schedule(40, leftFrostmourne, self) -- Always 40s
		if self.Options.RemoveImmunes then
			self:Schedule(39.99, RemoveImmunes, self)
		end
	elseif spellId == 72350 then -- Fury of Frostmourne
		self:SetWipeTime(190) --Change min wipe time mid battle to force dbm to keep module loaded for this long out of combat roleplay, hopefully without breaking mod.
		self:Stop()
		self:ClearIcons()
		timerRoleplay:Start()
	elseif args:IsSpellID(69242, 73800, 73801, 73802) then -- Soul Shriek Raging spirits
		timerSoulShriekCD:Start(args.sourceGUID)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
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
			self:SetIcon(lastPlague, 4, 5)
		end
	elseif args:IsSpellID(69409, 73797, 73798, 73799) then -- Soul reaper (MT debuff)
		self.vb.soulReaperCount = self.vb.soulReaperCount + 1
		timerSoulreaperCD:Cancel()
		warnSoulreaper:Show(self.vb.soulReaperCount, args.destName)
		specwarnSoulreaper:Show(args.destName)
		timerSoulreaper:Start(args.destName)
		timerSoulreaperCD:Start(nil, self.vb.soulReaperCount+1)
		soundSoulReaperSoon:Schedule(30.5-2.5, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\soulreaperSoon.mp3")
		if args:IsPlayer() then
			specWarnSoulreaper:Show()
			specWarnSoulreaper:Play("defensive")
		else
			specWarnSoulreaperOtr:Show(args.destName)
			specWarnSoulreaperOtr:Play("tauntboss")
		end
	elseif spellId == 69200 then -- Raging Spirit
		self.vb.ragingSpiritCount = self.vb.ragingSpiritCount + 1
		tinsert(ragingSpiritsGUIDs, "unknownSpiritGUID")
		timerSoulShriekCD:Start(20, "unknownSpiritGUID") -- spirit GUID is unknown, and it would be expensive to both retrieve it later and to manipulate the timer, so we just use a dummy GUID to cancel later
		if args:IsPlayer() then
			specWarnRagingSpirit:Show()
			specWarnRagingSpirit:Play("targetyou")
		else
			warnRagingSpirit:Show(args.destName)
		end
		if self.vb.phase == 1.5 then
			timerRagingSpiritCD:Start(nil, self.vb.ragingSpiritCount) -- Fixed timer, confirmed after log review 2022/09/03: 20.0 for first intermission
		else
			timerRagingSpiritCD:Start(15.0, self.vb.ragingSpiritCount) -- Fixed timer, confirmed after log review 2022/09/03: 15.0 for second intermission
		end
		if self.Options.RagingSpiritIcon then
			self:SetIcon(args.destName, 6, 5)
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
			self:SetIcon(args.destName, 5, 5)
		end
	elseif args:IsSpellID(73654, 74295, 74296, 74297) then -- Harvest Souls (Heroic)
		specWarnHarvestSouls:Show()
		--specWarnHarvestSouls:Play("phasechange")
--		timerHarvestSoulCD:Start(106.1) -- Custom edit to make Harvest Souls timers work again. REVIEW! 1s variance? (25H Lordaeron 2022/09/03 || 25H Lordaeron 2022/11/16) - 106.4, 107.5, 106.5 || 106.1, 106.3, 106.6
		timerVileSpirit:Cancel()
		timerSoulreaperCD:Cancel()
		soundSoulReaperSoon:Cancel()
		timerDefileCD:Cancel()
		warnDefileSoon:Cancel()
		warnDefileSoon:CancelVoice()
		self:SetWipeTime(50)--We set a 45 sec min wipe time to keep mod from ending combat if you die while rest of raid is in frostmourn
		self:Schedule(50, RestoreWipeTime, self)
--		self:Schedule(48.55, leftFrostmourne, self) -- Subtract [48.55]s from Exit FM to last CAST_SUCCESS diff. Timestamps: Harvest cast success > Enter Frostmourne (SAA 73655) > Exit FM (SAR 73655) > Exit FM (ZONE_CHANGED) > Harvest cast. (25H Lordaeron [2023-08-23]@[22:14:48]) - "Harvest Souls-74297-npc:36597-3706 = pull:452.4/Stage 3/14.0, 107.3, 107.2" => '107.3 calculation as follows': 452.42 > 458.44 [6.02] > 500.97 [42.53/48.55] > 501.39 [0.42/42.95/48.97] > 559.69 [58.30/58.72/101.25/107.27]
	end
end

function mod:SPELL_DISPEL(args)
	local extraSpellId = args.extraSpellId
	if type(extraSpellId) == "number" and (extraSpellId == 70337 or extraSpellId == 73912 or extraSpellId == 73913 or extraSpellId == 73914 or extraSpellId == 70338 or extraSpellId == 73785 or extraSpellId == 73786 or extraSpellId == 73787) then
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
--	if args:IsSpellID(72143, 72146, 72147, 72148) then -- Shambling Horror enrage effect. Disabled on AURA_APPLIED since it is earlier (and therefore better) on CAST_START. Also prevents double announce
--		timerEnrageCD:Cancel(args.sourceGUID)
--		warnShamblingEnrage:Show(args.destName)
--		timerEnrageCD:Start(args.sourceGUID)
	if spellId == 28747 then -- Shambling Horror enrage effect on low hp
		specWarnEnrageLow:Show()
	elseif args:IsSpellID(72754, 73708, 73709, 73710) and args:IsPlayer() and self:AntiSpam(2, 1) then		-- Defile Damage
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
		soundDefileOnYou:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\defileOnYou.mp3")
--[[ -- no longer needed since we use SPELL_CAST_START scheduling for leftFrostmourne. Unsure as to when this
	elseif spellId == 73650 and self:AntiSpam(3, 2) then		-- Restore Soul (Heroic)
		-- DBM:AddMsg("Restore Soul SPELL_AURA_APPLIED unhidden from combat log. Notify Zidras on Discord or GitHub") -- no longer valid, at least from 18/04/2025 on Warmane.
		timerHarvestSoulCD:Start(60) -- this is slighly innacurate
		timerVileSpirit:Start(10)--May be wrong too but we'll see, didn't have enough log for this one.
]]
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

--[[ This would probably fail on early UNIT_DIED, so schedule it instead
function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 73655 and args:IsPlayer() then -- Harvest Soul (25H)
		timerHarvestSoulCD:Start(57.5) -- Subtract [48.56]s to CAST_SUCCESS diff. Timestamps: Harvest cast > Enter Frostmourne > Exit FM > Harvest cast. (25H Lordaeron [2023-08-23]@[22:14:48]) - "Harvest Souls-74297-npc:36597-3706 = pull:452.4/Stage 3/14.0, 107.3, 107.2" => '107.3 calculation as follows': 452.42 > 458.87 [6.45] > 500.98 > 501.39 [0.41/42.52/48.97] > 559.69 [58.30/58.71/100.82/107.27]
	end
end
]]

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
--[[		self.vb.valkyrWaveCount = self.vb.valkyrWaveCount + 1
		if time() - lastValk > 15 then -- show the warning and timer just once for all three summon events
			warnSummonValkyr:Show(self.vb.valkyrWaveCount)
			timerSummonValkyr:Start(nil, self.vb.valkyrWaveCount+1)
			lastValk = time()
			scanValkyrTargets(self)
			--if self.Options.ValkyrIcon then
			--	local cid = self:GetCIDFromGUID(args.destGUID)
			--	if self:IsDifficulty("normal25", "heroic25") then
			--		self:ScanForMobs(args.destGUID, 1, 2, 3, nil, 20, "ValkyrIcon")--mod, scanId, iconSetMethod, mobIcon, maxIcon,
			--	else
			--		self:ScanForMobs(args.destGUID, 1, 2, 1, nil, 20, "ValkyrIcon")
			--	end
			--end
		end--]]
	elseif spellId == 70372 then -- Shambling Horror
		tinsert(shamblingHorrorsGUIDs, args.destGUID) -- Spawn order. Idea was to somehow distinguish shamblings, so let's do this on the assumption that it's visually easy to differentiate them due to HP diff.
		local shamblingCount = DBM:tIndexOf(shamblingHorrorsGUIDs, args.destGUID)
		warnShamblingSoon:Cancel()
		warnShamblingHorror:Show()
		warnShamblingSoon:Schedule(55)
		timerShamblingHorror:Start()
		timerEnrageCD:Start(12.3, shamblingCount, args.destGUID) -- -20s from Shambling Enrage summon. 34.4 || 34.3; 32.3; 33.4
		timerEnrageCD:Schedule(12.3+2, nil, shamblingCount, args.destGUID) -- apparently on Warmane if you stun on pre-cast, it skips the Enrage. Couldn't repro on test server nor validate it, but doesn't really hurt because SCS has Restart method
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
		timerNecroticPlagueCleanse:Restart() -- prevent timer debug, since dispel can (and should) happen before the 5s expires
		if name == UnitName("player") and not mod:IsTank() then
			specWarnNecroticPlague:Show()
			soundNecroticOnYou:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\necroticOnYou.mp3")
		end
		if self.Options.NecroticPlagueIcon then
			self:SetIcon(uId, 4, 5)
		end
	end
end

function mod:UNIT_ENTERING_VEHICLE(uId)
	local unitName = UnitName(uId)
	DBM:Debug("UNIT_ENTERING_VEHICLE Val'kyr check for "..  unitName .. " (" .. uId .. "): UnitInVehicle is returning " .. (UnitInVehicle(uId) or "nil") .. " and UnitInRange is returning " .. (UnitInRange(uId) or "nil") .. " with distance: " .. DBM.RangeCheck:GetDistance(uId) .."yd. Checking if it is already cached: " .. (valkyrTargets[unitName] and "true" or "nil."), 3)
--		DBM:Debug(unitName .. " (" .. uId .. ") has entered a vehicle. Confirming API: " .. (UnitInVehicle(uId) or "nil"))
	if UnitInVehicle(uId) and not valkyrTargets[unitName] then	  -- if person is in a vehicle and not already announced (API is probably unneeded, need more logs to confirm. Cache check is required to prevent this event from multifiring for the same raid member with more than one uId)
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
		grabIcon = grabIcon + 1--Makes assumption discovery order of vehicle grabs will match combat log order, since there is a delay
	end
end

function mod:UNIT_EXITING_VEHICLE(uId)
	local unitName = UnitName(uId)
	DBM:Debug(unitName .. " (" .. uId .. ") has exited a vehicle. Confirming API: " .. (UnitInVehicle(uId) or "nil"))
	if valkyrTargets[unitName] then -- on Val'kyr passenger drop, it sometimes fires twice in one second succession, so check cache (AntiSpam was a bit too much for this)
		valkyrTargets[unitName] = nil
		self:RemoveEntry(unitName)
	end
end
--[[
function mod:UNIT_SPELLCAST_START(_, spellName)
	if spellName == GetSpellInfo(68981) then -- Remorseless Winter (phase transition start)
		self:SetStage(self.vb.phase + 0.5) -- Intermission. Use + 0.5 workaround to differentiate between intermissions.
		self.vb.ragingSpiritCount = 1
		warnRemorselessWinter:Show()
		timerPhaseTransition:Start()
		if self.vb.phase == 1.5 then
			timerRagingSpiritCD:Start(6, self.vb.ragingSpiritCount) -- Fixed timer, confirmed after log review 2022/09/26: 6.0 for first intermission
		else
			timerRagingSpiritCD:Start(5, self.vb.ragingSpiritCount) -- Fixed timer, confirmed after log review 2022/09/26: 5.0 for second intermission
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
		self:RegisterShortTermEvents(
			"UPDATE_MOUSEOVER_UNIT",
			"UNIT_TARGET_UNFILTERED"
		)
		self:DestroyFrame()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif spellName == GetSpellInfo(72262) then -- Quake (phase transition end)
		self.vb.ragingSpiritCount = 0
		warnQuake:Show()
		timerRagingSpiritCD:Cancel()
		self:SetStage(self.vb.phase + 0.5) -- Return back to whole number
		self:UnregisterShortTermEvents()
		NextPhase(self) -- keep this after UnregisterShortTermEvents for P2 vehicle events
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellName == GetSpellInfo(70358) then -- Drudge Ghouls
		warnDrudgeGhouls:Show()
		timerDrudgeGhouls:Start()
	elseif spellName == GetSpellInfo(70498) then -- Vile Spirits
		warnSummonVileSpirit:Show()
		timerVileSpirit:Start()
	elseif spellName == GetSpellInfo(70541) then -- Infest
		self.vb.infestCount = self.vb.infestCount + 1
		warnInfest:Show(self.vb.infestCount)
		specWarnInfest:Show(self.vb.infestCount)
		timerInfestCD:Start(nil, self.vb.infestCount+1)
		soundInfestSoon:Cancel()
		soundInfestSoon:Schedule(22.5-2, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\infestSoon.mp3")
	elseif spellName == GetSpellInfo(72762) then -- Defile
		self.vb.defileCount = self.vb.defileCount + 1
		self:BossTargetScanner(36597, "DefileTarget", 0.02, 15)
		warnDefileSoon:Cancel()
		warnDefileSoon:CancelVoice()
		warnDefileSoon:Schedule(27, self.vb.defileCount+1)
		warnDefileSoon:ScheduleVoice(27, "scatter")
		timerDefileCD:Start(nil, self.vb.defileCount+1)
	elseif spellName == GetSpellInfo(73539) then -- Shadow Trap (Heroic)
		self:BossTargetScanner(36597, "TrapTarget", 0.02, 10)
		timerTrapCD:Start()
	elseif spellName == GetSpellInfo(72350) then -- Fury of Frostmourne
		self:SetWipeTime(190) --Change min wipe time mid battle to force dbm to keep module loaded for this long out of combat roleplay, hopefully without breaking mod.
		self:Stop()
		self:ClearIcons()
		timerRoleplay:Start()
	end
end
]]

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
--	if spellName == soulshriek and mod:LatencyCheck() then
--		self:SendSync("SoulShriek", UnitGUID(uId))
	if (spellName == GetSpellInfo(74361) or spellName == GetSpellInfo(69037)) and self:AntiSpam(5, 4) then -- Summon Val'kyr Periodic (10H, 25N, 25H) | Summon Val'kyr (10N)
		table.wipe(valkyrTargets)	-- reset valkyr cache for next round
		grabIcon = 2
		self.vb.valkIcon = 2
		self.vb.valkyrWaveCount = self.vb.valkyrWaveCount + 1
		warnSummonValkyr:Show(self.vb.valkyrWaveCount)
		timerSummonValkyr:Start(nil, self.vb.valkyrWaveCount+1)
	--[[
	elseif spellName == GetSpellInfo(73654) then -- Harvest Souls (Heroic)
		specWarnHarvestSouls:Show()
		--specWarnHarvestSouls:Play("phasechange")
--		timerHarvestSoulCD:Start(106.1) -- Custom edit to make Harvest Souls timers work again. REVIEW! 1s variance? (25H Lordaeron 2022/09/03 || 25H Lordaeron 2022/11/16) - 106.4, 107.5, 106.5 || 106.1, 106.3, 106.6
		timerVileSpirit:Cancel()
		timerSoulreaperCD:Cancel()
		soundSoulReaperSoon:Cancel()
		timerDefileCD:Cancel()
		warnDefileSoon:Cancel()
		warnDefileSoon:CancelVoice()
		self:SetWipeTime(50)--We set a 45 sec min wipe time to keep mod from ending combat if you die while rest of raid is in frostmourn
		self:Schedule(50, RestoreWipeTime, self)
--		self:Schedule(48.55, leftFrostmourne, self) -- Subtract [48.55]s from Exit FM to last CAST_SUCCESS diff. Timestamps: Harvest cast success > Enter Frostmourne (SAA 73655) > Exit FM (SAR 73655) > Exit FM (ZONE_CHANGED) > Harvest cast. (25H Lordaeron [2023-08-23]@[22:14:48]) - "Harvest Souls-74297-npc:36597-3706 = pull:452.4/Stage 3/14.0, 107.3, 107.2" => '107.3 calculation as follows': 452.42 > 458.44 [6.02] > 500.97 [42.53/48.55] > 501.39 [0.42/42.95/48.97] > 559.69 [58.30/58.72/101.25/107.27]
	]]
	end
end

function mod:UPDATE_MOUSEOVER_UNIT()
	if DBM:GetUnitCreatureId("mouseover") == 36633 then -- Ice Sphere
		local sphereGUID = UnitGUID("mouseover")
		local sphereTarget = UnitName("mouseovertarget")
		if sphereGUID and sphereTarget and not iceSpheresGUIDs[sphereGUID] then
			local sphereString = ("%s\t%s"):format(sphereTarget, sphereGUID)
			self:SendSync("SphereTarget", sphereString)
		end
	elseif DBM:GetUnitCreatureId("mouseover") == 36701 then -- Raging Spirit
		local spiritGUID = UnitGUID("mouseover")
		if spiritGUID and not tContains(ragingSpiritsGUIDs, spiritGUID) then
			local spiritIndex = DBM:tIndexOf(ragingSpiritsGUIDs, "unknownSpiritGUID")
			if spiritIndex then
				ragingSpiritsGUIDs[spiritIndex] = spiritGUID -- replace the dummy GUID with the real one
				local totalTime = timerSoulShriekCD:Time("unknownSpiritGUID")
				local elapsedTime = timerSoulShriekCD:GetTime("unknownSpiritGUID")
				timerSoulShriekCD:Cancel("unknownSpiritGUID") -- cancel the dummy timer
				timerSoulShriekCD:Update(elapsedTime, totalTime, spiritGUID) -- restart the timer with the real GUID
			end
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
	elseif DBM:GetUnitCreatureId(uId.."target") == 36701 then -- Raging Spirit
		local spiritGUID = UnitGUID(uId.."target")
		if spiritGUID and not tContains(ragingSpiritsGUIDs, spiritGUID) then
			local spiritIndex = DBM:tIndexOf(ragingSpiritsGUIDs, "unknownSpiritGUID")
			if spiritIndex then
				ragingSpiritsGUIDs[spiritIndex] = spiritGUID -- replace the dummy GUID with the real one
				local totalTime = timerSoulShriekCD:Time("unknownSpiritGUID")
				local elapsedTime = timerSoulShriekCD:GetTime("unknownSpiritGUID")
				timerSoulShriekCD:Cancel("unknownSpiritGUID") -- cancel the dummy timer
				timerSoulShriekCD:Update(elapsedTime, totalTime, spiritGUID) -- restart the timer with the real GUID
			end
		end
	end
end

--[[
-- "<673.50 22:26:02> [DBM_Debug] Indoor/SubZone changed on zoneID: 605 and subZone: Frostmourne:nil:"
-- "<673.51 22:26:02> [ZONE_CHANGED_INDOORS] The Frozen Throne:Icecrown Citadel:Frostmourne:"

-- "<715.75 22:26:44> [DBM_Debug] Indoor/SubZone changed on zoneID: 605 and subZone: The Frozen Throne:nil:"
-- "<715.76 22:26:44> [ZONE_CHANGED] Icecrown Citadel:Icecrown Citadel:The Frozen Throne:"

-- This would probably fail on early UNIT_DIED, and is personal event, so schedule it instead
function mod:ZONE_CHANGED() -- [ZONE_CHANGED] Icecrown Citadel:Icecrown Citadel:The Frozen Throne:
	timerHarvestSoulCD:Start(58.3)
end
]]

function mod:OnSync(msg, target)
	if msg == "CombatStart" then
		timerCombatStart:Start()
--	elseif msg == "SoulShriek" then
--		timerSoulShriekCD:Start(target)
	elseif msg == "SphereTarget" then
		local sphereTarget, sphereGUID = strsplit("\t", target)
		if sphereTarget and sphereGUID and not iceSpheresGUIDs[sphereGUID] then
			iceSpheresGUIDs[sphereGUID] = sphereTarget
			warnIceSpheresTarget:Show(sphereTarget)
			if sphereTarget == UnitName("player") then
				specWarnIceSpheresYou:Show()
				specWarnIceSpheresYou:Play("iceorbmove")
			end
		end
	end
end
