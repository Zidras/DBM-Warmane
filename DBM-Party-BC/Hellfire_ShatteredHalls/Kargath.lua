local mod	= DBM:NewMod(569, "DBM-Party-BC", 3, 259)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(16808)

mod:SetModelID(19799)
mod:SetModelOffset(-0.4, 0.1, -0.4)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_SPELLCAST_START"
)

--134170 Some Random Orc Icon. Could not find red fel orc icon. Only green orcs or brown orcs. Brown closer to red than green is.
local warnHeathenGuard			= mod:NewAnnounce("warnHeathen", 2, 134170)
local warnReaverGuard			= mod:NewAnnounce("warnReaver", 2, 134170)
local warnSharpShooterGuard		= mod:NewAnnounce("warnSharpShooter", 2, 134170)

local specWarnBladeDance		= mod:NewSpecialWarningSpell(30739, nil, nil, nil, 2, 2)

local timerHeathenCD			= mod:NewTimer(21, "timerHeathen", 134170, nil, nil, 1)
local timerReaverCD				= mod:NewTimer(21, "timerReaver", 134170, nil, nil, 1)
local timerSharpShooterCD		= mod:NewTimer(21, "timerSharpShooter", 134170, nil, nil, 1)
local timerBladeDanceCD			= mod:NewCDTimer(35, 30739, nil, nil, nil, 2)

mod.vb.addSet = 0
mod.vb.addType = 0

local function Adds(self)
	self.vb.addSet = self.vb.addSet + 1
	self.vb.addType = self.vb.addType + 1
	if self.vb.addType == 1 then--Heathen
		warnHeathenGuard:Show(self.vb.addSet.."-"..self.vb.addType)
		timerReaverCD:Start()
	elseif self.vb.addType == 2 then--Reaver
		warnReaverGuard:Show(self.vb.addSet.."-"..self.vb.addType)
		timerSharpShooterCD:Start()
	elseif self.vb.addType == 3 then--SharpShooter
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
	self:Schedule(27.5, Adds, self)--When reaches stairs, not when enters/spawns way down hallway.
	timerBladeDanceCD:Start(72-delay)
end

--Change to no sync if blizz adds IEEU(boss1)
function mod:UNIT_SPELLCAST_START(uId, _, spellId)
   if spellId == 30738 then -- Blade Dance Targeting
		self:SendSync("BladeDance")
	end
end

function mod:OnSync(msg)
	if msg == "BladeDance" and self:AntiSpam(3, 1) then
		specWarnBladeDance:Show()
		timerBladeDanceCD:Start()
		specWarnBladeDance:Play("aesoon")
	end
end
