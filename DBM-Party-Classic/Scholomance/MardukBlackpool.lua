local mod	= DBM:NewMod("MardukBlackpool", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(10433)
mod:SetEncounterID(--[[ mod:IsClassic() and 2809 or  ]]454)

mod:RegisterCombat("combat")
