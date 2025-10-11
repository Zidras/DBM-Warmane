if UnitFactionGroup("player") == "Alliance" then return end
local mod	= DBM:NewMod(468, "DBM-Party-Classic", 18, 239)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(6906, 6907, 6908)
mod:SetEncounterID(548)

mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")
