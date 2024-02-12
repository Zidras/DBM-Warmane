if GetLocale() ~= "frFR" then return end
local L

----------------
--  Lucifron  --
----------------
L = DBM:GetModLocalization("Lucifron")

L:SetGeneralLocalization({
	name = "Lucifron"
})

----------------
--  Magmadar  --
----------------
L = DBM:GetModLocalization("Magmadar")

L:SetGeneralLocalization({
	name = "Magmadar"
})

----------------
--  Gehennas  --
----------------
L = DBM:GetModLocalization("Gehennas")

L:SetGeneralLocalization({
	name = "Gehennas"
})

------------
--  Garr  --
------------
L = DBM:GetModLocalization("Garr-Classic")

L:SetGeneralLocalization({
	name = "Garr"
})

--------------
--  Geddon  --
--------------
L = DBM:GetModLocalization("Geddon")

L:SetGeneralLocalization({
	name = "Baron Geddon"
})

----------------
--  Shazzrah  --
----------------
L = DBM:GetModLocalization("Shazzrah")

L:SetGeneralLocalization({
	name = "Shazzrah"
})

----------------
--  Sulfuron  --
----------------
L = DBM:GetModLocalization("Sulfuron")

L:SetGeneralLocalization({
	name = "Messager de Sulfuron"
})

----------------
--  Golemagg  --
----------------
L = DBM:GetModLocalization("Golemagg")

L:SetGeneralLocalization({
	name = "Golemagg l'Incinérateur"
})

-----------------
--  Majordomo  --
-----------------
L = DBM:GetModLocalization("Majordomo")

L:SetGeneralLocalization({
	name = "Chambellan Executus"
})

L:SetTimerLocalization({
	timerShieldCD		= "Bouclier suivant"
})

L:SetOptionLocalization({
	timerShieldCD		= "Afficher le timer pour le prochain bouclier de dégâts / Renvoi de la magie"
})

----------------
--  Ragnaros  --
----------------
L = DBM:GetModLocalization("Ragnaros-Classic")

L:SetGeneralLocalization({
	name = "Ragnaros"
})

L:SetWarningLocalization({
	WarnSubmerge		= "Submergé",
	WarnEmerge			= "Émergé"
})

L:SetTimerLocalization({
	TimerSubmerge		= "Submergé",
	TimerEmerge			= "Émergé",
})

L:SetOptionLocalization({
	WarnSubmerge		= "Afficher un avertissement pour submergé",
	TimerSubmerge		= "Afficher le timer pour submergé",
	WarnEmerge			= "Afficher un avertissement pour émergé",
	TimerEmerge			= "Afficher le timer pour émergé",
})

L:SetMiscLocalization({
	Submerge	= "VENEZ, MES SERVITEURS ! DÉFENDEZ VOTRE MAÎTRE !",
	Submerge2	= "VOUS NE POUVEZ VAINCRE LA FLAMME VIVANTE ! VENEZ, SERVITEURS DU FEU ! VENEZ, CRÉATURES DE LA HAINE ! VOTRE MAÎTRE VOUS APPELLE !",
	Pull		= "Impudents imbéciles ! Vous vous êtes précipités vers votre propre mort ! Voyez, à présent, le Maître remue !"
})

-----------------
--  MC: Trash  --
-----------------
L = DBM:GetModLocalization("MCTrash")

L:SetGeneralLocalization({
	name = "CM: Ennemis communs"
})
