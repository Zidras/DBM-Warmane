if GetLocale() ~= "deDE" then return end
local L

------------------------------
--  The Crown Chemical Co.  --
------------------------------
L = DBM:GetModLocalization("ApothecaryTrio")

L:SetTimerLocalization({
	HummelActive		= "Hummel wird aktiv",
	BaxterActive		= "Baxter wird aktiv",
	FryeActive			= "Frye wird aktiv"
})

L:SetOptionLocalization({
	TrioActiveTimer		= "Zeige Zeit bis Apotheker aktiv werden"
})

L:SetMiscLocalization({
	SayCombatStart		= "Haben sie sich die Mühe gemacht und Euch gesagt, wer ich bin und warum ich das hier tue?"
})

----------------------------
--  The Frost Lord Ahune  --
----------------------------
L = DBM:GetModLocalization("Ahune")

L:SetWarningLocalization({
	Emerged			= "Aufgetaucht",
	specWarnAttack	= "Ahune ist verwundbar - Angriff!"
})

L:SetTimerLocalization({
	SubmergeTimer	= "Abtauchen",
	EmergeTimer		= "Auftauchen"
})

L:SetOptionLocalization({
	Emerged			= "Zeige Warnung, wenn Ahune auftaucht",
	specWarnAttack	= "Spezialwarnung, wenn Ahune verwundbar wird",
	SubmergeTimer	= "Zeige Zeit bis Abtauchen",
	EmergeTimer		= "Zeige Zeit bis Auftauchen"
})

L:SetMiscLocalization({
	Pull			= "Der Eisbrocken ist geschmolzen!"
})

----------------------
--  Coren Direbrew  --
----------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetWarningLocalization({
	specWarnBrew		= "Werde das Bier los, bevor sie dir noch eins zuwirft!",
	specWarnBrewStun	= "TIPP: Du hast eine Kopfnuss kassiert, trink das Bier beim nächsten Mal!"
})

L:SetOptionLocalization({
	specWarnBrew		= "Spezialwarnung für $spell:47376",
	specWarnBrewStun	= "Spezialwarnung für $spell:47340"
})

L:SetMiscLocalization({
	YellBarrel			= "Stecke im Fass!"
})

-----------------------------
--  The Headless Horseman  --
-----------------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetWarningLocalization({
	WarnPhase				= "Phase %d",
	warnHorsemanSoldiers	= "Pulsierende Kürbisse erscheinen",
	warnHorsemanHead		= "Kopf des Reiters aktiv"
})

L:SetOptionLocalization({
	WarnPhase				= "Zeige Warnung für jeden Phasenwechsel",
	warnHorsemanSoldiers	= "Zeige Warnung, wenn Pulsierende Kürbnisse erscheinen",
	warnHorsemanHead		= "Zeige Warnung, wenn Kopf des Reiters erscheint"
})

L:SetMiscLocalization({
	HorsemanSummon			= "Erhebe dich, Reiter,...", -- CONFIRM! local SQL has different string - Erhebe dich, Reiter...
	HorsemanHead			= "Komm hierher, du Idiot!",
	HorsemanSoldiers		= "Soldaten, erhebt Euch und kämpft immer weiter. Bringt endlich den Sieg zum gefallenen Reiter!",
	SayCombatEnd			= "Dieses Ende ist mir schon bekannt. Welch neue Abenteuer hat das Schicksal zur Hand?"
})
