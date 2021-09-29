if GetLocale() ~= "deDE" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Mark'gar"
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
	TimerAdds					= "Zeige Zeit bis neue Adds erscheinen",
	SpecWarnVengefulShade		= "Zeige Spezialwarnung, wenn du von Rachsüchtigen Schatten angegriffen wirst",--creatureid 38222
	WeaponsStatus				= "Special warning at combat start if unequip/equip function is enabled", --Needs Translating
	ShieldHealthFrame			= "Zeige Bossleben mit einer Leiste für $spell:70842",
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
	name = "Luftschlacht um die Eiskronenzitadelle"
}

L:SetWarningLocalization{
	WarnAddsSoon	= "Neue Adds bald"
}

L:SetOptionLocalization{
	WarnAddsSoon		= "Zeige Vorwarnung für erscheinende Adds",
	TimerAdds			= "Zeige Zeit bis neue Adds erscheinen"
}

L:SetTimerLocalization{
	TimerAdds			= "Neue Adds"
}

L:SetMiscLocalization{
	PullAlliance	= "Alle Maschinen auf Volldampf! Unser Schicksal erwartet uns!",
	PullHorde		= "Erhebt Euch, Söhne und Töchter der Horde! Wir ziehen gegen einen verhassten Feind in die Schlacht! LOK'TAR OGAR!",
	AddsAlliance	= "Häscher, Unteroffiziere, Angriff!",
	AddsHorde		= "Soldaten! Zum Angriff!",
	MageAlliance	= "Der Rumpf ist beschädigt! Holt einen Kampfmagier, der die Kanonen ausschaltet!",
	MageHorde		= "Die Außenhaut ist beschädigt! Holt einen Zauberer, der die Kanonen ausschaltet!",
	KillAlliance	= "Sagt nicht, ich hätte Euch nicht gewarnt, Ihr Schurken! Vorwärts, Brüder und Schwestern!",
	KillHorde		= "Die Allianz wankt. Vorwärts zum Lichkönig!",
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Todesbringer Saurfang"
}

L:SetOptionLocalization{
	RangeFrame			= "Zeige Abstandsfenster (12 m)",
	RunePowerFrame		= "Zeige Boss-Leben und Leiste für $spell:72371",
	RemoveDI			= "Entferne $spell:19752, wenn es verwendet wird, um das Wirken von $spell:72293 zu verhindern."
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
	AnnounceSporeIcons	= "Verkünde Zeichen für Ziele von $spell:69279 im Schlachtzugchat (nur als Leiter)",
	AchievementCheck	= "Verkünde Fehlschlag des Erfolgs 'Grippeimpfungs-Engpass' an Schlachtzug (nur als Leiter/Assistent)"
}

L:SetMiscLocalization{
	SporeSet			= "Gassporenzeichen {rt%d} auf %s gesetzt",
	AchievementFailed	= ">> ERFOLG FEHLGESCHLAGEN: %s hat %d Stapel von Geimpft <<"
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Modermiene"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Kleiner Schlamm erscheint",
	SpecWarnLittleOoze			= "Kleiner Schlamm greift dich an - Lauf weg!"--creatureid 36897
}

L:SetOptionLocalization{
	WarnOozeSpawn				= "Zeige Warnung für Erscheinen eines Kleinen Schlamm",
	SpecWarnLittleOoze			= "Spezialwarnung, wenn du von einem Kleinen Schlamm angegriffen wirst",--creatureid 36897
	RangeFrame					= "Zeige Abstandsfenster (8 m)",
	TankArrow					= "Zeige Pfeil zum Tank des Großen Schlamms (experimentell)",
}

L:SetMiscLocalization{
	YellSlimePipes1				= "Gute Nachricht, Freunde! Die Giftschleim-Rohre sind repariert!",	-- Professor Putricide
	YellSlimePipes2				= "Gute Nachricht, Freunde! Der Schleim fließt wieder!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professor Seuchenmord"
}

L:SetOptionLocalization{
	MalleableGooIcon			= "Setze Zeichen auf erstes Ziel von $spell:72295",
	GooArrow					= "Show DBM arrow when $spell:72295 is near you" --Needs Translating
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Rat des Blutes"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Ziel wechseln auf: %s",
	WarnTargetSwitchSoon	= "Zielwechsel bald"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Zielwechsel"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Zeige Warnung für Zielwechsel",-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Zeige Vorwarnung für Zielwechsel",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Zeige Zeit bis Zielwechsel",
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
	WarnPortalOpen	= "Portale offen"
}

L:SetTimerLocalization{
	TimerPortalsOpen			= "Portale offen",
	TimerPortalsClose			= "Portale geschlossen",
	TimerBlazingSkeleton		= "Loderndes Skelett",
	TimerAbom					= "Nächste Monstrosität"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Setze Zeichen auf Loderndes Skelett (Totenkopf)",
	WarnPortalOpen				= "Zeige Warnung, wenn Alptraumportale geöffnet sind",
	TimerPortalsOpen			= "Zeige Zeit bis Alptraumportale geöffnet sind",
	TimerPortalsClose			= "Zeige Zeit bis Alptraumportale geschlossen sind",
	TimerBlazingSkeleton		= "Zeige Zeit bis nächstes Loderndes Skelett erscheint",
	TimerAbom					= "Zeige Zeit bis nächste Gefräßige Monstrosität erscheint (experimentell)"
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
	WarnAirphase				= "Verkünde Luftphase",
	WarnGroundphaseSoon			= "Zeige Vorwarnung für Bodenphase",
	TimerNextAirphase			= "Zeige Zeit bis nächste Luftphase",
	TimerNextGroundphase		= "Zeige Zeit bis nächste Bodenphase",
	AnnounceFrostBeaconIcons	= "Verkünde Zeichen für Ziele von $spell:70126 im SZ-Chat (nur als Leiter)",
	ClearIconsOnAirphase		= "Entferne alle Zeichen vor der Luftphase",
	AssignWarnDirectionsCount	= "Weisen Sie $spell:70126 -Zielen eine Wegbeschreibung zu und zählen Sie auf Phase 2",
	AchievementCheck			= "Verkünde Warnungen für den Erfolg 'Das Buffet ist eröffnet' an Schlachtzug (nur als Leiter/Assistent)",
	RangeFrame					= "Zeige dynamisches Abstandsfenster (10 m/20 m) basierend auf zuletzt genutzten Bossfähigkeiten und Spieler-Debuffs"
}

L:SetMiscLocalization{
	YellAirphase		= "Euer Vormarsch endet hier! Keiner wird überleben!",
	YellPhase2			= "Fühlt die grenzenlose Macht meines Meisters, und verzweifelt!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "Frostleuchtfeuer-Zeichen {rt%d} auf %s gesetzt",
	AchievementWarning	= "Warnung: %s hat 5 Stapel von Mystischer Puffer",
	AchievementFailed	= ">> ERFOLG FEHLGESCHLAGEN: %s hat %d Stapel von Mystischer Puffer <<"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "Der Lichkönig"
}

L:SetWarningLocalization{
	ValkyrWarning			= ">%s< wurde gegriffen!",
	SpecWarnYouAreValkd		= "Du wurdest gegriffen",
	WarnNecroticPlagueJump	= "Nekrotische Seuche auf >%s< gesprungen",
	SpecWarnValkyrLow		= "Schattenwächterin unter 55%%"
}

L:SetTimerLocalization{
	TimerRoleplay				= "Rollenspiel",
	PhaseTransition				= "Phasenübergang",
	TimerNecroticPlagueCleanse	= "Nekrotische Seuche reinigen"
}

L:SetOptionLocalization{
	TimerRoleplay				= "Dauer des Rollenspiels (bei 10%) anzeigen",
	WarnNecroticPlagueJump		= "Verkünde Sprungziele von $spell:73912",
	TimerNecroticPlagueCleanse	= "Zeige Timer zum Reinigen von $spell:73912 vor dem ersten Tick",
	PhaseTransition				= "Dauer der Phasenübergänge anzeigen",
	ValkyrWarning				= "Verkünde Griffziele der Schattenwächterinnen der Val'kyr",
	SpecWarnYouAreValkd			= "Spezialwarnung, wenn du von einer Schattenwächterin der Val'kyr gegriffen wurdest",--npc36609
	TrapArrow					= "Zeige Pfeil wenn $spell:73539 in deiner Nähe ist",
	AnnounceValkGrabs			= "Verkünde Griffziele der Schattenwächterinnen der Val'kyr im SZ-Chat (benötigt aktivierte Mitteilungen und Leiter-/Assistentenstatus)",
	SpecWarnValkyrLow			= "Spezialwarnung, wenn eine Schattenwächterin der Val'kyr unter 55% Lebenspunkte ist",
	AnnouncePlagueStack			= "Verkünde $spell:70337 Stapel an den Schlachtzug (ab 10 Stapel, danach alle 5 Stapel) (nur als Leiter/Assistent)",
	ShowFrame					= "Show Val'Kyr Targets frame", --Needs Translating
	FrameClassColor				= "Use Class Colors in Val'Kyr Targets frame", --Needs Translating
	FrameUpwards				= "Expand Val'Kyr target frame upwards", --Needs Translating
	FrameLocked					= "Lock Val'Kyr Targets frame", --Needs Translating
	RemoveImmunes				= "Remove immunity spells before exiting Frostmourne room" --Needs Translating
}

L:SetMiscLocalization{
	LKPull					= "Der vielgerühmte Streiter des Lichts ist endlich hier? Soll ich Frostgram niederlegen und mich Eurer Gnade ausliefern, Fordring?",
	LKRoleplay				= "Ist es wirklich Rechtschaffenheit, die Euch treibt? Ich bin mir nicht sicher…",
	ValkGrabbedIcon			= "Schattenwächterin der Val'kyr {rt%d} hat %s gegriffen",
	ValkGrabbed				= "Schattenwächterin der Val'kyr hat %s gegriffen",
	PlagueStackWarning		= "Warnung: %s hat %d Stapel von Nekrotischer Seuche",
	AchievementCompleted	= ">> ERFOLG FERTIG: %s hat %d Stapel von Nekrotischer Seuche <<",
	FrameTitle				= "Valkyr targets", --Needs Translating
	FrameLock				= "Frame Lock", --Needs Translating
	FrameClassColor			= "Use Class Colors", --Needs Translating
	FrameOrientation		= "Expand upwards", --Needs Translating
	FrameHide				= "Hide Frame", --Needs Translating
	FrameClose				= "Close" --Needs Translating
}

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ICCTrash")

L:SetGeneralLocalization{
	name = "Trash der Eiskronenzitadelle"
}

L:SetWarningLocalization{
	SpecWarnTrapL		= "Falle aktiviert! - Todesgeweihter Wächter freigesetzt",
	SpecWarnTrapP		= "Falle aktiviert! - Rachsüchtige Fleischernter kommen",
	SpecWarnGosaEvent	= "Sindragosa-Spießrutenlauf gestartet!"
}

L:SetOptionLocalization{
	SpecWarnTrapL		= "Spezialwarnung für Fallenaktivierung (Todesgeweihter Wächter)",
	SpecWarnTrapP		= "Spezialwarnung für Fallenaktivierung (Rachsüchtige Fleischernter)",
	SpecWarnGosaEvent	= "Spezialwarnung für Sindragosa-Spießrutenlauf"
}

L:SetMiscLocalization{
	WarderTrap1			= "Wer... ist da?",
	WarderTrap2			= "Ich erwache...",
	WarderTrap3			= "Das Sanktum des Meisters wurde entweiht!",
	FleshreaperTrap1	= "Schnell, überfallen wir sie von hinten!",
	FleshreaperTrap2	= "Ihr könnt uns nicht entkommen.",
	FleshreaperTrap3	= "Die Lebenden? Hier?!",
	SindragosaEvent		= "Ihr dürft Euch der Frostkönigin nicht nähern! Schnell, haltet sie auf!"
}
