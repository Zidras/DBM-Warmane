if GetLocale() ~= "esES" then return end
local L

-- Azuregos (Azshara)
L = DBM:GetModLocalization("Azuregos")

L:SetGeneralLocalization{
	name = "Azuregos"
}

L:SetMiscLocalization({
	Pull		= "Este lugar está bajo mi protección. Los misterios arcanos no serán mancillados."
})

-- Taerar (Ashenvale)
L = DBM:GetModLocalization("Taerar")

L:SetGeneralLocalization{
	name = "Taerar"
}

L:SetMiscLocalization({
	Pull		= "¡La paz no es más que un sueño fugaz! ¡Que reine la PESADILLA!"
})

-- Ysondre (Feralas)
L = DBM:GetModLocalization("Ysondre")

L:SetGeneralLocalization{
	name = "Ysondre"
}

L:SetMiscLocalization({
	Pull		= "¡Los hilos de la VIDA se han roto! ¡Tenemos que vengar a los Soñadores!"
})

-- Lethon (Hinterlands)
L = DBM:GetModLocalization("Lethon")

L:SetGeneralLocalization{
	name = "Lethon"
}

L:SetMiscLocalization({
	Pull		= "Puedo sentir la SOMBRA en vuestros corazones. ¡No puede haber descanso para los malos!"
})

-- Emeriss (Duskwood)
L = DBM:GetModLocalization("Emeriss")

L:SetGeneralLocalization{
	name = "Emeriss"
}

L:SetMiscLocalization({
	Pull		= "¡La esperanza es una ENFERMEDAD del alma! ¡Esta tierra se marchitará y morirá!"
})
