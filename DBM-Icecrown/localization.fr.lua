if GetLocale() ~= "frFR" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "Seigneur Gargamoelle"
})

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization({
	name = "Dame Murmemort"
})

L:SetTimerLocalization({
	TimerAdds	= "Nouveaux Adds"
})

L:SetWarningLocalization({
	WarnReanimating				= "Les adds revivent",
	WarnAddsSoon				= "Nouveaux adds bientôt",
	SpecWarnVengefulShade		= "Ombre vengeresse vous attaque - COUREZ",
	WeaponsStatus				= "Auto-déséquipement activé: %s (%s - %s)"
})

L:SetOptionLocalization({
	WarnAddsSoon				= "Montre une pré-alerte avant que les adds arrivent",
	WarnReanimating				= "Montre une alerte quand les adds vont revenir à la vie",
	TimerAdds					= "Montre le timer pour les nouveaux adds",
	SpecWarnVengefulShade		= "Montre une alerte spéciale quand vous êtes attaquer par une Ombre vengeresse",
	WeaponsStatus				= "Alerte spéciale si la fonction de déséquipement n'est pas active au début du combat",
	ShieldHealthFrame			= "Montre la vie du boss avec une barre de vie pour la $spell:70842",
	SoundWarnCountingMC			= "Jouer un son à 5 secondes du Contrôle mental",
--	RemoveDruidBuff				= "Retire $spell:48469 / $spell:48470 24 secondes après le début du combat",
	RemoveBuffsOnMC				= "Retirez les buffs lorsque $spell:71289 est lancé sur vous. Chaque option est cumulative.",
	Gift						= "Supprimer $spell:48469 / $spell:48470. Approche minimale pour éviter $spell:33786 résistances.",
	CCFree						= "+ Supprimer $spell:48169 / $spell:48170. Tient compte des résistances des sorts de l'école de l'ombre.",
	ShortOffensiveProcs			= "+ Supprimer les procs offensifs qui ont une faible durée. Recommandé pour la sécurité du raid sans compromettre les dégâts du raid.",
	MostOffensiveBuffs			= "+ Supprimer la plupart des buffs offensifs (principalement pour les Casters et les |cFFFF7C0AFarouche Druide|r). Sécurité maximale pour les raids avec une perte de dégâts et la nécessité de s'auto-rebuffer/shapeshift!",
	EqUneqWeapons				= "Retire/équipe les armes si le $spell:71289 est lancé sur vous. Pour que cela fonctionne, créez un set appellé \"pve\".",
	EqUneqTimer					= "Retire les armes à CHAQUE fois selon le timer (si votre ping est élevé). L'option de dessus doit être active."
})

L:SetMiscLocalization({
	YellReanimatedFanatic	= "Lève-toi, dans l'exultation de cette nouvelle pureté",
	ShieldPercent			= "Barrière de mana",
--	Fanatic1				= "Membres du culte",
--	Fanatic2				= "Fanatique déformé",
--	Fanatic3				= "Fanatique réanimé",
	setMissing				= "ATTENTION! DBM auto-déséquipement d'arme ne fonctionnera pas tant que vous n'aurez pas créer un set apellé pve",
	EqUneqLineDescription	= "Équiper/Déséquiper automatiquement"
})

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization({
	name = "Bataille des canonnières"
})

L:SetWarningLocalization({
	WarnAddsSoon	= "Nouveaux Add Bientôt"
})

L:SetOptionLocalization({
	WarnAddsSoon		= "Montre une alerte avant que les adds arrivent",
	TimerAdds			= "Montre le timer pour les nouveaux adds"
})

L:SetTimerLocalization({
	TimerAdds			= "Nouveaux Adds"
})

L:SetMiscLocalization({
	PullAlliance	= "Faites chauffer les moteurs ! On a rencart avec le destin, les gars !",
	PullHorde		= "Levez-vous, fils et filles de la Horde ! Aujourd’hui, nous affrontons le plus haï de nos ennemis ! LOK’TAR OGAR !",
	AddsAlliance	= "Saccageurs, sergents, à l'attaque !",
	AddsHorde		= "Soldats, sergents, à l'attaque !",
	MageAlliance	= "La coque est endommagée, qu'un mage de bataille aille faire taire leurs canons !",
	MageHorde		= "La coque déguste sévère, qu'un sorcier aille me faire taire ces canons !",
	KillAlliance	= "Vous direz pas que j'vous avais pas prévenus, canailles ! Mes frères et sœurs, en avant !",
	KillHorde		= "L'Alliance baisse pavillon. Sus au roi-liche !"
})

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization({
	name = "Porte-Mort Saurcroc"
})

L:SetOptionLocalization({
	RunePowerFrame		= "Montre la barre de vie du boss + la barre de $spell:72371",
--	RemoveDI			= "Supprimez $spell:19752 s'il est utilisé pour empêcher le lancement du sort $spell:72293."
})

L:SetMiscLocalization({
	RunePower			= "Bêtes de sang",
	PullAlliance		= "Bon allez, on se bouge",
	PullHorde			= "Kor'krons, en route ! Champions, surveillez bien vos arrières. Le Fléau a été -"
})

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "Pulentraille"
})

L:SetOptionLocalization({
	AnnounceSporeIcons	= "Annonce les icônes pour les cibles de $spell:69279 au chat de raid<br/>(nécessite le raid lead)",
	AchievementCheck	= "Annonce l'échec du haut-fait 'Pénurie de vaccins' au raid<br/>(nécessite un statut promu)"
})

L:SetWarningLocalization({
	SporeSet			= "Icône de Spore gazeuse {rt%d} mise sur %s",
	AchievementFailed	= ">> HAUT-FAIT ÉCHOUÉ : %s a %d stacks d'Inoculé <<"
})

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization({
	name = "Trognepus"
})

L:SetWarningLocalization({
	WarnOozeSpawn				= "Les Limons sont arrivées",
	WarnUnstableOoze			= "%s sur >%s< (%s)",
	SpecWarnLittleOoze			= "Les Limons vous attaque - COUREZ"
})

L:SetOptionLocalization({
	WarnOozeSpawn				= "Montre une alerte pour l'arrivée des Limons",
	SpecWarnLittleOoze			= "Montre une alerte spéciale quand vous êtes attaquer par des Limons",
	TankArrow					= "Afficher la flèche DBM pour le kiter du Grand limon (Expérimental)"
})

L:SetMiscLocalization({
	YellSlimePipes1				= "réparé le distributeur de poison",	-- Professor Putricide
	YellSlimePipes2				= "Great news, everyone! The slime is flowing again!"	-- Professor Putricide
})

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization({
	name = "Professeur Putricide"
})

L:SetWarningLocalization({
	WarnReengage			= "%s: Ré-engagement"
})

L:SetTimerLocalization({
	TimerReengage			= "Ré-engagement"
})

--[[L:SetOptionLocalization({
	WarnReengage			= "Show warning for Boss re-engage", -- needs localization
	TimerReengage			= "Show timer for Boss re-engage" -- needs localization
})]]

L:SetMiscLocalization({
	YellTransform1			= "Mmm, je ne sens plus rien. Woah ?! Mais ça vient d'où, tout ça ?",
	YellTransform2			= "Au bon goût de… Cerise ! Oups ! Pardon !"
})

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization({
	name = "Princes de Sang"
})

L:SetWarningLocalization({
	WarnTargetSwitch		= "Changement de cible sur : %s",
	WarnTargetSwitchSoon	= "Changement de cible bientôt"
})

L:SetTimerLocalization({
	TimerTargetSwitch		= "Possible changement de cible"
})

L:SetOptionLocalization({
	WarnTargetSwitch		= "Montre l'alerte pour le changement de cible",
	WarnTargetSwitchSoon	= "Montre une pré-alerte pour le changement de cible",
	TimerTargetSwitch		= "Montre un timer pour le changement de cible",
	ActivePrinceIcon		= "Place l'icône de raid principale sur le prince de sang actuellement surpuissant (nécessite d'être assistant ou mieux).",
	ShadowPrisonMetronome	= "Joue un son de clic répétitif de 1 seconde pour éviter $spell:72999"
})

L:SetMiscLocalization({
	Keleseth			= "Prince Keleseth",
	Taldaram			= "Prince Taldaram",
	Valanar				= "Prince Valanar",
	FirstPull			= "Naïfs mortels. Vous pensiez nous avoir vaincus si facilement ? Les San'layn sont les soldats immortels du roi-liche ! Maintenant, vous allez subir leurs puissances réunies !",
	EmpoweredFlames		= "L'Embrasement surpuissant (%S+)!"
})

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization({
	name = "Reine de sang Lana'thel"
})

L:SetMiscLocalization({
	SwarmingShadows			= "Shadows amass and swarm around (%S+)!",
	YellFrenzy				= "J'ai faim!"
})

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization({
	name = "Valithria Marcherêve"
})

L:SetWarningLocalization({
	WarnPortalOpen	= "Portails actifs !"
})

L:SetTimerLocalization({
	TimerPortalsOpen			= "Arrivée des portails",
	TimerPortalsClose			= "Portals close",
	TimerBlazingSkeleton		= "Next Blazing Skeleton",
	TimerAbom					= "Next Abomination (%s)"
})

L:SetOptionLocalization({
	WarnPortalOpen				= "Prévient via une alerte quand Valithria ouvre des portails.",
	TimerPortalsOpen			= "Montre une timer pour voir quand Valithria ouvre des portails.",
	TimerPortalsClose			= "Afficher le timer lorsque Portail cauchemardesque est fermé",
	TimerBlazingSkeleton		= "Afficher le timer pour l'apparition du prochain Squelette flamboyant"
})

L:SetMiscLocalization({
	YellPull		= "Des intrus se sont introduits dans le sanctuaire. Hâtez-vous d'achever le dragon vert ! Ne gardez que les os et les tendons, pour la réanimation !",
	YellPortals		= "J'ai ouvert un portail vers le Rêve. Vous y trouverez votre salut, héros…"
})

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization({
	name = "Sindragosa"
})

L:SetWarningLocalization({
	WarnAirphase			= "Phase dans les airs",
	WarnGroundphaseSoon		= "Sindragosa atterrit bientôt"
})

L:SetTimerLocalization({
	TimerNextAirphase		= "Prochaine phase dans les airs",
	TimerNextGroundphase	= "Prochaine phase sur le sol",
	AchievementMystic		= "Enlevez les stacks Mystiques"
})

L:SetOptionLocalization({
	WarnAirphase				= "Annonce la phase dans les airs",
	WarnGroundphaseSoon			= "Montre une pré-alerte pour la phase au sol",
	TimerNextAirphase			= "Montre un timer pour la prochaine phase dans les airs",
	TimerNextGroundphase		= "Montre un timer pour la prochaine phase au sol",
	AnnounceFrostBeaconIcons	= "Annonce les icônes pour les cibles de $spell:70126 dans le chat de raid (requires announce to be enabled and leader/promoted status)",
	ClearIconsOnAirphase		= "Retire toutes les icones avant la phase d'envol",
	AssignWarnDirectionsCount	= "Attribuez des directions aux cibles $spell:70126 et comptez sur la phase 2",
	AchievementCheck			= "Annonce les alertes du haut-fait 'Tout ce que vous pouvez rafler' au raid<br/>(nécessite un statut promu)",
	RangeFrame					= "Montre la fenêtre de portée (10 normal, 20 heroic) (Montre uniquement les icônes marquer sur les joueurs)"
})

L:SetMiscLocalization({
	YellAirphase		= "Votre incursion s'arrête ici",
	YellPhase2			= "Sentez maintenant le pouvoir infini de mon",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "Icône de Guide de givre {rt%d} mis sur %s",
	AchievementWarning	= "Alerte : %s à 5 stacks de Rafale mystique",
	AchievementFailed	= ">> HAUT-FAIT ÉCHOUÉ : %s à %d stacks de Rafale mystique <<",
})

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization({
	name = "Le Roi Liche"
})

L:SetWarningLocalization({
	ValkyrWarning			= "%s >%s< %s est saisi !",
	SpecWarnYouAreValkd		= "Vous avez été saisi",
	WarnNecroticPlagueJump	= "La Peste nécrotique a sauter sur >%s<",
	SpecWarnValkyrLow		= "Valkyr sous les 55%"
})

L:SetTimerLocalization({
	TimerRoleplay				= "Jeux de rôle",
	PhaseTransition				= "Phase de transition",
	TimerNecroticPlagueCleanse	= "Peste nécrotique Dispell"
})

L:SetOptionLocalization({
	TimerRoleplay				= "Montre le timer pour l'event de rôle",
	WarnNecroticPlagueJump		= "Annonce sur qui saute la $spell:73912",
	TimerNecroticPlagueCleanse	= "Montre le timer pour dispell la Peste nécrotique avant le premier tic",
	PhaseTransition				= "Montre le timer pour la phase de transition",
	ValkyrWarning				= "Annonce qui a été saisi par les Gardes de l'ombre val'kyr",
	SpecWarnYouAreValkd			= "Affiche une alerte spéciale lorsque vous avez été pris par une Garde de l'ombre val'kyr",--npc36609
	AnnounceValkGrabs			= "Annonce les cibles prises par les Gardes de l'ombre val'kyr\n(nécessite un statut promu)",
	SpecWarnValkyrLow			= "Affiche une alerte spéciale lorsque la Garde de l'ombre val'kyr est sous les 55% PDV",
	AnnouncePlagueStack			= "Annonce les $spell:73912 stacks au raid (10 stacks, toutes les 5 après 10)\n(nécessite un statut promu)",
	ShowFrame					= "Affiche une fenêtre des cibles des Val'Kyr",
	FrameClassColor				= "Utiliser les couleurs de classes dans la fenêtre des cibles de Val'Kyr",
	FrameUpwards				= "Étendre la fenêtre des cibles Val'Kyr vers le haut",
	FrameLocked					= "Verouiller la fenêtre des cibles Val'Kyr",
	RemoveImmunes				= "Enlève les sorts d'immunité avant de sortir de la chambre de Deuillegivre"
})

L:SetMiscLocalization({
	LKPull					= "Voici donc qu’arrive la fameuse justice de la Lumière ? Dois-je déposer Deuillegivre et me jeter à tes pieds en implorant pitié, Fordring ?",
	LKRoleplay				= "Est-ce vraiment la justice qui vous anime ? Je me demande…",
	ValkGrabbedIcon			= "Gardes de l'ombre val'kyr {rt%d} a pris %s",
	ValkGrabbed				= "Gardes de l'ombre val'kyr a pris %s",
	PlagueStackWarning		= "Alerte : %s a %d stacks de Peste nécrotique",
	AchievementCompleted	= ">> HAUT-FAIT ÉCHOUÉ : %s a %d stacks de Peste nécrotique <<",
	FrameTitle				= "Cibles Valkyr",
	FrameLock				= "Vérouiller fenêtre",
	FrameClassColor			= "Utiliser couleurs de Classes",
	FrameOrientation		= "Étendre vers le haut",
	FrameHide				= "Cacher fenêtre",
	FrameClose				= "Fermer",
	FrameGUIDesc			= "Cadre Val'Kyr",
	FrameGUIMoveMe			= "Déplacer le cadre Val'Kyr"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ICCTrash")

L:SetGeneralLocalization({
	name = "Icecrown Trash"
})

L:SetWarningLocalization({
	SpecWarnTrapL		= "Piège Activé! - Gardien lié par la mort libéré",
	SpecWarnTrapP		= "Piège Activé! - arrivé de Fauche-chair vengeurs",
	SpecWarnGosaEvent	= "Le défi de Sindragosa commencé !"
})

L:SetOptionLocalization({
	SpecWarnTrapL		= "Afficher une alerte spéciale pour l'activation du piège Gardien lié par la mort",
	SpecWarnTrapP		= "Afficher une alerte spéciale pour l'activation du piège Fauche-chair vengeurs",
	SpecWarnGosaEvent	= "Afficher une alerte spéciale pour le défi de Sindragosa"
})

L:SetMiscLocalization({
	WarderTrap1			= "Qui... va là ?",
	WarderTrap2			= "Je... m’éveille...",
	WarderTrap3			= "Le sanctuaire du maître a été dérangé.",
	FleshreaperTrap1	= "Vite, on va les prendre en embuscade par derrière !",
	FleshreaperTrap2	= "Vous ne pouvez pas nous échapper !",
	FleshreaperTrap3	= "Les vivants ? Ici ?!",
	SindragosaEvent		= "Nul n'approche la reine du Givre. Arrêtez-les, vite !"
})
