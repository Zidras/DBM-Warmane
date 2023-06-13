if GetLocale() ~= "ruRU" then return end
 local L

-- Azuregos (Azshara)
L = DBM:GetModLocalization("Azuregos")

L:SetGeneralLocalization({
	name = "Азурегос"
})

L:SetMiscLocalization({
	Pull		= "Это место под моей защитой. Тайные мистерии останутся неоскверненными."
})

-- Taerar (Ashenvale)
L = DBM:GetModLocalization("Taerar")

L:SetGeneralLocalization({
	name = "Таэрар"
})

L:SetMiscLocalization({
	Pull		= "Мир – это всего лишь мимолетный сон. Пусть правит КОШМАР!"
})

-- Ysondre (Feralas)
L = DBM:GetModLocalization("Ysondre")

L:SetGeneralLocalization({
	name = "Исондра"
})

L:SetMiscLocalization({
	Pull		= "Нити ЖИЗНИ разорваны! Отомстим за Спящих!"
})

-- Lethon (Hinterlands)
L = DBM:GetModLocalization("Lethon")

L:SetGeneralLocalization({
	name = "Летон"
})

L:SetMiscLocalization({
	Pull		= "Я чувствую ТЕНЬ, нависшую над вашими сердцами. Нечестивцам не будет покоя!"
})

-- Emeriss (Duskwood)
L = DBM:GetModLocalization("Emeriss")

L:SetGeneralLocalization({
	name = "Эмерисс"
})

L:SetMiscLocalization({
	Pull		= "Надежда – это БОЛЕЗНЬ души! Эта земля зачахнет и умрет!"
})
