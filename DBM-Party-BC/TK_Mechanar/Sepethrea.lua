local mod = DBM:NewMod(564, "DBM-Party-BC", 13, 258)
local L = mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20250929220131")
mod:SetCreatureID(19221)
mod:SetEncounterID(1930)

mod:SetModelID(19166)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
