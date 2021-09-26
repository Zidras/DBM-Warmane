local mod	= DBM:NewMod("Targorr", "DBM-Party-Classic", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(1696)

mod:RegisterCombat("combat")
