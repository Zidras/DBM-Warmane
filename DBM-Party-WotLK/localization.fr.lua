if GetLocale() ~= "frFR" then return end

local L

local optionWarning		= "Activer l'alerte : %s"
local optionPreWarning	= "Activer la pré-alerte : %s"

----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "Prince Taldaram"
})

-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "Ancien Nadox"
})

---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Jedoga Cherchelombre"
})

---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "Héraut Volazj"
})

----------------
--  Amanitar  --
----------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "Amanitar"
})

-------------------
--  Azjol-Nerub  --
---------------------------------
--  Krik'thir the Gatewatcher  --
---------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "Krik'thir le Gardien de porte"
})

----------------
--  Hadronox  --
----------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "Hadronox"
})

-------------------------
--  Anub'arak (Party)  --
-------------------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Anub'arak (Groupe)"
})

---------------------------------------
--  Caverns of Time: Old Stratholme  --
---------------------------------------
--  Meathook  --
----------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "Grancrochet"
})

--------------------------------
--  Salramm the Fleshcrafter  --
--------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "Salramm le Façonneur de chair"
})

-------------------------
--  Chrono-Lord Epoch  --
-------------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Chronoseigneur Epoch"
})

-----------------
--  Mal'Ganis  --
-----------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "Mal'Ganis"
})

L:SetMiscLocalization({
	Outro	= "Votre voyage ne fait que commencer, jeune prince. Rassemblez vos troupes et retrouvez-moi dans les terres arctiques du Norfendre. C'est là-bas que nous règlerons nos comptes. C'est là-bas que votre vraie destinée vous attend."
})

-----------------
-- Wave Timers --
-----------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Vagues de Stratholme"
})

L:SetWarningLocalization({
	WarningWaveNow	= "Vague %d: %s"
})

L:SetTimerLocalization({
	TimerWaveIn		=	"Prochaine vague (6)",
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("New Wave"),
	TimerWaveIn		= "Montre le timer \"Prochaine vague\" (vague 6 seulement)",
	TimerRoleplay	= "Afficher le timer de la durée du jeu de rôle initial"
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
	Roleplay	= "Ravi que vous ayez réussi à nous rejoindre, Uther.",
	Roleplay2	= "On dirait que tout le monde est prêt. N'oubliez pas, ces gens sont tous infectés et ils vont bientôt mourir. Nous devons purifier Stratholme pour protéger le reste de Lordaeron du Fléau. Allons-y."
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

L:SetMiscLocalization({
	YellExplosion = "Cadavre fait boum !"
})

------------------------
-- Novos the Summoner --
------------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "Novos l'Invocateur"
})

L:SetWarningLocalization({
	WarnCrystalHandler	= "Eleveur de cristal apparaissent (%d restant)"
})

L:SetTimerLocalization({
	timerCrystalHandler	= "Eleveur de cristal apparaissent"
})

L:SetOptionLocalization({
	WarnCrystalHandler	= "Alerte indiquant Eleveur de cristal apparaissent",
	timerCrystalHandler	= "Afficher le temps pour le prochain Eleveur de cristal apparaissent"
})

L:SetMiscLocalization({
	YellPull		= "Ce frisson glacé qui vous parcourt est l'annonciateur de votre perte !",
	HandlerYell		= "Renforcez mes défenses ! Faites vite, bon sang !",
	Phase2			= "Vous voyez bien que tout cela est futile !",
	YellKill		= "Your efforts... are in vain.",
})


-----------------
--  King Dred  --
-----------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "Roi Dred"
})

-----------------------------
--  The Prophet Tharon'ja  --
-----------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "Le prophète Tharon'ja"
})

---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "Slad'ran"
})

---------------
--  Moorabi  --
---------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "Moorabi"
})

-------------------------
--  Drakkari Colossus  --
-------------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "Colosse drakkari"
})

L:SetWarningLocalization({
	warningElemental	= "Phase 2 : L’élémentaire",
	WarningStone		= "Phase 1 : Le colosse"
})

L:SetOptionLocalization({
	WarningElemental	= "Activer l'annonce de la Phase 2 : L’élémentaire",
	WarningStone		= "Activer l'annonce de la Phase 1 : Le colosse"
})

-----------------
--  Gal'darah  --
-----------------
L = DBM:GetModLocalization("Galdarah")

L:SetGeneralLocalization({
	name = "Gal'darah"
})

L:SetWarningLocalization({
	TimerPhase2		= "Phase 2 : L’avatar d'Akali",
	TimerPhase1		= "Phase 1 : Grand prophète d’Akali"
})

L:SetTimerLocalization({
	TimerPhase2		= "Phase 2 : L’avatar d'Akali",
	TimerPhase1		= "Phase 1 : Grand prophète d’Akali"
})

L:SetOptionLocalization({
	TimerPhase2		= "Alerte concernant Phase 2 : L’avatar d'Akali",
	TimerPhase1		= "Alerte concernant Phase 1 : Grand prophète d’Akali"
})

L:SetMiscLocalization({
	YellPhase2_1	= "Après ça il restera plus rien !",
	YellPhase2_2	= "Tu veux voir la puissance ? Je vais te montrer la PUISSANCE !"
})

-------------------------
--  Eck the Ferocious  --
-------------------------
L = DBM:GetModLocalization("Eck")

L:SetGeneralLocalization({
	name = "Eck le Féroce"
})

--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
L = DBM:GetModLocalization("Bjarngrin")

L:SetGeneralLocalization({
	name = "Général Bjarngrim"
})

-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "Ionar"
})

---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization("Volkhan")

L:SetGeneralLocalization({
	name = "Volkhan"
})

------------
-- Loken --
------------
L = DBM:GetModLocalization("Loken")

L:SetGeneralLocalization({
	name = "Loken"
})

----------------------
--  Halls of Stone  --
-----------------------
--  Maiden of Grief  --
-----------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "Damoiselle de peine"
})

------------------
--  Krystallus  --
------------------
L = DBM:GetModLocalization("Krystallus")

L:SetGeneralLocalization({
	name = "Krystallus"
})

----------------------------
-- Sjonnir the Ironshaper --
----------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "Sjonnir le Sculptefer"
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
	timerEvent		= "Montrer le timer de l'event"
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

-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Ormorok le Sculpte-arbre"
})

----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Grand magus Telestra"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Séparation bientôt",
	WarningSplitNow		= "Séparation",
	WarningMerge		= "Rassemblement"
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

----------------
-- The Oculus --
-----------------------------
-- Drakos the Interrogator --
-----------------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "Drakos l'Interrogateur"
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

L:SetMiscLocalization({
	CombatStart	= "Pauvres crétins aveugles !"
})

--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Varos Arpentenuée"
})

---------------------------
--  Ley-Guardian Eregos  --
---------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Gardien-tellurique Eregos"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Comptez là-dessus"
})

--------------------
--  Utgarde Keep  --
-----------------------
--  Prince Keleseth  --
-----------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "Prince Keleseth"
})

--------------------------------
--  Skarvald the Constructor  --
--  & Dalronn the Controller  --
--------------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "Constructeur & Contrôleur"
})

----------------------------
--  Ingvar the Plunderer  --
----------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ingvar le Pilleur"
})

L:SetMiscLocalization({
	YellIngvarPhase2	= "Je reviens... Ahh... Une seconde chance de vous tailler le crâne !",
	YellCombatEnd		= "Non ! Je peux faire... mieux, je peux..."
})

----------------------
-- Utgarde Pinnacle --
------------------------
-- Skadi the Ruthless --
------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "Skadi le Brutal"
})

L:SetMiscLocalization({
	CombatStart		= "Quels chiens osent s'introduire ici ? Remuez-vous, mes frères ! Un festin pour celui qui me ramène leurs têtes !",
	Phase2			= "Misérables canailles ! Vos cadavres feront des morceaux de choix pour mon nouveau drake !"
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "Roi Ymiron"
})

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Svala Tristetombe"
})

L:SetTimerLocalization({
	timerRoleplay		= "Svala Tristetombe active"
})

L:SetOptionLocalization({
	timerRoleplay		= "Afficher le timer de la durée du roleplay avant que Svala Tristetombe ne devienne actif"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "Votre seigneurie ! J'ai fait ainsi que vous m'aviez commandé, et j'implore à présent votre bénédiction !"
})

---------------------
-- Gortok Palehoof --
---------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Gortok Pâle-sabot"
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

L:SetMiscLocalization({
	CyanArrived	= "A valiant defense, but this city must be razed. I will fulfill Malygos's wishes myself!"
})

--------------
--  Erekem  --
--------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "Erekem"
})

---------------
--  Ichoron  --
---------------
L = DBM:GetModLocalization("Ichoron")

L:SetGeneralLocalization({
	name = "Ichoron"
})

-----------------
--  Lavanthor  --
-----------------
L = DBM:GetModLocalization("Lavanthor")

L:SetGeneralLocalization({
	name = "Lavanthor"
})

--------------
--  Moragg  --
--------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "Moragg"
})

--------------
--  Xevozz  --
--------------
L = DBM:GetModLocalization("Xevoss")

L:SetGeneralLocalization({
	name = "Xevozz"
})

-------------------------------
--  Zuramat the Obliterator  --
-------------------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "Zuramat l'Oblitérateur"
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
	TimerPortalIn	= "Portail #%d"
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

L:SetOptionLocalization({
	AchievementCheck	= "Annoncer l'échec de la réussite « I've Had Worse » pour faire la fête"
})

L:SetMiscLocalization({
	Pull				= "Bien joué. Aujourd'hui, vous avez fait la preuv-",
	AchievementFailed	= ">> Haut fait ÉCHEC: %s a été frappé par Explosion de goule <<",
	YellCombatEnd		= "Non ! Pas encore... un échec..."
})

-------------------
-- Grand Champions --
-------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Grand Champions"
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

L:SetMiscLocalization({
	YellCombatEnd	= "Grâce ! Je me rends. Excellent travail. Puis-je me débiner, maintenant ?"
})

---------------------
-- Pit of Saron --
-------------------
--  Ick and Krick  --
-------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "Ick"
})

----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Maître-forge Gargivre"
})

L:SetOptionLocalization({
	AchievementCheck	= "Annoncer les avertissements de réussite « Ne va pas à onze » pour faire la fête"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s vous lance un énorme bloc de saronite !",
	AchievementWarning	= "Alerte: %s a %d stacks de Gel prolongé",
	AchievementFailed	= ">> Haut fait ÉCHEC: %s a %d stacks de Gel prolongé <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Seigneur du Fléau Tyrannus"
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

-------------------
-- Devourer of Souls --
-------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "Dévoreur d'âmes"
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

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization("Marwyn")

L:SetGeneralLocalization({
	name = "Marwyn"
})

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization("LichKingEvent")

L:SetGeneralLocalization({
	name = "Échapper à Arthas"
})

L:SetTimerLocalization({
	achievementEscape	= "Le temps d'échapper à"
})

L:SetOptionLocalization({
	WarnWave	= "Afficher un avertissement pour les vagues entrantes."
})

L:SetMiscLocalization({
	ArthasYellKill	= "FEU ! FEU !",
	Ghoul			= "Raging Ghoul",			--creature id 36940. Not sure how to use these in function above to simplify locals though. :\
	Abom			= "Lumbering Abomination",	--creature id 37069
	WitchDoctor		= "Risen Witch Doctor",		--creature id 36941
	Wave1			= "Vous ne vous échapperez pas !",
	Wave2			= "Succombez au froid de la tombe !",
	Wave3			= "Encore un cul-de-sac !",
	Wave4			= "Combien de temps allez-vous tenir ?"
})
