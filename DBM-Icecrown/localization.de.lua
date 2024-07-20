if GetLocale() ~= "deDE" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "Lord Mark'gar"
})

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization({
	name = "Lady Todeswisper"
})

L:SetTimerLocalization({
	TimerAdds	= "Neue Adds"
})

L:SetWarningLocalization({
	WarnReanimating				= "Add-Wiederbelebung",	-- Reanimating an adherent or fanatic
	WarnAddsSoon				= "Neue Adds bald",
	SpecWarnVengefulShade		= "Rachsüchtiger Schatten greift dich an - Lauf",--creatureid 38222
	WeaponsStatus				= "Automatisches Entwaffnen aktiv: %s (%s - %s)"
})

L:SetOptionLocalization({
	WarnAddsSoon				= "Zeige Vorwarnung für erscheinende Adds",
	WarnReanimating				= "Zeige Warnung, wenn ein Add wiederbelebt wird",	-- Reanimated Adherent/Fanatic spawning
	TimerAdds					= "Zeige Zeit bis neue Adds erscheinen",
	SpecWarnVengefulShade		= "Zeige Spezialwarnung, wenn du von Rachsüchtigen Schatten angegriffen wirst",--creatureid 38222
	WeaponsStatus				= "Zeige Spezialwarnung bei Kampfbeginn, wenn automatisches Be-/Entwaffnen aktiviert ist",
	ShieldHealthFrame			= "Zeige Bossleben mit einer Leiste für $spell:70842",
	SoundWarnCountingMC			= "5 Sekunden Cooldown abspielen für Gedankenkontrolle",
--	RemoveDruidBuff				= "Entferne $spell:48469 / $spell:48470 24 Sekunden nach Kampfbeginn",
	RemoveBuffsOnMC				= "Entferne Buffs, wenn $spell:71289 auf dich gewirkt wird. Jede Option ist komulativ.",
	Gift						= "+ Entferne $spell:48469 / $spell:48470. Notwendig, um $spell:33786 nicht zu widerstehen.",
	CCFree						= "+ Entferne $spell:48169 / $spell:48170. Berücksichtige die Widerstände von Zaubern der Schattenschule.",
	ShortOffensiveProcs			= "+ Entferne offensive Procs, die eine geringe Dauer haben. Empfohlen für die Sicherheit des Schlachtzugs, ohne Auswirkungen auf den Gesamtschaden des Raids",
	MostOffensiveBuffs			= "+ Entfernt die meisten offensiven Buffs (hauptsächlich für Zauberwirkende und Wilder-Kampf Druiden. Maximale Schlachtzugsicherheit, Maximale Schadensreduktion, benötigt selbstständiges rebuffen/gestaltenwechsel",
	EqUneqWeapons				= "Be-/Entwaffnen, wenn $spell:71289 auf MICH wirkt. Funktioniert nur, wenn ein Ausrüstungsset mit dem Namen \"pve\" existiert (mit angelegten Waffen).",
	EqUneqTimer					= "Entwaffnen IMMER nach Timer, nicht erst bei Gedankenkontrolle (bei höherer Latenz). Die obere Funktion muss aktiviert sein"
})

L:SetMiscLocalization({
	YellReanimatedFanatic	= "Erhebt Euch und frohlocket ob Eurer reinen Form!",
	ShieldPercent			= "Manabarriere", --Translate Spell id 70842
--	Fanatic1				= "Fanatischer Kultist",
--	Fanatic2				= "Deformierter Fanatiker",
--	Fanatic3				= "Wiederbelebter Fanatiker",
	setMissing				= "ACHTUNG! Das automatische Be-/Entwaffnen funktioniert erst, wenn Sie ein Ausrüstungsset namens *pve* erstellt haben",
	EqUneqLineDescription	= "Automatisches An-/Ablegen"
})

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization({
	name = "Luftschlacht um die Eiskronenzitadelle"
})

L:SetWarningLocalization({
	WarnAddsSoon	= "Neue Adds bald"
})

L:SetOptionLocalization({
	WarnAddsSoon		= "Zeige Vorwarnung für erscheinende Adds",
	TimerAdds			= "Zeige Zeit bis neue Adds erscheinen"
})

L:SetTimerLocalization({
	TimerAdds			= "Neue Adds"
})

L:SetMiscLocalization({
	PullAlliance	= "Alle Maschinen auf Volldampf! Unser Schicksal erwartet uns!",
	PullHorde		= "Erhebt Euch, Söhne und Töchter der Horde! Wir ziehen gegen einen verhassten Feind in die Schlacht! LOK'TAR OGAR!",
	AddsAlliance	= "Häscher, Unteroffiziere, Angriff!",
	AddsHorde		= "Soldaten! Zum Angriff!",
	MageAlliance	= "Der Rumpf ist beschädigt! Holt einen Kampfmagier, der die Kanonen ausschaltet!",
	MageHorde		= "Die Außenhaut ist beschädigt! Holt einen Zauberer, der die Kanonen ausschaltet!",
	KillAlliance	= "Sagt nicht, ich hätte Euch nicht gewarnt, Ihr Schurken! Vorwärts, Brüder und Schwestern!",
	KillHorde		= "Die Allianz wankt. Vorwärts zum Lichkönig!",
})

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization({
	name = "Todesbringer Saurfang"
})

L:SetOptionLocalization({
	RunePowerFrame		= "Zeige Boss-Leben und Leiste für $spell:72371",
--	RemoveDI			= "Entferne $spell:19752, wenn es verwendet wird, um das Wirken von $spell:72293 zu verhindern."
})

L:SetMiscLocalization({
	RunePower			= "Blutmacht",
	PullAlliance		= "Mit jedem Krieger der Horde, den Ihr getötet habt, mit jedem dieser Allianzhunde, der fiel, wuchsen die Armeen des Lichkönigs. Selbst in diesem Moment erwecken die Val'kyr Eure Gefallenen als Diener der Geißel.",
	PullHorde			= "Kor'kron, Aufbruch! Champions, gebt Acht. Die Geißel ist..."
})

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "Fauldarm"
})

L:SetOptionLocalization({
	AnnounceSporeIcons	= "Verkünde Zeichen für Ziele von $spell:69279 im Schlachtzugchat (nur als Leiter)",
	AchievementCheck	= "Verkünde Fehlschlag des Erfolgs 'Grippeimpfungs-Engpass' an Schlachtzug (nur als Leiter/Assistent)"
})

L:SetMiscLocalization({
	SporeSet			= "Gassporenzeichen {rt%d} auf %s gesetzt",
	AchievementFailed	= ">> ERFOLG FEHLGESCHLAGEN: %s hat %d Stapel von Geimpft <<"
})

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization({
	name = "Modermiene"
})

L:SetWarningLocalization({
	WarnOozeSpawn				= "Kleiner Schlamm erscheint",
	SpecWarnLittleOoze			= "Kleiner Schlamm greift dich an - Lauf weg!"--creatureid 36897
})

L:SetOptionLocalization({
	WarnOozeSpawn				= "Zeige Warnung für Erscheinen eines Kleinen Schlamm",
	SpecWarnLittleOoze			= "Spezialwarnung, wenn du von einem Kleinen Schlamm angegriffen wirst",--creatureid 36897
	TankArrow					= "Zeige Pfeil zum Tank des Großen Schlamms (experimentell)",
})

L:SetMiscLocalization({
	YellSlimePipes1				= "Gute Nachricht, Freunde! Die Giftschleim-Rohre sind repariert!",	-- Professor Putricide
	YellSlimePipes2				= "Gute Nachricht, Freunde! Der Schleim fließt wieder!"	-- Professor Putricide
})

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization({
	name = "Professor Seuchenmord"
})

L:SetWarningLocalization({
	WarnReengage			= "%s: Erneuter Angriff"
})

L:SetTimerLocalization({
	TimerReengage			= "Erneuter Angriff"
})

L:SetOptionLocalization({
	WarnReengage			= "Zeige Warnung für erneuten Angriff",
	TimerReengage			= "Zeige Zeit bis erneuten Angriff"
})

L:SetMiscLocalization({
	YellTransform1			= "Hm, ich spüre gar nichts. Nanu?! Wo kommen die denn her?",
	YellTransform2			= "Schmeckt nach... Kirsche! OH! Verzeihung!"
})

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization({
	name = "Rat des Blutes"
})

L:SetWarningLocalization({
	WarnTargetSwitch		= "Ziel wechseln auf: %s",
	WarnTargetSwitchSoon	= "Zielwechsel bald"
})

L:SetTimerLocalization({
	TimerTargetSwitch		= "Zielwechsel"
})

L:SetOptionLocalization({
	WarnTargetSwitch		= "Zeige Warnung für Zielwechsel",-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Zeige Vorwarnung für Zielwechsel",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Zeige Zeit bis Zielwechsel",
	ActivePrinceIcon		= "Setze Zeichen auf den machterfüllten Prinzen (Totenkopf)",
	ShadowPrisonMetronome	= "Einen sich wiederholenden 1-Sekunden-Klickton abspielen, um $spell:72999 zu vermeiden"
})

L:SetMiscLocalization({
	Keleseth			= "Prinz Keleseth",
	Taldaram			= "Prinz Taldaram",
	Valanar				= "Prinz Valanar",
	FirstPull			= "Törichte Sterbliche. Ihr glaubt, wir wären so einfach besiegt? Die San'layn sind die unsterblichen Soldaten des Lichkönigs! Seht nun ihre vereinte Macht!",
	EmpoweredFlames		= "Machtvolle Flammen rasen auf (%S+) zu!"
})

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization({
	name = "Blutkönigin Lana'thel"
})

L:SetMiscLocalization({
	SwarmingShadows			= "Schatten sammeln sich und schwärmen um (%S+)!",
	YellFrenzy				= "Ich habe Durst!"
})

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization({
	name = "Valithria Traumwandler"
})

L:SetWarningLocalization({
	WarnPortalOpen	= "Portale offen"
})

L:SetTimerLocalization({
	TimerPortalsOpen			= "Portale offen",
	TimerPortalsClose			= "Portale geschlossen",
	TimerBlazingSkeleton		= "Loderndes Skelett",
	TimerAbom					= "Nächste Monstrosität (%s)"
})

L:SetOptionLocalization({
	WarnPortalOpen				= "Zeige Warnung, wenn Alptraumportale geöffnet sind",
	TimerPortalsOpen			= "Zeige Zeit bis Alptraumportale geöffnet sind",
	TimerPortalsClose			= "Zeige Zeit bis Alptraumportale geschlossen sind",
	TimerBlazingSkeleton		= "Zeige Zeit bis nächstes Loderndes Skelett erscheint"
})

L:SetMiscLocalization({
	YellPull		= "Eindringlinge im Inneren Sanktum! Beschleunigt die Vernichtung des grünen Drachen! Bewahrt nur Knochen und Sehnen für die Wiederbelebung auf!",
	YellPortals		= "Ich habe ein Portal in den Traum geöffnet. Darin liegt Eure Erlösung, Helden..."
})

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization({
	name = "Sindragosa"
})

L:SetWarningLocalization({
	WarnAirphase			= "Luftphase",
	WarnGroundphaseSoon		= "Sindragosa landet bald"
})

L:SetTimerLocalization({
	TimerNextAirphase		= "Nächste Luftphase",
	TimerNextGroundphase	= "Nächste Bodenphase",
	AchievementMystic		= "Ablaufzeit für Mystischer Puffer"
})

L:SetOptionLocalization({
	WarnAirphase				= "Verkünde Luftphase",
	WarnGroundphaseSoon			= "Zeige Vorwarnung für Bodenphase",
	TimerNextAirphase			= "Zeige Zeit bis nächste Luftphase",
	TimerNextGroundphase		= "Zeige Zeit bis nächste Bodenphase",
	AnnounceFrostBeaconIcons	= "Verkünde Zeichen für Ziele von $spell:70126 im SZ-Chat (nur als Leiter)",
	ClearIconsOnAirphase		= "Entferne alle Zeichen vor der Luftphase",
	AssignWarnDirectionsCount	= "Weisen Sie $spell:70126 -Zielen eine Wegbeschreibung zu und zählen Sie Phase 2 an",
	AchievementCheck			= "Verkünde Warnungen für den Erfolg 'Das Buffet ist eröffnet' an Schlachtzug (nur als Leiter/Assistent)",
	RangeFrame					= "Zeige dynamisches Abstandsfenster (10 m/20 m) basierend auf zuletzt genutzten Bossfähigkeiten und Spieler-Debuffs"
})

L:SetMiscLocalization({
	YellAirphase		= "Euer Vormarsch endet hier! Keiner wird überleben!",
	YellPhase2			= "Fühlt die grenzenlose Macht meines Meisters, und verzweifelt!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "Frostleuchtfeuer-Zeichen {rt%d} auf %s gesetzt",
	AchievementWarning	= "Warnung: %s hat 5 Stapel von Mystischer Puffer",
	AchievementFailed	= ">> ERFOLG FEHLGESCHLAGEN: %s hat %d Stapel von Mystischer Puffer <<"
})

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization({
	name = "Der Lichkönig"
})

L:SetWarningLocalization({
	ValkyrWarning			= "%s >%s< %s wurde gegriffen!",
	SpecWarnYouAreValkd		= "Du wurdest gegriffen",
	WarnNecroticPlagueJump	= "Nekrotische Seuche auf >%s< gesprungen",
	SpecWarnValkyrLow		= "Schattenwächterin unter 55%%"
})

L:SetTimerLocalization({
	TimerRoleplay				= "Rollenspiel",
	PhaseTransition				= "Phasenübergang",
	TimerNecroticPlagueCleanse	= "Nekrotische Seuche reinigen"
})

L:SetOptionLocalization({
	TimerRoleplay				= "Dauer des Rollenspiels (bei 10%) anzeigen",
	WarnNecroticPlagueJump		= "Verkünde Sprungziele von $spell:73912",
	TimerNecroticPlagueCleanse	= "Zeige Timer zum Reinigen von $spell:73912 vor dem ersten Tick",
	PhaseTransition				= "Dauer der Phasenübergänge anzeigen",
	ValkyrWarning				= "Verkünde Griffziele der Schattenwächterinnen der Val'kyr",
	SpecWarnYouAreValkd			= "Spezialwarnung, wenn du von einer Schattenwächterin der Val'kyr gegriffen wurdest",--npc36609
	AnnounceValkGrabs			= "Verkünde Griffziele der Schattenwächterinnen der Val'kyr im SZ-Chat (benötigt aktivierte Mitteilungen und Leiter-/Assistentenstatus)",
	SpecWarnValkyrLow			= "Spezialwarnung, wenn eine Schattenwächterin der Val'kyr unter 55% Lebenspunkte ist",
	AnnouncePlagueStack			= "Verkünde $spell:70337 Stapel an den Schlachtzug (ab 10 Stapel, danach alle 5 Stapel) (nur als Leiter/Assistent)",
	ShowFrame					= "Zeige Val'Kyr Zielframe",
	FrameClassColor				= "Benutze Klassenfarben im Val'Kyr Zielframe",
	FrameUpwards				= "Erweitere Val'Kyr Zielframe nach oben",
	FrameLocked					= "Val'Kyr Targets Zielframe sperren",
	RemoveImmunes				= "Entferne Immunitätszauber vor dem verlassen Frostgrams Kammer"
})

L:SetMiscLocalization({
	LKPull					= "Der vielgerühmte Streiter des Lichts ist endlich hier? Soll ich Frostgram niederlegen und mich Eurer Gnade ausliefern, Fordring?",
	LKRoleplay				= "Ist es wirklich Rechtschaffenheit, die Euch treibt? Ich bin mir nicht sicher…",
	ValkGrabbedIcon			= "Schattenwächterin der Val'kyr {rt%d} hat %s gegriffen",
	ValkGrabbed				= "Schattenwächterin der Val'kyr hat %s gegriffen",
	PlagueStackWarning		= "Warnung: %s hat %d Stapel von Nekrotischer Seuche",
	AchievementCompleted	= ">> ERFOLG FERTIG: %s hat %d Stapel von Nekrotischer Seuche <<",
	FrameTitle				= "Valkyr Ziele",
	FrameLock				= "Frame sperren",
	FrameClassColor			= "Benutze Klassenfarben",
	FrameOrientation		= "nach oben erweitern",
	FrameHide				= "Frame verstecken",
	FrameClose				= "Schließen",
	FrameGUIDesc			= "Val'Kyr-Rahmen",
	FrameGUIMoveMe			= "Val'Kyr-Rahmen verschieben"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ICCTrash")

L:SetGeneralLocalization({
	name = "Trash der Eiskronenzitadelle"
})

L:SetWarningLocalization({
	SpecWarnTrapL		= "Falle aktiviert! - Todesgeweihter Wächter freigesetzt",
	SpecWarnTrapP		= "Falle aktiviert! - Rachsüchtige Fleischernter kommen",
	SpecWarnGosaEvent	= "Sindragosa-Spießrutenlauf gestartet!"
})

L:SetOptionLocalization({
	SpecWarnTrapL		= "Spezialwarnung für Fallenaktivierung (Todesgeweihter Wächter)",
	SpecWarnTrapP		= "Spezialwarnung für Fallenaktivierung (Rachsüchtige Fleischernter)",
	SpecWarnGosaEvent	= "Spezialwarnung für Sindragosa-Spießrutenlauf"
})

L:SetMiscLocalization({
	WarderTrap1			= "Wer... ist da?",
	WarderTrap2			= "Ich erwache...",
	WarderTrap3			= "Das Sanktum des Meisters wurde entweiht!",
	FleshreaperTrap1	= "Schnell, überfallen wir sie von hinten!",
	FleshreaperTrap2	= "Ihr könnt uns nicht entkommen.",
	FleshreaperTrap3	= "Die Lebenden? Hier?!",
	SindragosaEvent		= "Ihr dürft Euch der Frostkönigin nicht nähern! Schnell, haltet sie auf!"
})
