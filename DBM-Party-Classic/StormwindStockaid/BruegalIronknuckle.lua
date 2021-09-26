local mod	= DBM:NewMod("BruegalIronknuckle", "DBM-Party-Classic", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(1720)

mod:RegisterCombat("combat")
