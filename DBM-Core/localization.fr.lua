if GetLocale() ~= "frFR" then return end
if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

L.DEADLY_BOSS_MODS						= "Deadly Boss Mods" -- NO TRANSLATE
L.DBM									= "DBM" -- NO TRANSLATE

-- Canular du 1er Avril
local dateTable = date("*t")
if dateTable.day and dateTable.month and dateTable.day == 1 and dateTable.month == 4 then
	L.DEADLY_BOSS_MODS					= "Harmless Boss Mods"
	L.DBM								= "HBM"
end

L.HOW_TO_USE_MOD						= "Bienvenue sur " .. L.DBM .. ". Tapez /dbm help pour une liste des commandes supportées. Pour accéder aux options, tapez /dbm dans la fenêtre de discussion pour commencer la configuration. Chargez des zones spécifiques manuellement pour configurer tous les paramètres spécifiques aux boss selon vos envies. " .. L.DBM .. " essaiera de le faire pour vous en analysant votre spécialisation au premier lancement, mais nous savons que de toute façon certaines personnes souhaiteront activer d'autres options."
L.SILENT_REMINDER						= "Rappel : " .. L.DBM .. " est toujours en mode silencieux."
--L.NEWS_UPDATE							= "|h|c11ff1111News|r|h: This update is basically a re-release of 9.1.9 to clear a false malware detection on the hash of the previous file release. Read more about it |Hgarrmission:DBM:news|h|cff3588ff[here]|r|h"

L.COPY_URL_DIALOG_NEWS					= "Pour lire les dernières nouvelles, visitez le lien ci-dessous"

L.UPDATEREMINDER_URL					= "https://github.com/Wardool/DBM-Way-Of-Elendil/"

L.LOAD_MOD_ERROR						= "Erreur lors du chargement des modules de %s: %s"
L.LOAD_MOD_SUCCESS						= "Modules '%s' chargés. Pour plus d'options, comme des sons d'alertes personnalisés et des notes d'avertissement personnalisées, tapez /dbm."
--L.LOAD_MOD_COMBAT						= "Chargement de '%s' reporté jusqu'à la fin du combat"
L.LOAD_GUI_ERROR						= "Impossible de charger l'interface: %s"
--L.LOAD_GUI_COMBAT						= "L'interface ne peut pas se charger initialement en combat. Elle sera chargée après le combat. Une fois l'interface chargée, vous pourrez l'ouvrir en combat."
L.BAD_LOAD								= L.DBM .. " a détecté une erreur de chargement du module de l'instance car vous êtes en combat. Dès que vous sortez de combat veuillez entrer /console reloadui le plus vite possible."
L.LOAD_MOD_VER_MISMATCH					= "%s n'a pas pu être chargé car votre DBM-Core ne remplit pas les conditions. Il vous faut une version plus récente."
L.LOAD_MOD_EXP_MISMATCH					= "%s n'a pas pu être chargé car il est conçu pour une extension de WoW qui n'est pas actuellement disponible. Lorsque l'extension sera disponible, ce module fonctionnera automatiquement."
L.LOAD_MOD_TOC_MISMATCH					= "%s n'a pas pu être chargé car il est conçu pour une version de WoW (%s) qui n'est pas actuellement disponible. Lorsque le patch sera disponible, ce module fonctionnera automatiquement."
L.LOAD_MOD_DISABLED						= "%s est installé mais actuellement désactivé. Ce module ne sera pas chargé à moins que vous ne l'activiez."
L.LOAD_MOD_DISABLED_PLURAL				= "%s sont installés mais actuellement désactivés. Ces modules ne seront pas chargés à moins que vous ne les activiez."

L.COPY_URL_DIALOG						= "Copier l'URL"

L.NO_RANGE								= "Le radar de portée ne peut pas être utilisé dans les instances sans support de carte (téléchargez un patch de carte ou faites avec). Le cadre de portée texte hérité est utilisé à la place."
L.NO_ARROW								= "La flèche ne peut pas être utilisée dans les instances sans support de carte (téléchargez un patch de carte ou faites avec)."
L.NO_HUD								= "La HUDMap ne peut pas être utilisée dans les instances sans support de carte (téléchargez un patch de carte ou faites avec)."

--L.DYNAMIC_DIFFICULTY_CLUMP				= L.DBM .. " a désactivé la vérification du nombre de joueurs à portée sur ce combat pour cause de manque d'information sur le nombre de joueurs requis regroupés pour votre taille de raid."
--L.DYNAMIC_ADD_COUNT						= L.DBM .. " a désactivé les alertes de décompte d'adds en vie sur ce combat pour cause de manque d'information du nombre d'adds apparaissant pour votre taille de raid."
--L.DYNAMIC_MULTIPLE						= L.DBM .. " a désactivé plusieurs fonctionnalités sur ce combat pour cause de manque d'informations sur certains mécanismes pour votre taille de raid."

--L.LOOT_SPEC_REMINDER					= "Votre spécialisation actuelle est %s. Votre choix de butin actuel est %s."

L.BIGWIGS_ICON_CONFLICT					= L.DBM .. " a détecté que vous avez activé les icônes de raid dans BigWigs et " .. L.DBM .. ". Veuillez désactiver les icônes dans l'un des deux pour éviter les conflits."

L.MOD_AVAILABLE							= "%s est disponible pour cette zone. Vous pouvez le télécharger sur " .. L.UPDATEREMINDER_URL

L.COMBAT_STARTED						= "%s engagé. Bonne chance et amusez-vous bien ! :)"
L.COMBAT_STARTED_IN_PROGRESS			= "Vous êtes engagé dans un combat en cours contre %s. Bonne chance et amusez-vous bien ! :)"
L.GUILD_COMBAT_STARTED					= "%s a été engagé par le groupe de guilde de %s."
--L.SCENARIO_STARTED						= "%s a commencé. Bonne chance et amusez-vous bien ! :)"
--L.SCENARIO_STARTED_IN_PROGRESS			= "Vous avez rejoint %s, un scénario déjà en cours. Bonne chance et amusez-vous bien ! :)"
L.BOSS_DOWN								= "%s vaincu après %s !"
L.BOSS_DOWN_I							= "%s vaincu ! Vous avez %d victoires au total."
L.BOSS_DOWN_L							= "%s vaincu après %s ! Votre dernier temps était de %s et votre record de %s. Vous avez %d victoires au total."
L.BOSS_DOWN_NR							= "%s vaincu après %s ! C'est un nouveau record ! (L'ancien record était de %s). Vous avez %d victoires au total."
L.RAID_DOWN								= "%s terminé après %s !"
L.RAID_DOWN_L							= "%s terminé après %s ! Votre temps le plus rapide était de %s."
L.RAID_DOWN_NR							= "%s terminé après %s ! C'est un nouveau record ! (L'ancien record était de %s)."
L.GUILD_BOSS_DOWN						= "%s a été vaincu par le groupe de guilde de %s après %s !"
--L.SCENARIO_COMPLETE						= "%s terminé après %s !"
--L.SCENARIO_COMPLETE_I					= "%s terminé ! Vous avez %d réussites au total."
--L.SCENARIO_COMPLETE_L					= "%s terminé après %s ! Votre dernière réussite a pris %s et la plus rapide %s. Vous avez %d réussites au total."
--L.SCENARIO_COMPLETE_NR					= "%s terminé après %s ! C'est un nouveau record ! (L'ancien record était de %s). Vous avez %d réussites au total."
L.COMBAT_ENDED_AT						= "Combat face à %s (%s) terminé après %s."
L.COMBAT_ENDED_AT_LONG					= "Combat face à %s (%s) terminé après %s. Vous cumulez un total de %d wipe(s) dans cette difficulté."
L.GUILD_COMBAT_ENDED_AT					= "Le groupe de guilde de %s a wipe sur %s (%s) après %s."
--L.SCENARIO_ENDED_AT						= "%s terminé après %s."
--L.SCENARIO_ENDED_AT_LONG				= "%s terminé après %s. Vous avez %d échecs au total dans cette difficulté."
L.COMBAT_STATE_RECOVERED				= "%s a été engagé il y a %s, récupération des délais..."
L.TRANSCRIPTOR_LOG_START				= "Début du log de Transcriptor."
L.TRANSCRIPTOR_LOG_END					= "Fin du log de Transcriptor."

L.MOVIE_SKIPPED							= L.DBM .. " a tenté de passer une cinématique automatiquement."
--L.BONUS_SKIPPED 						= L.DBM .. " a automatiquement fermé la fenêtre de butin bonus. Si vous avez besoin de la récupérer, tapez /dbmbonusroll dans les 3 minutes."

L.AFK_WARNING							= "Vous êtes AFK et en combat (santé restante %d%%), alerte sonore déclenchée. Si vous n'êtes pas AFK, enlevez votre statut AFK ou désactivez cette option dans 'Fonctionnalités supplémentaires'."

L.COMBAT_STARTED_AI_TIMER				= "Mon CPU est un processeur à réseau neuronal ; un ordinateur qui apprend. (Ce combat utilisera la nouvelle fonctionnalité d'IA pour générer des timers approximatifs)"

L.PROFILE_NOT_FOUND						= "<"..L.DBM.."> Votre profil actuel est corrompu. " .. L.DBM .. " va charger le profil 'Default'."
L.PROFILE_CREATED						= "Profil '%s' créé."
L.PROFILE_CREATE_ERROR					= "Échec de la création du profil. Nom de profil invalide."
L.PROFILE_CREATE_ERROR_D				= "Échec de la création du profil. Le profil '%s' existe déjà."
L.PROFILE_APPLIED						= "Profil '%s' appliqué."
L.PROFILE_APPLY_ERROR					= "Échec de l'application du profil. Le profil '%s' n'existe pas."
L.PROFILE_COPIED						= "Profil '%s' copié."
L.PROFILE_COPY_ERROR					= "Échec de la copie du profil. Le profil '%s' n'existe pas."
L.PROFILE_COPY_ERROR_SELF				= "Impossible de copier un profil sur lui-même."
L.PROFILE_DELETED						= "Profil '%s' supprimé. Le profil 'Default' sera appliqué."
L.PROFILE_DELETE_ERROR					= "Échec de la suppression du profil. Le profil '%s' n'existe pas."
L.PROFILE_CANNOT_DELETE					= "Impossible de supprimer le profil 'Default'."
L.MPROFILE_COPY_SUCCESS					= "Les paramètres de module de %s (spé %d) ont été copiés."
L.MPROFILE_COPY_SELF_ERROR				= "Impossible de copier les paramètres du personnage sur lui-même."
L.MPROFILE_COPY_S_ERROR					= "La source est corrompue. Les paramètres n'ont pas été copiés ou seulement partiellement. La copie a échoué."
L.MPROFILE_COPYS_SUCCESS				= "Les paramètres de son ou de note du module de %s (spé %d) ont été copiés."
L.MPROFILE_COPYS_SELF_ERROR				= "Impossible de copier les paramètres de son ou de note du personnage sur eux-mêmes."
L.MPROFILE_COPYS_S_ERROR				= "La source est corrompue. Les paramètres de son ou de note n'ont pas été copiés ou seulement partiellement. La copie a échoué."
L.MPROFILE_DELETE_SUCCESS				= "Les paramètres de module de %s (spé %d) ont été supprimés."
L.MPROFILE_DELETE_SELF_ERROR			= "Impossible de supprimer les paramètres de module actuellement utilisés."
L.MPROFILE_DELETE_S_ERROR				= "La source est corrompue. Les paramètres n'ont pas été supprimés ou seulement partiellement. La suppression a échoué."

L.NOTE_SHARE_SUCCESS					= "%s a partagé sa note pour %s."
-- L.NOTE_SHARE_LINK						= "Cliquez ici pour ouvrir la note"
L.NOTE_SHARE_FAIL						= "%s a tenté de partager une note avec vous pour %s. Cependant, le module associé à cette capacité n'est pas installé ou chargé. Si vous avez besoin de cette note, assurez-vous de charger le module pour lequel ils partagent des notes et demandez-leur de la partager à nouveau."

L.NOTEHEADER							= "Entrez votre texte de note ici pour %s. Entourer le nom d'un joueur avec >< affichera la couleur de sa classe. Pour les alertes avec des décomptes multiples, séparez les notes par '/'."
L.NOTEFOOTER							= "Appuyez sur 'OK' pour accepter les changements ou 'Annuler' pour les refuser."
L.NOTESHAREDHEADER						= "%s a partagé la note ci-dessous pour %s. Si vous l'acceptez, elle écrasera votre note existante."
L.NOTESHARED							= "Votre note a été envoyée au groupe."
L.NOTESHAREERRORSOLO					= "Vous vous sentez seul(e) ? Vous ne devriez pas vous envoyer des notes à vous-même."
L.NOTESHAREERRORBLANK					= "Impossible de partager des notes vides."
L.NOTESHAREERRORGROUPFINDER				= "Les notes ne peuvent pas être partagées en BG, LFR ou LFG."
L.NOTESHAREERRORALREADYOPEN				= "Impossible d'ouvrir un lien de note partagée lorsque l'éditeur de note est déjà ouvert, pour vous empêcher de perdre la note que vous êtes en train de modifier."

L.ALLMOD_DEFAULT_LOADED					= "Les options par défaut pour tous les modules de cette instance ont été chargées."
L.ALLMOD_STATS_RESETED					= "Toutes les statistiques des modules ont été réinitialisées."
L.MOD_DEFAULT_LOADED					= "Les options par défaut pour ce combat ont été chargées."

L.WORLDBOSS_ENGAGED						= "%s a probablement été engagé sur votre royaume à %s%% de vie. (Envoyé par %s)"
L.WORLDBOSS_DEFEATED					= "%s a probablement été vaincu sur votre royaume (Envoyé par %s)."
L.WORLDBUFF_STARTED						= "Le buff %s a commencé sur votre royaume pour la faction %s (Envoyé par %s)."

L.TIMER_FORMAT_SECS						= "%.2f |4seconde:secondes;"
L.TIMER_FORMAT_MINS						= "%d |4minute:minutes;"
L.TIMER_FORMAT							= "%d |4minute:minutes; et %.2f |4seconde:secondes;"

L.MIN									= "min"
L.MIN_FMT								= "%d min"
L.SEC									= "sec"
L.SEC_FMT								= "%s sec"

L.GENERIC_WARNING_OTHERS				= "et un autre"
L.GENERIC_WARNING_OTHERS2				= "et %d autres"
L.GENERIC_WARNING_BERSERK				= "Enrage dans %s %s"
L.GENERIC_TIMER_BERSERK					= "Enrage"
L.OPTION_TIMER_BERSERK					= "Afficher le chrono pour $spell:26662"
L.GENERIC_TIMER_COMBAT					= "Début du combat"
L.OPTION_TIMER_COMBAT					= "Afficher le chrono pour le début du combat"
L.BAD									= "Mauvais"
L.OPTION_HEALTH_FRAME					= "Afficher la fenêtre de vie du Boss"

L.OPTION_CATEGORY_TIMERS				= "Barres"
L.OPTION_CATEGORY_WARNINGS				= "Annonces générales"
L.OPTION_CATEGORY_WARNINGS_YOU			= "Annonces personnelles"
L.OPTION_CATEGORY_WARNINGS_OTHER		= "Annonces de cible"
L.OPTION_CATEGORY_WARNINGS_ROLE			= "Annonces de rôle"
L.OPTION_CATEGORY_SPECWARNINGS			= "Annonces spéciales"

L.OPTION_CATEGORY_SOUNDS				= "Sons"
L.OPTION_CATEGORY_DROPDOWNS				= "Menus déroulants"
L.OPTION_CATEGORY_YELLS					= "Cris"
L.OPTION_CATEGORY_NAMEPLATES			= "Barres de nom"
L.OPTION_CATEGORY_ICONS					= "Icônes"

L.AUTO_RESPONDED						= "Répondu automatiquement."
L.STATUS_WHISPER						= "%s: %s, %d/%d personnes en vie"
L.AUTO_RESPOND_WHISPER					= "%s est occupé à combattre %s (%s, %d/%d personnes en vie)"
L.WHISPER_COMBAT_END_KILL				= "%s a vaincu %s !"
L.WHISPER_COMBAT_END_KILL_STATS			= "%s a vaincu %s ! Ils ont un total de %d victoires."
L.WHISPER_COMBAT_END_WIPE_AT			= "%s a wipe sur %s à %s."
L.WHISPER_COMBAT_END_WIPE_STATS_AT		= "%s a wipe sur %s à %s. Ils ont un total de %d wipes dans cette difficulté."
--L.AUTO_RESPOND_WHISPER_SCENARIO			= "%s est occupé dans %s (%d/%d personnes en vie)."
--L.WHISPER_SCENARIO_END_KILL				= "%s a terminé %s !"
--L.WHISPER_SCENARIO_END_KILL_STATS		= "%s a terminé %s ! Ils ont un total de %d victoires."
--L.WHISPER_SCENARIO_END_WIPE				= "%s n'a pas terminé %s."
--L.WHISPER_SCENARIO_END_WIPE_STATS		= "%s n'a pas terminé %s. Ils ont un total de %d échecs dans cette difficulté."

L.VERSIONCHECK_HEADER					= "Boss Mod - Versions"
L.VERSIONCHECK_ENTRY					= "%s: %s (%s) %s"
L.VERSIONCHECK_ENTRY_TWO				= "%s: %s (%s) & %s (%s)"
L.VERSIONCHECK_ENTRY_NO_DBM				= "%s: Aucun boss mod installé"
L.VERSIONCHECK_FOOTER					= "%d joueur(s) trouvé(s) avec " .. L.DBM .. " & %d joueur(s) avec Bigwigs."
L.VERSIONCHECK_OUTDATED					= "%d joueur(s) suivant(s) ont une version de boss mod obsolète : %s"
L.YOUR_VERSION_OUTDATED					= "Votre version de " .. L.DEADLY_BOSS_MODS .. " est obsolète. Veuillez visiter " .. L.UPDATEREMINDER_URL .. " pour obtenir la dernière version."
L.VOICE_PACK_OUTDATED					= "Le pack de voix " .. L.DBM .. " que vous avez sélectionné manque de certains sons supportés par " .. L.DBM .. ". Certains sons d'avertissement utiliseront les sons par défaut. Veuillez télécharger une version plus récente du pack de voix ou contacter son auteur pour une mise à jour qui contienne les sons manquants."
L.VOICE_MISSING							= "Vous avez sélectionné un pack de voix " .. L.DBM .. " qui n'a pas pu être trouvé. Si c'est une erreur, assurez-vous que votre pack de voix est correctement installé et activé dans les addons."
L.VOICE_DISABLED						= "Vous avez actuellement au moins un pack de voix " .. L.DBM .. " installé mais aucun n'est activé. Si vous avez l'intention d'utiliser un pack de voix, assurez-vous qu'il est choisi dans 'Alertes vocales', sinon désinstallez les packs de voix non utilisés pour masquer ce message."
L.VOICE_COUNT_MISSING					= "La voix de décompte %d est réglée sur un pack de voix/décompte qui n'a pas pu être trouvé. Elle a été réinitialisée au paramètre par défaut : %s."

L.UPDATEREMINDER_HEADER					= "Votre version de "..L.DEADLY_BOSS_MODS.." est obsolète.\n La version %s (%s) est disponible au téléchargement ici : " .. L.UPDATEREMINDER_URL
L.UPDATEREMINDER_FOOTER					= "Appuyez sur " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " pour copier le lien de téléchargement dans votre presse-papiers."
L.UPDATEREMINDER_FOOTER_GENERIC			= "Appuyez sur " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " pour copier le lien dans votre presse-papiers."
L.UPDATEREMINDER_DISABLE				= "AVERTISSEMENT : Votre version de " .. L.DEADLY_BOSS_MODS.. " étant obsolète et incompatible avec les versions plus récentes de DBM, elle a été désactivée de force et ne pourra pas être utilisée avant d'être mise à jour. Ceci afin de garantir que des modules incompatibles ne causent pas une mauvaise expérience de jeu pour vous ou les membres de votre groupe."
L.UPDATEREMINDER_DISABLETEST			= "AVERTISSEMENT : Votre version de " .. L.DEADLY_BOSS_MODS.. " étant obsolète et s'agissant d'un royaume de test/bêta, elle a été désactivée de force et ne pourra pas être utilisée avant d'être mise à jour. Ceci afin de garantir que des modules obsolètes ne sont pas utilisés pour générer des retours de test."
L.UPDATEREMINDER_HOTFIX					= "La version de ".. L.DBM.." que vous utilisez a des problèmes connus lors de ce combat de boss qui sont corrigés si vous mettez à jour vers la dernière version."
L.UPDATEREMINDER_HOTFIX_ALPHA			= "La version de ".. L.DBM.." que vous utilisez a des problèmes connus lors de ce combat de boss qui sont corrigés dans une prochaine version (ou la dernière version alpha)."
L.UPDATEREMINDER_MAJORPATCH				= "AVERTISSEMENT : Votre version de "..L.DEADLY_BOSS_MODS.." étant obsolète, "..L.DBM.." a été désactivé jusqu'à sa mise à jour, car il s'agit d'un patch de jeu majeur. Ceci afin de garantir que du code ancien et incompatible ne cause pas une mauvaise expérience de jeu pour vous ou les membres de votre groupe. Assurez-vous de télécharger une version plus récente depuis Curse, Wago, WoWI ou la page des versions de GitHub dès que possible."
L.UPDATE_REQUIRES_RELAUNCH				= "ATTENTION : Cette mise à jour de "..L.DBM.." ne fonctionnera pas correctement si vous ne redémarrez pas complètement votre client de jeu. Cette mise à jour contient de nouveaux fichiers ou des changements de fichier .toc qui ne peuvent pas être chargés via un /reload. Vous pourriez rencontrer des fonctionnalités défaillantes ou des erreurs si vous continuez sans redémarrer le client."
L.OUT_OF_DATE_NAG						= "Votre version de "..L.DBM.." est obsolète et ce module de combat spécifique a des fonctionnalités plus récentes ou des corrections de bugs. Il est recommandé de mettre à jour pour ce combat afin d'améliorer votre expérience."

L.MOVABLE_BAR							= "Déplacez-moi !"

L.PIZZA_SYNC_INFO						= "|Hplayer:%1$s|h[%1$s]|h vous a envoyé un timer "..L.DBM..": '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Annuler ce timer]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorer les timers de %1$s]|r|h"
L.PIZZA_CONFIRM_IGNORE					= "Voulez-vous vraiment ignorer les timers "..L.DBM.." de %s pour cette session ?"
L.PIZZA_ERROR_USAGE						= "Utilisation : /dbm [broadcast] timer <temps> <texte>"

L.MINIMAP_TOOLTIP_HEADER				= L.DEADLY_BOSS_MODS
L.MINIMAP_TOOLTIP_FOOTER				= "Glisser pour déplacer"

L.RANGECHECK_HEADER						= "Vérification de portée (%d m)"
L.RANGECHECK_HEADERT					= "Vérification de portée (%dm-%dP)"
L.RANGECHECK_RHEADER					= "Vérification de portée inversée (%dm)"
L.RANGECHECK_RHEADERT					= "Vérification de portée inversée (%dm-%dP)"
L.RANGECHECK_SETRANGE					= "Définir la portée"
L.RANGECHECK_SETTHRESHOLD				= "Définir le seuil de joueurs"
L.RANGECHECK_SOUNDS						= "Sons"
L.RANGECHECK_SOUND_OPTION_1				= "Son quand un joueur est à portée"
L.RANGECHECK_SOUND_OPTION_2				= "Son quand plus d'un joueur est à portée"
L.RANGECHECK_SOUND_0					= "Aucun son"
L.RANGECHECK_SOUND_1					= "Son par défaut"
L.RANGECHECK_SOUND_2					= "Bip agaçant"
L.RANGECHECK_SETRANGE_TO				= "%d m"
L.RANGECHECK_LOCK						= "Verrouiller le cadre"
L.RANGECHECK_OPTION_FRAMES				= "Cadres"
L.RANGECHECK_OPTION_RADAR				= "Afficher le cadre du radar"
L.RANGECHECK_OPTION_TEXT				= "Afficher le cadre textuel"
L.RANGECHECK_OPTION_BOTH				= "Afficher les deux cadres"
L.RANGECHECK_OPTION_SPEED				= "Taux de mise à jour (Rechargement requis)"
L.RANGECHECK_OPTION_SLOW				= "Lent (CPU le plus lent)"
L.RANGECHECK_OPTION_AVERAGE				= "Moyen"
L.RANGECHECK_OPTION_FAST				= "Rapide (le plus en temps réel)"
L.RANGERADAR_HEADER						= "Portée: %d m"
L.RANGERADAR_RHEADER					= "P-Inv:%d Joueurs:%d"
L.RANGERADAR_BOSS_HEADER				= "Portée boss (%d m)"
L.RANGERADAR_IN_RANGE_TEXT				= "%d à portée (%0.1f m)"
L.RANGECHECK_IN_RANGE_TEXT				= "%d à portée"
L.RANGERADAR_IN_RANGE_TEXTONE			= "%s (%0.1f m)"

L.LOCK_FRAME							= "Cadre verrouillé"
L.INFOFRAME_SHOW_SELF					= "Toujours afficher votre puissance"
L.INFOFRAME_SETLINES					= "Définir le nombre max de lignes"
L.INFOFRAME_SETCOLS						= "Définir le nombre max de colonnes"
L.INFOFRAME_LINESDEFAULT				= "Défini par le module"
L.INFOFRAME_LINES_TO					= "%d lignes"
L.INFOFRAME_COLS_TO						= "%d colonnes"
L.INFOFRAME_POWER						= "Puissance"
L.INFOFRAME_AGGRO						= "Aggro"
L.INFOFRAME_MAIN						= "Principale :"
L.INFOFRAME_ALT							= "Alt :"

L.LFG_INVITE							= "Invitation LFG"

L.SLASHCMD_HELP							= {
	"Commandes slash disponibles :",
	"-----------------",
	"/dbm unlock: Affiche une barre de statut de timer déplaçable (alias : move).",
	"/range <nombre> ou /distance <nombre>: Affiche le cadre de portée. /rrange ou /rdistance pour inverser les couleurs.",
	"/dbm timer: Lance un timer " .. L.DBM .. " personnalisé, voir '/dbm timer' pour les détails.",
	"/dbm arrow: Affiche la flèche " .. L.DBM .. ", voir '/dbm arrow help' pour les détails.",
	"/dbm help2: Affiche les commandes slash de gestion de raid."
}
L.SLASHCMD_HELP2						= {
	"Commandes slash disponibles :",
	"-----------------",
	"/dbm pull <sec>: Envoie un timer de pull de <sec> secondes au raid (requiert d'être promu, alias : pull).",
	"/dbm break <min>: Envoie un timer de pause de <min> minutes au raid (requiert d'être promu, alias : break).",
	"/dbm version: Effectue une vérification de version des boss mods (alias : ver).",
	"/dbm version2: Effectue une vérification de version des boss mods qui chuchote également aux utilisateurs obsolètes (alias : ver2).",
	"/dbm lockout: Demande aux membres du raid leurs verrouillages d'instance actuels (alias : lockouts, ids) (requiert d'être promu).",
	"/dbm lag: Effectue une vérification de latence à l'échelle du raid.",
	"/dbm durability: Effectue une vérification de durabilité à l'échelle du raid."
}
L.TIMER_USAGE							= {
	"Commandes de timer " .. L.DBM .. " :",
	"-----------------",
	"/dbm timer <sec> <texte>: Lance un timer de <sec> secondes avec votre <texte>.",
	"/dbm ltimer <sec> <texte>: Lance un timer qui tourne automatiquement en boucle jusqu'à son annulation.",
	"/dbm broadcast timer <x> <texte>: Diffuse un timer DBM de <x> secondes avec le nom <texte> au raid (requiert le statut de chef/promu).",
	"('broadcast' devant 'timer' ou 'ltimer' le partage également avec le raid si vous êtes chef/promu)",
	"/dbm timer endloop: Arrête tout ltimer en boucle.",
	"/dbm break <min>: Lance un timer de pause de <min> minutes. Donne à tous les membres du raid avec DBM un timer de pause (requiert le statut de chef/promu)."
}

L.ERROR_NO_PERMISSION					= "Vous n'avez pas la permission requise pour faire cela."
L.TIME_TOO_SHORT						= "Le timer de pull doit être supérieur à 3 secondes."

L.BOSSHEALTH_HIDE_FRAME					= "Fermer le cadre de vie"

L.BREAK_USAGE							= "Le timer de pause ne peut pas dépasser 60 minutes. Assurez-vous d'entrer le temps en minutes et non en secondes."
L.BREAK_START							= "La pause commence maintenant -- vous avez %s ! (Envoyé par %s)"
L.BREAK_MIN								= "La pause se termine dans %s minute(s) !"
L.BREAK_SEC								= "La pause se termine dans %s secondes !"
L.TIMER_BREAK							= "C'est la pause !"
L.ANNOUNCE_BREAK_OVER					= "La pause est terminée à %s"

L.TIMER_PULL							= "Pull dans"
L.ANNOUNCE_PULL_MODE					= "Mode de pull : %s"
L.ANNOUNCE_PULL							= "Pull dans %d sec. (Envoyé par %s)"
L.ANNOUNCE_PULL_NOW						= "Pull maintenant !"
L.ANNOUNCE_PULL_TARGET					= "Pull de %s dans %d sec. (Envoyé par %s)"
L.ANNOUNCE_PULL_NOW_TARGET				= "Pull de %s maintenant !"
L.GEAR_WARNING							= "Attention : Vérifiez votre équipement. Votre ilvl équipé est %d plus bas que l'ilvl de votre sac."
L.GEAR_WARNING_WEAPON					= "Attention : Vérifiez si votre arme est correctement équipée."
L.GEAR_FISHING_POLE						= "Canne à pêche"

L.ACHIEVEMENT_TIMER_SPEED_KILL			= "Kill rapide"

L.AUTO_ANNOUNCE_TEXTS = {
	you									= "%s sur VOUS",
	target								= "%s sur >%%s<",
	targetdistance						= "%s sur >%%s< (%%d m)",
	targetsource						= ">%%s< lance %s sur >%%s<",
	targetcount							= "%s (%%s) sur >%%s<",
	targetcountdistance					= "%s (%%s) sur >%%s< (%%d m)",
	spell								= "%s",
	incoming							= "Affaiblissement %s imminent",
	incomingcount						= "Affaiblissement %s imminent (%%s)",
	ends								= "%s terminé",
	endtarget							= "%s terminé : >%%s<",
	fades								= "%s dissipé",
	addsleft							= "%s restant : %%d",
	cast								= "Incantation de %s : %.1f sec",
	soon								= "%s imminent",
	sooncount							= "%s (%%s) imminent",
	countdown							= "%s dans %%d s",
	prewarn								= "%s dans %s",
	bait								= "%s imminent - appâtez maintenant",
	stage								= "Phase %s",
	prestage							= "Phase %s imminente",
	count								= "%s (%%s)",
	stack								= "%s sur >%%s< (%%d)",
	moveto								= "%s - allez sur >%%s<"
}

local prewarnOption						= "Afficher une pré-alerte pour $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS = {
	you									= "Annoncer quand $spell:%s est sur vous",
	target								= "Annoncer les cibles de $spell:%s",
	targetdistance						= "Annoncer les cibles de $spell:%s (avec la distance)",
	targetNF							= "Annoncer les cibles de $spell:%s (ignore le filtre de cible global)",
	targetsource						= "Annoncer les cibles de $spell:%s (avec la source)",
	targetcount							= "Annoncer les cibles de $spell:%s (avec décompte)",
	targetcountdistance					= "Annoncer les cibles de $spell:%s (avec décompte et distance)",
	spell								= "Annoncer quand $spell:%s a été lancé",
	incoming							= "Annoncer quand des affaiblissements de $spell:%s sont imminents",
	incomingcount						= "Annoncer (avec décompte) quand des affaiblissements de $spell:%s sont imminents",
	ends								= "Annoncer quand $spell:%s est terminé",
	endtarget							= "Annoncer quand $spell:%s est terminé (avec la cible)",
	fades								= "Annoncer quand $spell:%s est dissipé",
	addsleft							= "Annoncer combien de $spell:%s restent",
	cast								= "Annoncer quand $spell:%s commence à être incanté",
	soon								= prewarnOption,
	sooncount							= "Afficher une pré-alerte (avec décompte) pour $spell:%s",
	countdown							= "Afficher un spam de décompte pré-alerte pour $spell:%s",
	prewarn								= prewarnOption,
	bait								= "Afficher une pré-alerte (pour appâter) pour $spell:%s",
	stage								= "Annoncer la Phase %s",
	stagechange							= "Annoncer les changements de phase",
	prestage							= "Afficher une pré-alerte pour la Phase %s",
	count								= "Annoncer quand $spell:%s a été lancé (avec décompte)",
	stack								= "Annoncer les cumuls de $spell:%s",
	moveto								= "Annoncer quand se déplacer vers quelqu'un ou un endroit pour $spell:%s"
}

L.AUTO_SPEC_WARN_TEXTS = {
	spell								= "%s !",
	ends								= "%s terminé",
	fades								= "%s dissipé",
	soon								= "%s imminent",
	sooncount							= "%s (%%s) imminent",
	bait								= "%s imminent - appâtez maintenant",
	prewarn								= "%s dans %s",
	dispel								= "%s sur >%%s< - dissipez maintenant",
	interrupt							= "%s - interrompez >%%s< !",
	interruptcount						= "%s - interrompez >%%s< ! (%%d)",
	you									= "%s sur vous",
	youcount							= "%s (%%s) sur vous",
	youpos								= "%s (Position : %%s) sur vous",
	youposcount							= "%s (%%s) (Position : %%s) sur vous",
	soakpos								= "%s (Position d'absorption : %%s)",
	target								= "%s sur >%%s<",
	targetcount							= "%s (%%s) sur >%%s< ",
	defensive							= "%s - défensif",
	taunt								= "%s sur >%%s< - provoquez maintenant",
	close								= "%s sur >%%s< près de vous",
	move								= "%s - éloignez-vous",
	keepmove							= "%s - continuez à bouger",
	stopmove							= "%s - arrêtez de bouger",
	dodge								= "%s - esquivez l'attaque",
	dodgecount							= "%s (%%s) - esquivez l'attaque",
	dodgeloc							= "%s - esquivez depuis %%s",
	moveaway							= "%s - éloignez-vous des autres",
	moveawaycount						= "%s (%%s) - éloignez-vous des autres",
	moveto								= "%s - allez sur >%%s<",
	soak								= "%s - absorbez-le",
	soakcount							= "%s - absorbez %%s",
	jump								= "%s - sautez",
	run									= "%s - fuyez",
	runcount							= "%s - fuyez (%%s)",
	cast								= "%s - arrêtez d'incanter",
	lookaway							= "%s sur %%s - détournez le regard",
	reflect								= "%s sur >%%s< - arrêtez d'attaquer",
	count								= "%s ! (%%s)",
	stack								= "%%d charges de %s sur vous",
	switch								= "%s - changez de cible",
	switchcount							= "%s - changez de cible (%%s)",
	gtfo								= "Dégâts de %%s - éloignez-vous",
	adds								= "Adds imminents - changez de cible",
	addscount							= "Adds imminents - changez de cible (%%s)",
	addscustom							= "Adds imminents - %%s",
	targetchange						= "Changement de cible - passez à %%s"
}

L.AUTO_SPEC_WARN_OPTIONS = {
	spell								= "Afficher une annonce spéciale pour $spell:%s",
	ends								= "Afficher une annonce spéciale quand $spell:%s est terminé",
	fades								= "Afficher une annonce spéciale quand $spell:%s est dissipé",
	soon								= "Afficher une pré-annonce spéciale pour $spell:%s",
	sooncount							= "Afficher une pré-annonce spéciale (avec décompte) pour $spell:%s",
	bait								= "Afficher une pré-annonce spéciale (pour appâter) pour $spell:%s",
	prewarn								= "Afficher une pré-annonce spéciale %s secondes avant $spell:%s",
	dispel								= "Afficher une annonce spéciale pour dissiper/voler $spell:%s",
	interrupt							= "Afficher une annonce spéciale pour interrompre $spell:%s",
	interruptcount						= "Afficher une annonce spéciale (avec décompte) pour interrompre $spell:%s",
	you									= "Afficher une annonce spéciale lorsque vous êtes affecté par $spell:%s",
	youcount							= "Afficher une annonce spéciale (avec décompte) lorsque vous êtes affecté par $spell:%s",
	youpos								= "Afficher une annonce spéciale (avec position) lorsque vous êtes affecté par $spell:%s",
	youposcount							= "Afficher une annonce spéciale (avec position et décompte) lorsque vous êtes affecté par $spell:%s",
	soakpos								= "Afficher une annonce spéciale (avec position) pour aider à absorber les autres affectés par $spell:%s",
	target								= "Afficher une annonce spéciale quand quelqu'un est affecté par $spell:%s",
	targetcount							= "Afficher une annonce spéciale (avec décompte) quand quelqu'un est affecté par $spell:%s",
	defensive							= "Afficher une annonce spéciale pour utiliser des capacités défensives pour $spell:%s",
	taunt								= "Afficher une annonce spéciale pour provoquer quand l'autre tank est affecté par $spell:%s",
	close								= "Afficher une annonce spéciale quand quelqu'un près de vous est affecté par $spell:%s",
	move								= "Afficher une annonce spéciale pour sortir de $spell:%s",
	keepmove							= "Afficher une annonce spéciale pour continuer à bouger pour $spell:%s",
	stopmove							= "Afficher une annonce spéciale pour arrêter de bouger pour $spell:%s",
	dodge								= "Afficher une annonce spéciale pour esquiver $spell:%s",
	dodgecount							= "Afficher une annonce spéciale (avec décompte) pour esquiver $spell:%s",
	dodgeloc							= "Afficher une annonce spéciale (avec emplacement) pour esquiver $spell:%s",
	moveaway							= "Afficher une annonce spéciale pour s'éloigner des autres pour $spell:%s",
	moveawaycount						= "Afficher une annonce spéciale (avec décompte) pour s'éloigner des autres pour $spell:%s",
	moveto								= "Afficher une annonce spéciale pour se déplacer vers quelqu'un ou un endroit pour $spell:%s",
	soak								= "Afficher une annonce spéciale pour absorber $spell:%s",
	soakcount							= "Afficher une annonce spéciale (avec décompte) pour absorber $spell:%s",
	jump								= "Afficher une annonce spéciale pour sauter pour $spell:%s",
	run									= "Afficher une annonce spéciale pour fuir $spell:%s",
	runcount							= "Afficher une annonce spéciale (avec décompte) pour fuir $spell:%s",
	cast								= "Afficher une annonce spéciale pour arrêter d'incanter pour $spell:%s",
	lookaway							= "Afficher une annonce spéciale pour détourner le regard pour $spell:%s",
	reflect								= "Afficher une annonce spéciale pour arrêter d'attaquer $spell:%s",
	count								= "Afficher une annonce spéciale (avec décompte) pour $spell:%s",
	stack								= "Afficher une annonce spéciale lorsque vous avez >=%d charges de $spell:%s",
	switch								= "Afficher une annonce spéciale pour changer de cible pour $spell:%s",
	switchcount							= "Afficher une annonce spéciale (avec décompte) pour changer de cible pour $spell:%s",
	gtfo								= "Afficher une annonce spéciale pour sortir des zones de dégâts au sol",
	adds								= "Afficher une annonce spéciale pour changer de cible pour les adds imminents",
	addscount							= "Afficher une annonce spéciale (avec décompte) pour changer de cible pour les adds imminents",
	addscustom							= "Afficher une annonce spéciale pour les adds imminents",
	targetchange						= "Afficher une annonce spéciale pour les changements de cible prioritaires"
}

L.AUTO_TIMER_TEXTS = {
	target								= "%s : %%s",
	targetcount							= "%s (%%2$s) : %%1$s",
	cast								= "%s",
	castshort							= "%s ",
	castcount							= "%s (%%s)",
	castcountshort						= "%s (%%s) ",
	castsource							= "%s : %%s",
	castsourceshort						= "%s : %%s ",
	active								= "%s se termine",
	fades								= "%s se dissipe",
	ai									= "IA de %s",

	cd									= "Rech. %s",
	cdshort								= "~%s",
	cdcount								= "Rech. %s (%%s)",
	cdcountshort						= "~%s (%%s)",
	cdsource							= "Rech. %s : >%%s<",
	cdsourceshort						= "~%s : >%%s<",
	cdspecial							= "Rech. Spécial",
	cdspecialshort						= "~Spécial",

	next								= "Proch. %s",
	nextshort							= "%s",
	nextcount							= "Proch. %s (%%s)",
	nextcountshort						= "%s (%%s)",
	nextsource							= "Proch. %s : %%s",
	nextsourceshort						= "%s : %%s",
	nextspecial							= "Proch. Spécial",
	nextspecialshort					= "Spécial",

	var									= "%s",
	varcount							= "%s (%%s)",
	varsource							= "%s : >%%s<",
	varspecial							= "Spécial",
	varcombo							= "%%1$s + %%2$s",

	achievement							= "%s",
	stage								= "Phase Suivante",
	stageshort							= "Phase",
	adds								= "Adds imminents",
	addsshort							= "Adds",
	addscustom							= "Adds imminents (%%s)",
	addscustomshort						= "Adds (%%s)",
	roleplay							= "Jeu de rôle"
}
L.AUTO_TIMER_TEXTS.cdnp					= L.AUTO_TIMER_TEXTS.cd
L.AUTO_TIMER_TEXTS.nextnp				= L.AUTO_TIMER_TEXTS.next
L.AUTO_TIMER_TEXTS.cdcountnp			= L.AUTO_TIMER_TEXTS.cdcount
L.AUTO_TIMER_TEXTS.nextcountnp			= L.AUTO_TIMER_TEXTS.nextcount

L.AUTO_TIMER_OPTIONS = {
	target								= "Afficher le timer pour l'affaiblissement $spell:%s (%ss)",
	targetcount							= "Afficher le timer (avec décompte) pour l'affaiblissement $spell:%s (%ss)",
	cast								= "Afficher le timer pour l'incantation de $spell:%s (%ss)",
	castcount							= "Afficher le timer (avec décompte) pour l'incantation de $spell:%s (%ss)",
	castsource							= "Afficher le timer (avec source) pour l'incantation de $spell:%s (%ss)",
	active								= "Afficher le timer pour la durée de $spell:%s (%ss)",
	fades								= "Afficher le timer pour la dissipation de $spell:%s sur les joueurs (%ss)",
	ai									= "Afficher le timer IA pour le temps de recharge de $spell:%s (%ss)",

	cd									= "Afficher le timer pour le temps de recharge de $spell:%s (%ss)",
	cdcount								= "Afficher le timer pour le temps de recharge de $spell:%s (%ss)",
	cdnp								= "Afficher le timer uniquement sur la barre de nom pour le temps de recharge de $spell:%s (%ss)",
	cdnpcount							= "Afficher le timer uniquement sur la barre de nom (avec décompte) pour le temps de recharge de $spell:%s (%ss)",
	cdsource							= "Afficher le timer (avec source) pour le temps de recharge de $spell:%s (%ss)",
	cdspecial							= "Afficher le timer pour le temps de recharge de la capacité spéciale (%ss)",

	next								= "Afficher le timer pour le prochain $spell:%s (%ss)",
	nextcount							= "Afficher le timer pour le prochain $spell:%s (%ss)",
	nextnp								= "Afficher le timer uniquement sur la barre de nom pour le prochain $spell:%s (%ss)",
	nextnpcount							= "Afficher le timer uniquement sur la barre de nom (avec décompte) pour le prochain $spell:%s (%ss)",
	nextsource							= "Afficher le timer (avec source) pour le prochain $spell:%s (%ss)",
	nextspecial							= "Afficher le timer pour la prochaine capacité spéciale (%ss)",

	var									= "Afficher le timer (avec variation) pour la fenêtre de recharge de $spell:%s (%ss)",
	varcount							= "Afficher le timer (avec décompte et variation) pour la fenêtre de recharge de $spell:%s (%ss)",
	varnp								= "Afficher le timer uniquement sur la barre de nom (avec variation) pour la fenêtre de recharge de $spell:%s (%ss)",
	varpnp								= "Afficher le timer prioritaire uniquement sur la barre de nom (avec variation) pour la fenêtre de recharge de $spell:%s (%ss)",
	varsource							= "Afficher le timer (avec source et variation) pour la fenêtre de recharge de $spell:%s (%ss)",
	varspecial							= "Afficher le timer (avec variation) pour la fenêtre de recharge de la capacité spéciale (%ss)",
	varcombo							= "Afficher le timer (avec variation) pour la fenêtre de recharge du combo de capacités (%ss)",

	achievement							= "Afficher le timer pour %s (%ss)",
	stage								= "Afficher le timer pour la phase suivante (%ss)",
	adds								= "Afficher le timer pour les adds imminents (%ss)",
	addscustom							= "Afficher le timer pour les adds imminents (%ss)",
	roleplay							= "Afficher le timer pour la durée du jeu de rôle (%ss)"
}

L.AUTO_ICONS_OPTION_TARGETS				= "Placer des icônes sur les cibles de $spell:%s"
L.AUTO_ICONS_OPTION_TARGETS_TANK_A		= "Placer des icônes sur les cibles de $spell:%s avec priorité tank > mêlée > distant et repli alphabétique"
L.AUTO_ICONS_OPTION_TARGETS_TANK_R		= "Placer des icônes sur les cibles de $spell:%s avec priorité tank > mêlée > distant et repli sur la liste de raid"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_A		= "Placer des icônes sur les cibles de $spell:%s avec priorité mêlée et alphabétique"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_R		= "Placer des icônes sur les cibles de $spell:%s avec priorité mêlée et liste de raid"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_A	= "Placer des icônes sur les cibles de $spell:%s avec priorité distant et alphabétique"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_R	= "Placer des icônes sur les cibles de $spell:%s avec priorité distant et liste de raid"
L.AUTO_ICONS_OPTION_TARGETS_ALPHA		= "Placer des icônes sur les cibles de $spell:%s avec priorité alphabétique"
L.AUTO_ICONS_OPTION_TARGETS_ROSTER		= "Placer des icônes sur les cibles de $spell:%s avec priorité sur la liste de raid"
L.AUTO_ICONS_OPTION_NPCS				= "Placer des icônes sur $spell:%s"
L.AUTO_ICONS_OPTION_CONFLICT			= " (Peut entrer en conflit avec d'autres options)"
L.AUTO_ARROW_OPTION_TEXT				= "Afficher la flèche " .. L.DBM .. " pour se diriger vers la cible affectée par $spell:%s"
L.AUTO_ARROW_OPTION_TEXT2				= "Afficher la flèche " .. L.DBM .. " pour s'éloigner de la cible affectée par $spell:%s"
L.AUTO_ARROW_OPTION_TEXT3				= "Afficher la flèche " .. L.DBM .. " pour se diriger vers un emplacement spécifique pour $spell:%s"
L.AUTO_YELL_OPTION_TEXT = {
	shortyell							= "Crier quand vous êtes affecté par $spell:%s",
	yell								= "Crier (avec le nom du joueur) quand vous êtes affecté par $spell:%s",
	yellme								= "Crier quand vous êtes affecté par $spell:%s",
	count								= "Crier (avec décompte) quand vous êtes affecté par $spell:%s",
	fade								= "Crier (avec décompte et nom du sort) quand $spell:%s se dissipe",
	shortfade							= "Crier (avec décompte) quand $spell:%s se dissipe",
	iconfade							= "Crier (avec décompte et icône) quand $spell:%s se dissipe",
	position							= "Crier (avec position et nom du joueur) quand vous êtes affecté par $spell:%s",
	shortposition						= "Crier (avec position) quand vous êtes affecté par $spell:%s",
	combo								= "Crier (avec texte personnalisé) quand vous êtes affecté par $spell:%s et d'autres sorts en même temps",
	repeatplayer						= "Crier de manière répétée (avec nom du joueur) quand vous êtes affecté par $spell:%s",
	repeaticon							= "Crier de manière répétée (avec icône) quand vous êtes affecté par $spell:%s"
}
L.AUTO_YELL_ANNOUNCE_TEXT = {
	shortyell							= "%s",
	yell								= "%s sur " .. UnitName("player") .. "!",
	yellme								= "%s sur moi !",
	count								= "%s sur " .. UnitName("player") .. "! (%%d)",
	fade								= "%s se dissipe dans %%d",
	shortfade							= "%%d",
	iconfade							= "{rt%%2$d}%%1$d",
	--position							= "%s %%s sur {rt%%d}" ..UnitName("player").. "{rt%%d}",
	shortposition						= "{rt%%1$d}%s %%2$d",--Icon, Spellname, number
	combo								= "%s et %%s",--Spell name (from option, plus spellname given in arg)
	--repeatplayer						= UnitName("player"),
	repeaticon							= "{rt%%1$d}"
}
L.AUTO_YELL_CUSTOM_POSITION				= "{rt%d}%s"
L.AUTO_YELL_CUSTOM_POSITION2			= "{rt%d}%s{rt%d}"
L.AUTO_YELL_CUSTOM_FADE					= "%s dissipé"
L.AUTO_HUD_OPTION_TEXT					= "Afficher la HudMap pour $spell:%s (Retiré)"
L.AUTO_HUD_OPTION_TEXT_MULTI			= "Afficher la HudMap pour diverses mécaniques (Retiré)"
L.AUTO_NAMEPLATE_OPTION_TEXT			= "Afficher les auras de barre de nom pour $spell:%s en utilisant un addon de barre de nom compatible ou "..L.DBM
L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED		= "Afficher les auras de barre de nom pour $spell:%s en utilisant uniquement "..L.DBM
L.AUTO_RANGE_OPTION_TEXT				= "Afficher le cadre de portée (%s) pour $spell:%s"
L.AUTO_RANGE_OPTION_TEXT_SHORT			= "Afficher le cadre de portée (%s)"
L.AUTO_RRANGE_OPTION_TEXT				= "Afficher le cadre de portée inversé (%s) pour $spell:%s"
L.AUTO_RRANGE_OPTION_TEXT_SHORT			= "Afficher le cadre de portée inversé (%s)"
L.AUTO_INFO_FRAME_OPTION_TEXT			= "Afficher le cadre d'info pour $spell:%s"
L.AUTO_INFO_FRAME_OPTION_TEXT2			= "Afficher le cadre d'info pour l'aperçu du combat"
L.AUTO_INFO_FRAME_OPTION_TEXT3			= "Afficher le cadre d'info pour $spell:%s (quand le seuil de %%s est atteint)"
L.AUTO_READY_CHECK_OPTION_TEXT			= "Jouer le son du ready check lorsque le boss est engagé (même s'il n'est pas ciblé)"
L.AUTO_SPEEDCLEAR_OPTION_TEXT			= "Afficher le timer pour le clean le plus rapide de %s"
L.AUTO_PRIVATEAURA_OPTION_TEXT			= "Jouer les alertes sonores DBM pour les auras privées de $spell:%s sur ce combat. Priorité sonore : pack de voix si disponible, sinon sirène."

L.AUTO_SOUND_OPTION_TEXT				= "Jouer un son pour $spell:%d"
L.AUTO_SOUND_OPTION_TEXT5				= "Décompte audio de 5 secondes pour $spell:%d"
L.AUTO_SOUND_OPTION_TEXT3				= "Décompte audio de 3 secondes pour $spell:%d"
L.AUTO_SOUND_OPTION_TEXT_YOU			= "Jouer un son pour $spell:%d sur vous"
L.AUTO_SOUND_OPTION_TEXT_SOON			= "Jouer un son pour $spell:%d imminent"
L.AUTO_SOUND_OPTION_TEXT_CLOSE			= "Jouer un son pour $spell:%d près de vous"

L.MOVE_WARNING_BAR						= "Annonce déplaçable"
L.MOVE_WARNING_MESSAGE					= "Merci d'utiliser "..L.DEADLY_BOSS_MODS..""
L.MOVE_SPECIAL_WARNING_BAR				= "Avertissement spécial déplaçable"
L.MOVE_SPECIAL_WARNING_TEXT				= "Avertissement Spécial"

L.ARROW_MOVABLE							= "Flèche déplaçable"
L.ARROW_WAY_USAGE						= "/dway <x> <y>: Crée une flèche qui pointe vers un emplacement spécifique (en utilisant les coordonnées de la carte de la zone locale)"
L.ARROW_WAY_SUCCESS						= "Pour masquer la flèche, faites '/dbm arrow hide' ou atteignez la flèche."
L.ARROW_ERROR_USAGE						= {
	"Utilisation de "..L.DBM.."-Arrow:",
	"-----------------",
	"/dbm arrow <x> <y>: Crée une flèche qui pointe vers un emplacement spécifique (en utilisant les coordonnées mondiales)",
	"/dbm arrow map <x> <y>: Crée une flèche qui pointe vers un emplacement spécifique (en utilisant les coordonnées de la carte de la zone)",
	"/dbm arrow <joueur>: Crée une flèche qui pointe vers un joueur spécifique de votre groupe ou raid (sensible à la casse !)",
	"/dbm arrow hide: Masque la flèche",
	"/dbm arrow move: Rend la flèche déplaçable"
}

L.SPEED_KILL_TIMER_TEXT					= "Record à battre"
L.SPEED_CLEAR_TIMER_TEXT				= "Meilleur clean"
L.TIMER_RESPAWN							= "Réapparition de %s"

L.REQ_INSTANCE_ID_PERMISSION			= "%s a demandé à voir vos IDs d'instance et votre progression actuels.\nVoulez-vous envoyer ces informations à %s ? Il ou elle pourra demander ces informations pendant votre session actuelle (c'est-à-dire jusqu'à ce que vous vous reconnectiez)."
L.ERROR_NO_RAID							= "Vous devez être dans un groupe de raid pour utiliser cette fonctionnalité."
L.INSTANCE_INFO_REQUESTED				= "Demande d'informations sur le verrouillage du raid envoyée au groupe de raid.\nVeuillez noter que les utilisateurs devront donner leur permission avant de vous envoyer les données, cela peut donc prendre une minute avant que nous recevions toutes les réponses."
L.INSTANCE_INFO_STATUS_UPDATE			= "Réponses reçues de %d joueurs sur %d utilisateurs de DBM : %d ont envoyé les données, %d ont refusé la demande. En attente de réponses pendant encore %d secondes..."
L.INSTANCE_INFO_ALL_RESPONSES			= "Réponses reçues de tous les membres du raid."
L.INSTANCE_INFO_DETAIL_DEBUG			= "Expéditeur : %s Type de résultat : %s Nom de l'instance : %s ID de l'instance : %s Difficulté : %d Taille : %d Progression : %s"
L.INSTANCE_INFO_DETAIL_HEADER			= "%s, difficulté %s :"
L.INSTANCE_INFO_DETAIL_INSTANCE			= "    ID %s, progression %d : %s"
L.INSTANCE_INFO_DETAIL_INSTANCE2		= "    Progression %d : %s"
L.INSTANCE_INFO_NOLOCKOUT				= "Il n'y a aucune information de verrouillage de raid dans votre groupe de raid."
L.INSTANCE_INFO_STATS_DENIED			= "Demande refusée : %s"
L.INSTANCE_INFO_STATS_AWAY				= "Absent : %s"
L.INSTANCE_INFO_STATS_NO_RESPONSE		= "Aucune version récente de "..L.DBM.." installée : %s"
L.INSTANCE_INFO_RESULTS					= "Résultats de l'analyse des IDs d'instance. Notez que les instances peuvent apparaître plusieurs fois s'il y a des joueurs avec des clients WoW localisés dans votre raid."
L.INSTANCE_INFO_SHOW_RESULTS			= "Joueurs n'ayant pas encore répondu : %s"

L.LAG_CHECKING							= "Vérification de la latence du raid..."
L.LAG_HEADER							= L.DEADLY_BOSS_MODS.. " - Résultats de latence"
L.LAG_ENTRY								= "%s: Délai monde [%d ms] / Délai domicile [%d ms]"
L.LAG_FOOTER							= "Pas de réponse : %s"

L.DUR_CHECKING							= "Vérification de la durabilité du raid..."
L.DUR_HEADER							= L.DEADLY_BOSS_MODS.. " - Résultats de durabilité"
L.DUR_ENTRY								= "%s: Durabilité [%d pourcent] / Équipement cassé [%s]"
L.LAG_FOOTER							= "Pas de réponse : %s"

L.OVERRIDE_ACTIVATED					= "Les substitutions de configuration ont été activées pour ce combat par le RL."

L.LDB_TOOLTIP_HELP1						= "Clic pour ouvrir " .. L.DBM
L.LDB_TOOLTIP_HELP2						= "Alt+clic droit pour basculer en mode Silencieux"
L.SILENTMODE_IS							= "Le mode Silencieux est "

L.WORLD_BUFFS = {
	hordeOny							= "Peuple de la Horde, citoyens d’Orgrimmar, venez, rassemblez-vous et célébrez un héros de la Horde",
	allianceOny							= "Citoyens et alliés de Stormwind, ce jour est historique.",
	hordeNef							= "NEFARIAN A ÉTÉ TUÉ ! Peuple d'Orgrimmar",
	allianceNef							= "Citoyens de l'Alliance, le seigneur du clan Blackrock a été tué !",
	zgHeart								= "Il ne reste plus qu'une étape avant que prenne fin la menace de l'Écorcheur d'âmes",
	zgHeartBooty						= "Le Dieu sanglant, l'Écorcheur d'âmes, a été vaincu ! Nous ne sommes plus menacés !",
	zgHeartYojamba						= "Commencez le rituel, mes serviteurs. Nous devons renvoyer le cœur d'Hakkar dans le vide !",
	rendHead							= "Le faux chef Rend Blackhand est tombé !"
}

L.RAID_INFO_WORLD_BOSS					= "Boss hors instance"
L.SCENARIO_STAGE						= "Phase %d"
L.SPECIALIZATION						= "Spécialisation"
L.HARD_MODE								= "Mode difficile"
L.BOSS_YOU_DEFEATED						= "Vous avez vaincu"
L.BOSS_KILL_SUBTITLE					= "a été vaincu(e)"