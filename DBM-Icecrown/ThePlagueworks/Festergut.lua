local mod	= DBM:NewMod("Festergut", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230827173452")
mod:SetCreatureID(36626)
mod:RegisterCombat("combat")
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20230627000000)
mod:SetMinSyncRevision(20230627000000)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 69195 71219 73031 73032",
	"SPELL_CAST_SUCCESS 69278 71221",
	"SPELL_AURA_APPLIED 69279 69166 71912 72219 72551 72552 72553 69240 71218 73019 73020 69291 72101 72102 72103 19753",
	"SPELL_AURA_APPLIED_DOSE 69166 71912 72219 72551 72552 72553 69291 72101 72102 72103",
	"SPELL_AURA_REMOVED 69279"
)

local warnInhaledBlight		= mod:NewStackAnnounce(69166, 3)
local warnGastricBloat		= mod:NewStackAnnounce(72219, 2, nil, "Tank|Healer")
local warnGasSpore			= mod:NewTargetNoFilterAnnounce(69279, 4)
local warnVileGas			= mod:NewTargetAnnounce(69240, 3)

local specWarnPungentBlight	= mod:NewSpecialWarningSpell(69195, nil, nil, nil, 2, 2)
local specWarnGasSpore		= mod:NewSpecialWarningYou(69279, nil, nil, nil, 1, 2)
local yellGasSpore			= mod:NewYellMe(69279)
local specWarnVileGas		= mod:NewSpecialWarningYou(69240, nil, nil, nil, 1, 2)
local yellVileGas			= mod:NewYellMe(69240)
local specWarnGastricBloat	= mod:NewSpecialWarningStack(72219, nil, 9, nil, nil, 1, 6)
local specWarnInhaled3		= mod:NewSpecialWarning("Stack3", "Tank", nil, nil, nil, nil, nil, nil, 69166)

local timerGasSpore			= mod:NewBuffFadesTimer(12, 69279, nil, nil, nil, 3)
local timerVileGas			= mod:NewBuffFadesTimer(6, 69240, nil, "Ranged", nil, 3)
local timerGasSporeCD		= mod:NewCDTimer(40, 69279, nil, nil, nil, 3, nil, nil, true)	-- REVIEW CD =>
local timerPungentBlight	= mod:NewCDTimer(33.5, 69195, nil, nil, nil, 2)		-- REVIEW CD =>
local timerInhaledBlight	= mod:NewCDTimer(33.5, 69166, nil, nil, nil, 6, nil, nil, true)	-- REVIEW CD =>
local timerGastricBloat		= mod:NewTargetTimer(100, 72219, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)	-- 100 Seconds until expired
local timerGastricBloatCD	= mod:NewCDTimer(12, 72219, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON) -- REVIEW CD => pull:12.51, 12.33, 12.08, 10.56, 11.86, 11.47, 10.66, 11.31, 11.21, 10.92, 11.42, 10.99, 11.12, 10.22, 12.22 || pull:13.81, 10.92, 12.02, 11.99, 12.41, 11.64, 11.41, 11.92, 11.71, 12.20, 14.07, 11.29

local berserkTimer			= mod:NewBerserkTimer(300)

mod:AddBoolOption("RemoveDI","Tank")
mod:AddRangeFrameOption(10, 69240, "Ranged")
mod:AddSetIconOption("SetIconOnGasSpore", 69279, true, 7, {1, 2, 3})
mod:AddBoolOption("AnnounceSporeIcons", false, nil, nil, nil, nil, 69279)
mod:AddBoolOption("AchievementCheck", false, "announce", nil, nil, nil, 4615, "achievement")

local gasSporeTargets = {}
local vileGasTargets = {}
mod.vb.gasSporeCast = 0
mod.vb.warnedfailed = false

local function RemoveDI(self)
	if self.Options.RemoveDI then
		CancelUnitBuff("player", (GetSpellInfo(19753)))
	end
end

function mod:AnnounceSporeIcons(uId, icon)
	if self.Options.AnnounceSporeIcons and DBM:IsInGroup() and DBM:GetRaidRank() > 1 then
		SendChatMessage(L.SporeSet:format(icon, DBM:GetUnitFullName(uId)), DBM:IsInRaid() and "RAID" or "PARTY")
	end
end

local function warnGasSporeTargets()
	warnGasSpore:Show(table.concat(gasSporeTargets, "<, >"))
	timerGasSpore:Start()
	table.wipe(gasSporeTargets)
end

local function warnVileGasTargets()
	warnVileGas:Show(table.concat(vileGasTargets, "<, >"))
	table.wipe(vileGasTargets)
	timerVileGas:Start()
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerInhaledBlight:Start(28.9-delay) -- REVIEW CD =>
	timerGasSporeCD:Start(20-delay) -- REVIEW CD =>
	timerGastricBloatCD:Start(-delay)
	table.wipe(gasSporeTargets)
	table.wipe(vileGasTargets)
	self.vb.gasSporeCast = 0
	self.vb.warnedfailed = false
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10) -- REVIEW CD =>
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69195, 71219, 73031, 73032) then	-- Pungent Blight
		specWarnPungentBlight:Show()
		specWarnPungentBlight:Play("aesoon")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(69278, 71221) then	-- Gas Spore (10 man, 25 man)
		self.vb.gasSporeCast = self.vb.gasSporeCast + 1
		if self.vb.gasSporeCast == 6 then
			timerGasSporeCD:Start(50) -- From all the 2023 logs I have, there was only one 50s instance, and it was on the 6->7th cast
		--	self.vb.gasSporeCast = 0
		else
			timerGasSporeCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69279 then	-- Gas Spore
		gasSporeTargets[#gasSporeTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnGasSpore:Show()
			specWarnGasSpore:Play("targetyou")
			yellGasSpore:Yell()
		end
		if self.Options.SetIconOnGasSpore then
			local maxIcon = self:IsDifficulty("normal25", "heroic25") and 3 or 2
			self:SetSortedIcon("roster", 0.3, args.destName, 1, maxIcon, false, "AnnounceSporeIcons")
		end
		self:Unschedule(warnGasSporeTargets)
		if #gasSporeTargets >= 3 then
			warnGasSporeTargets()
		else
			self:Schedule(0.3, warnGasSporeTargets)
		end
	elseif args:IsSpellID(69166, 71912) then	-- Inhaled Blight
		local amount = args.amount or 1
		warnInhaledBlight:Show(args.destName, amount)
		if amount >= 3 then
			specWarnInhaled3:Show(amount, args.spellName, args.sourceName)
			specWarnInhaled3:Play("defensive")
			timerPungentBlight:Start()
			timerInhaledBlight:Cancel() -- added due to the "keep" arg
		else	--Prevent timer from starting after 3rd stack since he won't cast it a 4th time, he does Pungent instead.
			timerInhaledBlight:Start()
		end
	elseif args:IsSpellID(72219, 72551, 72552, 72553) then	-- Gastric Bloat
		local amount = args.amount or 1
		warnGastricBloat:Show(args.destName, amount)
		timerGastricBloat:Start(args.destName)
		timerGastricBloatCD:Start()
		if args:IsPlayer() and amount >= 9 then
			specWarnGastricBloat:Show(amount)
			specWarnGastricBloat:Play("stackhigh")
		end
	elseif args.spellId == 19753 then
		self:Schedule(0.02, RemoveDI, self)
	elseif args:IsSpellID(69240, 71218, 73019, 73020) and args:IsDestTypePlayer() then	-- Vile Gas
		vileGasTargets[#vileGasTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnVileGas:Show()
			specWarnVileGas:Play("scatter")
			yellVileGas:Yell()
		end
		self:Unschedule(warnVileGasTargets)
		self:Schedule(0.8, warnVileGasTargets)
	elseif args:IsSpellID(69291, 72101, 72102, 72103) and args:IsDestTypePlayer() then	--Inoculated
		local amount = args.amount or 1
		if self.Options.AchievementCheck and DBM:GetRaidRank() > 0 and not self.vb.warnedfailed and self:AntiSpam(3, 1) then
			if amount == 3 then
				self.vb.warnedfailed = true
				SendChatMessage(L.AchievementFailed:format(args.destName, amount), "RAID_WARNING")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69279 then	-- Gas Spore
		if self.Options.SetIconOnGasSpore then
			self:SetIcon(args.destName, 0)
		end
	end
end


