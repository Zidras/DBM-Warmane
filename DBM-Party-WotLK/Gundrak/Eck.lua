local mod	= DBM:NewMod("Eck", "DBM-Party-WotLK", 5)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(29932)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)

local enrageTimer	= mod:NewBerserkTimer(120)

function mod:OnCombatStart(delay)
	enrageTimer:Start(120 - delay)
end
