if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-------------
-- Malygos --
-------------
L = DBM:GetModLocalization("Malygos")

L:SetGeneralLocalization({
	name = "Malygos"
})

L:SetMiscLocalization({
	YellPull	= "Habéis agotado mi paciencia. ¡Me desharé de vosotros!",
	EmoteSpark	= "¡Un Chispazo toma forma a partir de una falla cercana!",
	YellPhase2	= "Esperaba acabar con vuestras vidas rápidamente",
	YellBreath	= "¡No lo conseguiréis mientras me quede aliento!",
	YellPhase3	= "Ahora aparecen vuestros benefactores, ¡pero llegan demasiado tarde!",
	EmoteSurge	= "¡%s fija su mirada en ti!"
})
