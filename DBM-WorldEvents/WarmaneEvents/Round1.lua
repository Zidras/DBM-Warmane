local mod	= DBM:NewMod("WarmaneTowerDefense-Round1", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241228180505")

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

mod:RemoveOption("HealthFrame")

-- function mod:OnCombatStart(delay)
-- end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Round1Start or msg:find(L.Round1Start) then
		DBM:StartCombat(self, 0, "MONSTER_MESSAGE")
	elseif msg == L.Round1Complete or msg:find(L.Round1Complete) then -- victory
		DBM:EndCombat(self)
	elseif msg:find(L.Round1Failed) then -- wipe
		DBM:EndCombat(self, true)
	end
end
