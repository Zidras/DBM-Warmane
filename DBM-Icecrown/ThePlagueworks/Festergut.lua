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
	"SPELL_AURA_APPLIED 69279 69166 71912 72219 72551 72552 72553 69240 71218 73019 73020 69291 72101 72102 72103",
	"SPELL_AURA_APPLIED_DOSE 69166 71912 72219 72551 72552 72553 69291 72101 72102 72103",
	"SPELL_AURA_REMOVED 69279",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
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
local specWarnInhaled3		= mod:NewSpecialWarningStack(69166, "Tank", 3, nil, nil, 1, 2)
local specWarnGoo			= mod:NewSpecialWarningDodge(72297, true, nil, nil, 1, 2) -- Retail has default true for melee but it's more sensible to show for everyone.

local timerGasSpore			= mod:NewBuffFadesTimer(12, 69279, nil, nil, nil, 3)
local timerVileGas			= mod:NewBuffFadesTimer(6, 69240, nil, "Ranged", nil, 3)
local timerGasSporeCD		= mod:NewCDTimer(40.6, 69279, nil, nil, nil, 3, nil, nil, true)	-- REVIEW! ~10s variance [40.6 - 50.3]. Added "keep" arg. (25H Lordaeron [2022-09-14]@[20:34:44] || 25H Lordaeron [2022-09-23]@[21:13:34] || 25N Lordaeron [2023-02-10]@[19:23:53] || 25N Lordaeron [2023-02-14]@[20:56:07] || 10H Icecrown [2023-04-05]@[22:46:14] || 25H Lordaeron [2023-04-07]@[19:35:55) - "Gas Spore-71221-npc:36626-1002 = pull:24.1, 42.9, 41.9, 45.9, 44.7 || "Gas Spore-71221-npc:36626-1507 = pull:24.9, 43.6, 41.5, 42.0, 41.9" || "Gas Spore-71221-npc:36626-1086 = pull:21.5, 43.9, 41.9, 43.0, 41.2, 43.5 || "Gas Spore-71221-npc:36626-1575 = pull:21.1, 44.1, 40.6, 48.7, 43.2, 44.1 || "Gas Spore-69278-npc:36626-852 = pull:20.1, 46.1, 41.2" || "Gas Spore-71221-npc:36626-1098 = pull:20.3, 43.1, 43.3, 43.6, 43.3, 43.1, 50.3"
local timerPungentBlight	= mod:NewCDTimer(33.5, 69195, nil, nil, nil, 2)		-- Edited. ~34 seconds after 3rd stack of inhaled. REVIEW! (25H Lordaeron 2022/09/25) - pull:131.4 [33.5]
local timerInhaledBlight	= mod:NewCDTimer(33.5, 69166, nil, nil, nil, 6, nil, nil, true)	-- Timer is based on Aura. ~9s variance on pull, 1.5s variance [33.5-35.0]. Added "keep" arg (25H Lordaeron 2022/09/04 || 25H Lordaeron 2022/09/25) - 34.2, 34.7, *, 34.2 || 34.3, 33.8, 67.5 [33.5-pungent, 34.0], 34.2
local timerGastricBloat		= mod:NewTargetTimer(100, 72219, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)	-- 100 Seconds until expired
local timerGastricBloatCD	= mod:NewCDTimer(13.1, 72219, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON) -- REVIEW! ~3s variance [13.1 - 16.2]. (25H Lordaeron [2023-04-07]@[19:29:03] || 25H Icecrown [2023-05-28]@[16:21:49]) - "Gastric Bloat-72553-npc:36626-1098 = pull:13.8, 13.1, 13.5, 13.1, 13.2, 14.0, 13.8, 13.4, 13.2, 13.9, 13.4, 13.8 || "Gastric Bloat-72553-npc:36626-752 = pull:13.6, 16.2, 13.4, 13.1, 13.4, 13.3, 14.3, 13.4, 13.1, 14.1, 13.1, 14.8, 13.1
local timerGooCD			= mod:NewCDTimer(10, 72297, nil, nil, nil, 3)

local berserkTimer			= mod:NewBerserkTimer(300)

mod:AddRangeFrameOption(10, 69240, "Ranged")
mod:AddSetIconOption("SetIconOnGasSpore", 69279, true, 7, {1, 2, 3})
mod:AddBoolOption("AnnounceSporeIcons", false, nil, nil, nil, nil, 69279)
mod:AddBoolOption("AchievementCheck", false, "announce", nil, nil, nil, 4615, "achievement")

local gasSporeTargets = {}
local vileGasTargets = {}
mod.vb.gasSporeCast = 0
mod.vb.warnedfailed = false

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
	timerInhaledBlight:Start(28.9-delay) -- ~5s variance [28.9-34.0] (25H Lordaeron 2022/09/04 || 25H Lordaeron 2022/09/25 || 25H Lordaeron [2022-11-16]@[22:30:46] || 10H Lordearon [2023-04-05]@[22:46:14] || 25H Lordaeron [2023-06-27]@[20:34:49] || 25H Lordaeron [2023-08-23]@[20:39:56]) - pull:32.0 || pull:32.9 || pull:28.9 || pull:30.6 || pull:34.0 || pull:30.7
	timerGasSporeCD:Start(20-delay) -- ~5s variance [20.1 - 24.9]. Added "keep" arg. (25H Lordaeron [2022-09-14]@[20:34:44] || 25H Lordaeron [2022-09-23]@[21:13:34] || 25N Lordaeron [2023-02-10]@[19:23:53] || 25N Lordaeron [2023-02-14]@[20:56:07] || 10H Icecrown [2023-04-05]@[22:46:14] || 25H Lordaeron [2023-04-07]@[19:35:55) - pull:24.1 || pull:24.9 || pull:21.5 || pull:21.1|| pull:20.1|| pull:20.3
	timerGastricBloatCD:Start(-delay)
	table.wipe(gasSporeTargets)
	table.wipe(vileGasTargets)
	self.vb.gasSporeCast = 0
	self.vb.warnedfailed = false
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10) -- 9.6y is the shortest distance that it doesn't spread (TC test 12/03/2023); set to 10 for safety
	end
	if self:IsHeroic() then
		timerGooCD:Start(13-delay)
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
			specWarnInhaled3:Show(amount)
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

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(72299) then -- Malleable Goo Summon Trigger (10 player normal) (the other 3 spell ids are not needed here since all spells have the same name)
		DBM:AddMsg("Malleable Goo Summon Trigger UNIT_SPELLCAST_SUCCEEDED unhidden from combat log. Notify Zidras on Discord or GitHub")
		specWarnGoo:Show()
		specWarnGoo:Play("watchstep")
		if self:IsDifficulty("heroic25") then
			timerGooCD:Start()
		else
			timerGooCD:Start(15)--30 seconds in between goos on 10 man heroic
		end
	elseif spellName == GetSpellInfo(73032) then -- Pungent Blight
		timerInhaledBlight:Start()
	end
end
