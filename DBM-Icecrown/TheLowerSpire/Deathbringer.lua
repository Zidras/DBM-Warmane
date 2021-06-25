local mod	= DBM:NewMod("Deathbringer", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4408 $"):sub(12, -3))
mod:SetCreatureID(37813)
mod:RegisterCombat("combat")
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_HEALTH",
	"CHAT_MSG_MONSTER_YELL"
)

local warnFrenzySoon		= mod:NewSoonAnnounce(72737, 2, nil, true)
local warnAddsSoon			= mod:NewPreWarnAnnounce(72173, 10, 3)
local warnAdds				= mod:NewSpellAnnounce(72173, 4)
local warnFrenzy			= mod:NewSpellAnnounce(72737, 2, nil, true)
local warnBloodNova			= mod:NewSpellAnnounce(73058, 2)
local warnMark				= mod:NewTargetCountAnnounce(72444, 4)
local warnBoilingBlood		= mod:NewTargetAnnounce(72441, 2, nil, "Healer")
local warnRuneofBlood		= mod:NewTargetAnnounce(72410, 3, nil, "Tank|Healer")

local specwarnMark			= mod:NewSpecialWarningTarget(72444, nil, false, nil, 1, 2)
local specwarnRuneofBlood	= mod:NewSpecialWarningTaunt(72410, nil, nil, nil, 1, 2)
local specwarnRuneofBloodYou= mod:NewSpecialWarningYou(72410, mod:IsTank())
local timerCombatStart		= mod:NewCombatTimer(47.3)
local timerRuneofBlood		= mod:NewNextTimer(20, 72410, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_TANK_ICON)
local timerBoilingBlood		= mod:NewNextTimer(15.5, 72441, nil, "Healer", nil, 5, nil, DBM_CORE_HEALER_ICON)
local timerBloodNova		= mod:NewNextTimer(20, 73058, nil, nil, nil, 2)
local timerCallBloodBeast	= mod:NewNextTimer(40, 72173, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON, nil, 3)

local enrageTimer			= mod:NewBerserkTimer(480)
local soundFrenzy			= mod:NewSound(72737)
local SoundAdds				= mod:NewSound(72173)

mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("RunePowerFrame", true, "misc")
mod:AddSetIconOption("BeastIcons", 72173, true, true, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddBoolOption("BoilingBloodIcons", false)
mod:RemoveOption("HealthFrame")

local warned_preFrenzy = false
local boilingBloodTargets = {}
local boilingBloodIcon 	= 8
local spamBloodBeast = 0
local Mark = 0
local UnitGUID = UnitGUID

local function warnBoilingBloodTargets()
	warnBoilingBlood:Show(table.concat(boilingBloodTargets, "<, >"))
	table.wipe(boilingBloodTargets)
	boilingBloodIcon = 8
end

function mod:OnCombatStart(delay)
	if self.Options.RunePowerFrame then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(37813, L.name)
		self:ScheduleMethod(0.5, "CreateBossRPFrame")
	end
	if mod:IsDifficulty("normal10") or mod:IsDifficulty("normal25") then
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
	warned_preFrenzy = false
	boilingBloodIcon = 8
	Mark = 0
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(12)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
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

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(73058, 72378) then	-- Blood Nova (only 2 cast IDs, 4 spell damage IDs, and one dummy)
		warnBloodNova:Show()
		timerBloodNova:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(72410) then
		warnRuneofBlood:Show(args.destName)
		if not args:IsPlayer() then
			specwarnRuneofBlood:Show(args.destName)
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
			SoundAdds:Play("Interface\\AddOns\\DBM-Core\\sounds\\Long.mp3")
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
	if args:IsSpellID(72293) then		-- Mark of the Fallen Champion
		Mark = Mark + 1
		warnMark:Show(Mark, args.destName)
		specwarnMark:Show(args.destName)
	elseif args:IsSpellID(72385, 72441, 72442, 72443) then	-- Boiling Blood
		boilingBloodTargets[#boilingBloodTargets + 1] = args.destName
		timerBoilingBlood:Start()
		if self.Options.BoilingBloodIcons then
			self:SetIcon(args.destName, boilingBloodIcon, 15)
			boilingBloodIcon = boilingBloodIcon - 1
		end
		self:Unschedule(warnBoilingBloodTargets)
		if (mod:IsDifficulty("normal10") or mod:IsDifficulty("heroic10")) or ((mod:IsDifficulty("normal25") or mod:IsDifficulty("heroic25")) and #boilingBloodTargets >= 3) then	-- Boiling Blood
			warnBoilingBloodTargets()
		else
			self:Schedule(0.3, warnBoilingBloodTargets)
		end
	elseif args:IsSpellID(72737) then						-- Frenzy
		warnFrenzy:Show()
		soundFrenzy:Play("Interface\\AddOns\\DBM-Core\\sounds\\Info.mp3")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(72385, 72441, 72442, 72443) then
		self:SetIcon(args.destName, 0)
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_preFrenzy and self:GetUnitCreatureId(uId) == 37813 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.33 then
		warned_preFrenzy = true
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
