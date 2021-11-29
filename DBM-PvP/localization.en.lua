local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "General Options"
})

L:SetTimerLocalization({
	TimerCap		= "%s",
	TimerFlag		= "Flag respawn",
	TimerShadow		= "Shadow Sight",
	TimerStart		= "Starting in",
	TimerWin		= "Victory in"
})

L:SetOptionLocalization({
	AutoSpirit			= "Auto-release spirit",
	ColorByClass		= "Set name color to class color in the score frame",
	HideBossEmoteFrame	= "Hide the raid boss emote frame and garrison/Guild toasts during battlegrounds",
	ShowBasesToWin		= "Show bases required to win",
	ShowEstimatedPoints	= "Show estimated points on win/loss",
	ShowFlagCarrier		= "Show flag carrier",
	ShowRelativeGameTime= "Fill win timer relative to BG start time (If disabled, bar just always looks full)",
	TimerCap			= "Show capture timer",
	TimerFlag			= "Show flag respawn timer",
	TimerShadow			= "Show timer for Shadow Sight",
	TimerStart			= "Show timer till match start",
	TimerWin			= "Show win timer"
})

L:SetMiscLocalization({
	BgStart120			= "2 minutes",
	BgStart60			= "1 minute",
	BgStart30			= "30 seconds",
	ArenaInvite			= "Arena invite",
	Start60				= "One minute until the Arena battle begins!",
	Start30				= "Thirty seconds until the Arena battle begins!",
	Start15				= "Fifteen seconds until the Arena battle begins!",
	BasesToWin			= "Bases to win: %d",
	WinBarText			= "%s wins",
	-- TODO: Implement the flag carrying system
	Flag				= "Flag",
	FlagReset			= "The flag has been reset.",
	FlagTaken			= "(.+) has taken the flag!",
	FlagCaptured		= "The .+ ha%w+ captured the flag!",
	FlagDropped			= "The flag has been dropped.",
	--
	ExprFlagPickUp		= "The (%w+) .lag was picked up by (.+)!", -- Unused
	ExprFlagCaptured	= "(.+) captured the (%w+) flag!",
--	ExprFlagCaptured	= "(.+) captured the (%w+) Flag!", -- TrinityCore
	ExprFlagReturn		= "The (%w+) .lag was returned to its base by (.+)!", -- Unused
	ScoreExpr			= "(%d+)/1600",
	Vulnerable1			= "The flag carriers have become vulnerable to attack!",
	Vulnerable2			= "The flag carriers have become increasingly vulnerable to attack!",
	-- Alterac/IsleOfConquest bosses
	InfoFrameHeader		= "Boss Health",
	HordeBoss			= "Horde Boss",
	AllianceBoss		= "Alliance Boss",
	Galvangar			= "Galvangar",
	Balinda				= "Balinda",
	Ivus				= "Ivus",
	Lokholar			= "Lokholar",
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "Alterac Valley"
})

L:SetTimerLocalization({
	TimerBoss	= "%s"
})

L:SetOptionLocalization({
	AutoTurnIn	= "Automatically turn-in quests",
	TimerBoss	= "Show boss remaining timer"
})

L:SetMiscLocalization({
	BossHorde	= "WHO DARES SUMMON LOKHOLAR?",
	BossAlly	= "Wicked, wicked, mortals! The forest weeps. The elements recoil at the destruction. Ivus must purge you from this world!"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "Arathi Basin"
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "Eye of the Storm"
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "Warsong Gulch"
})

------------------------------
--  Strand of the Ancients  --
------------------------------
L = DBM:GetModLocalization("StrandoftheAncients")

L:SetGeneralLocalization({
	name = "Strand of the Ancients"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "Isle of Conquest"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "Siege Engine ready!",
	WarnSiegeEngineSoon	= "Siege Engine in ~10 sec"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "Siege Engine ready"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "Show timer for Siege Engine construction",
	WarnSiegeEngine		= "Show warning when Siege Engine is ready",
	WarnSiegeEngineSoon	= "Show warning when Siege Engine is almost ready",
	ShowGatesHealth		= "Show the health of damaged gates (health values may be wrong after joining an already ongoing battleground!)"
})

L:SetMiscLocalization({
	GatesHealthFrame		= "Damaged gates",
	SiegeEngine				= "Siege Engine",
	GoblinStartAlliance		= "See those seaforium bombs? Use them on the gates while I repair the siege engine!",
	GoblinStartHorde		= "I'll work on the siege engine, just watch my back. Use those seaforium bombs on the gates if you need them!",
	GoblinHalfwayAlliance	= "I'm halfway there! Keep the Horde away from here.  They don't teach fighting in engineering school!",
	GoblinHalfwayHorde		= "I'm about halfway done! Keep the Alliance away - fighting's not in my contract!",
	GoblinFinishedAlliance	= "My finest work so far! This siege engine is ready for action!",
	GoblinFinishedHorde		= "The siege engine is ready to roll!",
	GoblinBrokenAlliance	= "It's broken already?! No worries. It's nothing I can't fix.",
	GoblinBrokenHorde		= "It's broken again?! I'll fix it... just don't expect the warranty to cover this"
})