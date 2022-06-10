local mod	= DBM:NewMod("Anub'arak_Coliseum", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetMinSyncRevision(7007)
mod:SetCreatureID(34564)
mod:SetUsedIcons(1, 2, 3, 4, 5, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 67574 66013 67700 68509 68510 66012 10278",
	"SPELL_AURA_REFRESH 67574 66013 67700 68509 68510 66012",
	"SPELL_AURA_REMOVED 66013 67700 68509 68510 10278",
	"SPELL_CAST_START 66118 67630 68646 68647 66134",
	"SPELL_CAST_SUCCESS 66012",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnAdds				= mod:NewAnnounce("warnAdds", 3, 45419)
local preWarnShadowStrike	= mod:NewSoonAnnounce(66134, 3)
local warnShadowStrike		= mod:NewSpellAnnounce(66134, 4)
local warnPursue			= mod:NewTargetNoFilterAnnounce(67574, 4)
local warnFreezingSlash		= mod:NewTargetNoFilterAnnounce(66012, 2, nil, "Tank|Healer")
local warnHoP				= mod:NewTargetNoFilterAnnounce(10278, 2, nil, false) --Heroic strat revolves around kiting pursue and using Hand of Protection.
local warnEmerge			= mod:NewAnnounce("WarnEmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnEmergeSoon		= mod:NewAnnounce("WarnEmergeSoon", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnSubmerge			= mod:NewAnnounce("WarnSubmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnSubmergeSoon		= mod:NewAnnounce("WarnSubmergeSoon", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnPhase3			= mod:NewPhaseAnnounce(3)

local specWarnPursue		= mod:NewSpecialWarningRun(67574, nil, nil, 2, 4, 2)
local specWarnShadowStrike	= mod:NewSpecialWarningSpell(66134, "Tank", nil, 2, 1) --Don't have a good voice for this. Need a "stun mob now"
local specWarnPCold			= mod:NewSpecialWarningYou(66013, false, nil, nil, 1, 2)

local timerAdds				= mod:NewTimer(45, "timerAdds", 45419, nil, nil, 1, DBM_COMMON_L.TANK_ICON)
local timerSubmerge			= mod:NewTimer(80, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6, DBM_COMMON_L.IMPORTANT_ICON, nil, 1)
local timerEmerge			= mod:NewTimer(65, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6, DBM_COMMON_L.IMPORTANT_ICON, nil, 1)
local timerFreezingSlash	= mod:NewCDTimer(20, 66012, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerPCold			= mod:NewBuffActiveTimer(15, 68509, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerShadowStrike		= mod:NewNextTimer(30, 66134, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON, nil, 3)
local timerHoP				= mod:NewBuffActiveTimer(10, 10278, nil, nil, nil, 5) --So we will track bops to make this easier.

local enrageTimer			= mod:NewBerserkTimer(570)

mod:AddSetIconOption("PursueIcon", 67574, true, 0, {8})
mod:AddSetIconOption("SetIconsOnPCold", 66013, true, 7, {1, 2, 3, 4, 5})
mod:AddBoolOption("AnnouncePColdIcons", false)
mod:AddBoolOption("AnnouncePColdIconsRemoved", false)
mod:AddBoolOption("RemoveHealthBuffsInP3", false)

mod.vb.Burrowed = false

local function Adds(self)
	if self:IsInCombat() then
		if not self.vb.Burrowed then
			timerAdds:Start()
			warnAdds:Schedule(45)
			self:Schedule(45, Adds, self)
		end
	end
end

local function ShadowStrike(self)
	self:Unschedule(ShadowStrike)
	if self:IsInCombat() then
		timerShadowStrike:Cancel()
		timerShadowStrike:Start()
		preWarnShadowStrike:Cancel()
		preWarnShadowStrike:Schedule(25.5)
		self:Schedule(30, ShadowStrike, self)
	end
end

-- Warmane workaround, since emerge boss emote is not being fired
local function EmergeFix(self)
	self:SetStage(1)
	self.vb.Burrowed = false
	timerEmerge:Cancel()
	timerAdds:Start(5)
	warnAdds:Schedule(5)
	self:Schedule(5, Adds, self)
	warnEmerge:Show()
	warnSubmergeSoon:Schedule(70)
	timerSubmerge:Start()
	if self:IsHeroic() then
		ShadowStrike(self)
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.Burrowed = false
	timerAdds:Start(10-delay)
	warnAdds:Schedule(10-delay)
	self:Schedule(10-delay, Adds, self)
	warnSubmergeSoon:Schedule(70-delay)
	timerSubmerge:Start(-delay)
	enrageTimer:Start(-delay)
	timerFreezingSlash:Start(15-delay)
	if self:IsHeroic() then
		timerShadowStrike:Start()
		preWarnShadowStrike:Schedule(25.5-delay)
		self:Schedule(30-delay, ShadowStrike, self)
	end
end

function mod:AnnouncePcoldIcons(uId, icon)
	if self.Options.AnnouncePColdIcons and IsInGroup() and DBM:GetRaidRank() > 1 then
		SendChatMessage(L.PcoldIconSet:format(icon, DBM:GetUnitFullName(uId)), IsInRaid() and "RAID" or "PARTY")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 67574 then			-- Pursue
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
			local maxIcon = self:IsDifficulty("normal25", "heroic25") and 5 or 2
			self:SetSortedIcon("roster", 1, args.destName, 1, maxIcon, false, "AnnouncePcoldIcons")
		end
	elseif spellId == 66012 then							-- Freezing Slash
		warnFreezingSlash:Show(args.destName)
	elseif spellId == 10278 and self:IsInCombat() then		-- Hand of Protection
		warnHoP:Show(args.destName)
		timerHoP:Start(args.destName)
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(66013, 67700, 68509, 68510) then			-- Penetrating Cold
		if self.Options.SetIconsOnPCold then
			self:SetIcon(args.destName, 0)
			if self.Options.AnnouncePColdIconsRemoved and DBM:GetRaidRank() > 1 then
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
			self:Unschedule(Adds)
		end
		if self.Options.RemoveHealthBuffsInP3 then
			mod:ScheduleMethod(0.1, "RemoveBuffs")
		end
	elseif args.spellId == 66134 and self:IsHeroic() and self:AntiSpam(2, 1) then	-- Shadow Strike
		self:Unschedule(ShadowStrike)
		ShadowStrike(self)
		if self.Options.SpecWarn66134spell then
			specWarnShadowStrike:Show()
		else
			warnShadowStrike:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 66012 then							-- Freezing Slash (caught one log where AURA_APPLIED was not present in one of the casts, so start timer on cast success instead)
		timerFreezingSlash:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg) -- Warmane workaround since submerge emote sometimes is not being fired
	if msg and msg == L.YellBurrow then
		self:SetStage(2)
		self.vb.Burrowed = true
		timerAdds:Cancel()
		warnAdds:Cancel()
		warnSubmerge:Show()
		warnEmergeSoon:Schedule(58.5)
		timerEmerge:Start()
		timerFreezingSlash:Stop()
		if self:IsHeroic() then
			self:Unschedule(ShadowStrike)
			timerShadowStrike:Cancel()
			preWarnShadowStrike:Cancel()
		end
		self:Schedule(65, EmergeFix, self)	-- Warmane workaround, since emerge boss emote is not being fired
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	-- if msg and msg:find(L.Burrow) then
	-- 	self:SetStage(2)
	-- 	self.vb.Burrowed = true
	-- 	timerAdds:Cancel()
	-- 	warnAdds:Cancel()
	-- 	warnSubmerge:Show()
	-- 	warnEmergeSoon:Schedule(58.5)
	-- 	timerEmerge:Start()
	-- 	timerFreezingSlash:Stop()
	-- 	self:Schedule(65, EmergeFix, self)	-- Warmane workaround, since emerge boss emote is not being fired
	if msg and msg:find(L.Emerge) then
		self:Unschedule(EmergeFix)		-- Warmane workaround: failsafe if script gets fixed eventually
		self:SetStage(1)
		self.vb.Burrowed = false
		timerEmerge:Cancel()
		timerAdds:Start(5)
		warnAdds:Schedule(5)
		self:Schedule(5, Adds, self)
		warnEmerge:Show()
		warnSubmergeSoon:Schedule(70)
		timerSubmerge:Start()
		if self:IsHeroic() then
			ShadowStrike(self)
		end
	end
end

function mod:RemoveBuffs() -- Remove HP buffs for p3
	CancelUnitBuff("player", (GetSpellInfo(47440)))		-- Commanding Shout
	CancelUnitBuff("player", (GetSpellInfo(48161)))		-- Power Word: Fortitude
	CancelUnitBuff("player", (GetSpellInfo(48162)))		-- Prayer of Fortitude
	CancelUnitBuff("player", (GetSpellInfo(72590)))		-- Runescroll of Fortitude
end