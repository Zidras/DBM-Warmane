local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")

L:SetGeneralLocalization({
	name = "Kalecgos"
})

L:SetWarningLocalization({
	WarnPortal			= "Portal #%d : >%s< (Group %d)",
	SpecWarnWildMagic	= "Wild Magic - %s!"
})

L:SetOptionLocalization({
	WarnPortal			= "Show warning for $spell:46021 target",
	SpecWarnWildMagic	= "Show special warning for Wild Magic",
	ShowRespawn			= "Show boss respawn timer after a wipe",
	ShowFrame			= "Show Spectral Realm frame" ,
	FrameClassColor		= "Use class colors in Spectral Realm frame",
	FrameUpwards		= "Expand Spectral Realm frame upwards",
	FrameLocked			= "Set Spectral Realm frame not movable"
})

L:SetMiscLocalization({
	Demon				= "Sathrovarr the Corruptor",
	Heal				= "Healing + 100%",
	Haste				= "Spell Haste + 100%",
	Hit					= "Melee Hit - 50%",
	Crit				= "Crit Damage + 100%",
	Aggro				= "AGGRO + 100%",
	Mana				= "Cost Reduce 50%",
	FrameTitle			= "Spectral Realm",
	FrameLock			= "Frame Lock",
	FrameClassColor		= "Use Class Colors",
	FrameOrientation	= "Expand upwards",
	FrameHide			= "Hide Frame",
	FrameClose			= "Close",
	FrameGUIMoveMe		= "Move me"
})

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization({
	name = "Brutallus"
})

L:SetOptionLocalization({
	RangeFrameActivation= "Range frame activation",
	AlwaysOn			= "On encounter start. Ignores filter",
	OnDebuff			= "On debuff. Applies debuff filter"
})

L:SetMiscLocalization({
	Pull			= "Ah, more lambs to the slaughter!"
})

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization({
	name = "Felmyst"
})

L:SetWarningLocalization({
	WarnPhase		= "%s Phase"
})

L:SetTimerLocalization({
	TimerPhase		= "Next %s Phase"
})

L:SetOptionLocalization({
	WarnPhase		= "Show warning for next phase",
	TimerPhase		= "Show time for next phase"
})

L:SetMiscLocalization({
	Air				= "Air",
	Ground			= "Ground",
	AirPhase		= "I am stronger than ever before!",
	Breath			= "%s takes a deep breath."
})

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name = "Eredar Twins"
})

L:SetMiscLocalization({
	Nova			= "directs Shadow Nova at (.+)%.",
	Conflag			= "directs Conflagration at (.+)%.",
	Sacrolash		= "Lady Sacrolash",
	Alythess		= "Grand Warlock Alythess"
})

------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization({
	name = "M'uru"
})

L:SetWarningLocalization({
	WarnHuman		= "Humanoids (%d)",
	WarnVoid		= "Void Sentinel (%d)",
	WarnFiend		= "Dark Fiend spawned",
	specWarnVoid	= "Darkness - Scatter skulls!",
	specWarnBH		= "Black Hole - Scatter skulls!",
	specWarnVW		= "Void Sentinels in 5",
	specWarnDarknessSoon = "Darkness soon"
})

L:SetTimerLocalization({
	TimerHuman		= "Next Humanoids (%s)",
	TimerVoid		= "Next Void (%s)",
	TimerPhase		= "Entropius"
})

L:SetOptionLocalization({
	WarnHuman		= "Show warning for Humanoids",
	WarnVoid		= "Show warning for Void Sentinels",
	WarnFiend		= "Show warning for Fiends in phase 2",
	specWarnVoid	= "Show special warning for Gloom (scatter)",
	specWarnBH		= "Show special warning for black hole (scatter)",
	specWarnVW		= "Show special warning for Void Sentinel",
	specWarnDarknessSoon = "Show special warning before Darkness",
	TimerHuman		= "Show timer for Humanoids",
	TimerVoid		= "Show timer for Void Sentinels",
	TimerPhase		= "Show timer for Phase 2 transition"
})

L:SetMiscLocalization({
	Entropius		= "Entropius"
})

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization({
	name = "Kil'jaeden"
})

L:SetWarningLocalization({
	WarnDarkOrb		= "Dark Orbs Spawned",
	WarnBlueOrb		= "Dragon Orb activated",
	SpecWarnDarkOrb	= "Dark Orbs Spawned!",
	SpecWarnBlueOrb	= "Dragon Orbs Activated!"
})

L:SetTimerLocalization({
	TimerBlueOrb	= "Dragon Orbs activate"
})

L:SetOptionLocalization({
	WarnDarkOrb		= "Show warning for Dark Orbs",
	WarnBlueOrb		= "Show warning for Dragon Orbs",
	SpecWarnDarkOrb	= "Show special warning for Dark Orbs",
	SpecWarnBlueOrb	= "Show special warning for Dragon Orbs",
	TimerBlueOrb	= "Show timer form Dragon Orbs activate"
})

L:SetMiscLocalization({
	YellPull		= "The expendable have perished. So be it! Now I shall succeed where Sargeras could not! I will bleed this wretched world and secure my place as the true master of the Burning Legion! The end has come! Let the unravelling of this world commence!",
	OrbYell1		= "I will channel my powers into the orbs! Be ready!",
	OrbYell2		= "I have empowered another orb! Use it quickly!",
	OrbYell3		= "Another orb is ready! Make haste!",
	OrbYell4		= "I have channeled all I can! The power is in your hands!"
})
