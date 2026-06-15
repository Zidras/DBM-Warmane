local mod	= DBM:NewMod("Ignis", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221011211626")
mod:SetCreatureID(33118)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 62680 63472 62488",
	"SPELL_CAST_SUCCESS 62548 63474",
	"SPELL_AURA_APPLIED 62717 63477 62382",
	"SPELL_AURA_REMOVED 62717 63477"
)

local warnSlagPot				= mod:NewTargetNoFilterAnnounce(63477, 3)
local warnConstruct				= mod:NewCountAnnounce(62488, 2)

local specWarnFlameJetsCast		= mod:NewSpecialWarningCast(63472, "SpellCaster", nil, nil, 2, 2)
local specWarnFlameBrittle		= mod:NewSpecialWarningSwitch(62382, "Dps", nil, nil, 1, 2)

local timerFlameJetsCast		= mod:NewCastTimer(2.7, 63472, nil, nil, nil, 5, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerFlameJetsCooldown	= mod:NewCDTimer(45.1, 63472, nil, nil, nil, 2, nil, DBM_COMMON_L.IMPORTANT_ICON, true) -- 10/25 diff. ~3s variance. Transcriptor snippet below. Added "keep" arg
local timerActivateConstruct	= mod:NewCDCountTimer(30, 62488, nil, nil, nil, 1, nil, nil, true) -- 10/25 diff. ~6s variance. Transcriptor snippet below. Added "keep" arg
local timerScorchCast			= mod:NewCastTimer(3, 63473)
local timerScorchCooldown		= mod:NewCDTimer(31, 63473, nil, nil, nil, 5) -- 10/25 diff. ~1s variance. Transcriptor snippet below
local timerSlagPot				= mod:NewTargetTimer(10, 63477, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerAchieve				= mod:NewAchievementTimer(240, 2930)

local soundAuraMastery			= mod:NewSound(63472, "soundConcAuraMastery")

mod:AddSetIconOption("SlagPotIcon", 63477, false, false, {8})

mod.vb.ConstructCount = 0

local function isBuffOwner(uId, spellId)
	if not uId and not spellId then return end
	local _, _, _, _, _, _, _, unitCaster = DBM:UnitBuff(uId, spellId)
	if unitCaster == uId then
		return true
	else
		return false
	end
end

function mod:OnCombatStart(delay)
	self.vb.ConstructCount = 0
	timerAchieve:Start()
	timerActivateConstruct:Start(15-delay, 1) -- REVIEW! variance? (10m Frostmourne 2022/07/17 || 25m Lordaeron 2022/10/05 || 25m Lordaeron 2022/10/09) - 15.0 || 15.0 || 15.0
	timerScorchCooldown:Start(25-delay) -- (10m Frostmourne 2022/07/17 || 25m Lordaeron 2022/10/05 || 25m Lordaeron 2022/10/09) - 25.0 || 25.0 || 25.0
	timerFlameJetsCooldown:Start(30-delay) -- 25 man log review (2022/07/10)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62680, 63472) then		-- Flame Jets
		timerFlameJetsCast:Start()
		specWarnFlameJetsCast:Show()
		if self.Options.soundConcAuraMastery and isBuffOwner("player", 19746) then -- Concentration Aura Mastery by a Paladin will negate the interrupt effect of Flame Jets
			soundAuraMastery:Play("Interface\\AddOns\\DBM-Core\\sounds\\PlayerAbilities\\AuraMastery.ogg")
		else
			specWarnFlameJetsCast:Play("stopcast")
		end
		timerFlameJetsCooldown:Start(self:IsDifficulty("normal10") and 41.5 or 45.1) -- 10/25 different. ~5s variance (25 man log review 2022/07/10 || 10m Frostmourne 2022/07/17 || 25m Lordaeron 2022/10/05 || 25m Lordaeron 2022/10/09) - 45.1, 47.0 || 43.5, 41.5, 45.9, 41.9 || 47.2, 45.8, 47.0 || 48.9, 46.6
	elseif args.spellId == 62488 then		-- Activate Construct
		self.vb.ConstructCount = self.vb.ConstructCount + 1
		warnConstruct:Show(self.vb.ConstructCount)
		if self.vb.ConstructCount < 20 then
			timerActivateConstruct:Start(self:IsDifficulty("normal10") and 43 or 33, self.vb.ConstructCount+1) -- 10/25 different. ~6s variance (25 man log review 2022/07/10 || 10m Frostmourne 2022/07/17 || 25m Lordaeron 2022/10/05 || 25m Lordaeron 2022/10/09) - 33.5, 38.5, 37.8 || 43.1, 46.0, 43.0, 46.0, 43.0 || 33.0, 39.1, 38.7, 39.0 || 33.0, 39.0, 36.0, 39.0
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(62548, 63474) then	-- Scorch
		timerScorchCast:Start()
		timerScorchCooldown:Start(self:IsDifficulty("normal10") and 28 or 31) -- 10/25 different. ~1s variance (25 man log review 2022/07/10 || 10m Frostmourne 2022/07/17 || 25m Lordaeron 2022/10/05 || 25m Lordaeron 2022/10/09) - 31.0, 32.0, 31.0 || 28.0, 28.1, 28.1, 28.0, 28.0, 29.0, 28.0 || 31.0, 32.1, 31.1, 31.0, 31.0 || 31.0, 32.0, 31.0, 31.1
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62717, 63477) then		-- Slag Pot
		warnSlagPot:Show(args.destName)
		timerSlagPot:Start(args.destName)
		if self.Options.SlagPotIcon then
			self:SetIcon(args.destName, 8, 10)
		end
	elseif args.spellId == 62382 and self:AntiSpam(5, 1) then
		specWarnFlameBrittle:Show()
		specWarnFlameBrittle:Play("killmob")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(62717, 63477) then		-- Slag Pot
		if self.Options.SlagPotIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end
