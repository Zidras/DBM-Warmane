local mod	= DBM:NewMod("Anubarak", "DBM-Party-WotLK", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(29120)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 53472 59433"
)

local warningPound		= mod:NewSpellAnnounce(53472, 3)

local timerAchieve		= mod:NewAchievementTimer(240, 1860)

function mod:OnCombatStart(delay)
	if not self:IsDifficulty("normal5") then
		timerAchieve:Start(-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(53472, 59433) then
		warningPound:Show()
	end
end
