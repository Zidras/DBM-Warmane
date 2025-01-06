local mod	= DBM:NewMod("ICCTrash", "DBM-Icecrown", 6)
local L		= mod:GetLocalizedStrings()

local UnitGUID = UnitGUID

mod:SetRevision("20250106224658")
mod:SetModelID(37007)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 71022 71088 71123 71942",
	"SPELL_AURA_APPLIED 69483 72865 71127 70451 70432 70645 71785 71298 70475",
	"SPELL_AURA_APPLIED_DOSE 71127",
	"SPELL_AURA_REMOVED 70451 70432 70645 71785 71298",
	"SPELL_SUMMON 71159",
	"SPELL_DAMAGE 70305",
	"SPELL_MISSED 70305",
	"UNIT_DIED",
	"UNIT_TARGET", -- currently unfiltered due to CORE not defaulting legacy uIds. Review valkyr code below if Core is changed
	"CHAT_MSG_MONSTER_YELL"
)

--Lower Spire
local warnDisruptingShout		= mod:NewSpellAnnounce(71022, 2)
local warnDarkReckoning			= mod:NewTargetNoFilterAnnounce(69483, 3)
local warnDeathPlague			= mod:NewTargetNoFilterAnnounce(72865, 4)
--Plagueworks
local warnZombies				= mod:NewSpellAnnounce(71159, 2)
local warnMortalWound			= mod:NewStackAnnounce(71127, 2, nil, "Tank|Healer")
local warnDecimateSoon			= mod:NewSoonAnnounce(71123, 3)
--Crimson Hall
local warnBloodMirror			= mod:NewTargetNoFilterAnnounce(70451, 3, nil, "Healer|Tank")
local warnBloodSap				= mod:NewTargetNoFilterAnnounce(70432, 4, nil, "Healer|Tank")
local warnChainsofShadow		= mod:NewTargetNoFilterAnnounce(70645, 3, nil, false)
--Frostwing Hall
local warnConflag				= mod:NewTargetNoFilterAnnounce(71785, 4, nil, false)
local warnBanish				= mod:NewTargetNoFilterAnnounce(71298, 3, nil, false)

--Lower Spire
local specWarnDisruptingShout	= mod:NewSpecialWarningCast(71022)
local specWarnDarkReckoning		= mod:NewSpecialWarningMoveAway(69483)
local specWarnDeathPlague		= mod:NewSpecialWarningYou(72865)
local specWarnTrapL				= mod:NewSpecialWarning("SpecWarnTrapL")
--Plagueworks
local specWarnSeveredEssence	= mod:NewSpecialWarningMove(71942)
local specWarnDecimate			= mod:NewSpecialWarningSpell(71123)
local specWarnMortalWound		= mod:NewSpecialWarningStack(71127, "Tank|Healer", 6)
local specWarnTrapP				= mod:NewSpecialWarning("SpecWarnTrapP")
local specWarnBlightBomb		= mod:NewSpecialWarningSpell(71088)
--Frostwing Hall
local specWarnGosaEvent			= mod:NewSpecialWarning("SpecWarnGosaEvent")
local specWarnBlade				= mod:NewSpecialWarningMove(70305)

--Lower Spire
local timerDisruptingShout		= mod:NewCastTimer(3, 71022, nil, nil, nil, 2)
local timerDarkReckoning		= mod:NewTargetTimer(8, 69483, nil, nil, nil, 5)
local timerDeathPlague			= mod:NewTargetTimer(15, 72865, nil, nil, nil, 3)
--Plagueworks
local timerSeveredEssence		= mod:NewNextTimer(35.5, 71942, nil, nil, nil, 1--[[, nil, nil, true]]) -- REVIEW! 5s variance [35.5-40.5]. Removed "keep" arg, due to several edge cases where timer kept ticking to infinity. Until variance is implemented on DBT, this will never be accurate (25H Lordaeron [2023-08-19]@[11:49:20] || 25H Lordaeron [2023-08-27]@[10:41:16]) - 36.0 || 40.49; 35.51
local timerZombies				= mod:NewNextTimer(20, 71159, nil, nil, nil, 1)
local timerMortalWound			= mod:NewTargetTimer(15, 71127, nil, nil, nil, 5)
local timerDecimate				= mod:NewNextTimer(33, 71123, nil, nil, nil, 2)
local timerBlightBomb			= mod:NewCastTimer(5, 71088, nil, nil, nil, 3)
local timerProfessorEvent		= mod:NewRPTimer(90, 70475, nil, nil, nil, 2)
--Crimson Hall
local timerBloodMirror			= mod:NewTargetTimer(30, 70451, nil, "Healer|Tank", nil, 5)
local timerBloodSap				= mod:NewTargetTimer(8, 70432, nil, "Healer|Tank", nil, 5)
local timerChainsofShadow		= mod:NewTargetTimer(10, 70645, nil, false, nil, 3)
--Frostwing Hall
local timerConflag				= mod:NewTargetTimer(10, 71785, nil, false, nil, 3)
local timerBanish				= mod:NewTargetTimer(6, 71298, nil, false, nil, 3)
local timerFrostblade			= mod:NewNextTimer(26, 70305, nil, nil, nil, 2)

mod:RemoveOption("HealthFrame")
--Lower Spire
mod:AddSetIconOption("SetIconOnDarkReckoning", 69483, true, 0, {8})
mod:AddSetIconOption("SetIconOnDeathPlague", 72865, true, 7, {1, 2, 3, 4, 5, 6, 7, 8})
--Crimson Hall
mod:AddSetIconOption("BloodMirrorIcon", 70451, false, 0, {2})

local valkyrHeraldGUID = {}
local eventProfessorStarted = false
mod.vb.nerubarAlive = 16 -- 8 each wave
mod.vb.frostwardenAlive = 6

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 71022 then
		warnDisruptingShout:Show()
		specWarnDisruptingShout:Show()
		timerDisruptingShout:Start()
	elseif spellId == 71088 then
		specWarnBlightBomb:Show()
		timerBlightBomb:Start(args.sourceGUID)
	elseif spellId == 71123 then
		specWarnDecimate:Show()
		warnDecimateSoon:Cancel()	-- in case the first 1 is inaccurate, you wont have an invalid soon warning
		warnDecimateSoon:Schedule(28)
		timerDecimate:Start()
	elseif spellId == 71942 then
		local sourceGUID = args.sourceGUID
		valkyrHeraldGUID[sourceGUID] = true
		specWarnSeveredEssence:Show()
		timerSeveredEssence:Start(sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 69483 then
		warnDarkReckoning:Show(args.destName)
		timerDarkReckoning:Start(args.destName)
		if args:IsPlayer() then
			specWarnDarkReckoning:Show()
		end
		if self.Options.SetIconOnDarkReckoning then
			self:SetIcon(args.destName, 8, 8)
		end
	elseif spellId == 72865 then
		warnDeathPlague:CombinedShow(0.3, args.destName)
		timerDeathPlague:Start(args.destName)
		if args:IsPlayer() then
			specWarnDeathPlague:Show()
		end
		if self.Options.SetIconOnDeathPlague then
			self:SetSortedIcon("roster", 0.3, args.destName, 1, 8, false)
		end
	elseif spellId == 71127 then
		local amount = args.amount or 1
		timerMortalWound:Start(args.destName)
		if amount % 2 == 0 then
			warnMortalWound:Show(args.destName, amount)
			if args:IsPlayer() and amount > 5 then
				specWarnMortalWound:Show(amount)
			end
		end
	elseif spellId == 70451 and args:IsDestTypePlayer() then
		warnBloodMirror:CombinedShow(0.3, args.destName)
		timerBloodMirror:Start(args.destName)
		if self.Options.BloodMirrorIcon then
			self:SetSortedIcon("roster", 0.3, args.destName, 2, 2, true)
		end
	elseif spellId == 70432 then
		warnBloodSap:Show(args.destName)
		timerBloodSap:Start(args.destName)
	elseif spellId == 70645 and args:IsDestTypePlayer() then
		warnChainsofShadow:Show(args.destName)
		timerChainsofShadow:Start(args.destName)
	elseif spellId == 71785 then
		warnConflag:Show(args.destName)
		timerConflag:Start(args.destName)
	elseif spellId == 71298 then
		warnBanish:Show(args.destName)
		timerBanish:Start(args.destName)
	elseif spellId == 70475 and not eventProfessorStarted then -- Giant Insect Swarm
		eventProfessorStarted = true
		timerProfessorEvent:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 70451 then
		timerBloodMirror:Cancel(args.destName)
		self:SetIcon(args.destName, 0)
	elseif spellId == 70432 then
		timerBloodSap:Cancel(args.destName)
	elseif spellId == 70645 then
		timerChainsofShadow:Cancel(args.destName)
	elseif spellId == 71785 then
		timerConflag:Cancel(args.destName)
	elseif spellId == 71298 then
		timerBanish:Cancel(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 71159 and self:AntiSpam(5) then
		warnZombies:Show()
		timerZombies:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if spellId == 70305 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnBlade:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local destGUID = args.destGUID
	local cid = self:GetCIDFromGUID(destGUID)
	if cid == 37025 then
		warnDecimateSoon:Cancel()
		timerDecimate:Cancel()
	elseif cid == 37217 then
		timerZombies:Cancel()
		warnDecimateSoon:Cancel()
		timerDecimate:Cancel()
	elseif cid == 10404 then -- Pustulating Horror
		timerBlightBomb:Cancel(destGUID)
	elseif cid == 37098 then -- Val'kyr Herald
		self:SendSync("ValkyrDeaggro", destGUID) -- would work with just timer cancel method, but switched to sync too since valk table is heavily dependant on syncing, and CLEU has a history of breaking
	elseif (cid == 37501 or cid == 37502) and self.vb.nerubarAlive > 0 then -- 4 Nerub'ar Champion / 4 Nerub'ar Webweaver (first and third gauntlet wave)
		self.vb.nerubarAlive = self.vb.nerubarAlive - 1
		if self.vb.nerubarAlive == 8 then
			DBM:AddSpecialEventToTranscriptorLog("Sindra Gauntlet 2nd wave")
			self.vb.frostwardenAlive = 6
			timerFrostblade:Start() -- REVIEW! ~26s after last nerubar dies
		elseif self.vb.nerubarAlive == 0 then
			DBM:AddSpecialEventToTranscriptorLog("Sindra Gauntlet ended")
		end
	elseif (cid == 37228 or cid == 37229) and self.vb.frostwardenAlive > 0 then -- 4 Frostwarden Warrior / 2 Frostwarden Sorceress
		self.vb.frostwardenAlive = self.vb.frostwardenAlive - 1
		if self.vb.frostwardenAlive == 0 then
			DBM:AddSpecialEventToTranscriptorLog("Sindra Gauntlet 3rd wave")
		end
	end
end

do
	local UnitExists = UnitExists
	local valkGUID
	local uIdTarget
	local valkHasTarget
	function mod:UNIT_TARGET(uId)
		uIdTarget = uId.."target"
		local unitTargetIsValk = self:GetUnitCreatureId(uIdTarget) == 37098
		local unitIsValk =  self:GetUnitCreatureId(uId) == 37098
		if not unitIsValk and not unitTargetIsValk then return end -- Stop if unit is not Valk or if raid member did not target a Valk

		if unitTargetIsValk then -- Raid member fired this event
			valkGUID = UnitGUID(uIdTarget)
			valkHasTarget = UnitExists(uIdTarget.."target")

			if not valkHasTarget and valkyrHeraldGUID[valkGUID] then
				valkyrHeraldGUID[valkGUID] = nil -- Valk does not have a target -> hasn't aggroed anything or was reset
				self:SendSync("ValkyrDeaggro", valkGUID)
				DBM:Debug("Valkyr Herald \'" .. valkGUID .. "\' was reset")
			end
			if valkHasTarget and not valkyrHeraldGUID[valkGUID] then
				valkyrHeraldGUID[valkGUID] = true -- Valkyr already had a raid target at the time of this check, meaning it was aggroed before, so prevent it from sending an aggro sync since timer would be innacurate.
				DBM:Debug("Valkyr Herald \'" .. valkGUID .. "\' already had aggro!")
			end
			return -- rest of code does not need to run, so return here
		end

		if unitIsValk then -- Valk fired this event
			valkGUID = UnitGUID(uId)
			valkHasTarget = UnitExists(uIdTarget)
			if not valkHasTarget and valkyrHeraldGUID[valkGUID] then
				valkyrHeraldGUID[valkGUID] = nil -- Valk does not have a target -> hasn't aggroed anything or was reset
				self:SendSync("ValkyrDeaggro", valkGUID)
				DBM:Debug("Valkyr Herald \'" .. valkGUID .. "\' was reset")
			end
			if valkHasTarget and not valkyrHeraldGUID[valkGUID] then
				valkyrHeraldGUID[valkGUID] = true -- duplicated from the OnSync handler, to prevent this code from running twice, as well as to workaround antispam measures
				self:SendSync("ValkyrAggro", valkGUID)
			end
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.WarderTrap1 or msg == L.WarderTrap2 or msg == L.WarderTrap3) and self:LatencyCheck() then
		self:SendSync("WarderTrap")
	elseif (msg == L.FleshreaperTrap1 or msg == L.FleshreaperTrap2 or msg == L.FleshreaperTrap3) and self:LatencyCheck() then
		self:SendSync("FleshTrap")
	elseif msg == L.SindragosaEvent and self:LatencyCheck() then
		self:SendSync("GauntletStart")
	end
end

function mod:OnSync(msg, guid)
	if msg == "WarderTrap" then
		specWarnTrapL:Show()
	elseif msg == "FleshTrap" then
		specWarnTrapP:Show()
	elseif msg == "GauntletStart" then
		DBM:AddSpecialEventToTranscriptorLog("Sindra Gauntlet started")
		specWarnGosaEvent:Show()
		self.vb.nerubarAlive = 8
	elseif msg == "ValkyrAggro" and guid then
		valkyrHeraldGUID[guid] = true
		timerSeveredEssence:Start(8, guid) -- REVIEW! variance [8-10]? On Warmane, based on aggro, touchdown or swing?
	elseif msg == "ValkyrDeaggro" and guid then
		valkyrHeraldGUID[guid] = nil
		timerSeveredEssence:Cancel(guid)
	end
end
