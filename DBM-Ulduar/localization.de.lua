if GetLocale() ~= "deDE" then return end

local L

-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization({
	name = "Flammenleviathan"
})

L:SetWarningLocalization({
	PursueWarn				= "Verfolgt >%s<",
	warnNextPursueSoon		= "Zielwechsel in 5 Sekunden",
	SpecialPursueWarnYou	= "Du wirst verfolgt - Lauf weg!",
	warnWardofLife			= "Zauberschutz des Lebens erscheint"
})

L:SetOptionLocalization({
	SpecialPursueWarnYou	= "Spezialwarnung, wenn du $spell:62374 wirst",
	PursueWarn				= "Verkünde Ziele von $spell:62374",
	warnNextPursueSoon		= "Zeige Vorwarnung für nächstes $spell:62374",
	warnWardofLife			= "Spezialwarnung, wenn Zauberschutz des Lebens erscheint"
})

L:SetMiscLocalization({
	YellPull	= "Feindeinheiten erkannt. Bedrohungsbewertung aktiv. Hauptziel erfasst. Neubewertung in T minus 30 Sekunden.",
	Emote		= "%%s verfolgt (%S+)%."
})

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization({
	name = "Ignis, Meister des Eisenwerks"
})

L:SetOptionLocalization({
	soundConcAuraMastery	= "Spielt den Sound von $spell:31821, um die Effekte von $spell:63472 zu negieren (nur für den |cFFF48CBAPaladin|r, der der Besitzer von $spell:19746 ist)"
})

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization({
	name = "Klingenschuppe"
})

L:SetWarningLocalization({
	warnTurretsReadySoon		= "Letzes Geschütz bereit in 20 Sekunden",
	warnTurretsReady			= "Letzes Geschütz bereit"
})

L:SetTimerLocalization({
	timerTurret1	= "Geschütz 1",
	timerTurret2	= "Geschütz 2",
	timerTurret3	= "Geschütz 3",
	timerTurret4	= "Geschütz 4",
	timerGrounded	= "Bodenphase"
})

L:SetOptionLocalization({
	warnTurretsReadySoon		= "Zeige Vorwarnung für Fertigstellung des letzten Harpunengeschützes",
	warnTurretsReady			= "Zeige Warnung bei Fertigstellung des letzten Harpunengeschützes",
	timerTurret1				= "Zeige Zeit bis erstes Harpunengeschütz einsatzbereit ist",
	timerTurret2				= "Zeige Zeit bis zweites Harpunengeschütz einsatzbereit ist",
	timerTurret3				= "Zeige Zeit bis drittes Harpunengeschütz einsatzbereit ist (25 Spieler)",
	timerTurret4				= "Zeige Zeit bis viertes Harpunengeschütz einsatzbereit ist (25 Spieler)",
	timerGrounded				= "Dauer der Bodenphase anzeigen"
})

L:SetMiscLocalization({
	YellAir				= "Gebt uns einen Moment, damit wir uns auf den Bau der Geschütze vorbereiten können.",
	YellAir2			= "Feuer einstellen! Lasst uns diese Geschütze reparieren!",
	YellGround			= "Beeilt Euch! Sie wird nicht lange am Boden bleiben!",
	EmotePhase2			= "ist dauerhaft an den Boden gebunden!"
})

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization({
	name = "XT-002 Dekonstruktor"
})

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization({
	name = "Versammlung des Eisens"
})

L:SetOptionLocalization({
	AlwaysWarnOnOverload		= "Warne immer bei $spell:63481 (sonst nur wenn Sturmrufer Brundir im Ziel)"
})

L:SetMiscLocalization({
	Steelbreaker		= "Stahlbrecher",
	RunemasterMolgeim	= "Runenmeister Molgeim",
	StormcallerBrundir	= "Sturmrufer Brundir"
})

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization({
	name = "Algalon der Beobachter"
})

L:SetWarningLocalization({
	warnStarLow				= "Kollabierender Stern stirbt bald"
})

L:SetTimerLocalization({
	NextCollapsingStar		= "Nächste Kollabierende Sterne",
})

L:SetOptionLocalization({
	NextCollapsingStar		= "Zeige Zeit bis nächste Kollabierende Sterne erscheinen",
	warnStarLow				= "Spezialwarnung, wenn ein Kollabierender Stern bald stirbt (bei ~25%)"
})

L:SetMiscLocalization({
--	HealthInfo				= "Heilen für Sterne",
--	FirstPull				= "Seht Eure Welt durch meine Augen: Ein Universum so gewaltig - grenzenlos - unbegreiflich selbst für die Klügsten unter Euch.",
--	YellPull2				= "Euer Handeln ist unlogisch. Alle Möglichkeiten dieser Begegnung wurden berechnet. Das Pantheon wird die Nachricht des Beobachters erhalten, ungeachtet des Ausgangs.",
	YellKill				= "Ich sah Welten umhüllt von den Flammen der Schöpfer, sah ohne einen Hauch von Trauer ihre Bewohner vergehen. Ganze Planetensysteme geboren und vernichtet, während Eure sterblichen Herzen nur einmal schlagen. Doch immer war mein Herz kalt... ohne Mitgefühl. Ich - habe - nichts - gefühlt. Millionen, Milliarden Leben verschwendet. Trugen sie alle dieselbe Beharrlichkeit in sich, wie Ihr? Liebten sie alle das Leben so sehr, wie Ihr es tut?",
	Emote_CollapsingStar	= "%s beginnt damit, kollabierende Sterne zu beschwören!",
	Phase2					= "Erblicket die Instrumente der Schöpfung!",
	CollapsingStar			= "Kollabierender Stern"
})

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization({
	name = "Kologarn"
})

L:SetTimerLocalization({
	timerLeftArm		= "Nachwachsen linker Arm",
	timerRightArm		= "Nachwachsen rechter Arm",
	achievementDisarmed	= "Zeit für Arm-ab-Erfolg"
})

L:SetOptionLocalization({
	timerLeftArm			= "Zeige Zeit bis der linke Arm nachwächst",
	timerRightArm			= "Zeige Zeit bis der rechte Arm nachwächst",
	achievementDisarmed		= "Zeige Timer für Erfolg 'Arm dran, weil Arm ab'"
})

L:SetMiscLocalization({
--	Yell_Trigger_arm_left	= "Das ist nur ein Kratzer!",
--	Yell_Trigger_arm_right	= "Ist nur 'ne Fleischwunde!",
	Health_Body				= "Kologarn",
	Health_Right_Arm		= "Rechter Arm",
	Health_Left_Arm			= "Linker Arm",
	FocusedEyebeam			= "%s fokussiert seinen Blick auf Euch!"
})

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization({
	name = "Auriaya"
})

L:SetWarningLocalization({
	WarnCatDied		= "Wilder Verteidiger tot (%d Leben übrig)",
	WarnCatDiedOne	= "Wilder Verteidiger tot (1 Leben übrig)"
})

-- L:SetTimerLocalization({
-- 	timerDefender	= "Wilder Verteidiger wird aktiviert"
-- })

L:SetOptionLocalization({
	WarnCatDied		= "Zeige Warnung, wenn der Wilde Verteidiger stirbt",
	WarnCatDiedOne	= "Zeige Warnung, wenn der Wilde Verteidiger nur noch 1 Leben übrig hat"
--	timerDefender	= "Zeige Zeit bis zur Aktivierung des Wilden Verteidigers"
})

L:SetMiscLocalization({
	Defender = "Wilder Verteidiger (%d)",
	YellPull = "In manche Dinge mischt man sich besser nicht ein!"
})

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization({
	name = "Hodir"
})

L:SetMiscLocalization({
	Pull		= "Für Euer Eindringen werdet Ihr bezahlen!",
	YellKill	= "Ich... bin von ihm befreit... endlich."
})

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization({
	name = "Thorim"
})

L:SetTimerLocalization({
	TimerHardmode	= "Hard Mode"
})

L:SetOptionLocalization({
	specWarnHardmode	= "Spezialwarnung, wenn der Schwerer Modus aktiviert ist",
	TimerHardmode		= "Zeige Timer für Hard Mode",
	AnnounceFails		= "Verkünde Spieler im Schlachtzugchat, die bei $spell:62466 scheitern (benötigt aktivierte Mitteilungen und Leiter-/Assistentenstatus)"
})

L:SetMiscLocalization({
	YellPhase1			= " Eindringlinge! Ihr Sterblichen, die Ihr es wagt, Euch in mein Vergnügen einzumischen, werdet... Wartet... Ihr...",
	YellPhase2			= "Ihr unverschämtes Geschmeiß! Ihr wagt es, mich in meinem Refugium herauszufordern? Ich werde Euch eigenhändig zerschmettern!",
	YellKill			= "Senkt Eure Waffen! Ich ergebe mich!",
	YellHardModeActive	= "Unmöglich! Lord Thorim, ich werde Euren Feinden einen kalten Tod bescheren!",
	YellHardModeFailed	= "Diese armseligen Sterblichen sind harmlos, unter meiner Würde. Entfernt sie!",
	ChargeOn			= "Blitzladung: %s",
	Charge				= "Fehler bei Blitzladung (dieser Versuch): %s"
})

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization({
	name = "Freya"
})

L:SetWarningLocalization({
	WarnSimulKill	= "Erster Elementar tot - Wiederbelebung in ~12 Sekunden"
})

L:SetTimerLocalization({
	TimerSimulKill	= "Wiederbelebung"
})

L:SetOptionLocalization({
	WarnSimulKill	= "Verkünde Tod des ersten Elementars",
	TimerSimulKill	= "Zeige Zeit bis zur Wiederbelebung der Elementare"
})

L:SetMiscLocalization({
	SpawnYell			= "Helft mir, Kinder!",
	WaterSpirit			= "Uralter Wassergeist",
	Snaplasher			= "Knallpeitscher",
	StormLasher			= "Sturmpeitscher",
	YellKill			= "Seine Macht über mich beginnt zu schwinden. Endlich kann ich wieder klar sehen. Ich danke Euch, Helden.",
	YellAdds1			= "Eonar, Eure Dienerin braucht Hilfe!",
	YellAdds2			= "Der Schwarm der Elemente soll über Euch kommen!",
	EmoteLGift			= "fängt an zu wachsen!", -- Ein |cFF00FFFFGeschenk der Lebensbinderin|r fängt an zu wachsen!
	TrashRespawnTimer	= "Freya-Trash-Respawn",
	YellPullNormal		= "Das Konservatorium muss verteidigt werden!",
	YellPullHard		= "Ihr Ältesten, gewährt mir Eure Macht!"
})

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization({
	name = "Freyas Älteste"
})

L:SetOptionLocalization({
	TrashRespawnTimer	= "Zeige Timer für Trash-Respawn"
})

L:SetMiscLocalization({
	TrashRespawnTimer	= "Freya-Trash-Respawn"
})

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization({
	name = "Mimiron"
})

L:SetWarningLocalization({
	MagneticCore		= ">%s< hat den Magnetischen Kern",
	WarnBombSpawn		= "Bombenbot erschienen"
})

L:SetTimerLocalization({
	TimerHardmode	= "Hard Mode - Selbstzerstörung",
	TimeToPhase2	= "Phase 2",
	TimeToPhase3	= "Phase 3",
	TimeToPhase4	= "Phase 4"
})

L:SetOptionLocalization({
	TimeToPhase2			= "Zeige Zeit bis Phase 2",
	TimeToPhase3			= "Zeige Zeit bis Phase 3",
	TimeToPhase4			= "Zeige Zeit bis Phase 4",
	MagneticCore			= "Verkünde Spieler, die Magnetische Kerne plündern",
	AutoChangeLootToFFA		= "Automatisch in Phase 3 Plündern auf 'Jeder gegen jeden' einstellen",
	WarnBombSpawn			= "Zeige Warnung für Bombenbot",
	TimerHardmode			= "Zeige Timer für Hard Mode"
})

L:SetMiscLocalization({
	MobPhase1		= "Leviathan Mk II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Luftkommandoeinheit",
	MobPhase4		= "V-07-TR-0N", -- don't localize
	YellPull		= "Wir haben nicht viel Zeit, Freunde! Ihr werdet mir dabei helfen, meine neueste und großartigste Kreation zu testen. Bevor Ihr nun Eure Meinung ändert, denkt daran, dass Ihr mir etwas schuldig seid, nach dem Unfug, den Ihr mit dem XT-002 angestellt habt.",
	YellHardPull	= "Selbstzerstörungssequenz eingeleitet.",
	YellPhase2		= "WUNDERBAR! Das sind Ergebnisse nach meinem Geschmack! Integrität der Hülle bei 98,9 Prozent! So gut wie keine Dellen! Und weiter geht's.",
	YellPhase3		= "Danke Euch, Freunde! Eure Anstrengungen haben fantastische Daten geliefert! So, wo habe ich noch gleich... Ah, hier ist…",
	YellPhase4		= "Vorversuchsphase abgeschlossen. Jetzt kommt der eigentliche Test!",
	YellKilled		= "Es scheint, als wäre mir eine klitzekleine Fehlkalkulation unterlaufen. Ich habe zugelassen, dass das Scheusal im Gefängnis meine Primärdirektive überschreibt. Alle Systeme nun funktionstüchtig.",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
})

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization({
	name = "General Vezax"
})

L:SetTimerLocalization({
	hardmodeSpawn = "Saronitanimus erscheint"
})

L:SetOptionLocalization({
	hardmodeSpawn		= "Zeige Zeit bis zum Erscheinen des Saronitanimus (Hard Mode)",
	CrashArrow			= "DBM-Pfeil anzeigen, wenn $spell:62660 in Ihrer Nähe ist"
})

L:SetMiscLocalization({
	EmoteSaroniteVapors	= "Eine Wolke Saronitdämpfe bildet sich in der Nähe!"
})

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization({
	name = "Yogg-Saron"
})

L:SetWarningLocalization({
	WarningGuardianSpawned			= "Wächter %d erschienen",
	WarningCrusherTentacleSpawned	= "Schmettertentakel erschienen",
	WarningSanity					= "%d Geistige Gesundheit übrig",
	SpecWarnSanity					= "%d Geistige Gesundheit übrig",
	SpecWarnGuardianLow				= "Wächter nicht mehr angreifen!",
	SpecWarnMadnessOutNow			= "Wahnsinn hervorrufen - LAUF RAUS!",
	WarnBrainPortalSoon				= "Gehirnportale in 10 Sek",
	SpecWarnBrainPortalSoon			= "Gehirnportale bald"
})

L:SetTimerLocalization({
	NextPortal	= "Gehirnportale"
})

L:SetOptionLocalization({
	WarningGuardianSpawned			= "Zeige Warnung, wenn ein Wächter des Yogg-Saron erscheint",
	WarningCrusherTentacleSpawned	= "Zeige Warnung, wenn ein Schmettertentakel erscheint",
	WarningSanity					= "Zeige Warnung, wenn deine $spell:63050 niedrig ist",
	SpecWarnSanity					= "Spezialwarnung, wenn deine $spell:63050 sehr niedrig ist",
	SpecWarnGuardianLow				= "Zeige Spezialwarnung wenn Wächter (P1) fast tot ist (für DDs)",
	WarnBrainPortalSoon				= "Zeige Vorwarnung für Gehirnportale",
	SpecWarnMadnessOutNow			= "Spezialwarnung kurz bevor $spell:64059 zu Ende gewirkt wird",
	SpecWarnBrainPortalSoon			= "Spezialwarnung für nächste Gehirnportale",
	NextPortal						= "Zeige Zeit bis nächste Gehirnportale",
	ShowSaraHealth					= "Zeige Lebensanzeige für Sara in Phase 1 (muss anvisiert oder im Fokus eines Schlachtzugsmitglieds sein)",
	MaladyArrow						= "Zeige Pfeil wenn $spell:63881 in deiner Nähe ist"
})

L:SetMiscLocalization({
	YellPull			= "Bald ist die Zeit gekommen, dem Untier den Kopf abzuschlagen! Konzentriert Euren Zorn und Euren Hass auf seine Diener!",
	S1TheLucidDream		= "Phase 1: Der strahlende Traum",
	Sara				= "Sara",
	GuardianofYoggSaron	= "Wächter des Yogg-Saron",
	S2DescentIntoMadness= "Phase 2: Abstieg in den Wahnsinn",
	CrusherTentacle		= "Schmettertentakel",
	CorruptorTentacle	= "Verderbertentakel",
	ConstrictorTentacle	= "Würgetentakel",
	DescentIntoMadness	= "Abstieg in den Wahnsinn",
	InfluenceTentacle	= "Einflusstentakel",
	LaughingSkull		= "Lachender Schädel",
	BrainofYoggSaron	= "Yogg-Sarons Gehirn",
	S3TrueFaceofDeath	= "Phase 3: Das wahre Antlitz des Todes",
	YoggSaron			= "Yogg-Saron",
	ImmortalGuardian	= "Unvergängliche Wache"
})
