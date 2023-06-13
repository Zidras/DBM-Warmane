local mod	= DBM:NewMod("XT002", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221010223308")
mod:SetCreatureID(33293)
mod:SetUsedIcons(1, 2)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 62776",
	"SPELL_AURA_APPLIED 62775 63018 65121 63024 64234 63849",
	"SPELL_AURA_REMOVED 63018 65121 63024 64234 63849",
	"SPELL_DAMAGE 64208 64206",
	"SPELL_MISSED 64208 64206"
)

-- General
local enrageTimer					= mod:NewBerserkTimer(600)
local timerAchieve					= mod:NewAchievementTimer(205, 2937)

mod:AddRangeFrameOption(12, nil, true)

-- Stage One
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1))
local warnLightBomb					= mod:NewTargetNoFilterAnnounce(65121, 3)
local warnGravityBomb				= mod:NewTargetNoFilterAnnounce(64234, 3)

local specWarnTympanicTantrum		= mod:NewSpecialWarningSpell(62776, nil, nil, nil, 1, 2)
local specWarnLightBomb				= mod:NewSpecialWarningMoveAway(65121, nil, nil, nil, 1, 2)
local yellLightBomb					= mod:NewYell(65121)
local specWarnGravityBomb			= mod:NewSpecialWarningMoveAway(64234, nil, nil, nil, 1, 2)
local yellGravityBomb				= mod:NewYell(64234)

local timerTympanicTantrumCast		= mod:NewCastTimer(62776)
local timerTympanicTantrum			= mod:NewBuffActiveTimer(8, 62776, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerTympanicTantrumCD		= mod:NewCDTimer(60, 62776, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON, nil, 3) -- S3 FM Log review 2022/07/17 - " Tympanic Tantrum-62776-npc:33293 = pull:60.0/Stage 1/60.0, Stage 2/6.6, Stage 1/29.0, 35.9/64.9/71.5, 60.0, 60.0, 60.0, 60.1, 60.0", -- [1]

local timerLightBomb				= mod:NewTargetTimer(9, 65121, nil, nil, nil, 3)
local timerGravityBomb				= mod:NewTargetTimer(9, 64234, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnLightBombTarget", 65121, true, true, {1})
mod:AddSetIconOption("SetIconOnGravityBombTarget", 64234, true, true, {2})

-- Stage Two
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2))
local timerHeart					= mod:NewCastTimer(30, 63849, nil, nil, nil, 6, nil, DBM_COMMON_L.DAMAGE_ICON)

-- Hard Mode
mod:AddTimerLine(DBM_COMMON_L.HEROIC_ICON..DBM_CORE_L.HARD_MODE)
local specWarnConsumption			= mod:NewSpecialWarningGTFO(64206, nil, nil, nil, 1, 8)--Hard mode void zone dropped by Gravity Bomb

function mod:OnCombatStart(delay)
	self:SetStage(1)
	enrageTimer:Start(-delay)
	timerAchieve:Start()
	if self:IsDifficulty("normal10") then -- REVIEW. No log yet to validate this.
		timerTympanicTantrumCD:Start(35-delay)
	else
		timerTympanicTantrumCD:Start(60-delay)
	end
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
	if args.spellId == 62776 then					-- Tympanic Tantrum (aoe damage + daze)
		specWarnTympanicTantrum:Show()
		specWarnTympanicTantrum:Play("aesoon")
		timerTympanicTantrumCast:Start()
		timerTympanicTantrumCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62775 and args.auraType == "DEBUFF" then	-- Tympanic Tantrum
		timerTympanicTantrum:Start()
	elseif args:IsSpellID(63018, 65121) then	-- Light Bomb
		if args:IsPlayer() then
			specWarnLightBomb:Show()
			specWarnLightBomb:Play("runout")
			yellLightBomb:Yell()
		end
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 1)
		end
		warnLightBomb:Show(args.destName)
		timerLightBomb:Start(args.destName)
	elseif args:IsSpellID(63024, 64234) then		-- Gravity Bomb
		if args:IsPlayer() then
			specWarnGravityBomb:Show()
			specWarnGravityBomb:Play("runout")
			yellGravityBomb:Yell()
		end
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 2)
		end
		warnGravityBomb:Show(args.destName)
		timerGravityBomb:Start(args.destName)
	elseif spellId == 63849 then	-- Exposed Heart
		self:SetStage(2)
		timerTympanicTantrumCD:Stop()
		timerTympanicTantrum:Stop()
		timerHeart:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(63018, 65121) then	-- Light Bomb
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(63024, 64234) then	-- Gravity Bomb
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 63849 then	-- Exposed Heart
		self:SetStage(1)
		timerHeart:Stop()
		timerTympanicTantrumCD:Start(35.6) -- REVIEW! Variance? (S3 FM Log review 2022/07/17 || 25m Lordearon 2022/10/10) -- 35.9 || 35.6
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if (spellId == 64208 or spellId == 64206) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnConsumption:Show()
		specWarnConsumption:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
