local mod	= DBM:NewMod(419, "DBM-Party-Classic", 7, 231)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(7361)


mod:RegisterCombat("combat")
