local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "Anub'Rekhan"
})

L:SetOptionLocalization({
	ArachnophobiaTimer	= "Show timer for Arachnophobia (achievement)"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Arachnophobia",
	Pull1				= "Yes, run! It makes the blood pump faster!",
	Pull2				= "Just a little taste..."
})

----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "Grand Widow Faerlina"
})

L:SetWarningLocalization({
	WarningEmbraceExpire	= "Widow's Embrace ends in 5 seconds"
})

L:SetOptionLocalization({
	WarningEmbraceExpire	= "Show pre-warning for $spell:28732 fade"
})

L:SetMiscLocalization({
	Pull					= "Kneel before me, worm!"--Not actually pull trigger, but often said on pull
})

---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "Maexxna"
})

L:SetWarningLocalization({
	WarningSpidersSoon	= "Maexxna Spiderlings in 5 seconds",
	WarningSpidersNow	= "Maexxna Spiderlings spawned"
})

L:SetTimerLocalization({
	TimerSpider	= "Next Maexxna Spiderlings"
})

L:SetOptionLocalization({
	WarningSpidersSoon	= "Show pre-warning for Maexxna Spiderlings",
	WarningSpidersNow	= "Show warning for Maexxna Spiderlings",
	TimerSpider			= "Show timer for next Maexxna Spiderlings"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Arachnophobia"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "Noth the Plaguebringer"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teleported",
	WarningTeleportSoon	= "Teleport in 10 seconds"
})

L:SetTimerLocalization({
	TimerTeleport		= "Teleport",
	TimerTeleportBack	= "Teleport back"
})

L:SetOptionLocalization({
	WarningTeleportNow	= "Show warning for Teleport",
	WarningTeleportSoon	= "Show pre-warning for Teleport",
	TimerTeleport		= "Show timer for Teleport",
	TimerTeleportBack	= "Show timer for Teleport back"
})

L:SetMiscLocalization({
	Pull				= "Die, trespasser!",
	Adds				= "summons forth Skeletal Warriors!",
	AddsTwo				= "raises more skeletons!"
})

--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Heigan the Unclean"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teleported",
	WarningTeleportSoon	= "Teleport in %d seconds"
})

L:SetTimerLocalization({
	TimerTeleport	= "Teleport"
})

L:SetOptionLocalization({
	WarningTeleportNow	= "Show warning for Teleport",
	WarningTeleportSoon	= "Show pre-warning for Teleport",
	TimerTeleport		= "Show timer for Teleport"
})

L:SetMiscLocalization({
	Pull				= "You are mine now."
})

---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Loatheb"
})

L:SetWarningLocalization({
	WarningHealSoon	= "Healing possible in 3 seconds",
	WarningHealNow	= "Heal now"
})

L:SetOptionLocalization({
	WarningHealSoon		= "Show pre-warning for 3-second healing window",
	WarningHealNow		= "Show warning for 3-second healing window",
	SporeDamageAlert	= "Send whisper to and announce to raid players who damage spores\n(requires announce to be enabled and leader/promoted status)",
	CorruptedSorting	= "Set infoframe sorting behaviour for $spell:55593",
	Alphabetical		= "Sort in alphabetical order",
	Duration			= "Sort by duration"
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Patchwerk"
})

L:SetOptionLocalization({
	WarningHateful	= "Post Hateful Strike targets to raid chat\n(requires announce to be enabled and leader/promoted status)"
})

L:SetMiscLocalization({
	yell1			= "Patchwerk want to play!",
	yell2			= "Kel'thuzad make Patchwerk his avatar of war!",
	HatefulStrike	= "Hateful Strike --> %s [%s]"
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
	WarningChargeChanged	= "Polarity changed to %s",
	WarningChargeNotChanged	= "Polarity did not change"
})

L:SetOptionLocalization({
	WarningChargeChanged	= "Show special warning when your polarity changed",
	WarningChargeNotChanged	= "Show special warning when your polarity did not change",
	ArrowsEnabled			= "Show arrows during $spell:28089",
	TwoCamp					= "Show arrows (normal \"2 camp\" run through strategy)",
	ArrowsRightLeft			= "Show left/right arrows for the \"4 camp\" strategy (show left arrow if polarity changed, right if not)",
	ArrowsInverse			= "Inverse \"4 camp\" strategy (show right arrow if polarity changed, left if not)"
})

L:SetMiscLocalization({
	Yell	= "Stalagg crush you!",
	Emote	= "%s overloads!",
	Emote2	= "Tesla Coil overloads!",
	Boss1	= "Feugen",
	Boss2	= "Stalagg",
	Charge1 = "negative",
	Charge2 = "positive"
})

----------------------------
--  Instructor Razuvious  --
----------------------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "Instructor Razuvious"
})

L:SetWarningLocalization({
	WarningShieldWallSoon	= "Shield Wall ends in 5 seconds"
})

L:SetOptionLocalization({
	WarningShieldWallSoon	= "Show pre-warning for Shield Wall ending"
})

L:SetMiscLocalization({
	Yell1 = "Show them no mercy!",
	Yell2 = "The time for practice is over! Show me what you have learned!",
	Yell3 = "Do as I taught you!",
	Yell4 = "Sweep the leg... Do you have a problem with that?"
})

----------------------------
--  Gothik the Harvester  --
----------------------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "Gothik the Harvester"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "Wave %d: %s in 3 sec",
	WarningWaveSpawned	= "Wave %d: %s spawned",
	WarningRiderDown	= "Rider down",
	WarningKnightDown	= "Knight down",
	WarningPhase2		= "Phase 2"
})

L:SetTimerLocalization({
	TimerWave	= "Wave %d",
	TimerPhase2	= "Phase 2"
})

L:SetOptionLocalization({
	TimerWave			= "Show timer for next wave",
	TimerPhase2			= "Show timer for Phase 2",
	WarningWaveSoon		= "Show pre-warning for wave",
	WarningWaveSpawned	= "Show warning for wave spawned",
	WarningRiderDown	= "Show warning when an Unrelenting Rider dies",
	WarningKnightDown	= "Show warning when an Unrelenting Death Knight dies"
})

L:SetMiscLocalization({
	yell			= "Foolishly you have sought your own demise.",
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s and %d %s",
	WarningWave3	= "%d %s, %d %s and %d %s",
	Trainee			= "Trainees",
	Knight			= "Knights",
	Rider			= "Riders"
})

---------------------
--  Four Horsemen  --
---------------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Four Horsemen"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Mark %d in 3 seconds",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetOptionLocalization({
	WarningMarkSoon				= "Show pre-warning for Mark",
	SpecialWarningMarkOnPlayer	= "Show special warning when you are affected by more than 4 marks"
})

L:SetMiscLocalization({
	Korthazz	= "Thane Korth'azz",
	Rivendare	= "Baron Rivendare",
	Blaumeux	= "Lady Blaumeux",
	Zeliek		= "Sir Zeliek"
})

-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "Sapphiron"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon	= "Air phase in 10 seconds",
	WarningAirPhaseNow	= "Air phase",
	WarningLanded		= "Sapphiron landed",
	SpecWarnSapphLow	= "Sapphiron can't fly!"
})

L:SetTimerLocalization({
	TimerAir		= "Air phase",
	TimerLanding	= "Landing"
})

L:SetOptionLocalization({
	WarningAirPhaseSoon	= "Show pre-warning for air phase",
	WarningAirPhaseNow	= "Announce air phase",
	WarningLanded		= "Announce ground phase",
	TimerAir			= "Show timer for air phase",
	TimerLanding		= "Show timer for landing",
	SpecWarnSapphLow	= "Special warning for 10% execute phase (cancel air phase)"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s takes a deep breath.",
	AirPhase			= "Sapphiron lifts off into the air!",
	LandingPhase		= "Sapphiron resumes his attacks!"
})

------------------
--  Kel'Thuzad  --
------------------
L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "Kel'Thuzad"
})

L:SetWarningLocalization({
	specwarnP2Soon	= "Kel'Thuzad engages in 10 Seconds",
	warnAddsSoon	= "Guardians of Icecrown incoming soon",
	WeaponsStatus	= "Auto Unequip/Equip weapons: %s (%s - %s)"
})

L:SetTimerLocalization({
	TimerPhase2	= "Phase 2"
})

L:SetOptionLocalization({
	TimerPhase2			= "Show timer for Phase 2",
	specwarnP2Soon		= "Show special warning 10 seconds before Kel'Thuzad engages",
	warnAddsSoon		= "Show pre-warning for Guardians of Icecrown",
	WeaponsStatus		= "Show special warning at combat start if unequip/equip function is enabled",
	EqUneqWeaponsKT		= "Automatically unequip and equip weapons on a timer, before and after $spell:28410. Requires a COMPLETE (with the weapons of choice that will be equipped) equipment set named \"pve\"",
	EqUneqWeaponsKT2	= "Automatically unequip and equip weapons when $spell:28410 is cast on YOU. Requires a COMPLETE (with the weapons of choice that will be equipped) equipment set named \"pve\"",
	RemoveBuffsOnMC		= "Remove buffs when $spell:28410 is cast on you. Each option is cumulative.",
	Never				= NEVER, -- don't translate,
	Gift				= "Remove $spell:48469 / $spell:48470. Minimal approach to prevent $spell:33786 resists.",
	CCFree				= "+ Remove $spell:48169 / $spell:48170. Account for resists of spells in the Shadow school.",
	ShortOffensiveProcs	= "+ Remove offensive procs that have a low duration. Recommended for raid safety without compromising raid damage output.",
	MostOffensiveBuffs	= "+ Remove most offensive buffs (mainly for Casters and |cFFFF7C0AFeral Druids|r). Maximum raid safety with loss of damage output and need to self-rebuff/shapeshift!",
	EqUneqFilter		= FILTER, -- don't translate
	OnlyDPS				= DBM_COMMON_L.DAMAGE_ICON, -- don't translate
	DPSTank				= DBM_COMMON_L.DAMAGE_ICON..DBM_COMMON_L.TANK_ICON, -- don't translate
	NoFilter			= DBM_COMMON_L.DAMAGE_ICON..DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON -- don't translate
})

L:SetMiscLocalization({
	Yell		= "Minions, servants, soldiers of the cold dark! Obey the call of Kel'Thuzad!",
--	YellMC1		= "Your soul is bound to me, now!",
--	YellMC2		= "There will be no escape!",
	Yell1Phase2	= "Pray for mercy!", -- 12995
	Yell2Phase2	= "Scream your dying breath!", -- 12996
	Yell3Phase2	= "The end is upon you!", -- 12997
	YellPhase3	= "Master, I require aid!", -- 12998
	YellGuardians	= "Very well. Warriors of the frozen wastes, rise up! I command you to fight, kill and die for your master! Let none survive!", -- 12994
	setMissing	= "ATTENTION! DBM automatic weapon unequipping/equipping will not work until you create a equipment set named pve",
	EqUneqLineDescription	= "Automatic Equip/Unequip"
})
