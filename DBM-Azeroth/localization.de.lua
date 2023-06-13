if GetLocale() ~= "deDE" then return end
local L

-- Azuregos (Azshara)
L = DBM:GetModLocalization("Azuregos")

L:SetGeneralLocalization({
	name = "Azuregos"
})

L:SetMiscLocalization({
	Pull		= "Dieser Ort steht unter meinem Schutz. Die Mysterien des Arkanen werden unberührt bleiben."
})

-- Taerar (Ashenvale)
L = DBM:GetModLocalization("Taerar")

L:SetGeneralLocalization({
	name = "Taerar"
})

L:SetMiscLocalization({
	Pull		= "Frieden ist nur ein flüchtiger Traum! Von nun an herrscht der ALPTRAUM!"
})

-- Ysondre (Feralas)
L = DBM:GetModLocalization("Ysondre")

L:SetGeneralLocalization({
	name = "Ysondre"
})

L:SetMiscLocalization({
	Pull		= "Die Fäden des LEBENS wurden durchtrennt! Die Träumer müssen gerächt werden!"
})

-- Lethon (Hinterlands)
L = DBM:GetModLocalization("Lethon")

L:SetGeneralLocalization({
	name = "Lethon"
})

L:SetMiscLocalization({
	Pull		= "Ich fühle die SCHATTEN in Euren Herzen. Niemals darf das Böse Ruhe finden!"
})

-- Emeriss (Duskwood)
L = DBM:GetModLocalization("Emeriss")

L:SetGeneralLocalization({
	name = "Emeriss"
})

L:SetMiscLocalization({
	Pull		= "Die Hoffnung ist eine KRANKHEIT der Seele. Dieses Land wird verdorren und sterben!"
})
