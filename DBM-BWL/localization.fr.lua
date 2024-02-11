if GetLocale() ~= "frFR" then return end
local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization({
	name = "Tranchetripe l'Indompté"
})

L:SetTimerLocalization({
	TimerAddsSpawn	= "Premiers serviteurs"
})

L:SetOptionLocalization({
	TimerAddsSpawn	= "Afficher le timer pour les premiers serviteurs"
})

L:SetMiscLocalization({
	Phase2Emote	= "s'enfuit car le contrôle de l'orbe s'affaiblit.",
	YellPull = "La chambre des œufs est envahie ! Sonnez l'alarme ! Protégez les œufs à tout prix !"
})

-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization({
	name				= "Vaelastrasz le Corrompu"
})

L:SetMiscLocalization({
	Event				= "Trop tard, mes amis ! La corruption de Nefarius s'empare de moi… Je ne peux plus… me contrôler."
})

-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization({
	name	= "Seigneur des couvées Lashlayer"
})

L:SetMiscLocalization({
	Pull	= "Aucun membre de votre espèce ne devrait être ici ! Vous vous êtes condamnés vous-mêmes !	"
})

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization({
	name = "Gueule-de-feu"
})

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization({
	name = "Rochébène"
})

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization({
	name = "Flamegor"
})

-----------------------
--  Vulnerabilities  --
-----------------------
-- Chromaggus, Death Talon Overseer and Death Talon Wyrmguard
L = DBM:GetModLocalization("TalonGuards")

L:SetGeneralLocalization({
	name = "Gardes Griffemort"
})

L:SetWarningLocalization({
	WarnVulnerable		= "Vulnérabilité : %s"
})

L:SetOptionLocalization({
	WarnVulnerable		= "Afficher un avertissement pour les vulnérabilités des sorts"
})

L:SetMiscLocalization({
	Fire		= "Feu",
	Nature		= "Nature",
	Frost		= "Givre",
	Shadow		= "Ombre",
	Arcane		= "Arcanes",
	Holy		= "Sacré"
})

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization({
	name = "Chromaggus"
})

L:SetWarningLocalization({
	WarnBreath		= "%s",
	WarnVulnerable	= "Vulnérabilité : %s"
})

L:SetTimerLocalization({
	TimerBreathCD	= "%s recharge",
	TimerBreath		= "%s lancement",
	TimerVulnCD		= "Recharge de Vulnérabilité"
})

L:SetOptionLocalization({
	WarnBreath		= "Afficher un avertissement lorsque Chromaggus lance un de ses souffles",
	WarnVulnerable	= "Afficher un avertissement pour les vulnérabilités des sorts",
	TimerBreathCD	= "Afficher le temps de recharge de souffle",
	TimerBreath		= "Afficher le lancement du souffle",
	TimerVulnCD		= "Afficher le temps de recharge de vulnérabilité"
})

L:SetMiscLocalization({
	Breath1		= "Premier souffle",
	Breath2		= "Deuxième souffle",
	VulnEmote	= "%s grimace lorsque sa peau se met à briller.",
	Fire		= "Feu",
	Nature		= "Nature",
	Frost		= "Givre",
	Shadow		= "Ombre",
	Arcane		= "Arcanes",
	Holy		= "Sacré"
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization({
	name = "Nefarian"
})

L:SetWarningLocalization({
	WarnAddsLeft		= "%d restants",
	WarnClassCall		= "L'appel de %s",
	specwarnClassCall	= "Votre appel de classe !"
})

L:SetTimerLocalization({
	TimerClassCall		= "L'appel de %s termine"
})

L:SetOptionLocalization({
	TimerClassCall		= "Afficher le timer pour la durée de l'appel en classe",
	WarnAddsLeft		= "Annoncer les éliminations restantes jusqu'au déclenchement de la phase 2",
	WarnClassCall		= "Annoncer les appels de classe",
	specwarnClassCall	= "Afficher un avertissement spécial lorsque vous êtes affecté par un appel de classe"
})

L:SetMiscLocalization({
	YellP1			= "Que les jeux commencent !",
	YellP2			= "Beau travail ! Le courage des mortels commence à faiblir ! Voyons maintenant s'ils peuvent lutter contre le véritable seigneur du pic Rochenoire !",
	YellP3			= "C'est impossible ! Relevez-vous, serviteurs ! Servez une nouvelle fois votre maître !",
	YellShaman		= "Chamans, montrez-moi ce que vos totems peuvent faire !",
	YellPaladin		= "Les paladins… J'ai entendu dire que vous aviez de nombreuses vies… Montrez-moi.",
	YellDruid		= "Les druides et leur stupides changements de forme. Voyons ce qu'ils donnent en vrai…",
	YellPriest		= "Prêtres ! Si vous continuez à soigner comme ça, nous pourrions rendre le processus plus intéressant !",
	YellWarrior		= "Guerriers, je sais que vous pouvez frapper plus fort que ça ! Voyons ça !",
	YellRogue		= "Voleurs, arrêtez de vous cacher et affrontez-moi !",
	YellWarlock		= "Démonistes, vous ne devriez pas jouer avec une magie qui vous dépasse. Vous voyez ce qui arrive ?",
	YellHunter		= "Ah, les chasseurs et les stupides sarbacanes !",
	YellMage		= "Les mages aussi ? Vous devriez être plus prudents lorsque vous jouez avec la magie.",
	YellDK			= "Chevalier de la mort… Venez ici !"
})
