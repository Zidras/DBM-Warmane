local mod	= DBM:NewMod(572, "DBM-Party-BC", 4, 260)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(17942)

mod:SetModelID(18224)
mod:SetModelOffset(-2, 0.4, -1)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
