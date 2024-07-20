local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization({
	name = "The Prophet Skeram"
})

L:SetMiscLocalization({
	YellKillSkeram = "You only delay the inevitable!"
})

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization({
	name = "Bug Trio"
})

L:SetMiscLocalization({
	Yauj = "Princess Yauj",
	Vem = "Vem",
	Kri = "Lord Kri"
})

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization({
	name = "Battleguard Sartura"
})

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization({
	name = "Fankriss the Unyielding"
})

--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization({
	name = "Viscidus"
})

L:SetWarningLocalization({
	WarnFreeze	= "Freeze: %d/3",
	WarnShatter	= "Shatter: %d/3"
})

L:SetOptionLocalization({
	WarnFreeze	= "Announce Freeze status",
	WarnShatter	= "Announce Shatter status"
})

L:SetMiscLocalization({
	Slow	= "begins to slow",
	Freezing= "is freezing up",
	Frozen	= "is frozen solid",
	Phase4	= "begins to crack",
	Phase5	= "looks ready to shatter",
	Phase6	= "Explodes.",

	HitsRemain	= "Hits Remaining",
	Frost		= "Frost",
	Physical	= "Physical"
})

-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization({
	name = "Princess Huhuran"
})

---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization({
	name = "Twin Emperors"
})

L:SetMiscLocalization({
	Veklor = "Emperor Vek'lor",
	Veknil = "Emperor Vek'nilash"
})

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization({
	name = "C'Thun"
})

L:SetWarningLocalization({
	WarnEyeTentacle			= "Eye Tentacle",
	WarnClawTentacle2		= "Claw Tentacle",
	WarnGiantEyeTentacle	= "Giant Eye Tentacle",
	WarnGiantClawTentacle	= "Giant Claw Tentacle",
	SpecWarnWeakened		= "C'Thun Weaken!"
})

L:SetTimerLocalization({
	TimerEyeTentacle		= "Eye Tentacle",
	TimerClawTentacle		= "Claw Tentacle",
	TimerGiantEyeTentacle	= "Giant Eye Tentacle",
	TimerGiantClawTentacle	= "Giant Claw Tentacle",
	TimerWeakened			= "Weaken ends"
})

L:SetOptionLocalization({
	WarnEyeTentacle			= "Show warning for Eye Tentacle",
	WarnClawTentacle2		= "Show warning for Claw Tentacle",
	WarnGiantEyeTentacle	= "Show warning for Giant Eye Tentacle",
	WarnGiantClawTentacle	= "Show warning for Giant Claw Tentacle",
	SpecWarnWeakened		= "Show special warning when boss weaken",
	TimerEyeTentacle		= "Show timer for next Eye Tentacle",
	TimerClawTentacle		= "Show timer for next Claw Tentacle",
	TimerGiantEyeTentacle	= "Show timer for next Giant Eye Tentacle",
	TimerGiantClawTentacle	= "Show timer for next Giant Claw Tentacle",
	TimerWeakened			= "Show timer for boss weaken duration",
	RangeFrame				= "Show range frame (10)"
})

L:SetMiscLocalization({
	Stomach		= "Stomach",
	Eye			= "Eye of C'Thun",
	FleshTent	= "Flesh Tentacle",--Localized so it shows on frame in users language, not senders
	Weakened	= "weaken",
	NotValid	= "AQ40 partially cleared. %s optional bosses remain."
})

----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization({
	name = "Ouro"
})

L:SetWarningLocalization({
	WarnSubmerge		= "Submerge",
	WarnEmerge			= "Emerge"
})

L:SetTimerLocalization({
	TimerSubmerge		= "Forced Submerge",
	TimerEmerge			= "Emerge"
})

L:SetOptionLocalization({
	WarnSubmerge		= "Show warning for submerge",
	TimerSubmerge		= "Show timer for when submerge will be forced. Note: He can still submerge at any time what so ever if his target leaves melee range.",
	WarnEmerge			= "Show warning for emerge",
	TimerEmerge			= "Show timer for emerge"
})

----------------
-- AQ40 Trash --
----------------
L = DBM:GetModLocalization("AQ40Trash")

L:SetGeneralLocalization({
	name = "AQ40 Trash"
})
