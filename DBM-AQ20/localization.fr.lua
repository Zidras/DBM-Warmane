if GetLocale() ~= "frFR" then return end
local L

---------------
-- Kurinnaxx --
---------------
L = DBM:GetModLocalization("Kurinnaxx")

L:SetGeneralLocalization({
	name		= "Kurinnaxx"
})

------------
-- Rajaxx --
------------
L = DBM:GetModLocalization("Rajaxx")

L:SetGeneralLocalization({
	name		= "Général Rajaxx"
})

L:SetWarningLocalization({
	WarnWave	= "Vague %s"
})

L:SetOptionLocalization({
	WarnWave	= "Afficher l'annonce pour la prochaine vague entrante"
})

L:SetMiscLocalization({
	Wave12		= "Ils arrivent. Essayez de ne pas vous faire tuer, bleusaille.",
	Wave12Alt	= "Alors, Rajaxx, tu te souviens que j’avais dit que je te tuerais le dernier ?",
	Wave3		= "L’heure de notre vengeance sonne enfin ! Que les ténèbres règnent dans le cœur de nos ennemis !",
	Wave4		= "C’en est fini d’attendre derrière des portes fermées et des murs de pierre ! Nous ne serons pas privés de notre vengeance ! Les dragons eux-mêmes trembleront devant notre courroux !",
	Wave5		= "La peur est pour l’ennemi ! La peur et la mort !",
	Wave6		= "Forteramure pleurnichera pour avoir la vie sauve, comme l’a fait son morveux de fils ! En ce jour, mille ans d’injustice s’achèvent !",
	Wave7		= "Fandral ! Ton heure est venue ! Va te cacher dans le Rêve d’Emeraude, et prie pour que nous ne te trouvions jamais !",
	Wave8		= "Imbécile imprudent ! Je vais te tuer moi-même !"
})

----------
-- Moam --
----------
L = DBM:GetModLocalization("Moam")

L:SetGeneralLocalization({
	name		= "Moam"
})

----------
-- Buru --
----------
L = DBM:GetModLocalization("Buru")

L:SetGeneralLocalization({
	name		= "Buru Grandgosier"
})

L:SetWarningLocalization({
	WarnPursue		= "Poursuivre >%s<",
	SpecWarnPursue	= "Te poursuivre",
	WarnDismember	= "%s sur >%s< (%s)"
})

L:SetOptionLocalization({
	WarnPursue		= "Annoncer des cibles de poursuite",
	SpecWarnPursue	= "Afficher un avertissement spécial lorsque vous êtes poursuivi",
	WarnDismember	= DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.spell:format(96)
})

L:SetMiscLocalization({
	PursueEmote	= "%s pose ses yeux sur"
})

-------------
-- Ayamiss --
-------------
L = DBM:GetModLocalization("Ayamiss")

L:SetGeneralLocalization({
	name		= "Ayamiss le Chasseur"
})

--------------
-- Ossirian --
--------------
L = DBM:GetModLocalization("Ossirian")

L:SetGeneralLocalization({
	name		= "Ossirian l'Intouché"
})

L:SetWarningLocalization({
	WarnVulnerable	= "%s"
})

L:SetTimerLocalization({
	TimerVulnerable	= "%s"
})

L:SetOptionLocalization({
	WarnVulnerable	= "Annoncer les sensibilités",
	TimerVulnerable	= "Afficher le timer pour les sensibilités"
})

----------------
-- AQ20 Trash --
----------------
L = DBM:GetModLocalization("AQ20Trash")

L:SetGeneralLocalization({
	name = "AQ20: Ennemis communs"
})
