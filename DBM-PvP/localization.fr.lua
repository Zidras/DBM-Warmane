if GetLocale() ~= "frFR" then return end

local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "Options générale"
})

L:SetTimerLocalization({
	TimerFlag		= "Respawn du drapeau",
	TimerShadow		= "Cristal d'ombre",
	TimerStart		= "La bataille commence dans",
	TimerWin		= "Victoire en"
})

L:SetOptionLocalization({
	AutoSpirit			= "Auto-rez à un Ange",
	ColorByClass		= "Met le nom en couleur en fonction de la classe dans le tableau des scores",
	HideBossEmoteFrame	= "Masquez les cadres d'émotes de boss de raid",
	ShowBasesToWin		= "Montre les bases à avoir pour gagner",
	ShowEstimatedPoints	= "Montre l'estimation de point pour gagner / perdre",
	ShowFlagCarrier		= "Montre le porteur du drapeau",
	ShowRelativeGameTime= "Remplir la minuterie de victoire par rapport à l'heure de début du champ de bataille (si désactivé, la barre semble toujours pleine)",
	TimerCap			= "Montre le timer de capture",
	TimerFlag			= "Montre le timer du respawn du drapeau",
	TimerShadow			= "Montre le timer pour le cristal d'ombre",
	TimerStart			= "Voir le timer du début",
	TimerWin			= "Montre le timer de la victoire"
})

L:SetMiscLocalization({
	--BG 2 minutes
	BgStart120TC		= "La bataille commence dans 2 minutes !",
	--BG 1 minute
	BgStart60TC			= "La bataille commence dans 1 minute !",
	BgStart60AlteracTC	= "La bataille pour la vallée d’Alterac commence dans 1 minute.",
	BgStart60SotA2TC	= "Deuxième manche de la bataille du rivage des Anciens dans 1 minute.",
	BgStart60WarsongTC	= "La bataille pour le goulet des Chanteguerres commence dans 1 minute.",
	-- BG 30 seconds
	BgStart30TC			= "La bataille commence dans 30 secondes !",
	BgStart30AlteracTC	= "La bataille pour la vallée d’Alterac commence dans 30 secondes.",
	BgStart30SotA2TC	= "Début de la deuxième manche dans 30 secondes. Préparez-vous !",
	BgStart30WarsongTC	= "La bataille pour le goulet des Chanteguerres commence dans 30 secondes. Préparez-vous !",
	--
	ArenaInvite			= "Invitation d'arène",
	Start60TC			= "Le combat d’arène commence dans une minute !",
	Start30TC			= "Le combat d’arène commence dans trente secondes !",
	Start15TC			= "Le combat commence dans quinze secondes !",
	BasesToWin			= "Bases pour gagner: %d",
	WinBarText			= "%s Gagne",
	Flag				= "Drapeau",
--	FlagReset 			= "Le drapeau a été réinitialisé.",
--	FlagTaken 			= "(.+) a pris le drapeau !",
--	FlagCaptured 		= "La .+ ha%w+ s'est emparée du drapeau !",
--	FlagDropped 		= "Le drapeau vient d'être laché !",
--	ExprFlagPickUp		= "Le Drapeau (%w+) a été pris par (.+)!",
--	ExprFlagCaptured	= "(.+) a capturé le drapeau (%w+)!",
--	ExprFlagReturn		= "Le Drapeau (%w+) a été renvoyé à la base par (.+)!",
	Vulnerable1			= "Le porteur du drapeau est vulnérable aux attaques!",
	Vulnerable2			= "Le porteur du drapeau devient encore plus vulnérable aux attaques!"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "Vallée d'Alterac"
})

L:SetOptionLocalization({
	AutoTurnIn	= "Fini automatiquement les quêtes dans la Vallée d'Alterac"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "Bassin d'Arathi"
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "L'Œil du cyclone"
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "Goulet des Chanteguerres"
})

---------------------
--  Strand of the Ancients  --
---------------------
L = DBM:GetModLocalization("StrandoftheAncients")

L:SetGeneralLocalization({
	name = "Rivage des Anciens"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "Île des Conquérants"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "Engins de Siège prêt!",
	WarnSiegeEngineSoon	= "Apparition des Engins de Siège dans ~10 sec"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "Engins de Siège prêt"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "Montre le timer de la construction des Engins de Siège",
	WarnSiegeEngine		= "Alerter lorsque l'Engin de Siège est prêt",
	WarnSiegeEngineSoon	= "Alerter lorsque l'Engin de Siège est presque prêt",
	ShowGatesHealth		= "Afficher la vie des portes endommagées (les valeurs peuvent être fausses après avoir rejoint un champ de bataille déjà en cours!))"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "Portes endommagées",
	SiegeEngine				= "Engin de Siège",
	GoblinStartAlliance		= "Regarder ces Bombes d'hydroglycérine ? Utilisez-les sur les portes alors que je répare l'engin de siège!",
	GoblinStartHorde		= "Je travaillerai sur l'engin de siège, regarde juste mon dos. Utilse ces Bombes d'hydroglycérine sur les portes si tu en as besoin!",
	GoblinHalfwayAlliance	= "Je suis à mi-chemin! Gardez la Horde loin d'ici. Ils n'apprennent pas la lutte à l'ecole d'ingénieur!",
	GoblinHalfwayHorde		= "J'ai déjà fait mi-chemin ! Gardez l'Alliance loin - Combattre n'est pas dans mon contrat!",
	GoblinFinishedAlliance	= "Mon plus beau travail accompli jusqu'à présent! Cet engin de siège est prêt pour l'action!",
	GoblinFinishedHorde		= "L'engin de siège est prêt à rouler!",
	GoblinBrokenAlliance	= "C'est déjà cassé?! Pas de soucis. Ce n'est rien que je ne puisse arranger.",
	GoblinBrokenHorde		= "C'est encore cassé?! j'arrangerais ça... ne vous attendez pas a ce que la garantie couvre cela"
})