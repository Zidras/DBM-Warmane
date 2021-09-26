if GetLocale() ~= "frFR" then return end
local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization{
	name = "Le Prophète Skeram"
}

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization{
	name = "Trio d'insectes"
}
L:SetMiscLocalization{
	Yauj = "Princesse Yauj",
	Vem = "Vem",
	Kri = "Seigneur Kri"
}

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization{
	name = "Garde de guerre Sartura"
}

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization{
	name = "Fankriss l'Inflexible"
}

--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization{
	name = "Viscidus"
}
L:SetWarningLocalization{
	WarnFreeze	= "Gel : %d/3",
	WarnShatter	= "Briser : %d/3"
}
L:SetOptionLocalization{
	WarnFreeze	= "Annoncer l'état de Gel",
	WarnShatter	= "Annoncer l'état de Briser"
}
L:SetMiscLocalization{
	Slow	= "commence à ralentir !",
	Freezing= "est gelé !",
	Frozen	= "est congelé !",
	Phase4 	= "commence à se briser !",
	Phase5 	= "semble prêt à se briser !",
	Phase6 	= "explose !",

	HitsRemain	= "Touche restante",
	Frost		= "Givre",
	Physical	= "Physique"
}
-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization{
	name = "Princesse Huhuran"
}
---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization{
	name = "Empereurs Jumeaux"
}
L:SetMiscLocalization{
	Veklor = "Empereur Vek'lor",
	Veknil = "Empereur Vek'nilash"
}

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization{
	name = "C'Thun"
}
L:SetWarningLocalization{
	WarnEyeTentacle			= "Tentacule oculaire",
	WarnClawTentacle2		= "Tentacule griffu",
	WarnGiantEyeTentacle	= "Tentacule oculaire géant",
	WarnGiantClawTentacle	= "Tentacule griffu géant",
	SpecWarnWeakened		= "C'Thun est affaibli !"
}
L:SetTimerLocalization{
	TimerEyeTentacle		= "Prochain Tentacule oculaire",
	TimerClawTentacle		= "Prochain Tentacule griffu",
	TimerGiantEyeTentacle	= "Prochain Tentacule oculaire géant",
	TimerGiantClawTentacle	= "Prochain Tentacule griffu géant",
	TimerWeakened			= "Faiblesse terminé"
}
L:SetOptionLocalization{
	WarnEyeTentacle			= "Afficher l'avertissement pour Tentacule oculaire",
	WarnClawTentacle2		= "Afficher l'avertissement pour Tentacule griffu",
	WarnGiantEyeTentacle	= "Afficher l'avertissement pour Tentacule oculaire géant",
	WarnGiantClawTentacle	= "Afficher l'avertissement pour Tentacule griffu géant",
	SpecWarnWeakened		= "Afficher un avertissement spécial lorsque le boss s'affaiblit",
	TimerEyeTentacle		= "Afficher le timer pour le prochain Tentacule oculaire",
	TimerClawTentacle		= "Afficher le timer pour le prochain Tentacule griffu",
	TimerGiantEyeTentacle	= "Afficher le timer pour le prochain Tentacule oculaire géant",
	TimerGiantClawTentacle	= "Afficher le timer pour le prochain Tentacule griffu géant",
	TimerWeakened			= "Afficher le timer pour la durée d'affaiblissement du boss",
	RangeFrame				= "Afficher le cadre de portée (10 m)"
}
L:SetMiscLocalization{
	Stomach		= "Estomac",
	Eye			= "Oeil de C'Thun",
	FleshTent	= "Tentacule de chair",
	Weakened 	= "est affaibli !",
	NotValid	= "AQ40 partiellement effacé. %s bosses optionnels restent."
}
----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization{
	name = "Ouro"
}
L:SetWarningLocalization{
	WarnSubmerge		= "Submerger",
	WarnEmerge			= "Émerger"
}
L:SetTimerLocalization{
	TimerSubmerge		= "Submerger",
	TimerEmerge			= "Émerger"
}
L:SetOptionLocalization{
	WarnSubmerge		= "Afficher l'avertissement pour submerger",
	TimerSubmerge		= "Afficher le timer pour submerger",
	WarnEmerge			= "Afficher l'avertissement pour émerger",
	TimerEmerge			= "Afficher le timer pour émerger"
}

----------------
-- AQ40 Trash --
----------------
L = DBM:GetModLocalization("AQ40Trash")

L:SetGeneralLocalization{
	name = "AQ40: Ennemis communs"
}
