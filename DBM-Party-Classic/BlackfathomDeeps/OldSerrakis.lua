local mod	= DBM:NewMod("OldSerrakis", "DBM-Party-Classic", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(4830)
--

mod:RegisterCombat("combat")
