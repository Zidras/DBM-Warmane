local mod	= DBM:NewMod("TheBeast", "DBM-Party-Classic", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(10430)

mod:RegisterCombat("combat")
