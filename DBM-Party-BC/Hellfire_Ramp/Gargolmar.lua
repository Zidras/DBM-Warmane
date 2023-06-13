local mod	= DBM:NewMod(527, "DBM-Party-BC", 1, 248)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(17306)

mod:SetModelID(18236)
mod:SetModelOffset(-0.2, 0, -0.3)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
