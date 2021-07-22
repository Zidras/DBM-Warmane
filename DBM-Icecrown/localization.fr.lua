if GetLocale() ~= "frFR" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Lower Spire trash"
}

L:SetWarningLocalization{
	SpecWarnTrap		= "Trap Activated! - Deathbound Ward released"--creatureid 37007
}

L:SetOptionLocalization{
	SpecWarnTrap		= "Show special warning for trap activation",
	SetIconOnDarkReckoning	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
}

L:SetMiscLocalization{
	WarderTrap1		= "Who... goes there...?",
	WarderTrap2		= "I... awaken!",
	WarderTrap3		= "The master's sanctum has been disturbed!"
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "Plagueworks Trash"
}

L:SetWarningLocalization{
	WarnMortalWound	= "%s on >%s< (%s)",		-- Mortal Wound on >args.destName< (args.amount)
	SpecWarnTrap	= "Trap Activated! - Vengeful Fleshreapers incoming"--creatureid 37038
}

L:SetOptionLocalization{
	SpecWarnTrap	= "Show special warning for trap activation",
	WarnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
}

L:SetMiscLocalization{
	FleshreaperTrap1		= "Quickly! We'll ambush them from behind!",
	FleshreaperTrap2		= "You... cannot escape us!",
	FleshreaperTrap3		= "The living... here?!"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name = "Crimson Hall Trash"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

---------------------------
--  Trash - Frostwing Hall  --
---------------------------
L = DBM:GetModLocalization("FrostwingHallTrash")

L:SetGeneralLocalization{
	name = "Frostwing Hall Trash"
}

L:SetWarningLocalization{
	SpecWarnGosaEvent	= "Sindragosa gauntlet started!"
}

L:SetTimerLocalization{
	GosaTimer			= "Time remaining"
}

L:SetOptionLocalization{
	SpecWarnGosaEvent	= "Show special warning for Sindragosa gauntlet event",
	GosaTimer			= "Show timer for Sindragosa gauntlet event duration"
}

L:SetMiscLocalization{
	SindragosaEvent		= "You must not approach the Frost Queen. Quickly, stop them!"
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Seigneur Gargamoelle"
}

L:SetTimerLocalization{
	AchievementBoned		= "Temps pour libérer"
}

L:SetOptionLocalization{
	SetIconOnImpale			= "Met des icônes sur les cibles de $spell:69062"
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
	SetIconOnDominateMind		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901),
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
	Fanatic3				= "Fanatique réanimé"
	setMissing				= "ATTENTION! DBM automatic weapon unequipping/equipping will not work until you create a equipment set named pve" --Needs Translating
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "La Bataille aérienne en Canonnière"
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
	PullAlliance	= "Faites chauffer les moteurs",
	PullHorde		= "nous affrontons le plus haï de nos ennemis",
	AddsAlliance	= "Reavers, Sergeants, attack", --Needs Translating
	AddsHorde		= "Marines, Sergeants, attack", --Needs Translating
	KillAlliance	= "Vous direz pas que j'vous avais pas prévenus",
	KillHorde		= "L'Alliance baisse pavillon"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Porte-Mort Saurcroc"
}

L:SetOptionLocalization{
	BoilingBloodIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	MarkCastIcon		= "Met des icones sur les cibles de $spell:72444 durant l'incantation (Experimental)",
	RunePowerFrame		= "Montre la barre de vie du boss + la barre de $spell:72371"
}

L:SetMiscLocalization{
	RunePower			= "Bêtes de sang",
	PullAlliance		= "Bon allez, on se bouge",
	PullHorde			= "surveillez bien vos arrières"
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
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279),
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
	RangeFrame					= "Show range frame (8 yards)", --Needs Translating
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	TankArrow					= "Show DBM arrow for Big Ooze kiter (Experimental)"
}

L:SetMiscLocalization{
	YellSlimePipes1	= "réparé le distributeur de poison",	-- Professor Putricide
	YellSlimePipes2	= "Great news, everyone! The slime is flowing again!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professeur Putricide"
}

L:SetOptionLocalization{
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72856),
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
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "Place l'icône de raid principale sur le prince de sang actuellement surpuissant (nécessite d'être assistant ou mieux)."
	RangeFrame				= "Show range frame (12 yards)", --Needs Translating
	VortexArrow				= "Show DBM arrow when $spell:72037 is near you" --Needs Translating
}

L:SetMiscLocalization{
	Keleseth			= "Prince Keleseth",
	Taldaram			= "Prince Taldaram",
	Valanar				= "Prince Valanar",
	--FirstPull			= "Foolish mortals. You thought us defeated so easily? The San'layn are the Lich King's immortal soldiers! Now you shall face their might combined!", -- Needs Translating
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
	SetIconOnDarkFallen			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838),
	RangeFrame				= "Show range frame (8 yards)" --Needs Translating
}

L:SetMiscLocalization{
	SwarmingShadows			= "Shadows amass and swarm around (%S+)!",
	YellFrenzy				= "I'm hungry!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Marcherêve"
}

L:SetWarningLocalization{
	WarnCorrosion	= "%s sur >%s< (%s)",
	WarnPortalOpen	= "Portails actifs !"
}

L:SetTimerLocalization{
	TimerPortalsOpen			= "Arrivée des portails",
	TimerPortalsClose			= "Portals close",
	TimerBlazingSkeleton		= "Next Blazing Skeleton",
	TimerAbom					= "Next Abomination",
	TimerSuppressorOne			= "1st wave of Suppressors", --Needs Translating
	TimerSuppressorTwo			= "2nd wave of Suppressors", --Needs Translating
	TimerSuppressorThree		= "3rd wave of Suppressors", --Needs Translating
	TimerSuppressorFour			= "4th wave of Suppressors" --Needs Translating
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Met une icone sur le Squelette flamboyant (Tête de mort)",
	WarnPortalOpen				= "Prévient via une alerte quand Valithria ouvre des portails.",
	TimerPortalsOpen			= "Montre une timer pour voir quand Valithria ouvre des portails.",
	TimerPortalsClose			= "Show timer when Nightmare Portals are closed", --Needs Translating
	TimerBlazingSkeleton		= "Show timer for next Blazing Skeleton spawn", --Needs Translating
	TimerAbom					= "Show timer for next Gluttonous Abomination spawn (Experimental)", --Needs Translating
	Suppressors					= "Show special warning for new Suppressors", --Needs Translating
	TimerSuppressorOne			= "1st wave of Suppressors", --Needs Translating
	TimerSuppressorTwo			= "2nd wave of Suppressors", --Needs Translating
	TimerSuppressorThree		= "3rd wave of Suppressors", --Needs Translating
	TimerSuppressorFour			= "4th wave of Suppressors" --Needs Translating
}

L:SetMiscLocalization{
	YellPull		= "Ne gardez que les os et les tendons",
	YellKill		= "JE REVIS"
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
	SetIconOnFrostBeacon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase		= "Retire toutes les icones avant la phase d'envol",
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
	DefileIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	NecroticPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912),
	RagingSpiritIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	HarvestSoulIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74327),
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
	LKPull					= "la fameuse justice de la Lumière",
	LKRoleplay				= "Is it truly righteousness that drives you? I wonder...",
	ValkGrabbedIcon			= "Valkyr Shadowguard {rt%d} grabbed %s", -- Needs Translating
	ValkGrabbed				= "Valkyr Shadowguard grabbed %s", -- Needs Translating
	PlagueStackWarning		= "Warning: %s has %d stacks of Necrotic Plague", -- Needs Translating
	AchievementCompleted	= ">> ACHIEVEMENT COMPLETE: %s has %d stacks of Necrotic Plague <<", -- Needs Translating
	FrameTitle				= "Valkyr targets",
	FrameLock				= "Frame Lock",
	FrameClassColor			= "Use Class Colors",
	FrameOrientation		= "Expand upwards",
	FrameHide				= "Hide Frame",
	FrameClose				= "Close"
}
