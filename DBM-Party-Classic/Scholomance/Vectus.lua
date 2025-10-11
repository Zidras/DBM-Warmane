local mod	= DBM:NewMod("Vectus", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(10432)
mod:SetEncounterID(--[[ mod:IsClassic() and 2813 or  ]]455)

mod:RegisterCombat("combat")
