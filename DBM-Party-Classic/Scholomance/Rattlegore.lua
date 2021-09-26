local mod	= DBM:NewMod("Rattlegore", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(11622)

mod:RegisterCombat("combat")
