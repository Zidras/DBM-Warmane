local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "Lord Marrowgar"
})

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization({
	name = "Lady Deathwhisper"
})

L:SetTimerLocalization({
	TimerAdds	= "New Adds"
})

L:SetWarningLocalization({
	WarnReanimating				= "Add reviving",	-- Reanimating an adherent or fanatic
	WarnAddsSoon				= "New adds soon",
	SpecWarnVengefulShade		= "Vengeful Shade attacking you - Run Away",--creatureid 38222
	WeaponsStatus				= "Auto Unequip/Equip weapons: %s (%s - %s)"
})

L:SetOptionLocalization({
	WarnAddsSoon				= "Show pre-warning for adds spawning",
	WarnReanimating				= "Show warning when an add is being revived",	-- Reanimated Adherent/Fanatic spawning
	TimerAdds					= "Show timer for new adds",
	SpecWarnVengefulShade		= "Show special warning when you are attacked by Vengeful Shade",--creatureid 38222
	WeaponsStatus				= "Show special warning at combat start if unequip/equip function is enabled",
	ShieldHealthFrame			= "Show boss health with a health bar for $spell:70842",
	SoundWarnCountingMC			= "Play a 5 second audio countdown for Mind Control",
--	RemoveDruidBuff				= "Remove $spell:48469 / $spell:48470 24 seconds into the fight",
	RemoveBuffsOnMC				= "Remove buffs when $spell:71289 is cast on you. Each option is cumulative.",
	Never						= NEVER, -- don't translate
	Gift						= "Remove $spell:48469 / $spell:48470. Minimal approach to prevent $spell:33786 resists.",
	CCFree						= "+ Remove $spell:48169 / $spell:48170. Account for resists of spells in the Shadow school.",
	ShortOffensiveProcs			= "+ Remove offensive procs that have a low duration. Recommended for raid safety without compromising raid damage output.",
	MostOffensiveBuffs			= "+ Remove most offensive buffs (mainly for Casters and |cFFFF7C0AFeral Druids|r). Maximum raid safety with loss of damage output and need to self-rebuff/shapeshift!",
	EqUneqWeapons				= "Unequip/equip weapons if $spell:71289 is cast on you. For equipping to work, create a COMPLETE (with the weapons of choice that will be equipped) equipment set named \"pve\".",
	EqUneqTimer					= "Remove weapons by timer ALWAYS, not on cast (if ping is high). The option above must be enabled.",
	EqUneqFilter				= FILTER, -- don't translate
	OnlyDPS						= DBM_COMMON_L.DAMAGE_ICON, -- don't translate
	DPSTank						= DBM_COMMON_L.DAMAGE_ICON..DBM_COMMON_L.TANK_ICON, -- don't translate
	NoFilter					= DBM_COMMON_L.DAMAGE_ICON..DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON -- don't translate
})

L:SetMiscLocalization({
	YellReanimatedFanatic	= "Arise, and exult in your pure form!",
	ShieldPercent			= "Mana Barrier",--Translate Spell id 70842
--	Fanatic1				= "Cult Fanatic",
--	Fanatic2				= "Deformed Fanatic",
--	Fanatic3				= "Reanimated Fanatic",
	setMissing				= "ATTENTION! DBM automatic weapon unequipping/equipping will not work until you create a equipment set named pve",
	EqUneqLineDescription	= "Automatic Equip/Unequip"
})

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization({
	name = "Icecrown Gunship Battle"
})

L:SetWarningLocalization({
	WarnAddsSoon	= "New adds soon"
})

L:SetOptionLocalization({
	WarnAddsSoon		= "Show pre-warning for adds spawning",
	TimerAdds			= "Show timer for new adds"
})

L:SetTimerLocalization({
	TimerAdds			= "New adds"
})

L:SetMiscLocalization({
	PullAlliance	= "Fire up the engines! We got a meetin' with destiny, lads!",
	PullHorde		= "Rise up, sons and daughters of the Horde! Today we battle a hated enemy of the Horde! LOK'TAR OGAR!",
	--CombatAlliance	= "Cowardly dogs! Ye blindsided us!",
	--CombatHorde		= "You answer to Saurfang now!",
	AddsAlliance	= "Reavers, Sergeants, attack",
	AddsHorde		= "Marines, Sergeants, attack",
	MageAlliance	= "We're taking hull damage, get a battle-mage out here to shut down those cannons!",
	MageHorde		= "We're taking hull damage, get a sorcerer out here to shut down those cannons!",
	KillAlliance	= "Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!",
	KillHorde		= "The Alliance falter. Onward to the Lich King!"
})

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization({
	name = "Deathbringer Saurfang"
})

L:SetOptionLocalization({
	RunePowerFrame		= "Show Boss Health + $spell:72371 bar",
--	RemoveDI			= "Remove $spell:19752 if used to prevent $spell:72293 cast"
})

L:SetMiscLocalization({
	RunePower			= "Blood Power",
	PullAlliance		= "For every Horde soldier that you killed -- for every Alliance dog that fell, the Lich King's armies grew. Even now the val'kyr work to raise your fallen as Scourge.",
	PullHorde			= "Kor'kron, move out! Champions, watch your backs. The Scourge have been..."
})

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "Festergut"
})

L:SetOptionLocalization({
	AnnounceSporeIcons	= "Announce icons for $spell:69279 targets to raid chat<br/>(requires raid leader)",
	AchievementCheck	= "Announce 'Flu Shot Shortage' achievement failure to raid<br/>(requires promoted status)"
})

L:SetMiscLocalization({
	SporeSet			= "Gas Spore icon {rt%d} set on %s",
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s has %d stacks of Inoculated <<"
})

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization({
	name = "Rotface"
})

L:SetWarningLocalization({
	WarnOozeSpawn				= "Little Ooze spawning",
	SpecWarnLittleOoze			= "Little Ooze attacking you - Run Away"--creatureid 36897
})

L:SetOptionLocalization({
	WarnOozeSpawn				= "Show warning for Little Ooze spawning",
	SpecWarnLittleOoze			= "Show special warning when you are attacked by Little Ooze",--creatureid 36897
	TankArrow					= "Show DBM arrow for Big Ooze kiter (Experimental)"
})

L:SetMiscLocalization({
	YellSlimePipes1	= "Good news, everyone! I've fixed the poison slime pipes!",	-- Professor Putricide
	YellSlimePipes2	= "Great news, everyone! The slime is flowing again!"	-- Professor Putricide
})

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization({
	name = "Professor Putricide"
})

L:SetWarningLocalization({
	WarnReengage			= "%s: Re-Engage"
})

L:SetTimerLocalization({
	TimerReengage			= "Re-Engage"
})

L:SetOptionLocalization({
	WarnReengage			= "Show warning for Boss re-engage",
	TimerReengage			= "Show timer for Boss re-engage"
})

L:SetMiscLocalization({
	YellTransform1			= "Hrm, I don't feel a thing. Wha?! Where'd those come from?",
	YellTransform2			= "Tastes like... Cherry! OH! Excuse me!"
})

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization({
	name = "Blood Prince Council"
})

L:SetWarningLocalization({
	WarnTargetSwitch		= "Switch target to: %s",
	WarnTargetSwitchSoon	= "Target switch soon"
})

L:SetTimerLocalization({
	TimerTargetSwitch		= "Target switch"
})

L:SetOptionLocalization({
	WarnTargetSwitch		= "Show warning to switch targets",-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Show pre-warning to switch targets",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Show timer for target switch cooldown",
	ActivePrinceIcon		= "Set icon on the empowered Prince (skull)",
	ShadowPrisonMetronome	= "Play a repeating 1 second click sound to avoid $spell:72999"
})

L:SetMiscLocalization({
	Keleseth			= "Prince Keleseth",
	Taldaram			= "Prince Taldaram",
	Valanar				= "Prince Valanar",
	FirstPull			= "Foolish mortals. You thought us defeated so easily? The San'layn are the Lich King's immortal soldiers! Now you shall face their might combined!",
	EmpoweredFlames		= "Empowered Flames speed toward (%S+)!"
})

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization({
	name = "Blood-Queen Lana'thel"
})

L:SetMiscLocalization({
	SwarmingShadows			= "Shadows amass and swarm around (%S+)!",
	YellFrenzy				= "I'm hungry!" -- Player did not bite; not to be confused with BQL Berserk (This ends NOW!)
})

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization({
	name = "Valithria Dreamwalker"
})

L:SetWarningLocalization({
	WarnPortalOpen	= "Portals open"
})

L:SetTimerLocalization({
	TimerPortalsOpen			= "Portals open",
	TimerPortalsClose			= "Portals close",
	TimerBlazingSkeleton		= "Next Blazing Skeleton",
	TimerAbom					= "Next Abomination (%s)"
})

L:SetOptionLocalization({
	WarnPortalOpen				= "Show warning when Nightmare Portals are opened up",
	TimerPortalsOpen			= "Show timer until Nightmare Portals are opened up",
	TimerPortalsClose			= "Show timer until Nightmare Portals are closed",
	TimerBlazingSkeleton		= "Show timer for next Blazing Skeleton spawn"
})

L:SetMiscLocalization({
	YellPull		= "Intruders have breached the inner sanctum. Hasten the destruction of the green dragon! Leave only bones and sinew for the reanimation!",
	YellPortals		= "I have opened a portal into the Dream. Your salvation lies within, heroes..."
})

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization({
	name = "Sindragosa"
})

L:SetWarningLocalization({
	WarnAirphase			= "Air phase",
	WarnGroundphaseSoon		= "Sindragosa landing soon"
})

L:SetTimerLocalization({
	TimerNextAirphase		= "Next air phase",
	TimerNextGroundphase	= "Next ground phase",
	AchievementMystic		= "Time to clear Mystic stacks"
})

L:SetOptionLocalization({
	WarnAirphase				= "Announce air phase",
	WarnGroundphaseSoon			= "Show pre-warning for ground phase",
	TimerNextAirphase			= "Show timer for next air phase",
	TimerNextGroundphase		= "Show timer for next ground phase",
	AnnounceFrostBeaconIcons	= "Announce icons for $spell:70126 targets to raid chat<br/>(requires raid leader)",
	ClearIconsOnAirphase		= "Clear all icons before air phase",
	AssignWarnDirectionsCount	= "Assign directions to $spell:70126 targets and count on phase 2",
	AchievementCheck			= "Announce 'All You Can Eat' achievement warnings to raid<br/>(requires promoted status)",
	RangeFrame					= "Show dynamic range frame (10/20) based on last used boss ability and player debuffs ($spell:69762 shows only on Heroic)"
})

L:SetMiscLocalization({
	YellAirphase		= "Your incursion ends here! None shall survive!",
	YellPhase2			= "Now, feel my master's limitless power and despair!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "Frost Beacon icon {rt%d} set on %s",
	AchievementWarning	= "Warning: %s has 5 stacks of Mystic Buffet",
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s has %d stacks of Mystic Buffet <<"
})

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization({
	name = "The Lich King"
})

L:SetWarningLocalization({
	ValkyrWarning			= "%s >%s< %s has been grabbed!",
	SpecWarnYouAreValkd		= "You have been grabbed",
	WarnNecroticPlagueJump	= "Necrotic Plague jumped to >%s<",
	SpecWarnValkyrLow		= "Valkyr below 55%"
})

L:SetTimerLocalization({
	TimerRoleplay				= "Roleplay",
	PhaseTransition				= "Phase transition",
	TimerNecroticPlagueCleanse	= "Cleanse Necrotic Plague"
})

L:SetOptionLocalization({
	TimerRoleplay				= "Show timer for roleplay event",
	WarnNecroticPlagueJump		= "Announce $spell:73912 jump targets",
	TimerNecroticPlagueCleanse	= "Show timer to cleanse Necrotic Plague before\nthe first tick",
	PhaseTransition				= "Show time for phase transitions",
	ValkyrWarning				= "Announce Val'kyr Shadowguards grab targets",
	SpecWarnYouAreValkd			= "Show special warning when you have been grabbed by a Val'kyr Shadowguard",--npc36609
	AnnounceValkGrabs			= "Announce Val'kyr Shadowguard grab targets in raid chat\n(requires announce to be enabled and promoted status)",
	SpecWarnValkyrLow			= "Show special warning when Valkyr is below 55% HP",
	AnnouncePlagueStack			= "Announce $spell:73912 stacks to raid (10 stacks, every 5 after 10)\n(requires promoted status)",
	ShowFrame					= "Show Val'Kyr Targets frame",
	FrameClassColor				= "Use Class Colors in Val'Kyr Targets frame",
	FrameUpwards				= "Expand Val'Kyr target frame upwards",
	FrameLocked					= "Lock Val'Kyr Targets frame",
	RemoveImmunes				= "Remove immunity spells before exiting Frostmourne room"
})

L:SetMiscLocalization({
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
	FrameClose				= "Close",
	FrameGUIDesc			= "Val'Kyr Frame",
	FrameGUIMoveMe			= "Move Val'Kyr Frame"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ICCTrash")

L:SetGeneralLocalization({
	name = "Icecrown Trash"
})

L:SetWarningLocalization({
	SpecWarnTrapL		= "Trap Activated! - Deathbound Ward released", -- creatureid 37007
	SpecWarnTrapP		= "Trap Activated! - Vengeful Fleshreapers incoming", --creatureid 37038
	SpecWarnGosaEvent	= "Sindragosa gauntlet started!"
})

L:SetOptionLocalization({
	SpecWarnTrapL		= "Show special warning for Deathbound Ward trap activation",
	SpecWarnTrapP		= "Show special warning for Vengeful Fleshreapers trap activation",
	SpecWarnGosaEvent	= "Show special warning for Sindragosa gauntlet event"
})

L:SetMiscLocalization({
	WarderTrap1			= "Who... goes there...?",
	WarderTrap2			= "I... awaken!",
	WarderTrap3			= "The master's sanctum has been disturbed!",
	FleshreaperTrap1	= "Quickly! We'll ambush them from behind!",
	FleshreaperTrap2	= "You... cannot escape us!",
	FleshreaperTrap3	= "The living... here?!",
	SindragosaEvent		= "You must not approach the Frost Queen. Quickly, stop them!"
})
