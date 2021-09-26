local mod	= DBM:NewMod("RazorclawtheButcher", "DBM-Party-Classic", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(3886)

mod:RegisterCombat("combat")
