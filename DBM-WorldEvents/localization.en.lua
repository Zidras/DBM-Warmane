local L

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name = "Apothecary Trio"
})

L:SetTimerLocalization({
	HummelActive		= "Hummel becomes active",
	BaxterActive		= "Baxter becomes active",
	FryeActive			= "Frye becomes active"
})

L:SetOptionLocalization({
	TrioActiveTimer		= "Show timers for when Apothecary Trio becomes active"
})

L:SetMiscLocalization({
	SayCombatStart		= "Did they bother to tell you who I am and why I am doing this?"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("Ahune")

L:SetGeneralLocalization({
	name = "Ahune"
})

L:SetWarningLocalization({
--	Submerged		= "Ahune has submerged",
	Emerged			= "Ahune has emerged",
	specWarnAttack	= "Ahune is vulnerable - Attack now!"
})

L:SetTimerLocalization({
	SubmergeTimer	= "Submerge",
	EmergeTimer		= "Emerge",
	TimerCombat		= "Combat starts"
})

L:SetOptionLocalization({
--	Submerged		= "Show warning when Ahune submerges",
	Emerged			= "Show warning when Ahune emerges",
	specWarnAttack	= "Show special warning when Ahune becomes vulnerable",
	SubmergeTimer	= "Show timer for submerge",
	EmergeTimer		= "Show timer for emerge",
	TimerCombat		= "Show timer for start of combat",
})

L:SetMiscLocalization({
	Pull			= "The Ice Stone has melted!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Direbrew"
})

L:SetWarningLocalization({
	specWarnBrew		= "Get rid of the brew before she tosses you another one!",
	specWarnBrewStun	= "HINT: You were bonked, remember to drink the brew next time!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Show special warning for $spell:47376",
	specWarnBrewStun	= "Show special warning for $spell:47340"
})

L:SetMiscLocalization({
	YellBarrel	= "Barrel on me!"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Headless Horseman"
})

L:SetWarningLocalization({
	WarnPhase				= "Phase %d",
	warnHorsemanSoldiers	= "Pulsing Pumpkins spawning",
	warnHorsemanHead		= "Head of the Horseman Active"
})

L:SetOptionLocalization({
	WarnPhase				= "Show a warning for each phase change",
	warnHorsemanSoldiers	= "Show warning for Pulsing Pumpkin spawn",
	warnHorsemanHead		= "Show warning for Head of the Horseman spawning",
	specWarnHorsemanHead	= "Show special warning for Whirlwind (2nd and later head spawn)"
})

L:SetMiscLocalization({
	HorsemanSummon		= "Horseman rise...", -- 22695
	HorsemanHead		= "Get over here, you idiot!", -- 22415
	HorsemanSoldiers	= "Soldiers arise, stand and fight! Bring victory at last to this fallen knight!", -- 23861
	SayCombatEnd		= "This end have I reached before.  What new adventure lies in store?" -- 23455
})

-----------------------------
--  Warmane Annual Events  --
----------------------------
--  Tower Defense (2024)  --
----------------------------
L = DBM:GetModLocalization("WarmaneTowerDefense")

L:SetGeneralLocalization({
	name = "Tower Defense (2024)"
})

-- L:SetWarningLocalization({
-- })

-- L:SetTimerLocalization({
-- })

-- L:SetOptionLocalization({
-- })

L:SetTimerLocalization({
	TimerRound			= "Round %d (%s)",
})

L:SetOptionLocalization({
	TimerRound			= "Upon round victory, show timer to begin the next round (with round number and whether it is a Boss or Adds round)"
})

L:SetMiscLocalization({
	RoundStart			= "Round (%d+) starts now!",
	RoundComplete		= "Round (%d+) complete! Buy your upgrades at the vendor now.",
	RoundFailed			= "Your defense has failed", -- , you have survived (%d) round!
	EqUneqWeapons		= "Unequip/equip weapons if $spell:28410 is cast on you. For equipping to work, create a COMPLETE (with the weapons of choice that will be equipped) equipment set named \"pve\".",
})
