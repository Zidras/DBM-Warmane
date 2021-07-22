if GetLocale() ~= "deDE" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Trash der unteren Spitze"
}

L:SetWarningLocalization{
	SpecWarnTrap		= "Falle aktiviert! - Todesgeweihter Wächter freigesetzt" --creatureid 37007
}

L:SetOptionLocalization{
	SpecWarnTrap			= "Zeige Spezialwarnung für Fallenaktivierung",
	SetIconOnDarkReckoning	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
}

L:SetMiscLocalization{
	WarderTrap1		= "Wer... ist da?",
	WarderTrap2		= "Ich erwache...",
	WarderTrap3		= "Das Sanktum des Meisters wurde entweiht!"
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "Trash der Seuchenwerke"
}

L:SetWarningLocalization{
	WarnMortalWound	= "%s auf >%s< (%s)",		-- Mortal Wound on >args.destName< (args.amount)
	SpecWarnTrap	= "Falle aktiviert! - Rachsüchtige Fleischernter kommen" --creatureid 37038
}

L:SetOptionLocalization{
	SpecWarnTrap	= "Zeige Spezialwarnung fur Fallenaktivierung",
	WarnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
}

L:SetMiscLocalization{
	FleshreaperTrap1		= "Schnell, überfallen wir sie von hinten!",
	FleshreaperTrap2		= "Ihr könnt uns nicht entkommen.",
	FleshreaperTrap3		= "Die Lebenden? Hier?!"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name = "Trash der Blutroten Halle"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

---------------------------
--  Trash - Frostwing Hall  --
---------------------------
L = DBM:GetModLocalization("FrostwingHallTrash")

L:SetGeneralLocalization{
	name = "Trash der Frostschwingenhallen"
}

L:SetWarningLocalization{
	SpecWarnGosaEvent	= "Sindragosa-Spießrutenlaut gestartet!"
}

L:SetTimerLocalization{
	GosaTimer			= "Zeit verbleibend"
}

L:SetOptionLocalization{
	SpecWarnGosaEvent	= "Zeige Spezialwarnung für Sindragosa-Spießrutenlauf",
	GosaTimer			= "Zeige Timer für die Dauer des Sindragosa-Spießrutenlaufs"
}

L:SetMiscLocalization{
	SindragosaEvent		= "Ihr dürft Euch der Frostkönigin nicht nähern! Schnell, haltet sie auf!"
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Mark'Gar"
}

L:SetTimerLocalization{
	TimerBoneSpikeUp	= "Spikes up in...", --Needs Translating
	TimerWhirlwindStart	= "Whirlwind starts in..." --Needs Translating
}

L:SetOptionLocalization{
	SetIconOnImpale		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Lady Todeswisper"
}

L:SetTimerLocalization{
	TimerAdds	= "Neue Adds"
}

L:SetWarningLocalization{
	WarnReanimating				= "Add-Wiederbelebung",	-- Reanimating an adherent or fanatic
	WarnAddsSoon				= "Neue Adds bald",
	SpecWarnVengefulShade		= "Rachsüchtiger Schatten greift dich an - Lauf",--creatureid 38222
	WeaponsStatus				= "Auto Unequipping enabled" --Needs Translating
}

L:SetOptionLocalization{
	WarnAddsSoon				= "Zeige Vorwarnung für erscheinende Adds",
	WarnReanimating				= "Zeige Warnung, wenn ein Add wiederbelebt wird",	-- Reanimated Adherent/Fanatic spawning
	TimerAdds					= "Zeige Timer für neue Adds",
	SpecWarnVengefulShade		= "Zeige Spezialwarnung, wenn du von Rachsüchtigen Schatten angegriffen wirst",--creatureid 38222
	WeaponsStatus				= "Special warning at combat start if unequip/equip function is enabled", --Needs Translating
	ShieldHealthFrame			= "Zeige Bossleben mit einer Leiste für $spell:70842",
	SetIconOnDominateMind		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901),
	SoundWarnCountingMC			= "Play a 5 second audio countdown for Mind Control", --Needs Translating
	RemoveDruidBuff				= "Remove MotW / GotW 24 seconds into the fight", --Needs Translating
	EqUneqWeapons				= "Unequip/equip weapons if MC is cast on you. For equipping to work, create an equipment set called 'pve'.", --Needs Translating
	EqUneqTimer					= "Remove weapons by timer ALWAYS, not on cast (if ping is high). The option above must be enabled.", --Needs Translating
	BlockWeapons				= "Completely block the unequip/equip functions above" --Needs Translating
}

L:SetMiscLocalization{
	YellReanimatedFanatic	= "Erhebt Euch und frohlocket ob Eurer reinen Form!",
	ShieldPercent			= "Manabarriere", --Translate Spell id 70842
	Fanatic1				= "Fanatischer Kultist",
	Fanatic2				= "Deformierter Fanatiker",
	Fanatic3				= "Wiederbelebter Fanatiker",
	setMissing				= "ATTENTION! DBM automatic weapon unequipping/equipping will not work until you create a equipment set named pve" --Needs Translating
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Luftschiffkampf"
}

L:SetWarningLocalization{
	WarnAddsSoon	= "Neue Adds bald"
}

L:SetOptionLocalization{
	WarnAddsSoon		= "Zeige Vorwarnung für erscheinende Adds",
	TimerAdds			= "Zeige Timer für neue Adds"
}

L:SetTimerLocalization{
	TimerAdds			= "Neue Adds"
}

L:SetMiscLocalization{
	PullAlliance	= "Alle Maschinen auf Volldampf! Unser Schicksal erwartet uns!",
	PullHorde		= "Erhebt Euch, Söhne und Töchter der Horde! Wir ziehen gegen einen verhassten Feind in die Schlacht! LOK'TAR OGAR!",
	AddsAlliance	= "Häscher, Unteroffiziere, Angriff!",
	AddsHorde		= "Soldaten! Zum Angriff!",
	KillAlliance	= "Sagt nicht, ich hätte Euch nicht gewarnt, Ihr Schurken! Vorwärts, Brüder und Schwestern!",
	KillHorde		= "Die Allianz wankt. Vorwärts zum Lichkönig!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Todesbringer Saurfang"
}

L:SetOptionLocalization{
	BoilingBloodIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	RangeFrame			= "Zeige Abstandsfenster (12 m)",
	RunePowerFrame		= "Zeige Boss-Leben und Leiste für $spell:72371"
}

L:SetMiscLocalization{
	RunePower			= "Blutmacht",
	PullAlliance		= "Mit jedem Krieger der Horde, den Ihr getötet habt, mit jedem dieser Allianzhunde, der fiel, wuchsen die Armeen des Lichkönigs. Selbst in diesem Moment erwecken die Val'kyr Eure Gefallenen als Diener der Geißel.",
	PullHorde			= "Kor'kron, Aufbruch! Champions, gebt Acht. Die Geißel ist..."
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Fauldarm"
}

L:SetOptionLocalization{
	RangeFrame			= "Zeige Abstandsfenster (8 m)",
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279),
	AnnounceSporeIcons	= "Verkünde Symbole für Ziele von $spell:69279 im Raidchat\n(benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)",
	AchievementCheck	= "Announce 'Flu Shot Shortage' achievement failure to raid<br/>(requires promoted status)" --Needs Translating
}

L:SetMiscLocalization{
	SporeSet			= "Gassporensymbol {rt%d} auf %s gesetzt",
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s has %d stacks of Inoculated <<" --Needs Translating
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Modermiene"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Kleiner Brühschlammer erscheint",
	SpecWarnLittleOoze			= "Kleiner Brühschlammer greift dich an - Lauf"--creatureid 36897
}

L:SetOptionLocalization{
	WarnOozeSpawn				= "Zeige Warnung für Spawn von Kleinen Brühschlammern",
	SpecWarnLittleOoze			= "Zeige Spezialwarnung, wenn du von Kleinen Brühschlammern angegriffen wirst",--creatureid 36897
	RangeFrame					= "Show range frame (8 yards)", --Needs Translating
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	TankArrow					= "Zeige Pfeil zum Tank des Großen Schlamms (experimentell)",
}

L:SetMiscLocalization{
	YellSlimePipes1	= "Gute Nachricht, Freunde! Die Giftschleim-Rohre sind repariert!",	-- Professor Putricide
	YellSlimePipes2	= "Gute Nachricht, Freunde! Der Schleim fließt wieder!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professor Seuchenmord"
}

L:SetOptionLocalization{
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72856),
	MalleableGooIcon			= "Setze Zeichen auf erstes Ziel von $spell:72295",
	GooArrow					= "Show DBM arrow when $spell:72295 is near you" --Needs Translating
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Der Rat des Blutes"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Ziel wechseln auf: %s",
	WarnTargetSwitchSoon	= "Zielwechsel bald"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Zielwechsel"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Zeige Warnung für den Zielwechsel",-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Zeige Vorwarnung für den Zielwechsel",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Zeige Timer für Zielwechsel-Cooldown",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "Setze Zeichen auf den machterfüllten Prinzen (Totenkopf)",
	RangeFrame				= "Zeige Abstandsfenster (12 m)",
	VortexArrow				= "Show DBM arrow when $spell:72037 is near you" --Needs Translating
}

L:SetMiscLocalization{
	Keleseth			= "Prinz Keleseth",
	Taldaram			= "Prinz Taldaram",
	Valanar				= "Prinz Valanar",
	FirstPull			= "Törichte Sterbliche. Ihr glaubt, wir wären so einfach besiegt? Die San'layn sind die unsterblichen Soldaten des Lichkönigs! Seht nun ihre vereinte Macht!",
	EmpoweredFlames		= "Machtvolle Flammen rasen auf (%S+) zu!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Blutkönigin Lana'thel"
}

L:SetOptionLocalization{
	SetIconOnDarkFallen		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838),
	RangeFrame				= "Zeige Abstandsfenster (8 m)"
}

L:SetMiscLocalization{
	SwarmingShadows			= "Schatten sammeln sich und schwärmen um (%S+)!",
	YellFrenzy				= "Ich habe Durst!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Traumwandler"
}

L:SetWarningLocalization{
	WarnCorrosion	= "%s auf >%s< (%s)",		-- Corrosion on >args.destName< (args.amount)
	WarnPortalOpen	= "Portale offen"
}

L:SetTimerLocalization{
	TimerPortalsOpen			= "Portale offen",
	TimerPortalsClose			= "Portals close", --Needs Translating
	TimerBlazingSkeleton		= "Loderndes Skelett",
	TimerAbom					= "Abomination",
	TimerSuppressorOne			= "1st wave of Suppressors", --Needs Translating
	TimerSuppressorTwo			= "2nd wave of Suppressors", --Needs Translating
	TimerSuppressorThree		= "3rd wave of Suppressors", --Needs Translating
	TimerSuppressorFour			= "4th wave of Suppressors" --Needs Translating
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Setze Zeichen auf Loderndes Skelett (Totenkopf)",
	WarnPortalOpen				= "Zeige Warnung wenn Alptraumportale geöffnet sind",
	TimerPortalsOpen			= "Zeige Timer wenn Alptraumportale geöffnet sind",
	TimerPortalsClose			= "Show timer when Nightmare Portals are closed", --Needs Translating
	TimerBlazingSkeleton		= "Zeige Timer für nächstes Loderndes Skelett",
	TimerAbom					= "Show timer for next Gluttonous Abomination spawn (Experimental)", --Needs Translating
	Suppressors					= "Show special warning for new Suppressors", --Needs Translating
	TimerSuppressorOne			= "1st wave of Suppressors", --Needs Translating
	TimerSuppressorTwo			= "2nd wave of Suppressors", --Needs Translating
	TimerSuppressorThree		= "3rd wave of Suppressors", --Needs Translating
	TimerSuppressorFour			= "4th wave of Suppressors" --Needs Translating
}

L:SetMiscLocalization{
	YellPull		= "Eindringlinge im Inneren Sanktum! Beschleunigt die Vernichtung des grünen Drachen! Bewahrt nur Knochen und Sehnen für die Wiederbelebung auf!",
	YellPortals		= "Ich habe ein Portal in den Traum geöffnet. Darin liegt Eure Erlösung, Helden..."
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Sindragosa"
}

L:SetWarningLocalization{
	WarnAirphase			= "Luftphase",
	WarnGroundphaseSoon		= "Sindragosa landet bald"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "Nächste Luftphase",
	TimerNextGroundphase	= "Nächste Bodenphase",
	AchievementMystic		= "Ablaufzeit für Mystischer Puffer"
}

L:SetOptionLocalization{
	WarnAirphase				= "Kündige Luftphase an",
	WarnGroundphaseSoon			= "Zeige Vorwarnung für Bodenphase",
	TimerNextAirphase			= "Zeige Timer für nächste Luftphase",
	TimerNextGroundphase		= "Zeige Timer für nächste Bodenphase",
	AnnounceFrostBeaconIcons	= "Poste Zeichen für Ziele von $spell:70126 in Raidchat\n(benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)",
 	SetIconOnFrostBeacon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase		= "Entferne alle Zeichen vor der Luftphase",
	AchievementCheck			= "Announce 'All You Can Eat' achievement warnings to raid<br/>(requires promoted status)", --Needs Translating
	RangeFrame					= "Zeige Abstandsfenster (10 m normal, 20 m heroisch)\n(zeigt nur Spieler mit Raidzeichen an)"
}

L:SetMiscLocalization{
	YellAirphase		= "Euer Vormarsch endet hier! Keiner wird überleben!",
	YellPhase2			= "Fühlt die grenzenlose Macht meines Meisters, und verzweifelt!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "Frostleuchtfeuer-Zeichen {rt%d} auf %s gesetzt",
	AchievementWarning	= "Warning: %s has 5 stacks of Mystic Buffet", --Needs Translating
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s has %d stacks of Mystic Buffet <<" --Needs Translating
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "Der Lichkönig"
}

L:SetWarningLocalization{
	ValkyrWarning			= ">%s< has been grabbed!", --Needs Translating
	SpecWarnYouAreValkd		= "You have been grabbed", --Needs Translating
	WarnNecroticPlagueJump	= "Nekrotische Seuche auf >%s< gesprungen",
	SpecWarnValkyrLow		= "Valkyr below 55%" --Needs Translating
}

L:SetTimerLocalization{
	TimerRoleplay				= "Rollenspiel",
	PhaseTransition				= "Phasenübergang",
	TimerNecroticPlagueCleanse	= "Nekrotische Seuche reinigen"
}

L:SetOptionLocalization{
	TimerRoleplay				= "Zeige Timer für Rollenspiel",
	WarnNecroticPlagueJump		= "Verkünde Sprungziele von $spell:73912",
	TimerNecroticPlagueCleanse	= "Zeige Timer um Nekrotische Seuche vor dem ersten Tick zu reinigen",
	PhaseTransition				= "Zeige Timer für Phasenübergänge",
	ValkyrWarning				= "Announce who has been grabbed by Val'kyr Shadowguards", --Needs Translating
	SpecWarnYouAreValkd			= "Show special warning when you have been grabbed by a Val'kyr Shadowguard",--npc36609 --Needs Translating
	DefileIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	NecroticPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912),
	RagingSpiritIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	HarvestSoulIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74327),
	TrapArrow					= "Zeige Pfeil wenn $spell:73539 in deiner Nähe ist",
	AnnounceValkGrabs			= "Announce Val'kyr Shadowguard grab targets to raid chat\n(requires announce to be enabled and promoted status)",  --Needs Translating
	SpecWarnValkyrLow			= "Show special warning when Valkyr is below 55% HP",  --Needs Translating
	AnnouncePlagueStack			= "Announce $spell:73912 stacks to raid (10 stacks, every 5 after 10)\n(requires promoted status)",  --Needs Translating
	ShowFrame					= "Show Val'Kyr Targets frame", --Needs Translating
	FrameClassColor				= "Use Class Colors in Val'Kyr Targets frame", --Needs Translating
	FrameUpwards				= "Expand Val'Kyr target frame upwards", --Needs Translating
	FrameLocked					= "Lock Val'Kyr Targets frame", --Needs Translating
	RemoveImmunes				= "Remove immunity spells before exiting Frostmourne room" --Needs Translating
}

L:SetMiscLocalization{
	LKPull					= "Der vielgerühmte Streiter des Lichts ist endlich hier? Soll ich Frostgram niederlegen und mich Eurer Gnade ausliefern, Fordring?",
	LKRoleplay				= "Ist es wirklich Rechtschaffenheit, die Euch treibt? Ich bin mir nicht sicher…",
	ValkGrabbedIcon			= "Valkyr Shadowguard {rt%d} grabbed %s", -- Needs Translating
	ValkGrabbed				= "Valkyr Shadowguard grabbed %s", -- Needs Translating
	PlagueStackWarning		= "Warning: %s has %d stacks of Necrotic Plague", -- Needs Translating
	AchievementCompleted	= ">> ACHIEVEMENT COMPLETE: %s has %d stacks of Necrotic Plague <<", -- Needs Translating
	FrameTitle				= "Valkyr targets",
	FrameLock				= "Frame Lock",
	FrameClassColor			= "Use Class Colors",
	FrameOrientation		= "Expand upwards",
	FrameHide				= "Hide Frame",
	FrameClose				= "Close"
}
