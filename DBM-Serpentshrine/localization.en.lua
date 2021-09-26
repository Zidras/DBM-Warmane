local L

---------------------------
--  Hydross the Unstable --
---------------------------
L = DBM:GetModLocalization("Hydross")

L:SetGeneralLocalization{
	name = "Hydross the Unstable"
}

L:SetWarningLocalization{
	WarnMark 		= "%s : %s",
	WarnPhase		= "%s Phase",
	SpecWarnMark	= "%s : %s"
}

L:SetTimerLocalization{
	TimerMark	= "Next %s : %s"
}

L:SetOptionLocalization{
	WarnMark		= "Show warning for Marks",
	WarnPhase		= "Show warning for next phase",
	SpecWarnMark	= "Show warning when Marks debuff damage over 100%",
	TimerMark		= "Show timer for next Marks"
}

L:SetMiscLocalization{
	Frost	= "Frost",
	Nature	= "Nature"
}

-----------------------
--  The Lurker Below --
-----------------------
L = DBM:GetModLocalization("LurkerBelow")

L:SetGeneralLocalization{
	name = "The Lurker Below"
}

L:SetWarningLocalization{
	WarnSubmerge		= "Submerged",
	WarnEmerge			= "Emerged"
}

L:SetTimerLocalization{
	TimerSubmerge		= "Submerge CD",
	TimerEmerge			= "Emerge CD"
}

L:SetOptionLocalization{
	WarnSubmerge		= "Show warning when submerge",
	WarnEmerge			= "Show warning when emerge",
	TimerSubmerge		= "Show time for submerge",
	TimerEmerge			= "Show time for emerge"
}

--------------------------
--  Leotheras the Blind --
--------------------------
L = DBM:GetModLocalization("Leotheras")

L:SetGeneralLocalization{
	name = "Leotheras the Blind"
}

L:SetWarningLocalization{
	WarnPhase		= "%s Phase"
}

L:SetTimerLocalization{
	TimerPhase	= "Next %s Phase"
}

L:SetOptionLocalization{
	WarnPhase		= "Show warning for next phase",
	TimerPhase		= "Show time for next phase"
}

L:SetMiscLocalization{
	Human		= "Human",
	Demon		= "Demon",
	YellDemon	= "Be gone, trifling elf%.%s*I am in control now!",
	YellPhase2	= "No... no! What have you done? I am the master! Do you hear me? I am... aaggh! Can't... contain him."
}

-----------------------------
--  Fathom-Lord Karathress --
-----------------------------
L = DBM:GetModLocalization("Fathomlord")

L:SetGeneralLocalization{
	name = "Fathom-Lord Karathress"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	Caribdis	= "Fathom-Guard Caribdis",
	Tidalvess	= "Fathom-Guard Tidalvess",
	Sharkkis	= "Fathom-Guard Sharkkis"
}

--------------------------
--  Morogrim Tidewalker --
--------------------------
L = DBM:GetModLocalization("Tidewalker")

L:SetGeneralLocalization{
	name = "Morogrim Tidewalker"
}

L:SetWarningLocalization{
	SpecWarnMurlocs	= "Murlocs Coming!"
}

L:SetTimerLocalization{
	TimerMurlocs	= "Murlocs"
}

L:SetOptionLocalization{
	SpecWarnMurlocs	= "Show special warning when Murlocs spawning",
	TimerMurlocs	= "Show timer for Murlocs spawning",
	GraveIcon		= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(38049)
}

L:SetMiscLocalization{
}

-----------------
--  Lady Vashj --
-----------------
L = DBM:GetModLocalization("Vashj")

L:SetGeneralLocalization{
	name = "Lady Vashj"
}

L:SetWarningLocalization{
	WarnElemental		= "Tainted Elemental Soon (%s)",
	WarnStrider			= "Strider Soon (%s)",
	WarnNaga			= "Naga Soon (%s)",
	WarnShield			= "Shield %d/4 down",
	WarnLoot			= "Tainted Core on >%s<",
	SpecWarnElemental	= "Tainted Elemental - Switch!"
}

L:SetTimerLocalization{
	TimerElementalActive	= "Elemental Active",
	TimerElemental			= "Elemental CD (%d)",
	TimerStrider			= "Next Strider (%d)",
	TimerNaga				= "Next Naga (%d)"
}

L:SetOptionLocalization{
	WarnElemental		= "Show pre-warning for next Tainted Elemental",
	WarnStrider			= "Show pre-warning for next Strider",
	WarnNaga			= "Show pre-warning for next Naga",
	WarnShield			= "Show warning for Phase 2 shield down",
	WarnLoot			= "Show warning for Tainted Core loot",
	TimerElementalActive	= "Show timer for how long Tainted Elemental is active",
	TimerElemental		= "Show timer for Tainted Elemental cooldown",
	TimerStrider		= "Show timer for next Strider",
	TimerNaga			= "Show timer for next Naga",
	SpecWarnElemental	= "Show special warning when Tainted Elemental coming",
	ChargeIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(38280),
	AutoChangeLootToFFA	= "Switch loot mode to Free for All in Phase 2"
}

L:SetMiscLocalization{
	DBM_VASHJ_YELL_PHASE2	= "The time is now! Leave none standing!",
	DBM_VASHJ_YELL_PHASE3	= "You may want to take cover.",
	LootMsg					= "([^%s]+).*Hitem:(%d+)"
}
