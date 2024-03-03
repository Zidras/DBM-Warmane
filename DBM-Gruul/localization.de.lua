if GetLocale() ~= "deDE" then return end
local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization({
	name = "Hochkönig Maulgar"
})

--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization({
	name = "Gruul der Drachenschlächter"
})

L:SetWarningLocalization({
	WarnGrowth	= "%s (%d)"
})

L:SetOptionLocalization({
	WarnGrowth	= "Zeige Warnung für $spell:36300",
	RangeDistance	= "Range frame distance for $spell:33654",
	Smaller			= "Smaller distance (14)",
	Safe			= "Safer distance (20)"
})
