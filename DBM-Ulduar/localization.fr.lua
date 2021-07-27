if GetLocale() ~= "frFR" then return end

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Léviathan des flammes"
}

L:SetTimerLocalization{
}

L:SetMiscLocalization{
	YellPull	= "Entités hostiles détectées. Protocole d'estimation de menace actif. Acquisition de la cible primaire. Décompte avant réévaluation : 30 secondes.",
	YellPull2	= "Orbital countermeasures enabled.", --Needs Translating
	Emote		= "%%s poursuit (%S+)%."
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

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis le maître de la Fournaise"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SlagPotIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(63477)
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
	warnTurretsReady			= "Quatrième tourelle à harpon prête",
	SpecWarnDevouringFlameCast	= "Flamme dévorante sur Vous",
	WarnDevouringFlameCast		= "Flamme dévorante sur >%s<"
}

L:SetTimerLocalization{
	timerTurret1	= "Tourelle 1",
	timerTurret2	= "Tourelle 2",
	timerTurret3	= "Tourelle 3",
	timerTurret4	= "Tourelle 4",
	timerGrounded	= "Sur le sol"
}

L:SetOptionLocalization{
	PlaySoundOnDevouringFlame	= "Jouer un son quand vous êtes affecté par la Flamme dévorante",
	warnTurretsReadySoon		= "Activer le pré-avertissement pour les tourelles",
	warnTurretsReady			= "Activer l'avertissement pour les tourelles",
	SpecWarnDevouringFlameCast	= "Montre une alerte spéciale quand les Flammes dévorantes sont cast sur Vous",
	timerTurret1				= "Montre le timer pour la tourelle 1",
	timerTurret2				= "Montre le timer pour la tourelle 2",
	timerTurret3				= "Montre le timer pour la tourelle 3 (Héroique)",
	timerTurret4				= "Montre le timer pour la tourelle 4 (Héroique)",
	OptionDevouringFlame		= "Annonce la cible des Flammes dévorantes (Incertain)",
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

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarningTTIn10Sec			= "Tympanic Tantrum in 10 sec." --Needs Translating
}

L:SetOptionLocalization{
	SetIconOnLightBombTarget		= "Mettre un icône sur la cible de la bombe de lumière",
	SetIconOnGravityBombTarget		= "Mettre un icône sur la cible de la bombe à gravité",
	WarningTympanicTantrumIn10Sec	= "Show special pre-warning (10 sec.) for $spell:62776 " --Needs Translating
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
	YellPull1					= "Whether the world's greatest gnats or the world's greatest heroes, you're still only mortal!", --Needs Translating
	YellPull2					= "Nothing short of total decimation will suffice.", --Needs Translating
	YellPull3					= "You will not defeat the Assembly of Iron so easily, invaders!", --Needs Translating
	YellRuneOfDeath				= "Decipher this!", --Needs Translating
	YellRunemasterMolgeimDied	= "What have you gained from my defeat? You are no less doomed, mortals!", --Needs Translating
	YellRunemasterMolgeimDied2	= "The legacy of storms shall not be undone.", --Needs Translating
	YellStormcallerBrundirDied	= "The power of the storm lives on...", --Needs Translating
	YellStormcallerBrundirDied2	= "You rush headlong into the maw of madness!", --Needs Translating
	YellSteelbreakerDied		= "My death only serves to hasten your demise.", --Needs Translating
	YellSteelbreakerDied2		= "Impossible!" --Needs Translating
}

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon l'Observateur"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Prochain choc cosmique",
	NextCosmicSmash			= "Prochain Choc cosmique possible",
	TimerCombatStart		= "Le combat débute dans"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Coup de poing phasique sur >%s<",
	WarningCosmicSmash 		= "Choc cosmique - Explosion dans 4 sec",
	WarnPhase2Soon			= "Phase 2 soon", --Needs Translating
	warnStarLow				= "Collapsing Star is low" --Needs Translating
}

L:SetOptionLocalization{
	WarningPhasePunch		= "Annoncer la cible du Coup de poing phasique",
	NextCollapsingStar		= "Montre un timer pour le prochain choque cosmique",
	WarningCosmicSmash 		= "Annonce le Choc cosmique",
	NextCosmicSmash			= "Montre le timer pour un possible Choc cosmique",
	TimerCombatStart		= "Montre le timer avant le début du combat",
	WarnPhase2Soon			= "Show pre-warning for Phase 2 (at ~23%)", --Needs Translating
	warnStarLow				= "Show special warning when Collapsing Star is low (at ~25%)" --Needs Translating
}

L:SetMiscLocalization{
	YellPull				= "Vos actions sont illogiques. Tous les résultats possibles de cette rencontre ont été calculés. Le panthéon recevra le message de l'Observateur quelque soit l'issue.",
	YellPull2 				= "Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer's message regardless of outcome.", --Needs Translating
	YellKill				= "I have seen worlds bathed in the Makers' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?", --Needs Translating
	Emote_CollapsingStar	= "commence à lancer un effondrement",
	Phase2					= "Behold the tools of creation", --Needs Translating
	CollapsingStar			= "Collapsing Star", --Needs Translating
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
	PlaySoundOnEyebeam		= "Play sound on $spell:63346", --Needs Translating
	YellOnBeam				= "Yell on $spell:63346" --Needs Translating
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "Juste une éraflure !",
	Yell_Trigger_arm_right	= "Une blessure superficielle !",
	YellEncounterStart		= "None shall pass!", --Needs Translating
	YellLeftArmDies			= "Just a scratch!", --Needs Translating
	YellRightArmDies		= "Only a flesh wound!", --Needs Translating
	Health_Body				= "Torse de Kologarn",
	Health_Right_Arm		= "Bras droit",
	Health_Left_Arm			= "Bras gauche",
	FocusedEyebeam			= "%s concentre son regard sur vous !",
	YellBeam				= "Focused Eyebeam on me!"
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
	YellAdds1			= "Eonar, your servant requires aid!", --Needs Translating
	YellAdds2			= "The swarm of the elements shall overtake you!", --Needs Translating
	EmoteLGift			= "begins to grow!", --Needs Translating
	TrashRespawnTimer	= "Respawn des Trashs de Freya"
}

L:SetWarningLocalization{
	WarnSimulKill		= "Premier add mort - Résurrection dans 1 minute",
	WarningBeamsSoon	= "Beams soon", --Needs Translating
	EonarsGift			= "Target Change - switch to Eonar's Gift" --Needs Translating
}

L:SetTimerLocalization{
	TimerSimulKill	= "Résurrection"
}

L:SetOptionLocalization{
	WarnSimulKill	= "Annonce la mort du premier mob",
	PlaySoundOnFury = "Joue un sons quand vous êtes affecter par la Fureur de la nature",
	WarnBeamsSoon	= "Show a warning for $spell:62865 is soon", --Needs Translating
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
	WarningFlamesIn5Sec = "Flames in 5 sec." --Needs Translating
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
	WarnFlamesIn5Sec 		= "Show special warning: Flames in 5 sec.", --Needs Translating
	SoundWarnCountingFlames = "Play a 5 second audio countdown for next flames" --Needs Translating
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
	YellKilled		= "It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison. overriding my primary directive. All systems seem to be functional now. Clear.", --Needs Translating
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
	SpecialWarningShadowCrash		= "Show special warning for $spell:62660\n(must be targeted or focused by at least one raid member)", --Needs Translating
	SpecialWarningShadowCrashNear	= "Montre une alerte spéciale quand la $spell:62660 à côté de vous",
	SpecialWarningLLNear			= "Montre une alerte spéciale quand la $spell:63276 est à côté de vous",
	YellOnLifeLeech					= "Crie pour la $spell:63276",
	YellOnShadowCrash				= "Crie pour la $spell:62660",
	hardmodeSpawn					= "Montre le timer pour l'arriver d'Animus de saronite (Hard Mode)",
	CrashArrow						= "Show DBM arrow when $spell:62660 is near you", --Needs Translating
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
	WarningYellSqueeze	= "Ecrasement sur moi ! Aidez-moi !"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "Un gardien vient d'arriver",
	WarningCrusherTentacleSpawned	= "Une Tentacule écraseur vient d'arriver",
	WarningSanity 					= "%d de Santé mentale restant",
	SpecWarnSanity 					= "%d de Santé mentale restant",
	SpecWarnGuardianLow				= "Arretez d'attaquer ce gardien !",
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
	WarningSqueeze					= "Annonce la cible d'Ecrasement",
	NextPortal						= "Montre un timer avant le prochain portail",
	SetIconOnFervorTarget			= "Met une icône sur les cible de la $spell:63138",
	ShowSaraHealth					= "Montre la vie de Sara durant la P1 (Doit être sélectionnée par au moins un membre du raid)",
	SpecWarnMaladyNear				= "Montre une alerte spéciale si une personne à côté de vous est victime du $spell:63881",
	SetIconOnBrainLinkTarget		= "Met une icone sur la cible des Cerveaux liés",
	MaladyArrow						= "Show DBM arrow when $spell:63881 is near you" --Needs Translating
}
