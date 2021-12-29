local mod	= DBM:NewMod("Loken", "DBM-Party-WotLK", 6)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic"

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(28923)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 52960 59835"
)

local warningNova	= mod:NewSpellAnnounce(52960, 3)

local timerNovaCD	= mod:NewCDTimer(30, 52960, nil, nil, nil, 2)
local timerAchieve	= mod:NewAchievementTimer(120, 1867)

function mod:OnCombatStart(delay)
	if not self:IsDifficulty("normal5") then
		timerAchieve:Start(-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(52960, 59835) then
		warningNova:Show()
		timerNovaCD:Start()
	end
end