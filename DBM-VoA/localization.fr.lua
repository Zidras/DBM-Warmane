if GetLocale() ~= "frFR" then return end

local L

----------------
--  Archavon  --
----------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Archavon"
})

L:SetWarningLocalization({
	WarningGrab		= "Archavon a Empalé >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "Enrage (Archavon)"
})

L:SetOptionLocalization({
	WarningGrab		= "Montre l'alerte pour le tank qui a été empalé"
})

L:SetMiscLocalization({
	TankSwitch		= "%%s lunges for (%S+)!"
})

--------------
--  Emalon  --
--------------

L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization({
	name = "Emalon le guetteur d’orage"
})

L:SetTimerLocalization({
	timerMobOvercharge	= "Explosion de Surcharge",
	EmalonEnrage		= "Enrage (Emalon)"
})

L:SetOptionLocalization({
	timerMobOvercharge	= "Montre le timer pour le séide surchargé (debuff empilable)"
})

---------------
--  Koralon  --
---------------

L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization({
	name = "Koralon"
})

L:SetTimerLocalization({
	KoralonEnrage	= "Enrage (Koralon)"
})

---------------
--  Toravon  --
---------------

L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization({
	name = "Toravon la Sentinelle de glace"
})

L:SetTimerLocalization({
	ToravonEnrage	= "Enrage (Toravon)"
})
