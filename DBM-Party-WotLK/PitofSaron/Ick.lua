local mod	= DBM:NewMod("Ick", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4342 $"):sub(12, -3))
mod:SetCreatureID(36476)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"UNIT_AURA"
)

local warnPursuitCast			= mod:NewCastAnnounce(68987, 3)
local warnPursuit				= mod:NewTargetNoFilterAnnounce(68987, 4)

local specWarnToxic				= mod:NewSpecialWarningMove(69024, nil, nil, nil, 1, 2)
local specWarnMines				= mod:NewSpecialWarningSpell(69015, nil, nil, nil, 2, 2)
local specWarnPursuit			= mod:NewSpecialWarningRun(68987, nil, nil, 2, 4, 2)
local specWarnPoisonNova		= mod:NewSpecialWarningRun(68989, "Melee", nil, 2, 4, 2)

local timerSpecialCD			= mod:NewCDSpecialTimer(20)--Every 20-22 seconds. In rare cases he skips a special though and goes 40 seconds. unsure of cause
local timerPursuitCast			= mod:NewCastTimer(5, 68987)
local timerPursuitConfusion		= mod:NewBuffActiveTimer(12, 69029)
local timerPoisonNova			= mod:NewCastTimer(5, 68989, nil, "Melee", 2, 2)

mod:AddSetIconOption("SetIconOnPursuitTarget", 68987, true, false, {8})

local pursuit = DBM:GetSpellInfo(68987)
local pursuitTable = {}

function mod:OnCombatStart(delay)
	table.wipe(pursuitTable)
	timerSpecialCD:Start()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 68987 then							-- Pursuit
		warnPursuitCast:Show()
		timerPursuitCast:Start()
		timerSpecialCD:Start()
	elseif args:IsSpellID(68989, 70434) then				-- Poison Nova
		timerPoisonNova:Start()
		specWarnPoisonNova:Show()
		specWarnPoisonNova:Play("runout")
		timerSpecialCD:Start()
	elseif args.spellId == 69012 then				--Explosive Barrage
		specWarnMines:Show()
		specWarnMines:Play("watchstep")
		timerSpecialCD:Start(22) --Will be 2 seconds longer because of how long barrage lasts
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69029, 70850) then							-- Pursuit Confusion
		timerPursuitConfusion:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69029 then					-- Pursuit Confusion
		timerPursuitConfusion:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if (spellId == 69024 or spellId == 70436) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnToxic:Show()
		specWarnToxic:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_AURA(uId)
	local isPursuitDebuff = DBM:UnitDebuff(uId, pursuit)
	local name = DBM:GetUnitFullName(uId)
	if not isPursuitDebuff and pursuitTable[name] then
		pursuitTable[name] = nil
		if self.Options.SetIconOnPursuitTarget then
			self:SetIcon(name, 0)
		end
	elseif isPursuitDebuff and not pursuitTable[name] then
		pursuitTable[name] = true
		if UnitIsUnit(uId, "player") then
			specWarnPursuit:Show()
			specWarnPursuit:Play("justrun")
		else
			warnPursuit:Show(name)
		end
		if self.Options.SetIconOnPursuitTarget then
			self:SetIcon(name, 8)
		end
	end
end
