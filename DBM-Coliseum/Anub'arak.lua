local mod	= DBM:NewMod("Anub'arak_Coliseum", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4435 $"):sub(12, -3))
mod:SetCreatureID(34564)
mod:SetUsedIcons(3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnAdds				= mod:NewAnnounce("warnAdds", 3, 45419)
local preWarnShadowStrike	= mod:NewSoonAnnounce(66134, 3)
local warnShadowStrike		= mod:NewSpellAnnounce(66134, 4)
local warnPursue			= mod:NewTargetAnnounce(67574, 4)
local warnFreezingSlash		= mod:NewTargetAnnounce(66012, 2, nil, "Tank|Healer")
local warnHoP				= mod:NewTargetAnnounce(10278, 2, nil, false) --Heroic strat revolves around kiting pursue and using Hand of Protection.
local warnEmerge			= mod:NewAnnounce("WarnEmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnEmergeSoon		= mod:NewAnnounce("WarnEmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnSubmerge			= mod:NewAnnounce("WarnSubmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnSubmergeSoon		= mod:NewAnnounce("WarnSubmergeSoon", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnPhase3			= mod:NewPhaseAnnounce(3)

local specWarnPursue		= mod:NewSpecialWarningRun(67574, nil, nil, 2, 4, 2)
local specWarnShadowStrike	= mod:NewSpecialWarningSpell(66134, "Tank", nil, 2, 1) --Don't have a good voice for this. Need a "stun mob now"
local specWarnPCold			= mod:NewSpecialWarningYou(66013, false, nil, nil, 1, 2)

local timerAdds				= mod:NewTimer(45, "timerAdds", 45419, nil, nil, 1, DBM_CORE_L.TANK_ICON)
local timerSubmerge			= mod:NewTimer(75, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6, DBM_CORE_L.IMPORTANT_ICON, nil, 1)
local timerEmerge			= mod:NewTimer(65, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6, DBM_CORE_L.IMPORTANT_ICON, nil, 1)
local timerFreezingSlash	= mod:NewCDTimer(20, 66012, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerPCold			= mod:NewBuffActiveTimer(15, 68509, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)
local timerShadowStrike		= mod:NewNextTimer(30.5, 66134, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON, nil, 3)
local timerHoP				= mod:NewBuffActiveTimer(10, 10278, nil, nil, nil, 5) --So we will track bops to make this easier.

local enrageTimer			= mod:NewBerserkTimer(570)

mod:AddSetIconOption("PursueIcon", 67574, true)
mod:AddSetIconOption("SetIconsOnPCold", 66013, false)
mod:AddBoolOption("AnnouncePColdIcons", false)
mod:AddBoolOption("AnnouncePColdIconsRemoved", false)
mod:AddBoolOption("RemoveHealthBuffsInP3", false)

local PColdTargets = {}
mod.vb.Burrowed = false

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.Burrowed = false
	timerAdds:Start(10-delay)
	warnAdds:Schedule(10-delay)
	self:ScheduleMethod(10-delay, "Adds")
	warnSubmergeSoon:Schedule(70-delay)
	timerSubmerge:Start(80-delay)
	enrageTimer:Start(-delay)
	timerFreezingSlash:Start(-delay)
	table.wipe(PColdTargets)
	if self:IsHeroic() then
		timerShadowStrike:Start()
		preWarnShadowStrike:Schedule(25.5-delay)
		self:ScheduleMethod(30.5-delay, "ShadowStrike")
	end
end

function mod:Adds()
	if self:IsInCombat() then
		if not self.vb.Burrowed then
			timerAdds:Start()
			warnAdds:Schedule(45)
			self:ScheduleMethod(45, "Adds")
		end
	end
end

function mod:ShadowStrike()
	self:UnscheduleMethod("ShadowStrike")
	if self:IsInCombat() then
		timerShadowStrike:Cancel()
		timerShadowStrike:Start()
		preWarnShadowStrike:Cancel()
		preWarnShadowStrike:Schedule(25.5)
		self:ScheduleMethod(30.5, "ShadowStrike")
	end
end

-- Warmane workaround, since emerge boss emote is not being fired
function mod:EmergeFix()
	self:SetStage(1)
	self.vb.Burrowed = false
	timerEmerge:Cancel()
	timerAdds:Start(5)
	warnAdds:Schedule(5)
	self:ScheduleMethod(5, "Adds")
	warnEmerge:Show()
	warnSubmergeSoon:Schedule(65)
	timerSubmerge:Start()
	if self:IsHeroic() then
		timerShadowStrike:Stop()
		preWarnShadowStrike:Cancel()
		self:UnscheduleMethod("ShadowStrike")
		self:ScheduleMethod(5.0, "ShadowStrike")
	end
end

local function ClearPcoldTargets()
	table.wipe(PColdTargets)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetPcoldIcons()
		table.sort(PColdTargets, sort_by_group)
		local PColdIcon = 7
		for i, v in ipairs(PColdTargets) do
			if self.Options.AnnouncePColdIcons and DBM:GetRaidRank() > 1 then
				SendChatMessage(L.PcoldIconSet:format(PColdIcon, DBM:GetUnitFullName(v)), "RAID")
			end
			self:SetIcon(v, PColdIcon)
			PColdIcon = PColdIcon - 1
		end
		self:Schedule(5, ClearPcoldTargets)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 67574 then			-- Pursue
		if args:IsPlayer() then
			specWarnPursue:Show()
			specWarnPursue:Play("justrun")
			specWarnPursue:ScheduleVoice(1.5, "keepmove")
		else
			warnPursue:Show(args.destName)
		end
		if self.Options.PursueIcon then
			self:SetIcon(args.destName, 8, 15)
		end
	elseif args:IsSpellID(66013, 67700, 68509, 68510) then		-- Penetrating Cold
		timerPCold:Show()
		if args:IsPlayer() then
			specWarnPCold:Show()
			specWarnPCold:Play("targetyou")
		end
		if self.Options.SetIconsOnPCold then
			table.insert(PColdTargets, DBM:GetRaidUnitId(args.destName))
			self:UnscheduleMethod("SetPcoldIcons")
			if (self:IsDifficulty("normal25", "heroic25") and #PColdTargets >= 5) or (self:IsDifficulty("normal10", "heroic10") and #PColdTargets >= 2) then
				self:SetPcoldIcons()
			else
				if self:LatencyCheck() then
					self:ScheduleMethod(0.5, "SetPcoldIcons")
				end
			end
		end
	elseif args.spellId == 66012 then							-- Freezing Slash
		warnFreezingSlash:Show(args.destName)
		timerFreezingSlash:Start()
	elseif args.spellId == 10278 and self:IsInCombat() then		-- Hand of Protection
		warnHoP:Show(args.destName)
		timerHoP:Start(args.destName)
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(66013, 67700, 68509, 68510) then			-- Penetrating Cold
		if self.Options.SetIconsOnPCold then
			self:SetIcon(args.destName, 0)
			if self.Options.AnnouncePColdIconsRemoved and DBM:GetRaidRank() > 0 then
				SendChatMessage(L.PcoldIconRemoved:format(args.destName), "RAID")
			end
		end
	elseif args.spellId == 10278 and self:IsInCombat() then		-- Hand of Protection
		timerHoP:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66118, 67630, 68646, 68647) then			-- Swarm (start p3)
		self:SetStage(3)
		warnPhase3:Show()
		warnEmergeSoon:Cancel()
		warnSubmergeSoon:Cancel()
		timerEmerge:Stop()
		timerSubmerge:Stop()
		if self:IsNormal() then
			timerAdds:Cancel()
			warnAdds:Cancel()
			self:UnscheduleMethod("Adds")
		end
		if self.Options.RemoveHealthBuffsInP3 then
			mod:ScheduleMethod(0.1, "RemoveBuffs")
		end
	elseif args.spellId == 66134 and self:AntiSpam(2, 1) then	-- Shadow Strike
		self:UnscheduleMethod("ShadowStrike")
		self:ShadowStrike()
		if self.Options.SpecWarn66134spell then
			specWarnShadowStrike:Show()
		else
			warnShadowStrike:Show()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg and msg:find(L.Burrow) then
		self:SetStage(2)
		self.vb.Burrowed = true
		timerAdds:Cancel()
		warnAdds:Cancel()
		warnSubmerge:Show()
		warnEmergeSoon:Schedule(55)
		timerEmerge:Start()
		timerFreezingSlash:Stop()
		self:ScheduleMethod(65, "EmergeFix")	-- Warmane workaround, since emerge boss emote is not being fired
	elseif msg and msg:find(L.Emerge) then
		self:UnscheduleMethod("EmergeFix")		-- Warmane workaround: failsafe if script gets fixed eventually
		self:SetStage(1)
		self.vb.Burrowed = false
		timerAdds:Start(5)
		warnAdds:Schedule(5)
		self:ScheduleMethod(5, "Adds")
		warnEmerge:Show()
		warnSubmergeSoon:Schedule(65)
		timerSubmerge:Start()
		if self:IsHeroic() then
			timerShadowStrike:Stop()
			preWarnShadowStrike:Cancel()
			self:UnscheduleMethod("ShadowStrike")
			self:ScheduleMethod(5.5, "ShadowStrike")
		end
	end
end

function mod:RemoveBuffs() -- Remove HP buffs for p3
	CancelUnitBuff("player", (GetSpellInfo(47440)))		-- Commanding Shout
	CancelUnitBuff("player", (GetSpellInfo(48161)))		-- Power Word: Fortitude
	CancelUnitBuff("player", (GetSpellInfo(48162)))		-- Prayer of Fortitude
	CancelUnitBuff("player", (GetSpellInfo(72590)))		-- Runescroll of Fortitude
end