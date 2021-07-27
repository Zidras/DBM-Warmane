if GetLocale() ~= "deDE" then return end

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Flammenleviathan"
}

L:SetTimerLocalization{
}

L:SetMiscLocalization{
	YellPull	= "Feindeinheiten erkannt. Bedrohungsbewertung aktiv. Hauptziel erfasst. Neubewertung in T minus 30 Sekunden.",
	YellPull2	= "Orbital countermeasures enabled.", --Needs Translating
	Emote		= "%%s verfolgt (%S+)%."
}

L:SetWarningLocalization{
	PursueWarn				= "Verfolgt >%s<!",
	warnNextPursueSoon		= "Zielwechsel in 5 Sek",
	SpecialPursueWarnYou	= "Du wirst verfolgt - lauf weg",
	warnWardofLife			= "Zauberschutz des Lebens erscheint"
}

L:SetOptionLocalization{
	SpecialPursueWarnYou	= "Zeige Spezialwarnung bei Verfolgung",
	PursueWarn				= "Verkünde Verfolgung eines Spielers",
	warnNextPursueSoon		= "Zeige Vorwarnung vor nächstem Verfolgen",
	warnWardofLife			= "Zeige Spezialwarnung für Erscheinen von Zauberschutz des Lebens"
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis, Meister des Eisenwerks"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SlagPotIcon			= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(63477)
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Klingenschuppe"
}

L:SetWarningLocalization{
	warnTurretsReadySoon		= "letzer Turm bereit in 20 Sek",
	warnTurretsReady			= "letzer Turm bereit",
	SpecWarnDevouringFlameCast	= "Verschlingende Flamme auf dir",
	WarnDevouringFlameCast		= "Verschlingende Flamme auf >%s<"
}

L:SetTimerLocalization{
	timerTurret1	= "Turm 1",
	timerTurret2	= "Turm 2",
	timerTurret3	= "Turm 3",
	timerTurret4	= "Turm 4",
	timerGrounded	= "auf dem Boden"
}

L:SetOptionLocalization{
	PlaySoundOnDevouringFlame	= "Spiele Sound wenn betroffen durch Verschlingende Flamme",
	warnTurretsReadySoon		= "Zeige Vorwarnung für Turmfertigstellung",
	warnTurretsReady			= "Zeige Warnung für fertige Türme",
	SpecWarnDevouringFlameCast	= "Zeige Spezialwarnung wenn Verschlingende Flamme auf dich gezaubert wird",
	timerTurret1				= "Zeige Timer für Turm 1",
	timerTurret2				= "Zeige Timer für Turm 2",
	timerTurret3				= "Zeige Timer für Turm 3 (25 Spieler)",
	timerTurret4				= "Zeige Timer für Turm 4 (25 Spieler)",
	OptionDevouringFlame		= "Verkünde Ziel der Verschlingenden Flamme (nicht verlässlich)",
	timerGrounded			    = "Zeige Timer für Dauer der Bodenphase"
}

L:SetMiscLocalization{
	YellAir				= "Gebt uns einen Moment, damit wir uns auf den Bau der Geschütze vorbereiten können.",
	YellAir2			= "Feuer einstellen! Lasst uns diese Geschütze reparieren!",
	YellGround			= "Beeilt Euch! Sie wird nicht lange am Boden bleiben!",
	EmotePhase2			= "%%s grounded permanently!"
}

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002 Dekonstruktor"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarningTTIn10Sec			= "Tympanic Tantrum in 10 sec." --Needs Translating
}

L:SetOptionLocalization{
	SetIconOnLightBombTarget	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(65121),
	SetIconOnGravityBombTarget	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(64234),
	WarningTympanicTantrumIn10Sec = "Show special pre-warning (10 sec.) for $spell:62776 " --Needs Translating
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Versammlung des Eisens"
}

L:SetWarningLocalization{
	WarningSupercharge			= "Superladung auf Boss"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	PlaySoundLightningTendrils	= "Spiele Sound bei Blitzranken",
	SetIconOnOverwhelmingPower	= "Setze Zeichen auf Ziel von Überwältigende Kraft",
	SetIconOnStaticDisruption	= "Setze Zeichen auf Ziel von Statische Störung",
	AlwaysWarnOnOverload		= "Warne immer bei Überladen (ansonsten nur wenn Boss im Ziel)",
	PlaySoundOnOverload			= "Spiele Sound bei Überladen",
	PlaySoundDeathRune			= "Spiele Sound bei Rune des Todes"
}

L:SetMiscLocalization{
	Steelbreaker				= "Stahlbrecher",
	RunemasterMolgeim			= "Runenmeister Molgeim",
	StormcallerBrundir			= "Sturmrufer Brundir",
	YellPull1					= "Whether the world's greatest gnats or the world's greatest heroes, you're still only mortal!", --Needs Translating
	YellPull2					= "Nothing short of total decimation will suffice.", --Needs Translating
	YellPull3					= "You will not defeat the Assembly of Iron so easily, invaders!", --Needs Translating
	YellRuneOfDeath				= "Decipher this!", --Needs Translating
	YellRunemasterMolgeimDied	= "What have you gained from my defeat? You are no less doomed, mortals!", --Needs Translating
	YellRunemasterMolgeimDied2	= "The legacy of storms shall not be undone.", --Needs Translating
	YellStormcallerBrundirDied	= "The power of the storm lives on...", --Needs Translating
	YellStormcallerBrundirDied2	= "You rush headlong into the maw of madness!", --Needs Translating
	YellSteelbreakerDied		= "My death only serves to hasten your demise.", --Needs Translating
	YellSteelbreakerDied2		= "Impossible!" --Needs Translating
}

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon der Beobachter"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "Neue kollabierende Sterne",
	NextCosmicSmash			= "Nächster möglicher Kosmischer Schlag",
	TimerCombatStart		= "Kampf beginnt"
}

L:SetWarningLocalization{
	WarningPhasePunch		= "Phasenschlag auf >%s< - %d mal",
	WarningCosmicSmash 		= "Kosmischer Schlag - Explosion in 4 Sek",
	WarnPhase2Soon			= "Phase 2 bald",
	warnStarLow				= "Kollabierender Stern stirbt bald"
}

L:SetOptionLocalization{
	WarningPhasePunch		= "Zeige Warnung bei Phasenschlag",
	NextCollapsingStar		= "Zeige Timer für kollabierende Sterne",
	WarningCosmicSmash 		= "Zeige Warnung bei Kosmischem Schlag",
	NextCosmicSmash			= "Zeige Timer für nächsten möglichen Kosmischen Schlag",
	TimerCombatStart		= "Zeige Timer für Kampfbeginn",
	WarnPhase2Soon			= "Zeige Vorwarnung für Phase 2 (bei ~23%)",
	warnStarLow				= "Zeige Spezialwarnung wenn Kollabierender Stern bald stirbt (bei ~25%)"
}

L:SetMiscLocalization{
	YellPull				= "Euer Handeln ist unlogisch. Alle Möglichkeiten dieser Begegnung wurden berechnet. Das Pantheon wird die Nachricht des Beobachters erhalten, ungeachtet des Ausgangs.",
	YellPull2 				= "Your actions are illogical. All possible results for this encounter have been calculated. The Pantheon will receive the Observer's message regardless of outcome.", --Needs Translating
	YellKill				= "I have seen worlds bathed in the Makers' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?", --to be translated
	Emote_CollapsingStar	= "%s beginnt damit, kollabierende Sterne zu beschwören!!",
	Phase2					= "Behold the tools of creation",	--Needs Translating
	CollapsingStar			= "Collapsing Star", --Needs Translating
	PullCheck				= "Zeit, bis Algalon mit dem Uplink beginnt= (%d+) min."
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerLeftArm		= "Nachwachsen linker Arm",
	timerRightArm		= "Nachwachsen rechter Arm",
	achievementDisarmed	= "Zeit für Arm-ab-Erfolg"
}

L:SetOptionLocalization{
	timerLeftArm			= "Zeige Timer für Arm-Nachwachsen (links)",
	timerRightArm			= "Zeige Timer für Arm-Nachwachsen (rechts)",
	achievementDisarmed		= "Zeige Timer für Erfolg 'Arm dran, weil Arm ab'",
	SetIconOnGripTarget		= "Setze Zeichen auf Steinerner-Griff-Ziele",
	SetIconOnEyebeamTarget	= "Setze Zeichen auf Ziele von Fokussierter Augenstrahl (Mond)",
	PlaySoundOnEyebeam		= "Spiele Sound bei Fokussiertem Augenstrahl",
	YellOnBeam				= "Yell on $spell:63346"  --Needs Translating
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left	= "Das ist nur ein Kratzer!",
	Yell_Trigger_arm_right	= "Ist nur 'ne Fleischwunde!",
	YellEncounterStart		= "None shall pass!", --Needs Translating
	YellLeftArmDies			= "Just a scratch!", --Needs Translating
	YellRightArmDies		= "Only a flesh wound!", --Needs Translating
	Health_Body				= "Kologarn",
	Health_Right_Arm		= "Rechter Arm",
	Health_Left_Arm			= "Linker Arm",
	FocusedEyebeam			= "%s fokussiert seinen Blick auf Euch!",
	YellBeam				= "Focused Eyebeam on me!" --Needs Translating
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender = "Wilder Verteidiger (%d)",
	YellPull = "In manche Dinge mischt man sich besser nicht ein!"
}

L:SetTimerLocalization{
	timerDefender	= "Wilder Verteidiger wird aktiviert"
}

L:SetWarningLocalization{
	SpecWarnBlast	= "Schildwachenschlag - Unterbrechen!",
	WarnCatDied		= "Wilder Verteidiger tot (%d Leben übrig)",
	WarnCatDiedOne	= "Wilder Verteidiger tot (1 Leben übrig)"
}

L:SetOptionLocalization{
	SpecWarnBlast	= "Zeige Spezialwarnung bei Schildwachenschlag (zum Unterbrechen)",
	WarnCatDied		= "Zeige Warnung wenn ein Wilder Verteidiger stirbt",
	WarnCatDiedOne	= "Zeige Warnung wenn Wilder Verteidiger 1 Leben übrig hat",
	timerDefender	= "Zeige Timer für Aktivierung des Wilden Verteidigers"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	PlaySoundOnFlashFreeze	= "Spiele Sound bei Blitzeis-Zauber",
	YellOnStormCloud		= "Schreie bei Sturmwolke auf dir",
	SetIconOnStormCloud		= "Setze Zeichen auf Spieler mit Sturmwolke"
}

L:SetMiscLocalization{
	YellKill	= "Ich... bin von ihm befreit... endlich.",
	YellCloud	= "Sturmwolke auf mir!"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	TimerHardmodeThorim	= "Hard Mode"
}

L:SetOptionLocalization{
	TimerHardmode	= "Zeige Timer für Hard Mode",
	RangeFrame		= "Zeige Abstandsfenster (10 m)",
	AnnounceFails	= "Poste Spielerfehler für Blitzladung in Raidchat\n(benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)"
}

L:SetMiscLocalization{
	YellPhase1	= " Eindringlinge! Ihr Sterblichen, die Ihr es wagt, Euch in mein Vergnügen einzumischen, werdet... Wartet... Ihr...",
	YellPhase2	= "Ihr unverschämtes Geschmeiß! Ihr wagt es, mich in meinem Refugium herauszufordern? Ich werde Euch eigenhändig zerschmettern!",
	YellKill	= "Senkt Eure Waffen! Ich ergebe mich!",
	ChargeOn	= "Blitzladung: %s",
	Charge		= "Blitzladung-Fehler (dieser Versuch): %s"
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell			= "Helft mir, Kinder!",
	WaterSpirit			= "Uralter Wassergeist",
	Snaplasher			= "Knallpeitscher",
	StormLasher			= "Sturmpeitscher",
	YellKill			= "Seine Macht über mich beginnt zu schwinden. Endlich kann ich wieder klar sehen. Ich danke Euch, Helden.",
	YellAdds1			= "Eonar, your servant requires aid!", --Needs Translating
	YellAdds2			= "The swarm of the elements shall overtake you!", --Needs Translating
	EmoteLGift			= "begins to grow!", --Needs Translating
	TrashRespawnTimer	= "Freya-Trash-Respawn"
}

L:SetWarningLocalization{
	WarnSimulKill		= "Erster tot - Wiederbelebung in ~12 sec",
	WarningBeamsSoon	= "Beams soon", --Needs Translating
	EonarsGift			= "Target Change - switch to Eonar's Gift" --Needs Translating
}

L:SetTimerLocalization{
	TimerSimulKill	= "Wiederbelebung",
}

L:SetOptionLocalization{
	WarnSimulKill	= "Verkünde Tod des Ersten der Dreiergruppe",
	PlaySoundOnFury	= "Spiele Sound wenn du von Furor der Natur betroffen bist",
	WarnBeamsSoon	= "Show a warning for $spell:62865 is soon", --Needs Translating
	TimerSimulKill	= "Zeige Timer für Gegner-Wiederbelebung"
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freyas Älteste"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Freya-Trash-Respawn"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	PlaySoundOnFistOfStone	= "Spiele Sound bei Fäuste aus Stein",
	TrashRespawnTimer		= "Zeige Timer für Trash-Respawn"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	MagneticCore		= ">%s< hat Magnetischen Kern",
	WarningShockBlast	= "Schockschlag - LAUF WEG",
	WarnBombSpawn		= "neuer Bombenbot",
	WarningFlamesIn5Sec = "Flames in 5 sec." --Needs Translating
}

L:SetTimerLocalization{
	TimerHardmode	= "Hard Mode - Selbstzerstörung",
	TimeToPhase2	= "Phase 2",
	TimeToPhase3	= "Phase 3",
	TimeToPhase4	= "Phase 4"
}

L:SetOptionLocalization{
	TimeToPhase2			= "Zeige Timer für Beginn der 2. Phase",
	TimeToPhase3			= "Zeige Timer für Beginn der 3. Phase",
	TimeToPhase4			= "Zeige Timer für Beginn der 4. Phase",
	MagneticCore			= "Verkünde Looter des Magnetischen Kerns",
	HealthFramePhase4		= "Zeige Lebensanzeige in Phase 4",
	AutoChangeLootToFFA		= "Automatisch in Phase 3 Plündern auf 'Jeder gegen jeden' einstellen",
	WarnBombSpawn			= "Zeige Warnung für Bombenbot",
	TimerHardmode			= "Zeige Timer für Hard Mode",
	PlaySoundOnShockBlast	= "Spiele Sound bei Schockschlag",
	PlaySoundOnDarkGlare	= "Spiele Sound bei Lasersalve",
	ShockBlastWarningInP1	= "Zeige Spezialwarnung für Schockschlag in Phase 1",
	ShockBlastWarningInP4	= "Zeige Spezialwarnung für Schockschlag in Phase 4",
	RangeFrame				= "Zeige Abstandsfenster in Phase 1 (6 m)",
	SetIconOnNapalm			= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(65026),
	SetIconOnPlasmaBlast	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(62997),
	WarnFlamesIn5Sec 		= "Show special warning: Flames in 5 sec.", --Needs Translating
	SoundWarnCountingFlames = "Play a 5 second audio countdown for next flames" --Needs Translating
}

L:SetMiscLocalization{
	MobPhase1		= "Leviathan Mk II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Luftkommandoeinheit",
	YellPull		= "Wir haben nicht viel Zeit, Freunde! Ihr werdet mir dabei helfen, meine neueste und großartigste Kreation zu testen. Bevor Ihr nun Eure Meinung ändert, denkt daran, dass Ihr mir etwas schuldig seid, nach dem Unfug, den Ihr mit dem XT-002 angestellt habt",
	YellHardPull		= "Warum habt Ihr das denn jetzt gemacht? Habt Ihr das Schild nicht gesehen, auf dem steht \"DIESEN KNOPF NICHT DRÜCKEN!\"? Wie sollen wir die Tests abschließen, solange der Selbstzerstörungsmechanismus aktiv ist?",
	YellPhase2		= "WUNDERBAR! Das sind Ergebnisse nach meinem Geschmack! Integrität der Hülle bei 98,9 Prozent! So gut wie keine Dellen! Und weiter geht's.",
	YellPhase3		= "Danke Euch, Freunde! Eure Anstrengungen haben fantastische Daten geliefert! So, wo habe ich noch gleich... Ah, hier ist…",
	YellPhase4		= "Vorversuchsphase abgeschlossen. Jetzt kommt der eigentliche Test!",
	YellKilled		= "It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison. overriding my primary directive. All systems seem to be functional now. Clear.", --Needs Translating
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "General Vezax"
}

L:SetTimerLocalization{
	hardmodeSpawn = "Saronitanimus erscheint"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash		= "Schattengeschoss auf dir",
	SpecialWarningShadowCrashNear	= "Schattengeschoss in deiner Nähe!",
	SpecialWarningLLNear			= "Mal der Gesichtslosen auf >%s< in deiner Nähe!"
}

L:SetOptionLocalization{
	SetIconOnShadowCrash			= "Setze Zeichen auf Ziele von Schattengeschoss (Totenkopf)",
	SetIconOnLifeLeach				= "Setze Zeichen auf Ziele von Mal der Gesichtslosen (Lebensentzug) (Kreuz)",
	SpecialWarningShadowCrash		= "Zeige Spezialwarnung für Schattengeschoss (muss anvisiert oder im Fokus eines Schlachtzugsmitglieds sein)",
	SpecialWarningShadowCrashNear	= "Zeige Spezialwarnung bei Schattengeschoss in deiner Nähe",
	SpecialWarningLLNear			= "Zeige Spezialwarnung für Mal der Gesichtslosen (Lebensentzug) in deiner Nähe",
	YellOnLifeLeech					= "Schreie bei $spell:63276",
	YellOnShadowCrash				= "Schreie bei $spell:62660",
	hardmodeSpawn					= "Zeige Timer für Spawn des Saronitanimus (Hard Mode)",
	CrashArrow						= "Show DBM arrow when $spell:62660 is near you", --Needs Translating
	BypassLatencyCheck				= "Don't use latency based sync check for $spell:62660\n(only use this if you're having problems otherwise)" --Needs Translating
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "A cloud of saronite vapors coalesces nearby!", --Needs Translating
	YellLeech			= "Mal der Gesichtslosen auf mir!",
	YellCrash			= "Schattengeschoss auf mir!"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 			= "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",	--to be translated
	YellPhase2			= "I am the lucid dream.",	--to be translated
	Sara 				= "Sara",
	WarningYellSqueeze	= "Quetschen auf mir! Hilfe!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 			= "neuer Wächter",
	WarningCrusherTentacleSpawned	= "neues Schmettertentakel",
	WarningSanity 					= "%d Geistige Gesundheit übrig",
	SpecWarnSanity 					= "%d Geistige Gesundheit übrig",
	SpecWarnGuardianLow				= "Wächter nicht mehr angreifen!",
	SpecWarnMadnessOutNow			= "Wahnsinn hervorrufen - LAUF RAUS",
	WarnBrainPortalSoon				= "Gehirnportale in 3 Sek",
	SpecWarnFervor					= "Saras Eifer auf dir!",
	SpecWarnFervorCast				= "Saras Eifer wird auf dich gezaubert",
	SpecWarnMaladyNear				= "Geisteskrankheit auf %s in deiner Nähe",
	specWarnBrainPortalSoon			= "Gehirnportale bald"
}

L:SetTimerLocalization{
	NextPortal	= "Gehirnportale"
}

L:SetOptionLocalization{
	WarningGuardianSpawned			= "Zeige Warnung für neue Wächter",
	WarningCrusherTentacleSpawned	= "Zeige Warnung für neue Schmettertentakel",
	WarningSanity					= "Zeige Warnung wenn Geistige Gesundheit niedrig ist",
	SpecWarnSanity					= "Zeige Spezialwarnung wenn Geistige Gesundheit sehr niedrig ist",
	SpecWarnGuardianLow				= "Zeige Spezialwarnung wenn Wächter (P1) fast tot ist (für DDs)",
	WarnBrainPortalSoon				= "Zeige Vorwarnung für Gehirnportale",
	SpecWarnMadnessOutNow			= "Zeige Spezialwarnung kurz vor Ende von Wahnsinn hervorrufen",
	SetIconOnFearTarget				= "Setze Zeichen auf Ziele von Geisteskrankheit",
	SpecWarnFervorCast				= "Zeige Spezialwarnung wenn Saras Eifer auf dich gezaubert wird (muss anvisiert oder im Fokus eines Schlachtzugsmitglieds sein)",
	specWarnBrainPortalSoon			= "Zeige Spezialwarnung für nächste Gehirnportale",
	WarningSqueeze					= "Schreie bei Quetschen",
	NextPortal						= "Zeige Timer für nächste Gehirnportale",
	SetIconOnFervorTarget			= "Setze Zeichen auf Spieler mit Saras Eifer",
	ShowSaraHealth					= "Zeige Lebensanzeige für Sara in Phase 1 (muss anvisiert oder im Fokus eines Schlachtzugsmitglieds sein)",
	SpecWarnMaladyNear				= "Zeige Spezialwarnung für Geisteskrankheit in deiner Nähe",
	SetIconOnBrainLinkTarget		= "Setze Zeichen auf Ziele von Gehirnverbindung",
	MaladyArrow						= "Zeige Pfeil wenn $spell:63881 in deiner Nähe ist"
}
