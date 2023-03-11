if GetLocale() ~= "frFR" then return end
local L

-- -----------------
-- --  Najentus  --
-- -----------------
-- L = DBM:GetModLocalization("Najentus")

-- L:SetGeneralLocalization({
-- 	name = "High Warlord Naj'entus"
-- })

-- L:SetMiscLocalization({
-- 	HealthInfo	= "Health Info"
-- })

-- ----------------
-- -- Supremus --
-- ----------------
-- L = DBM:GetModLocalization("Supremus")

-- L:SetGeneralLocalization({
-- 	name = "Supremus"
-- })

-- L:SetWarningLocalization({
-- 	WarnPhase		= "%s Phase"
-- })

-- L:SetTimerLocalization({
-- 	TimerPhase		= "Next %s phase"
-- })

-- L:SetOptionLocalization({
-- 	WarnPhase		= "Show warning for next phase",
-- 	TimerPhase		= "Show time for next phase",
-- 	KiteIcon		= "Set icon on Kite target"
-- })

-- L:SetMiscLocalization({
-- 	PhaseTank		= "punches the ground in anger!",
-- 	PhaseKite		= "The ground begins to crack open!",
-- 	ChangeTarget	= "acquires a new target",
-- 	Kite			= "Kite",
-- 	Tank			= "Tank"
-- })

-- -------------------------
-- --  Shade of Akama  --
-- -------------------------
-- L = DBM:GetModLocalization("Akama")

-- L:SetGeneralLocalization({
-- 	name = "Shade of Akama"
-- })

-- L:SetWarningLocalization({
-- 	warnAshtongueDefender	= "Ashtongue Defender",
-- 	warnAshtongueSorcerer	= "Ashtongue Sorcerer"
-- })

-- L:SetTimerLocalization({
-- 	timerAshtongueDefender	= "Ashtongue Defender: %s",
-- 	timerAshtongueSorcerer	= "Ashtongue Sorcerer: %s"
-- })

-- L:SetOptionLocalization({
-- 	warnAshtongueDefender	= "Show warning for Ashtongue Defender",
-- 	warnAshtongueSorcerer	= "Show warning for Ashtongue Sorcerer",
-- 	timerAshtongueDefender	= "Show timer for Ashtongue Defender",
-- 	timerAshtongueSorcerer	= "Show timer for Ashtongue Sorcerer"
-- })

-- -------------------------
-- --  Teron Gorefiend  --
-- -------------------------
-- L = DBM:GetModLocalization("TeronGorefiend")

-- L:SetGeneralLocalization({
-- 	name = "Teron Gorefiend"
-- })

-- L:SetTimerLocalization({
-- 	TimerVengefulSpirit		= "Ghost : %s"
-- })

-- L:SetOptionLocalization({
-- 	TimerVengefulSpirit		= "Show timer for Ghost durations"
-- })

-- ----------------------------
-- --  Gurtogg Bloodboil  --
-- ----------------------------
-- L = DBM:GetModLocalization("Bloodboil")

-- L:SetGeneralLocalization({
-- 	name = "Gurtogg Bloodboil"
-- })

-- --------------------------
-- --  Essence Of Souls  --
-- --------------------------
-- L = DBM:GetModLocalization("Souls")

-- L:SetGeneralLocalization({
-- 	name = "Essence of Souls"
-- })

-- L:SetWarningLocalization({
-- 	WarnMana		= "Zero Mana in 30 sec"
-- })

-- L:SetTimerLocalization({
-- 	TimerMana		= "Mana 0"
-- })

-- L:SetOptionLocalization({
-- 	WarnMana		= "Show warning from zero mana in Phase 2",
-- 	TimerMana		= "Show timer for zero mana in Phase 2"
-- })

-- L:SetMiscLocalization({
-- 	Suffering		= "Essence of Suffering",
-- 	Desire			= "Essence of Desire",
-- 	Anger			= "Essence of Anger",
-- 	Phase1End		= "I don't want to go back!",
-- 	Phase2End		= "I won't be far!"
-- })

-- -----------------------
-- --  Mother Shahraz --
-- -----------------------
-- L = DBM:GetModLocalization("Shahraz")

-- L:SetGeneralLocalization({
-- 	name = "Mother Shahraz"
-- })

-- L:SetTimerLocalization({
-- 	timerAura	= "%s"
-- })

-- L:SetOptionLocalization({
-- 	timerAura	= "Show timer for Prismatic Aura"
-- })

-- ----------------------
-- --  Illidari Council  --
-- ----------------------
-- L = DBM:GetModLocalization("Council")

-- L:SetGeneralLocalization({
-- 	name = "Illidari Council"
-- })

-- L:SetWarningLocalization({
-- 	Immune			= "Malande - %s immune for 15 sec"
-- })

-- L:SetOptionLocalization({
-- 	Immune			= "Show warning when Manalde becomes spell or melee immune"
-- })

-- L:SetMiscLocalization({
-- 	Gathios			= "Gathios the Shatterer",
-- 	Malande			= "Lady Malande",
-- 	Zerevor			= "High Nethermancer Zerevor",
-- 	Veras			= "Veras Darkshadow",
-- 	Melee			= "Melee",
-- 	Spell			= "Spell"
-- })

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