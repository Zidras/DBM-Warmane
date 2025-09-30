local mod	= DBM:NewMod("DoctorTheolenKrastinov", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(11261)
mod:SetEncounterID(--[[ mod:IsClassic() and 2802 or  ]]458)

mod:RegisterCombat("combat")
