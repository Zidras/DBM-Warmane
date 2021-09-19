local mod	= DBM:NewMod("Deathbringer", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4408 $"):sub(12, -3))
mod:SetCreatureID(37813)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_HEALTH",
	"CHAT_MSG_MONSTER_YELL"
)
local canShadowmeld = select(2, UnitRace("player")) == "NightElf"
local canVanish = select(2, UnitClass("player")) == "ROGUE"

local warnFrenzySoon		= mod:NewSoonAnnounce(72737, 2, nil, "Tank|Healer")
local warnAddsSoon			= mod:NewPreWarnAnnounce(72173, 10, 3)
local warnAdds				= mod:NewSpellAnnounce(72173, 4)
local warnFrenzy			= mod:NewSpellAnnounce(72737, 2, nil, "Tank|Healer")
local warnBloodNova			= mod:NewSpellAnnounce(72378, 2)
local warnMark 				= mod:NewTargetCountAnnounce(72293, 4, 72293)
local warnBoilingBlood		= mod:NewTargetAnnounce(72385, 2, nil, "Healer")
local warnRuneofBlood		= mod:NewTargetAnnounce(72410, 3, nil, "Tank|Healer")

local specwarnMark			= mod:NewSpecialWarningTarget(72444, nil, false, nil, 1, 2)
local specwarnRuneofBlood	= mod:NewSpecialWarningTaunt(72410, nil, nil, nil, 1, 2)
local specwarnRuneofBloodYou= mod:NewSpecialWarningYou(72410, "Tank")

local timerCombatStart		= mod:NewCombatTimer(47.3)
local timerRuneofBlood		= mod:NewNextTimer(20, 72410, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerBoilingBlood		= mod:NewNextTimer(15.5, 72441, nil, "Healer", nil, 5, nil, DBM_CORE_L.HEALER_ICON)
local timerBloodNova		= mod:NewNextTimer(20, 73058, nil, nil, nil, 2)
local timerCallBloodBeast	= mod:NewNextTimer(40, 72173, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON, nil, 3)

local soundSpecWarnMark		= mod:NewSound(72293, nil, canShadowmeld or canVanish)

local enrageTimer			= select(3, DBM:GetMyPlayerInfo()) == "Lordaeron" and mod:NewBerserkTimer(420) or mod:NewBerserkTimer(480)

mod:AddBoolOption("RangeFrame", "Ranged")
mod:AddBoolOption("RunePowerFrame", false, "misc")
mod:AddSetIconOption("BeastIcons", 72173, true, true)
mod:AddBoolOption("BoilingBloodIcons", false)
mod:AddInfoFrameOption(72370, false)
mod:AddBoolOption("RemoveDI")
mod:RemoveOption("HealthFrame")

mod.vb.warned_preFrenzy = false
mod.vb.boilingBloodIcon 	= 8
mod.vb.Mark = 0
local boilingBloodTargets = {}
local spellName = DBM:GetSpellInfo(72370)
local UnitGUID = UnitGUID

local function warnBoilingBloodTargets(self)
	warnBoilingBlood:Show(table.concat(boilingBloodTargets, "<, >"))
	table.wipe(boilingBloodTargets)
	self.vb.boilingBloodIcon = 8
	timerBoilingBlood:Start()
end

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
	timerCallBloodBeast:Start(40-delay)
	warnAddsSoon:Schedule(30-delay)
	timerBloodNova:Start(-delay)
	timerRuneofBlood:Start(19.5-delay)
	timerBoilingBlood:Start(19-delay)
	table.wipe(boilingBloodTargets)
	self.vb.warned_preFrenzy = false
	self.vb.boilingBloodIcon = 8
	self.vb.Mark = 0
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

do	-- add the additional Rune Power Bar
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

function mod:FallenMarkTarget(targetname)
    if not targetname then return end
    if targetname == UnitName("player") then
		if canShadowmeld then
			soundSpecWarnMark:Play("Interface\\AddOns\\DBM-Core\\sounds\\PlayerAbilities\\Shadowmeld.ogg")
		elseif canVanish then
			soundSpecWarnMark:Play("Interface\\AddOns\\DBM-Core\\sounds\\PlayerAbilities\\Vanish.ogg")
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(73058, 72378) then	-- Blood Nova (only 2 cast IDs, 4 spell damage IDs, and one dummy)
		warnBloodNova:Show()
		timerBloodNova:Start()
	elseif args.spellId == 72293 then
        self:BossTargetScanner(37813, "FallenMarkTarget", 0.01, 10)
    end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 72410 then
		warnRuneofBlood:Show(args.destName)
		if not args:IsPlayer() then
			specwarnRuneofBlood:Show(args.destName)
			specwarnRuneofBlood:Play("tauntboss")
		else
			specwarnRuneofBloodYou:Show()
		end
		timerRuneofBlood:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(72172, 72173) or args:IsSpellID(72356, 72357, 72358) then -- Summon Blood Beasts
		if self:AntiSpam(5) then
			warnAdds:Show()
			warnAddsSoon:Schedule(30)
			timerCallBloodBeast:Start()
		end
		if self.Options.BeastIcons then
			if self:IsDifficulty("normal25", "heroic25") then
				self:ScanForMobs(args.destGUID, 0, 8, 5, 0.1, 20, "BeastIcons")
			else
				self:ScanForMobs(args.destGUID, 0, 8, 2, 0.1, 20, "BeastIcons")
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 72293 then		-- Mark of the Fallen Champion
		self.vb.Mark = self.vb.Mark + 1
		warnMark:Show(self.vb.Mark, args.destName)
		specwarnMark:Show(args.destName)
	elseif args:IsSpellID(72385, 72441, 72442, 72443) then	-- Boiling Blood
		boilingBloodTargets[#boilingBloodTargets + 1] = args.destName
		if self.Options.BoilingBloodIcons then
			self:SetIcon(args.destName, self.vb.boilingBloodIcon, 15)
		end
		self.vb.boilingBloodIcon = self.vb.boilingBloodIcon - 1
		self:Unschedule(warnBoilingBloodTargets)
		if self:IsDifficulty("normal10", "heroic10") or (self:IsDifficulty("normal25", "heroic25") and #boilingBloodTargets >= 3) then	-- Boiling Blood
			warnBoilingBloodTargets(self)
		else
			self:Schedule(0.5, warnBoilingBloodTargets, self)
		end
	elseif args.spellId == 72737 then						-- Frenzy
		warnFrenzy:Show()
	elseif args.spellId == 19753 and self:IsInCombat() and self.Options.RemoveDI then	-- Remove Divine Intervention
		CancelUnitBuff("player", GetSpellInfo(19753))
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(72385, 72441, 72442, 72443) and self.Options.BoilingBloodIcons then
		self:SetIcon(args.destName, 0)
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
		timerCombatStart:Start(99.5)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(12)
		end
	end
end