local mod	= DBM:NewMod("TheRavenian", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(10507)
mod:SetEncounterID(--[[ mod:IsClassic() and 2812 or ]]460)

mod:RegisterCombat("combat")
