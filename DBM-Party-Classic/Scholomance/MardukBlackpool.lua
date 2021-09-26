local mod	= DBM:NewMod("MardukBlackpool", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(10433)

mod:RegisterCombat("combat")
