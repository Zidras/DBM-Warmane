local mod	= DBM:NewMod("JandiceBarov", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(10503)
mod:SetEncounterID(--[[ mod:IsClassic() and 2804 or  ]]452)

mod:RegisterCombat("combat")
