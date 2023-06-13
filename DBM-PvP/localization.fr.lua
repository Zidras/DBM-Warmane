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
	ShowGatesHealth		= "Afficher la vie des portes endommagées (les valeurs peuvent être fausses après avoir rejoint un champ de bataille déjà en cours!))",
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
	-- Flag carrying system
	Flag				= "Drapeau",
	FlagResetTC			= "Le drapeau a été réinitialisé.",
	FlagTakenTC			= "(.+) a pris le drapeau !",
	FlagCapturedATC		= "L'Alliance a pris le drapeau !",
	FlagCapturedHTC		= "La Horde s'est emparée du drapeau !",
	FlagDroppedTC		= "Le drapeau a été lâché !",
	--
	ExprFlagPickUpTC	= "Le drapeau de (%w+) a été ramassé par (.+) !",
	ExprFlagCapturedTC	= "(.+) a pris le drapeau de (%w+) !",
	ExprFlagReturnTC	= "Le drapeau de (%w+) a été ramené à sa base par (.+) !",
	ExprFlagDroppedTC	= "Le drapeau de (%w+) a été lâché par (.+) !",
	Vulnerable1			= "Le porteur du drapeau est vulnérable aux attaques!",
	Vulnerable2			= "Le porteur du drapeau devient encore plus vulnérable aux attaques!",
	-- Gates
	GatesHealthFrame				= "Portes endommagées",
	HordeGateFront					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t Porte principale",
	HordeGateFrontDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t Porte principale",
	HordeGateWest					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t Porte de l'Ouest",
	HordeGateWestDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t Porte de l'Ouest",
	HordeGateEast					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t Porte de l'Est",
	HordeGateEastDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t Porte de l'Est",
	AllianceGateFront				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t Porte principale",
	AllianceGateFrontDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t Porte principale",
	AllianceGateWest				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t Porte de l'Ouest",
	AllianceGateWestDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t Porte de l'Ouest",
	AllianceGateEast				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t Porte de l'Est",
	AllianceGateEastDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t Porte de l'Est",
	-- Strands of the Ancients Gates emotes
	GreenEmeraldAttacked			= "La porte de l'Émeraude verte est attaquée !",
	GreenEmeraldDestroyed			= "La porte de l'Émeraude verte est détruite !",
	BlueSapphireAttacked			= "La porte du Saphir bleu est attaquée !",
	BlueSapphireDestroyed			= "La porte du Saphir bleu est détruite !",
	PurpleAmethystAttacked			= "La porte de l'Améthyste violette est attaquée !",
	PurpleAmethystDestroyed			= "La porte de l'Améthyste violette est détruite !",
	RedSunAttacked					= "La porte du Soleil rouge est attaquée !",
	RedSunDestroyed					= "La porte du Soleil rouge est détruite !",
	YellowMoonAttacked				= "La porte de la Lune jaune est attaquée !",
	YellowMoonDestroyed				= "La porte de la Lune jaune est détruite !",
	ChamberAncientRelicsAttacked	= "La salle de la relique est attaquée !",
	ChamberAncientRelicsDestroyed	= "La salle est envahie ! La relique des titans est vulnérable !",
	-- Isle of Conquest Gates CHAT_MSG_BG_SYSTEM_NEUTRAL messages
	HordeGateFrontDestroyedTC		= "La grande porte du donjon de la Horde est détruite !",
	HordeGateWestDestroyedTC		= "La porte ouest du donjon de la Horde est détruite !",
	HordeGateEastDestroyedTC		= "La porte est du donjon de la Horde est détruite !",
	AllianceGateFrontDestroyedTC	= "La grande porte du donjon de l'Alliance est détruite !",
	AllianceGateWestDestroyedTC		= "La porte ouest du donjon de l'Alliance est détruite !",
	AllianceGateEastDestroyedTC		= "La porte est du donjon de l'Alliance est détruite !",
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
	WarnSiegeEngineSoon	= "Alerter lorsque l'Engin de Siège est presque prêt"
})

L:SetMiscLocalization({
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
