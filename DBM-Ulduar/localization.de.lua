if GetLocale() ~= "deDE" then return end

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Flammenleviathan"
}

L:SetWarningLocalization{
	PursueWarn				= "Verfolgt >%s<",
	warnNextPursueSoon		= "Zielwechsel in 5 Sekunden",
	SpecialPursueWarnYou	= "Du wirst verfolgt - Lauf weg!",
	warnWardofLife			= "Zauberschutz des Lebens erscheint"
}

L:SetOptionLocalization{
	SpecialPursueWarnYou	= "Spezialwarnung, wenn du $spell:62374 wirst",
	PursueWarn				= "Verkünde Ziele von $spell:62374",
	warnNextPursueSoon		= "Zeige Vorwarnung für nächstes $spell:62374",
	warnWardofLife			= "Spezialwarnung, wenn Zauberschutz des Lebens erscheint"
}

L:SetMiscLocalization{
	YellPull	= "Feindeinheiten erkannt. Bedrohungsbewertung aktiv. Hauptziel erfasst. Neubewertung in T minus 30 Sekunden.",
	Emote		= "%%s verfolgt (%S+)%."
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis, Meister des Eisenwerks"
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Klingenschuppe"
}

L:SetWarningLocalization{
	warnTurretsReadySoon		= "Letzes Geschütz bereit in 20 Sekunden",
	warnTurretsReady			= "Letzes Geschütz bereit"
}

L:SetTimerLocalization{
	timerTurret1	= "Geschütz 1",
	timerTurret2	= "Geschütz 2",
	timerTurret3	= "Geschütz 3",
	timerTurret4	= "Geschütz 4",
	timerGrounded	= "Bodenphase"
}

L:SetOptionLocalization{
	warnTurretsReadySoon		= "Zeige Vorwarnung für Fertigstellung des letzten Harpunengeschützes",
	warnTurretsReady			= "Zeige Warnung bei Fertigstellung des letzten Harpunengeschützes",
	timerTurret1				= "Zeige Zeit bis erstes Harpunengeschütz einsatzbereit ist",
	timerTurret2				= "Zeige Zeit bis zweites Harpunengeschütz einsatzbereit ist",
	timerTurret3				= "Zeige Zeit bis drittes Harpunengeschütz einsatzbereit ist (25 Spieler)",
	timerTurret4				= "Zeige Zeit bis viertes Harpunengeschütz einsatzbereit ist (25 Spieler)",
	timerGrounded				= "Dauer der Bodenphase anzeigen"
}

L:SetMiscLocalization{
	YellAir				= "Gebt uns einen Moment, damit wir uns auf den Bau der Geschütze vorbereiten können.",
	YellAir2			= "Feuer einstellen! Lasst uns diese Geschütze reparieren!",
	YellGround			= "Beeilt Euch! Sie wird nicht lange am Boden bleiben!",
	EmotePhase2			= "ist dauerhaft an den Boden gebunden!"
}

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002 Dekonstruktor"
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Versammlung des Eisens"
}

L:SetOptionLocalization{
	AlwaysWarnOnOverload		= "Warne immer bei $spell:63481 (sonst nur wenn Sturmrufer Brundir im Ziel)"
}

L:SetMiscLocalization{
	Steelbreaker		= "Stahlbrecher",
	RunemasterMolgeim	= "Runenmeister Molgeim",
	StormcallerBrundir	= "Sturmrufer Brundir"
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

L:SetTimerLocalization{
	timerLeftArm		= "Nachwachsen linker Arm",
	timerRightArm		= "Nachwachsen rechter Arm",
	achievementDisarmed	= "Zeit für Arm-ab-Erfolg"
}

L:SetOptionLocalization{
	timerLeftArm			= "Zeige Zeit bis der linke Arm nachwächst",
	timerRightArm			= "Zeige Zeit bis der rechte Arm nachwächst",
	achievementDisarmed		= "Zeige Timer für Erfolg 'Arm dran, weil Arm ab'"
}

L:SetMiscLocalization{
--	Yell_Trigger_arm_left	= "Das ist nur ein Kratzer!",
--	Yell_Trigger_arm_right	= "Ist nur 'ne Fleischwunde!",
	Health_Body				= "Kologarn",
	Health_Right_Arm		= "Rechter Arm",
	Health_Left_Arm			= "Linker Arm",
	FocusedEyebeam			= "%s fokussiert seinen Blick auf Euch!"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetWarningLocalization{
	WarnCatDied		= "Wilder Verteidiger tot (%d Leben übrig)",
	WarnCatDiedOne	= "Wilder Verteidiger tot (1 Leben übrig)"
}

L:SetTimerLocalization{
	timerDefender	= "Wilder Verteidiger wird aktiviert"
}

L:SetOptionLocalization{
	WarnCatDied		= "Zeige Warnung, wenn der Wilde Verteidiger stirbt",
	WarnCatDiedOne	= "Zeige Warnung, wenn der Wilde Verteidiger nur noch 1 Leben übrig hat",
	timerDefender	= "Zeige Zeit bis zur Aktivierung des Wilden Verteidigers"
}

L:SetMiscLocalization{
	Defender = "Wilder Verteidiger (%d)",
	YellPull = "In manche Dinge mischt man sich besser nicht ein!"
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

L:SetTimerLocalization{
	TimerHardmode	= "Hard Mode"
}

L:SetOptionLocalization{
	TimerHardmode	= "Zeige Timer für Hard Mode",
	AnnounceFails	= "Verkünde Spieler im Schlachtzugchat, die bei $spell:62466 scheitern (benötigt aktivierte Mitteilungen und Leiter-/Assistentenstatus)"
}

L:SetMiscLocalization{
	YellPhase1	= " Eindringlinge! Ihr Sterblichen, die Ihr es wagt, Euch in mein Vergnügen einzumischen, werdet... Wartet... Ihr...",
	YellPhase2	= "Ihr unverschämtes Geschmeiß! Ihr wagt es, mich in meinem Refugium herauszufordern? Ich werde Euch eigenhändig zerschmettern!",
	YellKill	= "Senkt Eure Waffen! Ich ergebe mich!",
	ChargeOn	= "Blitzladung: %s",
	Charge		= "Fehler bei Blitzladung (dieser Versuch): %s"
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetWarningLocalization{
	WarnSimulKill	= "Erster Elementar tot - Wiederbelebung in ~12 Sekunden"
}

L:SetTimerLocalization{
	TimerSimulKill	= "Wiederbelebung"
}

L:SetOptionLocalization{
	WarnSimulKill	= "Verkünde Tod des ersten Elementars",
	TimerSimulKill	= "Zeige Zeit bis zur Wiederbelebung der Elementare"
}

L:SetMiscLocalization{
	SpawnYell			= "Helft mir, Kinder!",
	WaterSpirit			= "Uralter Wassergeist",
	Snaplasher			= "Knallpeitscher",
	StormLasher			= "Sturmpeitscher",
	YellKill			= "Seine Macht über mich beginnt zu schwinden. Endlich kann ich wieder klar sehen. Ich danke Euch, Helden.",
	YellAdds1			= "Eonar, Eure Dienerin braucht Hilfe!",
	YellAdds2			= "Der Schwarm der Elemente soll über Euch kommen!",
	EmoteLGift			= "fängt an zu wachsen!", -- Ein |cFF00FFFFGeschenk der Lebensbinderin|r fängt an zu wachsen!
	TrashRespawnTimer	= "Freya-Trash-Respawn"
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freyas Älteste"
}

L:SetOptionLocalization{
	TrashRespawnTimer	= "Zeige Timer für Trash-Respawn"
}

L:SetMiscLocalization{
	TrashRespawnTimer	= "Freya-Trash-Respawn"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	MagneticCore		= ">%s< hat den Magnetischen Kern",
	WarnBombSpawn		= "Bombenbot erschienen"
}

L:SetTimerLocalization{
	TimerHardmode	= "Hard Mode - Selbstzerstörung",
	TimeToPhase2	= "Phase 2",
	TimeToPhase3	= "Phase 3",
	TimeToPhase4	= "Phase 4"
}

L:SetOptionLocalization{
	TimeToPhase2			= "Zeige Zeit bis Phase 2",
	TimeToPhase3			= "Zeige Zeit bis Phase 3",
	TimeToPhase4			= "Zeige Zeit bis Phase 4",
	MagneticCore			= "Verkünde Spieler, die Magnetische Kerne plündern",
	AutoChangeLootToFFA		= "Automatisch in Phase 3 Plündern auf 'Jeder gegen jeden' einstellen",
	WarnBombSpawn			= "Zeige Warnung für Bombenbot",
	TimerHardmode			= "Zeige Timer für Hard Mode"
}

L:SetMiscLocalization{
	MobPhase1		= "Leviathan Mk II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Luftkommandoeinheit",
	YellPull		= "Wir haben nicht viel Zeit, Freunde! Ihr werdet mir dabei helfen, meine neueste und großartigste Kreation zu testen. Bevor Ihr nun Eure Meinung ändert, denkt daran, dass Ihr mir etwas schuldig seid, nach dem Unfug, den Ihr mit dem XT-002 angestellt habt.",
	YellHardPull	= "Selbstzerstörungssequenz eingeleitet.",
	YellPhase2		= "WUNDERBAR! Das sind Ergebnisse nach meinem Geschmack! Integrität der Hülle bei 98,9 Prozent! So gut wie keine Dellen! Und weiter geht's.",
	YellPhase3		= "Danke Euch, Freunde! Eure Anstrengungen haben fantastische Daten geliefert! So, wo habe ich noch gleich... Ah, hier ist…",
	YellPhase4		= "Vorversuchsphase abgeschlossen. Jetzt kommt der eigentliche Test!",
	YellKilled		= "Es scheint, als wäre mir eine klitzekleine Fehlkalkulation unterlaufen. Ich habe zugelassen, dass das Scheusal im Gefängnis meine Primärdirektive überschreibt. Alle Systeme nun funktionstüchtig.",
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
