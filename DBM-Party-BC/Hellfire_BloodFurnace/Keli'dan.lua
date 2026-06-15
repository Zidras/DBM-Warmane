local mod	= DBM:NewMod(557, "DBM-Party-BC", 2, 256)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(17377)--17377 is boss, 17653 are channelers that just pull with him.

mod:SetModelID(17153)
mod:SetModelOffset(0, 0, -0.1)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
