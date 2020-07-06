local mod	= DBM:NewMod("Champions", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3726 $"):sub(12, -3))
mod:SetCreatureID(34458, 34451, 34459, 34448, 34449, 34445, 34456, 34447, 34441, 34454, 34444, 34455, 34450, 34453, 34461, 34460, 34469, 34467, 34468, 34471, 34465, 34466, 34473, 34472, 34470, 34463, 34474, 34475)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)


mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_AURA_APPLIED",
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

local isDispeller = select(2, UnitClass("player")) == "WARRIOR"
				or select(2, UnitClass("player")) == "PRIEST"
				or select(2, UnitClass("player")) == "SHAMAN"


-- Announce: 1 - target player with CC, 2 - target player no CC, 3 - target self (npc)

-- Death Knight
local warnChainsofIce		= mod:NewTargetAnnounce(66020, 2) 				-- 66020
local warnDeathgrip			= mod:NewTargetAnnounce(66017, 2) 				-- 66017
-- Paladin
local warnHandofFreedom		= mod:NewTargetAnnounce(66115, 3) 				-- 66115 
local warnHandofProt		= mod:NewTargetAnnounce(66009, 3) 				-- 66009
local warnHoJ				= mod:NewTargetAnnounce(66613, 1) 				-- 66613, 66607
local warnRepentance		= mod:NewTargetAnnounce(66008, 1) 				-- 66008
local warnDivineShield		= mod:NewSpellAnnounce(66010, 3) 				-- 66010
local warnAvengingWrath		= mod:NewSpellAnnounce(66011, 3) 				-- 66011
-- Mage
local warnIceBlock			= mod:NewSpellAnnounce(65802, 3) 				-- 65802
local warnSheep				= mod:NewTargetAnnounce(65801, 1, nil, true) 	-- 65801
local warnBlink				= mod:NewSpellAnnounce(65793, 3) 				-- 65793
local warnCounterspell		= mod:NewTargetAnnounce(65790, 1)				-- 65790
-- Warlock
local warnHellfire			= mod:NewSpellAnnounce(68147, 4) 				-- 68147
local warnFear				= mod:NewTargetAnnounce(65809, 1) 				-- 65809
local warnDeathCoil			= mod:NewTargetAnnounce(65820, 1) 				-- 65820
-- Warrior
local preWarnBladestorm 	= mod:NewSoonAnnounce(65947, 3) 				-- 65947
local warnBladestorm		= mod:NewSpellAnnounce(65947, 4) 				-- 65947
local warnCharge			= mod:NewTargetAnnounce(65927, 2) 				-- 65927, 65929
local warnRetaliation		= mod:NewSpellAnnounce(65932, 3) 				-- 65932
local warnIntimidatingShout	= mod:NewSpellAnnounce(65931, 1) 				-- 65931
-- Shaman
local warnHeroism			= mod:NewSpellAnnounce(65983, 3) 				-- 65983
local warnBloodlust			= mod:NewSpellAnnounce(65980, 3) 				-- 65980
local warnEarthShield		= mod:NewTargetAnnounce(66063, 3) 				-- 66063
local warnHex				= mod:NewTargetAnnounce(66054, 1) 				-- 66054
-- Priest
local warnDispersion		= mod:NewSpellAnnounce(65544, 3) 				-- 65544
local warnPsychicScream		= mod:NewSpellAnnounce(65543, 1) 				-- 65543
local warnPsychicHorror		= mod:NewTargetAnnounce(65545, 1) 				-- 65545
local warnSilence			= mod:NewTargetAnnounce(65542, 1) 				-- 65542
-- Druid
local warnBarkskin			= mod:NewSpellAnnounce(65860, 3) 				-- 65860
local warnTranquility		= mod:NewSpellAnnounce(66086, 4) 				-- 66086, 67976, 67975, 67974
local warnEntanglingRoots	= mod:NewTargetAnnounce(65857, 1) 				-- 65857
local warnCyclone			= mod:NewTargetAnnounce(65859, 1, nil, true) 	-- 65859
-- Rogue
local warnShadowstep		= mod:NewTargetAnnounce(36554, 2) 				-- 66178
local warnBlind				= mod:NewTargetAnnounce(65960, 1) 				-- 65960
local warnCloakOfShadows	= mod:NewSpellAnnounce(65961, 3) 				-- 65961
-- Hunter
local warnDeterrence		= mod:NewSpellAnnounce(65871, 3) 				-- 65871
local warnWingClip			= mod:NewTargetAnnounce(66207, 1) 				-- 66207
local warnWyvernSting		= mod:NewTargetAnnounce(65878, 1) 				-- 65878, 65877
local warnFrostTrap			= mod:NewSpellAnnounce(65880, 3) 				-- 65880
local warnDisengage			= mod:NewSpellAnnounce(65869, 3) 				-- 65869


local timerBladestorm		= mod:NewBuffActiveTimer(8, 65947)
local timerBladestormCD		= mod:NewCDTimer(90, 65947)
local timerShadowstepCD		= mod:NewCDTimer(20, 36554)
local timerBlindCD			= mod:NewCDTimer(120, 65960)
local timerDeathgripCD		= mod:NewCDTimer(20, 66017)
local timerFrostTrapCD		= mod:NewCDTimer(30, 65880)
local timerDisengageCD		= mod:NewCDTimer(30, 65869)	
local timerPsychicScreamCD	= mod:NewCDTimer(30, 65543)	
local timerBlinkCD			= mod:NewCDTimer(15, 65793)
local timerHoJCD			= mod:NewCDTimer(40, 66613)	
local timerRepentanceCD		= mod:NewCDTimer(60, 66008)
local timerHoPCD 			= mod:NewCDTimer(300, 66009)
local timerSilenceCD		= mod:NewCDTimer(45, 65542)
local timerHeroismCD		= mod:NewCDTimer(300, 65983)
local timerBloodlustCD		= mod:NewCDTimer(300, 65980)


local specWarnHellfire		= mod:NewSpecialWarningMove(68147)
local specWarnHandofProt	= mod:NewSpecialWarningDispel(66009, isDispeller)
local specWarnDivineShield	= mod:NewSpecialWarningDispel(66010, isDispeller) 
local specWarnIceBlock		= mod:NewSpecialWarningDispel(65802, isDispeller)
local specWarnHandofFreedom	= mod:NewSpecialWarningDispel(68758, isDispeller)
local specWarnTranquility 	= mod:NewSpecialWarningInterupt(66086)
local specWarnEarthShield	= mod:NewSpecialWarningDispel(66063, isDispeller)
local specWarnAvengingWrath = mod:NewSpecialWarningDispel(66011, isDispeller)
local specWarnBloodlust 	= mod:NewSpecialWarningDispel(65980, isDispeller)
local specWarnHeroism 		= mod:NewSpecialWarningDispel(65983, isDispeller)


mod:AddBoolOption("PlaySoundOnBladestorm", mod:IsMelee())

function mod:SPELL_CAST_SUCCESS(args)
	-- Death Knight
	if args:IsSpellID(66017, 68753, 68754, 68755) and args:IsDestTypePlayer() then	-- Death Grip 
		warnDeathgrip:Show(args.destName)
		timerDeathgripCD:Start()
	elseif args:IsSpellID(66020) and args:IsDestTypePlayer() then 	-- Chains of Ice 
		warnChainsofIce:Show(args.destName)
	-- Paladin
	elseif args:IsSpellID(68758, 68757, 68756, 66115) and not args:IsDestTypePlayer() then	-- Hand of Freedom 
		warnHandofFreedom:Show(args.destName)
		specWarnHandofFreedom:Show(args.destName)
	elseif args:IsSpellID(66009) then								-- Hand of Protection 
		warnHandofProt:Show(args.destName)
		specWarnHandofProt:Show(args.destName)
		timerHoPCD:Start()
	elseif args:IsSpellID(66008) then								-- Repentance 
		warnRepentance:Show(args.destName)
		timerRepentanceCD:Start()
	elseif args:IsSpellID(66613, 66007) then						-- Hammer of Justice 
		warnHoJ:Show(args.destName)
		timerHoJCD:Start()
	elseif args:IsSpellID(66010) then								-- Divine Shield
		warnDivineShield:Show()
		specWarnDivineShield:Show()
	elseif args:IsSpellID(66011) then								-- Avenging Wrath  
		warnAvengingWrath:Show()
		specWarnAvengingWrath:Show()
	-- Mage
	elseif args:IsSpellID(65802) then								-- Ice Block 
		warnIceBlock:Show()
		specWarnIceBlock:Show()
	elseif args:IsSpellID(65793) then								-- Blink
		warnBlink:Show()
		timerBlinkCD:Start()
	elseif args:IsSpellID(65790) then								-- Counterspell
		warnCounterspell:Show(args.destName)
	-- Warlock
	elseif args:IsSpellID(65816, 68145, 68146, 68147) then			-- Hellfire 
		warnHellfire:Show()
	elseif args:IsSpellID(65820, 68141, 68139, 68140) then			-- Death Coil 
		warnDeathCoil:Show(args.destName)
	-- Warrior
	elseif args:IsSpellID(65947) then								-- Bladestorm 
		warnBladestorm:Show()
		timerBladestorm:Start()
		timerBladestormCD:Start()
		preWarnBladestorm:Schedule(85)
		if self.Options.PlaySoundOnBladestorm then
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	elseif args:IsSpellID(65932) then								-- Retaliation 
		warnRetaliation:Show()
	elseif args:IsSpellID(65931) then								-- Intimidating Shout 
		warnIntimidatingShout:Show()
	-- Shaman
	elseif args:IsSpellID(66063) then								-- Earth Shield 
		warnEarthShield:Show(args.destName)
		specWarnEarthShield:Show(args.destName)
	-- Priest
	elseif args:IsSpellID(65544) then								-- Dispersion 
		warnDispersion:Show()
	elseif args:IsSpellID(65543) then								-- Psychic Scream 
		warnPsychicScream:Show()
	elseif args:IsSpellID(65545) then								-- Psychic Horror 
		warnPsychicHorror:Show(args.destName)
	elseif args:IsSpellID(65542) then								-- Silence
		warnSilence:Show(args.destName)
		timerSilenceCD:Start()
	-- Druid
	elseif args:IsSpellID(65860) then								-- Barkskin
		warnBarkskin:Show()
	-- Rogue
	elseif args:IsSpellID(66178, 68759, 68760, 68761) then			-- Shadowstep 
		warnShadowstep:Show()
		timerShadowstepCD:Start()
	elseif args:IsSpellID(65960) then								-- Blind
		warnBlind:Show(args.destName)
		timerBlindCD:Start()
	elseif args:IsSpellID(65961) then								-- Cloak of Shadows
		warnCloakOfShadows:Show()
	-- Hunter
	elseif args:IsSpellID(66207) then								-- Wing Clip
		warnWingClip:Show(args.destName)
	elseif args:IsSpellID(65880) then								-- Frost Trap
		warnFrostTrap:Show()
		timerFrostTrapCD:Start()
	elseif args:IsSpellID(65869) then								-- Disengage
		warnDisengage:Show()
		timerDisengageCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	-- Death Knight
	-- Paladin
	-- Mage
	if args:IsSpellID(65801) then									-- Polymorph
		warnSheep:Show(args.destName)
	-- Warlock
	elseif args:IsSpellID(65809) then								-- Fear
		warnFear:Show(args.destName)
	-- Warrior
	elseif args:IsSpellID(65927, 65929) then						-- Charge
		warnCharge:Show(args.destName)
	-- Shaman
	elseif args:IsSpellID(66054) then								-- Hex
		warnHex:Show(args.destName)
	elseif args:IsSpellID(65983) then								-- Heroism
		warnHeroism:Show()
		specWarnHeroism:Show()
		timerHeroismCD:Start()
	elseif args:IsSpellID(65980) then								-- Bloodlust
		warnBloodlust:Show()
		specWarnBloodlust:Show()
		timerBloodlustCD:Start()
	-- Priest
	-- Druid
	elseif args:IsSpellID(65859) then								-- Cyclone
		warnCyclone:Show(args.destName)
	elseif args:IsSpellID(65857) then								-- Entangling Roots
		warnEntanglingRoots:Show(args.destName)
	elseif args:IsSpellID(66086, 67974, 67975, 67976) then			-- Tranquility
		warnTranquility:Show()
		specWarnTranquility:Show()
	-- Rogue
	-- Hunter
	elseif args:IsSpellID(65871) then								-- Deterrence
		warnDeterrence:Show()
	elseif args:IsSpellID(65878, 65877) then						-- Wyvern Sting
		warnWyvernSting:Show(args.destName)
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsPlayer() and args:IsSpellID(65817, 68142, 68143, 68144) then
		specWarnHellfire:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34472 or cid == 34454 then -- Rogue
		timerShadowstepCD:Cancel()
		timerBlindCD:Cancel()
	elseif cid == 34458 or cid == 34461 then -- DK
		timerDeathgripCD:Cancel()
	elseif cid == 34475 or cid == 34453 then -- Warrior
		timerBladestormCD:Cancel()
		preWarnBladestorm:Cancel()
	--elseif cid == 34460 or cid == 34451 then -- Balance Druid
	--elseif cid == 34469 or cid == 34459 then -- Resto Druid
	elseif cid == 34467 or cid == 34448 then -- Hunter
		timerFrostTrapCD:Cancel()
		timerDisengageCD:Cancel()
	elseif cid == 34468 or cid == 34449 then -- Mage
		timerBlinkCD:Cancel()
	elseif cid == 34465 or cid == 34445 then -- Holy Paladin
		timerHoJCD:Cancel()
		timerHoPCD:Cancel()
	elseif cid == 34471 or cid == 34456 then -- Retri Paladin
		timerHoJCD:Cancel()
		timerRepentanceCD:Cancel()
		timerHoPCD:Cancel()
	elseif cid == 34466 or cid == 34447 then -- Disco Priest
		timerPsychicScreamCD:Cancel()
	elseif cid == 34473 or cid == 34441 then -- Shadow Priest
		timerPsychicScreamCD:Cancel()
		timerSilenceCD:Cancel()
	elseif cid == 34463 or cid == 34455 then -- Enh Shaman
		if cid == 34463 then
			timerHeroismCD:Cancel()
		else
			timerBloodlustCD:Cancel()
		end
	elseif cid == 34470 or cid == 34444 then -- Resto Shaman
		if cid == 34470 then
			timerHeroismCD:Cancel()
		else
			timerBloodlustCD:Cancel()
		end
	--elseif cid == 34474 or cid == 34450 then -- Warlock
	end
end