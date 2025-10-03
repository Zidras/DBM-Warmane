local mod	= DBM:NewMod(424, "DBM-Party-Classic", 8, 232)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(12258)
mod:SetEncounterID(423)

mod:RegisterCombat("combat")

--Nothing to see here, puncture seems to be randomly cast, and not that important
