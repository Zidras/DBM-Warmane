local L

-----------
--  Alar --
-----------
L = DBM:GetModLocalization("Alar")

L:SetGeneralLocalization{
	name = "Al'ar"
}

L:SetTimerLocalization{
	NextPlatform	= "Max Platform length"
}

L:SetOptionLocalization{
	NextPlatform	= "Show timer for when how long Al'ar may stay at platform (May leave sooner but almost never any later)"
}

------------------
--  Void Reaver --
------------------
L = DBM:GetModLocalization("VoidReaver")

L:SetGeneralLocalization{
	name = "Void Reaver"
}

--------------------------------
--  High Astromancer Solarian --
--------------------------------
L = DBM:GetModLocalization("Solarian")

L:SetGeneralLocalization{
	name = "High Astromancer Solarian"
}

L:SetWarningLocalization{
	WarnSplit		= "Split",
	WarnSplitSoon	= "Split in 5 seconds",
	WarnAgent		= "Agents spawned",
	WarnPriest		= "Priests and Solarian spawned"

}

L:SetTimerLocalization{
	TimerSplit		= "Next Split",
	TimerAgent		= "Agents incoming",
	TimerPriest		= "Priests & Solarian incoming"
}

L:SetOptionLocalization{
	WarnSplit		= "Show warning for Split",
	WarnSplitSoon	= "Show pre-warning for Split",
	WarnAgent		= "Show warning for Agents spawn",
	WarnPriest		= "Show warning for Priests and Solarian spawn",
	TimerSplit		= "Show timer for Split",
	TimerAgent		= "Show timer for Agents spawn",
	TimerPriest		= "Show timer for Priests and Solarian spawn",
	WrathIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(42783)
}

L:SetMiscLocalization{
	YellSplit1		= "I will crush your delusions of grandeur!",
	YellSplit2		= "You are hopelessly outmatched!",
	YellPhase2		= "I become"
}

---------------------------
--  Kael'thas Sunstrider --
---------------------------
L = DBM:GetModLocalization("KaelThas")

L:SetGeneralLocalization{
	name = "Kael'thas Sunstrider"
}

L:SetWarningLocalization{
	WarnGaze		= "Gaze on >%s<",
	WarnMobDead		= "%s down",
	WarnEgg			= "Phoenix Egg spawned",
	SpecWarnGaze	= "Gaze on YOU - Run away!",
	SpecWarnEgg		= "Phoenix Egg spawned - Change Target!"
}

L:SetTimerLocalization{
	TimerPhase		= "Next Phase",
	TimerPhase1mob	= "%s",
	TimerNextGaze	= "New Gaze target",
	TimerRebirth	= "Phoenix Rebirth"
}

L:SetOptionLocalization{
	WarnGaze		= "Show warning for Thaladred's Gaze target",
	WarnMobDead		= "Show warning for Phase 2 mob down",
	WarnEgg			= "Show warning when Phoenix Egg spawn",
	SpecWarnGaze	= "Show special warning when Gaze on you",
	SpecWarnEgg		= "Show special warning when Phoenix Egg spawn",
	TimerPhase		= "Show time for next phase",
	TimerPhase1mob	= "Show time for Phase 1 mob active",
	TimerNextGaze	= "Show timer for Thaladred's Gaze target changes",
	TimerRebirth	= "Show timer for Phoenix Egg rebirth remaining",
	GazeIcon		= "Set icon on Thaladred's Gaze target",
	MCIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(36797),
	RangeFrame		= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(10, 37018)
}

L:SetMiscLocalization{
	YellPull1	= "Energy. Power. My people are addicted to it... a dependence made manifest after the Sunwell was destroyed. Welcome... to the future. A pity you are too late to stop it. No one can stop me now! Selama ashal'anore!",
	YellPull2	= "Energy. Power. My people are addicted to it... a dependence made manifest after the Sunwell was destroyed. Welcome to the future. A pity you are too late to stop it. No one can stop me now! Selama ashal'anore!",--Apparently a variation exists and either can be used?
	YellPhase2	= "As you see, I have many weapons in my arsenal....",
	YellPhase3	= "Perhaps I underestimated you. It would be unfair to make you fight all four advisors at once, but... fair treatment was never shown to my people. I'm just returning the favor.",
	YellPhase4	= "Alas, sometimes one must take matters into one's own hands. Balamore shanal!",
	YellPhase5	= "I have not come this far to be stopped! The future I have planned will not be jeopardized! Now you will taste true power!!",
	YellSang	= "You have persevered against some of my best advisors... but none can withstand the might of the Blood Hammer. Behold, Lord Sanguinar!",
	YellCaper	= "Capernian will see to it that your stay here is a short one.",
	YellTelo	= "Well done, you have proven worthy to test your skills against my master engineer, Telonicus.",
	EmoteGaze	= "sets eyes on ([^%s]+)!",
	Thaladred	= "Thaladred the Darkener",
	Sanguinar	= "Lord Sanguinar",
	Capernian	= "Grand Astromancer Capernian",
	Telonicus	= "Master Engineer Telonicus",
	Bow			= "Netherstrand Longbow",
	Axe			= "Devastation",
	Mace		= "Cosmic Infuser",
	Dagger		= "Infinity Blades",
	Sword		= "Warp Slicer",
	Shield		= "Phaseshift Bulwark",
	Staff		= "Staff of Disintegration",
	Egg			= "Phoenix Egg"
}
