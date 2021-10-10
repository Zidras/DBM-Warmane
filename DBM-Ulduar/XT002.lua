local mod	= DBM:NewMod("XT002", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4154 $"):sub(12, -3))
mod:SetCreatureID(33293)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)

local warnLightBomb					= mod:NewTargetAnnounce(65121, 3)
local warnGravityBomb				= mod:NewTargetAnnounce(64234, 3)

local specWarnLightBomb				= mod:NewSpecialWarningYou(65121)
local specWarnGravityBomb			= mod:NewSpecialWarningYou(64234)
local specWarnConsumption			= mod:NewSpecialWarningMove(64206)--Hard mode void zone dropped by Gravity Bomb

local enrageTimer					= mod:NewBerserkTimer(360)
local timerTympanicTantrumCast		= mod:NewCastTimer(62776)
local timerTympanicTantrum			= mod:NewBuffActiveTimer(8, 62776)
local timerTympanicTantrumCD		= mod:NewCDTimer(60, 62776, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON, nil, 3)
local timerHeart					= mod:NewCastTimer(30, 63849)
local timerLightBomb				= mod:NewTargetTimer(9, 65121)
local timerGravityBomb				= mod:NewTargetTimer(9, 64234)
local timerAchieve					= mod:NewAchievementTimer(205, 2937, "TimerSpeedKill")

mod:AddBoolOption("SetIconOnLightBombTarget", true)
mod:AddBoolOption("SetIconOnGravityBombTarget", true)
mod:AddBoolOption("RangeFrame", true)

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerAchieve:Start()
	if mod:IsDifficulty("heroic10") then
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
	if args:IsSpellID(62776) then					-- Tympanic Tantrum (aoe damge + daze)
		timerTympanicTantrumCast:Start()
		timerTympanicTantrumCD:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62775) and args.auraType == "DEBUFF" then	-- Tympanic Tantrum
		timerTympanicTantrumCD:Start()
		timerTympanicTantrum:Start()

	elseif args:IsSpellID(63018, 65121) then 	-- Light Bomb
		if args:IsPlayer() then
			specWarnLightBomb:Show()
		end
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 7, 9)
		end
		warnLightBomb:Show(args.destName)
		timerLightBomb:Start(args.destName)
	elseif args:IsSpellID(63024, 64234) then		-- Gravity Bomb
		if args:IsPlayer() then
			specWarnGravityBomb:Show()
		end
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 8, 9)
		end
		warnGravityBomb:Show(args.destName)
		timerGravityBomb:Start(args.destName)
	elseif args:IsSpellID(63849) then
		timerTympanicTantrumCD:Stop()
		timerHeart:Start()
		timerTympanicTantrumCD:Start(65) -- maybe?
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(63018, 65121) then 	-- Light Bomb
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(63024, 64234) then		-- Gravity Bomb
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if (spellId == 64208 or spellId == 64206) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnConsumption:Show()
		specWarnConsumption:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE