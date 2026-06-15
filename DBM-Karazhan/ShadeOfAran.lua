local mod	= DBM:NewMod("Aran", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250806215207")
mod:SetCreatureID(16524)

mod:SetModelID(16621)
mod:RegisterCombat("combat")
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)


mod:RegisterEventsInCombat(
	"SPELL_CAST_START 30004 29973 29969",
	"SPELL_AURA_APPLIED 29991 29946",
	"SPELL_AURA_REMOVED 29991 29946",
	"SPELL_SUMMON 29962 37051 37052 37053"
)

local warningFlameCast		= mod:NewCastAnnounce(30004, 4)
local warningFlameTargets	= mod:NewTargetNoFilterAnnounce(29946, 4)
local warningBlizzard		= mod:NewSpellAnnounce(29969, 3)
local warningElementals		= mod:NewSpellAnnounce(37053, 3)
local warningChains			= mod:NewTargetNoFilterAnnounce(29991, 2)

local specWarnFlameWreath	= mod:NewSpecialWarning("DBM_ARAN_DO_NOT_MOVE", nil, nil, nil, 3, 2)
local specWarnArcane		= mod:NewSpecialWarningRun(29973, nil, nil, nil, 4, 7)
local specWarnBlizzard		= mod:NewSpecialWarningGTFO(29951, nil, nil, nil, 1, 6)

local timerSpecial			= mod:NewTimer(28.9, "timerSpecial", 23452, nil, nil, 2)
local timerFlameCast		= mod:NewCastTimer(5, 30004, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerArcaneExplosion	= mod:NewCastTimer(10, 29973, nil, nil, nil, 2)
local timerFlame			= mod:NewBuffActiveTimer(20.2, 29946, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBlizzad			= mod:NewBuffActiveTimer(30, 29951, nil, nil, nil, 3)
local timerElementals		= mod:NewBuffActiveTimer(90, 37053, nil, nil, nil, 6)
local timerChains			= mod:NewTargetTimer(10, 29991, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)

local berserkTimer			= mod:NewBerserkTimer(900)

mod:AddSetIconOption("WreathIcons", 29946, true, false, {5, 6, 7, 8})
mod:AddSetIconOption("ElementalIcons", 37053, true, true, {1, 2, 3, 4})

local WreathTargets = {}
mod.vb.flameWreathIcon = 8
mod.vb.mobIcon = 1

local function warnFlameWreathTargets(self)
	warningFlameTargets:Show(table.concat(WreathTargets, "<, >"))
	timerFlame:Start()
	table.wipe(WreathTargets)
	self.vb.flameWreathIcon = 8
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	self.vb.flameWreathIcon = 8
	table.wipe(WreathTargets)
	self.vb.mobIcon = 1
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE 29951",
			"SPELL_PERIODIC_MISSED 29951"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 30004 then
		warningFlameCast:Show()
		timerFlameCast:Start()
		timerSpecial:Start()
	elseif args.spellId == 29973 then
		timerArcaneExplosion:Start()
		specWarnArcane:Show()
		specWarnArcane:Play("runtoedge")
		timerSpecial:Start()
	elseif args.spellId == 29969 then
		warningBlizzard:Show()
		timerBlizzad:Start()
		timerSpecial:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 29991 then
		warningChains:Show(args.destName)
		timerChains:Start(args.destName)
	elseif args.spellId == 29946 then
		WreathTargets[#WreathTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnFlameWreath:Show()
			specWarnFlameWreath:Play("stopmove")
		end
		if self.Options.WreathIcons then
			self:SetIcon(args.destName, self.vb.flameWreathIcon, 20)
		end
		self.vb.flameWreathIcon = self.vb.flameWreathIcon - 1
		self:Unschedule(warnFlameWreathTargets)
		self:Schedule(0.3, warnFlameWreathTargets, self)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 29991 then
		timerChains:Cancel(args.destName)
	elseif args.spellId == 29946 and self.Options.WreathIcon then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(29962, 37051, 37052, 37053) then -- Summon Water elementals
		if self:AntiSpam(5, 1) then
			warningElementals:Show()
			timerElementals:Show()
		end
		if self.Options.ElementalIcons then
			self:ScanForMobs(args.destGUID, 2, self.vb.mobIcon, 1, nil, 10, "ElementalIcons")--creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName, isFriendly, secondCreatureID, skipMarked
		end
		self.vb.mobIcon = self.vb.mobIcon + 1
		if self.vb.mobIcon == 5 then self.vb.mobIcon = 1 end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
	if spellId == 29951 and destGUID == UnitGUID("player") and self:AntiSpam(2.5, 2) then
		specWarnBlizzard:Show(spellName)
		specWarnBlizzard:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
