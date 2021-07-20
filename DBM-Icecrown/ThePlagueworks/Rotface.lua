local mod	= DBM:NewMod("Rotface", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4408 $"):sub(12, -3))
mod:SetCreatureID(36627)
mod:SetUsedIcons(7, 8)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SWING_DAMAGE",
	"CHAT_MSG_MONSTER_YELL"
)

local warnSlimeSpray			= mod:NewSpellAnnounce(69508, 2)
local warnMutatedInfection		= mod:NewTargetAnnounce(69674, 4)
local warnRadiatingOoze			= mod:NewSpellAnnounce(69760, 3)
local warnOozeSpawn				= mod:NewAnnounce("WarnOozeSpawn", 1)
local warnStickyOoze			= mod:NewSpellAnnounce(69774, 1)
local warnUnstableOoze			= mod:NewStackAnnounce(69558, 2)
local warnVileGas				= mod:NewTargetAnnounce(72272, 3)

local specWarnMutatedInfection	= mod:NewSpecialWarningYou(69674, nil, nil, nil, 1, 2)
local specWarnStickyOoze		= mod:NewSpecialWarningMove(69774, nil, nil, nil, 1, 2)
local specWarnOozeExplosion		= mod:NewSpecialWarningDodge(69839, nil, nil, nil, 1, 2)
local specWarnSlimeSpray		= mod:NewSpecialWarningSpell(69508, false, nil, nil, 1, 2)--For people that need a bigger warning to move
local specWarnRadiatingOoze		= mod:NewSpecialWarningSpell(69760, "-Tank", nil, nil, 1, 2)
local specWarnLittleOoze		= mod:NewSpecialWarning("SpecWarnLittleOoze", false, nil, nil, 1, 2)
local specWarnVileGas			= mod:NewSpecialWarningYou(72272, nil, nil, nil, 1, 2)

local timerStickyOoze			= mod:NewNextTimer(16, 69774, nil, "Tank", nil, 5)
local timerWallSlime			= mod:NewNextTimer(25, 69789) -- Edited.
local timerSlimeSpray			= mod:NewNextTimer(21, 69508, nil, nil, nil, 3)
local timerMutatedInfection		= mod:NewTargetTimer(12, 69674, nil, nil, nil, 3)
local timerOozeExplosion		= mod:NewCastTimer(4, 69839, nil, nil, nil, 2, nil, DBM_CORE_L.MYTHIC_ICON, nil, 3)
local timerVileGasCD			= mod:NewNextTimer(30, 72272, nil, nil, nil, 3)

mod:AddBoolOption("RangeFrame", "Ranged")
mod:AddBoolOption("InfectionIcon", true)
mod:AddBoolOption("TankArrow")

local RFVileGasTargets	= {}
local spamOoze = 0
mod.vb.InfectionIcon = 8

local function warnRFVileGasTargets()
	warnVileGas:Show(table.concat(RFVileGasTargets, "<, >"))
	table.wipe(RFVileGasTargets)
	timerVileGasCD:Start()
end

local function WallSlime(self)
	self:Unschedule(WallSlime)
	if self:IsInCombat() then
		timerWallSlime:Start()
		self:Schedule(20, WallSlime, self)
	end
end
function mod:OnCombatStart(delay)
	timerWallSlime:Start(9-delay) -- Adjust from 25 to 9 to have a correct timer from the start
	timerSlimeSpray:Start(20-delay) -- Custom add for the first Slime Spray
	timerVileGasCD:Start(29-delay) -- Edited.
	self:Schedule(25-delay, WallSlime, self)
	self.vb.InfectionIcon = 8
	spamOoze = 0
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10) -- Increased from 8 to 10
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 69508 then
		timerSlimeSpray:Start()
		specWarnSlimeSpray:Show()
		warnSlimeSpray:Show()
	elseif args.spellId == 69774 then
		timerStickyOoze:Start()
		warnStickyOoze:Show()
	elseif args.spellId == 69839 then --Unstable Ooze Explosion (Big Ooze)
		if GetTime() - spamOoze < 4 then --This will prevent spam but breaks if there are 2 oozes. GUID work is required
			specWarnOozeExplosion:Cancel()
			specWarnOozeExplosion:CancelVoice()
		end
		if GetTime() - spamOoze < 4 or GetTime() - spamOoze > 5 then --Attempt to ignore a cast that may fire as an ooze is already exploding.
			timerOozeExplosion:Start()
			specWarnOozeExplosion:Schedule(4)
			specWarnOozeExplosion:ScheduleVoice(4, "watchstep")
		end
		spamOoze = GetTime()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 71208 and args:IsPlayer() then
		specWarnStickyOoze:Show()
		specWarnStickyOoze:Play("runaway")
	elseif args.spellId == 69760 then
		warnRadiatingOoze:Show()
	elseif args.spellId == 69558 then
		warnUnstableOoze:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(69674, 71224, 73022, 73023) then
		timerMutatedInfection:Start(args.destName)
		if args:IsPlayer() then
			specWarnMutatedInfection:Show()
			specWarnMutatedInfection:Play("movetotank")
		else
			warnMutatedInfection:Show(args.destName)
		end
		if self.Options.InfectionIcon then
			self:SetIcon(args.destName, self.vb.InfectionIcon, 12)
		end
		if self.vb.InfectionIcon == 8 then	-- After ~3mins there is a chance 2 ppl will have the debuff, so we are alternating between 2 icons
			self.vb.InfectionIcon = 7
		else
			self.vb.InfectionIcon = 8
		end
	elseif args:IsSpellID(72272, 72273) and args:IsDestTypePlayer() then	-- Vile Gas(Heroic Rotface only, 25 man spellid the same as 10?)
		RFVileGasTargets[#RFVileGasTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnVileGas:Show()
			specWarnVileGas:Play("scatter")
		end
		self:Unschedule(warnRFVileGasTargets)
		self:Schedule(2.5, warnRFVileGasTargets) -- Yes it does take this long to travel to all 3 targets sometimes, qq.
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(72272, 72273) then
		timerVileGasCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(69674, 71224, 73022, 73023) then
		timerMutatedInfection:Cancel(args.destName)
		warnOozeSpawn:Show()
		if self.Options.InfectionIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(69761, 71212, 73026, 73027) and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnRadiatingOoze:Show()
		specWarnRadiatingOoze:Play("runaway")
	elseif args:GetDestCreatureID() == 36899 and args:IsSrcTypePlayer() and not args:IsSpellID(53189, 53190, 53194, 53195) then--Any spell damage except for starfall (ranks 3 and 4)
		if args.sourceName ~= UnitName("player") then
			if self.Options.TankArrow then
				DBM.Arrow:ShowRunTo(args.sourceName, 0, 0)
			end
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SWING_DAMAGE(args)
	if args:GetSrcCreatureID() == 36897 and args:IsPlayer() and self:AntiSpam(3, 2) then --Little ooze hitting you
		specWarnLittleOoze:Show()
		specWarnLittleOoze:Play("keepmove")
	elseif args:GetDestCreatureID() == 36899 and args:IsSrcTypePlayer() then
		if args.sourceName ~= UnitName("player") then
			if self.Options.TankArrow then
				DBM.Arrow:ShowRunTo(args.sourceName, 0, 0)
			end
		end
	end
end
mod.SWING_MISSED = mod.SWING_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellSlimePipes1 or msg:find(L.YellSlimePipes1)) or (msg == L.YellSlimePipes2 or msg:find(L.YellSlimePipes2)) then
		WallSlime(self)
	end
end
