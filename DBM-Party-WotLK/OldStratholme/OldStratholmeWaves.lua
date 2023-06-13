local mod	= DBM:NewMod("StratWaves", "DBM-Party-WotLK", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220729232625")

mod:RegisterEvents(
	"UPDATE_WORLD_STATES",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_SAY"
)
mod.noStatistics = true

local warningWaveNow	= mod:NewAnnounce("WarningWaveNow", 3)

local timerWaveIn		= mod:NewTimer(20, "TimerWaveIn", 57687, nil, nil, 1)
local timerRoleplay		= mod:NewTimer(162, "TimerRoleplay")

local devouring = L.Devouring
local meathook = L.Meathook
local salramm = L.Salramm
local enraged = L.Enraged
local necro = L.Necro
local fiend = L.Fiend
local abom = L.Abom

local wavesNormal = {
	{2, devouring},
	{2, devouring},
	{2, devouring},
	{2, devouring},
	{DBM_COMMON_L.BOSS .. ": " .. meathook},
	{2, devouring},
	{2, devouring},
	{2, devouring},
	{2, devouring},
	{DBM_COMMON_L.BOSS .. ": " .. salramm},
}

local wavesHeroic = {
	{3, devouring},
	{1, devouring, 1, enraged, 1, necro},
	{1, devouring, 1, enraged, 1, necro, 1, fiend},
	{1, necro, 4, L.Acolyte, 1, fiend},
	{DBM_COMMON_L.BOSS .. ": " .. meathook},
	{1, devouring, 1, necro, 1, fiend, 1, L.Stalker},
	{1, devouring, 2, enraged, 1, abom},
	{1, devouring, 1, enraged, 1, necro, 1, abom},
	{1, devouring, 1, necro, 1, fiend, 1, abom},
	{DBM_COMMON_L.BOSS .. ": " .. salramm},
}

local waveInfo
local lastWave = 0

local function getWaveString(self, wave)
	if self:IsDifficulty("heroic5") then
		waveInfo = wavesHeroic[wave]
	else
		waveInfo = wavesNormal[wave]
	end
	if #waveInfo == 1 then
		return L.WaveBoss:format(unpack(waveInfo))
	elseif #waveInfo == 2 then
		return L.Wave1:format(unpack(waveInfo))
	elseif #waveInfo == 4 then
		return L.Wave2:format(unpack(waveInfo))
	elseif #waveInfo == 6 then
		return L.Wave3:format(unpack(waveInfo))
	elseif #waveInfo == 8 then
		return L.Wave4:format(unpack(waveInfo))
	end
end

function mod:UPDATE_WORLD_STATES()
	local text = select(3, GetWorldStateUIInfo(2))
	if not text then return end
	local _, _, wave = string.find(text, L.WaveCheck)
	if not wave then
		wave = 0
	end
	wave = tonumber(wave)
	lastWave = tonumber(lastWave)
	if wave < lastWave then
		lastWave = 0
	end
	if wave > lastWave then
		warningWaveNow:Show(wave, getWaveString(self, wave))
		lastWave = wave
	end
end

function mod:UNIT_DIED(args)
	if bit.band(args.destGUID:sub(0, 5), 0x00F) == 3 then
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 26529 then
			timerWaveIn:Start()
		end
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.Roleplay or msg:find(L.Roleplay) then
		timerRoleplay:Start()--Arthas preaches to uther and jaina
	elseif msg == L.Roleplay2 or msg:find(L.Roleplay2) then
		timerRoleplay:Start(106)--Arthas prances around blabbing with malganis
	end
end
