local mod	= DBM:NewMod("CommanderSpringvale", "DBM-Party-Classic", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(4278)

mod:RegisterCombat("combat")
