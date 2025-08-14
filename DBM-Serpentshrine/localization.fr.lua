if GetLocale() ~= "frFR" then return end
local L

---------------------------
--  Hydross the Unstable --
---------------------------
L = DBM:GetModLocalization("Hydross")

L:SetGeneralLocalization({
	name = "Hydross l'Instable"
})

L:SetOptionLocalization({
	WarnMark		= "Afficher une alerte pour les Marques",
	WarnPhase		= "Afficher une alerte pour la prochaine phase",
	SpecWarnMark	= "Afficher une alerte lorsque les dégâts du débuff Marques dépassent 100%",
	TimerMark		= "Afficher un timer pour la prochaine Marque"
})

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

L:SetWarningLocalization({
	WarnSubmerge		= "Immergé",
	WarnEmerge			= "Émergé"
})

L:SetTimerLocalization({
	TimerSubmerge		= "CD Immersion",
	TimerEmerge			= "CD Émergence"
})

L:SetOptionLocalization({
	WarnSubmerge		= "Afficher une alerte lors de l'immersion",
	WarnEmerge			= "Afficher une alerte lors de l'émergence",
	TimerSubmerge		= "Afficher un timer pour l'immersion",
	TimerEmerge			= "Afficher un timer pour l'émergence"
})

--------------------------
--  Leotheras the Blind --
--------------------------
L = DBM:GetModLocalization("Leotheras")

L:SetGeneralLocalization({
	name = "Leotheras l'Aveugle"
})

L:SetOptionLocalization({
	WarnPhase		= "Afficher une alerte pour la prochaine phase",
	TimerPhase		= "Afficher un timer pour la prochaine phase"
})

L:SetMiscLocalization({
	YellDemon	= "Hors d'ici, elfe insignifiant. Je prends le contrôle !",
	YellPull	= "Enfin, mon exil s'achève !"
})

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
L = DBM:GetModLocalization("Fathomlord")

L:SetGeneralLocalization({
	name = "Seigneur des fonds Karathress"
})

L:SetMiscLocalization({
	YellPull	= "Gardes, en position ! Nous avons de la visite…"
})

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetGeneralLocalization({
	name = "Morogrim Marcheur-des-flots"
})

L:SetOptionLocalization({
	SpecWarnMurlocs	= "Afficher une alerte spéciale lors de l'arrivée des murlocs",
	TimerMurlocs	= "Afficher un timer pour l'arrivée des murlocs"
})

L:SetMiscLocalization({
	Grave			= "%s envoie ses ennemis six pieds sous l'eau !",
	Murlocs			= "La violence du tremblement de terre a alerté des murlocs qui passaient non loin !"
})

-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetGeneralLocalization({
	name = "Dame Vashj"
})

L:SetWarningLocalization({
	WarnElemental		= "Élémentaire souillé bientôt (%s)",
	WarnStrider			= "Trotteur bientôt (%s)",
	WarnNaga			= "Naga bientôt (%s)",
	WarnShield			= "Bouclier %d/4 détruit",
	WarnLoot			= "Noyau contaminé sur >%s<",
	SpecWarnElemental	= "Élémentaire souillé - Changez de cible !"
})

L:SetTimerLocalization({
	TimerElementalActive	= "Élémentaire actif",
	TimerElemental			= "CD Élémentaire (%d)",
	TimerStrider			= "Prochain trotteur (%d)",
	TimerNaga				= "Prochain naga (%d)"
})

L:SetOptionLocalization({
	WarnElemental		= "Afficher une pré-alerte pour le prochain Élémentaire souillé",
	WarnStrider			= "Afficher une pré-alerte pour le prochain trotteur",
	WarnNaga			= "Afficher une pré-alerte pour le prochain naga",
	WarnShield			= "Afficher une alerte pour la destruction du bouclier en phase 2",
	WarnLoot			= "Afficher une alerte pour le loot du Noyau contaminé",
	TimerElementalActive	= "Afficher un timer pour la durée d'activité de l'Élémentaire souillé",
	TimerElemental		= "Afficher un timer pour le cooldown de l'Élémentaire souillé",
	TimerStrider		= "Afficher un timer pour le prochain trotteur",
	TimerNaga			= "Afficher un timer pour le prochain naga",
	SpecWarnElemental	= "Afficher une alerte spéciale lors de l'arrivée de l'Élémentaire souillé",
	AutoChangeLootToFFA	= "Passer le mode de butin en Butin libre en phase 2"
})

L:SetMiscLocalization({
	DBM_VASHJ_YELL_PHASE2	= "L'heure est venue ! N'épargnez personne !",
	DBM_VASHJ_YELL_PHASE3	= "Il faudrait peut-être vous mettre à l'abri.",
	LootMsg					= "([^%s]+).*Hitem:(%d+)"
})
