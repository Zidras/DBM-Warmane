local mod	= DBM:NewMod("DoctorTheolenKrastinov", "DBM-Party-Classic", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(11261)

mod:RegisterCombat("combat")
