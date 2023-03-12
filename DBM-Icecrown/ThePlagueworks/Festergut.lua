local mod	= DBM:NewMod("Festergut", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230312134131")
mod:SetCreatureID(36626)
mod:RegisterCombat("combat")
mod:SetUsedIcons(1, 2, 3)
mod:SetHotfixNoticeRev(20230312000000)
mod:SetMinSyncRevision(20230312000000)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 69195 71219 73031 73032",
	"SPELL_AURA_APPLIED 69279 69166 71912 72219 72551 72552 72553 69240 71218 73019 73020 69291 72101 72102 72103",
	"SPELL_AURA_APPLIED_DOSE 69166 71912 72219 72551 72552 72553 69291 72101 72102 72103",
	"SPELL_AURA_REMOVED 69279",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, use actual cast event for handling gasSporeCast to make it robust against under sized groups/retail soloing. Should be counting actual casts not debuff counts
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
local timerGasSporeCD		= mod:NewNextTimer(40, 69279, nil, nil, nil, 3)		-- Every 40 seconds except after 3rd and 6th cast, then it's 50sec CD
local timerPungentBlight	= mod:NewCDTimer(33.5, 69195, nil, nil, nil, 2)		-- Edited. ~34 seconds after 3rd stack of inhaled. REVIEW! (25H Lordaeron 2022/09/25) - pull:131.4 [33.5]
local timerInhaledBlight	= mod:NewCDTimer(33.8, 69166, nil, nil, nil, 6)	-- Timer is based on Aura. ~1s variance? (25H Lordaeron 2022/09/04 || 25H Lordaeron 2022/09/25) - 34.2, 34.7, *, 34.2 || 34.3, 33.8, 67.5 [33.5-pungent, 34.0], 34.2
local timerGastricBloat		= mod:NewTargetTimer(100, 72219, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)	-- 100 Seconds until expired
local timerGastricBloatCD	= mod:NewCDTimer(12, 72219, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)		-- 10 to 14 seconds
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
	timerInhaledBlight:Start(32.0-delay) -- REVIEW! ~1s variance? (25H Lordaeron 2022/09/04 || 25H Lordaeron 2022/09/25) - pull:32.0 || pull:32.9
	timerGasSporeCD:Start(20-delay)--This may need tweaking
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

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69279 then	-- Gas Spore
		gasSporeTargets[#gasSporeTargets + 1] = args.destName
		self.vb.gasSporeCast = self.vb.gasSporeCast + 1
		--25 man is 3 sets of 3 and 10 man is 3 sets of 2, totalling 9 and 6 respectively
		if (self.vb.gasSporeCast < 9 and self:IsDifficulty("normal25", "heroic25")) or (self.vb.gasSporeCast < 6 and self:IsDifficulty("normal10", "heroic10")) then
			timerGasSporeCD:Restart()
		elseif (self.vb.gasSporeCast >= 9 and self:IsDifficulty("normal25", "heroic25")) or (self.vb.gasSporeCast >= 6 and self:IsDifficulty("normal10", "heroic10")) then
			timerGasSporeCD:Restart(50)--Basically, the third time spores are placed on raid, it'll be an extra 10 seconds before he applies first set of spores again.
			self.vb.gasSporeCast = 0
		end
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
--		else	--Prevent timer from starting after 3rd stack since he won't cast it a 4th time, he does Pungent instead.
--			timerInhaledBlight:Start()
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