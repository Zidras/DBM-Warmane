if GetLocale() ~= "frFR" then return end
local L

---------------------------
--  Hydross the Unstable --
---------------------------
L = DBM:GetModLocalization("Hydross")

L:SetMiscLocalization({
	YellPull	= "Je ne peux pas vous laisser nous gêner !"
})

-----------------------
--  The Lurker Below --
-----------------------
L = DBM:GetModLocalization("LurkerBelow")

L:SetGeneralLocalization({
	name = "Le Rôdeur d'En bas"
})

--------------------------
--  Leotheras the Blind --
--------------------------
L = DBM:GetModLocalization("Leotheras")

L:SetMiscLocalization({
	YellDemon	= "Hors d'ici, elfe insignifiant. Je prends le contrôle !",
	YellPull	= "Enfin, mon exil s'achève !"
})

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
L = DBM:GetModLocalization("Fathomlord")

L:SetMiscLocalization({
	YellPull	= "Gardes, en position ! Nous avons de la visite…"
})

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetMiscLocalization({
	Grave			= "%s envoie ses ennemis six pieds sous l'eau !",
	Murlocs			= "La violence du tremblement de terre a alerté des murlocs qui passaient non loin !"
})

-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetMiscLocalization({
	DBM_VASHJ_YELL_PHASE2	= "L'heure est venue ! N'épargnez personne !",
	DBM_VASHJ_YELL_PHASE3	= "Il faudrait peut-être vous mettre à l'abri.",
	LootMsg					= "([^%s]+).*Hitem:(%d+)"
})