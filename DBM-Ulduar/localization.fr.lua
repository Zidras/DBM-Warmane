if GetLocale() ~= "frFR" then return end

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization({
	name = "Léviathan des flammes"
})

L:SetWarningLocalization({
	PursueWarn				= "Poursuit >%s<!",
	warnNextPursueSoon		= "Changement de cible dans 5 Sec",
	SpecialPursueWarnYou	= "Vous êtes poursuivi !",
	warnWardofLife			= "Gardien de Vie vient d'arriver"
})

L:SetOptionLocalization({
	SpecialPursueWarnYou	= "Afficher l'avertissement spécial quand un joueur est poursuivi",
	PursueWarn				= "Afficher l'avertissement quand vous êtes poursuivi",
	warnNextPursueSoon		= "Prévenir avant la prochaine poursuite",
	warnWardofLife			= "Montre une alerte quand un Gardien de Vie arrive"
})

L:SetMiscLocalization({
	YellPull		= "Entités hostiles détectées. Protocole d'estimation de menace actif. Acquisition de la cible primaire. Décompte avant réévaluation : 30 secondes.",
	Emote			= "%%s poursuit (%S+)%."
})

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization({
	name = "Ignis le maître de la Fournaise"
})

L:SetOptionLocalization({
	soundConcAuraMastery	= "Jouer le son $spell:31821 pour annuler les effets de $spell:63472 (seulement pour le |cFFF48CBAPaladin|r qui est le propriétaire de $spell:19746)"
})

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization({
	name = "Tranchécaille"
})

L:SetWarningLocalization({
	warnTurretsReadySoon		= "Quatrième tourelle à harpon prête dans 20 Sec",
	warnTurretsReady			= "Quatrième tourelle à harpon prête"
})

L:SetTimerLocalization({
	timerTurret1			= "Tourelle 1",
	timerTurret2			= "Tourelle 2",
	timerTurret3			= "Tourelle 3",
	timerTurret4			= "Tourelle 4",
	timerGrounded			= "Sur le sol"
})

L:SetOptionLocalization({
	warnTurretsReadySoon		= "Activer le pré-avertissement pour les tourelles",
	warnTurretsReady			= "Activer l'avertissement pour les tourelles",
	timerTurret1				= "Montre le timer pour la tourelle 1",
	timerTurret2				= "Montre le timer pour la tourelle 2",
	timerTurret3				= "Montre le timer pour la tourelle 3 (25 joueurs)",
	timerTurret4				= "Montre le timer pour la tourelle 4 (25 joueurs)",
	timerGrounded				= "Montre le timer pour la phase au sol"
})

L:SetMiscLocalization({
	YellAir				= "Laissez un instant pour préparer la construction des tourelles.",
	YellAir2			= "Incendie éteint ! Reconstruisons les tourelles !",
	YellGround			= "Faites vite ! Elle va pas rester au sol très longtemps !",
	EmotePhase2			= "bloquée au sol"
})

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization({
	name = "Déconstructeur XT-002"
})

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization({
	name = "Assemblée du fer"
})

L:SetOptionLocalization({
	AlwaysWarnOnOverload		= "Toujours alerter pour la $spell:63481 (sinon seulement quand ciblé)"
})

L:SetMiscLocalization({
	Steelbreaker		= "Brise-acier",
	RunemasterMolgeim	= "Maître des runes Molgeim",
	StormcallerBrundir	= "Mande-foudre Brundir"
--	YellPull1					= "Que vous soyez les plus grandes punaises ou les plus grands héros de ce monde, vous n'êtes jamais que des mortels.",
--	YellPull2					= "Seule votre extermination complète me conviendra.",
--	YellPull3					= "Vous ne vaincrez pas si facilement l'assemblée du Fer, envahisseurs !",
--	YellRuneOfDeath				= "Déchiffrez donc ça !",
--	YellRunemasterMolgeimDied	= "Que vous apporte ma chute ? Votre destin n'en est pas moins scellé, mortels.",
--	YellRunemasterMolgeimDied2	= "L’héritage des tempêtes ne sera pas anéanti...",
--	YellStormcallerBrundirDied	= "La puissance de la tempête survivra.",
--	YellStormcallerBrundirDied2	= "Vous courez tout droit dans la gueule de la folie !!",
--	YellSteelbreakerDied		= "Ma mort ne fera que hâter votre perte.",
--	YellSteelbreakerDied2		= "Impossible..."
})

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization({
	name = "Algalon l'Observateur"
})

L:SetWarningLocalization({
	warnStarLow				= "Effondrement d'étoile est bas"
})

L:SetTimerLocalization({
	NextCollapsingStar		= "Prochain Choc cosmique",
})

L:SetOptionLocalization({
	NextCollapsingStar		= "Montre un timer pour le prochain choc cosmique",
	warnStarLow				= "Affiche une alerte spéciale lorsque Effondrement d'étoile est bas (à ~25%)"
})

L:SetMiscLocalization({
--	FirstPull				= "Voyez votre monde comme je le vois : un univers si vaste qu'il est incommensurable - impossible à appréhender même par vos plus grands esprits.",
--	YellPull				= "Vos actions sont illogiques. Tous les résultats possibles de cette rencontre ont été calculés. Le Panthéon recevra le message de l'Observateur quelle que soit l'issue.",
	YellKill				= "J'ai vu des mondes baignés dans les flammes des Faiseurs. Leurs occupants s'évaporer sans même un gémissement. Des systèmes planétaires entiers créés et détruits dans le temps qu'il faut à un cœur mortel pour battre une fois. Et devant tout cela, dans mon propre cœur, pas la moindre émotion... la moindre empathie. Je. Ne. Ressentais. Rien. Mille milliards de vies gâchées. Avaient-elles toutes possédé une telle ténacité ? Aimaient-elles la vie autant que vous ?",
	Emote_CollapsingStar	= "%s commence à lancer un effondrement d'étoiles !",
	Phase2					= "Découvrez les outils de la création !",
	CollapsingStar			= "Effondrement d'étoile"
})

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization({
	name = "Kologarn"
})

L:SetTimerLocalization({
	timerLeftArm			= "Repop du bras gauche",
	timerRightArm			= "Repop du bras droit",
	achievementDisarmed		= "Temps pour Désarmement"
})

L:SetOptionLocalization({
	timerLeftArm			= "Afficher un timer pour le repop du bras gauche",
	timerRightArm			= "Afficher un timer pour le repop du bras droit",
	achievementDisarmed		= "Afficher un timer pour le Haut Fait Désarmement"
})

L:SetMiscLocalization({
--	Yell_Trigger_arm_left	= "Juste une éraflure !",
--	Yell_Trigger_arm_right	= "Une blessure superficielle !",
--	YellEncounterStart		= "On ne passe pas !",
--	YellLeftArmDies			= "Juste une éraflure !",
--	YellRightArmDies		= "Une blessure superficielle !",
	Health_Body				= "Torse de Kologarn",
	Health_Right_Arm		= "Bras droit",
	Health_Left_Arm			= "Bras gauche",
	FocusedEyebeam			= "%s concentre son regard sur vous !"
})

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization({
	name = "Auriaya"
})

L:SetWarningLocalization({
	WarnCatDied			= "Défenseur farouche mort (%d vies restantes)",
	WarnCatDiedOne		= "Défenseur farouche mort (1 vie en moins)",
})

-- L:SetTimerLocalization({
-- 	timerDefender		= "Défenseur farouche activé"
-- })

L:SetOptionLocalization({
	WarnCatDied			= "Activer l'avertissement quand un défenseur farouche meurt",
	WarnCatDiedOne		= "Montre une alerte spéciale quand un Défenseur farouche meurt"
--	timerDefender		= "Montre un timer quand le Défenseur farouche est activé"
})

L:SetMiscLocalization({
	Defender			= "Défenseur farouche (%d)",
	YellPull			= "Certaines choses ne doivent pas être dérangées !"
})

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization({
	name = "Hodir"
})

L:SetMiscLocalization({
	Pull			= "Vous allez souffrir pour cette intrusion !",
	YellKill		= "Je suis... libéré de son emprise... enfin.",
})

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization({
	name = "Thorim"
})

L:SetTimerLocalization({
	TimerHardmode	= "Mode difficile"
})

L:SetOptionLocalization({
	specWarnHardmode		= "Afficher une alerte spéciale lorsque le Mode difficile est activé",
	TimerHardmode			= "Afficher le timer pour le mode difficile",
	AnnounceFails			= "Affiche les joueurs qui n'ont pas évité les Charges de foudre (Nécessite l'activation des annonces et être promu ou leader)"
})

L:SetMiscLocalization({
	YellPhase1			= "Des intrus ! Mortels, vous qui osez me déranger en plein divertissement allez pay -  Attendez, vous -",
	YellPhase2			= "Avortons impertinents, vous osez me défier sur mon piédestal ? Je vais vous écraser moi-même !",
	YellKill			= "Retenez vos coups ! Je me rends !",
	YellHardModeActive	= "Impossible ! Mon seigneur Thorim, je vais offrir à tes ennemis une mort glaciale !",
	YellHardModeFailed	= "Ces pitoyables mortels sont inoffensifs, indignes de m'affronter. Débarrasse-toi d'eux !",
	ChargeOn			= "Charge(s) de foudre: %s",
	Charge				= "Charge(s) de foudre non évitée(s) (cet essai): %s"
})

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization({
	name = "Freya"
})

L:SetWarningLocalization({
	WarnSimulKill	= "Premier add mort - Résurrection dans 1 minute"
})

L:SetTimerLocalization({
	TimerSimulKill	= "Résurrection"
})

L:SetOptionLocalization({
	WarnSimulKill	= "Annonce la mort du premier mob",
	TimerSimulKill	= "Montre le timer de la résurrection des mobs"
})

L:SetMiscLocalization({
	SpawnYell			= "Mes enfants, venez m'aider !",
	WaterSpirit			= "Esprit de l'eau ancien",
	Snaplasher			= "Flagellant mordant",
	StormLasher			= "Flagellant des tempêtes",
	YellKill			= "Son emprise sur moi se dissipe. J'y vois à nouveau clair. Merci, héros.",
	YellAdds1			= "Eonar, ta servante a besoin d'aide !",
	YellAdds2			= "La nuée des éléments va vous submerger !",
	EmoteLGift			= "commence à pousser !", -- Un |cFF00FFFFdon de la Lieuse-de-vie|r commence à pousser !
	TrashRespawnTimer	= "Respawn des Trashs de Freya",
	YellPullNormal		= "Le jardin doit être protégé !",
	YellPullHard		= "Anciens, donnez-moi votre force !"
})

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization({
	name = "Freya's Elders"
})

L:SetOptionLocalization({
	TrashRespawnTimer	= "Montre le timer du repop des trashs"
})

L:SetMiscLocalization({
	TrashRespawnTimer	= "Respawn des Trashs de Freya"
})

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization({
	name = "Mimiron"
})

L:SetWarningLocalization({
	MagneticCore		= ">%s< vient de loot le Core Magnétique",
	WarnBombSpawn		= "Robot Bombe vient de pop"
})

L:SetTimerLocalization({
	TimerHardmode		= "Hard Mode - Autodestruction",
	TimeToPhase2		= "Phase 2",
	TimeToPhase3		= "Phase 3",
	TimeToPhase4		= "Phase 4"
})

L:SetOptionLocalization({
	TimeToPhase2			= "Montre le timer pour la Phase 2",
	TimeToPhase3			= "Montre le timer pour la Phase 3",
	TimeToPhase4			= "Montre le timer pour la Phase 4",
	MagneticCore			= "Annonce qui a loot le Core Magnétique",
	AutoChangeLootToFFA		= "Met le butin en accès libre durant la phase 3",
	WarnBombSpawn			= "Annonce les Robots Bombes",
	TimerHardmode			= "Montre le timer pour le Hard Mode"
})

L:SetMiscLocalization({
	MobPhase1		= "Léviathan Mod. II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Unité de commandement aérien",
	MobPhase4		= "V-07-TR-0N", -- don't localize
	YellPull		= "Nous n'avons pas beaucoup de temps, les amis ! Vous allez m'aider à tester ma dernière création en date, la plus grande de toutes. Avant de changer d'avis, n'oubliez pas que que vous me devez bien ça après m'avoir complètement déglingué le XT-002.",
	YellHardPull	= "Initialisation de la séquence d'autodestruction.",
	YellPhase2		= "MERVEILLEUX ! Résultats parfaitement formidables !",
	YellPhase3		= "Merci, les amis !",
	YellPhase4		= "Fin de la phase d'essais préliminaires",
	YellKilled		= "Il semblerait que j'aie pu faire une minime erreur de calcul. J'ai permis à mon esprit de se laisser corrompre par ce démon dans la prison qui a désactivé ma directive principale. Tous les systèmes fonctionnent à nouveau. Terminé.",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
})

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization({
	name = "Général Vezax"
})

L:SetTimerLocalization({
	hardmodeSpawn = "Arriver d'Animus de saronite"
})

L:SetOptionLocalization({
	hardmodeSpawn		= "Montre le timer pour l'arrivée d'Animus de saronite (Hard Mode)",
	CrashArrow			= "Afficher la flèche DBM lorsque $spell:62660 est proche de vous"
})

L:SetMiscLocalization({
	EmoteSaroniteVapors	= "nuage de vapeurs saronitiques"
})

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization({
	name = "Yogg-Saron"
})


L:SetWarningLocalization({
	WarningGuardianSpawned			= "Un gardien vient d'arriver",
	WarningCrusherTentacleSpawned	= "Une Tentacule écraseur vient d'arriver",
	WarningSanity					= "%d de Santé mentale restant",
	SpecWarnSanity					= "%d de Santé mentale restant",
	SpecWarnGuardianLow				= "Arrêtez d'attaquer ce gardien !",
	SpecWarnMadnessOutNow			= "Incantation de Susciter la folie fini - SORTEZ",
	WarnBrainPortalSoon				= "Portail dans 10 sec",
	SpecWarnBrainPortalSoon			= "Portail bientôt"
})

L:SetTimerLocalization({
	NextPortal	= "Portail du Cerveau"
})

L:SetOptionLocalization({
	WarningGuardianSpawned			= "Annonce l'arrivée des Gardiens",
	WarningCrusherTentacleSpawned	= "Annonce l'arrivée des Tentacules",
	WarningSanity					= "Montre une alerte quand la $spell:63050 est basse",
	SpecWarnSanity					= "Montre une alerte quand la $spell:63050 est très basse",
	SpecWarnGuardianLow				= "Montre une alerte spéciale quand les gardiens (P1) n'a plus beaucoup de vie",
	WarnBrainPortalSoon				= "Annonce les Portails",
	SpecWarnMadnessOutNow			= "Montre une alerte spéciale avant la fin du cast de Susciter la folie",
	SpecWarnBrainPortalSoon			= "Annonce l'arrivée d'un portail",
	NextPortal						= "Montre un timer avant le prochain portail",
	ShowSaraHealth					= "Montre la vie de Sara durant la P1 (Doit être sélectionnée par au moins un membre du raid)",
	MaladyArrow						= "Afficher la flèche DBM lorsque $spell:63881 est proche de vous"
})

L:SetMiscLocalization({
	YellPull1			= "Il sera bientôt temps de frapper la tête de la bête ! Concentrez votre rage et votre haine sur ses laquais !",
	S1TheLucidDream		= "Phase 1 : Le rêve lucide",
	Sara				= "Sara",
	GuardianofYoggSaron	= "Gardien de Yogg-Saron",
	S2DescentIntoMadness= "Phase 2 : La Descente dans la folie",
	CrusherTentacle		= "Tentacule écraseur",
	CorruptorTentacle	= "Tentacule corrupteur",
	ConstrictorTentacle	= "Tentacule constricteur",
	DescentIntoMadness	= "Descente dans la folie",
	InfluenceTentacle	= "Tentacule d’influence",
	LaughingSkull		= "Crâne-Ricanant",
	BrainofYoggSaron	= "Cerveau de Yogg-Saron",
	S3TrueFaceofDeath	= "Phase 3 : le vrai visage de la mort",
	YoggSaron			= "Yogg-Saron",
	ImmortalGuardian	= "Gardien immortel"
})
