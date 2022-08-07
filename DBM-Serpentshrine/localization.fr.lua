if GetLocale() ~= "frFR" then return end
local L

---------------------------
--  Hydross the Unstable --
---------------------------
--L = DBM:GetModLocalization("Hydross")

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
--L = DBM:GetModLocalization("Leotheras")

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
--L = DBM:GetModLocalization("Fathomlord")

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetMiscLocalization({
--	Grave			= "%s sends his enemies to their watery graves!",
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