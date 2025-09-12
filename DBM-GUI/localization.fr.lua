if GetLocale() ~= "frFR" then return end
if not DBM_GUI_L then DBM_GUI_L = {} end

local L = DBM_GUI_L
local CL = DBM_CORE_L

--L.MainFrame 						= "Deadly Boss Mods"

L.DBMWarmane						= CL.DBM .. "-Warmane par Zidras"
L.TranslationByPrefix				= "Retail rétroportage par "
L.TranslationBy						= "Barsoom, Bunny67, Zidras"
L.Website							= "Rendez-nous visite sur discord à |cFF73C2FBhttps://discord.gg/CyVWDWS|r"
L.WebsiteButton						= "Site web"

L.OTabBosses						= "Bosses"--Deprecated and will be deleted once tabs no longer use this
L.OTabRaids							= "Raid"--Raids & PVP
L.OTabDungeons						= "Groupe/Solo"--1-5 person content (Dungeons, MoP Scenarios, World Events, Brawlers, Proving Grounds, Visions, Torghast, etc) (Dungeons, MoP Scenarios, World Events, Brawlers, Proving Grounds, Visions, Torghast, etc)
L.OTabPlugins						= "Core Plugins"
L.OTabOptions						= "Options principales"
L.OTabAbout							= "À propos"

L.TabCategory_OTHER					= "Autres modules"
L.TabCategory_AFFIXES				= "Affixes"

L.BossModLoaded						= "Statistiques %s"
L.BossModLoad_now					= [[Ce boss mod n'est pas chargé.
Il le sera une fois que vous serez dans l'instance.
Vous pouvez aussi cliquer sur le bouton pour le charger manuellement.]]

L.PosX								= "Position en X"
L.PosY								= "Position en Y"

L.MoveMe							= "Déplacez-moi"
L.Button_OK							= "OK"
L.Button_Cancel						= "Annuler"
L.Button_LoadMod					= "Charger le module"
L.Mod_Enabled						= "Activer ce module"
L.Mod_Reset							= "Charger les options par défaut"
L.Reset								= "Réinit."
L.Import							= "Importer"

L.Enable							= "Activer"
L.Disable							= "Désactiver"

L.NoSound							= "Pas de son"

L.IconsInUse						= "Icônes utilisées par ce module"

-- Tab: Boss Statistics
L.BossStatistics					= "Statistiques des boss"
L.Statistic_Kills					= "Victoires :"
L.Statistic_Wipes					= "Échecs :"
L.Statistic_Incompletes				= "Incomplets :"--For scenarios, TODO, figure out a clean way to replace any Statistic_Wipes with Statistic_Incompletes for scenario mods
L.Statistic_BestKill				= "Meilleur temps :"
L.Statistic_BestRank				= "Meilleur rang :"--Maybe not get used, not sure yet, localize anyways

-- Tab: General Options
L.TabCategory_Options				= "Options générales"
L.Area_BasicSetup					= "Aide à la configuration initiale de DBM"
L.Area_ModulesForYou				= "Quels modules DBM sont bons pour vous ?"
L.Area_ProfilesSetup				= "Guide d'utilisation des profiles DBM"
-- Panel: Core & GUI
L.Core_GUI							= "Core & Interface"
L.General							= "Options générales de DBM core"
L.EnableMiniMapIcon					= "Afficher l'icône de la minicarte"
L.UseSoundChannel					= "Configurer le canal audio utilisé par DBM pour jouer les sons d'alerte"
L.UseMasterChannel					= "Canal audio Principal"
L.UseDialogChannel					= "Canal audio Discussion"
L.UseSFXChannel						= "Canal audio Son (SFX)"
L.Latency_Text						= "Seuil de latence max. pour synchro: %d"

L.Button_RangeFrame					= "Afficher/cacher Cadre de portée"
L.Button_InfoFrame					= "Afficher/cacher Cadre d'infos"
L.Button_TestBars					= "Barres de test"
L.Button_MoveBars					= "Déplacer les barres"
L.Button_ResetInfoRange				= "Réinit. les cadres de portée et d'infos"

L.ModelOptions						= "Options du visualiseur de modèle 3D"
L.EnableModels						= "Activer les modèles 3D dans les options des boss"
L.ModelSoundOptions					= "Configurer le son pour le visualiseur 3D"
L.ModelSoundShort					= AUCTION_TIME_LEFT1 -- Short
L.ModelSoundLong					= AUCTION_TIME_LEFT3 -- Long

L.ResizeOptions						= "Options de redimensionnage"
L.ResizeInfo						= "Vous pouvez redimensionner l'interface en étirant le coin bas-droit"
L.Button_ResetWindowSize			= "Réinit. la taille de la fenêtre"
L.Editbox_WindowWidth				= "Largeur de la fenêtre"
L.Editbox_WindowHeight				= "Hauteur de la fenêtre"

L.UIGroupingOptions					= "Options d'interface partagées (requiert de recharger l'interface pour tout module qui serait déjà chargé)"
L.GroupOptionsBySpell				= "Options de modules regroupées par capacité (pour les modules compatibles)"
L.GroupOptionsExcludeIcon			= "Exclure l'option \"Définir l'icône sur\" du regroupement par capacité (elles seront regroupées dans la catégorie \"Icônes\" comme avant)"
L.AutoExpandSpellGroups				= "Déplier automatiquement les options liées à la même capacité"
--L.ShowSpellDescWhenExpanded	= "Continue showing spell description when groups are expanded"--Might not be used
L.NoDescription						= "Cette capacité n'a aucune description"

-- Panel: Extra Features
L.Panel_ExtraFeatures				= "Fonctionnalités supplémentaires"

L.Area_SoundAlerts					= "Options des alertes sonores/flash"
L.LFDEnhance						= "Faire clignoter le bouton de l'application et jouer le son d'Appel lors des vérif. de rôle &amp; des invitations (LFG,BG,etc) dans les canaux audio Principal ou Discussion (canaux généralement plus forts, fonctionnent même si le SFX est désactivé)"
L.WorldBossNearAlert				= "Faire clignoter le bouton de l'application et jouer le son d'Appel quand un World Boss proche de vous est engagé"
L.RLReadyCheckSound					= "Quand le chef de raid lance un Appel, jouer le son via les canaux audio Principal ou Discussion et faire clignoter le bouton de l'application"
L.AFKHealthWarning					= "Faire clignoter le bouton de l'application et jouer un son d'alerte si vous perdez de la vie alors que vous absent"
L.AutoReplySound					= "Faire clignoter le bouton de l'application et jouer un son d'alerte quand vous recevez une réponse DBM automatique par chuchotement"
--
L.TimerGeneral						= "Options des décompte"
L.SKT_Enabled						= "Décompte du record pour le combat actuel s'il est disponible"
L.ShowRespawn						= "Décompte de la réapparition du boss après un wipe"
L.ShowQueuePop						= "Décompte du temps restant pour accepter une invitation (LFG,BG,etc)"
--
--Auto Logging: Logging toggles/types
L.Area_AutoLogging					= "Options d'enregistrement auto"
L.AutologBosses						= "Enregistrement auto du combat contre un boss en utilisant le journal de combat de Blizzard"
L.AdvancedAutologBosses				= "Enregistrement auto du combat contre un boss en utilisant Transcriptor"
--Auto Logging: Global filter Options
L.Area_AutoLoggingFilters			= "Filtres d'enregistrement automatique"
L.RecordOnlyBosses					= "N'enregistrer que les boss et exclure tous les trash. Utilisez '/dbm pull' avant les boss pour prendre en compte les potions (pre pot) &amp; ENCOUNTER_START"
L.DoNotLogLFG						= "Ne pas enregistrer en LFG ou LFR (contenu en file d'attente)"
--Auto Logging: Recorded Content types
L.Area_AutoLoggingContent			= "Contenu d'enregistrement automatique"
L.LogCurrentMythicRaids				= "Raids mythiques de niveau actuel"--Retail Only
L.LogCurrentRaids					= "Raids non mythiques de niveau actuel (Héroïque, Normal et LFR si le filtre LFG/LFR est désactivé)"
L.LogTWRaids						= "Raids des Marcheurs du temps ou de Chromie"--Retail Only
L.LogTrivialRaids					= "Raids triviaux (en dessous du niveau du personnage)"
L.LogCurrentMPlus					= "Donjons M+ actuel"--Retail Only
L.LogCurrentMythicZero				= "Donjons Mythique 0 actuel"--Retail Only
L.LogTWDungeons						= "Donjons des Marcheurs du temps ou de Chromie"--Retail Only
L.LogCurrentHeroic					= "Donjons héroïques de niveau actuel (Note : si vous faites de l'héroïque via la file d'attente et que vous voulez que ce soit enregistré, désactivez le filtre LFG)"
L.LogCurrentNormal					= "Donjons normaux de niveau actuel (Remarque : si vous faites quelque chose d'héroïque via l'outil de recherche de raid et que vous souhaitez que cela soit enregistré, désactivez le filtre LFG)"
L.LogTrivialDungeons				= "Donjons triviaux (en dessous du niveau du personnage)"
--
L.Area_3rdParty						= "Options des Addons tiers"
L.oRA3AnnounceConsumables			= "Annoncer la vérification des consommables oRA3 au début du combat"
L.ShowBBOnCombatStart				= "Effectuer la vérification des buffs Big Brother au début du combat"
L.BigBrotherAnnounceToRaid			= "Annoncer les résultats de Big Brother au raid"
L.Area_Invite						= "Options des invitations"
L.AutoAcceptFriendInvite			= "Acceptation auto des invitations venant d'un ami"
L.AutoAcceptGuildInvite				= "Acceptation auto des invitations venant d'un membre de la guilde"
L.Area_Advanced						= "Options Avancées"
L.FakeBW							= "Prétendre utiliser BigWigs lors des vérifications de versions au lieu de DBM (utile pour les guildes qui forcent l'utilisation de BigWigs)"
L.AITimer							= "Utiliser un générateur automatique de décomptes pour les nouveaux combats en utilisant l'IA intégrée de DBM (utile pour engager les boss jamais vus sur la béta). Recommandé de toujours laisser cette option activée"
L.FixCLEUOnCombatStart				= "Effacer le cache du journal de combat à la fin du pull/combat et du changement de zone"

-- Panel: Profiles
L.Panel_Profile						= "Profils"
L.Area_CreateProfile				= "Créer un profil"
L.EnterProfileName					= "Entrer un nom pour le nouveau profil"
L.CreateProfile						= "Créer un nouveau profil"
L.Area_ApplyProfile					= "Définir le profil actif"
L.SelectProfileToApply				= "Sélection du profil à utiliser"
L.Area_CopyProfile					= "Copier un profil"
L.SelectProfileToCopy				= "Sélection du profil à copier"
L.Area_DeleteProfile				= "Supprimer un profil"
L.SelectProfileToDelete				= "Sélection du profil à supprimer"
L.Area_DualProfile					= "Options du profil"
L.DualProfile						= "Activer la gestion des options en fonction de la spécialisation (la gestion des profiles boss mod est faite à partir de la fenêtre des statistiques des boss mod chargés)"

L.Area_ModProfile					= "Copier les réglages depuis un autre perso/spé ou supprimer des réglages"
L.ModAllReset						= "Réinitialiser tous les réglages"
L.ModAllStatReset					= "Réinitialiser toutes les statistiques"
L.SelectModProfileCopy				= "Copier tous les réglages"
L.SelectModProfileCopySound			= "Copier les réglages sonores"
L.SelectModProfileCopyNote			= "Copier les réglages des notes"
L.SelectModProfileCurrent			= "Profil actuel de boss mod"
L.SelectModProfileDelete			= "Supprimer les réglages pour"

L.Area_ImportExportProfile	= "Importer/Exporter profils"
L.ImportExportInfo			= "Attention ! Importer un profil écrasera votre profil actuel"
L.ButtonImportProfile		= "Importer profil"
L.ButtonExportProfile		= "Exporter profil"
L.ProfileExportTitle		= "Voici votre profil actuel au format texte."
L.ProfileExportSubtitle	    = "Ctrl-C pour copier la config. dans votre presse-papier."
L.ProfileImportTitle		= "Collez ici un profil au format texte."
L.ProfileImportSubtitle	    = "Ctrl-V pour coller un texte de config de DBM."

L.ImportErrorOn						= "Son personnalisé manquant pour : %s"
L.ImportVoiceMissing				= "Pack de voix manquant : %s"

-- Tab: Alerts
L.TabCategory_Alerts				= "Alertes"
L.Area_SpecAnnounceConfig			= "Guide des effets visuels et sonores des Alertes spéciales"
L.Area_SpecAnnounceNotes			= "Guide des Notes des Alertes spéciales"
L.Area_VoicePackInfo				= "Information sur les Packs de voix DBM"
-- Panel: Raidwarning
L.Tab_RaidWarning					= "Alertes"
L.RaidWarning_Header				= "Options des alertes"
L.RaidWarnColors					= "Couleurs des alertes"
L.RaidWarnColor_1					= "Couleur 1"
L.RaidWarnColor_2					= "Couleur 2"
L.RaidWarnColor_3					= "Couleur 3"
L.RaidWarnColor_4					= "Couleur 4"
L.InfoRaidWarning					= [[Vous pouvez préciser la position et les couleurs de la fenêtre des alertes raid.
Cette fenêtre est utilisée pour les messages de type "Joueur X est affecté par Y".]]
L.ColorResetted						= "Les paramètres de couleur de ce champ ont été réinitialisés"
L.ShowWarningsInChat				= "Afficher les alertes dans la fenêtre de discussion"
L.ShowFakedRaidWarnings				= "Afficher les avertissements comme de faux messages d'alerte de raid"
L.WarningIconLeft					= "Afficher l'icône du côté gauche"
L.WarningIconRight					= "Afficher l'icône du côté droit"
L.WarningIconChat					= "Afficher les icônes dans la fenêtre de discussion"
L.WarningAlphabetical				= "Arranger les noms de manière alphabétique"
L.Warn_Duration						= "Durée de l'alerte: %0.1f sec"
L.None								= "Aucun"
L.Random							= "Aléatoire"
L.Outline							= "Contour fin"
L.ThickOutline						= "Contour épais"
L.MonochromeOutline					= "Contour monochrome"
L.MonochromeThickOutline			= "Contour monochrome épais"
L.RaidWarnSound						= "Jouer un son sur les alertes raid"

-- Panel: Spec Warn Frame
L.Panel_SpecWarnFrame				= "Alertes spéciales"
L.Area_SpecWarn						= "Options des spéciales"
L.SpecWarn_ClassColor				= "Utiliser la couleur des classes pour les alertes spéciales"
L.ShowSWarningsInChat				= "Afficher les alertes spéciales dans la fenêtre de discussion"
L.SWarnNameInNote					= "Utiliser les options de type 5 si une note d'alerte spéciale contient votre nom"
L.SpecialWarningIcon				= "Afficher les icônes sur les alertes spéciales"
L.ShortTextSpellname				= "Abréger le texte des noms des sorts (si possible)"
L.SpecWarn_FlashFrameRepeat			= "Clignoter %d fois"
L.SpecWarn_Flash					= "Clignotement écran"
L.SpecWarn_Vibrate					= "Vibrations manette"
L.SpecWarn_FlashRepeat				= "Répéter Clignotement"
L.SpecWarn_FlashColor				= "Couleur Clignotement %d"
L.SpecWarn_FlashDur					= "Durée Clignotement : %0.1f"
L.SpecWarn_FlashAlpha				= "Alpha Clignotement : %0.1f"
L.SpecWarn_DemoButton				= "Aff. un exemple"
L.SpecWarn_ResetMe					= "Réinit. les valeurs"
L.SpecialWarnSoundOption			= "Définir son par défaut"
L.SpecialWarnHeader1				= "Type 1: Définir les options pour les annonces de priorité normale vous affectant ou affectant vos actions"
L.SpecialWarnHeader2				= "Type 2: Définir les options pour les annonces de priorité normale affectant tout le monde"
L.SpecialWarnHeader3				= "Type 3: Définir les options pour les annonces de HAUTE priorité"
L.SpecialWarnHeader4				= "Type 4: Définir les options pour les annonces spéciales de fuite de HAUTE priorité"
L.SpecialWarnHeader5				= "Type 5: Définir les options pour les annonces dont la note contient votre nom de joueur"

-- Panel: Generalwarnings
L.Tab_GeneralMessages				= "Messages dans la fenêtre de discussion"
L.CoreMessages						= "Options des messages de DBM"
L.ShowPizzaMessage					= "Afficher les messages d'annonce de décomptes dans la fenêtre de discussion"
L.ShowAllVersions					= "Afficher les versions boss mod de tous les membres du groupe dans la fenêtre de discussion lors d'une vérification des versions. (Si désactivé, continu d'effectuer un résumé obsolète/à jour)"
L.ShowReminders						= "Afficher des messages de rappel pour les sous-modules manquants, désactivés, hotfixes, obsolètes, et mode silencieux étant toujours activé"

L.CombatMessages					= "Options des messages liés au combat"
L.ShowEngageMessage					= "Afficher les messages de pull du boss dans la fenêtre de discussion"
L.ShowDefeatMessage					= "Afficher les messages victoire/défaite dans la fenêtre de discussion"
L.ShowGuildMessages					= "Afficher les messages pull/victoire/défaite pour les groupes de la guilde dans la fenêtre de discussion"
L.ShowGuildMessagesPlus				= "Afficher aussi les messages pull/victoire/défaite pour les groupes Mythique+ de la guilde (requiert raid option)"

L.Area_ChatAlerts					= "Options des alertes supplémentaires"
L.RoleSpecAlert						= "Afficher une alerte lorsque vous rejoignez un raid et que votre préférence de butin ne correspond pas à votre spécialisation actuelle"
L.CheckGear							= "Afficher une alerte d'équipement pendant le pull (quand votre ilvl équipé est beaucoup plus bas que votre ilvl global (40+) ou que votre arme principale n'est pas équipée)"
L.WorldBossAlert					= "Afficher une alerte lorsqu'un world boss pourrait avoir été engagé sur votre royaume par votre guilde ou des amis (incorrect si l'info est reçue par inter-serveur)"
L.WorldBuffAlert					= "Afficher une alerte et un décompte lorsqu'un événement annonçant un world buff est détecté sur votre royaume"

L.Area_BugAlerts					= "Options des rapports de bugs"
L.BadTimerAlert						= "Afficher un message quand DBM détecte un décompte erroné avec au moins 1 seconde de différence"
L.BadIDAlert						= "Afficher un message quand DBM détecte une capacité ou entrée de journal erronée"

-- Panel: Spoken Alerts Frame
L.Panel_SpokenAlerts				= "Alertes vocales"
L.Area_VoiceSelection				= "Sélection des voix"
L.CountdownVoice					= "Voix principale pour les décomptes"
L.CountdownVoice2					= "Voix secondaire pour les décomptes"
L.CountdownVoice3					= "Voix tertiaire pour les décomptes"
L.PullVoice							= "Définir la voix pour les minuteurs de pull"
L.VoicePackChoice					= "Pack de voix des Alertes vocales"
L.MissingVoicePack					= "Pack de voix manquant (%s)"
L.Area_CountdownOptions				= "Options des décomptes"
L.Area_VoicePackReplace				= "Options de remplacement par le Pack de voix (quels sons seront remplacés par le Pack de voix)"
L.VPReplaceNote						= "Note: Les Packs de voix ne modifient ou suppriment jamais vos sons d'alertes.\nIls sont simplement mis en sourdine lorsqu'un Pack de voix les remplace."
L.ReplacesAnnounce					= "Remplacer les sons d'alerte (Note : Très peu d'utilisation pour les packs de voix, sauf pour les changements de phases et les adds)"
L.ReplacesSA1						= "Remplacer les sons d'alerte spéciale 1 (personnelle, càd 'pvpflag' qui ne sont pas des GTFO)"
L.ReplacesSA2						= "Remplacer les sons d'alerte spéciale 2 (tout le monde, càd 'beware')"
L.ReplacesSA3						= "Remplacer les sons d'alerte spéciale 3 (haute priorité, càd 'airhorn')"
L.ReplacesSA4						= "Remplacer les sons d'alerte spéciale 4 (haute priorité, fuyez)"
L.ReplacesGTFO						= "Remplacer les sons des alertes spéciales GTFO"
L.ReplacesCustom					= "Remplacer les sons d'alerte spéciale des réglages utilisateur personnalisés (par événement) (non recommandé)"
L.Area_VoicePackAdvOptions			= "Options avancées Packs de voix"
L.SpecWarn_AlwaysVoice				= "Toujours jouer toutes les alertes vocales même si l'Alerte spéciale est désactivée (peut être utile aux chefs de raid dans certaines situations, non recommandé autrement)"
L.VPDontMuteSounds					= "Désactiver la mise en sourdine des alertes standards lors de l'utilisation d'un pack de voix (à utiliser seulement si vous souhaitez entendre les DEUX types d'alertes sonores simultanément)"
L.Area_VPLearnMore					= "Apprenez-en plus sur les packs de voix et comment utiliser ces options"
L.VPLearnMore						= "|cFF73C2FBhttps://github.com/DeadlyBossMods/DBM-Retail/wiki/%5BGuide%5D-DBM-&-Voicepacks#2022-update|r"
L.Area_BrowseOtherVP				= "Trouvez d'autres packs de voix sur Curse"
L.BrowseOtherVPs					= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+voice|r"
L.Area_BrowseOtherCT				= "Trouvez d'autres packs de décompte sur Curse"
L.BrowseOtherCTs					= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+count+pack|r"

-- Panel: Event Sounds
L.Panel_EventSounds					= "Événements sonores"
L.Area_SoundSelection				= "Sélection du son (parcourez le menu de sélection avec la molette souris)"
L.EventVictorySound					= "Son pour les victoires"
L.EventWipeSound					= "Son pour les défaites"
L.EventEngagePT						= "Son pour le début du décompte avant pull"
L.EventEngageSound					= "Son pour le pull"
L.EventDungeonMusic					= "Musique jouée dans les donjons/raids"
L.EventEngageMusic					= "Musique jouée pendant les rencontres"
L.Area_EventSoundsExtras			= "Options des événements sonores"
L.EventMusicCombined				= "Autoriser tous les choix de musiques dans les sélections de donjons et de rencontres (changer cette option requiert de recharger l'interface)"
L.Area_EventSoundsFilters			= "Conditions des événements sonores"
L.EventFilterDungMythicMusic		= "Ne pas jouer de musique de donjon en difficulté Mythique/Mythique+"
L.EventFilterMythicMusic			= "Ne pas jouer de musique de rencontre en difficulté Mythique/Mythique+"

-- Tab: Timers
L.TabCategory_Timers				= "Barres"
L.Area_ColorBytype					= "Guide de coloration par type des barres"
-- Panel: Color by Type
L.Panel_ColorByType					= "Couleur par type"
L.AreaTitle_BarColors				= "Couleurs de barre par type de décompte"
L.BarTexture						= "Texture des barres"
L.BarStyle							= "Comportement des barres"
L.BarDBM							= "Classique (les petites barres existantes glissent vers l'ancrage élargi)"
L.BarSimple							= "Simple (la petite barre disparaît et une nouvelle grande barre est créée)"
L.BarStartColor						= "Couleur initiale"
L.BarEndColor						= "Couleur finale"
L.Bar_Height						= "Hauteur : %d"
L.Slider_BarOffSetX					= "Décalage X : %d"
L.Slider_BarOffSetY					= "Décalage Y : %d"
L.Slider_BarWidth					= "Largeur : %d"
L.Slider_BarScale					= "Échelle : %0.2f"
L.BarSaturation						= "Saturation pour les petits décomptes (si les grandes barres sont désactivées) : %0.2f"

--Types
L.BarStartColorAdd					= "Initiale\n(Add)"
L.BarEndColorAdd					= "Finale\n(Add)"
L.BarStartColorAOE					= "Initiale\n(AOE)"
L.BarEndColorAOE					= "Finale\n(AOE)"
L.BarStartColorDebuff				= "Initiale\n(Ciblé)"
L.BarEndColorDebuff					= "Finale\n(Ciblé)"
L.BarStartColorInterrupt			= "Initiale\n(Interruption)"
L.BarEndColorInterrupt				= "Finale\n(Interruption)"
L.BarStartColorRole					= "Initiale\n(Rôle)"
L.BarEndColorRole					= "Finale\n(Rôle)"
L.BarStartColorPhase				= "Initiale\n(Phase)"
L.BarEndColorPhase					= "Finale\n(Phase)"
L.BarStartColorUI					= "Initiale\n(Utilisateur)"
L.BarEndColorUI						= "Finale\n(Utilisateur)"
--Type 7 options
L.Bar7Header						= "Options de la barre utilisateur"
L.Bar7ForceLarge					= "Toujours utiliser une grande barre"
L.Bar7CustomInline					= "Utiliser l'icône intégrée personnalisée '!'"
--Dropdown Options
L.CBTGeneric						= "Générique"
L.CBTAdd							= "Add"
L.CBTAOE							= "AOE"
L.CBTTargeted						= "Ciblé"
L.CBTInterrupt						= "Interruption"
L.CBTRole							= "Rôle"
L.CBTPhase							= "Phase"
L.CBTImportant						= "Important (Utilisateur)"
L.CVoiceOne							= "Décompte vocal 1"
L.CVoiceTwo							= "Décompte vocal 2"
L.CVoiceThree						= "Décompte vocal 3"

-- Panel: Timers
L.Panel_Appearance					= "Apparence des barres"
L.Panel_Behavior					= "Comportement des barres"
L.AreaTitle_BarSetup				= "Options de l'apparence des barres"
L.AreaTitle_Behavior				= "Options du comportement des barres"
L.AreaTitle_BarSetupSmall			= "Options des petites barres"
L.AreaTitle_BarSetupHuge			= "Options des énormes barres"
L.AreaTitle_BarSetupVariance		= "Options des barres de variance"
L.EnableHugeBar						= "Activer les énormes barres (ou Barres 2)"
L.EnableVarianceBar 				= "Activer les barres de variance"
L.VarianceTransparency				= "Transparence des barres : %0.1f"
L.VarianceTimerTextBehavior			= "Définir le comportement du texte du minuteur de variance"
L.ZeroatWindowEnds					= "Le texte atteint zéro à la fin de la fenêtre de recharge"
L.ZeroatWindowStartPause			= "Le texte atteint zéro au début de la fenêtre de recharge et se met en pause"
L.ZeroatWindowStartRestart			= "Le texte atteint zéro au début de la fenêtre de recharge puis redémarre"
L.ZeroatWindowStartNeg				= "Le texte atteint zéro au début de la fenêtre de recharge puis devient négatif"--Default
L.BarIconLeft						= "Icône à gauche"
L.BarIconRight						= "Icône à droite"
L.ExpandUpwards						= "Étendre vers le haut"
L.FillUpBars						= "Remplir"
L.ClickThrough						= "Désactiver les interactions souris (clic au travers)"
L.Bar_Decimal						= "Afficher la décimale en dessous de : %d"
L.Bar_Alpha							= "Alpha : %0.1f"
L.Bar_EnlargeTime					= "Barres agrandies à partir de : %d"
L.BarSpark							= "Barre clignotante"
L.BarFlash							= "Faire clignoter les barres qui vont expirer"
L.BarSort							= "Trier par temps restant"
L.BarColorByType					= "Couleur par type"
L.Highest							= "Plus long en haut"
L.Lowest							= "Plus court en haut"
L.NoBarFade							= "Utiliser les couleurs de début/fin comme couleurs pour les petites/grandes barres au lieu d'un changement de couleur progressif"
L.BarInlineIcons					= "Icônes intégrées"
L.DisableRightClickBar				= "Désactiver le clic droit pour annuler les barres timer"
L.ShortTimerText					= "Texte de temps abrégé (si possible)"
L.StripTimerText					= "Désactiver les timers négatifs"
L.KeepBar							= "Maintenir les barres actives jusqu'à l'utilisation de la capacité"
L.KeepBar2							= "(quand supporté par le module)"
L.FadeBar							= "Disparition des barres pour les capacités hors de portée"
L.BarSkin							= "Apparence des barres"

-- Tab: HealthFrame
L.Panel_HPFrame						= "Cadre de vie"
L.Area_HPFrame						= "Options du cadre de vie"
L.HP_Enabled						= "Toujours montrer le cadre de vie (Remplace l'option spécifique au boss)"
L.HP_GrowUpwards					= "Étendre le cadre de vie vers le haut"
L.HP_ShowDemo						= "Montrer le cadre de vie"
L.BarWidth							= "Longueur de la barre: %d"

-- Tab: Global Disables & Filters
L.TabCategory_Filters				= "Désactivations globales & Filtres"
L.Area_DBMFiltersSetup				= "Guide des filtres DBM"
L.Area_BlizzFiltersSetup			= "Guide des filtres Blizzard"
-- Panel: Toggle DBM Features
L.Panel_SpamFilter					= "Fonctionnalités DBM"

L.Area_SpamFilter_SpecFeatures		= "Fonctionnalités d'annonce"
L.SpamBlockNoShowAnnounce			= "Ne pas afficher de texte ou jouer de son pour AUCUNE alerte générale (non accentuée)"
L.SpamBlockNoSpecWarnText			= "Ne pas afficher de texte pour les alertes spéciales"
L.SpamBlockNoSpecWarnFlash			= "Ne pas faire clignoter l'écran pour les alertes spéciales"
L.SpamBlockNoSpecWarnVibrate		= "Ne pas faire vibrer la manette pour les alertes spéciales"
L.SpamBlockNoSpecWarnSound			= "Ne pas jouer de son d'alerte spéciale (autorise les packs de voix, si l'un d'eux est sélectionné dans les options d'alertes vocales)"

L.Area_SpamFilter_Timers			= "Options de désactivation et de filtrage global des décomptes"
L.SpamBlockNoShowBossTimers			= "Ne pas afficher les décomptes pour les boss de donjon/raid"
L.SpamBlockNoShowTrashTimers		= "Ne pas afficher les décomptes pour les monstres de donjon/raid (Note : cela désactive également les CD des barres de vie)"
L.SpamBlockNoShowEventTimers		= "Ne pas afficher les décomptes pour les événements ou les invites (file d'attente, réapparition de boss, etc.)"
L.SpamBlockNoShowUTimers			= "Ne pas afficher les décomptes envoyés (Personnalisé/Pull/Pause)"
L.SpamBlockNoCountdowns				= "Ne pas jouer le son du compte à rebours"

L.Area_SpamFilter_Nameplates		= "Options de désactivation et de filtrage global des barres de vie"
L.SpamBlockNoNameplate				= "Ne pas afficher les auras sur les barres de vie"
L.SpamBlockNoBossGUIDs				= "Ne pas afficher les minuteurs du boss principal (boss1) sur les barres de vie Plater en tant qu'Auras de barre de vie\n(vous verrez toujours les minuteurs des monstres/adds du boss si la fonction est activée dans Plater)"
L.SpamBlockTimersWithNameplates		= "Ne pas afficher les barres de minuteur pour les modules de monstres si les Auras de barre de vie de Plater sont activées dans les options de Plater (ne s'applique pas aux combats de boss, qui afficheront toujours les barres de minuteur)"
L.NameplateFooter					= "Des fonctionnalités supplémentaires sont disponibles ici si Plater Nameplates est activé"

L.Area_SpamFilter_Misc				= "Options diverses de désactivation et de filtrage global"
L.SpamBlockNoSetIcon				= "Ne pas placer d'icônes sur les cibles"
L.SpamBlockNoRangeFrame				= "Ne pas afficher le cadre des portées"
L.SpamBlockNoInfoFrame				= "Ne pas afficher le cadre d'information"
L.SpamBlockNoHudMap					= "Ne pas afficher la HudMap"

L.SpamBlockNoYells					= "Ne pas envoyer de cris dans le chat"
L.SpamBlockNoNoteSync				= "Ne pas accepter les notes partagées"
L.SpamBlockAutoGossip				= "Ne pas gérer automatiquement les dialogues de commérage"

L.Area_Restore						= "Options de restauration DBM (Restaure la dernière utilisation de DBM ou non lors de la fin d'un module)"
L.SpamBlockNoIconRestore			= "Ne pas sauvegarder l'état des icônes et les restaurer en fin de combat"
L.SpamBlockNoRangeRestore			= "Ne pas restaurer le radar de portée quand les addons le cachent"

L.Area_PullTimer					= "Options du filtre des décomptes de pull, pause, combat, & personnalisé"
L.DontShowPTNoID					= "Bloquer les décomptes de pull envoyés depuis une zone différente de la vôtre (ne bloquera jamais les décomptes BigWigs envoyés sans ID de zone)"
L.DontShowPT						= "Ne pas afficher la barre de pull/pause"
L.DontShowPTText					= "Ne pas afficher le texte d'alerte du décompte de pull/pause"
L.DontShowPTCountdownText			= "Ne pas afficher le texte du décompte de pull"
L.DontPlayPTCountdown				= "Ne jouer aucun son de décompte de pull/pause/combat/perso"
L.PT_Threshold						= "Pas de son du décompte de pull/pause/combat/perso au delà de : %d"

L.Area_TimerTracker					= "Options de TimerTracker"
L.PlayTT							= "Activer le TimerTracker"
L.PlayTTCountdown					= "Jouer le son du compte à rebours TimerTracker"
L.PlayTTCountdownFinished			= "Jouer le son du compte à rebours TimerTracker terminé"

L.Area_BossBanner					= "Options de la bannière de boss"
L.EnableBB							= "Activer la bannière de boss"
L.PlayBBLoot						= "Jouer l'animation de la bannière de loot"
L.PlayBBSound						= "Jouer le son de la bannière de boss"
L.OverrideBBFont					= "Changer la police de la Bannière de boss (doit être activé pour changer la police)"

-- Panel: Reduce Information
L.Panel_ReducedInformation			= "Réduction d'informations"

L.Area_SpamFilter_Anounces			= "Filtres/Désescalade d'annonces"
L.SpamBlockNoShowTgtAnnounce		= "Ne pas afficher de texte ou jouer de son pour les annonces générales CIBLE qui ne vous affectent pas, sauf si l'avertissement spécifique ignore ce filtre (la désactivation globale dans les fonctionnalités DBM l'emporte sur celle-ci)"
L.SpamBlockNoTrivialSpecWarnSound	= "Ne pas jouer de son d'annonce spéciale ni faire clignoter l'écran pour le contenu bas-niveau (joue le son d'annonce par défaut sélectionné par l'utilisateur à la place)"

L.Area_SpamFilter					= "Options des filtres de spam"
L.DontShowFarWarnings				= "Ne pas afficher les annonces/décomptes pour les événements lointains"
L.StripServerName					= "Ne pas afficher le royaume sur les alertes et les décomptes"
L.FilterVoidFormSay					= "Ne pas envoyer de message d'icône ou de décompte sous $spell:47241 (les messages normaux seront toujours envoyés)"

L.Area_SpecFilter					= "Options de filtre par rôle"
L.FilterTankSpec					= "Filtrer les alertes réservées aux tanks si vous n'êtes pas en spé tank. (Note: Désactivation non recommandée car les alertes de taunt sont activées en permanence par défaut.)"
L.FilterInterruptsHeader			= "Filtrer les alertes de sorts interruptibles en fonction des préférences paramétrées."
L.SWFNever							= "Jamais"
L.FilterInterrupts					= "Si le lanceur n'est pas la cible/focus actuelle (Toujours)."
L.FilterInterrupts2					= "Si le lanceur n'est pas la cible/focus actuelle (Toujours) ou interruption en recharge (Boss seulement)"
L.FilterInterrupts3					= "Si le lanceur n'est pas la cible/focus actuelle (Toujours) ou interruption en recharge (Boss &amp; Trash)"
L.FilterInterruptNoteName			= "Filtrer les alertes des sorts interruptibles (avec compte) si l'alerte ne contient pas votre nom dans la note personnalisée"
L.FilterDispels						= "Filtrer les alertes de dissipations si votre sort de dissipation est en recharge"
L.FilterTrashWarnings				= "Filtrer toutes les annonces liées aux trash dans les donjons normaux, héroïques et triviaux (dépassés)"

L.Area_BInterruptFilter				= "Options de filtre d'interruption de boss"
L.FilterTargetFocus					= "Filtrer si le lanceur n'est pas la cible/le focus actuel"
L.FilterInterruptCooldown			= "Filtrer si le sort d'interruption est en temps de recharge"
L.FilterInterruptHealer				= "Filtrer si vous êtes dans une spécialisation de soigneur"
L.FilterInterruptNoteName			= "Filtrer si l'alerte a un compte mais que votre nom n'est pas dans la note personnalisée"--Only used on bosses, trash mods don't assign counts
L.Area_BInterruptFilterFooter		= "Si aucun filtre n'est sélectionné, toutes les interruptions sont affichées (Peut être envahissant)\nCertains modules peuvent ignorer entièrement ces filtres si le sort est d'une importance critique"
L.Area_TInterruptFilter				= "Options de filtre d'interruption des monstres"--Reuses above 3 strings

-- Panel: DBM Handholding
L.Panel_HandFilter					= "Réduire l'assistance DBM"
L.Area_SpamFilter_SpecRoleFilters	= "Filtres de type d'annonce spéciale (contrôle le niveau d'assistance de DBM)"
L.SpamSpecInformationalOnly			= "Supprime toutes les alertes spéciales écrites/orales indiquant une direction (Recharge de l'IU nécessaire). Les alertes seront toujours présentes (son/texte) mais n'indiqueront plus de directions."
L.SpamSpecRoleDispel				= "Filtrer entièrement les alertes 'dissipation' (Pas de texte ni de son)"
L.SpamSpecRoleInterrupt				= "Filtrer les alertes 'interruption' (Pas de texte ni de son)"
L.SpamSpecRoleDefensive				= "Filtrer les alertes 'défensive' (Pas de texte ni de son)"
L.SpamSpecRoleTaunt					= "Filtrer les alertes 'taunt' (Pas de texte ni de son)"
L.SpamSpecRoleSoak					= "Filtrer les alertes 'soak' (Pas de texte ni de son)"
L.SpamSpecRoleStack					= "Filtrer les alertes 'stack élevé' (Pas de texte ni de son)"
L.SpamSpecRoleSwitch				= "Filtrer les alertes 'changement de cible' &amp; 'adds' (Pas de texte ni de son)"
L.SpamSpecRoleGTFO					= "Filtrer les alertes 'sauvez-vous' (Pas de texte ni de son)"

-- Panel: Blizzard Features
L.Panel_HideBlizzard				= "Fonctionnalités Blizzard"
L.Area_HideBlizzard					= "Options de désactivation et de masquage Blizzard"
L.HideBossEmoteFrame				= "Masquer les emotes des boss pendant les combats de boss"
L.SpamBlockRaidWarning				= "Filtrer les annonces venant d'autres boss mods"
L.SpamBlockBossWhispers				= "Filtrer les alertes DBM chuchotement pendant les combats"
L.HideWatchFrame					= "Masquer le cadre de suivi (objectifs) pendant les combats de boss si aucun haut fait n'est suivi et si ce n'est pas en Mythique+"
L.HideGarrisonUpdates				= "Désactiver les notifications de fief pendant les combats de boss"
L.HideGuildChallengeUpdates			= "Désactiver les notifications de défis de guilde pendant les combats de boss"
L.HideQuestTooltips					= "Désactiver les objectifs de quête dans les info-bulles pendant les combats de boss"
L.HideTooltips						= "Masquer complètement les info-bulles pendant les combats de boss"
L.DisableSFX						= "Désactiver le canal audio des effets sonores pendant les combats de boss (Note: cette option rétabliera le canal audio Sons à la fin des combats même si ce dernier était désactivé avant le combat)"
L.DisableCinematics					= "Passer les cinématiques en jeu"
L.ReportRecount						= "Envoyer un rapport de Recount après la fin de la rencontre avec le boss (assistant raid requis)"
L.ReportSkada						= "Envoyer le rapport SkadaRevisited après la fin de la rencontre avec le boss (assistant raid requis)"
L.PerCharacterSettings				= "Utiliser des profils pour chaque personnage"
L.OnlyFight							= "Seulement pendant le combat, après que chaque cinématique ait été jouée une fois"
L.AfterFirst						= "En instance, après que chaque cinématique ait été jouée une fois"
L.CombatOnly						= "Désactiver en combat (tous)"
L.DisableWoE					    = "Ne jamais passer"
L.SkipWoE							= "Toujours passer"
L.RaidCombat						= "Désactiver en combat (boss seulement)"

-- Panel: Raid Leader Controls
L.Tab_RLControls					= "Contrôles chef de Raid"
L.Area_FeatureOverrides				= "Options de remplacement des fonctionnalités"
L.OverrideIcons 					= "Désactiver le marquage des icônes pour tous les membres du raid, y compris vous-même (Utilisez la substitution au lieu de la désactivation si vous souhaitez que DBM fasse le marquage selon vos conditions)"
L.OverrideSay						= "Désactiver les bulles de dialogues (/s, /y) pour tous les membres du raid, y compris vous-même"
L.DisableStatusWhisperShort			= "Désactiver les chuchotements d’état/réponse pour tout le groupe"
L.DisableGuildStatusShort			= "Désactiver la synchronisation des messages de progression vers la guilde pour tout le groupe"
--L.DisabledForDropdown				= "Choose boss mod(s) disable is sent to"--NYI
--L.DiabledForBoth					= "Disable above features for both DBM and BW"--NYI
--L.DiabledForDBM					= "Disable above features for only DBM users"--NYI
--L.DiabledForBW					= "Disable above features for only BW users"--NYI

L.Area_ConfigOverrides				= "Options de remplacement de configuration (Pas encore implémenté, à venir)"--NYI
L.OverrideBossAnnounceOptions		= "Appliquer ma configuration d'annonces de boss à tous les utilisateurs de DBM"--NYI
L.OverrideBossTimerOptions			= "Appliquer ma configuration de minuteurs de boss à tous les utilisateurs de DBM"--NYI
L.OverrideBossIconOptions			= "Appliquer ma configuration d'icônes de boss à tous les utilisateurs de DBM (si le paramètre d'icône est désactivé dans les options ci-dessus, cette option est ignorée)"--NYI
L.OverrideBossSayOptions			= "Appliquer ma configuration de bulles de discussion de boss à tous les utilisateurs de DBM (si le paramètre de bulle de discussion est désactivé dans les options ci-dessus, cette option est ignorée)"--NYI
L.ConfigAreaFooter					= "Les options de cette zone ne remplacent que temporairement la configuration des utilisateurs lors de l'engagement sans modifier leur configuration enregistrée."
L.ConfigAreaFooter2					= "Il est recommandé de prendre en compte tous les rôles et de ne pas exclure les minuteurs/alertes dont un tank, etc. pourrait avoir besoin"

L.Area_receivingOptions				= "Options de réception (Pas encore implémenté, à venir)"--NYI
L.NoAnnounceOverride				= "Ne pas accepter les remplacements d'annonces des chefs de raid."--NYI
L.NoTimerOverridee					= "Ne pas accepter les remplacements de minuteurs des chefs de raid."--NYI
L.ReplaceMyConfigOnOverride			= "AVERTISSEMENT : Remplacer de manière permanente mes configurations de module par celles du chef de raid, lors du remplacement"--NYI
L.ReceivingFooter					= "Les remplacements d'options d'icônes et de bulles de discussion ne peuvent pas être désactivés car ces paramètres affectent les autres joueurs autour de vous"--NYI
L.ReceivingFooter2					= "Si vous activez ces options, c'est entre vous et le RL si votre configuration entre en conflit avec leur intention"--NYI
L.ReceivingFooter3					= "Si vous activez 'remplacer ma configuration de module', vos paramètres d'origine seront perdus lors du remplacement"--NYI


L.TabFooter							= "Toutes les options de ce panneau ne fonctionnent que si vous êtes chef de groupe dans un groupe hors donjon/LFR"

-- Panel: Privacy
L.Tab_Privacy						= "Contrôles de confidentialité"
L.Area_WhisperMessages				= "Options des chuchotements"
L.AutoRespond						= "Répondre automatiquement aux chuchotements pendant les combats"
L.WhisperStats						= "Inclure les victoires/défaites dans les réponses"
L.DisableStatusWhisper				= "Désactiver les chuchotements de statut pour le groupe entier (requiert Chef de groupe). S'applique seulement aux raids normaux/héroïques/mythiques et aux donjons mythiques+."
L.Area_SyncMessages					= "Options de synchronisation des addons"
L.DisableGuildStatus				= "Empêcher les messages de progression de se synchroniser avec la guilde, si vous êtes chef de groupe, cela affectera tous les utilisateurs de DBM dans votre groupe"
L.EnableWBSharing					= "Partager quand vous engagez/battez un world boss avec votre guilde et vos amis battle.net qui sont sur le même royaume"

-- Tab: Frames & Integrations
L.TabCategory_Frames				= "Cadres & Intégrations"
L.Area_NamelateInfo					= "Infos sur les auras de barres de vie DBM"
-- Panel: InfoFrame
L.Panel_InfoFrame					= "Cadre d'infos"

-- Panel: Range
L.Panel_Range						= "Cadre de portée"

-- Panel: Nameplate
L.Panel_Nameplates					= "Barres de vie"
L.UseNameplateHandoff				= "Transférer les demandes d'aura de barre de vie aux addons de barres de vie pris en charge (KuiNameplates, Threat Plates, Plater) au lieu de les gérer en interne. C'est l'option recommandée car elle permet des fonctionnalités et une configuration plus avancées via l'addon de barre de vie"
L.Area_NPStyle						= "Style (Note : Ne configure le style que lorsque DBM gère les barres de vie.)"
L.NPAuraSize						= "Taille en pixels de l'aura (carré) : %d"

-- Misc
L.Area_General						= "Général"
L.Area_Position						= "Position"
L.Area_Style						= "Style"

L.FontSize							= "Taille de la police: %d"
L.FontStyle							= "Contours de la police"
L.FontColor							= "Couleur texte"
L.FontShadow						= "Ombre"
L.FontType							= "Choisir une police"

L.FontHeight	= 16

-- Retail Globals
L.LARGE	= "Grand"
L.SMALL	= "Petit"
L.PLAYER_DIFFICULTY6 = "Mythique" -- ID: 24525
L.PLAYER_DIFFICULTY_TIMEWALKER = "Marcheurs du temps" -- ID: 25846