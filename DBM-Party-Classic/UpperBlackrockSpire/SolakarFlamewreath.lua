local mod	= DBM:NewMod("SolakarFlamewreath", "DBM-Party-Classic", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(10264)
mod:SetEncounterID(277)

mod:RegisterCombat("combat")
