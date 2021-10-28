if GetLocale() ~= "deDE" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Bestien von Nordend"
}

L:SetWarningLocalization{
	WarningSnobold		= "Schneeboldvasall erschienen auf >%s<"
}

L:SetTimerLocalization{
	TimerNextBoss		= "Nächster Boss",
	TimerEmerge			= "Auftauchen",
	TimerSubmerge		= "Abtauchen"
}

L:SetOptionLocalization{
	WarningSnobold		= "Zeige Warnung, wenn ein Schneeboldvasall erscheint",
	PingCharge			= "Ping die Minimap wenn Eisheuler dich niedertrampeln will",
	ClearIconsOnIceHowl	= "Entferne alle Zeichen vor dem Trampeln",
	TimerNextBoss		= "Zeige Zeit bis zum Erscheinen des nächsten Bosses",
	TimerEmerge			= "Zeige Zeit bis Auftauchen",
	TimerSubmerge		= "Zeige Zeit bis Abtauchen",
	IcehowlArrow		= "Zeige DBM-Pfeil, wenn Eisheuler jemand in deiner Nähe niedertrampeln will"
}

L:SetMiscLocalization{
	Charge				= "%%s sieht (%S+) zornig an und lässt einen gewaltigen Schrei ertönen!",
	CombatStart			= "Er kommt aus den tiefsten, dunkelsten Höhlen der Sturmgipfel - Gormok der Pfähler! Voran, Helden!",
	Phase2				= "Stählt Euch, Helden, denn die Zwillingsschrecken Ätzschlund und Schreckensmaul erscheinen in der Arena!",
	Phase3				= "Mit der Ankündigung unseres nächsten Kämpfers gefriert die Luft selbst: Eisheuler! Tötet oder werdet getötet, Champions!",
	Gormok				= "Gormok der Pfähler",
	Acidmaw				= "Ätzschlund",
	Dreadscale			= "Schreckensmaul",
	Icehowl				= "Eisheuler"
}

---------------------
--  Lord Jaraxxus  --
---------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetOptionLocalization{
	IncinerateShieldFrame	= "Zeige Lebensanzeige mit einem Balken für Fleisch einäschern"
}

L:SetMiscLocalization{
	IncinerateTarget		= "Fleisch einäschern: %s",
	FirstPull				= "Großhexenmeister Wilfred Zischknall wird Eure nächste Herausforderung beschwören. Harrt seiner Ankunft."
}

-------------------------
--  Faction Champions  --
-------------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Fraktionschampions"
}

L:SetMiscLocalization{
	--Horde NPCs
	Gorgrim				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:64:64:96|t Gorgrim Schattenspalter",	-- 34458
	Birana				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Birana Sturmhuf",			-- 34451
	Erin				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Erin Nebelhuf",			-- 34459
	Rujkah				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t Ruj'kah",						-- 34448
	Ginselle			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:0:32|t Ginselle Seuchenwerfer",	-- 34449
	Liandra				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Liandra Sonnenrufer",			-- 34445
	Malithas			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Malithas Glanzklinge",		-- 34456
	Caiphus				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Caiphus der Ernste",		-- 34447
	Vivienne			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Vivienne Schwarzraunen",	-- 34441
	Mazdinah			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:0:32|t Maz'dinah",					-- 34454
	Thrakgar			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Thrakgar",					-- 34444
	Broln				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Broln Starkhorn",			-- 34455
	Harkzog				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:32:64|t Harkzog",					-- 34450
	Narrhok				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:0:32|t Narrhok Stahlbrecher",			-- 34453
	--Alliance NPCs
	Tyrius				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:64:64:96|t Tyrius Dämmerklinge",		-- 34461
	Kavina				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Kavina Haineslied",		-- 34460
	Melador				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Melador Talwanderer",		-- 34469
	Alyssia             = "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t Alyssia Mondpirscher",		-- 34467
	Noozle				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:0:32|t Noozle Zischelstock",		-- 34468
	Baelnor				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Baelnor Lichtträger",			-- 34471
	Velanaa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Velanaa",						-- 34465
	Anthar				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Anthar Schmiedenformer",	-- 34466
	Brienna				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Brienna Tiefnacht",		-- 34473
	Irieth				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:0:32|t Irieth Schattenschritt",	-- 34472
	Saamul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Saamul",					-- 34470
	Shaabad				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Shaabad",					-- 34463
	Serissa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:32:64|t Serissa Düsterhauch",		-- 34474
	Shocuul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:0:32|t Shocuul",						-- 34475

	AllianceVictory    = "EHRE DER ALLIANZ!",
	HordeVictory       = "Das ist nur ein Vorgeschmack auf die Zukunft. FÜR DIE HORDE!"
	--YellKill           = "Ein tragischer Sieg. Wir wurden schwächer durch die heutigen Verluste. Wer außer dem Lichkönig profitiert von solchen Torheiten? Große Krieger gaben ihr Leben. Und wofür? Die wahre Bedrohung erwartet uns noch - der Lichkönig erwartet uns alle im Tod."
}

---------------------
--  Val'kyr Twins  --
---------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "Zwillingsval'kyr"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Nächste Spezialfähigkeit",
	TimerAnubRoleplay	= "Bodeneinbrüche in"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Spezialfähigkeit bald",
	SpecWarnSpecial				= "Farbe wechseln",
	SpecWarnSwitchTarget		= "Ziel wechseln",
	SpecWarnKickNow				= "Jetzt unterbrechen",
	WarningTouchDebuff			= "Berührung auf >%s<",
	WarningPoweroftheTwins2		= "Macht der Zwillinge - Mehr Heilung auf >%s<"
}

L:SetMiscLocalization{
--	YellPull	= "Im Namen unseres dunklen Meisters. Für den Lichkönig. Ihr. Werdet. Sterben.",
--	CombatStart	= "Nur gemeinsam werdet Ihr den letzten Kampf meistern. Aus den Tiefen Eiskrones stammen diese zwei der mächtigsten Kommandanten der Geißel: schreckliche Val'kyr, geflügelte Boten des Lichkönigs!",
	Fjola		= "Fjola Lichtbann",
	Eydis		= "Eydis Nachtbann",
	AnubRP		= "Dem Lichkönig wurde ein schwerer Schlag versetzt! Ihr habt Euch als würdige Champions erwiesen. Gemeinsam werden wir den Angriff auf die Eiskronenzitadelle durchführen und den Rest der Geißel zerstören! Gemeinsam meistern wir alles!"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Zeige Zeit bis nächste Spezialfähigkeit",
	TimerAnubRoleplay			= "Rollenspiel-Timer für der Lichkönig anzeigen, der das Parkett bricht",
	WarnSpecialSpellSoon		= "Zeige Vorwarnung für nächste Spezialfähigkeit",
	SpecWarnSpecial				= "Spezialwarnung, wenn du die Farbe wechseln musst",
	SpecWarnSwitchTarget		= "Spezialwarnung, wenn der andere Zwilling zaubert",
	SpecWarnKickNow				= "Spezialwarnung zum Unterbrechen",
	SpecialWarnOnDebuff			= "Spezialwarnung bei Berührung (um Farbe zu wechseln)",
	SetIconOnDebuffTarget		= "Setze Zeichen auf Ziele von Berührung des Lichts/der Nacht (heroisch)",
	WarningTouchDebuff			= "Verkünde Ziele von Berührung des Lichts/der Nacht",
	WarningPoweroftheTwins2		= "Verkünde Ziele von Macht der Zwillinge"
}

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge				= "Auftauchen",
	TimerSubmerge			= "Abtauchen",
	timerAdds				= "Neue Adds"
}

L:SetWarningLocalization{
	WarnEmerge				= "Auftauchen",
	WarnEmergeSoon			= "Auftauchen in 10 Sekunden",
	WarnSubmerge			= "Abtauchen",
	WarnSubmergeSoon		= "Abtauchen in 10 Sekunden",
	warnAdds				= "Neue Adds"
}

L:SetMiscLocalization{
	--YellPull				= "Dieser Ort wird Euch als Grab dienen!",
	Emerge					= "entsteigt dem Boden!",
	Burrow					= "gräbt sich in den Boden!",
	YellBurrow				= "Auum na-l ak-k-k-k, isshhh. Erhebt euch, Diener. Verschlingt...",
	PcoldIconSet			= "DKälte-Zeichen {rt%d} auf %s gesetzt",
	PcoldIconRemoved		= "DKälte-Zeichen von %s entfernt"
}

L:SetOptionLocalization{
	WarnEmerge				= "Zeige Warnung für Auftauchen",
	WarnEmergeSoon			= "Zeige Vorwarnung für Auftauchen",
	WarnSubmerge			= "Zeige Warnung für Abtauchen",
	WarnSubmergeSoon		= "Zeige Vorwarnung für Abtauchen",
	warnAdds				= "Verkünde neue Adds",
	timerAdds				= "Zeige Zeit bis neue Adds erscheinen",
	TimerEmerge				= "Zeige Zeit bis Auftauchen",
	TimerSubmerge			= "Zeige Zeit bis Abtauchen",
	AnnouncePColdIcons		= "Verkünde Zeichen für Ziele von $spell:66013 im Schlachtzugchat (nur als Leiter)",
	AnnouncePColdIconsRemoved	= "Verkünde auch das Entfernen von Zeichen für $spell:66013 (benötigt obige Einstellung)",
	RemoveHealthBuffsInP3	= "Entferne lebenspunktesteigernde Buffs in Phase 3"
}
