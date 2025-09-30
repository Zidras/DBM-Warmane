local mod	= DBM:NewMod("RasFrostwhisper", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(10508)
mod:SetEncounterID(--[[ mod:IsClassic() and 2810 or  ]]456)

mod:RegisterCombat("combat")
