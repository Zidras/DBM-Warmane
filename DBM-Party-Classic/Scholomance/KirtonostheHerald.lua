local mod	= DBM:NewMod("KirtonostheHerald", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(10506)
mod:SetEncounterID(--[[ mod:IsClassic() and 2805 or  ]]451)

mod:RegisterCombat("combat")
