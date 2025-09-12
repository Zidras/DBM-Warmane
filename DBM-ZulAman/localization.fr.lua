if GetLocale() ~= "frFR" then return end
local L

---------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk")

L:SetGeneralLocalization({
	name = "Nalorakk"
})

L:SetWarningLocalization({
	WarnBear		= "Forme d'ours",
	WarnBearSoon	= "Forme d'ours dans 5 sec",
	WarnNormal		= "Forme normale",
	WarnNormalSoon	= "Forme normale dans 5 sec"
})

L:SetTimerLocalization({
	TimerBear		= "Forme d'ours",
	TimerNormal		= "Forme normale"
})

L:SetOptionLocalization({
	WarnBear		= "Afficher une alerte pour la forme d'ours",
	WarnBearSoon	= "Afficher une pré-alerte pour la forme d'ours",
	WarnNormal		= "Afficher une alerte pour la forme normale",
	WarnNormalSoon	= "Afficher une pré-alerte pour la forme normale",
	TimerBear		= "Afficher un timer pour la forme d'ours",
	TimerNormal		= "Afficher un timer pour la forme normale"
})

L:SetMiscLocalization({
	YellPull	= "Gardes, bougez-vous ! C'est l'heure du massacre !",
--	YellBear	= "You call on da beast, you gonna get more dan you bargain for!",
--	YellNormal	= "Make way for Nalorakk!"
})

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon")

L:SetGeneralLocalization({
	name = "Akil'zon"
})

L:SetMiscLocalization({
	YellPull	= "Moi, chuis le prédateur ! Vous, z'êtes la proie…",
})

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai")

L:SetGeneralLocalization({
	name = "Jan'alai"
})

L:SetMiscLocalization({
	YellPull	= "Les esprits du vent, ils vont être votre fin !",
--	YellBomb	= "I burn ya now!",
--	YellAdds	= "Where ma hatcha? Get to work on dem eggs!"
})

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi")

L:SetGeneralLocalization({
	name = "Halazzi"
})

 L:SetWarningLocalization({
	WarnSpirit	= "Phase spirituelle",
	WarnNormal	= "Phase normale"
 })

L:SetOptionLocalization({
	WarnSpirit	= "Afficher une alerte pour la phase spirituelle",
	WarnNormal	= "Afficher une alerte pour la phase normale"
 })

L:SetMiscLocalization({
	YellPull	= "À genoux, les idiots… devant la griffe et le croc !",
--	YellSpirit	= "I fight wit' untamed spirit....",
--	YellNormal	= "Spirit, come back to me!"
})

--------------------------
--  Hex Lord Malacrass --
--------------------------
L = DBM:GetModLocalization("Malacrass")

L:SetGeneralLocalization({
	name = "Seigneur des maléfices Malacrass"
})

L:SetMiscLocalization({
	YellPull	= "L'ombre, elle va vous tomber dessus."
})

--------------
--  Zul'jin --
--------------
L = DBM:GetModLocalization("ZulJin")

L:SetGeneralLocalization({
	name = "Zul'jin"
})

L:SetMiscLocalization({
--	YellPull	= "Nobody badduh dan me!",
--	YellPhase2	= "Got me some new tricks... like me brudda bear....",
--	YellPhase3	= "Dere be no hidin' from da eagle!",
--	YellPhase4	= "Let me introduce you to me new bruddas: fang and claw!",
--	YellPhase5	= "Ya don' have to look to da sky to see da dragonhawk!"
})
