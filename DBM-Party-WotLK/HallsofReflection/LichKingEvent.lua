local mod = DBM:NewMod("LichKingEvent", "DBM-Party-WotLK", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2153 $"):sub(12, -3))
mod:RegisterEvents(
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL"
)

local WarnWave		= mod:NewAnnounce("WarnWave", 2)

local timerEscape	= mod:NewAchievementTimer(360, 4526, "achievementEscape")

local addWaves = {
	[1] = { "6 "..L.Ghoul, "1 "..L.WitchDoctor },
	[2] = { "6 "..L.Ghoul, "2 "..L.WitchDoctor, "1 "..L.Abom },
	[3] = { "6 "..L.Ghoul, "2 "..L.WitchDoctor, "2 "..L.Abom },
	[4] = { "12 "..L.Ghoul, "3 "..L.WitchDoctor, "3 "..L.Abom },
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