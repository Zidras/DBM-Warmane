if GetLocale() ~= "deDE" then return end
local L

--Attumen
L = DBM:GetModLocalization("Attumen")

L:SetGeneralLocalization{
	name = "Attumen der Jäger"
}

L:SetMiscLocalization{
}


--Moroes
L = DBM:GetModLocalization("Moroes")

L:SetGeneralLocalization{
	name = "Moroes"
}

L:SetWarningLocalization{
	DBM_MOROES_VANISH_FADED	= "Moroes ist wieder da"
}

L:SetOptionLocalization{
	DBM_MOROES_VANISH_FADED	= "Zeige Warnung für Ende von Verschwinden"
}


-- Maiden of Virtue
L = DBM:GetModLocalization("Maiden")

L:SetGeneralLocalization{
	name = "Tugendhafte Maid"
}

-- Romulo and Julianne
L = DBM:GetModLocalization("RomuloAndJulianne")

L:SetGeneralLocalization{
	name = "Romulo und Julianne"
}

L:SetMiscLocalization{
	Event				= "Heute Abend werden wir Zeuge einer verbotenen Liebe!",
	RJ_Pull				= "Welch' Teufel bist du, dass du so mich folterst?",
	DBM_RJ_PHASE2_YELL	= "Komm, milde, liebevolle Nacht! Komm, gibt mir meinen Romulo zurück!",
	Romulo				= "Romulo",
	Julianne			= "Julianne"
}


-- Big Bad Wolf
L = DBM:GetModLocalization("BigBadWolf")

L:SetGeneralLocalization{
	name = "Der große böse Wolf"
}

L:SetMiscLocalization{
	DBM_BBW_YELL_1			= "Damit ich dich besser fressen kann!"
}


-- Wizard of Oz
L = DBM:GetModLocalization("Oz")

L:SetGeneralLocalization{
	name = "Zauberer von Oz"
}

L:SetWarningLocalization{
	DBM_OZ_WARN_TITO		= "Tito",
	DBM_OZ_WARN_ROAR		= "Brüller",
	DBM_OZ_WARN_STRAWMAN	= "Strohmann",
	DBM_OZ_WARN_TINHEAD		= "Blechkopf",
	DBM_OZ_WARN_CRONE		= "Die böse Hexe"
}

L:SetTimerLocalization{
	DBM_OZ_WARN_TITO		= "Tito",
	DBM_OZ_WARN_ROAR		= "Brüller",
	DBM_OZ_WARN_STRAWMAN	= "Strohmann",
	DBM_OZ_WARN_TINHEAD		= "Blechkopf"
}

L:SetOptionLocalization{
	AnnounceBosses			= "Zeige Warnungen für Erscheinen der Bosse",
	ShowBossTimers			= "Zeige Zeit bis die Bosse erscheinen"
}

L:SetMiscLocalization{
	DBM_OZ_YELL_DOROTHEE	= "Oh Tito, wir müssen einfach einen Weg nach Hause finden! Der alte Zauberer ist unsere einzige Hoffnung! Strohmann, Brüller, Blechkopf, wollt ihr - wartet... Donnerwetter, schaut! Wir haben Besucher!",
	DBM_OZ_YELL_ROAR		= "Ich habe keine Angst vor Euch! Wollt Ihr kämpfen? Hä, wollt Ihr? Kommt schon! Ich schaffe Euch mit beiden Pfoten hinter dem Rücken!",
	DBM_OZ_YELL_STRAWMAN	= " Was soll ich nur mit Euch machen? Mit fällt einfach nichts ein.",
	DBM_OZ_YELL_TINHEAD		= "Ich könnte wirklich ein Herz brauchen. Kann ich Eures haben?",
	DBM_OZ_YELL_CRONE		= "Wehe Euch allen, meine Hübschen!"
}


-- Curator
L = DBM:GetModLocalization("Curator")

L:SetGeneralLocalization{
	name = "Der Kurator"
}

L:SetWarningLocalization{
	warnAdd		= "Astralflimmern erschienen"
}

L:SetOptionLocalization{
	warnAdd		= "Zeige Warnung, wenn Astralflimmern erscheinen"
}

-- Terestian Illhoof
L = DBM:GetModLocalization("TerestianIllhoof")

L:SetGeneralLocalization{
	name = "Terestian Siechhuf"
}

L:SetMiscLocalization{
	Kilrek					= "Kil'rek",
	DChains					= "Dämonenketten"
}


-- Shade of Aran
L = DBM:GetModLocalization("Aran")

L:SetGeneralLocalization{
	name = "Arans Schemen"
}

L:SetWarningLocalization{
	DBM_ARAN_DO_NOT_MOVE	= "Flammenkranz - Nicht bewegen!"
}

L:SetTimerLocalization{
	timerSpecial			= "Spezialfähigkeiten CD"
}

L:SetOptionLocalization{
	timerSpecial			= "Abklingzeit der Spezialfähigkeiten anzeigen",
	DBM_ARAN_DO_NOT_MOVE	= "Spezialwarnung für $spell:30004"
}

--Netherspite
L = DBM:GetModLocalization("Netherspite")

L:SetGeneralLocalization{
	name = "Nethergroll"
}

L:SetWarningLocalization{
	warningPortal			= "Portalphase",
	warningBanish			= "Verbannungsphase"
}

L:SetTimerLocalization{
	timerPortalPhase	= "Portalphase",
	timerBanishPhase	= "Verbannungsphase"
}

L:SetOptionLocalization{
	warningPortal			= "Zeige Warnung für Portalphase",
	warningBanish			= "Zeige Warnung für Verbannungsphase",
	timerPortalPhase		= "Dauer der Portalphase anzeigen",
	timerBanishPhase		= "Dauer der Verbannungsphase anzeigen"
}

L:SetMiscLocalization{
	DBM_NS_EMOTE_PHASE_2	= "Netherenergien versetzen %s in rasende Wut!",
	DBM_NS_EMOTE_PHASE_1	= "%s schreit auf und öffnet Tore zum Nether."
}

--Chess
L = DBM:GetModLocalization("Chess")

L:SetGeneralLocalization{
	name = "Schachspiel"
}

L:SetTimerLocalization{
	timerCheat	= "Schummeln CD"
}

L:SetOptionLocalization{
	timerCheat	= "Abklingzeit von Schummeln anzeigen"
}

L:SetMiscLocalization{
	EchoCheats	= "Medivhs Echo schummelt!"
}

--Prince Malchezaar
L = DBM:GetModLocalization("Prince")

L:SetGeneralLocalization{
	name = "Prinz Malchezaar"
}

L:SetMiscLocalization{
	DBM_PRINCE_YELL_P2		= "Dummköpfe! Zeit ist das Feuer, in dem Ihr brennen werdet!",
	DBM_PRINCE_YELL_P3		= "Wie könnt Ihr hoffen, einer so überwältigenden Macht gewachsen zu sein?",
	DBM_PRINCE_YELL_INF1	= "Alle Realitäten, alle Dimensionen stehen mir offen!",
	DBM_PRINCE_YELL_INF2	= "Ihr steht nicht nur vor Malchezaar allein, sondern vor den Legionen, die ich befehlige!"
}


-- Nightbane
L = DBM:GetModLocalization("NightbaneRaid")

L:SetGeneralLocalization{
	name = "Schrecken der Nacht (Schlachtzug)"
}

L:SetWarningLocalization{
	DBM_NB_AIR_WARN			= "Luftphase"
}

L:SetTimerLocalization{
	timerAirPhase			= "Luftphase"
}

L:SetOptionLocalization{
	DBM_NB_AIR_WARN			= "Zeige Warnung für Luftphase",
	timerAirPhase			= "Dauer der Luftphase anzeigen"
}

L:SetMiscLocalization{
	DBM_NB_EMOTE_PULL		= "Etwas Uraltes erwacht in der Ferne...",
	DBM_NB_YELL_AIR			= "Abscheuliches Gewürm! Ich werde euch aus der Luft vernichten!",
	DBM_NB_YELL_GROUND		= "Genug! Ich werde landen und mich höchst persönlich um Euch kümmern!",
	DBM_NB_YELL_GROUND2		= "Insekten! Lasst mich Euch meine Kraft aus nächster Nähe demonstrieren!"
}


-- Named Beasts
L = DBM:GetModLocalization("Shadikith")

L:SetGeneralLocalization{
	name = "Shadikith der Gleiter"
}

L = DBM:GetModLocalization("Hyakiss")

L:SetGeneralLocalization{
	name = "Hyakiss der Lauerer"
}

L = DBM:GetModLocalization("Rokad")

L:SetGeneralLocalization{
	name = "Rokad der Verheerer"
}
