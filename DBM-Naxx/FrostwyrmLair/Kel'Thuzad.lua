local mod	= DBM:NewMod("Kel'Thuzad", "DBM-Naxx", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4911 $"):sub(12, -3))
mod:SetCreatureID(15990)
mod:SetModelID("creature/lich/lich.m2")
mod:SetMinCombatTime(60)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("yell", L.Yell)

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_SUMMON"
)

local isHunter 				= select(2, UnitClass("player")) == "HUNTER"
local warnAddsSoon			= mod:NewAnnounce("warnAddsSoon", 1)
local warnPhase2			= mod:NewPhaseAnnounce(2, 3)
local warnBlastTargets		= mod:NewTargetAnnounce(27808, 2)
local warnFissure			= mod:NewSpellAnnounce(27810, 3)
local soundFissure			= mod:NewSound(27810)
local specwarnfissure		= mod:NewSpecialWarning("fissure")
local warnMana				= mod:NewTargetAnnounce(27819, 2)
local warnManaClose   		= mod:NewSpecialWarning("manaNear")
local warnManaOnYou   		= mod:NewSpecialWarningYou(27819)
local warnChainsTargets		= mod:NewTargetAnnounce(28410, 2)
local warnMindControl 		= mod:NewSoonAnnounce(28410, 4)

local specwarnP2Soon		= mod:NewSpecialWarning("specwarnP2Soon")

local blastTimer			= mod:NewBuffActiveTimer(4, 27808)
local timerPhase2			= mod:NewTimer(227, "TimerPhase2")
local mindControlCD 		= mod:NewNextTimer(60, 28410)
local frostBlastCD   		= mod:NewCDTimer(25, 27808)
local fissureCD  			= mod:NewCDTimer(14, 27810)

local timerPossibleMC		= mod:NewTimer(20, "MCImminent", 28410)

mod:AddBoolOption("BlastAlarm", true)
mod:AddBoolOption("ShowRange", true)
mod:AddBoolOption("EqUneqWeaponsKT", (mod:IsWeaponDependent() or isHunter) and not mod:IsTank())
mod:AddBoolOption("EqUneqWeaponsKT2")

if mod.Options.EqUneqWeaponsKT and (mod:IsWeaponDependent() or isHunter) and not mod:IsTank() and (mod:IsDifficulty("heroic25") or mod:IsDifficulty("normal25")) and not mod:IsEquipmentSetAvailable("pve") then
	for i = 1, select("#", GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING")) do
		local frame = select(i, GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING"))
		if frame.AddMessage then
			mod:Schedule(10, frame.AddMessage, frame, L.setMissing)
		end
	end
	mod:Schedule(10, RaidNotice_AddMessage, RaidWarningFrame, L.setMissing, ChatTypeInfo["RAID_WARNING"])
end


local warnedAdds = false

function mod:OnCombatStart(delay)
	if self.Options.ShowRange then
		self:ScheduleMethod(217-delay, "RangeToggle", true)
	end
	warnedAdds = false
	specwarnP2Soon:Schedule(217-delay)
	timerPhase2:Start()
	frostBlastCD:Start(247)
	warnPhase2:Schedule(227)
	self:ScheduleMethod(226, "StartPhase2")
	self:SetStage(1)
	if mod:IsDifficulty("heroic25") or mod:IsDifficulty("normal25") then
		mindControlCD:Start(287)
		timerPossibleMC:Schedule(287)
		warnMindControl:Schedule(282)
		if self.Options.EqUneqWeaponsKT then
			self:ScheduleMethod(286.0, "UnWKT")
			self:ScheduleMethod(286.5, "UnWKT")
		end
	end
	self:Schedule(227, DBM.RangeCheck.Show, DBM.RangeCheck, 12)
end

function mod:UnWKT()
   if self:IsWeaponDependent() and (self.Options.EqUneqWeaponsKT or self.Options.EqUneqWeaponsKT2) then
        PickupInventoryItem(16)
        PutItemInBackpack()
        PickupInventoryItem(17)
        PutItemInBackpack()
    elseif isHunter then
        PickupInventoryItem(18)
        PutItemInBackpack()
    end
end

function mod:EqWKT()
	if (self.Options.EqUneqWeaponsKT or self.Options.EqUneqWeaponsKT2) and not self:IsWeaponDependent() and self:IsEquipmentSetAvailable("pve") then
		DBM:Debug("trying to equip pve",1)
		UseEquipmentSet("pve")
		CancelUnitBuff("player", (GetSpellInfo(25780)))
	end
end

function mod:OnCombatEnd()
	if self.Options.ShowRange then
		self:RangeToggle(false)
	end
end

function mod:StartPhase2()
	self:SetStage(2)
end

local frostBlastTargets = {}
local chainsTargets = {}

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(27810) and self:AntiSpam(2, 1) then
		warnFissure:Show()
		specwarnfissure:Show()
		soundFissure:Play("Interface\\AddOns\\DBM-Core\\sounds\\beware.ogg")
		fissureCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(27808) then -- Frost Blast
		table.insert(frostBlastTargets, args.destName)
		self:UnscheduleMethod("AnnounceBlastTargets")
		self:ScheduleMethod(0.5, "AnnounceBlastTargets")
		if self.Options.BlastAlarm then
			PlaySoundFile("Interface\\Addons\\DBM-Core\\sounds\\alarm1.wav")
		end
		blastTimer:Start()
		frostBlastCD:Start()
	elseif args:IsSpellID(27819) then -- Detonate Mana
		warnMana:Show(args.destName)
		self:SetIcon(args.destName, 8, 5.5)
		if self:GetDetonateRange(args.destName) <= 12 then
			if UnitName("player") == args.destName then
				warnManaOnYou:Show()
				SendChatMessage("Взрыв маны на мне!","SAY")
			else
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
				warnManaClose:Show()
			end
		end
	elseif args:IsSpellID(28410) then -- Chains of Kel'Thuzad
		table.insert(chainsTargets, args.destName)
		mindControlCD:Start()
		warnMindControl:Schedule(60)
		self:UnscheduleMethod("AnnounceChainsTargets")
		if #chainsTargets >= 3 then
			self:AnnounceChainsTargets()
		else
			self:ScheduleMethod(1.0, "AnnounceChainsTargets")
		end
		if self.Options.EqUneqWeaponsKT then
			self:ScheduleMethod(58.0, "UnWKT")
			self:ScheduleMethod(58.5, "UnWKT")
		end
	end
end

function mod:has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function mod:AnnounceChainsTargets()
	warnChainsTargets:Show(table.concat(chainsTargets, "< >"))
	if (not self:has_value(chainsTargets,UnitName("player")) and self.Options.EqUneqWeaponsKT) then
		DBM:Debug("Equipping scheduled",2)
        self:ScheduleMethod(1.0, "EqWKT")
		self:ScheduleMethod(2.0, "EqWKT")
		self:ScheduleMethod(3.6, "EqWKT")
		self:ScheduleMethod(5.0, "EqWKT")
		self:ScheduleMethod(6.0, "EqWKT")
        self:ScheduleMethod(8.0, "EqWKT")
		self:ScheduleMethod(10.0,"EqWKT")
		self:ScheduleMethod(12.0,"EqWKT")
	end
	table.wipe(chainsTargets)
end

function mod:AnnounceBlastTargets()
	warnBlastTargets:Show(table.concat(frostBlastTargets, "< >"))
	for i = #frostBlastTargets, 1, -1 do
		self:SetIcon(frostBlastTargets[i], 8 - i, 4.5)
		frostBlastTargets[i] = nil
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(27810) then
		warnFissure:Show()
		specwarnfissure:Show()
		soundFissure:Cancel()
		soundFissure:Schedule(0.01, "Interface\\AddOns\\DBM-Core\\sounds\\beware.ogg")
		fissureCD:Start()
	elseif args:IsSpellID(27808) then
		frostBlastCD:Start()
	elseif args.spellId == 28410 then
		mindControlCD:Start()
		timerPossibleMC:Cancel()
		timerPossibleMC:Schedule(60)
		DBM:Debug("MC on "..args.destName,2)
		if mod.Options.EqUneqWeaponsKT2 and args.destName == UnitName("player") then
			mod:UnWKT()
			mod:UnWKT()
			DBM:Debug("Unequipping",2)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if not warnedAdds and self:GetUnitCreatureId(uId) == 15990 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.48 then
		warnedAdds = true
		warnAddsSoon:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
    if args:IsSpellID(28410) then
		if (args.destName == UnitName("player") or args:IsPlayer()) and (self.Options.EqUneqWeaponsKT or self.Options.EqUneqWeaponsKT2) then
			DBM:Debug("Equipping scheduled",2)
	        self:ScheduleMethod(0.1, "EqWKT")
			self:ScheduleMethod(1.7, "EqWKT")
			self:ScheduleMethod(3.7, "EqWKT")
	        self:ScheduleMethod(7.0, "EqWKT")
			self:ScheduleMethod(9.0, "EqWKT")
			self:ScheduleMethod(11.0,"EqWKT")
		end
	end
end

function mod:RangeToggle(show)
	if show then
		DBM.RangeCheck:Show(12)
	else
		DBM.RangeCheck:Hide()
	end
end

function mod:GetDetonateRange(playerName)
	local uId
	for i= 1, GetNumRaidMembers()  do
		uId = "raid"..i
		if UnitName(uId) == playerName then
			return DBM.RangeCheck:GetDistance(uId, GetPlayerMapPosition("player"))
		end
	end
	return 100 --dummy number
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellMC1 or msg:find(L.YellMC1) or msg == L.YellMC2 or msg:find(L.YellMC2)) then
		if mod.Options.EqUneqWeaponsKT and mod:IsWeaponDependent() then
			mod:UnWKT()
			mod:UnWKT()
			self:ScheduleMethod(59, "UnWKT")
		end
		timerPossibleMC:Cancel()
		mindControlCD:Start()
		timerPossibleMC:Schedule(60)
	end
end
