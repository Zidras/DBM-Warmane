local mod	= DBM:NewMod("TheBeast", "DBM-Party-Classic", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(10430)
mod:SetEncounterID(279)

mod:RegisterCombat("combat")
