local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization({
	name = "Flame Leviathan"
})

L:SetWarningLocalization({
	PursueWarn				= "Pursuing >%s<",
	warnNextPursueSoon		= "Target change in 5 seconds",
	SpecialPursueWarnYou	= "You are being pursued - Run away",
	warnWardofLife			= "Ward of Life spawned"
})

L:SetOptionLocalization({
	SpecialPursueWarnYou	= "Show special warning when you are being $spell:62374",
	PursueWarn				= "Announce $spell:62374 targets",
	warnNextPursueSoon		= "Show pre-warning for next $spell:62374",
	warnWardofLife			= "Show special warning for Ward of Life spawn"
})

L:SetMiscLocalization({
	RadioGateSmash	= "Quickly! Evasive action! Evasive act--",
	YellPull		= "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.",
	Emote			= "%%s pursues (%S+)%."
})

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization({
	name = "Ignis the Furnace Master"
})

L:SetOptionLocalization({
	soundConcAuraMastery	= "Play $spell:31821 sound to negate the effects of $spell:63472 (only for the |cFFF48CBAPaladin|r that is the owner of $spell:19746)"
})

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization({
	name = "Razorscale"
})

L:SetWarningLocalization({
	warnTurretsReadySoon		= "Last turret ready in 20 seconds",
	warnTurretsReady			= "Last turret ready"
})

L:SetTimerLocalization({
	timerTurret1	= "Turret 1",
	timerTurret2	= "Turret 2",
	timerTurret3	= "Turret 3",
	timerTurret4	= "Turret 4",
	timerGrounded	= "On the ground"
})

L:SetOptionLocalization({
	warnTurretsReadySoon		= "Show pre-warning for turrets",
	warnTurretsReady			= "Show warning for turrets",
	timerTurret1				= "Show timer for turret 1",
	timerTurret2				= "Show timer for turret 2",
	timerTurret3				= "Show timer for turret 3 (25 player)",
	timerTurret4				= "Show timer for turret 4 (25 player)",
	timerGrounded				= "Show timer for ground phase duration"
})

L:SetMiscLocalization({
	YellAir				= "Give us a moment to prepare to build the turrets.",
	YellAir2			= "Fires out! Let's rebuild those turrets!",
	YellGround			= "Move quickly! She won't remain grounded for long!",
	EmotePhase2			= "%s is grounded permanently!"
})

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization({
	name = "XT-002 Deconstructor"
})

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization({
	name = "The Iron Council"
})

L:SetOptionLocalization({
	AlwaysWarnOnOverload		= "Always warn on $spell:63481 (otherwise, only when targeted)"
})

L:SetMiscLocalization({
	Steelbreaker		= "Steelbreaker",
	RunemasterMolgeim	= "Runemaster Molgeim",
	StormcallerBrundir	= "Stormcaller Brundir"
--	YellPull1					= "Whether the world's greatest gnats or the world's greatest heroes, you're still only mortal!",
--	YellPull2					= "Nothing short of total decimation will suffice.",
--	YellPull3					= "You will not defeat the Assembly of Iron so easily, invaders!",
--	YellRuneOfDeath				= "Decipher this!",
--	YellRunemasterMolgeimDied	= "What have you gained from my defeat? You are no less doomed, mortals!",
--	YellRunemasterMolgeimDied2	= "The legacy of storms shall not be undone.",
--	YellStormcallerBrundirDied	= "The power of the storm lives on...",
--	YellStormcallerBrundirDied2	= "You rush headlong into the maw of madness!",
--	YellSteelbreakerDied		= "My death only serves to hasten your demise.",
--	YellSteelbreakerDied2		= "Impossible!"
})

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization({
	name = "Algalon the Observer"
})

L:SetWarningLocalization({
	warnStarLow				= "Collapsing Star is low"
})

L:SetTimerLocalization({
	NextCollapsingStar		= "Next Collapsing Star"
})

L:SetOptionLocalization({
	NextCollapsingStar		= "Show timer for next Collapsing Star",
	warnStarLow				= "Show special warning when Collapsing Star is low (at ~25%)"
})

L:SetMiscLocalization({
--	HealthInfo				= "Heal for star",
--	FirstPull				= "See your world through my eyes: A universe so vast as to be immeasurable - incomprehensible even to your greatest minds.",
--	YellPull				= "Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer's message regardless of outcome.",
	YellKill				= "I have seen worlds bathed in the Makers' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?",
	Emote_CollapsingStar	= "%s begins to Summon Collapsing Stars!",
	Phase2					= "Behold the tools of creation!",
	CollapsingStar			= "Collapsing Star"
})

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization({
	name = "Kologarn"
})

L:SetTimerLocalization({
	timerLeftArm		= "Left Arm respawn",
	timerRightArm		= "Right Arm respawn",
	achievementDisarmed	= "Timer for Disarm"
})

L:SetOptionLocalization({
	timerLeftArm			= "Show timer for Left Arm respawn",
	timerRightArm			= "Show timer for Right Arm respawn",
	achievementDisarmed		= "Show timer for Disarm achievement"
})

L:SetMiscLocalization({
--	Yell_Trigger_arm_left	= "Just a scratch!",
--	Yell_Trigger_arm_right	= "Only a flesh wound!",
--	YellEncounterStart		= "None shall pass!",
--	YellLeftArmDies			= "Just a scratch!",
--	YellRightArmDies		= "Only a flesh wound!",
	Health_Body				= "Kologarn Body",
	Health_Right_Arm		= "Right Arm",
	Health_Left_Arm			= "Left Arm",
	FocusedEyebeam			= "Kologarn focuses his eyes on you!"
})

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization({
	name = "Auriaya"
})

L:SetWarningLocalization({
	WarnCatDied		= "Feral Defender down (%d lives remaining)",
	WarnCatDiedOne	= "Feral Defender down (1 life remaining)"
})

-- L:SetTimerLocalization({
-- 	timerDefender	= "Feral Defender activates"
-- })

L:SetOptionLocalization({
	WarnCatDied		= "Show warning when Feral Defender dies",
	WarnCatDiedOne	= "Show warning when Feral Defender has 1 life remaining"
--	timerDefender	= "Show timer for when Feral Defender is activated"
})

L:SetMiscLocalization({
	Defender = "Feral Defender (%d)",
	YellPull = "Some things are better left alone!"
})

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization({
	name = "Hodir"
})

L:SetMiscLocalization({
	Pull		= "You will suffer for this trespass!",
	YellKill	= "I... I am released from his grasp... at last."
})

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization({
	name = "Thorim"
})

L:SetWarningLocalization({
	specWarnHardmode = DBM_CORE_L.HARD_MODE -- don't translate
})

L:SetTimerLocalization({
	TimerHardmode		= "Hard mode"
})

L:SetOptionLocalization({
	specWarnHardmode	= "Show special announce when Hard mode has activated",
	TimerHardmode		= "Show timer for hard mode",
	AnnounceFails		= "Post player fails for $spell:62017 to raid chat<br/>(requires announce to be enabled and leader/promoted status)"
})

L:SetMiscLocalization({
	YellPhase1			= "Interlopers! You mortals who dare to interfere with my sport will pay.... Wait--you...",
	YellPhase2			= "Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!",
	YellKill			= "Stay your arms! I yield!",
	YellHardModeActive	= "Impossible!  Lord Thorim, I will bring your foes a frigid death!",
	YellHardModeFailed	= "These pathetic mortals are harmless, beneath my station. Dispose of them!",
	ChargeOn			= "Lightning Charge: %s",
	Charge				= "Lightning Charge fails (this try): %s"
})

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization({
	name = "Freya"
})

L:SetWarningLocalization({
	WarnSimulKill		= "First add down - Resurrection in ~12 seconds"
})

L:SetTimerLocalization({
	TimerSimulKill	= "Resurrection"
})

L:SetOptionLocalization({
	WarnSimulKill	= "Announce first mob down",
	TimerSimulKill	= "Show timer for mob resurrection"
})

L:SetMiscLocalization({
	SpawnYell			= "Children, assist me!",
	WaterSpirit			= "Ancient Water Spirit",
	Snaplasher			= "Snaplasher",
	StormLasher			= "Storm Lasher",
	YellKill			= "His hold on me dissipates. I can see clearly once more. Thank you, heroes.",
	YellAdds1			= "Eonar, your servant requires aid!",
	YellAdds2			= "The swarm of the elements shall overtake you!",
	EmoteLGift			= "begins to grow!", -- A |cFF00FFFFLifebinder's Gift|r begins to grow!
	TrashRespawnTimer	= "Freya trash respawn",
	YellPullNormal		= "The Conservatory must be protected!",
	YellPullHard		= "Elders grant me your strength!"
})

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization({
	name = "Freya's Elders"
})

L:SetOptionLocalization({
	TrashRespawnTimer	= "Show timer for trash respawn"
})

L:SetMiscLocalization({
	TrashRespawnTimer	= "Freya trash respawn"
})

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization({
	name = "Mimiron"
})

L:SetWarningLocalization({
	MagneticCore		= ">%s< has Magnetic Core",
	WarnBombSpawn		= "Bomb Bot spawned"
})

L:SetTimerLocalization({
	TimerHardmode	= "Hard mode - Self-destruct",
	TimeToPhase2	= "Phase 2",
	TimeToPhase3	= "Phase 3",
	TimeToPhase4	= "Phase 4"
})

L:SetOptionLocalization({
	TimeToPhase2			= "Show timer for Phase 2",
	TimeToPhase3			= "Show timer for Phase 3",
	TimeToPhase4			= "Show timer for Phase 4",
	MagneticCore			= "Announce Magnetic Core looters",
	AutoChangeLootToFFA		= "Switch loot mode to Free for All in Phase 3",
	WarnBombSpawn			= "Show warning for Bomb Bots",
	TimerHardmode			= "Show timer for hard mode"
})

L:SetMiscLocalization({
	MobPhase1		= "Leviathan Mk II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Aerial Command Unit",
	MobPhase4		= "V-07-TR-0N", -- Retail has this "wrong" in the EJ section as V0-L7R-0N. Yell and audiofile corroborate this. Also there are sloppy differences across locales, which I am now harmonizing.
	YellPull		= "We haven't much time, friends! You're going to help me test out my latest and greatest creation. Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002.",
	YellHardPull	= "Self-destruct sequence initiated.",
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9 percent! Barely a dent! Moving right along.",
	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",
	YellPhase4		= "Preliminary testing phase complete. Now comes the true test!",
	YellKilled		= "It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear.",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
})

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization({
	name = "General Vezax"
})

L:SetTimerLocalization({
	hardmodeSpawn = "Saronite Animus spawn"
})

L:SetOptionLocalization({
	hardmodeSpawn					= "Show timer for Saronite Animus spawn (hard mode)",
	CrashArrow						= "Show DBM arrow when $spell:62660 is near you"
})

L:SetMiscLocalization({
	EmoteSaroniteVapors	= "A cloud of saronite vapors coalesces nearby!"
})

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization({
	name = "Yogg-Saron"
})

L:SetWarningLocalization({
	WarningGuardianSpawned			= "Guardian %d spawned",
	WarningCrusherTentacleSpawned	= "Crusher Tentacle spawned",
	WarningSanity					= "%d Sanity remaining",
	SpecWarnSanity					= "%d Sanity remaining",
	SpecWarnGuardianLow				= "Stop attacking this Guardian",
	SpecWarnMadnessOutNow			= "Induce Madness ending - Move out",
	WarnBrainPortalSoon				= "Brain Portal in 10 seconds",
	SpecWarnBrainPortalSoon			= "Brain Portal soon"
})

L:SetTimerLocalization({
	NextPortal	= "Brain Portal"
})

L:SetOptionLocalization({
	WarningGuardianSpawned			= "Show warning for Guardian spawns",
	WarningCrusherTentacleSpawned	= "Show warning for Crusher Tentacle spawns",
	WarningSanity					= "Show warning when $spell:63050 is low",
	SpecWarnSanity					= "Show special warning when $spell:63050 is very low",
	SpecWarnGuardianLow				= "Show special warning when Guardian (Phase 1) is low (for DPS)",
	WarnBrainPortalSoon				= "Show pre-warning for Brain Portal",
	SpecWarnMadnessOutNow			= "Show special warning shortly before $spell:64059 ends",
	SpecWarnBrainPortalSoon			= "Show special warning for next Brain Portal",
	NextPortal						= "Show timer for next Brain Portal",
	ShowSaraHealth					= "Show health frame for Sara in Phase 1 (must be targeted or focused by at least one raid member)",
	MaladyArrow						= "Show DBM arrow when $spell:63881 is near you"
})

L:SetMiscLocalization({
	YellPull			= "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",
	S1TheLucidDream		= "Stage One: The Lucid Dream",
	Sara				= "Sara",
	GuardianofYoggSaron	= "Guardian of Yogg-Saron",
	S2DescentIntoMadness= "Stage Two: Descent into Madness",
	CrusherTentacle		= "Crusher Tentacle",
	CorruptorTentacle	= "Corruptor Tentacle",
	ConstrictorTentacle	= "Constrictor Tentacle",
	DescentIntoMadness	= "Descent into Madness",
	InfluenceTentacle	= "Influence Tentacle",
	LaughingSkull		= "Laughing Skull",
	BrainofYoggSaron	= "Brain of Yogg-Saron",
	S3TrueFaceofDeath	= "Stage Three: True Face of Death",
	YoggSaron			= "Yogg-Saron",
	ImmortalGuardian	= "Immortal Guardian"
})
