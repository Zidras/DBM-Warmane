local mod	= DBM:NewMod("LorekeeperPolkelt", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(10901)
mod:SetEncounterID(--[[ mod:IsClassic() and 2808 or  ]]459)

mod:RegisterCombat("combat")
