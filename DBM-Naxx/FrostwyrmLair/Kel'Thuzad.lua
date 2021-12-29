local mod	= DBM:NewMod("Kel'Thuzad", "DBM-Naxx", 5)
local L		= mod:GetLocalizedStrings()

local tContains = tContains
local PickupInventoryItem, PutItemInBackpack, UseEquipmentSet, CancelUnitBuff = PickupInventoryItem, PutItemInBackpack, UseEquipmentSet, CancelUnitBuff

mod:SetRevision(("$Revision: 4911 $"):sub(12, -3))
mod:SetCreatureID(15990)
mod:SetModelID("creature/lich/lich.m2")
mod:SetMinCombatTime(60)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

--mod:RegisterCombat("combat_yell", L.Yell)
mod:RegisterCombat("yell", L.Yell)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 27808 27819 28410",
	"SPELL_AURA_REMOVED 28410",
	"SPELL_CAST_SUCCESS 27810 27819 27808 28410",
	"UNIT_HEALTH boss1"
)

local warnAddsSoon			= mod:NewAnnounce("warnAddsSoon", 1, "Interface\\Icons\\INV_Misc_MonsterSpiderCarapace_01")
local warnPhase2			= mod:NewPhaseAnnounce(2, 3)
local warnBlastTargets		= mod:NewTargetAnnounce(27808, 2)
local warnFissure			= mod:NewSpellAnnounce(27810, 4, nil, nil, nil, nil, nil, 2)
local warnMana				= mod:NewTargetAnnounce(27819, 2)
local warnChainsTargets		= mod:NewTargetNoFilterAnnounce(28410, 4)
local warnMindControlSoon 	= mod:NewSoonAnnounce(28410, 4)

local specwarnP2Soon		= mod:NewSpecialWarning("specwarnP2Soon")
local specWarnManaBomb		= mod:NewSpecialWarningMoveAway(27819, nil, nil, nil, 1, 2)
local specWarnManaBombNear	= mod:NewSpecialWarningClose(27819, nil, nil, nil, 1, 2)
local specWarnBlast			= mod:NewSpecialWarningTarget(27808, "Healer", nil, nil, 1, 2)
local yellManaBomb			= mod:NewShortYell(27819)

local blastTimer			= mod:NewBuffActiveTimer(4, 27808, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)
local timerManaBomb			= mod:NewCDTimer(20, 27819, nil, nil, nil, 3)--20-50
local timerFissureCD  		= mod:NewCDTimer(14, 27810)
local timerFrostBlast		= mod:NewCDTimer(30, 27808, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)--40-46 (retail 40.1)
local timerMC				= mod:NewBuffActiveTimer(20, 28410, nil, nil, nil, 3)
local timerMCCD				= mod:NewCDTimer(90, 28410, nil, nil, nil, 3)--actually 60 second cdish but its easier to do it this way for the first one.
local timerPhase2			= mod:NewTimer(227, "TimerPhase2", nil, nil, nil, 6)

mod:AddSetIconOption("SetIconOnMC", 28410, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnManaBomb", 27819, false, false, {8})
mod:AddSetIconOption("SetIconOnFrostTomb", 28169, true, false, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddRangeFrameOption(10, 27819)

local RaidWarningFrame = RaidWarningFrame
local GetFramesRegisteredForEvent, RaidNotice_AddMessage = GetFramesRegisteredForEvent, RaidNotice_AddMessage
local function selfWarnMissingSet()
	if mod.Options.EqUneqWeaponsKT and not mod:IsEquipmentSetAvailable("pve") then
		for i = 1, select("#", GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING")) do
			local frame = select(i, GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING"))
			if frame.AddMessage then
				frame.AddMessage(frame, L.setMissing)
			end
		end
		RaidNotice_AddMessage(RaidWarningFrame, L.setMissing, ChatTypeInfo["RAID_WARNING"])
	end
end

mod:AddMiscLine(L.EqUneqLineDescription)
mod:AddBoolOption("EqUneqWeaponsKT", mod:IsDps(), nil, selfWarnMissingSet)
mod:AddBoolOption("EqUneqWeaponsKT2")

local function selfSchedWarnMissingSet(self)
	if self.Options.EqUneqWeaponsKT and not self:IsEquipmentSetAvailable("pve") then
		for i = 1, select("#", GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING")) do
			local frame = select(i, GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING"))
			if frame.AddMessage then
				self:Schedule(10, frame.AddMessage, frame, L.setMissing)
			end
		end
		self:Schedule(10, RaidNotice_AddMessage, RaidWarningFrame, L.setMissing, ChatTypeInfo["RAID_WARNING"])
	end
end
mod:Schedule(0.5, selfSchedWarnMissingSet, mod) -- mod options default values were being read before SV ones, so delay this

mod.vb.warnedAdds = false
mod.vb.MCIcon = 1
local frostBlastTargets = {}
local chainsTargets = {}
local isHunter = select(2, UnitClass("player")) == "HUNTER"

local function UnWKT(self)
	if (self.Options.EqUneqWeaponsKT or self.Options.EqUneqWeaponsKT2) and self:IsEquipmentSetAvailable("pve") then
		PickupInventoryItem(16)
		PutItemInBackpack()
		PickupInventoryItem(17)
		PutItemInBackpack()
		DBM:Debug("MH and OH unequipped",2)
		if isHunter then
			PickupInventoryItem(18)
			PutItemInBackpack()
			DBM:Debug("Ranged unequipped",2)
		end
	end
end

local function EqWKT(self)
	if (self.Options.EqUneqWeaponsKT or self.Options.EqUneqWeaponsKT2) and self:IsEquipmentSetAvailable("pve") then
		DBM:Debug("trying to equip pve",1)
		UseEquipmentSet("pve")
		CancelUnitBuff("player", (GetSpellInfo(25780))) -- Righteous Fury
	end
end

local function AnnounceChainsTargets(self)
	warnChainsTargets:Show(table.concat(chainsTargets, "< >"))
	if (not tContains(chainsTargets, UnitName("player")) and self.Options.EqUneqWeaponsKT and self:IsDps()) then
		DBM:Debug("Equipping scheduled",2)
        self:Schedule(1.0, EqWKT, self)
		self:Schedule(2.0, EqWKT, self)
		self:Schedule(3.6, EqWKT, self)
		self:Schedule(5.0, EqWKT, self)
		self:Schedule(6.0, EqWKT, self)
        self:Schedule(8.0, EqWKT, self)
		self:Schedule(10.0, EqWKT, self)
		self:Schedule(12.0, EqWKT, self)
	end
	table.wipe(chainsTargets)
	self.vb.MCIcon = 1
end

local function AnnounceBlastTargets(self)
	if self.Options.SpecWarn27808target then
		specWarnBlast:Show(table.concat(frostBlastTargets, "< >"))
		specWarnBlast:Play("healall")
	else
		warnBlastTargets:Show(table.concat(frostBlastTargets, "< >"))
	end
	blastTimer:Start(3.5)
	if self.Options.SetIconOnFrostTomb then
		for i = #frostBlastTargets, 1, -1 do
			self:SetIcon(frostBlastTargets[i], 8 - i, 4.5)
			frostBlastTargets[i] = nil
		end
	end
end

local function StartPhase2(self)
	if self.vb.phase == 1 then
		self:SetStage(2)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		if self:IsDifficulty("normal25") then
			timerMCCD:Start(61)
			warnMindControlSoon:Schedule(56)
			if self.Options.EqUneqWeaponsKT and self:IsDps() then
				self:Schedule(60, UnWKT, self)
				self:Schedule(60.5, UnWKT, self)
			end
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(chainsTargets)
	table.wipe(frostBlastTargets)
	self.vb.warnedAdds = false
	self.vb.MCIcon = 1
	specwarnP2Soon:Schedule(217-delay)
	timerPhase2:Start()
	self:Schedule(226, StartPhase2, self)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 27810 then
		warnFissure:Show()
		warnFissure:Play("watchstep")
		timerFissureCD:Start()
	elseif args.spellId == 28410 then
		timerMCCD:Start()
		DBM:Debug("MC on "..args.destName,2)
		if self.Options.EqUneqWeaponsKT2 and args.destName == UnitName("player") then
			UnWKT(self)
			self:Schedule(0.05, UnWKT, self)
			DBM:Debug("Unequipping",2)
		end
	elseif spellId == 27819 then
		timerManaBomb:Start()
	elseif spellId == 27808 then
		timerFrostBlast:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 27808 then -- Frost Blast
		table.insert(frostBlastTargets, args.destName)
		self:Unschedule(AnnounceBlastTargets)
		self:Schedule(0.5, AnnounceBlastTargets, self)
	elseif spellId == 27819 then -- Detonate Mana
		if self.Options.SetIconOnManaBomb then
			self:SetIcon(args.destName, 8, 5.5)
		end
		if args:IsPlayer() then
			specWarnManaBomb:Show()
			specWarnManaBomb:Play("bombrun")
			yellManaBomb:Yell()
		elseif self:CheckNearby(12, args.destName) then
			specWarnManaBombNear:Show()
			specWarnManaBombNear:Play("scatter")
		else
			warnMana:Show(args.destName)
		end
	elseif spellId == 28410 then -- Chains of Kel'Thuzad
		chainsTargets[#chainsTargets + 1] = args.destName
		if self:AntiSpam() then
			timerMC:Start()
			timerMCCD:Start()
			warnMindControlSoon:Schedule(60)
		end
		if self.Options.SetIconOnMC then
			self:SetIcon(args.destName, self.vb.MCIcon)
		end
		self.vb.MCIcon = self.vb.MCIcon + 1
		self:Unschedule(AnnounceChainsTargets)
		if #chainsTargets >= 3 then
			AnnounceChainsTargets(self)
		else
			self:Schedule(1.0, AnnounceChainsTargets, self)
		end
		if self.Options.EqUneqWeaponsKT and self:IsDps() then
			self:Schedule(58.0, UnWKT, self)
			self:Schedule(58.5, UnWKT, self)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 28410 then
		if self.Options.SetIconOnMC then
			self:SetIcon(args.destName, 0)
		end
		if (args.destName == UnitName("player") or args:IsPlayer()) and (self.Options.EqUneqWeaponsKT or self.Options.EqUneqWeaponsKT2) and self:IsDps() then
			DBM:Debug("Equipping scheduled",2)
	        self:Schedule(0.1, EqWKT, self)
			self:Schedule(1.7, EqWKT, self)
			self:Schedule(3.7, EqWKT, self)
	        self:Schedule(7.0, EqWKT, self)
			self:Schedule(9.0, EqWKT, self)
			self:Schedule(11.0, EqWKT, self)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warnedAdds and self:GetUnitCreatureId(uId) == 15990 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.48 then
		self.vb.warnedAdds = true
		warnAddsSoon:Show()
	end
end