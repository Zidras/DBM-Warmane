local mod	= DBM:NewMod("LadyIlluciaBarov", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(10502)
mod:SetEncounterID(--[[ mod:IsClassic() and 2806 or  ]]462)

mod:RegisterCombat("combat")
