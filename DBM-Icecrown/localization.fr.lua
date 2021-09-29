if GetLocale() ~= "frFR" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Seigneur Gargamoelle"
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Dame Murmemort"
}

L:SetTimerLocalization{
	TimerAdds	= "Nouveaux Adds"
}

L:SetWarningLocalization{
	WarnReanimating				= "Les adds revivent",
	WarnAddsSoon				= "Nouveaux adds bientôt",
	SpecWarnVengefulShade		= "Ombre vengeresse vous attaque - COUREZ",
	WeaponsStatus				= "Auto Unequipping enabled" --Needs Translating
}

L:SetOptionLocalization{
	WarnAddsSoon				= "Montre une pré-alerte avant que les adds arrivent",
	WarnReanimating				= "Montre une alerte quand les adds vont revenir a la vie",
	TimerAdds					= "Montre le timer pour les nouveaux adds",
	SpecWarnVengefulShade		= "Montre une alerte spéciale quand vous êtes attaquer par une Ombre vengeresse",
	WeaponsStatus				= "Special warning at combat start if unequip/equip function is enabled", --Needs Translating
	ShieldHealthFrame			= "Montre la vie du boss avec une barre de vie pour la $spell:70842",
	SoundWarnCountingMC			= "Play a 5 second audio countdown for Mind Control", --Needs Translating
	RemoveDruidBuff				= "Remove MotW / GotW 24 seconds into the fight", --Needs Translating
	EqUneqWeapons				= "Unequip/equip weapons if MC is cast on you. For equipping to work, create an equipment set called 'pve'.", --Needs Translating
	EqUneqTimer					= "Remove weapons by timer ALWAYS, not on cast (if ping is high). The option above must be enabled.", --Needs Translating
	BlockWeapons				= "Completely block the unequip/equip functions above" --Needs Translating
}

L:SetMiscLocalization{
	YellReanimatedFanatic	= "Lève-toi, dans l'exultation de cette nouvelle pureté",
	ShieldPercent			= "Barrière de mana",
	Fanatic1				= "Membres du culte",
	Fanatic2				= "Fanatique déformé",
	Fanatic3				= "Fanatique réanimé",
	setMissing				= "ATTENTION! DBM automatic weapon unequipping/equipping will not work until you create a equipment set named pve" --Needs Translating
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Bataille des canonnières"
}

L:SetWarningLocalization{
	WarnAddsSoon	= "Nouveaux Add Bientôt"
}

L:SetOptionLocalization{
	WarnAddsSoon		= "Montre une alerte avant que les adds arrivent",
	TimerAdds			= "Montre le timer pour les nouveaux adds"
}

L:SetTimerLocalization{
	TimerAdds			= "Nouveaux Adds"
}

L:SetMiscLocalization{
	PullAlliance	= "Faites chauffer les moteurs ! On a rencart avec le destin, les gars !",
	PullHorde		= "Levez-vous, fils et filles de la Horde ! Aujourd’hui, nous affrontons le plus haï de nos ennemis ! LOK’TAR OGAR !",
	AddsAlliance	= "Saccageurs, sergents, à l'attaque !",
	AddsHorde		= "Soldats, sergents, à l'attaque !",
	MageAlliance	= "La coque est endommagée, qu'un mage de bataille aille faire taire leurs canons !",
	MageHorde		= "La coque déguste sévère, qu'un sorcier aille me faire taire ces canons !",
	KillAlliance	= "Vous direz pas que j'vous avais pas prévenus, canailles ! Mes frères et sœurs, en avant !",
	KillHorde		= "L'Alliance baisse pavillon. Sus au roi-liche !"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Porte-Mort Saurcroc"
}

L:SetOptionLocalization{
	MarkCastIcon		= "Met des icones sur les cibles de $spell:72444 durant l'incantation (Experimental)",
	RunePowerFrame		= "Montre la barre de vie du boss + la barre de $spell:72371",
	RemoveDI			= "Supprimez $spell:19752 s'il est utilisé pour empêcher le lancement du sort $spell:72293."
}

L:SetMiscLocalization{
	RunePower			= "Bêtes de sang",
	PullAlliance		= "Bon allez, on se bouge",
	PullHorde			= "Kor'krons, en route ! Champions, surveillez bien vos arrières. Le Fléau a été -"
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Pulentraille"
}

L:SetOptionLocalization{
	RangeFrame			= "Montre la fenêtre de portée (8 Mètres)",
	AnnounceSporeIcons	= "Announce icons for $spell:69279 targets to raid chat<br/>(requires raid leader)", --Needs Translating
	AchievementCheck	= "Announce 'Flu Shot Shortage' achievement failure to raid<br/>(requires promoted status)" --Needs Translating
}

L:SetWarningLocalization{
	SporeSet			= "Gas Spore icon {rt%d} set on %s", --Needs Translating
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s has %d stacks of Inoculated <<" --Needs Translating
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Trognepus"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Les Limons sont arrivées",
	WarnUnstableOoze			= "%s sur >%s< (%s)",
	SpecWarnLittleOoze			= "Les Limons vous attaque - COUREZ"
}

L:SetOptionLocalization{
	WarnOozeSpawn				= "Montre une alerte pour l'arrivée des Limons",
	SpecWarnLittleOoze			= "Montre une alerte spéciale quand vous êtes attaquer par des Limons",
	RangeFrame					= "Montre la fenêtre de portée (8 Mètres)",
	TankArrow					= "Show DBM arrow for Big Ooze kiter (Experimental)" --Needs translating
}

L:SetMiscLocalization{
	YellSlimePipes1				= "réparé le distributeur de poison",	-- Professor Putricide
	YellSlimePipes2				= "Great news, everyone! The slime is flowing again!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professeur Putricide"
}

L:SetOptionLocalization{
	MalleableGooIcon			= "Met une icone sur la première cible de $spell:72295",
	GooArrow					= "Show DBM arrow when $spell:72295 is near you" --Needs Translating
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Princes de Sang"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Changement de cible sur : %s",
	WarnTargetSwitchSoon	= "Changement de cible bientôt"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Possible changement de cible"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Montre l'alerte pour le changement de cible",
	WarnTargetSwitchSoon	= "Montre une pré-alerte pour le changement de cible",
	TimerTargetSwitch		= "Montre un timer pour le changement de cible",
	ActivePrinceIcon		= "Place l'icône de raid principale sur le prince de sang actuellement surpuissant (nécessite d'être assistant ou mieux).",
	RangeFrame				= "Montre la fenêtre de portée (12 Mètres)",
	VortexArrow				= "Show DBM arrow when $spell:72037 is near you" --Needs Translating
}

L:SetMiscLocalization{
	Keleseth			= "Prince Keleseth",
	Taldaram			= "Prince Taldaram",
	Valanar				= "Prince Valanar",
	FirstPull			= "Naïfs mortels. Vous pensiez nous avoir vaincus si facilement ? Les San'layn sont les soldats immortels du roi-liche ! Maintenant, vous allez subir leurs puissances réunies !",
	EmpoweredFlames		= "L'Embrasement surpuissant (%S+)!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Reine de sang Lana'thel"
}

L:SetOptionLocalization{
	RangeFrame				= "Montre la fenêtre de portée (8 Mètres)"
}

L:SetMiscLocalization{
	SwarmingShadows			= "Shadows amass and swarm around (%S+)!",
	YellFrenzy				= "J'ai faim!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Marcherêve"
}

L:SetWarningLocalization{
	WarnPortalOpen	= "Portails actifs !"
}

L:SetTimerLocalization{
	TimerPortalsOpen			= "Arrivée des portails",
	TimerPortalsClose			= "Portals close",
	TimerBlazingSkeleton		= "Next Blazing Skeleton",
	TimerAbom					= "Next Abomination"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Met une icone sur le Squelette flamboyant (Tête de mort)",
	WarnPortalOpen				= "Prévient via une alerte quand Valithria ouvre des portails.",
	TimerPortalsOpen			= "Montre une timer pour voir quand Valithria ouvre des portails.",
	TimerPortalsClose			= "Show timer when Nightmare Portals are closed", --Needs Translating
	TimerBlazingSkeleton		= "Show timer for next Blazing Skeleton spawn", --Needs Translating
	TimerAbom					= "Show timer for next Gluttonous Abomination spawn (Experimental)" --Needs Translating
}

L:SetMiscLocalization{
	YellPull		= "Des intrus se sont introduits dans le sanctuaire. Hâtez-vous d'achever le dragon vert ! Ne gardez que les os et les tendons, pour la réanimation !",
	YellPortals		= "J'ai ouvert un portail vers le Rêve. Vous y trouverez votre salut, héros…"
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Sindragosa"
}

L:SetWarningLocalization{
	WarnAirphase			= "Phase dans les airs",
	WarnGroundphaseSoon		= "Sindragosa atterrie bientôt"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "Prochaine phase dans les airs",
	TimerNextGroundphase	= "Prochaine phase sur le sol",
	AchievementMystic		= "Time to clear Mystic stacks"
}

L:SetOptionLocalization{
	WarnAirphase				= "Annonce la phase dans les airs",
	WarnGroundphaseSoon			= "Montre une pré-alerte pour la phase au sol",
	TimerNextAirphase			= "Montre un timer pour la prochaine phase dans les airs",
	TimerNextGroundphase		= "Montre un timer pour la prochaine phase au sol",
	AnnounceFrostBeaconIcons	= "Annonce les icones pour les cibles de $spell:70126 dans le chat de raid (requires announce to be enabled and leader/promoted status)",
	ClearIconsOnAirphase		= "Retire toutes les icones avant la phase d'envol",
	AssignWarnDirectionsCount	= "Attribuez des directions aux cibles $spell:70126 et comptez sur la phase 2",
	AchievementCheck			= "Announce 'All You Can Eat' achievement warnings to raid<br/>(requires promoted status)", --Needs Translating
	RangeFrame					= "Montre la fenêtre de portée (10 normal, 20 heroic) (Montre uniquement les icones marquer sur les joueurs)"
}

L:SetMiscLocalization{
	YellAirphase		= "Votre incursion s'arrête ici",
	YellPhase2			= "Sentez maintenant le pouvoir infini de mon",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "Icone de Guide de givre {rt%d} mis sur %s",
	AchievementWarning	= "Warning: %s has 5 stacks of Mystic Buffet", --Needs Translating
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s has %d stacks of Mystic Buffet <<", --Needs Translating
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "Le Roi Liche"
}

L:SetWarningLocalization{
	ValkyrWarning			= ">%s< has been grabbed!", --Needs Translating
	SpecWarnYouAreValkd		= "You have been grabbed", --Needs Translating
	WarnNecroticPlagueJump	= "La Peste nécrotique a sauter sur >%s<",
	SpecWarnValkyrLow		= "Valkyr below 55%" --Needs Translating
}

L:SetTimerLocalization{
	TimerRoleplay				= "Jeux de role",
	PhaseTransition				= "Phase de transition",
	TimerNecroticPlagueCleanse	= "Peste nécrotique Dispell"
}

L:SetOptionLocalization{
	TimerRoleplay				= "Montre le timer pour l'event de role",
	WarnNecroticPlagueJump		= "Annonce sur qui saute la $spell:73912",
	TimerNecroticPlagueCleanse	= "Montre le timer pour dispell la Peste nécrotique avant le premier tic",
	PhaseTransition				= "Montre le timer pour la phase de transition",
	ValkyrWarning				= "Announce who has been grabbed by Val'kyr Shadowguards", --Needs Translating
	SpecWarnYouAreValkd			= "Show special warning when you have been grabbed by a Val'kyr Shadowguard",--npc36609 --Needs Translating
	TrapArrow					= "Montre les flèches de DBM quand $spell:73539 est à coter de vous",
	AnnounceValkGrabs			= "Announce Val'kyr Shadowguard grab targets to raid chat\n(requires announce to be enabled and promoted status)",  --Needs Translating
	SpecWarnValkyrLow			= "Show special warning when Valkyr is below 55% HP",
	AnnouncePlagueStack			= "Announce $spell:73912 stacks to raid (10 stacks, every 5 after 10)\n(requires promoted status)",  --Needs Translating
	ShowFrame					= "Show Val'Kyr Targets frame", --Needs Translating
	FrameClassColor				= "Use Class Colors in Val'Kyr Targets frame", --Needs Translating
	FrameUpwards				= "Expand Val'Kyr target frame upwards", --Needs Translating
	FrameLocked					= "Lock Val'Kyr Targets frame", --Needs Translating
	RemoveImmunes				= "Remove immunity spells before exiting Frostmourne room" --Needs Translating
}

L:SetMiscLocalization{
	LKPull					= "Voici donc qu’arrive la fameuse justice de la Lumière ? Dois-je déposer Deuillegivre et me jeter à tes pieds en implorant pitié, Fordring ?",
	LKRoleplay				= "Est-ce vraiment la justice qui vous anime ? Je me demande…",
	ValkGrabbedIcon			= "Valkyr Shadowguard {rt%d} grabbed %s", -- Needs Translating
	ValkGrabbed				= "Valkyr Shadowguard grabbed %s", -- Needs Translating
	PlagueStackWarning		= "Warning: %s has %d stacks of Necrotic Plague", -- Needs Translating
	AchievementCompleted	= ">> ACHIEVEMENT COMPLETE: %s has %d stacks of Necrotic Plague <<", -- Needs Translating
	FrameTitle				= "Valkyr targets", -- Needs Translating
	FrameLock				= "Frame Lock", -- Needs Translating
	FrameClassColor			= "Use Class Colors", -- Needs Translating
	FrameOrientation		= "Expand upwards", -- Needs Translating
	FrameHide				= "Hide Frame", -- Needs Translating
	FrameClose				= "Close" -- Needs Translating
}

-------------
--  Trash  --
-------------
-- NEEDS TRANSLATION
L = DBM:GetModLocalization("ICCTrash")

L:SetGeneralLocalization{
	name = "Icecrown Trash"
}

L:SetWarningLocalization{
	SpecWarnTrapL		= "Trap Activated! - Deathbound Ward released",
	SpecWarnTrapP		= "Trap Activated! - Vengeful Fleshreapers incoming",
	SpecWarnGosaEvent	= "Sindragosa gauntlet started!"
}

L:SetOptionLocalization{
	SpecWarnTrapL		= "Show special warning for Deathbound Ward trap activation",
	SpecWarnTrapP		= "Show special warning for engeful Fleshreapers trap activation",
	SpecWarnGosaEvent	= "Show special warning for Sindragosa gauntlet event"
}

L:SetMiscLocalization{
	WarderTrap1			= "Who... goes there...?",
	WarderTrap2			= "I... awaken!",
	WarderTrap3			= "The master's sanctum has been disturbed!",
	FleshreaperTrap1	= "Quickly! We'll ambush them from behind!",
	FleshreaperTrap2	= "You... cannot escape us!",
	FleshreaperTrap3	= "The living... here?!",
	SindragosaEvent		= "You must not approach the Frost Queen. Quickly, stop them!"
}
