local mod	= DBM:NewMod("Kel'Thuzad", "DBM-Naxx", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4911 $"):sub(12, -3))
mod:SetCreatureID(15990)
mod:SetMinCombatTime(60)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("yell", L.Yell)

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH"
)

local warnAddsSoon			= mod:NewAnnounce("warnAddsSoon", 1)
local warnPhase2			= mod:NewPhaseAnnounce(2, 3)
local warnBlastTargets		= mod:NewTargetAnnounce(27808, 2)
local warnFissure			= mod:NewSpellAnnounce(27810, 3)
local warnMana				= mod:NewTargetAnnounce(27819, 2)
local warnManaClose   = mod:NewSpecialWarning("Detonate Mana Near YOU")
local warnManaOnYou   = mod:NewSpecialWarning("You have Detonate Mana!")
local warnChainsTargets		= mod:NewTargetAnnounce(28410, 2)
local warnMindControl = mod:NewAnnounce("Mind Control Soon", 4)

local specwarnP2Soon		= mod:NewSpecialWarning("specwarnP2Soon")

local blastTimer			= mod:NewBuffActiveTimer(4, 27808)
local timerPhase2			= mod:NewTimer(227, "TimerPhase2")
local mindControlCD = mod:NewNextTimer(90, 28410)
local frostBlastCD    = mod:NewCDTimer(30, 27808)

mod:AddBoolOption("BlastAlarm", true)
mod:AddBoolOption("ShowRange", true)

local warnedAdds = false

function mod:OnCombatStart(delay)
	if self.Options.ShowRange then
		self:ScheduleMethod(217-delay, "RangeToggle", true)
	end
	warnedAdds = false
	specwarnP2Soon:Schedule(217-delay)
	timerPhase2:Start()
	frostBlastCD:Start(257)
	warnPhase2:Schedule(227)
	self:ScheduleMethod(226, "StartPhase2")
	self.vb.phase = 1
	if mod:IsDifficulty("heroic25") then
		mindControlCD:Start(257)
		warnMindControl:Schedule(252)
	end
	self:Schedule(227, DBM.RangeCheck.Show, DBM.RangeCheck, 12)
end

function mod:OnCombatEnd()
	if self.Options.ShowRange then
		self:RangeToggle(false)
	end
end

function mod:StartPhase2()
	self.vb.phase = 2
end

local frostBlastTargets = {}
local chainsTargets = {}
function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(27808) then -- Frost Blast
		table.insert(frostBlastTargets, args.destName)
		self:UnscheduleMethod("AnnounceBlastTargets")
		self:ScheduleMethod(0.5, "AnnounceBlastTargets")
		if self.Options.BlastAlarm then
			PlaySoundFile("Interface\\Addons\\DBM-Core\\sounds\\alarm1.wav")
		end
		blastTimer:Start()
	elseif args:IsSpellID(27819) then -- Detonate Mana
		warnMana:Show(args.destName)
		self:SetIcon(args.destName, 8, 5.5)
		if self:GetDetonateRange(args.destName) < 15 then
			if UnitName("player") == args.destName then
				PlaySoundFile("Sound\\Creature\\MekgineerThermaplug\\MekgineerThermaplugBomb01.wav")
				warnManaOnYou:Show()
				SendChatMessage("Detonate Mana on me!","SAY")
			else
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
				warnManaClose:Show()
			end
		end
	elseif args:IsSpellID(28410) then -- Chains of Kel'Thuzad
		table.insert(chainsTargets, args.destName)
		mindControlCD:Start()
		warnMindControl:Schedule(85)
		self:UnscheduleMethod("AnnounceChainsTargets")
		if #chainsTargets >= 3 then
			self:AnnounceChainsTargets()
		else
			self:ScheduleMethod(1.0, "AnnounceChainsTargets")
		end
	end
end

function mod:AnnounceChainsTargets()
	warnChainsTargets:Show(table.concat(chainsTargets, "< >"))
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
	end
	if args:IsSpellID(27808) then
		frostBlastCD:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if not warnedAdds and self:GetUnitCreatureId(uId) == 15990 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.48 then
		warnedAdds = true
		warnAddsSoon:Show()
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
	for i= 1, GetNumRaidMembers()  do
		uId = "raid"..i
		if UnitName(uId) == playerName then
			return DBM.RangeCheck:GetDistance(uId, GetPlayerMapPosition("player"))
		end
	end
	return 100 --dummy number
end
