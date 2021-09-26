local mod	= DBM:NewMod(477, "DBM-Party-Classic", 19, 240)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(3653)


mod:RegisterCombat("combat")
