local mod	= DBM:NewMod("Horsemen", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
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
local timerZeliekMark			= mod:NewNextTimer(16, 28835)
local timerBaronMark			= mod:NewNextTimer(15, 28834)
local timerThaneMark			= mod:NewNextTimer(15, 28832)
local timerHolyWrathCD			= mod:NewCDTimer(13, 57466)
local timerMeteorCD				= mod:NewCDTimer(15, 57467, nil, nil, nil, 2)

mod:AddRangeFrameOption("12")

mod:SetBossHealthInfo(
	16064, L.Korthazz,	-- Thane
	30549, L.Rivendare,	-- Baron
	16065, L.Blaumeux,	-- Lady
	16063, L.Zeliek		-- Zeliek
)

mod.vb.markCounter = 0

-- Still 15s timer on next meteor when he skips one (usually on tank swaps)
local function MeteorCast(self)
	self:Unschedule(MeteorCast)
	timerMeteorCD:Start()
	self:Schedule(15, MeteorCast, self)
end

function mod:OnCombatStart()
	self.vb.markCounter = 0
	timerLadyMark:Start()
	timerZeliekMark:Start()
	timerBaronMark:Start()
	timerThaneMark:Start()
	warnMarkSoon:Schedule(12)
	timerMeteorCD:Start()
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
		MeteorCast(self)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(28832, 28833, 28834, 28835) and self:AntiSpam(5, spellId) then
		self.vb.markCounter = self.vb.markCounter + 1
		if spellId == 28833 then -- Lady Mark
			timerLadyMark:Start(15)
		elseif spellId == 28835 then -- Zeliek Mark
			timerZeliekMark:Start(15)
		elseif spellId == 28834 then -- Baron Mark
			timerBaronMark:Start()
		elseif spellId == 28832 then -- Thane Mark
			timerThaneMark:Start()
		end
		warnMarkSoon:Schedule(12)
	elseif args:IsSpellID(28883, 53638, 57466, 32455) then
		timerHolyWrathCD:Start()
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
		timerThaneMark:Cancel()
		timerMeteorCD:Cancel()
		self:Unschedule(MeteorCast)
	elseif cid == 30549 then
		timerBaronMark:Cancel()
	elseif cid == 16065 then
		timerLadyMark:Cancel()
	elseif cid == 16063 then
		timerZeliekMark:Cancel()
	end
end