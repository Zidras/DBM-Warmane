local mod	= DBM:NewMod("Ignis", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4133 $"):sub(12, -3))
mod:SetCreatureID(33118)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 62680 63472 62488",
	"SPELL_CAST_SUCCESS 62548 63474",
	"SPELL_AURA_APPLIED 62717 63477 62382",
	"SPELL_AURA_REMOVED 62717 63477"
)

local announceSlagPot			= mod:NewTargetNoFilterAnnounce(63477, 3)
local announceConstruct			= mod:NewCountAnnounce(62488, 2)

local warnFlameJetsCast			= mod:NewSpecialWarningCast(63472, "SpellCaster", nil, nil, 2, 2)
local warnFlameBrittle			= mod:NewSpecialWarningSwitch(62382, "Dps", nil, nil, 1, 2)

local timerFlameJetsCast		= mod:NewCastTimer(2.7, 63472)
local timerActivateConstruct	= mod:NewCDCountTimer(30, 62488, nil, nil, nil, 1)
local timerFlameJetsCooldown	= mod:NewCDTimer(42, 63472, nil, nil, nil, 2)
local timerScorchCooldown		= mod:NewCDTimer(25, 63473, nil, nil, nil, 5)
local timerScorchCast			= mod:NewCastTimer(3, 63473)
local timerSlagPot				= mod:NewTargetTimer(10, 63477, nil, nil, nil, 3)
local timerAchieve				= mod:NewAchievementTimer(240, 2930)

mod.vb.ConstructCount = 0

mod:AddSetIconOption("SlagPotIcon", 63477, false, false, {8})

function mod:OnCombatStart(delay)
	self.vb.ConstructCount = 0
	timerAchieve:Start()
	if self:IsDifficulty("normal10") then
		timerActivateConstruct:Start(40-delay, self.vb.ConstructCount)
	else
		timerActivateConstruct:Start(-delay, self.vb.ConstructCount)
	end
	timerScorchCooldown:Start(12-delay)
	timerFlameJetsCooldown:Start(29)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62680, 63472) then		-- Flame Jets
		timerFlameJetsCast:Start()
		warnFlameJetsCast:Show()
		warnFlameJetsCast:Play("stopcast")
		timerFlameJetsCooldown:Start()
	elseif args.spellId == 62488 then		-- Activate Construct
		self.vb.ConstructCount = self.vb.ConstructCount + 1
		announceConstruct:Show(self.vb.ConstructCount)
		if self.vb.ConstructCount < 20 then
			timerActivateConstruct:Start(self:IsDifficulty("normal10") and 40 or 30, self.vb.ConstructCount)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(62548, 63474) then	-- Scorch
		timerScorchCast:Start()
		timerScorchCooldown:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62717, 63477) then		-- Slag Pot
		announceSlagPot:Show(args.destName)
		timerSlagPot:Start(args.destName)
		if self.Options.SlagPotIcon then
			self:SetIcon(args.destName, 8, 10)
		end
	elseif args.spellId == 62382 and self:AntiSpam(5, 1) then
		warnFlameBrittle:Show()
		warnFlameBrittle:Play("killmob")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(62717, 63477) then		-- Slag Pot
		if self.Options.SlagPotIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end