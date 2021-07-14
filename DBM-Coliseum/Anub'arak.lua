local mod	= DBM:NewMod("Anub'arak_Coliseum", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4435 $"):sub(12, -3))
mod:SetCreatureID(34564)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

mod:SetUsedIcons(3, 4, 5, 6, 7, 8)


mod:AddBoolOption("RemoveHealthBuffsInP3", false)

-- Adds
local warnAdds				= mod:NewAnnounce("warnAdds", 3, 45419)
local timerAdds				= mod:NewTimer(45, "timerAdds", 45419, nil, nil, 1, DBM_CORE_TANK_ICON)

-- Pursue
local warnPursue			= mod:NewTargetAnnounce(67574, 4)
local specWarnPursue		= mod:NewSpecialWarning("SpecWarnPursue")
local warnHoP				= mod:NewTargetAnnounce(10278, 2)--Heroic strat revolves around kiting pursue and using Hand of Protection.
local timerHoP				= mod:NewBuffActiveTimer(10, 10278, nil, nil, nil, 3)--So we will track bops to make this easier.
mod:AddBoolOption("PlaySoundOnPursue")
mod:AddBoolOption("PursueIcon")

-- Emerge
local warnEmerge			= mod:NewAnnounce("WarnEmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnEmergeSoon		= mod:NewAnnounce("WarnEmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerEmerge			= mod:NewTimer(62, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6, DBM_CORE_IMPORTANT_ICON, nil, 1)

-- Submerge
local warnSubmerge			= mod:NewAnnounce("WarnSubmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnSubmergeSoon		= mod:NewAnnounce("WarnSubmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local specWarnSubmergeSoon	= mod:NewSpecialWarning("specWarnSubmergeSoon", mod:IsTank())
local timerSubmerge			= mod:NewTimer(75, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6, DBM_CORE_IMPORTANT_ICON, nil, 1)

-- Phases
local warnPhase3			= mod:NewPhaseAnnounce(3)
local enrageTimer			= mod:NewBerserkTimer(570)
local Burrowed				= false

-- Penetrating Cold
local specWarnPCold			= mod:NewSpecialWarningYou(68510, false)
local timerPCold			= mod:NewBuffActiveTimer(15, 68509, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconsOnPCold", 68510, true, true, {7, 6, 5, 4, 3})
mod:AddBoolOption("AnnouncePColdIcons", false)
mod:AddBoolOption("AnnouncePColdIconsRemoved", false)

-- Freezing Slash
local warnFreezingSlash		= mod:NewTargetAnnounce(66012, 2, nil, mod:IsHealer() or mod:IsTank())
local timerFreezingSlash	= mod:NewCDTimer(20, 66012, nil, mod:IsHealer() or mod:IsTank(), nil, nil, nil, DBM_CORE_TANK_ICON..DBM_CORE_HEALER_ICON)

-- Shadow Strike
local timerShadowStrike		= mod:NewNextTimer(30.0, 66134, nil, true, nil, 4, nil, DBM_CORE_MYTHIC_ICON, nil, 3)
local preWarnShadowStrike	= mod:NewSoonAnnounce(66134, 3)
local warnShadowStrike		= mod:NewSpellAnnounce(66134, 4)
local specWarnShadowStrike	= mod:NewSpecialWarning("SpecWarnShadowStrike", mod:IsTank())

function mod:OnCombatStart(delay)
	Burrowed = false
	timerAdds:Start(10-delay)
	warnAdds:Schedule(10-delay)
	self:ScheduleMethod(10-delay, "Adds")
	warnSubmergeSoon:Schedule(70-delay)
	specWarnSubmergeSoon:Schedule(70-delay)
	timerSubmerge:Start(80-delay)
	enrageTimer:Start(-delay)
	timerFreezingSlash:Start(-delay)
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
		timerShadowStrike:Start()
		preWarnShadowStrike:Schedule(25.5-delay)
		self:ScheduleMethod(30-delay, "ShadowStrike")
	end
	self:SetStage(1)
end

function mod:Adds()
	if self:IsInCombat() then
		if not Burrowed then
			timerAdds:Start()
			warnAdds:Schedule(45)
			self:ScheduleMethod(45, "Adds")
		end
	end
end

function mod:ShadowStrike(offset)
	offset = offset or 0
	if self:IsInCombat() then
		timerShadowStrike:Cancel()
		timerShadowStrike:Start(30.0-offset)
		preWarnShadowStrike:Cancel()
		preWarnShadowStrike:Schedule(25.5-offset)
		self:UnscheduleMethod("ShadowStrike")
		self:ScheduleMethod(30.0-offset, "ShadowStrike")
	end
end

function mod:ShadowStrikeReset(time)
	if not time then return end
	if not self:IsDifficulty("heroic10", "heroic25") then return end
	if self:IsInCombat() then
		timerShadowStrike:Cancel()
		timerShadowStrike:Start(time)
		if (time - 5) > 0 then
			preWarnShadowStrike:Cancel()
			preWarnShadowStrike:Schedule(time-5)
		end
		self:UnscheduleMethod("ShadowStrike")
		self:ScheduleMethod(time, "ShadowStrike")
	end
end

local PColdTargets = {}
do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(UnitName(v1)) < DBM:GetRaidSubgroup(UnitName(v2))
	end
	function mod:SetPcoldIcons()
		if DBM:GetRaidRank() > 0 then
			table.sort(PColdTargets, sort_by_group)
			local PColdIcon = 7
			for i, v in ipairs(PColdTargets) do
				if self.Options.AnnouncePColdIcons then
					SendChatMessage(L.PcoldIconSet:format(PColdIcon, UnitName(v)), "RAID")
				end
				self:SetIcon(UnitName(v), PColdIcon)
				PColdIcon = PColdIcon - 1
			end
			table.wipe(PColdTargets)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67574) then			-- Pursue
		if args:IsPlayer() then
			specWarnPursue:Show()
			if self.Options.PlaySoundOnPursue then
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
		if self.Options.PursueIcon then
			self:SetIcon(args.destName, 8, 15)
		end
		warnPursue:Show(args.destName)
	elseif args:IsSpellID(66013, 67700, 68509, 68510) then		-- Penetrating Cold
		if args:IsPlayer() then
			specWarnPCold:Show()
		end
		if self.Options.SetIconsOnPCold then
			table.insert(PColdTargets, DBM:GetRaidUnitId(args.destName))
			self:UnscheduleMethod("SetPcoldIcons")
			self:ScheduleMethod(0.2, "SetPcoldIcons")
		end
		timerPCold:Show()
	elseif args:IsSpellID(66012) then							-- Freezing Slash
		warnFreezingSlash:Show(args.destName)
		timerFreezingSlash:Start()
	elseif args:IsSpellID(10278) and self:IsInCombat() then		-- Hand of Protection
		warnHoP:Show(args.destName)
		timerHoP:Start(args.destName)
	end
end

mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(66013, 67700, 68509, 68510) then			-- Penetrating Cold
		mod:SetIcon(args.destName, 0)
		if (self.Options.AnnouncePColdIcons and self.Options.AnnouncePColdIconsRemoved) and DBM:GetRaidRank() >= 1 then
			SendChatMessage(L.PcoldIconRemoved:format(args.destName), "RAID")
		end
	elseif args:IsSpellID(10278) and self:IsInCombat() then		-- Hand of Protection
		timerHoP:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66118, 67630, 68646, 68647) then			-- Swarm (start p3)
		warnPhase3:Show()
		self:SetStage(3)
		warnEmergeSoon:Cancel()
		warnSubmergeSoon:Cancel()
		specWarnSubmergeSoon:Cancel()
		timerEmerge:Stop()
		timerSubmerge:Stop()
		local left = timerShadowStrike:GetRemaining()
		self:ShadowStrikeReset(left+1.5)
		if self.Options.RemoveHealthBuffsInP3 then
			mod:ScheduleMethod(0.1, "RemoveBuffs")
		end
		if mod:IsDifficulty("normal10") or mod:IsDifficulty("normal25") then
			timerAdds:Cancel()
			warnAdds:Cancel()
			self:UnscheduleMethod("Adds")
		end
	elseif args:IsSpellID(66134) and self:AntiSpam(2,66134) then
		self:ShadowStrike()
		specWarnShadowStrike:Show()
		warnShadowStrike:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg and msg:find(L.Burrow) then
		Burrowed = true
		self:SetStage(2)
		timerAdds:Cancel()
		warnAdds:Cancel()
		warnSubmerge:Show()
		warnEmergeSoon:Schedule(55)
		timerEmerge:Start()
		timerFreezingSlash:Stop()
		timerShadowStrike:Stop()
		preWarnShadowStrike:Cancel()
		self:UnscheduleMethod("ShadowStrike")
	elseif msg and msg:find(L.Emerge) then
		Burrowed = false
		self:SetStage(1)
		timerEmerge:Cancel()
		timerAdds:Start(5)
		warnAdds:Schedule(5)
		self:ScheduleMethod(5, "Adds")
		warnEmerge:Show()
		warnSubmergeSoon:Schedule(65)
		specWarnSubmergeSoon:Schedule(65)
		timerSubmerge:Start()
		if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
			timerShadowStrike:Stop()
			preWarnShadowStrike:Cancel()
			self:UnscheduleMethod("ShadowStrike")
			self:ScheduleMethod(5.0, "ShadowStrike")
		end
	end
end

function mod:RemoveBuffs()
	CancelUnitBuff("player", (GetSpellInfo(47440)))		-- Commanding Shout (Rank 3)
	CancelUnitBuff("player", (GetSpellInfo(47439)))		-- Commanding Shout (Rank 2)
	CancelUnitBuff("player", (GetSpellInfo(45517)))		-- Commanding Shout (Rank 1)
	CancelUnitBuff("player", (GetSpellInfo(469)))		-- Commanding Shout (Rank 1)
	CancelUnitBuff("player", (GetSpellInfo(48161)))		-- Power Word: Fortitude (Rank 8)
	CancelUnitBuff("player", (GetSpellInfo(25389)))		-- Power Word: Fortitude (Rank 7)
	CancelUnitBuff("player", (GetSpellInfo(10938)))		-- Power Word: Fortitude (Rank 6)
	CancelUnitBuff("player", (GetSpellInfo(10937)))		-- Power Word: Fortitude (Rank 5)
	CancelUnitBuff("player", (GetSpellInfo(2791)))		-- Power Word: Fortitude (Rank 4)
	CancelUnitBuff("player", (GetSpellInfo(1245)))		-- Power Word: Fortitude (Rank 3)
	CancelUnitBuff("player", (GetSpellInfo(1244)))		-- Power Word: Fortitude (Rank 2)
	CancelUnitBuff("player", (GetSpellInfo(1243)))		-- Power Word: Fortitude (Rank 1)
	CancelUnitBuff("player", (GetSpellInfo(48162)))		-- Prayer of Fortitude (Rank 4)
	CancelUnitBuff("player", (GetSpellInfo(25392)))		-- Prayer of Fortitude (Rank 3)
	CancelUnitBuff("player", (GetSpellInfo(21564)))		-- Prayer of Fortitude (Rank 2)
	CancelUnitBuff("player", (GetSpellInfo(21562)))		-- Prayer of Fortitude (Rank 1)
	CancelUnitBuff("player", (GetSpellInfo(72590)))		-- Runescroll of Fortitude
end

