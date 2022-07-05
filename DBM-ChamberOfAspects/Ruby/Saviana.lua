local mod	= DBM:NewMod("Saviana", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(39747)
mod:SetUsedIcons(8, 7, 6, 5, 4)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 74403 74404",
	"SPELL_AURA_APPLIED 78722 74453",
	"SPELL_AURA_REMOVED 78722"
)

local warningWarnBeacon		= mod:NewTargetNoFilterAnnounce(74453, 4)--Will change to a target announce if possible. need to do encounter
local warningWarnBreath		= mod:NewSpellAnnounce(74403, 3)

local specWarnBeacon		= mod:NewSpecialWarningYou(74453, nil, nil, nil, 1, 2)--Target scanning may not even work since i haven't done encounter yet it's just a guess.
local specWarnTranq			= mod:NewSpecialWarningDispel(78722, "RemoveEnrage", nil, nil, 1, 2)

local timerBeacon			= mod:NewBuffActiveTimer(5, 74453, nil, nil, nil, 3)
local timerConflag			= mod:NewBuffActiveTimer(5, 74456, nil, nil, nil, 3)
local timerConflagCD		= mod:NewNextTimer(50, 74452, nil, nil, nil, 3)
local timerBreath			= mod:NewCDTimer(25, 74403, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerEnrage			= mod:NewBuffActiveTimer(10, 78722, nil, "RemoveEnrage|Tank|Healer", nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON..DBM_COMMON_L.TANK_ICON)

mod:AddRangeFrameOption(10, 74456)
mod:AddSetIconOption("beaconIcon", 74453, true, false, {8, 7, 6, 5, 4})

mod:GroupSpells(74453, 74456, 74452)--Group target debuff ID with regular debuff IDs

local beaconTargets = {}
mod.vb.beaconIcon	= 8

local function warnConflagTargets(self)
	warningWarnBeacon:Show(table.concat(beaconTargets, "<, >"))
	table.wipe(beaconTargets)
	self.vb.beaconIcon = 8
end

function mod:OnCombatStart(delay)
	timerConflagCD:Start(32-delay)--need more pulls to verify consistency
	timerBreath:Start(12-delay)--need more pulls to verify consistency
	table.wipe(beaconTargets)
	self.vb.beaconIcon = 8
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74403, 74404) then
		warningWarnBreath:Show()
		timerBreath:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 78722 then
		specWarnTranq:Show(args.destName)
		specWarnTranq:Play("trannow")
		timerEnrage:Start()
	elseif spellId == 74453 then
		beaconTargets[#beaconTargets + 1] = args.destName
		timerConflagCD:Start()
		timerBeacon:Start()
		timerConflag:Schedule(5)
		if args:IsPlayer() then
			specWarnBeacon:Show()
			specWarnBeacon:Play("targetyou")
		end
		if self.Options.beaconIcon then
			self:SetIcon(args.destName, self.vb.beaconIcon, 11)
		end
		self.vb.beaconIcon = self.vb.beaconIcon - 1
		self:Unschedule(warnConflagTargets)
		self:Schedule(0.3, warnConflagTargets, self)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 78722 then
		timerEnrage:Cancel()
	end
end