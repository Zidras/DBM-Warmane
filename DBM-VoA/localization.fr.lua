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
	ArchavonEnrage 	= "Enrage (Archavon)"
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

L:SetGeneralLocalization{
	name = "Koralon"
}

L:SetWarningLocalization{
	SpecWarnCinder		= "Vous êtes sur une Braise enflammée ! BOUGEZ !"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SpecWarnCinder		= "Montre une alerte spéciale quand vous êtes dans les Braises enflammées"
}

L:SetMiscLocalization{
	Meteor				= "%s lance Poings météoriques !"
}