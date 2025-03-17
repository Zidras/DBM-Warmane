local mod	= DBM:NewMod("Akama", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250228000000")
mod:SetCreatureID(22841, 23191, 23215, 23216, 23523, 23318, 23524, 23319)

mod:SetModelID(21357)

mod:RegisterCombat("combat")
mod:SetWipeTime(50)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 34189",
	"SPELL_AURA_REMOVED 34189",
	"SPELL_SUMMON 42035 40476 40474",
	"SPELL_CAST_SUCCESS 40607", -- SPELL_FIXATE
	"UNIT_DIED"
)

local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnDefender		= mod:NewAnnounce("warnAshtongueDefender", 2, 41180)
local warnSorc			= mod:NewAnnounce("warnAshtongueSorcerer", 2, 40520)

local specWarnAdds		= mod:NewSpecialWarningAddsCustom(42035, "-Healer", nil, nil, 1, 2)

local timerCombatStart	= mod:NewCombatTimer(12)
local timerAddsCD		= mod:NewAddsCustomTimer(55, 42035)
local timerDefenderCD	= mod:NewTimer(35, "timerAshtongueDefender", 41180, nil, nil, 1)
local timerSorcCD		= mod:NewTimer(32.5, "timerAshtongueSorcerer", 40520, nil, nil, 1)

mod.vb.spawnCounter = 0
mod.vb.maxSpawns = 20 -- Match the COUNTER_SPAWNS_MAX in server script

local function addsWestLoop(self)
	if self.vb.spawnCounter < self.vb.maxSpawns then
		specWarnAdds:Show(DBM_COMMON_L.WEST)
		specWarnAdds:Play("killmob")
		specWarnAdds:ScheduleVoice(1, "west")
		self:Schedule(55, addsWestLoop, self) -- 50-60s in server script
		timerAddsCD:Start(55, DBM_COMMON_L.WEST)
	end
end

local function addsEastLoop(self)
	if self.vb.spawnCounter < self.vb.maxSpawns then
		specWarnAdds:Show(DBM_COMMON_L.EAST)
		specWarnAdds:Play("killmob")
		specWarnAdds:ScheduleVoice(1, "east")
		self:Schedule(55, addsEastLoop, self) -- 50-60s in server script
		timerAddsCD:Start(55, DBM_COMMON_L.EAST)
	end
end

local function sorcLoop(self)
	if self.vb.spawnCounter < self.vb.maxSpawns then
		warnSorc:Show()
		self:Schedule(32.5, sorcLoop, self) -- 30-35s in server script
		timerSorcCD:Start(32.5)
	end
end

local function defenderLoop(self)
	if self.vb.spawnCounter < self.vb.maxSpawns then
		warnDefender:Show()
		self:Schedule(35, defenderLoop, self) -- 30-40s in server script
		timerDefenderCD:Start(35)
	end
end

function mod:OnCombatStart()
	self.vb.spawnCounter = 0
	self:SetStage(1)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	self:Unschedule(addsWestLoop)
	self:Unschedule(addsEastLoop)
	self:Unschedule(sorcLoop)
	self:Unschedule(defenderLoop)
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 34189 and args:GetDestCreatureID() == 23191 then -- Akama coming out of stealth
		timerCombatStart:Start()
		
		-- Start timers to match the server script
		-- Server starts Right side (Y > 400.0f) after 10s
		-- Server starts Left side (Y < 400.0f) after 3s
		self:Schedule(10, defenderLoop, self) -- Right side defender
		self:Schedule(3, sorcLoop, self) -- Left side sorcerer
		self:Schedule(10, addsWestLoop, self) -- Right side wave
		self:Schedule(3, addsEastLoop, self) -- Left side wave
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 42035 or spellId == 40476 or spellId == 40474 then
		self.vb.spawnCounter = self.vb.spawnCounter + 1
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 40607 and self.vb.phase == 1 then -- SPELL_FIXATE (when Shade engages Akama)
		self:SetStage(2)
		warnPhase2:Show()
		timerAddsCD:Stop()
		timerDefenderCD:Stop()
		timerSorcCD:Stop()
		self:Unschedule(addsWestLoop)
		self:Unschedule(addsEastLoop)
		self:Unschedule(sorcLoop)
		self:Unschedule(defenderLoop)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 22841 then -- Shade of Akama dies
		DBM:EndCombat(self)
	elseif cid == 23215 or cid == 23216 or cid == 23523 or cid == 23318 or cid == 23524 then
		-- When any add dies, decrement counter
		self.vb.spawnCounter = self.vb.spawnCounter - 1
		if self.vb.spawnCounter < 0 then self.vb.spawnCounter = 0 end
	end
end