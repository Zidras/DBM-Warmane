local L

----------------
--  Lucifron  --
----------------
L = DBM:GetModLocalization("Lucifron")

L:SetGeneralLocalization({
	name = "Lucifron"
})

----------------
--  Magmadar  --
----------------
L = DBM:GetModLocalization("Magmadar")

L:SetGeneralLocalization({
	name = "Magmadar"
})

----------------
--  Gehennas  --
----------------
L = DBM:GetModLocalization("Gehennas")

L:SetGeneralLocalization({
	name = "Gehennas"
})

------------
--  Garr  --
------------
L = DBM:GetModLocalization("Garr-Classic")

L:SetGeneralLocalization({
	name = "Garr"
})

--------------
--  Geddon  --
--------------
L = DBM:GetModLocalization("Geddon")

L:SetGeneralLocalization({
	name = "Baron Geddon"
})

----------------
--  Shazzrah  --
----------------
L = DBM:GetModLocalization("Shazzrah")

L:SetGeneralLocalization({
	name = "Shazzrah"
})

----------------
--  Sulfuron  --
----------------
L = DBM:GetModLocalization("Sulfuron")

L:SetGeneralLocalization({
	name = "Sulfuron Harbinger"
})

----------------
--  Golemagg  --
----------------
L = DBM:GetModLocalization("Golemagg")

L:SetGeneralLocalization({
	name = "Golemagg the Incinerator"
})

-----------------
--  Majordomo  --
-----------------
L = DBM:GetModLocalization("Majordomo")

L:SetGeneralLocalization({
	name = "Majordomo Executus"
})

L:SetTimerLocalization({
	timerShieldCD		= "Next Shield"
})

L:SetOptionLocalization({
	timerShieldCD		= "Show timer for next Damage/Reflect Shield"
})

----------------
--  Ragnaros  --
----------------
L = DBM:GetModLocalization("Ragnaros-Classic")

L:SetGeneralLocalization({
	name = "Ragnaros"
})

L:SetWarningLocalization({
	WarnSubmerge		= "Submerge",
	WarnEmerge			= "Emerge"
})

L:SetTimerLocalization({
	TimerSubmerge		= "Submerge",
	TimerEmerge			= "Emerge",
	timerCombatStart	= "~" .. DBM_CORE_L.GENERIC_TIMER_COMBAT
})

L:SetOptionLocalization({
	WarnSubmerge		= "Show warning for submerge",
	TimerSubmerge		= "Show timer for submerge",
	WarnEmerge			= "Show warning for emerge",
	TimerEmerge			= "Show timer for emerge",
	timerCombatStart	= DBM_CORE_L.OPTION_TIMER_COMBAT
})

L:SetMiscLocalization({
	Submerge	= "COME FORTH, MY SERVANTS! DEFEND YOUR MASTER!",
	Submerge2	= "YOU CANNOT DEFEAT THE LIVING FLAME! COME YOU MINIONS OF FIRE! COME FORTH, YOU CREATURES OF HATE! YOUR MASTER CALLS!",
	Pull		= "Impudent whelps! You've rushed headlong to your own deaths! See now, the master stirs!\n"
})

-----------------
--  MC: Trash  --
-----------------
L = DBM:GetModLocalization("MCTrash")

L:SetGeneralLocalization({
	name = "MC: Trash"
})
