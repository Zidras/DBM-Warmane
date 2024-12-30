local mod	= DBM:NewMod("Champions", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

local UnitGUID = UnitGUID

mod:SetRevision("20241230122035")
mod:SetCreatureID(34458, 34451, 34459, 34448, 34449, 34445, 34456, 34447, 34441, 34454, 34444, 34455, 34450, 34453, 34461, 34460, 34469, 34467, 34468, 34471, 34465, 34466, 34473, 34472, 34470, 34463, 34474, 34475)
mod:SetMinSyncRevision(20220907000000)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.AllianceVictory, L.HordeVictory)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 66017 68753 68754 68755 66020 68758 68757 68756 66115 66009 66008 66613 66007 66011 65793 65790 65816 68145 68146 68147 65820 68141 68139 68140 65947 65932 65931 66063 65983 65980 65544 65543 65545 65542 65860 66086 67974 67975 67976 66178 68759 68760 68761 65960 65961 66207 65880 65869",
	"SPELL_AURA_APPLIED 66010 65802 65801 65809 65927 65929 66054 65859 65857 65871 65878 65877",
	"SPELL_DAMAGE 65817 68142 68143 68144",
	"SPELL_MISSED 65817 68142 68143 68144",
	"UNIT_DIED"
)

if UnitFactionGroup("player") == "Alliance" then
	--mod:RegisterKill("yell", L.AllianceVictory)
	mod:SetBossHealthInfo(
	-- Horde
		34458, L.Gorgrim,
		34451, L.Birana,
		34459, L.Erin,
		34448, L.Rujkah,
		34449, L.Ginselle,
		34445, L.Liandra,
		34456, L.Malithas,
		34447, L.Caiphus,
		34441, L.Vivienne,
		34454, L.Mazdinah,
		34444, L.Thrakgar,
		34455, L.Broln,
		34450, L.Harkzog,
		34453, L.Narrhok
	)
else
	--mod:RegisterKill("yell", L.HordeVictory)
	mod:SetBossHealthInfo(
	-- Alliance
		34461, L.Tyrius,
		34460, L.Kavina,
		34469, L.Melador,
		34467, L.Alyssia,
		34468, L.Noozle,
		34471, L.Baelnor,
		34465, L.Velanaa,
		34466, L.Anthar,
		34473, L.Brienna,
		34472, L.Irieth,
		34470, L.Saamul,
		34463, L.Shaabad,
		34474, L.Serissa,
		34475, L.Shocuul
	)
end

local FACTION_ALLIANCE, FACTION_HORDE = FACTION_ALLIANCE, FACTION_HORDE

-- Announce: 1 - target player with CC, 2 - target player no CC, 3 - target self (npc)
-- Death Knight
local warnChainsofIce		= mod:NewTargetNoFilterAnnounce(66020, 2)		-- 66020
local warnDeathgrip			= mod:NewTargetNoFilterAnnounce(66017, 2)
-- Paladin
local warnHandofFreedom		= mod:NewTargetNoFilterAnnounce(66115, 2)
local warnHandofProt		= mod:NewTargetNoFilterAnnounce(66009, 3)		-- 66009
local warnHoJ				= mod:NewTargetNoFilterAnnounce(66613, 1)		-- 66613, 66607
local warnRepentance		= mod:NewTargetNoFilterAnnounce(66008, 1)		-- 66008
local warnDivineShield		= mod:NewSpellAnnounce(66010, 3)				-- 66010
local warnAvengingWrath		= mod:NewSpellAnnounce(66011, 3)				-- 66011
-- Mage
local warnIceBlock			= mod:NewSpellAnnounce(65802, 3)				-- 65802
local warnSheep				= mod:NewTargetNoFilterAnnounce(65801, 1, nil, false)
local warnBlink				= mod:NewSpellAnnounce(65793, 3)				-- 65793
local warnCounterspell		= mod:NewTargetNoFilterAnnounce(65790, 1)		-- 65790
-- Warlock
local warnHellfire			= mod:NewSpellAnnounce(65816, 4)
local warnFear				= mod:NewTargetNoFilterAnnounce(65809, 1)		-- 65809
local warnDeathCoil			= mod:NewTargetNoFilterAnnounce(65820, 1)		-- 65820
-- Warrior
local preWarnBladestorm		= mod:NewSoonAnnounce(65947, 3)
local warnBladestorm		= mod:NewSpellAnnounce(65947, 4)
local warnCharge			= mod:NewTargetNoFilterAnnounce(65927, 2)		-- 65927, 65929
local warnRetaliation		= mod:NewSpellAnnounce(65932, 3)				-- 65932
local warnIntimidatingShout	= mod:NewSpellAnnounce(65931, 1)				-- 65931
-- Shaman
local warnHeroism			= mod:NewSpellAnnounce(65983, 3)
local warnBloodlust			= mod:NewSpellAnnounce(65980, 3)
local warnEarthShield		= mod:NewTargetNoFilterAnnounce(66063, 3)		-- 66063
local warnHex				= mod:NewTargetNoFilterAnnounce(66054, 1)		-- 66054
-- Priest
local warnDispersion		= mod:NewSpellAnnounce(65544, 3)				-- 65544
local warnPsychicScream		= mod:NewSpellAnnounce(65543, 1)				-- 65543
local warnPsychicHorror		= mod:NewTargetNoFilterAnnounce(65545, 1)		-- 65545
local warnSilence			= mod:NewTargetNoFilterAnnounce(65542, 1)		-- 65542
-- Druid
local warnBarkskin			= mod:NewSpellAnnounce(65860, 3)				-- 65860
local warnTranquility		= mod:NewSpellAnnounce(66086, 4)				-- 66086, 67976, 67975, 67974
local warnEntanglingRoots	= mod:NewTargetNoFilterAnnounce(65857, 1)		-- 65857
local warnCyclone			= mod:NewTargetNoFilterAnnounce(65859, 1, nil, false)
-- Rogue
local warnShadowstep		= mod:NewSpellAnnounce(66178, 2)
local warnBlind				= mod:NewTargetNoFilterAnnounce(65960, 1)		-- 65960
local warnCloakOfShadows	= mod:NewSpellAnnounce(65961, 3)				-- 65961
-- Hunter
local warnDeterrence		= mod:NewSpellAnnounce(65871, 3)				-- 65871
local warnWingClip			= mod:NewTargetNoFilterAnnounce(66207, 1)		-- 66207
local warnWyvernSting		= mod:NewTargetNoFilterAnnounce(65878, 1)		-- 65878, 65877
local warnFrostTrap			= mod:NewSpellAnnounce(65880, 3)				-- 65880
local warnDisengage			= mod:NewSpellAnnounce(65869, 3)				-- 65869

local specWarnHellfire		= mod:NewSpecialWarningGTFO(65816, nil, nil, nil, 1, 8)
local specWarnHandofProt	= mod:NewSpecialWarningDispel(66009, "ImmunityDispeller", nil, nil, 1, 2)
local specWarnDivineShield	= mod:NewSpecialWarningDispel(66010, "ImmunityDispeller", nil, nil, 1, 2)
local specWarnIceBlock		= mod:NewSpecialWarningDispel(65802, "ImmunityDispeller", nil, nil, 1, 2)
local specWarnHandofFreedom	= mod:NewSpecialWarningDispel(66115, "MagicDispeller", nil, nil, 1, 2)
local specWarnTranquility	= mod:NewSpecialWarningInterrupt(66086)
local specWarnEarthShield	= mod:NewSpecialWarningDispel(66063, "MagicDispeller")
local specWarnAvengingWrath = mod:NewSpecialWarningDispel(66011, "MagicDispeller")
local specWarnBloodlust		= mod:NewSpecialWarningDispel(65980, "MagicDispeller", nil, nil, 1, 2)
local specWarnHeroism		= mod:NewSpecialWarningDispel(65983, "MagicDispeller", nil, nil, 1, 2)

-- log timers for this fight are all over the place. I suspect it is due to CC, and thus, only fixes I will do are if debug catches early refreshes.
local timerBladestorm		= mod:NewBuffActiveTimer(8, 65947, nil, nil, nil, 2)
local timerShadowstepCD		= mod:NewCDTimer(30, 66178, nil, nil, nil, 3) -- (25H Lordaeron 2022/09/03) - pull:25.7
local timerBlindCD			= mod:NewCDTimer(120, 65960)
local timerDeathgripCD		= mod:NewCDTimer(20.7, 66017, nil, nil, nil, 3) -- REVIEW! High variance (25H Lordaeron 2022/09/03 || 25H Lordaeron 2022/10/12) - pull:22.9, 31.5, 45.1, 34.9, 24.2, 21.9, 31.1, 61.4, 43.9, 21.5 || pull:62.4, 20.7, 21.3, 41.0
local timerBladestormCD		= mod:NewCDTimer(90.1, 65947, nil, nil, nil, 2) -- (25H Lordaeron 2022/09/03) - pull:49.0, 90.1, 90.1
local timerFrostTrapCD		= mod:NewCDTimer(30, 65880) -- REVIEW! ~5s variance? (25H Lordaeron 2022/09/03 || 25H Lordaeron 2022/09/23-npc:34467 || 25N Lordaeron 2022/10/21-npc:34467) - pull:46.2, 31.8 || pull:22.7, 34.4, 31.6 || pull:47.3, 30.0, 31.8
local timerDisengageCD		= mod:NewCDTimer(30, 65869) -- REVIEW! variance? (25H Lordaeron 2022/09/03) - pull:32.6, 40.4
local timerPsychicScreamCD	= mod:NewCDTimer(30, 65543) -- variance (25H Lordaeron 2022/09/03) - pull:49.1, 30.0, 31.7, 30.1, 33.5, 31.3, 30.6, 44.0, 37.2, 31.0
local timerBlinkCD			= mod:NewCDTimer(15.1, 65793) -- REVIEW! High variance! diff script per npc? (25H Lordaeron 2022/09/03-npc:34449 || 25H Lordaeron 2022/09/23-npc:34468) - pull:21.1, 17.6, 135.2, 20.2, 44.0, 34.7, 27.3, 18.1, 20.6, 19.2 || pull:19.3, 15.1, 28.5, 15.1, 19.3, 21.2, 92.1, 19.3
local timerHoJCD			= mod:NewCDTimer(40, 66613) -- REVIEW! variance? (25H Lordaeron 2022/09/03) - pull:178.8
local timerRepentanceCD		= mod:NewCDTimer(60, 66008)
local timerHoPCD			= mod:NewCDTimer(300, 66009) -- REVIEW! variance? (25H Lordaeron 2022/09/03) - pull:32.5
local timerSilenceCD		= mod:NewCDTimer(45, 65542)
local timerHeroismCD		= mod:NewCDTimer(300, 65983)
local timerBloodlustCD		= mod:NewCDTimer(300, 65980) -- REVIEW! variance? (25H Lordaeron 2022/09/03) - pull:26.9

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	-- Death Knight
	if args:IsSpellID(66017, 68753, 68754, 68755) and args:IsDestTypePlayer() then	-- Death Grip
		warnDeathgrip:Show(args.destName)
		timerDeathgripCD:Start()
	elseif spellId == 66020 and args:IsDestTypePlayer() then	-- Chains of Ice
		warnChainsofIce:Show(args.destName)
	-- Paladin
	elseif args:IsSpellID(68758, 68757, 68756, 66115) and not args:IsDestTypePlayer() then	-- Hand of Freedom
		warnHandofFreedom:Show(args.destName)
		specWarnHandofFreedom:Show(args.destName)
		specWarnHandofFreedom:Play("dispelboss")
	elseif spellId == 66009 then								-- Hand of Protection
		warnHandofProt:Show(args.destName)
		specWarnHandofProt:Show(args.destName)
		specWarnHandofProt:Play("dispelboss")
		timerHoPCD:Start()
	elseif spellId == 66008 then								-- Repentance
		warnRepentance:Show(args.destName)
		timerRepentanceCD:Start()
	elseif args:IsSpellID(66613, 66007) then						-- Hammer of Justice
		warnHoJ:Show(args.destName)
		timerHoJCD:Start()
	elseif spellId == 66011 then								-- Avenging Wrath
		warnAvengingWrath:Show()
		specWarnAvengingWrath:Show(args.sourceName)
	-- Mage
	elseif spellId == 65793 then								-- Blink
		warnBlink:Show()
		timerBlinkCD:Start()
	elseif spellId == 65790 then								-- Counterspell
		warnCounterspell:Show(args.destName)
	-- Warlock
	elseif args:IsSpellID(65816, 68145, 68146, 68147) then			-- Hellfire
		warnHellfire:Show()
	elseif args:IsSpellID(65820, 68141, 68139, 68140) then			-- Death Coil
		warnDeathCoil:Show(args.destName)
	-- Warrior
	elseif spellId == 65947 then								-- Bladestorm
		warnBladestorm:Show()
		timerBladestorm:Start()
		timerBladestormCD:Start()
		preWarnBladestorm:Schedule(85.1)
		elseif spellId == 65932 then							-- Retaliation
		warnRetaliation:Show()
	elseif spellId == 65931 then								-- Intimidating Shout
		warnIntimidatingShout:Show()
	-- Shaman
	elseif spellId == 66063 then								-- Earth Shield
		warnEarthShield:Show(args.destName)
		specWarnEarthShield:Show(args.destName)
	elseif spellId == 65983 then
		warnHeroism:Show()
		specWarnHeroism:Show(FACTION_ALLIANCE)
		specWarnHeroism:Play("dispelboss")
		timerHeroismCD:Start()
	elseif spellId == 65980 then
		warnBloodlust:Show()
		specWarnBloodlust:Show(FACTION_HORDE)
		specWarnBloodlust:Play("dispelboss")
		timerBloodlustCD:Start()
	-- Priest
	elseif spellId == 65544 then								-- Dispersion
		warnDispersion:Show()
	elseif spellId == 65543 then								-- Psychic Scream
		warnPsychicScream:Show()
	elseif spellId == 65545 then								-- Psychic Horror
		warnPsychicHorror:Show(args.destName)
	elseif spellId == 65542 then								-- Silence
		warnSilence:Show(args.destName)
		timerSilenceCD:Start()
	-- Druid
	elseif spellId == 65860 then								-- Barkskin
		warnBarkskin:Show()
	elseif args:IsSpellID(66086, 67974, 67975, 67976) then			-- Tranquility
		warnTranquility:Show()
		specWarnTranquility:Show(args.sourceName)
	-- Rogue
	elseif args:IsSpellID(66178, 68759, 68760, 68761) then			-- Shadowstep
		warnShadowstep:Show()
		if self:IsDifficulty("heroic25") then
			timerShadowstepCD:Start(20)
		else
			timerShadowstepCD:Start()
		end
	elseif spellId == 65960 then								-- Blind
		warnBlind:Show(args.destName)
		timerBlindCD:Start()
	elseif spellId == 65961 then								-- Cloak of Shadows
		warnCloakOfShadows:Show()
	-- Hunter
	elseif spellId == 66207 then								-- Wing Clip
		warnWingClip:Show(args.destName)
	elseif spellId == 65880 then								-- Frost Trap
		warnFrostTrap:Show()
		timerFrostTrapCD:Start()
	elseif spellId == 65869 then								-- Disengage
		warnDisengage:Show()
		timerDisengageCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	-- Death Knight
	-- Paladin
	if spellId == 66010 then									-- Divine Shield
		warnDivineShield:Show()
		specWarnDivineShield:Show(args.destName)
		specWarnDivineShield:Play("dispelboss")
	-- Mage
	elseif spellId == 65802 then								-- Ice Block
		warnIceBlock:Show()
		specWarnIceBlock:Show(args.sourceName)
	elseif spellId == 65801 and args:IsDestTypePlayer() then	-- Polymorph
		warnSheep:Show(args.destName)
	-- Warlock
	elseif spellId == 65809 then								-- Fear
		warnFear:Show(args.destName)
	-- Warrior
	elseif args:IsSpellID(65927, 65929) then						-- Charge
		warnCharge:Show(args.destName)
	-- Shaman
	elseif spellId == 66054 then								-- Hex
		warnHex:Show(args.destName)
	-- Priest
	-- Druid
	elseif spellId == 65859 and args:IsDestTypePlayer() then	-- Cyclone
		warnCyclone:Show(args.destName)
	elseif spellId == 65857 then								-- Entangling Roots
		warnEntanglingRoots:Show(args.destName)
	-- Rogue
	-- Hunter
	elseif spellId == 65871 then								-- Deterrence
		warnDeterrence:Show()
	elseif args:IsSpellID(65878, 65877) then						-- Wyvern Sting
		warnWyvernSting:Show(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
	if (spellId == 65817 or spellId ==  68142 or spellId == 68143 or spellId == 68144) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnHellfire:Show(spellName)
		specWarnHellfire:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34472 or cid == 34454 then -- Rogue
		timerShadowstepCD:Cancel()
		timerBlindCD:Cancel()
		DBM.BossHealth:RemoveBoss(34472)
		DBM.BossHealth:RemoveBoss(34454)
	elseif cid == 34458 or cid == 34461 then -- DK
		timerDeathgripCD:Cancel()
		DBM.BossHealth:RemoveBoss(34458)
		DBM.BossHealth:RemoveBoss(34461)
	elseif cid == 34475 or cid == 34453 then -- Warrior
		timerBladestormCD:Cancel()
		preWarnBladestorm:Cancel()
		DBM.BossHealth:RemoveBoss(34475)
		DBM.BossHealth:RemoveBoss(34453)
	elseif cid == 34460 or cid == 34451 then -- Balance Druid
		DBM.BossHealth:RemoveBoss(34460)
		DBM.BossHealth:RemoveBoss(34451)
	elseif cid == 34469 or cid == 34459 then -- Resto Druid
		DBM.BossHealth:RemoveBoss(34469)
		DBM.BossHealth:RemoveBoss(34459)
	elseif cid == 34467 or cid == 34448 then -- Hunter
		timerFrostTrapCD:Cancel()
		timerDisengageCD:Cancel()
		DBM.BossHealth:RemoveBoss(34467)
		DBM.BossHealth:RemoveBoss(34448)
	elseif cid == 34468 or cid == 34449 then -- Mage
		timerBlinkCD:Cancel()
		DBM.BossHealth:RemoveBoss(34468)
		DBM.BossHealth:RemoveBoss(34449)
	elseif cid == 34465 or cid == 34445 then -- Holy Paladin
		timerHoJCD:Cancel()
		timerHoPCD:Cancel()
		DBM.BossHealth:RemoveBoss(34465)
		DBM.BossHealth:RemoveBoss(34445)
	elseif cid == 34471 or cid == 34456 then -- Retri Paladin
		timerHoJCD:Cancel()
		timerRepentanceCD:Cancel()
		timerHoPCD:Cancel()
		DBM.BossHealth:RemoveBoss(34471)
		DBM.BossHealth:RemoveBoss(34456)
	elseif cid == 34466 or cid == 34447 then -- Disco Priest
		timerPsychicScreamCD:Cancel()
		DBM.BossHealth:RemoveBoss(34466)
		DBM.BossHealth:RemoveBoss(34447)
	elseif cid == 34473 or cid == 34441 then -- Shadow Priest
		timerPsychicScreamCD:Cancel()
		timerSilenceCD:Cancel()
		DBM.BossHealth:RemoveBoss(34473)
		DBM.BossHealth:RemoveBoss(34441)
	elseif cid == 34463 or cid == 34455 then -- Enh Shaman
		if cid == 34463 then
			timerHeroismCD:Cancel()
		else
			timerBloodlustCD:Cancel()
		end
		DBM.BossHealth:RemoveBoss(34463)
		DBM.BossHealth:RemoveBoss(34455)
	elseif cid == 34470 or cid == 34444 then -- Resto Shaman
		if cid == 34470 then
			timerHeroismCD:Cancel()
		else
			timerBloodlustCD:Cancel()
		end
		DBM.BossHealth:RemoveBoss(34470)
		DBM.BossHealth:RemoveBoss(34444)
	elseif cid == 34474 or cid == 34450 then -- Warlock
		DBM.BossHealth:RemoveBoss(34474)
		DBM.BossHealth:RemoveBoss(34450)
	end
end
