local mod	= DBM:NewMod("BlindHunter", "DBM-Party-Classic", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(4425)

mod:RegisterCombat("combat")

--Just a stats module, nothing more, boss doesn't really do anything, this just tracks your kills
