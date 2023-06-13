local mod	= DBM:NewMod("Horsemen", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221016185606")
mod:SetCreatureID(16063, 16064, 16065, 30549)

mod:RegisterCombat("combat", 16063, 16064, 16065, 30549)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 28884 57467",
	"SPELL_CAST_SUCCESS 28832 28833 28834 28835 28883 53638 57466 32455",
	"SPELL_AURA_APPLIED 29061",
	"SPELL_AURA_REMOVED 29061",
	"SPELL_AURA_APPLIED_DOSE 28832 28833 28834 28835",
	"UNIT_DIED"
)

--TODO, first marks
--TODO, verify stuff migrated from naxx 40
local warnMarkSoon				= mod:NewAnnounce("WarningMarkSoon", 1, 28835, false, nil, nil, 28835)
local warnMeteor				= mod:NewSpellAnnounce(57467, 4)
local warnVoidZone				= mod:NewTargetNoFilterAnnounce(28863, 3)--Only warns for nearby targets, to reduce spam
local warnHolyWrath				= mod:NewTargetNoFilterAnnounce(28883, 3, nil, false)
local warnBoneBarrier			= mod:NewTargetNoFilterAnnounce(29061, 2)

local specWarnMarkOnPlayer		= mod:NewSpecialWarning("SpecialWarningMarkOnPlayer", nil, nil, nil, 1, 6, nil, nil, 28835)
local specWarnVoidZone			= mod:NewSpecialWarningYou(28863, nil, nil, nil, 1, 2)
local yellVoidZone				= mod:NewYell(28863)

local timerLadyMark				= mod:NewNextTimer(16, 28833, nil, nil, nil, 3)
local timerZeliekMark			= mod:NewNextTimer(16, 28835, nil, nil, nil, 3)
local timerBaronMark			= mod:NewNextTimer(15, 28834, nil, nil, nil, 3)
local timerThaneMark			= mod:NewNextTimer(15, 28832, nil, nil, nil, 3)
local timerMeteorCD				= mod:NewCDTimer(11.1, 57467, nil, nil, nil, 3, nil, nil, true) -- REVIEW! ~10s variance? Added "keep" arg (25man Lordaeron 2022/10/16 wipe || 25man Lordaeron 2022/10/16 kill) - 17.8, 17.7, 17.8, 17.7, 15.5 || 17.7, 15.5, 17.8, 17.9, 11.1, 17.7, 13.4, 20.0, 13.3, 20.0
--local timerVoidZoneCD			= mod:NewCDTimer(12.9, 28863, nil, nil, nil, 3)-- 12.9-16
local timerHolyWrathCD			= mod:NewCDTimer(13, 28883, nil, nil, nil, 3)
local timerBoneBarrier			= mod:NewTargetTimer(20, 29061, nil, nil, nil, 5)

mod:AddRangeFrameOption("12")

mod:SetBossHealthInfo(
	16064, L.Korthazz,	-- Thane
	30549, L.Rivendare,	-- Baron
	16065, L.Blaumeux,	-- Lady
	16063, L.Zeliek		-- Zeliek
)

mod.vb.markCount = 0

-- REVIEW-Have two logs where this is NOT verified! Still 15s timer on next meteor when he skips one (usually on tank swaps)
--[[local function MeteorCast(self)
	self:Unschedule(MeteorCast)
	timerMeteorCD:Restart()
	self:Schedule(15, MeteorCast, self)
end]]

function mod:OnCombatStart()
	self.vb.markCount = 0
	timerLadyMark:Start()
	timerZeliekMark:Start()
	timerBaronMark:Start()
	timerThaneMark:Start()
	warnMarkSoon:Schedule(12)
	timerMeteorCD:Start()
	timerHolyWrathCD:Start(10.1) -- REVIEW! ~2s variance? (25man Lordaeron 2022/10/16 wipe || 25man Lordaeron 2022/10/16 kill) - 12.3 || 10.1
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
		timerMeteorCD:Start()
--		MeteorCast(self)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(28832, 28833, 28834, 28835) and self:AntiSpam(5, spellId) then
		self.vb.markCount = self.vb.markCount + 1
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
	elseif args.spellId == 28863 then
--		timerVoidZoneCD:Start()
		if args:IsPlayer() then
			specWarnVoidZone:Show()
			specWarnVoidZone:Play("targetyou")
			yellVoidZone:Yell()
		elseif self:CheckNearby(12, args.destName) then
			warnVoidZone:Show(args.destName)
		end
	elseif args:IsSpellID(28883, 53638, 57466, 32455) then
		warnHolyWrath:Show(args.destName)
		timerHolyWrathCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 29061 then
		warnBoneBarrier:Show(args.destName)
		timerBoneBarrier:Start(20, args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 29061 then
		timerBoneBarrier:Stop(args.destName)
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
--		self:Unschedule(MeteorCast)
	elseif cid == 30549 then
		timerBaronMark:Cancel()
	elseif cid == 16065 then
		timerLadyMark:Cancel()
	elseif cid == 16063 then
		timerZeliekMark:Cancel()
	end
end
