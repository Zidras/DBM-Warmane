local mod = DBM:NewMod("LichKingEvent", "DBM-Party-WotLK", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision("20220729231502")
mod:RegisterEvents(
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL"
)

local WarnWave		= mod:NewAnnounce("WarnWave", 2)

local timerEscape	= mod:NewAchievementTimer(360, 4526, "achievementEscape")

local ragingGhoul = L.Ghoul
local witchDoctor = L.WitchDoctor
local abomination = L.Abom

local addWaves = {
	[1] = { "6 "..ragingGhoul, "1 "..witchDoctor },
	[2] = { "6 "..ragingGhoul, "2 "..witchDoctor, "1 "..abomination },
	[3] = { "6 "..ragingGhoul, "2 "..witchDoctor, "2 "..abomination },
	[4] = { "12 "..ragingGhoul, "3 "..witchDoctor, "3 "..abomination },
}

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69708 then			--Lich King has broken out of his iceblock, this starts actual event
		if self:IsDifficulty("heroic5") then
			timerEscape:Start()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Wave1 or msg:find(L.Wave1) then
		WarnWave:Show(table.concat(addWaves[1], ", "))
	elseif msg == L.Wave2 or msg:find(L.Wave2) then
		WarnWave:Show(table.concat(addWaves[2], ", "))
	elseif msg == L.Wave3 or msg:find(L.Wave3) then
		WarnWave:Show(table.concat(addWaves[3], ", "))
	elseif msg == L.Wave4 or msg:find(L.Wave4) then
		WarnWave:Show(table.concat(addWaves[4], ", "))
	end
end