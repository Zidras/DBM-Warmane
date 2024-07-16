if GetLocale() ~= "deDE" then return end
local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan-Vanilla")

L:SetGeneralLocalization({
	name = "Anub'Rekhan"
})

L:SetOptionLocalization({
	ArachnophobiaTimer	= "Zeige Timer für Erfolg 'Arachnophobie'"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Arachnophobie",
	Pull1				= "Rennt! Das bringt das Blut in Wallung!",
	Pull2				= "Nur einmal kosten..." --needs to be verified (wowhead-captured translation)
})

----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina-Vanilla")

L:SetGeneralLocalization({
	name = "Großwitwe Faerlina"
})

L:SetWarningLocalization({
	WarningEmbraceExpire	= "Umarmung endet in 5 Sek"
})

L:SetOptionLocalization({
	WarningEmbraceExpire	= "Zeige Vorwarnung für das Ende von $spell:28732"
})

L:SetMiscLocalization({
	Pull					= "Kniet nieder, Wurm!" --needs to be verified (wowhead-captured translation)
})

---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna-Vanilla")

L:SetGeneralLocalization({
	name = "Maexxna"
})

L:SetWarningLocalization({
	WarningSpidersSoon	= "Maexxnaspinnlinge in 5 Sek",
	WarningSpidersNow	= "Maexxnaspinnlinge erschienen"
})

L:SetTimerLocalization({
	TimerSpider	= "Nächste Maexxnaspinnlinge"
})

L:SetOptionLocalization({
	WarningSpidersSoon	= "Zeige Vorwarnung für Maexxnaspinnlinge",
	WarningSpidersNow	= "Zeige Warnung für Maexxnaspinnlinge",
	TimerSpider			= "Zeige Zeit bis nächste Maexxnaspinnlinge erscheinen"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Arachnophobie"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth-Vanilla")

L:SetGeneralLocalization({
	name = "Noth der Seuchenfürst"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teleportiert",
	WarningTeleportSoon	= "Teleport in 10 Sek"
})

L:SetTimerLocalization({
	TimerTeleport		= "Teleport",
	TimerTeleportBack	= "Teleport zurück"
})

L:SetOptionLocalization({
	WarningTeleportNow	= "Zeige Warnung für Teleport",
	WarningTeleportSoon	= "Zeige Vorwarnung für Teleport",
	TimerTeleport		= "Zeige Zeit bis sich Noth auf den Balkon teleportiert",
	TimerTeleportBack	= "Zeige Zeit bis sich Noth zurück teleportiert"
})

L:SetMiscLocalization({
	Pull				= "Sterbt, Eindringling!",
	Adds				= "beschwört Skelettkrieger!",
	AddsTwo				= "%s belebt mehr Skelette!"
})

--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan-Vanilla")

L:SetGeneralLocalization({
	name = "Heigan der Unreine"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teleportiert",
	WarningTeleportSoon	= "Teleport in %d Sek"
})

L:SetTimerLocalization({
	TimerTeleport	= "Teleport"
})

L:SetOptionLocalization({
	WarningTeleportNow	= "Zeige Warnung für Teleport",
	WarningTeleportSoon	= "Zeige Vorwarnung für Teleport",
	TimerTeleport		= "Zeige Zeit bis Teleport"
})

L:SetMiscLocalization({
	Pull				= "Ihr gehört mir..."
})

---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb-Vanilla")

L:SetGeneralLocalization({
	name = "Loatheb"
})

L:SetWarningLocalization({
	WarningHealSoon	= "Heilung in 3 Sek möglich",
	WarningHealNow	= "Jetzt heilen"
})

L:SetOptionLocalization({
	WarningHealSoon		= "Zeige Vorwarnung für 3-Sekunden-Heilfenster",
	WarningHealNow		= "Zeige Warnung für 3-Sekunden-Heilfenster",
	SporeDamageAlert	= "Sende Flüsternachricht und verkünde Spieler in Raid die Sporen beschädigen\n(benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)",
	CorruptedSorting	= "Set infoframe sorting behaviour for $spell:55593", -- translation missing
	Alphabetical		= "Sort in alphabetical order", -- translation missing
	Duration			= "Sort by duration" -- translation missing
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk-Vanilla")

L:SetGeneralLocalization({
	name = "Flickwerk"
})

L:SetOptionLocalization({
	WarningHateful	= "Verkünde Hasserfüllte Stöße im Raidchat\n(benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)"
})

L:SetMiscLocalization({
	yell1			= "Flickwerk spielen möchte!",
	yell2			= "Kel’Thuzad macht Flickwerk zu seinem Abgesandten des Kriegs!",
	HatefulStrike	= "Hasserfüllter Stoß --> %s [%s]"
})

-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus-Vanilla")

L:SetGeneralLocalization({
	name = "Grobbulus"
})

-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth-Vanilla")

L:SetGeneralLocalization({
	name = "Gluth"
})

----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius-Vanilla")

L:SetGeneralLocalization({
	name = "Thaddius"
})

L:SetWarningLocalization({
	WarningChargeChanged	= "Polarität geändert zu %s",
	WarningChargeNotChanged	= "Polarität hat sich nicht geändert"
})

L:SetOptionLocalization({
	WarningChargeChanged	= "Spezialwarnung, wenn deine Polarität gewechselt hat",
	WarningChargeNotChanged	= "Spezialwarnung, wenn deine Polarität nicht gewechselt hat",
	ArrowsEnabled			= "Zeige Pfeile (normale \"2-Camps\"-Strategie)",
	ArrowsRightLeft			= "Zeige Links-/Rechtspfeil für die \"4-Camps\"-Strategie<br/>(Linkspfeil bei Polaritätsänderung, Rechtspfeil bei keiner Änderung)",
	ArrowsInverse			= "Umgedrehte \"4-Camps\"-Strategie<br/>(Rechtspfeil bei Polaritätsänderung, Linkspfeil bei keiner Änderung)"
})

L:SetMiscLocalization({
	Yell	= "Stalagg zerquetschen!",
	Emote	= "%s überlädt!",
	Emote2	= "Teslaspule überlädt!",
	Boss1	= "Feugen",
	Boss2	= "Stalagg",
	Charge1 = "negativ",
	Charge2 = "positiv"
})

----------------------------
--  Instructor Razuvious  --
----------------------------
L = DBM:GetModLocalization("Razuvious-Vanilla")

L:SetGeneralLocalization({
	name = "Instrukteur Razuvious"
})

L:SetWarningLocalization({
	WarningShieldWallSoon	= "Knochenbarriere endet in 5 Sekunden"
})

L:SetOptionLocalization({
	WarningShieldWallSoon	= "Zeige Vorwarnung, wenn $spell:29061 endet"
})

L:SetMiscLocalization({
	Yell1 = "Lasst keine Gnade walten!",
	Yell2 = "Die Zeit des Übens ist vorbei! Zeigt mir, was ihr gelernt habt!",
	Yell3 = "Befolgt meine Befehle!",
	Yell4 = "Streckt sie nieder... oder habt ihr ein Problem damit?"
})

----------------------------
--  Gothik the Harvester  --
----------------------------
L = DBM:GetModLocalization("Gothik-Vanilla")

L:SetGeneralLocalization({
	name = "Gothik der Ernter"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "Welle %d: %s in 3 Sek",
	WarningWaveSpawned	= "Welle %d: %s erschienen",
	WarningRiderDown	= "Reiter tot",
	WarningKnightDown	= "Ritter tot",
	WarningPhase2		= "Phase 2"
})

L:SetTimerLocalization({
	TimerWave	= "Welle %d",
	TimerPhase2	= "Phase 2"
})

L:SetOptionLocalization({
	TimerWave			= "Zeige Zeit bis nächste Welle",
	TimerPhase2			= "Zeige Zeit bis Phase 2",
	WarningWaveSoon		= "Warne, wenn bald eine neue Welle kommt",
	WarningWaveSpawned	= "Warne, wenn eine neue Welle kommt",
	WarningRiderDown	= "Zeige Warnung, wenn ein Unerbittlicher Reiter stirbt",
	WarningKnightDown	= "Zeige Warnung, wenn ein Unerbittlicher Todesritter stirbt"
})

L:SetMiscLocalization({
	yell			= "Ihr Narren habt euren eigenen Untergang heraufbeschworen.",
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s und %d %s",
	WarningWave3	= "%d %s, %d %s und %d %s",
	Trainee			= "Lehrlinge",
	Knight			= "Ritter",
	Rider			= "Reiter"
})

---------------------
--  Four Horsemen  --
---------------------
L = DBM:GetModLocalization("Horsemen-Vanilla")

L:SetGeneralLocalization({
	name = "Die vier Reiter"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Mal %d in 3 Sekunden",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetOptionLocalization({
	WarningMarkSoon				= "Zeige Vorwarnung für Mal",
	SpecialWarningMarkOnPlayer	= "Spezialwarnung, wenn sich ein Mal mehr als 4-mal auf dir stapelt"
})

L:SetMiscLocalization({
	Korthazz	= "Than Korth'azz",
	Rivendare	= "Baron Totenschwur",
	Blaumeux	= "Lady Blaumeux",
	Zeliek		= "Sir Zeliek"
})

-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron-Vanilla")

L:SetGeneralLocalization({
	name = "Saphiron"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon	= "Luftphase in 10 Sek",
	WarningAirPhaseNow	= "Luftphase",
	WarningLanded		= "Bodenphase",
	WarningDeepBreath	= "Frostatem",
	SpecWarnSapphLow	= "Saphiron kann nicht fliegen!"
})

L:SetTimerLocalization({
	TimerAir		= "Nächste Luftphase",
	TimerLanding	= "Nächste Bodenphase",
	TimerIceBlast	= "Frostatem"
})

L:SetOptionLocalization({
	WarningAirPhaseSoon	= "Zeige Vorwarnung, wenn Saphiron bald abhebt",
	WarningAirPhaseNow	= "Zeige Warnung, wenn Saphiron abhebt",
	WarningLanded		= "Zeige Warnung, wenn Saphiron landet",
	TimerAir			= "Zeige Zeit bis nächste Luftphase",
	TimerLanding		= "Zeige Zeit bis nächste Bodenphase",
	TimerIceBlast		= "Zeige Zeit bis $spell:28524",
	WarningDeepBreath	= "Spezialwarnung für $spell:28524",
	SpecWarnSapphLow	= "Sonderwarnung für 10 % Ausführungsphase (Luftphase abbrechen)"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s holt tief Luft.",
	AirPhase			= "Saphiron erhebt sich in die Lüfte!",
	LandingPhase		= "Saphiron nimmt seine Angriffe wieder auf!"
})

------------------
--  Kel'Thuzad  --
------------------
L = DBM:GetModLocalization("Kel'Thuzad-Vanilla")

L:SetGeneralLocalization({
	name = "Kel'Thuzad"
})

L:SetWarningLocalization({
	specwarnP2Soon	= "Kel'Thuzad greift in 10 Sekunden an",
	warnAddsSoon	= "Wächter von Eiskrone bald",
	WeaponsStatus	= "Automatisches Entwaffnen aktiv: %s (%s - %s)"
})

L:SetTimerLocalization({
	TimerPhase2	= "Phase 2"
})

L:SetOptionLocalization({
	TimerPhase2			= "Zeige Zeit bis Phase 2",
	specwarnP2Soon		= "Spezialwarnung 10 Sekunden bevor Kel'Thuzad angreift",
	warnAddsSoon		= "Zeige Vorwarnung für Wächter von Eiskrone",
	WeaponsStatus		= "Zeige Spezialwarnung bei Kampfbeginn, wenn automatisches Be-/Entwaffnen aktiviert ist",
	EqUneqWeaponsKT		= "Waffen vor und nach $spell:28410 automatisch aus- und ausrüsten. Benötigt Ausrüstungsset namens \"pve\"",
	EqUneqWeaponsKT2	= "Waffen automatisch ablegen und ausrüsten, wenn $spell:28410 auf DICH gewirkt wird. Benötigt Ausrüstungsset namens \"pve\"",
	RemoveBuffsOnMC		= "Entferne Buffs, wenn $spell:28410 auf dich gewirkt wird. Jede Option ist kumulativ.",
	Gift				= "Entferne $spell:48469 / $spell:48470. Minimaler Ansatz, um $spell:33786 Resistenzen zu verhindern.",
	CCFree				= "+ Entferne $spell:48169 / $spell:48170. Berücksichtige die Resistenzen von Zaubern der Schattenschule.",
	ShortOffensiveProcs	= "+ Entferne offensive Procs, die eine geringe Dauer haben. Empfohlen für die Sicherheit des Schlachtzugs, ohne den Schadensoutput des Schlachtzugs zu beeinträchtigen.",
	MostOffensiveBuffs	= "+ Entfernt die meisten offensiven Buffs (hauptsächlich für Zauberwirker und |cFFFF7C0AWildheit-Druide|r). Maximale Schlachtzugsicherheit bei gleichzeitigem Verlust des Schadensoutputs und der Notwendigkeit, sich selbst zu rebuffen/shapeshiften!"
})

L:SetMiscLocalization({
	Yell = "Lakaien, Diener, Soldaten der eisigen Finsternis! Folgt dem Ruf von Kel'Thuzad!",
	Yell1Phase2 = "Betet um Gnade!", -- 12995
	Yell2Phase2 = "Schreiend werdet ihr diese Welt verlassen!", -- 12996
	Yell3Phase2 = "Euer Ende ist gekommen!", -- 12997
	YellPhase3 = "Meister, ich benötige Beistand.", -- 12998
	YellGuardians = "Wohlan, Krieger der Eisigen Weiten, erhebt euch! Ich befehle euch für euren Meister zu kämpfen, zu töten und zu sterben! Keiner darf überleben!", -- 12994
	setMissing	= "AUFMERKSAMKEIT! Das automatische Ausrüsten/Ausrüsten von DBM-Waffen funktioniert erst, wenn Sie ein Ausrüstungsset namens pve . erstellen",
	EqUneqLineDescription	= "Automatisches An-/Ablegen"
})
