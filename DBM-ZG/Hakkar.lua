local mod	= DBM:NewMod("Hakkar", "DBM-ZG", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220909005309")
mod:SetCreatureID(14834)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 24324 24686 24687 24688 24689 24690",
	"SPELL_AURA_APPLIED 24327 24328 24686 24687 24689 24690",
	"SPELL_AURA_REMOVED 24328 24689"
)

--TODO, get a buff check for starting initial hard mode timers
--TODO, an infoframe showing list of players silenced by Jeklik on hard mode instead uf using a spammy timer
--[[
(ability.id = 24324 or ability.id = 24686 or ability.id = 24687 or ability.id = 24688 or ability.id = 24689 or ability.id = 24690) and type = "cast"
--]]
local warnSiphonSoon			= mod:NewSoonAnnounce(24324)
local warnInsanity				= mod:NewTargetNoFilterAnnounce(24327, 4)
local warnBlood					= mod:NewTargetAnnounce(24328, 2)--Not excempt from filter since it could be spammy
local warnAspectOfMarli			= mod:NewTargetNoFilterAnnounce(24686, 2)
local warnAspectOfThekal		= mod:NewSpellAnnounce(24689, 3, nil, "Tank|RemoveEnrage|Healer", 4)
local warnAspectOfArlokk		= mod:NewTargetNoFilterAnnounce(24690, 3)

local specWarnBlood				= mod:NewSpecialWarningMoveAway(24328, nil, nil, nil, 1, 2)
local yellBlood					= mod:NewYell(24328, nil, false, 2)
local specWarnAspectOfThekal	= mod:NewSpecialWarningDispel(24689, "RemoveEnrage", nil, nil, 1, 6)

local timerSiphon				= mod:NewNextTimer(90, 24324, nil, nil, nil, 2)
local timerAspectOfMarli		= mod:NewTargetTimer(6, 24686, nil, nil, nil, 5)
local timerAspectOfMarliCD		= mod:NewCDTimer(16, 24686, nil, nil, nil, 2)--16-20
local timerAspectOfJeklik		= mod:NewTargetTimer(5, 24687, nil, false, 2, 5)--Could be spammy so off by default. Users can turn it on who want to see this
local timerAspectOfJeklikCD		= mod:NewCDTimer(23, 24687, nil, nil, nil, 2)--23-24
local timerAspectOfVenoxisCD	= mod:NewCDTimer(16.2, 24688, nil, nil, nil, 2)--16.2-18.3
local timerAspectOfThekal		= mod:NewBuffActiveTimer(8, 24689, nil, "Tank|RemoveEnrage|Healer", 3, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.ENRAGE_ICON)
local timerAspectOfThekalCD		= mod:NewCDTimer(15.8, 24689, nil, nil, nil, 2)
local timerAspectOfArlokk		= mod:NewTargetTimer(2, 24690, nil, nil, nil, 2)
local timerAspectOfArlokkCD		= mod:NewNextTimer(30, 24690, nil, nil, nil, 2)--Needs more data to verify it's a next timer, rest aren't
local timerInsanity				= mod:NewTargetTimer(10, 24327, nil, nil, nil, 5)
local timerInsanityCD			= mod:NewCDTimer(20, 24327, nil, nil, nil, 3)

local enrageTimer				= mod:NewBerserkTimer(585)

mod:AddRangeFrameOption(10, 24328)

local function IsHardMode(self)
	if DBM:IsInRaid() then
		for i = 1, DBM:GetNumGroupMembers() do
			local UnitID = "raid"..i.."target"
			local guid = UnitGUID(UnitID)
			if guid then
				local cid = self:GetCIDFromGUID(guid)
				if cid == 14834 then
					if UnitHealthMax(UnitID) >= 1079325 then
						return true
					end
				end
			end
		end
	elseif DBM:IsInGroup() then
		for i = 1, DBM:GetNumSubgroupMembers() do
			local UnitID = "party"..i.."target"
			local guid = UnitGUID(UnitID)
			if guid then
				local cid = self:GetCIDFromGUID(guid)
				if cid == 14834 then
					if UnitHealthMax(UnitID) >= 1079325 then
						return true
					end
				end
			end
		end
	else--Solo Raid?, maybe in classic TBC or classic WRATH. Future proofing the mod
		local guid = UnitGUID("target")
		if guid then
			local cid = self:GetCIDFromGUID(guid)
			if cid == 14834 then
				if UnitHealthMax("target") >= 1079325 then
					return true
				end
			end
		end
	end
	return false
end

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	warnSiphonSoon:Schedule(80-delay)
	timerSiphon:Start(-delay)
	--Hard Mode Timers
	--This just checks if Hakkar has 1079325 health
	--Can't just start these on all normal mode pulls
	if IsHardMode(self) then
		timerAspectOfMarliCD:Start(10-delay)
		timerAspectOfThekalCD:Start(10-delay)
		timerAspectOfVenoxisCD:Start(14-delay)
		timerAspectOfJeklikCD:Start(21-delay)
		timerAspectOfArlokkCD:Start(30-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 24324 then
		warnSiphonSoon:Cancel()
		warnSiphonSoon:Schedule(80)
		timerSiphon:Start()
	elseif args.spellId == 24686 then
		timerAspectOfMarliCD:Start()
	elseif args.spellId == 24687 then
		timerAspectOfJeklikCD:Start()
	elseif args.spellId == 24688 then
		timerAspectOfVenoxisCD:Start()
	elseif args.spellId == 24689 then
		timerAspectOfThekalCD:Start()
	elseif args.spellId == 24690 then
		timerAspectOfArlokkCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 24327 then
		warnInsanity:Show(args.destName)
		timerInsanity:Start(args.destName)
		timerInsanityCD:Start()
	elseif args.spellId == 24328 then
		if args:IsPlayer() then
			specWarnBlood:Show()
			specWarnBlood:Play("runout")
			yellBlood:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		else
			warnBlood:Show(args.destName)
		end
	elseif args.spellId == 24686 then
		warnAspectOfMarli:Show(args.destName)
		timerAspectOfMarli:Start(args.destName)
	elseif args.spellId == 24687 then
		timerAspectOfJeklik:Start(args.destName)
	elseif args.spellId == 24689 and args:IsDestTypeHostile() then
		if self.Options.SpecWarn24689dispel then
			specWarnAspectOfThekal:Show()
			specWarnAspectOfThekal:Play("enrage")
		else
			warnAspectOfThekal:Show()
		end
		timerAspectOfThekal:Start()
	elseif args.spellId == 24690 then
		warnAspectOfArlokk:Show(args.destName)
		timerAspectOfArlokk:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 20475 then
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif args:IsSpellID(24689) and args:IsDestTypeHostile() then
		timerAspectOfThekal:Stop()
	end
end
