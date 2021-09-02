local mod	= DBM:NewMod("GoralukAnvilcrack", "DBM-Party-Classic", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(10899)

mod:RegisterCombat("combat")
