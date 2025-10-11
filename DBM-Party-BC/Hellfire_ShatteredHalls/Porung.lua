local mod	= DBM:NewMod(728, "DBM-Party-BC", 3, 259)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20250929220131")
mod:SetCreatureID(20923)
mod:SetEncounterID(1935)

mod:SetModelID(17725)
mod:SetModelOffset(0, 0, -0.1)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
