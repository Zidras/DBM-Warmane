local mod	= DBM:NewMod("Horsemen", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4909 $"):sub(12, -3))
mod:SetCreatureID(16063, 16064, 16065, 30549)

mod:RegisterCombat("combat", 16063, 16064, 16065, 30549)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 28884 57467",
	"SPELL_CAST_SUCCESS 28832 28833 28834 28835 28883 53638 57466 32455",
	"SPELL_AURA_APPLIED_DOSE 28832 28833 28834 28835",
	"UNIT_DIED"
)

--TODO, first marks
local warnMarkSoon				= mod:NewAnnounce("WarningMarkSoon", 1, 28835, false)
local warnMeteor				= mod:NewSpellAnnounce(57467, 4)

local specWarnMarkOnPlayer		= mod:NewSpecialWarning("SpecialWarningMarkOnPlayer", nil, nil, nil, 1, 6)

local timerLadyMark				= mod:NewNextTimer(16, 28833)
local NextZeliekMark			= mod:NewNextTimer(16, 28835)
local NextBaronMark				= mod:NewNextTimer(15, 28834)
local NextThaneMark				= mod:NewNextTimer(15, 28832)
local holyWrathCD				= mod:NewCDTimer(13, 57466)

mod:AddRangeFrameOption("12")

mod:SetBossHealthInfo(
	16064, L.Korthazz,	-- Thane
	30549, L.Rivendare,	-- Baron
	16065, L.Blaumeux,	-- Lady
	16063, L.Zeliek		-- Zeliek
)

mod.vb.markCounter = 0

function mod:OnCombatStart(delay)
	self.vb.markCounter = 0
	timerLadyMark:Start()
	NextZeliekMark:Start()
	NextBaronMark:Start()
	NextThaneMark:Start()
	warnMarkSoon:Schedule(12)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(12)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(28884, 57467) then
		warnMeteor:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(28832, 28833, 28834, 28835) and self:AntiSpam(5) then
		self.vb.markCounter = self.vb.markCounter + 1
		if spellId == 28833 then -- Lady Mark
			timerLadyMark:Start(15)
		elseif spellId == 28835 then -- Zeliek Mark
			NextZeliekMark:Start(15)
		elseif spellId == 28834 then -- Barok Mark
			NextBaronMark:Start()
		elseif spellId == 28832 then -- Thane Mark
			NextThaneMark:Start()
		end
		warnMarkSoon:Schedule(12)
	elseif args:IsSpellID(28883, 53638, 57466, 32455) then
		holyWrathCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(28832, 28833, 28834, 28835) and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 4 then
			specWarnMarkOnPlayer:Show(args.spellName, amount)
			specWarnMarkOnPlayer:Play("stackhigh")
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 16064 then
		NextThaneMark:Cancel()
	elseif cid == 30549 then
		NextBaronMark:Cancel()
	elseif cid == 16065 then
		timerLadyMark:Cancel()
	elseif cid == 16063 then
		NextZeliekMark:Cancel()
	end
end