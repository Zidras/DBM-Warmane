if GetLocale() ~= "frFR" then return end

local L

local spell				= "%s"				
local debuff			= "%s: >%s<"			
local spellCD			= "%s cooldown"
local spellSoon			= "%s bientôt"
local optionWarning		= "Activer l'alerte : %s"
local optionPreWarning	= "Activer la pré-alerte : %s"
local optionSpecWarning	= "Activer l'alerte spéciale : %s"
local optionTimerCD		= "Afficher le timer pour le cooldown pour : %s"
local optionTimerDur	= "Afficher le timer de durée pour : %s"
local optionTimerCast	= "Afficher le timer pour le cast de : %s"

--------------------------------
-- Ahn'Kahet: The Old Kingdom --
--------------------------------
-- Prince Taldaram --
---------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "Prince Taldaram"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------
-- Elder Nadox --
-----------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "Ancien Nadox"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
-- Jedoga Shadowseeker --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Jedoga Cherchelombre"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------
-- Herald Volazj --
-------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "Héraut Volazj"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------
-- Amanitar --
--------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "Amanitar"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------
-- Azjol-Nerub --
-------------------------------
-- Krik'thir the Gatewatcher --
-------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "Krik'thir le Gardien de porte"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------
-- Hadronox --
--------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "Hadronox"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
--  Anub'arak (Party)  --
-------------------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Anub'arak (Groupe)"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------------------
-- Caverns of Time - Old Stratholme --
--------------------------------------
-- Meathook --
--------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "Grancrochet"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------------
-- Salramm the Fleshcrafter --
------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "Salramm le Façonneur de chair"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------
-- Chrono-Lord Epoch --
-----------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Chronoseigneur Epoch"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------
-- Mal'Ganis --
---------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "Mal'Ganis"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	Outro	= "Your journey has just begun, young prince. Gather your forces and meet me in the arctic land of Northrend. It is there that we shall settle the score between us. It is there that your true destiny will unfold." --Translating needed
})

-----------------
-- Wave Timers --
-----------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Vagues de Stratholme"
})

L:SetWarningLocalization({
	WarningWaveNow	= "Vague %d: %s",
})

L:SetTimerLocalization({
	TimerWaveIn		= 	"Prochaine vague (6)", 
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("New Wave"),
	TimerWaveIn		= "Montre le timer \"Prochaine vague\" (vague 6 seulement)",
	TimerRoleplay	= "Show timer for opening roleplay event." --Translating needed
})

L:SetMiscLocalization({
	Meathook	= "Grancrochet",
	Salramm		= "Salramm le Façonneur de chair",
	Devouring	= "Goule dévorante",
	Enraged		= "Goule enragée",
	Necro		= "Nécromancien",
	Fiend		= "Démon des cryptes",
	Stalker		= "Traqueur des tombes",
	Abom		= "Assemblage recousu",
	Acolyte		= "Acolyte",
	Wave1		= "%d %s",
	Wave2		= "%d %s et %d %s",
	Wave3		= "%d %s, %d %s et %d %s",
	Wave4		= "%d %s, %d %s, %d %s et %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Vagues du Fléau = (%d+)/10",
	Roleplay	= "Glad you could make it, Uther.", --Translating needed
	Roleplay2	= "Everyone looks ready. Remember, these people are all infected with the plague and will die soon. We must purge Stratholme to protect the remainder of Lordaeron from the Scourge. Let's go." --Translating needed
})

----------------------
-- Drak'Tharon Keep --
----------------------
-- Trollgore --
---------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "Trollétripe"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------
-- Novos the Summoner --
------------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "Novos l'Invocateur"
})

L:SetWarningLocalization({
	WarnCrystalHandler	= "Crystal Handler spawned (%d remaining)"
})

L:SetTimerLocalization({
	timerCrystalHandler	= "Crystal Handler spawns"
})

L:SetOptionLocalization({
	WarnCrystalHandler	= "Show warning when Crystal Handler spawns",
	timerCrystalHandler	= "Show timer for next Crystal Handler spawn"
})

L:SetMiscLocalization({
	YellPull		= "The chill you feel is the herald of your doom!",
	HandlerYell		= "Bolster my defenses! Hurry, curse you!",
	Phase2			= "Surely you can see the futility of it all!",
	YellKill		= "Your efforts... are in vain.",
	SetIconOnEnragedMob = DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(39249)
})


---------------
-- King Dred --
---------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "Roi Dred"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------------
-- The Prophet Tharon'ja --
---------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "Le prophète Tharon'ja"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------
-- Gun'Drak --
--------------
-- Slad'ran --
--------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "Slad'ran"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------
-- Moorabi --
-------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "Moorabi"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------
-- Drakkari Colossus --		
-----------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "Colosse drakkari"
})

L:SetWarningLocalization({
	warningElemental	= "Phase Elémentaire",
	WarningStone		= "Phase Colosse"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningElemental	= "Activer l'annonce de la phase Elémentaire",
	WarningStone		= "Activer l'annonce de la phase Colosse"
})

---------------
-- Gal'darah --
---------------
L = DBM:GetModLocalization("Galdarah")

L:SetGeneralLocalization({
	name = "Gal'darah"
})

L:SetWarningLocalization({
	TimerPhase2		= "Rhino phase",
	TimerPhase1		= "Troll phase"
})

L:SetTimerLocalization({
	TimerPhase2		= "Rhino phase",
	TimerPhase1		= "Troll phase"
})

L:SetOptionLocalization({
	TimerPhase2		= "Show warning for Rhino phase",
	TimerPhase1		= "Show warning for Troll phase"
})

-----------------------
-- Eck the Ferocious --
-----------------------
L = DBM:GetModLocalization("Eck")

L:SetGeneralLocalization({
	name = "Eck le Féroce"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------
-- Halls of Lightning --
------------------------
-- General Bjarngrim --
-----------------------
L = DBM:GetModLocalization("Gjarngrin")

L:SetGeneralLocalization({
	name = "Général Bjarngrim"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------
-- Ionar --
-----------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "Ionar"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------
-- Volkhan --
-------------
L = DBM:GetModLocalization("Volkhan")

L:SetGeneralLocalization({
	name = "Volkhan"
})

L:SetWarningLocalization({
	WarningStomp 	= spell
})

L:SetTimerLocalization({
	TimerStompCD	= spellCD
})

L:SetOptionLocalization({
	WarningStomp 	= optionWarning:format(GetSpellInfo(52237)),
	TimerStompCD 	= optionTimerCD:format(GetSpellInfo(52237))
})

------------
-- Kronus --
------------
L = DBM:GetModLocalization("Kronus")

L:SetGeneralLocalization({
	name = "Loken"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------
-- Halls of Stone --
---------------------
-- Maiden of Grief --
---------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "Damoiselle de peine"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------
-- Krystallus --
----------------
L = DBM:GetModLocalization("Krystallus")

L:SetGeneralLocalization({
	name = "Krystallus"
})

L:SetWarningLocalization({
	WarningShatter	= spell
})

L:SetTimerLocalization({
	TimerShatterCD	= spellCD
})

L:SetOptionLocalization({
	WarningShatter	= optionWarning:format(GetSpellInfo(50810)),
	TimerShatterCD	= optionTimerCD:format(GetSpellInfo(50810))
})

----------------------------
-- Sjonnir the Ironshaper --
----------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "Sjonnir le Sculptefer"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------------------
-- Brann Bronzebeard Escort Event --
------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "Tribunal des âges"
})

L:SetWarningLocalization({
	WarningPhase	= "Phase %d"
})

L:SetTimerLocalization({
   timerEvent   = "Temps restant"
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("Phase #"),
	timerEvent      = "Montrer le timer de l'event"
})

L:SetMiscLocalization({
	Pull	= "Ouvrez l'œil ! Je vais régler ça en deux coups de cuillè -",
	Phase1	= "Faille de sécurité détectée. Analyse des archives historiques transférée en attente de basse priorité. Contre-mesures déclenchées.",
	Phase2	= "Seuil d'indice de menace dépassé. Archivation céleste annulée. Niveau de sécurité augmenté.",
	Phase3	= "Indice de menace critique. Analyse du Vide détournée. Lancement des protocoles d'épuration.",
	Kill	= "Alerte : systèmes de protection désactivés. Purge de la mémoire en cours…"
})

---------------
-- The Nexus --
---------------
-- Anomalus --
--------------
L = DBM:GetModLocalization("Anomalus")

L:SetGeneralLocalization({
	name = "Anomalus"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-----------------------------
-- Ormorok the Tree-Shaper --
-----------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Ormorok le Sculpte-arbre"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------
-- Grand Magus Telestra --
--------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Grand magus Telestra"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Séparation bientôt",
	WarningSplitNow		= "Séparation",
	WarningMerge		= "Rassemblement"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= "Montre une alerte lorsque la Séparation est proche",
	WarningSplitNow		= "Montre une alerte lors de la Séparation",
	WarningMerge		= "Montre une alerte lors du Rassemblement"
})

L:SetMiscLocalization({
	SplitTrigger1		= "Il y en aura assez pour tout le monde.",
	SplitTrigger2		= "Vous allez être trop bien servis !",
	MergeTrigger		= "Et maintenant finissons le travail !"
})

-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "Keristrasza"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------------------
-- Commander Kolurg/Stoutbeard --
---------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Unknown"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Commandant Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Commandant Rudebarbe"
end

L:SetGeneralLocalization({
	name = commander
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------
-- The Oculus --
-----------------------------
-- Drakos the Interrogator --
-----------------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "Drakos l'Interrogateur"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	MakeitCountTimer	= "Montre le timer pour le haut-fait Comptez là-dessus"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Comptez là-dessus"
})

--------------------
-- Mage-Lord Urom --
--------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "Seigneur-mage Urom"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	CombatStart		= "Poor blind fools!" --Translating needed
})

------------------------
-- Varos Cloudstrider --
------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Varos Arpentenuée"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
-- Ley-Guardian Eregos --
-------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Gardien-tellurique Eregos"
})

L:SetWarningLocalization({
	WarningShiftEnd	= "Changement de plan terminé"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).." terminé")
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Comptez là-dessus"
})

------------------
-- Utgarde Keep --
---------------------
-- Prince Keleseth --
---------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "Prince Keleseth"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------------
-- Skarvald the Constructor --
-- & Dalronn the Controller --
------------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "Constructeur & Contrôleur"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------
-- Ingvar the Plunderer --
--------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ingvar le Pilleur"
})

L:SetWarningLocalization({
	SpecialWarningSpelllock = "Renvoi des sorts !!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecialWarningSpelllock	= "Montre une alerte spéciale pour spell lock"
})

L:SetMiscLocalization({
	YellCombatEnd	= "Non ! Je peux faire... mieux, je peux..."
})

------------------------
--  Utgarde Pinnacle  --
--------------------------
--  Skadi the Ruthless  --
--------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "Skadi le Brutal"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	CombatStart		= "What mongrels dare intrude here? Look alive, my brothers! A feast for the one that brings me their heads!", --Translating needed
	Phase2			= "You motherless knaves! Your corpses will make fine morsels for my new drake!" --Translating needed
})

------------
-- Ymiron --
------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "Roi Ymiron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------
-- Svala Sorrowgrave --
-----------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Svala Tristetombe"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerRoleplay		= "Svala Tristetombe active" --Needs Translating
})

L:SetOptionLocalization({
	timerRoleplay		= "Show timer for roleplay before Svala Tristetombe becomes active" --Needs Translating
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "My liege! I have done as you asked, and now beseech you for your blessing!" --Needs Translating
})

---------------------
-- Gortok Palehoof --
---------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Gortok Pâle-sabot"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------
-- The Violet Hold --
---------------------
-- Cyanigosa --
---------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "Cyanigosa"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart		= "Combat starts"
})

L:SetOptionLocalization({
	TimerCombatStart		= "Show timer for start of combat"
})

L:SetMiscLocalization({
	CyanArrived	= "A valiant defense, but this city must be razed. I will fulfill Malygos's wishes myself!"
})

------------
-- Erekem --
------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "Erekem"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------
-- Ichoron --
-------------
L = DBM:GetModLocalization("Ichoron")

L:SetGeneralLocalization({
	name = "Ichoron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------
-- Lavanthor --
---------------
L = DBM:GetModLocalization("Lavanthor")

L:SetGeneralLocalization({
	name = "Lavanthor"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------
-- Moragg --
------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "Moragg"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------
-- Xevoss --
------------
L = DBM:GetModLocalization("Xevoss")

L:SetGeneralLocalization({
	name = "Xevoss"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------------
-- Zuramat the Obliterator --
-----------------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "Zuramat l'Oblitérateur"
})

L:SetWarningLocalization({
	SpecialWarningVoidShifted 	= spell:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness 	= spell:format(GetSpellInfo(59745))
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecialWarningVoidShifted	= optionSpecWarning:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness		= optionSpecWarning:format(GetSpellInfo(59745))
})

-------------------
-- Portal Timers --
-------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Timer des portails"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Portail imminent",
	WarningPortalNow	= "Portail #%d",
	WarningBossNow		= "Arrivée d'un boss"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portail #%d",
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("Portail"),
	WarningPortalSoon		= optionPreWarning:format("Portail imminent"),
	WarningBossNow			= optionWarning:format("Arrivée d'un boss"),
	TimerPortalIn			= "Afficher le timer des portails",
	ShowAllPortalTimers		= "Activer les annonces pour toutes les vagues"
})

L:SetMiscLocalization({
	Sealbroken	= "Gardes, nous partons ! Ces aventuriers vont se charger de la suite ! Allez, en route !",
	WavePortal	= "Portails Ouverts : (%d+)/18"
})

-----------------------------
--  Trial of the Champion  --
-----------------------------
--  The Black Knight  --
------------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "Le Chevalier noir"
})

L:SetWarningLocalization({
	warnExplode				= "Séide goule incante explosion ! Bougez !"
})

L:SetTimerLocalization{
	TimerCombatStart	= "Combat starts"
}

L:SetOptionLocalization({
	specWarnDesecration		= "Montre une alerte spéciale quand vous prenez des dégâts venant de la Violation",
	warnExplode				= "Montre une alerte quand une Séide goule incante explosion sur elle-même",
	SetIconOnMarkedTarget	= "Met une icône sur la cible de la mort",
	SetIconOnMarkedTarget	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(67823)
})

L:SetMiscLocalization({
	Pull				= "Well done. You have proven yourself today-",
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s was hit by Ghoul Explode <<",
	YellCombatEnd			= "Non ! Pas encore... un échec..."
})

-------------------
-- Grand Champions --
-------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Grand Champions"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd	= "Joli combat ! Votre prochain défi vient directement des rangs de la Croisade. L'épreuve sera de vous mesurer à l'incroyable vituosité de ses cavaliers."
})

-------------------
-- Argent Confessor Paletress --
-------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "Confesseur d'argent Paletress"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd	= "Bon travail !"
})

-------------------
-- Eadric the Pure --
-------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "Eadric le Pur"
})

L:SetWarningLocalization({
	specwarnRadiance		= "Radiance. Retournez vous !"
})

L:SetOptionLocalization({
	specwarnRadiance		= "Montre une alerte spéciale pour Radiance.",
	SetIconOnHammerTarget	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(66940)
})

L:SetMiscLocalization({
	YellCombatEnd	= "Grâce ! Je me rends. Excellent travail. Puis-je me débiner, maintenant ?"
})

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "Ick"
})

L:SetWarningLocalization({
	warnPursuit			= "Poursuite dans 5 secondes",
	specWarnPursuit		= "Vous êtes poursuivi ! Courrez !"
})

L:SetOptionLocalization({
	warnPursuit				= "Montre une alerte lorsque la Poursuite est pour bientôt",
	specWarnPursuit			= "Montre une alerte spéciale lorsque vous êtes poursuivi",
	SetIconOnPursuitTarget	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(68987)
})

L:SetMiscLocalization({
	IckPursuit	= "%s vous poursuit !",
	Barrage		= "%s commence à invoquer rapidement des mines explosives !",
--	YellCombatEnd	= ""--in case removing kricks creatureid doesn't fix it thinking we wipe.
})
----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Maître-forge Gargivre"
})

L:SetWarningLocalization({
	warnSaroniteRock			= "Rocher de Saronite ! Ligne de Vue maintenant !",
	specWarnSaroniteRock		= "Lancer de Saronite sur vous ! Bougez !",
	specWarnSaroniteRockNear	= "Lancer de Saronite près de vous - Bougez",
	specWarnPermafrost			= "%s: %s"
})

L:SetOptionLocalization({
	warnSaroniteRock			= "Montre une alerte pour le Rocher de Saronite (pour effacer Gel prolongé)",
	specWarnSaroniteRock		= "Montre une alerte spéciale lorsque le Lancer de Saronite est sur vous",
	specWarnSaroniteRockNear	= "Montre une alerte spéciale lorsque le Lancer de Saronite est près de vous",
	specWarnPermafrost			= "Montre une alerte spéciale lorsque le nombre de charge de Gel prolongé est grand (valeur non fixée)",
	SetIconOnSaroniteRockTarget	= "Met une icône sur la cible du Rocher de Saronite",
	SetIconOnSaroniteRockTarget	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(70851)
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s hurls a massive saronite boulder at you!",
	AchievementWarning	= "Warning: %s has %d stacks of Permafrost",
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s has %d stacks of Permafrost <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Seigneur du Fléau Tyrannus"
})

L:SetWarningLocalization({
	specWarnHoarfrost		= "Gelée blanche sur vous !",
	specWarnHoarfrostNear	= "Gelée blanche proche de vous ! Bougez !"
})

L:SetTimerLocalization{
	TimerCombatStart	= "Le combat commence"
}

L:SetOptionLocalization({
	specWarnHoarfrost			= "Montre une alerte spéciale lorsque la Gelée blanche est sur vous",
	specWarnHoarfrostNear		= "Montre une alerte spéciale lorsque la Gelée blanche est proche de vous",
	TimerCombatStart			= "Affiche un timer pour le début du combat",
	SetIconOnHoarfrostTarget	= DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(69246)
})

L:SetMiscLocalization({
	CombatStart		= "Hélas, mes très, très braves aventuriers, votre intrusion touche à sa fin. Entendez-vous le claquement de l'acier sur les os qui monte du tunnel, derrière vous ? C'est le son de votre mort imminente.",
	HoarfrostTarget	= "^%%s fixe (%S+) du regard et prépare une attaque de glace !",
	YellCombatEnd	= "Impossible.... Frigecroc.... avertis...."
})

---------------------
-- Forge of Souls --
---------------------
-- Bronjahm --
-------------------
L = DBM:GetModLocalization("Bronjahm")

L:SetGeneralLocalization({
	name = "Bronjahm"
})

L:SetWarningLocalization({
	specwarnSoulstorm	= "Tempête d'âme ! Allez au centre !"
})

L:SetOptionLocalization({
	specwarnSoulstorm	= "Montre une alerte spéciale lorsque Tempête d'âme est lancée (pour aller au centre)"
})

-------------------
-- Devourer of Souls --
-------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "Dévoreur d'âmes"
})

L:SetWarningLocalization({
	specwarnMirroredSoul	= "Âme réfléchie ! Stop DPS !",
	specwarnWailingSouls	= "Âmes gémissantes - Allez derrière"
})

L:SetOptionLocalization({
	specwarnMirroredSoul	= "Montre une alerte spéciale pour arrêter le DPS lorsque vous êtes la cible d'Âme réfléchie",
	specwarnWailingSouls	= "Montre une alerte spéciale lorsque le sort Âmes gémissantes est incanté",
	SetIconOnMirroredTarget	= "Set icons on $spell:69051 targets"
})

---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Timers des vagues"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Prochaine vague bientôt",
	WarnNewWave		= "Arrivée de %s"
})

L:SetTimerLocalization({
	TimerNextWave	= "Prochaine vague"
})

L:SetOptionLocalization({
	WarnNewWave			= "Montre une alerte pour l'arrivée d'un boss",
	WarnNewWaveSoon		= "Montre une pré-alerte pour la prochaine vague",
	ShowAllWaveWarnings	= "Montre des alertes et pré-alertes pour toutes les vagues",	--Is this a warning or a pre-warning?
	TimerNextWave		= "Affiche un timer pour le prochain ensemble de vague (après le boss de la vague 5)",
	ShowAllWaveTimers	= "Affiche un timer pour toutes les vagues"
})

L:SetMiscLocalization({
	Falric		= "Falric",
	WaveCheck	= "Vague d'esprit = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization("Falric")

L:SetGeneralLocalization({
	name = "Falric"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization("Marwyn")

L:SetGeneralLocalization({
	name = "Marwyn"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization("LichKingEvent")

L:SetGeneralLocalization({
	name = "Epreuve du Roi-Liche"
})

L:SetWarningLocalization({
	WarnWave1		= "6 Raging Ghoul, 1 Risen Witch Doctor incoming",--6 Ghoul, 1 WitchDocter
	WarnWave2		= "6 Raging Ghoul, 2 Risen Witch Doctor, 1 Lumbering Abomination incoming",--6 Ghoul, 2 WitchDocter, 1 Abom
	WarnWave3		= "6 Raging Ghoul, 2 Risen Witch Doctor, 2 Lumbering Abomination incoming",--6 Ghoul, 2 WitchDocter, 2 Abom
	WarnWave4		= "12 Raging Ghoul, 4 Risen Witch Doctor, 3 Lumbering Abomination incoming"--12 Ghoul, 3 WitchDocter, 3 Abom
})

L:SetTimerLocalization({
	achievementEscape	= "Time to escape"
})

L:SetOptionLocalization({
	ShowWaves	= "Show warning for incoming waves"
})

L:SetMiscLocalization({
	Ghoul			= "Raging Ghoul",--creature id 36940. Not sure how to use these in function above to simplify locals though. :\
	Abom			= "Lumbering Abomination",--creature id 37069
	WitchDoctor		= "Risen Witch Doctor",--creature id 36941
	ACombatStart	= "He is too powerful. We must leave this place at once! My magic can hold him in place for only a short time. Come quickly, heroes!",
	HCombatStart	= "He's... too powerful. Heroes, quickly... come to me! We must leave this place at once! I will do what I can to hold him in place while we flee.",
	Wave1			= "There is no escape!",
	Wave2			= "Succumb to the chill of the grave.",
	Wave3			= "Another dead end.",
	Wave4			= "How long can you fight it?",
	YellCombatEnd	= "FEU ! FEU !"
})
