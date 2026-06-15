if GetLocale() ~= "frFR" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "Anub'Rekhan"
})

L:SetOptionLocalization({
	ArachnophobiaTimer	= "Activer le timer pour l'arachnophobie (HAUT-FAIT)"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Arachnophobie",
	Pull1				= "Oui, courez ! Faites circuler le sang !",
	Pull2				= "Rien qu'une petite bouchée…"
})

----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "Grande Veuve Faerlina"
})

L:SetWarningLocalization({
	WarningEmbraceExpire	= "Fin du baisé de la veuve dans 5 sec"
})

L:SetOptionLocalization({
	WarningEmbraceExpire	= "Activer l'avertissement de fin du baisé de la veuve"
})

L:SetMiscLocalization({
	Pull					= "À genoux, vermisseau !"--Not actually pull trigger, but often said on pull
})

---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "Maexxna"
})

L:SetWarningLocalization({
	WarningSpidersSoon	= "Araignées dans 5 sec",
	WarningSpidersNow	= "Arrivée des araignées!"
})

L:SetTimerLocalization({
	TimerSpider			= "Araignées"
})

L:SetOptionLocalization({
	WarningSpidersSoon	= "Activer le pré-avertissement pour les araignées",
	WarningSpidersNow	= "Activer l'avertissement pour les araignées",
	TimerSpider			= "Montre le timer pour l'arrivée des araignées"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Arachnophobie"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "Noth le Porte-peste"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "Téléportation!",
	WarningTeleportSoon		= "Téléportation dans in 10 sec"
})

L:SetTimerLocalization({
	TimerTeleport			= "Téléportation",
	TimerTeleportBack		= "Retour de TP"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Activer l'avertissement pour la téléporation",
	WarningTeleportSoon		= "Activer le pré-avertissement pour la téléporation",
	TimerTeleport			= "Activer le timer pour la téléporation",
	TimerTeleportBack		= "Activer le timer pour le retour de North"
})

L:SetMiscLocalization({
	Pull				= "Mourez, intrus !",
	Adds				= "invoque des guerriers squelettes !",
	AddsTwo				= "lève encore d'autres squelettes !"
})

--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Heigan l'Impur"
})

L:SetWarningLocalization({
	WarningTeleportNow		= "Téléportation!",
	WarningTeleportSoon		= "Téléporation dans %d sec"
})

L:SetTimerLocalization({
	TimerTeleport			= "Téléporation"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Activer l'avertissement de Téléporation",
	WarningTeleportSoon		= "Activer le pré-avertissement de Téléporation",
	TimerTeleport			= "Activer le timer pour la Téléporation"
})

L:SetMiscLocalization({
	Pull					= "Vous êtes à moi, maintenant."
})

---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Horreb"
})

L:SetWarningLocalization({
	WarningHealSoon		= "Soins possibles dans 3 sec",
	WarningHealNow		= "SOIGNEZ MAINTENANT!"
})

L:SetOptionLocalization({
	WarningHealSoon		= "Activer l'avertissement \"Soins dans 3 sec\" ",
	WarningHealNow		= "Activer l'avertissement \"SOIGNEZ MAINTENANT\" ",
	SporeDamageAlert	= "Envoyer un murmure et annoncer aux joueurs de raid qui endommagent les spores\n(nécessite que l'annonce soit activée et le statut de leader/promu)",
	CorruptedSorting	= "Set infoframe sorting behaviour for $spell:55593", -- translation missing
	Alphabetical		= "Sort in alphabetical order", -- translation missing
	Duration			= "Sort by duration" -- translation missing
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Le recousu"
})

L:SetOptionLocalization({
	WarningHateful	= "Annoncer les Frappes Haineuses au raid\n(vous devez être promote ou le raid leader pour le faire)"
})

L:SetMiscLocalization({
	yell1			= "R'cousu veut jouer !",
	yell2			= "R'cousu avatar de guerre pour Kel'Thuzad !",
	HatefulStrike	= "Frappe Haineuse --> %s [%s]"
})

-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
	name = "Grobbulus"
})

-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name = "Gluth"
})

----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "Thaddius"
})

L:SetWarningLocalization({
	WarningChargeChanged	= "Polarité changée : %s",
	WarningChargeNotChanged	= "Même polarité"
})

L:SetOptionLocalization({
	WarningChargeChanged	= "Activer l'avertissement spécial quand votre polarité a changé",
	WarningChargeNotChanged	= "Activer l'avertissement spécial quand votre polarité n'a pas changé",
	TimerShiftCast			= "Afficher le timer pour le cast du changement de polarité",
	ArrowsEnabled			= "Afficher les flèches (stratégie normale : \"2 camps\")",
	ArrowsRightLeft			= "Afficher les flèches droite/gauche pour la stratégie \"4 camps\" (flèche gauche si la polarité a changé et droite sinon)",
	ArrowsInverse			= "Inverser la statégie \"4 camps\" (afficher la flèche droite si la polarité a changé et la gauche sinon)"
})

L:SetMiscLocalization({
	Yell					= "Stalagg écraser toi !",
	Emote					= "%s entre en surcharge !",
	Emote2					= "Bobine de Tesla entre en surcharge !",
	Boss1					= "Feugen",
	Boss2					= "Stalagg",
	Charge1					= "négative",
	Charge2					= "positive"
})

-----------------
--  Razuvious  --
-----------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "Razuvious"
})

L:SetWarningLocalization({
	WarningShieldWallSoon	= "Mur de Bouclier expire dans 5 sec"
})

L:SetOptionLocalization({
	WarningShieldWallSoon	= "Activer l'avertissement du Mur de Bouclier"
})

L:SetMiscLocalization({
	Yell1					= "Pas de quartier !",
	Yell2					= "Les cours sont terminés ! Montrez-moi ce que vous avez appris !",
	Yell3					= "Faites ce que vous ai appris !",
	Yell4					= "Frappe-le à la jambe"
})

--------------
--  Gothik  --
--------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "Gothik"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "Vague %d: %s dans 3 sec",
	WarningWaveSpawned	= "Vague %d: %s arrivée",
	WarningRiderDown	= "Cavalier down",
	WarningKnightDown	= "Chevalier down",
	WarningPhase2		= "Phase 2"
})

L:SetTimerLocalization({
	TimerWave			= "Vague #%d",
	TimerPhase2			= "Phase 2"
})

L:SetOptionLocalization({
	TimerWave			= "Afficher le timer des vagues",
	TimerPhase2			= "Afficher le timer pour la Phase 2",
	WarningWaveSoon		= "Activer le pré-avertissement pour les Vagues",
	WarningWaveSpawned	= "Avertir quand une vague est arrivée",
	WarningRiderDown	= "Avertir quand un Cavalier meurt",
	WarningKnightDown	= "Avertir quand un Chevalier meurt",
	WarningPhase2		= "Activer l'avertissement pour la Phase 2"
})

L:SetMiscLocalization({
	yell				= "Dans votre folie, vous avez provoqué votre propre mort.",
	WarningWave1		= "%d %s",
	WarningWave2		= "%d %s et %d %s",
	WarningWave3		= "%d %s, %d %s et %d %s",
	Trainee				= "Recrues",
	Knight				= "Chevaliers",
	Rider				= "Cavaliers"
})

----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Les quatre Cavaliers"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Marque %d dans 3 sec",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetOptionLocalization({
	WarningMarkSoon				= "Activer le pré-avertissement des Marques",
	SpecialWarningMarkOnPlayer	= "Avertissement spécial quand vous avez plus de 4 marques sur vous"
})

L:SetMiscLocalization({
	Korthazz					= "Thane Korth'azz",
	Rivendare					= "Baron Vaillefendre",
	Blaumeux					= "Dame Blaumeux",
	Zeliek						= "Sire Zeliek"
})

-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "Sapphiron"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon	= "Envol dans 10 sec",
	WarningAirPhaseNow	= "Dans les airs",
	WarningLanded		= "Atterrissage de Sapphiron",
	WarningDeepBreath	= "Souffle de givre !",
	SpecWarnSapphLow	= "Sapphiron ne peut pas voler !"
})

L:SetTimerLocalization({
	TimerAir			= "Envol",
	TimerLanding		= "Atterrissage dans",
	TimerIceBlast		= "Souffle de givre"
})

L:SetOptionLocalization({
	WarningAirPhaseSoon	= "Activer le pré-avertissement de la phase en vol",
	WarningAirPhaseNow	= "Activer l'avertissement de la phase en vol",
	WarningLanded		= "Activer l'avertissement pour la phase au sol",
	TimerAir			= "Afficher le timer de la phase en vol",
	TimerLanding		= "Afficher le timer de l'atterrissage",
	TimerIceBlast		= "Afficher le timer du Souffle de givre",
	WarningDeepBreath	= "Activer l'avertissement spécial pour le Souffle de givre",
	SpecWarnSapphLow	= "Avertissement spécial pour la phase d'exécution à 10 % (annulation de la phase d'air)"
})

L:SetMiscLocalization({
	EmoteBreath			= "prend une grande inspiration",
	AirPhase			= "Saphiron s'envole !",
	LandingPhase		= "Saphiron reprend ses attaques !"
})

------------------
--  Kel'thuzad  --
------------------
L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "Kel'Thuzad"
})

L:SetWarningLocalization({
	specwarnP2Soon		= "Kel'Thuzad sera actif dans 10 secondes",
	WeaponsStatus		= "Auto-déséquipement activé: %s (%s - %s)"
})

L:SetTimerLocalization({
	TimerPhase2				= "Phase 2",
	BlastTimer				= "Heal Maintenant !"
})

L:SetOptionLocalization({
	TimerPhase2			= "Afficher le timer pour la Phase 2",
	specwarnP2Soon		= "Montre un timer pour prévenir 10 secondes avant l'arrivée de Kel'Thuzad",
	WeaponsStatus		= "Alerte spéciale si la fonction de déséquipement n'est pas active au début du combat",
	EqUneqWeaponsKT		= "Déséquipez et équipez automatiquement les armes avant et après $spell:28410. Nécessite un ensemble d'équipement nommé \"pve\"",
	EqUneqWeaponsKT2	= "Déséquiper et équiper automatiquement les armes lorsque $spell:28410 est lancé sur VOUS. Nécessite un ensemble d'équipement nommé \"pve\"",
	RemoveBuffsOnMC		= "Retirez les buffs lorsque $spell:28410 est lancé sur vous. Chaque option est cumulative.",
	Gift				= "Supprimer $spell:48469 / $spell:48470. Approche minimale pour éviter $spell:33786 résistances.",
	CCFree				= "+ Supprimer $spell:48169 / $spell:48170. Tient compte des résistances des sorts de l'école de l'ombre.",
	ShortOffensiveProcs	= "+ Supprimer les procs offensifs qui ont une faible durée. Recommandé pour la sécurité du raid sans compromettre les dégâts du raid.",
	MostOffensiveBuffs	= "+ Supprimer la plupart des buffs offensifs (principalement pour les Casters et les |cFFFF7C0AFarouche Druide|r). Sécurité maximale pour les raids avec une perte de dégâts et la nécessité de s'auto-rebuffer/shapeshift!"
})

L:SetMiscLocalization({
	Yell		= "Serviteurs, valets et soldats des ténèbres glaciales ! Répondez à l'appel de Kel'Thuzad !",
	Yell1Phase2	= "Faites vos prières !", -- 12995
	Yell2Phase2	= "Hurlez et expirez !", -- 12996
	Yell3Phase2	= "Votre fin est proche !", -- 12997
	YellPhase3	= "Maître, j'ai besoin d'aide !", -- 12998
	YellGuardians	= "Très bien. Guerriers des terres gelées, relevez-vous ! Je vous ordonne de combattre, de tuer et de mourir pour votre maître ! N'épargnez personne !", -- 12994
	setMissing	= "ATTENTION! DBM auto-déséquipement d'arme ne fonctionnera pas tant que vous n'aurez pas créer un set apellé pve",
	EqUneqLineDescription	= "Équiper/Déséquiper automatiquement"
})
