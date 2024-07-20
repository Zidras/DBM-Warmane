local mod	= DBM:NewMod("Gothik-Vanilla", "DBM-VanillaNaxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240715112650")
mod:SetCreatureID(16060)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, sync infoframe from classic era version?
--(source.type = "NPC" and source.firstSeen = timestamp) or (target.type = "NPC" and target.firstSeen = timestamp)
local warnWaveNow		= mod:NewAnnounce("WarningWaveSpawned", 3, nil, false)
local warnWaveSoon		= mod:NewAnnounce("WarningWaveSoon", 2)
local warnRiderDown		= mod:NewAnnounce("WarningRiderDown", 4)
local warnKnightDown	= mod:NewAnnounce("WarningKnightDown", 2)
local warnPhase2		= mod:NewPhaseAnnounce(2, 3)

local timerPhase2		= mod:NewTimer(275, "TimerPhase2", 27082, nil, nil, 6)
local timerWave			= mod:NewTimer(30, "TimerWave", 5502, nil, nil, 1)
local timerGate			= mod:NewTimer(235, "Gate Opens", 9484)

mod.vb.wave = 0
local waves = {					-- #0 0:45
	{3, L.Trainee, timer = 20},	-- #1 1:15
	{3, L.Trainee, timer = 20},	-- #2 1:35?
	{3, L.Trainee, timer = 10}, -- #3 1:55
	{2, L.Knight, timer = 10},	-- #4 2:05
	{3, L.Trainee, timer = 15},	-- #5 2:15
	{2, L.Knight, timer = 5},	-- #6 2:30
	{3, L.Trainee, timer = 20},	-- #7 2:35
	{3, L.Trainee, 2, L.Knight, timer = 10}, -- #8 2:55
	{1, L.Rider, timer = 10},	-- #9 3:05
	{3, L.Trainee, timer = 5},	-- #10 3:15
	{2, L.Knight, timer = 15},	-- #11 3:20
	{1, L.Rider, 3, L.Trainee, timer = 10},	-- #12 3:35
	{2, L.Knight, timer = 10},	-- #13 3:45
	{3, L.Trainee, timer = 10},	-- #14 3:55
	{1, L.Rider, timer = 5},	-- #15 4:05
	{2, L.Knight, timer = 5},	-- #16 4:10
	{3, L.Trainee},				-- #17 4:15
}								-- Gate Open 4:40

local function StartPhase2(self)
	self:SetStage(2)
end

local function getWaveString(wave)
	local waveInfo = waves[wave]
	if #waveInfo == 2 then
		return L.WarningWave1:format(unpack(waveInfo))
	elseif #waveInfo == 4 then
		return L.WarningWave2:format(unpack(waveInfo))
	elseif #waveInfo == 6 then
		return L.WarningWave3:format(unpack(waveInfo))
	end
end

local function NextWave(self)
	self.vb.wave = self.vb.wave + 1
	warnWaveNow:Show(self.vb.wave, getWaveString(self.vb.wave))
	local timer = waves[self.vb.wave].timer
	if timer then
		timerWave:Start(timer, self.vb.wave + 1)
		warnWaveSoon:Schedule(timer - 3, self.vb.wave + 1, getWaveString(self.vb.wave + 1))
		self:Schedule(timer, NextWave, self)
	end
end

function mod:OnCombatStart()
	self:SetStage(1)
	self.vb.wave = 0
	timerGate:Start()
	timerPhase2:Start()
	warnPhase2:Schedule(275)
	timerWave:Start(nil, self.vb.wave + 1)
	warnWaveSoon:Schedule(27, self.vb.wave + 1, getWaveString(self.vb.wave + 1))
	self:Schedule(30, NextWave, self)
	self:Schedule(275, StartPhase2, self)
end

function mod:UNIT_DIED(args)
	if bit.band(args.destGUID:sub(0, 5), 0x00F) == 3 then
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 16126 then -- Unrelenting Rider
			warnRiderDown:Show()
		elseif cid == 16125 then -- Unrelenting Deathknight
			warnKnightDown:Show()
		end
	end
end

--[[function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(28025) and self.vb.phase == 1 then -- Teleport Left. Boss casts this teleportation spell, together with Yell: I have waited long enough. Now you face the harvester of souls.
		self:SetStage(2)
	end
end]]
