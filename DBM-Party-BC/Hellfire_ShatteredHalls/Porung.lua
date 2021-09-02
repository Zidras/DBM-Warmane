local mod	= DBM:NewMod(728, "DBM-Party-BC", 3, 259)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(20923)

mod:SetModelID(17725)
mod:SetModelOffset(0, 0, -0.1)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
