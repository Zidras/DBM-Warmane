if GetLocale() ~= "frFR" then return end
local L

-- Azuregos (Azshara)
L = DBM:GetModLocalization("Azuregos")

L:SetGeneralLocalization({
	name = "Azuregos"
})

L:SetMiscLocalization({
	Pull		= "Cet endroit est sous ma protection. Les secrets de l'arcane resteront inviolés."
})

-- Taerar (Ashenvale)
L = DBM:GetModLocalization("Taerar")

L:SetGeneralLocalization({
	name = "Taerar"
})

L:SetMiscLocalization({
	Pull		= "La paix n'est qu'un rêve éphémère ! Que le CAUCHEMAR règne !"
})

-- Ysondre (Feralas)
L = DBM:GetModLocalization("Ysondre")

L:SetGeneralLocalization({
	name = "Ysondre"
})

L:SetMiscLocalization({
	Pull		= "Les fils de la VIE ont été coupés ! Les Rêveurs doivent être vengés !"
})

-- Lethon (Hinterlands)
L = DBM:GetModLocalization("Lethon")

L:SetGeneralLocalization({
	name = "Léthon"
})

L:SetMiscLocalization({
	Pull		= "Je sens l'OMBRE dans vos cœurs. Il ne peut y avoir de repos pour les vilains !"
})

-- Emeriss (Duskwood)
L = DBM:GetModLocalization("Emeriss")

L:SetGeneralLocalization({
	name = "Emeriss"
})

L:SetMiscLocalization({
	Pull		= "L'espoir est une MALADIE de l'âme ! Ces terres vont flétrir et mourir !"
})
