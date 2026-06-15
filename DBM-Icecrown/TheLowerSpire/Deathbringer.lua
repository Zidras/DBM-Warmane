local mod	= DBM:NewMod("Deathbringer", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230627223940")
mod:SetCreatureID(37813)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetMinSyncRevision(20220905000000)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 73058 72378", -- 72293",
	"SPELL_CAST_SUCCESS 72410 72769 72385 72441 72442 72443",
	"SPELL_AURA_APPLIED 72293 72385 72441 72442 72443 72737", -- 19753",
	"SPELL_AURA_REMOVED 72385 72441 72442 72443",
	"SPELL_SUMMON 72172 72173 72356 72357 72358",
	"UNIT_DIED",
	"UNIT_HEALTH boss1"
)

--local canShadowmeld = select(2, UnitRace("player")) == "NightElf"
--local canVanish = select(2, UnitClass("player")) == "ROGUE"
local myRealm = select(3, DBM:GetMyPlayerInfo())

-- General
local timerCombatStart		= mod:NewCombatTimer(47.10)
local enrageTimer			= mod:NewBerserkTimer((myRealm == "Lordaeron" or myRealm == "Frostmourne") and 420 or 480)

mod:RemoveOption("HealthFrame")
mod:AddBoolOption("RunePowerFrame", false, "misc")
--mod:AddBoolOption("RemoveDI")

-- Deathbringer Saurfang
mod:AddTimerLine(BOSS)
local warnFrenzySoon		= mod:NewSoonAnnounce(72737, 2, nil, "Tank|Healer")
local warnFrenzy			= mod:NewSpellAnnounce(72737, 2, nil, "Tank|Healer")
local warnBloodNova			= mod:NewSpellAnnounce(72378, 2)
local warnMark				= mod:NewTargetCountAnnounce(72293, 4, 72293, nil, 28836, nil, nil, nil, true)
local warnBoilingBlood		= mod:NewTargetNoFilterAnnounce(72385, 2, nil, "Healer")
local warnRuneofBlood		= mod:NewTargetNoFilterAnnounce(72410, 3, nil, "Tank|Healer")

local specwarnMark			= mod:NewSpecialWarningYou(72444, nil, 28836, nil, 1, 2)
local specwarnRuneofBlood	= mod:NewSpecialWarningTaunt(72410, nil, nil, nil, 1, 2)
local specwarnRuneofBloodYou= mod:NewSpecialWarningYou(72410, "Tank")

local timerRuneofBlood		= mod:NewNextTimer(20, 72410, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON) -- REVIEW! HC -> wipe -> N different script? First two timers stopped being fixed? (25N Lordaeron 2023/02/10) - pull:20.8, 19.3, 20.0, 20.0, 20.0, 20.1, 20.0, 20.0, 20.0, 20.0
local timerBoilingBlood		= mod:NewCDTimer(15, 72385, nil, "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON, true) -- REVIEW! ~5s variance [15-20.42]; there was one 11.7! Same as above?? Added "keep" arg (10N Icecrown 2022/08/25 || 25H Lordaeron 2022/09/04 || 25N Lordaeron 2023/02/10 || 25H Lordaeron [2023-08-23]@[20:27:43]) - 19.2, 15.5, 15.7, 17.7, 18.1, 15.7, 16.9, 19.5, 15.3, 19.5, 18.5, 15.2, 19.9 || 15.1, 19.4, 19.0, 15.4, 15.0, 16.8, 19.1, 15.9, 17.1 || 11.7, 16.4, 16.5, 17.4, 19.6, 19.0, 16.5, 16.9, 15.5, 16.4, 17.5 || pull:15.5, 18.5, 17.3, 19.4, 19.7, 20.4, 17.0, 17.0, 15.0
local timerBloodNova		= mod:NewCDTimer(20, 72378, nil, nil, nil, 2, nil, nil, true) -- 5s variance [20-25]. Added "keep" arg (10N Icecrown 2022/08/25 || 25H Lordaeron 2022/09/04) - 21.7, 21.7, 20.9, 22.6, 20.2, 24.8, 24.6, 20.7, 22.2, 22.4 || 24.9, 21.8, 21.0, 22.8, 23.2, 24.3, 22.2

--local soundSpecWarnMark		= mod:NewSound(72293, nil, canShadowmeld or canVanish)

mod:AddRangeFrameOption(12, 72378, "Ranged")
mod:AddInfoFrameOption(72370, false)--Off by default, since you can literally just watch the bosses power bar
mod:AddSetIconOption("BoilingBloodIcons", 72385, false, 0, {1, 2, 3})

-- Blood Beasts
mod:AddTimerLine(DBM_COMMON_L.ADDS)
local warnAddsSoon			= mod:NewPreWarnAnnounce(72173, 10, 3)
local warnAdds				= mod:NewSpellAnnounce(72173, 4)

local specWarnScentofBlood	= mod:NewSpecialWarningSpell(72769, nil, nil, nil, nil, nil, 3) -- Heroic Ablility

local timerCallBloodBeast	= mod:NewNextTimer(40, 72173, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON, nil, 3)
local timerNextScentofBlood	= mod:NewNextTimer(10, 72769, nil, nil, nil, 2) -- 10 seconds after Beasts spawn, if any of them is alive

mod:AddSetIconOption("BeastIcons", 72173, true, 5, {8, 7, 6, 5, 4})

mod.vb.warned_preFrenzy = false
mod.vb.boilingBloodIcon = 1
mod.vb.beastIcon = 8
mod.vb.Mark = 0
mod.vb.bloodBeastAlive = 0
local spellName = DBM:GetSpellInfo(72370)

do	-- add the additional Rune Power Bar
	local UnitGUID = UnitGUID
	local last = 0
	local function getRunePowerPercent()
		local guid = UnitGUID("focus")
		if mod:GetCIDFromGUID(guid) == 37813 then
			last = math.floor(UnitPower("focus")/UnitPowerMax("focus") * 100)
			return last
		end
		for i = 0, GetNumRaidMembers(), 1 do
			local unitId = ((i == 0) and "target") or ("raid"..i.."target")
			guid = UnitGUID(unitId)
			if mod:GetCIDFromGUID(guid) == 37813 then
				last = math.floor(UnitPower(unitId)/UnitPowerMax(unitId) * 100)
				return last
			end
		end
		return last
	end
	function mod:CreateBossRPFrame()
		DBM.BossHealth:AddBoss(getRunePowerPercent, L.RunePower)
	end
end

--[[function mod:FallenMarkTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		if canShadowmeld then
			soundSpecWarnMark:Play("Interface\\AddOns\\DBM-Core\\sounds\\PlayerAbilities\\Shadowmeld.ogg")
		elseif canVanish then
			soundSpecWarnMark:Play("Interface\\AddOns\\DBM-Core\\sounds\\PlayerAbilities\\Vanish.ogg")
		end
	end
end]]

function mod:OnCombatStart(delay)
	if self.Options.RunePowerFrame then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(37813, L.name)
		self:ScheduleMethod(0.5, "CreateBossRPFrame")
	end
	if self:IsNormal() then
		enrageTimer:Start(-delay)
	else
		enrageTimer:Start(360-delay)
	end
	timerCallBloodBeast:Start(-delay)
	warnAddsSoon:Schedule(30-delay)
	timerBloodNova:Start(17-delay) -- (10N Icecrown 2022/08/25 || 10H Lordaeron 2022/09/02 || 25H Lordaeron 2022/09/04 || 25H Lordaeron 2023/02/10 18:54:04 || 25H Lordaeron 2023/02/10 19:02:29 || 25N Lordaeron 2023/02/10 19:10:14) - 17.1 || 17.0 || 17.0 || 17.0 || 17.0 || 20.3
	timerRuneofBlood:Start(-delay) -- (25H Lordaeron 2023/02/10 18:54:04 || 25H Lordaeron 2023/02/10 19:02:29 || 25N Lordaeron 2023/02/10 19:10:14) - 20.0 || 20.0 || 20.8
	timerBoilingBlood:Start(15.5-delay) -- (10N Icecrown 2022/08/25 || 10H Lordaeron 2022/09/02 || 25H Lordaeron 2022/09/04 || 25H Lordaeron 2023/02/10 18:54:04 || 25H Lordaeron 2023/02/10 19:02:29 || 25N Lordaeron 2023/02/10 19:10:14) - 15.5 || 15.5|| 15.5 || 15.6 || 15.5 || 19.4
	self.vb.warned_preFrenzy = false
	self.vb.boilingBloodIcon = 1
	self.vb.beastIcon = 8
	self.vb.Mark = 0
	self.vb.bloodBeastAlive = 0
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(12)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(spellName)
		DBM.InfoFrame:Show(1, "enemypower", 2)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	DBM.BossHealth:Clear()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(73058, 72378) then	-- Blood Nova (only 2 cast IDs, 4 spell damage IDs, and one dummy)
		warnBloodNova:Show()
		timerBloodNova:Start()
--	elseif args.spellId == 72293 then
--		self:BossTargetScanner(37813, "FallenMarkTarget", 0.01, 10)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 72410 then
		warnRuneofBlood:Show(args.destName)
		if not args:IsPlayer() then
			specwarnRuneofBlood:Show(args.destName)
			specwarnRuneofBlood:Play("tauntboss")
		else
			specwarnRuneofBloodYou:Show()
		end
		timerRuneofBlood:Start()
	elseif spellId == 72769 then
		specWarnScentofBlood:Show()
	elseif args:IsSpellID(72385, 72441, 72442, 72443) then -- Boiling Blood
		self.vb.boilingBloodIcon = 1
		timerBoilingBlood:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 72293 then		-- Mark of the Fallen Champion
		self.vb.Mark = self.vb.Mark + 1
		warnMark:Show(self.vb.Mark, args.destName)
		if args:IsPlayer() then
			specwarnMark:Show()
			specwarnMark:Play("defensive")
		end
	elseif args:IsSpellID(72385, 72441, 72442, 72443) then	-- Boiling Blood
		if self.Options.BoilingBloodIcons then
			self:SetIcon(args.destName, self.vb.boilingBloodIcon)
		end
		self.vb.boilingBloodIcon = self.vb.boilingBloodIcon + 1
		warnBoilingBlood:CombinedShow(0.5, args.destName)
	elseif spellId == 72737 then						-- Frenzy
		warnFrenzy:Show()
--	elseif spellId == 19753 and self:IsInCombat() and self.Options.RemoveDI then	-- Remove Divine Intervention
--		CancelUnitBuff("player", GetSpellInfo(19753))
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(72385, 72441, 72442, 72443) and self.Options.BoilingBloodIcons then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(72172, 72173) or args:IsSpellID(72356, 72357, 72358) then -- Summon Blood Beasts
		if self:AntiSpam(5) then
			self.vb.beastIcon = 8
			self.vb.bloodBeastAlive = self.vb.bloodBeastAlive + (self:IsDifficulty("normal25", "heroic25") and 5 or 2)
			warnAdds:Show()
			warnAddsSoon:Schedule(30)
			timerCallBloodBeast:Start()
			if self:IsHeroic() then
				timerNextScentofBlood:Start()
			end
		end
		if self.Options.BeastIcons then
			self:ScanForMobs(args.destGUID, 2, self.vb.beastIcon, 1, nil, 10, "BeastIcons")
		end
		self.vb.beastIcon = self.vb.beastIcon - 1
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 38508 then -- Blood Beast
		self.vb.bloodBeastAlive = self.vb.bloodBeastAlive - 1
		if self.vb.bloodBeastAlive == 0 then
			timerNextScentofBlood:Cancel()
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warned_preFrenzy and self:GetUnitCreatureId(uId) == 37813 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.33 then
		self.vb.warned_preFrenzy = true
		warnFrenzySoon:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:find(L.PullAlliance, 1, true) then
		timerCombatStart:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(12)
		end
	elseif msg:find(L.PullHorde, 1, true) then
		timerCombatStart:Start(98.72)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(12)
		end
	end
end
