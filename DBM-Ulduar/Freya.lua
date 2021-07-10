local mod	= DBM:NewMod("Freya", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4133 $"):sub(12, -3))

mod:SetCreatureID(32906)
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)
mod:SetUsedIcons(6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_SUMMON"
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
local warnRoots				= mod:NewTargetAnnounce(62438, 2)

local specWarnFury			= mod:NewSpecialWarningYou(63571)
local specWarnTremor		= mod:NewSpecialWarningCast(62859)	-- Hard mode
local specWarnUnstableBeam	= mod:NewSpecialWarningMove(62865)	-- Hard mode
local specWarnUnstableBeamSoon	= mod:NewSpecialWarning("WarningBeamsSoon", 3) -- Hard mode Sun Beam
local specWarnEonarsGift    = mod:NewSpecialWarning("EonarsGift", 3)

local enrage 				= mod:NewBerserkTimer(480)
local timerAlliesOfNature	= mod:NewNextTimer(60, 62678)
local timerSimulKill		= mod:NewTimer(12, "TimerSimulKill")
local timerFury				= mod:NewTargetTimer(10, 63571)
local timerTremorCD 		= mod:NewCDTimer(26, 62859)
local timerEonarsGiftCD     = mod:NewCDTimer(40, 62584)
local timerRootsCD      	= mod:NewCDTimer(14, 62439)
local timerUnstableBeamCD	= mod:NewCDTimer(15, 62451) -- Hard mode Sun Beam


local specBombs			= mod:NewSpecialWarningMove(64587)
local timerNextBombs	= mod:NewNextTimer(11, 64587)
local soundBombs3		= mod:NewSound3(64587)

mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("PlaySoundOnFury")
mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("WarnBeamsSoon", true)

local adds		= {}
local rootedPlayers 	= {}
local altIcon 		= true
local killTime		= 0
local iconId		= 6
local waves = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	enrage:Start()
	table.wipe(adds)
	timerEonarsGiftCD:Start(25)
end

function mod:OnCombatEnd(wipe)
	DBM.BossHealth:Hide()
	timerNextBombs:Cancel()
	specBombs:Cancel()
	if not wipe then
		if DBM.Bars:GetBar(L.TrashRespawnTimer) then
			DBM.Bars:CancelBar(L.TrashRespawnTimer)
		end
	end
end

local function showRootWarning()
	warnRoots:Show(table.concat(rootedPlayers, "< >"))
	table.wipe(rootedPlayers)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62437, 62859) then
		specWarnTremor:Show()
		timerTremorCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(62678, 62673) then -- Summon Allies of Nature
		waves = waves + 1
		if waves < 6 then
			timerAlliesOfNature:Start()
		end
	elseif args:IsSpellID(63571, 62589) then -- Nature's Fury
		altIcon = not altIcon	--Alternates between Skull and X
		self:SetIcon(args.destName, altIcon and 7 or 8, 10)
		warnFury:Show(args.destName)
		if args:IsPlayer() then -- only cast on players; no need to check destFlags
			if self.Options.PlaySoundOnFury then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
			specWarnFury:Show()
			SendChatMessage("Nature's Fury on me!", "RAID")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
		timerFury:Start(args.destName)
	elseif args.spellId == 64650 then
		if self:AntiSpam(1,64650) and self:IsInCombat() then
			timerNextBombs:Start(9.95)
			soundBombs3:Cancel()
			specBombs:Cancel()
			soundBombs3:Schedule(10.5-3)
			specBombs:Schedule(9.95)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62283, 62438, 62439, 62861, 62862, 62930) then --  Roots
		timerRootsCD:Start()
		iconId = iconId - 1
		self:SetIcon(args.destName, iconId, 15)
		table.insert(rootedPlayers, args.destName)
		self:Unschedule(showRootWarning)
		if #rootedPlayers >= 3 then
			showRootWarning()
		else
			self:Schedule(0.5, showRootWarning)
		end
	elseif args:IsSpellID(62451, 62865) then
		if GetTime() - (self.vb.lastBeam or 0) > 10 then
			self.vb.lastBeam = GetTime()
			timerUnstableBeamCD:Start()
			if (self.Options.WarnBeamsSoon) then
				specWarnUnstableBeamSoon:Schedule(12)
			end
		end
		if args:IsPlayer() then
			specWarnUnstableBeam:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
    if args.spellId == 62519 then
		warnPhase2:Show()
		self:SetStage(2)
    elseif args:IsSpellID(62861, 62438) then
        self:RemoveIcon(args.destName)
        iconId = iconId + 1
    elseif args:IsSpellID(63571, 62589) then
		self:RemoveIcon(args.destName)
		if args:IsPlayer() and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
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

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 33202 or cid == 32916 or cid == 32919 then
		if self.Options.HealthFrame then
			DBM.BossHealth:RemoveBoss(cid)
		end
		if (GetTime() - killTime) > 20 then
			killTime = GetTime()
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

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, mob)
	-- localize this
	if strmatch(msg, L.EmoteLGift) then
		specWarnEonarsGift:Show()
		timerEonarsGiftCD:Start()
	end
end
