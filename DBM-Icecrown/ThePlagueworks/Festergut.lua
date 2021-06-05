local mod	= DBM:NewMod("Festergut", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4404 $"):sub(12, -3))
mod:SetCreatureID(36626)
mod:RegisterCombat("combat")
mod:SetUsedIcons(6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnInhaledBlight		= mod:NewStackAnnounce(71912, 3)
local warnGastricBloat		= mod:NewStackAnnounce(72551, 2, nil, true)
local warnGasSpore			= mod:NewTargetAnnounce(69279, 4)
local warnVileGas			= mod:NewTargetAnnounce(73020, 3)
local warnGoo				= mod:NewSpellAnnounce(72549, 4)

local specWarnPungentBlight	= mod:NewSpecialWarningSpell(71219, nil, nil, nil, 2, 2)
local specWarnGasSpore		= mod:NewSpecialWarningYou(69279, nil, nil, nil, 1, 2)
local yellGasSpore			= mod:NewYellMe(69279)
local specWarnVileGas		= mod:NewSpecialWarningYou(71218, nil, nil, nil, 1, 2)
local yellVileGas			= mod:NewYellMe(69240)
local specWarnGastricBloat	= mod:NewSpecialWarningStack(72551, nil, 9, nil, nil, 1, 6)
local specWarnInhaled3		= mod:NewSpecialWarningStack(71912, "Tank", 3, nil, nil, 1, 2)
local specWarnGoo			= mod:NewSpecialWarningDodge(72549, true, nil, nil, 1, 2)

local timerGasSpore			= mod:NewBuffFadesTimer(12, 69279, nil, nil, nil, 3)
local timerVileGas			= mod:NewBuffFadesTimer(6, 71218, nil, "Ranged", nil, 3)
local timerGasSporeCD		= mod:NewNextTimer(40, 69279, nil, nil, nil, 3)		-- Every 40 seconds except after 3rd and 6th cast, then it's 50sec CD
local timerPungentBlight	= mod:NewNextTimer(33, 71219, nil, nil, nil, 2)		-- 33 seconds after 3rd stack of inhaled
local timerInhaledBlight	= mod:NewNextTimer(34, 71912, nil, nil, nil, 6)		-- 34 seconds'ish
local timerGastricBloat		= mod:NewTargetTimer(100, 72551, nil, true, nil, 5, nil, DBM_CORE_TANK_ICON)	-- 100 Seconds until expired
local timerGastricBloatCD	= mod:NewCDTimer(11, 72551, nil, true, nil, 5, nil, DBM_CORE_TANK_ICON) 		-- 10 to 14 seconds
local timerGooCD			= mod:NewNextTimer(10, 72549, nil, nil, nil, 3)

local berserkTimer			= mod:NewBerserkTimer(300)

local soundPungentBlight 	= mod:NewSound5(71219)
local soundSpores			= mod:NewSound(69279)

mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("SetIconOnGasSpore", true)
mod:AddBoolOption("AnnounceSporeIcons", false)
mod:AddBoolOption("AchievementCheck", false, "announce")

local gasSporeTargets	= {}
local gasSporeIconTargets	= {}
local vileGasTargets	= {}
local gasSporeCast 	= 0
local lastGoo = 0
local warnedfailed = false
local gasSporeIcon = 8

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(UnitName(v1)) < DBM:GetRaidSubgroup(UnitName(v2))
	end
	function mod:SetSporeIcons()
		if DBM:GetRaidRank() > 0 then
			table.sort(gasSporeIconTargets, sort_by_group)
			gasSporeIcon = 8
			for i, v in ipairs(gasSporeIconTargets) do
				if self.Options.AnnounceSporeIcons then
					SendChatMessage(L.SporeSet:format(gasSporeIcon, UnitName(v)), "RAID")
				end
				self:SetIcon(UnitName(v), gasSporeIcon, 12)
				gasSporeIcon = gasSporeIcon - 1
			end
			table.wipe(gasSporeIconTargets)
		end
	end
end

local function warnGasSporeTargets()
	warnGasSpore:Show(table.concat(gasSporeTargets, "<, >"))
	soundSpores:Play("Interface\\AddOns\\DBM-Core\\sounds\\Alert.mp3")
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
	timerInhaledBlight:Start(-delay)
	timerGasSporeCD:Start(20-delay)--This may need tweaking
	table.wipe(gasSporeTargets)
	table.wipe(vileGasTargets)
	gasSporeIcon = 8
	gasSporeCast = 0
	lastGoo = 0
	warnedfailed = false
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	if mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25") then
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
		timerInhaledBlight:Start(38)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(72299) and mod:LatencyCheck() then -- Malleable Goo Summon Trigger (10 player normal) (the other 3 spell ids are not needed here since all spells have the same name)
		self:SendSync("Goo")
	end
end

function mod:OnSync(event, arg)
	if event == "Goo" then
		if time() - lastGoo > 5 then
			warnGoo:Show()
			specWarnGoo:Show()
			if mod:IsDifficulty("heroic25") then
				timerGooCD:Start()
			else
				timerGooCD:Start(30)--30 seconds in between goos on 10 man heroic
			end
			lastGoo = time()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(69279) then	-- Gas Spore
		gasSporeTargets[#gasSporeTargets + 1] = args.destName
		gasSporeCast = gasSporeCast + 1
		if (gasSporeCast < 9 and (mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25"))) or (gasSporeCast < 6 and (mod:IsDifficulty("normal10") or mod:IsDifficulty("heroic10"))) then
			timerGasSporeCD:Start()
		elseif (gasSporeCast >= 9 and (mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25"))) or (gasSporeCast >= 6 and (mod:IsDifficulty("normal10") or mod:IsDifficulty("heroic10"))) then
			timerGasSporeCD:Start(50)--Basically, the third time spores are placed on raid, it'll be an extra 10 seconds before he applies first set of spores again.
			gasSporeCast = 0
		end
		if args:IsPlayer() then
			specWarnGasSpore:Show()
			specWarnGasSpore:Play("targetyou")
			yellGasSpore:Yell()
		end
		if self.Options.SetIconOnGasSpore then
			table.insert(gasSporeIconTargets, DBM:GetRaidUnitId(args.destName))
			if ((mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25")) and #gasSporeIconTargets >= 3) or ((mod:IsDifficulty("normal10") or mod:IsDifficulty("heroic10")) and #gasSporeIconTargets >= 2) then
				self:SetSporeIcons()--Sort and fire as early as possible once we have all targets.
			end
		end
		self:Unschedule(warnGasSporeTargets)
		if #gasSporeTargets >= 3 then
			warnGasSporeTargets()
		else
			self:Schedule(0.3, warnGasSporeTargets)
		end
	elseif args:IsSpellID(69166, 71912) then	-- Inhaled Blight
		warnInhaledBlight:Show(args.destName, args.amount or 1)
		if (args.amount or 1) >= 3 then
			specWarnInhaled3:Show(args.amount)
			timerPungentBlight:Start()
			soundPungentBlight:Schedule(33-5)
		end
		if (args.amount or 1) <= 2 then	--Prevent timer from starting after 3rd stack since he won't cast it a 4th time, he does Pungent instead.
			timerInhaledBlight:Start()
		end
	elseif args:IsSpellID(72219, 72551, 72552, 72553) then	-- Gastric Bloat
		warnGastricBloat:Show(args.destName, args.amount or 1)
		timerGastricBloat:Start(args.destName)
		timerGastricBloatCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 9 then
			specWarnGastricBloat:Show(args.amount)
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
	elseif args:IsSpellID(69291, 72101, 72102, 72103) then	--Inoculated
		if args:IsDestTypePlayer() then
			if self.Options.AchievementCheck and DBM:GetRaidRank() > 0 and not warnedfailed then
				if (args.amount or 1) == 3 then
					SendChatMessage(L.AchievementFailed:format(args.destName, (args.amount or 1)), "RAID_WARNING")
					warnedfailed = true
				end
			end
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
