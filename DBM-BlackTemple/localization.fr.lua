if GetLocale() ~= "frFR" then return end
local L

-- -----------------
-- --  Najentus  --
-- -----------------
L = DBM:GetModLocalization("Najentus")

L:SetGeneralLocalization({
	name = "Grand seigneur de guerre Naj'entus"
})

L:SetMiscLocalization({
	HealthInfo	= "Health Info"
})

-- ----------------
-- -- Supremus --
-- ----------------
L = DBM:GetModLocalization("Supremus")

L:SetGeneralLocalization({
	name = "Supremus"
})

L:SetWarningLocalization({
	WarnPhase		= "%s Phase"
})

L:SetTimerLocalization({
	TimerPhase		= "Next %s phase"
})

L:SetOptionLocalization({
	WarnPhase		= "Montre une alerte pour la prochaine phase",
	TimerPhase		= "Montre un timer pour la prochaine phase",
	KiteIcon		= "Mettre une icône sur la cible de $spell:41295",
})

L:SetMiscLocalization({
	PhaseTank		= "De rage, Supremus frappe le sol !",
	PhaseKite		= "Le sol commence à se fissurer !",
	ChangeTarget	= "Supremus choisit une nouvelle cible !",
	Kite			= "Kite",
	Tank			= "Tank"
})

-- -------------------------
-- --  Shade of Akama  --
-- -------------------------
L = DBM:GetModLocalization("Akama")

L:SetGeneralLocalization({
	name = "Ombre d'Akama"
})

L:SetWarningLocalization({
	warnAshtongueDefender	= "Défenseur cendrelangue",
	warnAshtongueSorcerer	= "Sorcier cendrelangue"
})

L:SetTimerLocalization({
	timerAshtongueDefender	= "Défenseur cendrelangue : %s",
	timerAshtongueSorcerer	= "Sorcier cendrelangue : %s"
})

L:SetOptionLocalization({
	warnAshtongueDefender	= "Afficher une alerte pour le Défenseur cendrelangue",
	warnAshtongueSorcerer	= "Afficher une alerte pour le Sorcier cendrelangue",
	timerAshtongueDefender	= "Afficher un timer pour le Défenseur cendrelangue",
	timerAshtongueSorcerer	= "Afficher un timer pour le Sorcier cendrelangue"
})

-- -------------------------
-- --  Teron Gorefiend  --
-- -------------------------
L = DBM:GetModLocalization("TeronGorefiend")

L:SetGeneralLocalization({
	name = "Teron Fielsang"
})

L:SetTimerLocalization({
	TimerVengefulSpirit		= "Esprit vengeur : %s"
})

L:SetOptionLocalization({
	TimerVengefulSpirit		= "Afficher un timer pour la durée d'esprit vengeur"
})

-- ----------------------------
-- --  Gurtogg Bloodboil  --
-- ----------------------------
L = DBM:GetModLocalization("Bloodboil")

L:SetGeneralLocalization({
	name = "Gurtogg Fièvresang"
})

-- --------------------------
-- --  Essence Of Souls  --
-- --------------------------
L = DBM:GetModLocalization("Souls")

L:SetGeneralLocalization({
	name = "Essence des âmes"
})

L:SetWarningLocalization({
	WarnMana		= "Mana à zéro dans 30 sec"
})

L:SetTimerLocalization({
	TimerMana		= "Mana à 0"
})

L:SetOptionLocalization({
	WarnMana		= "Afficher une alerte pour le mana à zéro pendant la phase 2",
	TimerMana		= "Afficher un timer pour le mana à zéro pendant la phase 2"
})

L:SetMiscLocalization({
	Suffering		= "Essence de la souffrance",
	Desire			= "Essence du désir.",
	Anger			= "Essence de la colère",
	Phase1End		= "Je ne veux pas y retourner !",
	Phase2End		= "Je ne serai jamais loin !"
})

-- -----------------------
-- --  Mother Shahraz --
-- -----------------------
L = DBM:GetModLocalization("Shahraz")

L:SetGeneralLocalization({
	name = "Mère Shahraz"
})

L:SetTimerLocalization({
	timerAura	= "%s"
})

L:SetOptionLocalization({
	timerAura	= "Afficher un timer pour l'Aura prismatique"
})

-- ----------------------
-- --  Illidari Council  --
-- ----------------------
L = DBM:GetModLocalization("Council")

L:SetGeneralLocalization({
	name = "Conseil illidari"
})

L:SetWarningLocalization({
	Immune			= "Malande - %s immunisée pendant 15 sec"
})

L:SetOptionLocalization({
	Immune			= "Afficher une alerte quand Malande devient immunisée aux sorts ou aux attaques"
})

L:SetMiscLocalization({
	Gathios			= "Gathios le Briseur",
	Malande			= "Dame Malande",
	Zerevor			= "Grand néantomancien Zerevor",
	Veras			= "Veras Ombrenoir",
	Melee			= "Melee",
	Spell			= "Spell"
})

-------------------------
--  Illidan Stormrage --
-------------------------
L = DBM:GetModLocalization("Illidan")

L:SetGeneralLocalization({
	name = "Illidan Hurlorage"
})

L:SetWarningLocalization({
	WarnHuman		= "Phase humaine"
})

L:SetTimerLocalization({
	TimerNextHuman		= "Prochaine phase humaine"
})

L:SetOptionLocalization({
	WarnHuman		= "Afficher l'avertissement pour la phase humaine",
	TimerNextHuman	= "Afficher l'heure de la prochaine phase humaine"
})

L:SetMiscLocalization({
	Pull			= "Akama. Ta duplicité n'est pas très étonnante. J'aurais dû vous massacrer depuis longtemps, toi et tes frères déformés.",
	Eyebeam			= "Soutenez le regard du Traître !",
	Demon			= "Contemplez la puissance... du démon intérieur !",
	Phase4			= "C'est tout, mortels ? Est-ce là toute la fureur que vous pouvez évoquer ?",
	S1YouAreNotPrepared	= "Phase 1 : Vous n’êtes pas prêts",
	S2FlamesOfAzzinoth	= "Phase 2 : Les flammes d’Azzinoth",
	S3TheDemonWithin	= "Phase 3 : Le démon intérieur",
	S4TheLongHunt		= "Phase 4 : La longue traque"
})
