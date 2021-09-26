local mod	= DBM:NewMod("SolakarFlamewreath", "DBM-Party-Classic", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(10264)

mod:RegisterCombat("combat")
