local mod	= DBM:NewMod("Horsemen", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4909 $"):sub(12, -3))
mod:SetCreatureID(16063, 16064, 16065, 30549)

mod:RegisterCombat("combat", 16063, 16064, 16065, 30549)

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_CAST_SUCCEEDED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_APPLIED",
	"UNIT_DIED"
)

local warnMarkSoon			= mod:NewAnnounce("WarningMarkSoon", 1, 28835, false)
local warnMarkNow			= mod:NewAnnounce("WarningMarkNow", 2, 28835)
local holyWrathCD     		= mod:NewCDTimer(13, 57466)

local LADY_MARK = 28833
local ZELIEK_MARK = 28835
local BARON_MARK = 28834
local THANE_MARK = 28832

local NextLadyMark			= mod:NewNextTimer(12, LADY_MARK)
local NextZeliekMark		= mod:NewNextTimer(12, ZELIEK_MARK)
local NextBaronMark			= mod:NewNextTimer(10, BARON_MARK)
local NextThaneMark			= mod:NewNextTimer(10, THANE_MARK)

local specWarnMarkOnPlayer	= mod:NewSpecialWarning("SpecialWarningMarkOnPlayer", nil, false, true)

mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("RangeFrame")

mod:SetBossHealthInfo(
	16064, L.Korthazz,
	30549, L.Rivendare,
	16065, L.Blaumeux,
	16063, L.Zeliek
)

local markCounter = 0

function mod:OnCombatStart(delay)
	self.combat_start = GetTime()
	markCounter = 0
	NextLadyMark:Start(34)
	NextZeliekMark:Start(34)
	NextBaronMark:Start(34)
	NextThaneMark:Start(34)

	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(12)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local markSpam = 0

function mod:SPELL_AURA_APPLIED(args)
	self:DoMarks(args)
end

function mod:DoMarks(args)
	local wasMark = false
	if args:IsSpellID(LADY_MARK) then
		wasMark = true
		NextLadyMark:Start(12)
	elseif args:IsSpellID(ZELIEK_MARK) then
		wasMark = true
		NextZeliekMark:Start(12)
	elseif args:IsSpellID(BARON_MARK) then
		wasMark = true
		NextBaronMark:Start(10)
	elseif args:IsSpellID(THANE_MARK) then
		wasMark = true
		NextThaneMark:Start(10)
	end

	if wasMark and (GetTime() - markSpam) > 5 then
		markSpam = GetTime()
		markCounter = markCounter + 1
	end

	return wasMark
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(28883, 53638, 57466, 32455) then
		holyWrathCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if self:DoMarks(args) and args:IsPlayer() then
		if args.amount >= 3 then
			specWarnMarkOnPlayer:Show(args.spellName, args.amount)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 16064 then
		NextZeliekMark:Cancel()
	elseif cid == 30549 then
		NextBaronMark:Cancel()
	elseif cid == 16065 then
		NextLadyMark:Cancel()
	elseif cid == 16063 then
		NextZeliekMark:Cancel()
	end
end
