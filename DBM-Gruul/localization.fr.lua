if GetLocale() ~= "frFR" then return end

local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization({
	name = "Haut Roi Maulgar"
})

--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization({
	name = "Gruul le Tue-dragon"
})

L:SetOptionLocalization({
	WarnGrowth		= "Montre une alerte pour $spell:36300",
	RangeDistance	= "Montre la fenêtre de portée pour $spell:33654",
	Smaller			= "Distance plus petite (11)",
	Safe			= "Distance de sûreté (18)"
})
