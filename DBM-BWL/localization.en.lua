local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization({
	name = "Razorgore the Untamed"
})

L:SetTimerLocalization({
	TimerAddsSpawn	= "Adds spawning"
})

L:SetOptionLocalization({
	TimerAddsSpawn	= "Show timer for first adds spawning"
})

L:SetMiscLocalization({
	Phase2Emote	= "flee as the controlling power of the orb is drained.",
	YellPull	= "Intruders have breached the hatchery! Sound the alarm! Protect the eggs at all costs!\n"
})

-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization({
	name				= "Vaelastrasz the Corrupt"
})

L:SetMiscLocalization({
	Event				= "Too late, friends! Nefarius' corruption has taken hold...I cannot...control myself.\n"
})

-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization({
	name	= "Broodlord Lashlayer"
})

L:SetMiscLocalization({
	Pull	= "None of your kind should be here!  You've doomed only yourselves!"
})

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization({
	name = "Firemaw"
})

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization({
	name = "Ebonroc"
})

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization({
	name = "Flamegor"
})

-----------------------
--  Vulnerabilities  --
-----------------------
-- Chromaggus, Death Talon Overseer and Death Talon Wyrmguard
L = DBM:GetModLocalization("TalonGuards")

L:SetGeneralLocalization({
	name = "Talon Guards"
})

L:SetWarningLocalization({
	WarnVulnerable		= "%s Vulnerability"
})

L:SetOptionLocalization({
	WarnVulnerable		= "Show warning for spell vulnerabilities"
})

L:SetMiscLocalization({
	Fire		= "Fire",
	Nature		= "Nature",
	Frost		= "Frost",
	Shadow		= "Shadow",
	Arcane		= "Arcane",
	Holy		= "Holy"
})

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization({
	name = "Chromaggus"
})

L:SetWarningLocalization({
	WarnBreath		= "%s",
	WarnVulnerable	= "%s Vulnerability"
})

L:SetTimerLocalization({
	TimerBreathCD	= "%s CD",
	TimerBreath		= "%s cast",
	TimerVulnCD		= "Vulnerability CD"
})

L:SetOptionLocalization({
	WarnBreath		= "Show warning when Chromaggus casts one of his Breaths",
	WarnVulnerable	= "Show warning for spell vulnerabilities",
	TimerBreathCD	= "Show Breath CD",
	TimerBreath		= "Show Breath cast",
	TimerVulnCD		= "Show Vulnerability CD"
})

L:SetMiscLocalization({
	Breath1		= "First Breath",
	Breath2		= "Second Breath",
	VulnEmote	= "%s flinches as its skin shimmers.",
	Vuln		= "Vulnerability",
	Fire		= "Fire",
	Nature		= "Nature",
	Frost		= "Frost",
	Shadow		= "Shadow",
	Arcane		= "Arcane",
	Holy		= "Holy"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization({
	name = "Nefarian"
})

L:SetWarningLocalization({
	WarnAddsLeft		= "%d kills remaining",
	WarnClassCall		= "%s call",
	specwarnClassCall	= "Class call on you!"
})

L:SetTimerLocalization({
	TimerClassCall		= "%s call ends"
})

L:SetOptionLocalization({
	TimerClassCall		= "Show timer for class call duration",
	WarnAddsLeft		= "Announce kills remaining until Stage 2 is triggered",
	WarnClassCall		= "Announce class calls",
	specwarnClassCall	= "Show Special warning when you are affected by class call"
})

L:SetMiscLocalization({
	YellP1		= "Let the games begin!",
	YellP2		= "Well done, my minions. The mortals' courage begins to wane! Now, let's see how they contend with the true Lord of Blackrock Spire!!!",
	YellP3		= "Impossible! Rise my minions!  Serve your master once more!",
	YellShaman	= "Shamans, show me what your totems can do!",
	YellPaladin	= "Paladins... I've heard you have many lives. Show me.",
	YellDruid	= "Druids and your silly shapeshifting. Lets see it in action!",
	YellPriest	= "Priests! If you're going to keep healing like that, we might as well make it a little more interesting!",
	YellWarrior	= "Warriors, I know you can hit harder than that! Let's see it!",
	YellRogue	= "Rogues? Stop hiding and face me!",
	YellWarlock	= "Warlocks, you shouldn't be playing with magic you don't understand. See what happens?",
	YellHunter	= "Hunters and your annoying pea-shooters!",
	YellMage	= "Mages too? You should be more careful when you play with magic...",
	YellDK		= "Death Knights... get over here!"
})
