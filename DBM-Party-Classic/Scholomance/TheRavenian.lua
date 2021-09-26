local mod	= DBM:NewMod("TheRavenian", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(10507)

mod:RegisterCombat("combat")
