local mod	= DBM:NewMod("OdotheBlindwatcher", "DBM-Party-Classic", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(4279)

mod:RegisterCombat("combat")
