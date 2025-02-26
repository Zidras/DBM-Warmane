local mod	= DBM:NewMod(569, "DBM-Party-BC", 3, 259)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20250224151524")
mod:SetCreatureID(16808)

mod:SetModelID(19799)
mod:SetModelOffset(-0.4, 0.1, -0.4)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 30739 35429"
)

--134170 Some Random Orc Icon. Could not find red fel orc icon. Only green orcs or brown orcs. Brown closer to red than green is.
local warnHeathenGuard			= mod:NewAnnounce("warnHeathen", 2, "Interface\\Icons\\Inv_Misc_Head_Orc_01")
local warnReaverGuard			= mod:NewAnnounce("warnReaver", 2, "Interface\\Icons\\Inv_Misc_Head_Orc_01")
local warnSharpShooterGuard		= mod:NewAnnounce("warnSharpShooter", 2, "Interface\\Icons\\Inv_Misc_Head_Orc_01")

local specWarnBladeDance		= mod:NewSpecialWarningSpell(30739, nil, nil, nil, 2, 2)
local specWarnSweepingStrikes	= mod:NewSpecialWarningSpell(35429, nil, nil, nil, 1, 2)

local timerHeathenCD			= mod:NewTimer(21, "timerHeathen", "Interface\\Icons\\Inv_Misc_Head_Orc_01", nil, nil, 1)
local timerReaverCD				= mod:NewTimer(21, "timerReaver", "Interface\\Icons\\Inv_Misc_Head_Orc_01", nil, nil, 1)
local timerSharpShooterCD		= mod:NewTimer(21, "timerSharpShooter", "Interface\\Icons\\Inv_Misc_Head_Orc_01", nil, nil, 1)
local timerBladeDanceCD			= mod:NewCDTimer(31, 30739, nil, nil, nil, 2, nil, nil, true)
local timerSweepingStrikesCD	= mod:NewVarTimer("v22-24.5", 35429, nil, nil, nil, 5, nil, nil, true)

mod.vb.addSet = 0
mod.vb.addType = 0

local function Adds(self)
	self.vb.addSet = self.vb.addSet + 1
	self.vb.addType = self.vb.addType + 1
	if self.vb.addType == 1 then -- Heathen
		warnHeathenGuard:Show(self.vb.addSet.."-"..self.vb.addType)
		timerReaverCD:Start()
	elseif self.vb.addType == 2 then -- Reaver
		warnReaverGuard:Show(self.vb.addSet.."-"..self.vb.addType)
		timerSharpShooterCD:Start()
	elseif self.vb.addType == 3 then -- SharpShooter
		warnSharpShooterGuard:Show(self.vb.addSet.."-"..self.vb.addType)
		timerHeathenCD:Start()
		self.vb.addType = 0
	end
	self:Schedule(21, Adds, self)
end

function mod:OnCombatStart(delay)
	self.vb.addSet = 0
	self.vb.addType = 0
	timerHeathenCD:Start(27.5-delay)
	self:Schedule(27.5, Adds, self) -- When reaches stairs, not when enters/spawns way down hallway.
	timerBladeDanceCD:Start(29-delay)
	timerSweepingStrikesCD:Start(11-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 30739 and self:AntiSpam(3, 1) then -- Blade Dance
		specWarnBladeDance:Show()
		timerBladeDanceCD:Start()
		specWarnBladeDance:Play("aesoon")
	elseif args.spellId == 35429 then -- Sweeping Strikes
		specWarnSweepingStrikes:Show()
		timerSweepingStrikesCD:Start()
	end
end
