if GetLocale() ~= "frFR" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization({
	name = "Les Bêtes du Norfendre"
})

L:SetWarningLocalization({
	WarningSnobold				= "Un Vassal frigbold viens d'arriver sur >%s<"
})

L:SetTimerLocalization({
	TimerNextBoss				= "Prochain boss dans"
--	TimerEmerge					= "Sort du sol",
--	TimerSubmerge				= "Rentre dans le sol"
})

L:SetOptionLocalization({
	soundConcAuraMastery		= "Jouer le son $spell:31821 pour annuler les effets de $spell:66330 (seulement pour le |cFFF48CBAPaladin|r qui est le propriétaire de $spell:19746)",
	WarningSnobold				= "Montre une alerte quand les Vassal arrivent",
	PingCharge					= "Ping sur la minimap quand Glace-hurlante va vous charger",
	ClearIconsOnIceHowl			= "Enlève toutes les icônes avant la prochaine charge",
--	TimerNextBoss				= "Montre le timer pour l'arrivée du prochain boss",
--	TimerEmerge					= "Montre le timer avant que les vers rentre dans le sol",
	TimerSubmerge				= "Montre le timer avant que les vers sortent du sol"
})

L:SetMiscLocalization({
	Charge			= "fusille (%S+) du regard",
	CombatStart		= "Arrivant tout droit des plus noires et profondes cavernes des pics Foudroyés, Gormok l'Empaleur !",
	Phase2			= "car voici que les terreurs jumelles",
	Phase3			= "de notre prochain combattant",
	Gormok			= "Gormok l'Empaleur",
	Acidmaw			= "Gueule-d'acide",
	Dreadscale		= "Ecaille-d'effroi",
	Icehowl			= "Glace-hurlante"
})

-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization({
	name = "Seigneur Jaraxxus"
})

L:SetOptionLocalization({
	IncinerateShieldFrame	= "Montre la vie du Boss avec une barre de vie pour Incinérer la chair"
})

L:SetMiscLocalization({
	IncinerateTarget		= "Incinérer la chair: %s",
	FirstPull				= "Le grand démoniste Wilfred Flopboum va invoquer votre prochain défi. Ne bougez pas, il arrive."
})

-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization({
	name = "Champion des Factions"
})

L:SetMiscLocalization({
	--Horde NPCs
	Gorgrim				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:64:64:96|t Gorgrim Fend-les-ombres",	-- 34458
	Birana				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Birana Sabot-Tempête",		-- 34451
	Erin				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Erin Sabot-de-brume",		-- 34459
	Rujkah				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t Ruj'kah",						-- 34448
	Ginselle			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:0:32|t Ginselle Jettechancre",		-- 34449
	Liandra				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Liandra Mande-soleil",		-- 34445
	Malithas			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Malithas Brillelame",			-- 34456
	Caiphus				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Caiphus le Sévère",		-- 34447
	Vivienne			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Vivienne Murmenoir",		-- 34441
	Mazdinah			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:0:32|t Maz'dinah",					-- 34454
	Thrakgar			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Thrakgar",					-- 34444
	Broln				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Broln Corne-Rude",			-- 34455
	Harkzog				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:32:64|t Harkzog",					-- 34450
	Narrhok				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:0:32|t Narrhok Brise-acier",			-- 34453
	--Alliance NPCs
	Tyrius				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:64:64:96|t Tyrius Lamebrune",			-- 34461
	Kavina				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Kavina Chantebosquet",		-- 34460
	Melador				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Melador Arpenteval",		-- 34469
	Alyssia				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t Alyssia Traquelune",			-- 34467
	Noozle				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:0:32|t Touillert Vizitige",		-- 34468
	Baelnor				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Baelnor Portelumière",		-- 34471
	Velanaa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Velanaa",						-- 34465
	Anthar				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Anthar Soigneforge",		-- 34466
	Brienna				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Brienna Tombenuit",		-- 34473
	Irieth				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:0:32|t Irieth Pas-de-l'ombre",		-- 34472
	Saamul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Saamul",					-- 34470
	Shaabad				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Shaabad",					-- 34463
	Serissa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:32:64|t Serissa Funèbricole",		-- 34474
	Shocuul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:0:32|t Shocuul",						-- 34475

	AllianceVictory			= "GLOIRE À L'ALLIANCE !",
	HordeVictory			= "Et ce n'était qu'un avant-goût de ce que l'avenir vous réserve. POUR LA HORDE !"
	--YellKill				= "Une victoire tragique et dépourvue de sens. La perte subie aujourd'hui nous affaiblira tous, car qui d'autre que le roi-liche pourrait bénéficier d'une telle folie ? De grands guerriers ont perdu la vie. Et pour quoi ? La vraie menace plane à l'horizon : le roi-liche nous attend, tous, dans la mort."
})

------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization({
	name = "Soeurs Val'kyr"
})

L:SetWarningLocalization({
	WarnSpecialSpellSoon		= "Capacité spéciale Bientôt !",
	SpecWarnSpecial				= "Changement de couleur !",
	SpecWarnSwitchTarget		= "Changement de cible !",
	SpecWarnKickNow				= "Casser Maintenant !",
	WarningTouchDebuff			= "Toucher sur >%s<",
	WarningPoweroftheTwins2		= "Puissance des jumelles - plus de soins sur >%s<"
})

L:SetTimerLocalization({
	TimerSpecialSpell			= "Prochaine Capacité Spéciale",
	TimerAnubRoleplay			= "Pauses de sol en"
})

L:SetOptionLocalization({
	TimerSpecialSpell			= "Montre une alerte spéciale pour la prochaine Capacité spéciale",
	TimerAnubRoleplay			= "Afficher le timer de la durée du roleplay du Le Roi Liche cassant le sol",
	WarnSpecialSpellSoon		= "Montre une Pré-Alerte pour la prochaine Capacité spéciale",
	SpecWarnSpecial				= "Montre une alerte spéciale quand vous devez changer de couleur",
	SpecWarnSwitchTarget		= "Montre une alerte spéciale quand l'autre boss est en train d'incanter",
	SpecWarnKickNow				= "Montre une alerte spéciale quand vous devez interrompre l'incantation",
	SpecialWarnOnDebuff			= "Montre une alerte spéciale quand vous avez un Toucher (pour changer de debuff)",
	SetIconOnDebuffTarget		= "Met des icônes sur les cibles des Toucher (héroique)",
	WarningTouchDebuff			= "Annoncer les cibles des débuff Toucher de Lumière/des Ténèbres",
	WarningPoweroftheTwins2		= "Annoncer la cible pour Puissance des jumelles"
})

L:SetMiscLocalization({
--	YellPull	= "Au nom de notre ténébreux maître. Pour le roi-liche. Vous. Allez. Mourir.",
--	CombatStart	= "Ce n'est qu'en travaillant côte à côte que vous pourrez triompher de l'ultime défi. Venus des profondeurs de la Couronne de glace, voici deux des lieutenants les plus puissants du Fléau : de redoutables val'kyrs, messagères ailées du roi-liche !",
	Fjola		= "Fjola Plaie-lumineuse",
	Eydis		= "Eydis Plaie-sombre",
	ValksRP		= "Que les jeux commencent !", -- 35709
	AnubRP		= "C'est un rude coup qui vient d'être porté au roi-liche ! Vous avez prouvé que vous êtes aptes à servir comme champions de la Croisade d'argent. Ensemble, nous frapperons la citadelle de la Couronne de glace, et détruirons ce qui reste du Fléau ! Aucun défi ne pourra résister à notre unité !"
})

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization({
	name					= "Anub'arak"
})

--L:SetTimerLocalization({
--	TimerEmerge				= "Sort du sol",
--	TimerSubmerge			= "Rentre dans le sol",
--	timerAdds				= "Nouveaux add dans"
--})

L:SetWarningLocalization({
	WarnEmerge				= "Anub'arak Sort du sol",
	WarnEmergeSoon			= "Anub'arak Sort du sol dans 10 sec",
	WarnSubmerge			= "Anub'arak Rentre dans le sol",
	WarnSubmergeSoon		= "Anub'arak Rentre dans le sol dans 10 sec",
	warnAdds				= "Les add arrivent"
})

L:SetMiscLocalization({
--	YellPull				= "Ce terreau sera votre tombeau !",
	Emerge					= "surgit de la terre",
	Burrow					= "enfonce dans le sol",
	YellBurrow				= "Auum na-l ak-k-k-k, isshhh. Debout, mes serviteurs. Dévorez...",
	PcoldIconSet			= "Pcold Icon {rt%d} set on %s",
	PcoldIconRemoved		= "Pcold Icon removed from %s"
})

L:SetOptionLocalization({
	WarnEmerge				= "Montre une alerte quand le boss sort du sol",
	WarnEmergeSoon			= "Montre une alerte avant que le boss sorte du sol",
	WarnSubmerge			= "Montre une alerte quand le boss rentre dans le sol",
	WarnSubmergeSoon		= "Montre une alerte avant que le boss ne rentre dans le sol",
	warnAdds				= "Montre une alerte pour l'arrivée des add",
--	timerAdds				= "Montre le timer avant l'arrivée des nouveaux add",
--	TimerEmerge				= "Montre le timer pour la sortie du boss",
--	TimerSubmerge			= "Montre le timer pour la rentrée du boss dans la terre",
	AnnouncePColdIcons		= "Marque les icones des cible du Froid pénétrant dans le chatt (Requiert les annonces activer et être le leader ou avoir une promot)",
	AnnouncePColdIconsRemoved	= "Annoncez également lorsque les icônes sont supprimées pour $spell:66013 (nécessite l'option ci-dessus)",
	RemoveHealthBuffsInP3	= "Enlève les buffs de soins au début de la phase 3"
})
