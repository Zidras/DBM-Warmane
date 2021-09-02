local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization{
	name = "High King Maulgar"
}


--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization{
	name = "Gruul the Dragonkiller"
}

L:SetWarningLocalization{
	WarnGrowth	= "%s (%d)"
}

L:SetOptionLocalization{
	WarnGrowth		= "Show warning for $spell:36300",
	RangeDistance	= "Range frame distance for |cff71d5ff|Hspell:33654|hShatter|h|r",
	Smaller			= "Smaller distance (11)",
	Safe			= "Safer distance (18)"
}