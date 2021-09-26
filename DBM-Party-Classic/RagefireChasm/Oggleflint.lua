local mod	= DBM:NewMod("Oggleflint", "DBM-Party-Classic", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(11517)
--

mod:RegisterCombat("combat")
