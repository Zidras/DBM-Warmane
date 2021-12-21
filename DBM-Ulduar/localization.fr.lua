if GetLocale() ~= "frFR" then return end

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Léviathan des flammes"
}

L:SetWarningLocalization{
	PursueWarn				= "Poursuit >%s<!",
	warnNextPursueSoon		= "Changement de cible dans 5 Sec",
	SpecialPursueWarnYou	= "Vous êtes poursuivi !",
	warnWardofLife			= "Gardien de Vie vient d'arriver"
}

L:SetOptionLocalization{
	SpecialPursueWarnYou	= "Afficher l'avertissement spécial quand un joueur est poursuivi",
	PursueWarn				= "Afficher l'avertissement quand vous êtes poursuivi",
	warnNextPursueSoon		= "Prévenir avant la prochaine poursuite",
	warnWardofLife			= "Montre une alerte quand un Gardien de Vie arrive"
}

L:SetMiscLocalization{
	YellPull		= "Entités hostiles détectées. Protocole d'estimation de menace actif. Acquisition de la cible primaire. Décompte avant réévaluation : 30 secondes.",
	Emote			= "%%s poursuit (%S+)%."
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis le maître de la Fournaise"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Tranchécaille"
}

L:SetWarningLocalization{
	warnTurretsReadySoon		= "Quatrième tourelle à harpon prête dans 20 Sec",
	warnTurretsReady			= "Quatrième tourelle à harpon prête"
}

L:SetTimerLocalization{
	timerTurret1			= "Tourelle 1",
	timerTurret2			= "Tourelle 2",
	timerTurret3			= "Tourelle 3",
	timerTurret4			= "Tourelle 4",
	timerGrounded			= "Sur le sol"
}

L:SetOptionLocalization{
	warnTurretsReadySoon		= "Activer le pré-avertissement pour les tourelles",
	warnTurretsReady			= "Activer l'avertissement pour les tourelles",
	timerTurret1				= "Montre le timer pour la tourelle 1",
	timerTurret2				= "Montre le timer pour la tourelle 2",
	timerTurret3				= "Montre le timer pour la tourelle 3 (25 joueurs)",
	timerTurret4				= "Montre le timer pour la tourelle 4 (25 joueurs)",
	timerGrounded				= "Montre le timer pour la phase au sol"
}

L:SetMiscLocalization{
	YellAir				= "Laissez un instant pour préparer la construction des tourelles.",
	YellAir2			= "Incendie éteint ! Reconstruisons les tourelles !",
	YellGround			= "Faites vite ! Elle va pas rester au sol très longtemps !",
	EmotePhase2			= "bloquée au sol"
}

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "Déconstructeur XT-002"
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Assemblée du Fer"
}

L:SetWarningLocalization{
	WarningRuneofDeathIn10Sec = "Rune de mort ~10 sec."
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	PlaySoundLightningTendrils	= "Jouer un son pour les Vrilles d'éclair",
	SetIconOnOverwhelmingPower	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(61888),
	SetIconOnStaticDisruption	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(61912),
	AlwaysWarnOnOverload		= "Toujours alerter pour la surcharge (sinon seulement quand ciblé)",
	PlaySoundOnOverload			= "Joue un son à la surcharge",
	PlaySoundDeathRune			= "Joue un son pour les runes de mort"
}

L:SetMiscLocalization{
	Steelbreaker				= "Brise-acier",
	RunemasterMolgeim			= "Maître des runes Molgeim",
	StormcallerBrundir			= "Mande-foudre Brundir",
	YellPull1					= "Que vous soyez les plus grandes punaises ou les plus grands héros de ce monde, vous n'êtes jamais que des mortels.",
	YellPull2					= "Seule votre extermination complète me conviendra.",
	YellPull3					= "Vous ne vaincrez pas si facilement l'assemblée du Fer, envahisseurs !",
	YellRuneOfDeath				= "Déchiffrez donc ça !",
	YellRunemasterMolgeimDied	= "Que vous apporte ma chute ? Votre destin n'en est pas moins scellé, mortels.",
	YellRunemasterMolgeimDied2	= "L’héritage des tempêtes ne sera pas anéanti...",
	YellStormcallerBrundirDied	= "La puissance de la tempête survivra.",
	YellStormcallerBrundirDied2	= "Vous courez tout droit dans la gueule de la folie !!",
	YellSteelbreakerDied		= "Ma mort ne fera que hâter votre perte.",
	YellSteelbreakerDied2		= "Impossible..."
}

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon l'Observateur"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Prochain Choc cosmique",
	NextCosmicSmash			= "Prochain Choc cosmique possible",
	TimerCombatStart		= "Le combat débute dans"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Coup de poing phasique sur >%s<",
	WarningCosmicSmash 		= "Choc cosmique - Explosion dans 4 sec",
	WarnPhase2Soon			= "Phase 2 arrive bientôt",
	warnStarLow				= "Effondrement d'étoile est bas"
}

L:SetOptionLocalization{
	WarningPhasePunch		= "Annoncer la cible du Coup de poing phasique",
	NextCollapsingStar		= "Montre un timer pour le prochain choc cosmique",
	WarningCosmicSmash 		= "Annonce le Choc cosmique",
	NextCosmicSmash			= "Montre le timer pour un possible Choc cosmique",
	TimerCombatStart		= "Montre le timer avant le début du combat",
	WarnPhase2Soon			= "Affiche une pré-alerte pour la Phase 2 (à ~23%)",
	warnStarLow				= "Affiche une alerte spéciale lorsque Effondrement d'étoile est bas (à ~25%)"
}

L:SetMiscLocalization{
	YellPull				= "Vos actions sont illogiques. Tous les résultats possibles de cette rencontre ont été calculés. Le panthéon recevra le message de l'Observateur quelque soit l'issue.",
	YellPull2 				= "Vos actions sont illogiques. Tous les résultats possibles de cette rencontre ont été calculés. Le Panthéon recevra le message de l’Observateur quelle que soit l’issue.",
	YellKill				= "J’ai vu des mondes baignés dans les flammes des Faiseurs. Leurs occupants s’évaporer sans même un gémissement. Des systèmes planétaires entiers créés et détruits dans le temps qu’il faut à un cœur mortel pour battre une fois. Et devant tout cela, dans mon propre cœur, pas la moindre émotion... la moindre empathie. Je. Ne. Ressentais. Rien. Mille milliards de vies gâchées. Avaient-elles toutes possédé une telle ténacité ? Aimaient-elles la vie autant que vous ?",
	Emote_CollapsingStar	= "commence à lancer un effondrement",
	Phase2					= "Découvrez les outils de la création !",
	CollapsingStar			= "Effondrement d'étoile",
	PullCheck				= "Signal de détresse d'Algalon transmis dans= (%d+) min."
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerLeftArm		= "Repop du bras gauche",
	timerRightArm		= "Repop du bras droit",
	achievementDisarmed	= "Temps pour Désarmement"
}

L:SetOptionLocalization{
	timerLeftArm			= "Afficher un timer pour le repop du bras gauche",
	timerRightArm			= "Afficher un timer pour le repop du bras droit",
	achievementDisarmed		= "Afficher un timer pour le Haut Fait Désarmement",
	SetIconOnGripTarget		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(64292),
	SetIconOnEyebeamTarget	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(63346),
	PlaySoundOnEyebeam		= "Jouer un son au $spell:63346",
	YellOnBeam				= "Crier au $spell:63346"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "Juste une éraflure !",
	Yell_Trigger_arm_right	= "Une blessure superficielle !",
	YellEncounterStart		= "On ne passe pas !",
	YellLeftArmDies			= "Juste une éraflure !",
	YellRightArmDies		= "Une blessure superficielle !",
	Health_Body				= "Torse de Kologarn",
	Health_Right_Arm		= "Bras droit",
	Health_Left_Arm			= "Bras gauche",
	FocusedEyebeam			= "%s concentre son regard sur vous !",
	YellBeam				= "Rayon de l'œil focalisé sur moi !"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender = "Défenseur farouche (%d)",
	YellPull = "Certaines choses ne doivent pas être dérangées !"
}

L:SetTimerLocalization{
	timerDefender	= "Défenseur farouche activé"
}

L:SetWarningLocalization{
	SpecWarnBlast	= "Déflagration du factionnaire - Interrompu!",
	WarnCatDied		= "Défenseur farouche mort (%d vies restantes)",
	WarnCatDiedOne	= "Défenseur farouche mort (1 vie en moins)"
}

L:SetOptionLocalization{
	SpecWarnBlast	= "Activer l'avertissement spécial pour les Déflagration du factionnaire",
	WarnCatDied		= "Activer l'avertissement quand un défenseur farouche meurt",
	WarnCatDiedOne	= "Montre une alerte spéciale quand un Défenseur farouche meurt",
	timerDefender	= "Montre un timer quand le Défenseur farouche est activé"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	PlaySoundOnFlashFreeze	= "Jouer un son lors de l'incantation du gel instantané",
	YellOnStormCloud		= "Crie quand la tempête de glace est active",
	SetIconOnStormCloud		= "Met une icône sur la cible de la tempête de glace"
}

L:SetMiscLocalization{
	YellKill	= "Je suis... libéré de son emprise... enfin.",
	YellCloud	= "Tempête de glace sur moi!"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	TimerHardmode	= "Mode difficile"
}

L:SetOptionLocalization{
	TimerHardmode	= "Afficher le timer pour le mode difficile",
	RangeFrame		= "Afficher la fenêtre de portée",
	AnnounceFails	= "Affiche les joueurs qui n'ont pas évité les Charges de foudre (Nécessite l'activation des annonces et être promu ou leader)"
}

L:SetMiscLocalization{
	YellPhase1	= "Des intrus ! Mortels, vous qui osez me déranger en plein divertissement allez pay -  Attendez, vous -",
	YellPhase2	= "Avortons impertinents, vous osez me défier sur mon piédestal ? Je vais vous écraser moi-même !",
	YellKill	= "Retenez vos coups ! Je me rends !",
	ChargeOn	= "Charge(s) de foudre: %s",
	Charge		= "Charge(s) de foudre non évitée(s) (cet essai): %s"
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell			= "Mes enfants, venez m'aider !",
	WaterSpirit			= "Esprit de l'eau ancien",
	Snaplasher			= "Flagellant mordant",
	StormLasher			= "Flagellant des tempêtes",
	YellKill			= "Son emprise sur moi se dissipe. J'y vois à nouveau clair. Merci, héros.",
	YellAdds1			= "Eonar, ta servante a besoin d'aide !",
	YellAdds2			= "La nuée des éléments va vous submerger !",
	EmoteLGift			= "commence à grandir !",
	TrashRespawnTimer	= "Respawn des Trashs de Freya"
}

L:SetWarningLocalization{
	WarnSimulKill		= "Premier add mort - Résurrection dans 1 minute",
	WarningBeamsSoon	= "Rayons bientôt",
	EonarsGift			= "Changement de Cible - basculer vers Cadeau d'Eonar"
}

L:SetTimerLocalization{
	TimerSimulKill	= "Résurrection"
}

L:SetOptionLocalization{
	WarnSimulKill	= "Annonce la mort du premier mob",
	PlaySoundOnFury = "Joue un sons quand vous êtes affecté par la Fureur de la nature",
	WarnBeamsSoon	= "Afficher une alerte lorsque $spell:62865 arrive",
	TimerSimulKill	= "Montre le timer de la résurrection des mobs"
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freya's Elders"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Respawn des Trashs de Freya"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	PlaySoundOnFistOfStone	= "Joue un son à l'incantation des poings de pierre",
	TrashRespawnTimer		= "Montre le timer du repop des trashs"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	MagneticCore		= ">%s< vient de loot le Core Magnétique",
	WarningShockBlast	= "Horion explosif - BOUGEZ",
	WarnBombSpawn		= "Robot Bombe vient de pop",
	WarningFlamesIn5Sec = "Flammes dans 5 sec."
}

L:SetTimerLocalization{
	TimerHardmode	= "Hard Mode - Autodestruction",
	TimeToPhase2	= "Phase 2",
	TimeToPhase3	= "Phase 3",
	TimeToPhase4	= "Phase 4"
}

L:SetOptionLocalization{
	TimeToPhase2			= "Montre le timer pour la Phase 2",
	TimeToPhase3			= "Montre le timer pour la Phase 3",
	TimeToPhase4			= "Montre le timer pour la Phase 4",
	MagneticCore			= "Annonce qui a loot le Core Magnétique",
	HealthFramePhase4		= "Montre les barres de vie dans la phase 4",
	AutoChangeLootToFFA		= "Met le butin en accès libre durant la phase 3",
	WarnBombSpawn			= "Annonce les Robots Bombes",
	TimerHardmode			= "Montre le timer pour le Hard Mode",
	PlaySoundOnShockBlast	= "Joue un son lors des Horions explosifs",
	PlaySoundOnDarkGlare	= "Joue un son au Barrage laser",
	ShockBlastWarningInP1	= "Montre une alerte spéciale pour les Horions explosifs durant la Phase 1",
	ShockBlastWarningInP4	= "Montre une alerte spéciale pour les Horions explosifs durant la Phase 4",
	RangeFrame				= "Affiche la fenêtre de portée pour la phase 1",
	SetIconOnNapalm			= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(65026),
	SetIconOnPlasmaBlast	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(62997),
	WarnFlamesIn5Sec 		= "Afficher une alerte spéciale : Flammes dans 5 sec.",
	SoundWarnCountingFlames = "Jouer un compte-à-rebours de 5 sec. pour les prochaines flammes"
}

L:SetMiscLocalization{
	MobPhase1		= "Léviathan Mod. II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Unité de commandement aérien",
	YellPull		= "Nous n'avons pas beaucoup de temps, les amis ! Vous allez m'aider à tester ma dernière création en date, la plus grande de toutes. Avant de changer d'avis, n'oubliez pas que que vous me devez bien ça après m'avoir complètement déglingué le XT-002.",
	YellHardPull	= "Mais, pourquoi",
	YellPhase2		= "MERVEILLEUX ! Résultats parfaitement formidables !",
	YellPhase3		= "Merci, les amis !",
	YellPhase4		= "Fin de la phase d'essais préliminaires",
	YellKilled		= "Il semblerait que j'aie pu faire une minime erreur de calcul. J'ai permis à mon esprit de se laisser corrompre par ce démon dans la prison qui a désactivé ma directive principale. Tous les systèmes fonctionnent à nouveau. Terminé.",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "Général Vezax"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Arriver d'Animus de saronite"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "Déferlante d'ombre sur VOUS",
	SpecialWarningShadowCrashNear	= "Déferlante d'ombre à côté de VOUS!",
	SpecialWarningLLNear			= "Marque du Sans-visage sur %s à côté de VOUS!"
}

L:SetOptionLocalization{
	SetIconOnShadowCrash			= "met une icône sur la cible des Déferlante d'ombre ( Tête de mort )",
	SetIconOnLifeLeach				= "Met une icône sur la cible de la Marque du Sans-visage ( Croix )",
	SpecialWarningShadowCrash		= "Afficher une alerte spéciale pour $spell:62660\n(doit être en ciblé ou focus par au moins un membre du raid)",
	SpecialWarningShadowCrashNear	= "Montre une alerte spéciale quand la $spell:62660 à côté de vous",
	SpecialWarningLLNear			= "Montre une alerte spéciale quand la $spell:63276 est à côté de vous",
	YellOnLifeLeech					= "Crie pour la $spell:63276",
	YellOnShadowCrash				= "Crie pour la $spell:62660",
	hardmodeSpawn					= "Montre le timer pour l'arrivée d'Animus de saronite (Hard Mode)",
	CrashArrow						= "Afficher la flèche DBM lorsque $spell:62660 est proche de vous",
	BypassLatencyCheck				= "Don't use latency based sync check for $spell:62660\n(only use this if you're having problems otherwise)"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "nuage de vapeurs saronitiques",
	YellLeech			= "Marque du Sans-visage sur moi !",
	YellCrash			= "Déferlante d'ombre sur moi !"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 			= "Il sera bientôt temps de frapper la tête de la bête ! Concentrez votre rage et votre haine sur ses laquais !",
	YellPhase2			= "Je suis le rêve éveillé",
	Sara 				= "Sara",
	WarningYellSqueeze	= "Écrasement sur moi ! Aidez-moi !"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Un gardien vient d'arriver",
	WarningCrusherTentacleSpawned	= "Une Tentacule écraseur vient d'arriver",
	WarningSanity 					= "%d de Santé mentale restant",
	SpecWarnSanity 					= "%d de Santé mentale restant",
	SpecWarnGuardianLow				= "Arrêtez d'attaquer ce gardien !",
	SpecWarnMadnessOutNow			= "Incantation de Susciter la folie fini - SORTEZ",
	WarnBrainPortalSoon				= "Portail dans 3 sec",
	SpecWarnFervor					= "Ferveur de Sara sur VOUS",
	SpecWarnFervorCast				= "Ferveur de Sara commence a incanter sur vous",
	SpecWarnMaladyNear				= "Mal de la raison à côté de vous sur >%s<",
	specWarnBrainPortalSoon			= "Portail bientôt"
}

L:SetTimerLocalization{
	NextPortal	= "Portail du Cerveau"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Annonce l'arrivée des Gardiens",
	WarningCrusherTentacleSpawned	= "Annonce l'arrivée des Tentacules",
	WarningSanity					= "Montre une alerte quand la $spell:63050 est basse",
	SpecWarnSanity					= "Montre une alerte quand la $spell:63050 est très basse",
	SpecWarnGuardianLow				= "Montre une alerte spéciale quand les gardiens (P1) n'a plus beaucoup de vie",
	WarnBrainPortalSoon				= "Annonce les Portails",
	SpecWarnMadnessOutNow			= "Montre une alerte spéciale avant la fin du cast de Susciter la folie",
	SetIconOnFearTarget				= "Met une icône sur la cible du $spell:63881",
	SpecWarnFervorCast				= "Montre une alerte spéciale quand la $spell:63138 commence a cast sur vous (Il faut avoir Sara en Target/Focus)",
	specWarnBrainPortalSoon			= "Annonce l'arrivée d'un portail",
	WarningSqueeze					= "Annonce la cible d'Écrasement",
	NextPortal						= "Montre un timer avant le prochain portail",
	SetIconOnFervorTarget			= "Met une icône sur les cible de la $spell:63138",
	ShowSaraHealth					= "Montre la vie de Sara durant la P1 (Doit être sélectionnée par au moins un membre du raid)",
	SpecWarnMaladyNear				= "Montre une alerte spéciale si une personne à côté de vous est victime du $spell:63881",
	SetIconOnBrainLinkTarget		= "Met une icône sur la cible des Cerveaux liés",
	MaladyArrow						= "Afficher la flèche DBM lorsque $spell:63881 est proche de vous"
}
