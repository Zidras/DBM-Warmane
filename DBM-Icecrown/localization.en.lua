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
	name = "Lord Marrowgar"
}

L:SetTimerLocalization{
	TimerBoneSpikeUp	= "Spikes up in...",
	TimerWhirlwindStart	= "Whirlwind starts in..."
}

L:SetOptionLocalization{
	SetIconOnImpale		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Lady Deathwhisper"
}

L:SetTimerLocalization{
	TimerAdds	= "New Adds"
}

L:SetWarningLocalization{
	WarnReanimating				= "Add reviving",			-- Reanimating an adherent or fanatic
	WarnAddsSoon				= "New adds soon",
	SpecWarnVengefulShade		= "Vengeful Shade attacking you - Run Away",--creatureid 38222
	WeaponsStatus				= "Auto Unequipping enabled"
}

L:SetOptionLocalization{
	RemoveDruidBuff				= "Remove MotW / GotW 24 seconds into the fight",
	WarnAddsSoon				= "Show pre-warning for adds spawning",
	WarnReanimating				= "Show warning when an add is being revived",	-- Reanimated Adherent/Fanatic spawning
	TimerAdds					= "Show timer for new adds",
	SpecWarnVengefulShade		= "Show special warning when you are attacked by Vengeful Shade",--creatureid 38222
	WeaponsStatus				= "Special warning at combat start if unequip/equip function is enabled",
	ShieldHealthFrame			= "Show boss health with a health bar for $spell:70842",
	SetIconOnDominateMind		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901),
	SoundWarnCountingMC			= "Play a 5 second audio countdown for Mind Control",
	EqUneqWeapons				= "Unequip/equip weapons if MC is cast on you. For equipping to work, create an equipment set called 'pve'.",
	EqUneqTimer					= "Remove weapons by timer ALWAYS, not on cast (if ping is high). The option above must be enabled.",
	BlockWeapons				= "Completely block the unequip/equip functions above"
}

L:SetMiscLocalization{
	YellReanimatedFanatic	= "Arise, and exult in your pure form!",
	ShieldPercent			= "Mana Barrier",--Translate Spell id 70842
	Fanatic1				= "Cult Fanatic",
	Fanatic2				= "Deformed Fanatic",
	Fanatic3				= "Reanimated Fanatic",
	setMissing				= "ATTENTION! DBM automatic weapon unequipping/equipping will not work until you create a equipment set named pve"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Gunship Battle"
}

L:SetWarningLocalization{
	WarnBattleFury	= "%s (%d)",
	WarnAddsSoon	= "New adds soon"
}

L:SetOptionLocalization{
	WarnBattleFury		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "Battle Fury"),
	TimerCombatStart	= "Show time for start of combat",
	WarnAddsSoon		= "Show pre-warning for adds spawning",
	TimerAdds			= "Show timer for new adds"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Combat starts",
	TimerAdds			= "New adds"
}

L:SetMiscLocalization{
	PullAlliance	= "Fire up the engines! We got a meetin' with destiny, lads!",
	CombatAlliance	= "Cowardly dogs! Ye blindsided us!",
	KillAlliance	= "Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!",
	PullHorde		= "Rise up, sons and daughters of the Horde! Today we battle a hated enemy of the Horde! LOK'TAR OGAR!",
	CombatHorde		= "ALLIANCE GUNSHIP! ALL HANDS ON DECK!",
	KillHorde		= "The Alliance falter. Onward to the Lich King!",
	AddsAlliance	= "Reavers, Sergeants, attack",
	AddsHorde		= "Marines, Sergeants, attack",
	MageAlliance	= "We're taking hull damage, get a battle-mage out here to shut down those cannons!",
	MageHorde		= "We're taking hull damage, get a sorcerer out here to shut down those cannons!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Deathbringer Saurfang"
}

L:SetOptionLocalization{
	BoilingBloodIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	RangeFrame				= "Show range frame (12 yards)",
	RunePowerFrame			= "Show Boss Health + $spell:72371 bar"
}

L:SetMiscLocalization{
	RunePower			= "Blood Power",
	PullAlliance		= "For every Horde soldier that you killed -- for every Alliance dog that fell, the Lich King's armies grew. Even now the val'kyr work to raise your fallen as Scourge.",
	PullHorde			= "Kor'kron, move out! Champions, watch your backs. The Scourge have been..."
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Festergut"
}

L:SetOptionLocalization{
	RangeFrame			= "Show range frame (8 yards)",
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279),
	AnnounceSporeIcons	= "Announce icons for $spell:69279 targets to raid chat<br/>(requires raid leader)",
	AchievementCheck	= "Announce 'Flu Shot Shortage' achievement failure to raid<br/>(requires promoted status)"
}

L:SetMiscLocalization{
	SporeSet			= "Gas Spore icon {rt%d} set on %s",
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s has %d stacks of Inoculated <<"
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Rotface"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Little Ooze spawning",
	SpecWarnLittleOoze			= "Little Ooze attacking you - Run Away"--creatureid 36897
}

L:SetOptionLocalization{
	WarnOozeSpawn				= "Show warning for Little Ooze spawning",
	SpecWarnLittleOoze			= "Show special warning when you are attacked by Little Ooze",--creatureid 36897
	RangeFrame					= "Show range frame (8 yards)",
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	TankArrow					= "Show DBM arrow for Big Ooze kiter (Experimental)"
}

L:SetMiscLocalization{
	YellSlimePipes1	= "Good news, everyone! I've fixed the poison slime pipes!",	-- Professor Putricide
	YellSlimePipes2	= "Great news, everyone! The slime is flowing again!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professor Putricide"
}

L:SetOptionLocalization{
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72856),
	MalleableGooIcon			= "Set icon on first $spell:72295 target",
	GooArrow					= "Show DBM arrow when $spell:72295 is near you"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Blood Prince Council"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Switch target to: %s",
	WarnTargetSwitchSoon	= "Target switch soon"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Target switch"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Show warning to switch targets",-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Show pre-warning to switch targets",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Show timer for target switch cooldown",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "Set icon on the empowered Prince (skull)",
	RangeFrame				= "Show range frame (12 yards)",
	VortexArrow				= "Show DBM arrow when $spell:72037 is near you"
}

L:SetMiscLocalization{
	Keleseth			= "Prince Keleseth",
	Taldaram			= "Prince Taldaram",
	Valanar				= "Prince Valanar",
	FirstPull			= "Foolish mortals. You thought us defeated so easily? The San'layn are the Lich King's immortal soldiers! Now you shall face their might combined!",
	EmpoweredFlames		= "Empowered Flames speed toward (%S+)!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Blood-Queen Lana'thel"
}

L:SetOptionLocalization{
	SetIconOnDarkFallen		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838),
	RangeFrame				= "Show range frame (8 yards)"
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
	name = "Valithria Dreamwalker"
}

L:SetWarningLocalization{
	WarnPortalOpen	= "Portals open",
	Suppressers		= "Suppressers"
}

L:SetTimerLocalization{
	TimerPortalsOpen		= "Portals open",
	TimerPortalsClose		= "Portals close",
	TimerBlazingSkeleton	= "Next Blazing Skeleton",
	TimerAbom				= "Next Abomination",
	TimerSuppresserOne			= "1st wave of Suppressers",
	TimerSuppresserTwo			= "2nd wave of Suppressers",
	TimerSuppresserThree		= "3rd wave of Suppressers",
	TimerSuppresserFour			= "4th wave of Suppressers"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Set icon on Blazing Skeleton (skull)",
	WarnPortalOpen				= "Show warning when Nightmare Portals are opened up",
	TimerPortalsOpen			= "Show timer when Nightmare Portals are opened up",
	TimerPortalsClose			= "Show timer when Nightmare Portals are closed",
	TimerBlazingSkeleton		= "Show timer for next Blazing Skeleton spawn",
	TimerAbom					= "Show timer for next Gluttonous Abomination spawn (Experimental)",
	Suppressers					= "Show special warning for new Suppressers",
	TimerSuppresserOne			= "1st wave of Suppressers",
	TimerSuppresserTwo			= "2nd wave of Suppressers",
	TimerSuppresserThree		= "3rd wave of Suppressers",
	TimerSuppresserFour			= "4th wave of Suppressers"
}

L:SetMiscLocalization{
	YellPull		= "Intruders have breached the inner sanctum. Hasten the destruction of the green dragon! Leave only bones and sinew for the reanimation!",
	YellPortals		= "I have opened a portal into the Dream. Your salvation lies within, heroes..."
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Sindragosa"
}

L:SetWarningLocalization{
	WarnAirphase			= "Air phase",
	WarnGroundphaseSoon		= "Sindragosa landing soon"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "Next air phase",
	TimerNextGroundphase	= "Next ground phase",
	AchievementMystic		= "Time to clear Mystic stacks"
}

L:SetOptionLocalization{
	WarnAirphase			= "Announce air phase",
	WarnGroundphaseSoon		= "Show pre-warning for ground phase",
	TimerNextAirphase		= "Show timer for next air phase",
	TimerNextGroundphase	= "Show timer for next ground phase",
	AnnounceFrostBeaconIcons= "Announce icons for $spell:70126 targets to raid chat<br/>(requires raid leader)",
	SetIconOnFrostBeacon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase	= "Clear all icons before air phase",
	AchievementCheck		= "Announce 'All You Can Eat' achievement warnings to raid<br/>(requires promoted status)",
	RangeFrame				= "Show dynamic range frame (10/20) based on last used boss ability and player debuffs"
}

L:SetMiscLocalization{
	YellAirphase		= "Your incursion ends here! None shall survive!",
	YellPhase2			= "Now, feel my master's limitless power and despair!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "Frost Beacon icon {rt%d} set on %s",
	AchievementWarning	= "Warning: %s has 5 stacks of Mystic Buffet",
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s has %d stacks of Mystic Buffet <<"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "The Lich King"
}

L:SetWarningLocalization{
	ValkyrWarning			= ">%s< has been grabbed!",
	SpecWarnYouAreValkd		= "You have been grabbed",
	WarnNecroticPlagueJump	= "Necrotic Plague jumped to >%s<",
	SpecWarnValkyrLow		= "Valkyr below 55%"
}

L:SetTimerLocalization{
	TimerRoleplay		= "Roleplay",
	PhaseTransition		= "Phase transition",
	TimerNecroticPlagueCleanse = "Cleanse Necrotic Plague"
}

L:SetOptionLocalization{
	TimerRoleplay			= "Show timer for roleplay event",
	WarnNecroticPlagueJump	= "Announce $spell:73912 jump targets",
	TimerNecroticPlagueCleanse	= "Show timer to cleanse Necrotic Plague before\nthe first tick",
	PhaseTransition			= "Show time for phase transitions",
	ValkyrWarning			= "Announce who has been grabbed by Val'kyr Shadowguards",
	SpecWarnYouAreValkd		= "Show special warning when you have been grabbed by a Val'kyr Shadowguard",--npc36609
	DefileIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	NecroticPlagueIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912),
	RagingSpiritIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	HarvestSoulIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74327),
	TrapArrow				= "Show DBM arrow when $spell:73539 is near you",
	AnnounceValkGrabs		= "Announce Val'kyr Shadowguard grab targets to raid chat\n(requires announce to be enabled and promoted status)",
	SpecWarnValkyrLow		= "Show special warning when Valkyr is below 55% HP",
	AnnouncePlagueStack		= "Announce $spell:73912 stacks to raid (10 stacks, every 5 after 10)\n(requires promoted status)",
	ShowFrame				= "Show Val'Kyr Targets frame",
	FrameClassColor			= "Use Class Colors in Val'Kyr Targets frame",
	FrameUpwards			= "Expand Val'Kyr target frame upwards",
	FrameLocked				= "Lock Val'Kyr Targets frame",
}

L:SetMiscLocalization{
	LKPull					= "So the Light's vaunted justice has finally arrived? Shall I lay down Frostmourne and throw myself at your mercy, Fordring?",
	LKRoleplay				= "Is it truly righteousness that drives you? I wonder...",
	ValkGrabbedIcon			= "Valkyr Shadowguard {rt%d} grabbed %s",
	ValkGrabbed				= "Valkyr Shadowguard grabbed %s",
	PlagueStackWarning		= "Warning: %s has %d stacks of Necrotic Plague",
	AchievementCompleted	= ">> ACHIEVEMENT COMPLETE: %s has %d stacks of Necrotic Plague <<",
	FrameTitle				= "Valkyr targets",
	FrameLock				= "Frame Lock",
	FrameClassColor			= "Use Class Colors",
	FrameOrientation		= "Expand upwards",
	FrameHide				= "Hide Frame",
	FrameClose				= "Close"
}
