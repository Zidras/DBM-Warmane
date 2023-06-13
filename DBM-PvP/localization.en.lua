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
	ShowGatesHealth		= "Show the health of damaged gates (health values may be wrong after joining an already ongoing battleground!)",
	ShowRelativeGameTime= "Fill win timer relative to BG start time (If disabled, bar just always looks full)",
	TimerCap			= "Show capture timer",
	TimerFlag			= "Show flag respawn timer",
	TimerShadow			= "Show timer for Shadow Sight",
	TimerStart			= "Show timer till match start",
	TimerWin			= "Show win timer"
})

L:SetMiscLocalization({
	--BG 2 minutes
	BGStart120			= "The battle begins in 2 minutes!",
	BgStart120Alterac	= "The Battle for Alterac Valley begins in 2 minutes.",
	BgStart120Arathi	= "The battle for Arathi Basin begins in 2 minutes.",
	BgStart120EotS		= "The battle for Eye of the Storm begins in 2 minutes.",
	BgStart120IoConquest= "The battle will begin in two minutes.",
	BgStart120SotA		= "The battle for Strand of the Ancients begins in 2 minutes.",
	BgStart120Warsong	= "The battle for Warsong Gulch begins in 2 minutes.",
	--BG 1 minute
	BgStart60TC			= "The battle begins in 1 minute!",
	BgStart60Alterac	= "The Battle for Alterac Valley begins in 1 minute.",
	BgStart60AlteracTC	= "1 minute until the battle for Alterac Valley begins.",
	BgStart60Arathi		= "The Battle for Arathi Basin begins in 1 minute.",
	BgStart60EotS		= "The Battle for Eye of the Storm begins in 1 minute.",
	BgStart60IoConquest	= "The battle will begin in 1 minute.",
	BgStart60SotA		= "The battle for Strand of the Ancients begins in 1 minute.",
	BgStart60SotA2		= "Round 2 of the Battle for the Strand of the Ancients begins in 1 minute.",
	BgStart60Warsong	= "The battle for Warsong Gulch begins in 1 minute.",
	-- BG 30 seconds
	BgStart30TC			= "The battle begins in 30 seconds!",
	BgStart30Alterac	= "The Battle for Alterac Valley begins in 30 seconds. Prepare yourselves!",
	BgStart30AlteracTC	= "30 seconds until the battle for Alterac Valley begins.",
	BgStart30Arathi		= "The Battle for Arathi Basin begins in 30 seconds. Prepare yourselves!",
	BgStart30EotS		= "The Battle for Eye of the Storm begins in 30 seconds.",
	BgStart30IoConquest	= "The battle will begin in 30 seconds!",
	BgStart30SotA		= "The battle for Strand of the Ancients begins in 30 seconds. Prepare yourselves!.",
	BgStart30SotA2		= "Round 2 begins in 30 seconds. Prepare yourselves!",
	BgStart30Warsong	= "The battle for Warsong Gulch begins in 30 seconds. Prepare yourselves!",
	--
	ArenaInvite			= "Arena invite",
	Start60				= "One minute until the Arena battle begins!",
	Start30				= "Thirty seconds until the Arena battle begins!",
	Start15				= "Fifteen seconds until the Arena battle begins!",
	BasesToWin			= "Bases to win: %d",
	WinBarText			= "%s wins",
	-- Flag carrying system
	Flag				= "Flag",
	FlagReset			= "The flag has been reset.",
	FlagResetTC			= "The flag has been reset.",
	FlagTaken			= "(.+) has taken the flag!",
	FlagTakenTC			= "(.+) has taken the flag!",
	FlagCaptured		= "The (%w+) have captured the flag!",
	FlagCapturedTC		= "The (%w+) have captured the flag!",
	FlagDropped			= "The flag has been dropped.",
	FlagDroppedTC		= "The flag has been dropped.",
	--
	ExprFlagPickUp		= "The (%w+) .lag was picked up by (.+)!",
	ExprFlagPickUpTC	= "The (%w+) .lag was picked up by (.+)!",
	ExprFlagCaptured	= "(.+) captured the (%w+) .lag!",
	ExprFlagCapturedTC	= "(.+) captured the (%w+) .lag!",
	ExprFlagReturn		= "The (%w+) .lag was returned to its base by (.+)!",
	ExprFlagReturnTC	= "The (%w+) .lag was returned to its base by (.+)!",
	ExprFlagDropped		= "The (%w+) .lag was dropped by (.+)!",
	ExprFlagDroppedTC	= "The (%w+) .lag was dropped by (.+)!",
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
	-- Gates
	GatesHealthFrame				= "Damaged gates",
	GreenEmerald					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:127:142|t",
	GreenEmeraldAttackedTex			= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:199:215:127:142|t",
	GreenEmeraldDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:127:142|t",
	BlueSapphire					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t",
	BlueSapphireAttackedTex			= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:199:215:92:107|t",
	BlueSapphireDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t",
	PurpleAmethyst					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:127:142|t",
	PurpleAmethystAttackedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:145:161:127:142|t",
	PurpleAmethystDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:127:142|t",
	RedSun							= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t",
	RedSunAttackedTex				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:145:161:92:107|t",
	RedSunDestroyedTex				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t",
	YellowMoon						= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:73:89:127:142|t",
	YellowMoonAttackedTex			= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:91:107:127:142|t",
	YellowMoonDestroyedTex			= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:109:125:127:142|t",
	ChamberAncientRelics			= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:73:89:92:107|t",
	ChamberAncientRelicsAttackedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:91:107:92:107|t",
	ChamberAncientRelicsDestroyedTex= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:109:125:92:107|t",
	--
	HordeGateFront					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t Front Gate",
	HordeGateFrontDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t Front Gate",
	HordeGateWest					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t West Gate",
	HordeGateWestDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t West Gate",
	HordeGateEast					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t East Gate",
	HordeGateEastDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t East Gate",
	AllianceGateFront				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t Front Gate",
	AllianceGateFrontDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t Front Gate",
	AllianceGateWest				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t West Gate",
	AllianceGateWestDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t West Gate",
	AllianceGateEast				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t East Gate",
	AllianceGateEastDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t East Gate",
	-- Strands of the Ancients Gates emotes
	GreenEmeraldAttacked			= "The Gate of the Green Emerald is under attack!",
	GreenEmeraldDestroyed			= "The Gate of the Green Emerald was destroyed!",
	BlueSapphireAttacked			= "The Gate of the Blue Sapphire is under attack!",
	BlueSapphireDestroyed			= "The Gate of the Blue Sapphire was destroyed!",
	PurpleAmethystAttacked			= "The Gate of the Purple Amethyst is under attack!",
	PurpleAmethystDestroyed			= "The Gate of the Purple Amethyst was destroyed!",
	RedSunAttacked					= "The Gate of the Red Sun is under attack!",
	RedSunDestroyed					= "The Gate of the Red Sun was destroyed!",
	YellowMoonAttacked				= "The Gate of the Yellow Moon is under attack!",
	YellowMoonDestroyed				= "The Gate of the Yellow Moon was destroyed!",
	ChamberAncientRelicsAttacked	= "The relic chamber is under attack!",
	ChamberAncientRelicsDestroyed	= "The chamber has been breached! The titan relic is vulnerable!",
	-- Isle of Conquest Gates CHAT_MSG_BG_SYSTEM_NEUTRAL messages
	HordeGateFrontDestroyed			= "The front gate of the horde keep is destroyed!",
	HordeGateFrontDestroyedTC		= "The front gate of the Horde keep has been destroyed!",
	HordeGateWestDestroyed			= "The west gate of the horde keep is destroyed!",
	HordeGateWestDestroyedTC		= "The west gate of the Horde keep has been destroyed!",
	HordeGateEastDestroyed			= "The east gate of the horde keep is destroyed!",
	HordeGateEastDestroyedTC		= "The east gate of the Horde keep has been destroyed!",
	AllianceGateFrontDestroyed		= "The front gate of the alliance keep is destroyed!",
	AllianceGateFrontDestroyedTC	= "The front gate of the Alliance keep has been destroyed!",
	AllianceGateWestDestroyed		= "The west gate of the alliance keep is destroyed!",
	AllianceGateWestDestroyedTC		= "The west gate of the Alliance keep has been destroyed!",
	AllianceGateEastDestroyed		= "The east gate of the alliance keep is destroyed!",
	AllianceGateEastDestroyedTC		= "The east gate of the Alliance keep has been destroyed!",
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
	WarnSiegeEngineSoon	= "Show warning when Siege Engine is almost ready"
})

L:SetMiscLocalization({
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
