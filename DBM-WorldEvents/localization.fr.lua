if GetLocale() ~= "frFR" then return end
local L

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetGeneralLocalization({
	name = "Trio d'apothicaires"
})

L:SetTimerLocalization({
	HummelActive		= "Hummel becomes active",
	BaxterActive		= "Baxter becomes active",
	FryeActive			= "Frye becomes active"
})

L:SetOptionLocalization({
	TrioActiveTimer		= "Show timers for when Apothecary Trio becomes active"
})

L:SetMiscLocalization({
	SayCombatStart		= "Did they bother to tell you who I am and why I am doing this?"
})

-------------
--  Ahune  --
-------------
L = DBM:GetModLocalization("Ahune")

L:SetWarningLocalization({
	Submerged		= "Ahune est immergé",
	Emerged			= "Ahune a émergé",
	specWarnAttack	= "Ahune est vulnérable - Attaquez maintenant !"
})

L:SetTimerLocalization({
	SubmergeTimer	= "Immerger",
	EmergeTimer		= "Emerger",
	TimerCombat		= "Début du combat dans"
})

L:SetOptionLocalization({
	Submerged		= "Afficher l'alerte lorsque Ahune est immergé",
	Emerged			= "Afficher l'alerter lorsque Ahune a émergé",
	specWarnAttack	= "Afficher une alerter spécial lorsque Ahune devient vulnérable",
	SubmergeTimer	= "Afficher le timer pour l'immersion",
	EmergeTimer		= "Afficher le timer pour l'émersion",
	TimerCombat		= "Afficher le timer du début du combat"
})

L:SetMiscLocalization({
	Pull			= "Le glaçon a fondu!"
})

-------------------
-- Coren Direbrew --
-------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "Coren Navrebière"
})

L:SetWarningLocalization({
	specWarnBrew		= "Débarrassez-vous de la bière avant qu'elle ne vous en lance une autre !",
	specWarnBrewStun	= "Vous avez reçu un coup sur la tête. La prochaine fois, videz votre verre !"
})

L:SetOptionLocalization({
	specWarnBrew		= "Montre une alerte spéciale pour $spell:47376",
	specWarnBrewStun	= "Montre une alerte spéciale pour $spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "Tonneau sur moi !"
})

-------------------
-- Headless Horseman --
-------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "Cavalier sans tête"
})

L:SetWarningLocalization({
	WarnPhase				= "Phase %d",
	warnHorsemanSoldiers		= "Arrivée des Citrouilles vibrantes !",
	warnHorsemanHead		= "Tapez la Tête du Cavalier"
})

L:SetTimerLocalization({
	TimerCombatStart		= "Début du combat dans"
})

L:SetOptionLocalization({
	TimerCombatStart		= "Afficher le timer du début du combat",
	warnHorsemanSoldiers		= "Montre une alerte pour l'arrivée des Citrouilles vibrantes",
	warnHorsemanHead		= "Montre une alerte spéciale pour l'arrivée de la Tête du Cavalier"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Le cavalier sans tête se lève...", -- CONFIRM! local SQL has different string: Lève-toi, cavalier...
	HorsemanHead			= "Viens donc ici , sombre abruti !",  -- Attention, espace avant la virgule. CONFIRM! local SQL has different string: Viens donc ici, sombre abruti !
	HorsemanSoldiers		= "Levez-vous, mes recrues ! Au combat sans surseoir ! Au chevalier déchu, donnez enfin victoire !",
	SayCombatEnd			= "Je la connais trop bien, cette fin importune. Que faut-il au destin pour changer ma fortune ?"
})
