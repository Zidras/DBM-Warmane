local mod	= DBM:NewMod("Deathwhisper", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4411 $"):sub(12, -3))
mod:SetCreatureID(36855)
mod:SetUsedIcons(4, 5, 6, 7, 8)
mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_INTERRUPT",
	"SPELL_SUMMON",
	"SWING_DAMAGE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_TARGET"
)

local canPurge = select(2, UnitClass("player")) == "MAGE"
			or select(2, UnitClass("player")) == "SHAMAN"
			or select(2, UnitClass("player")) == "PRIEST"
local isHunter = select(2, UnitClass("player")) == "HUNTER"
local warnAddsSoon					= mod:NewAnnounce("WarnAddsSoon", 2)
local warnDominateMind				= mod:NewTargetAnnounce(71289, 3)
local warnDeathDecay				= mod:NewSpellAnnounce(72108, 2)
local warnSummonSpirit				= mod:NewSpellAnnounce(71426, 2)
local warnReanimating				= mod:NewAnnounce("WarnReanimating", 3)
local warnDarkTransformation		= mod:NewSpellAnnounce(70900, 4)
local warnDarkEmpowerment			= mod:NewSpellAnnounce(70901, 4)
local warnPhase2					= mod:NewPhaseAnnounce(2, 1)
local warnFrostbolt					= mod:NewCastAnnounce(72007, 2, 2, nil, "Tank")
local warnDarkMartyrdom				= mod:NewSpellAnnounce(72499, 4)
local warnTouchInsignificance		= mod:NewStackAnnounce(71204, 2, nil, true)

local specWarnCurseTorpor			= mod:NewSpecialWarningYou(71237, nil, nil, nil, 1, 2)
local specWarnDeathDecay			= mod:NewSpecialWarningMove(72108, nil, nil, nil, 1, 2)
local specWarnTouchInsignificance	= mod:NewSpecialWarningStack(71204, nil, 3, nil, nil, 1, 6)
local specWarnVampricMight			= mod:NewSpecialWarningDispel(70674, "MagicDispeller", nil, nil, 1, 2)
local specWarnDarkMartyrdom			= mod:NewSpecialWarningRun(72499, "Melee", nil, nil, 4, 2)
local specWarnFrostbolt				= mod:NewSpecialWarningInterrupt(72007, nil, false, 2, 1, 2) -- HasInterrupt?
local specWarnVengefulShade			= mod:NewSpecialWarning("SpecWarnVengefulShade", "-Tank")
local specWarnWeapons				= mod:NewSpecialWarning("WeaponsStatus", false)

local timerAdds						= mod:NewTimer(45, "TimerAdds", 61131, nil, nil, 1, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON)
local timerDominateMind				= mod:NewBuffActiveTimer(12, 71289)
local timerDominateMindCD			= mod:NewCDTimer(40, 71289, nil, nil, nil, 3)
local timerSummonSpiritCD			= mod:NewCDTimer(10, 71426, nil, true, 2)
local timerFrostboltCast			= mod:NewCastTimer(2, 72007, nil, "Tank")
local timerTouchInsignificance		= mod:NewTargetTimer(30, 71204, nil, "Tank|Healer", nil, 5)

local berserkTimer					= mod:NewBerserkTimer(600)
local soundWarnSpirit				= mod:NewSound(71426)
local soundWarnMC					= mod:NewSound5(71289)

mod:AddBoolOption("SetIconOnDominateMind", true)
mod:AddBoolOption("SetIconOnDeformedFanatic", true)
mod:AddBoolOption("SetIconOnEmpoweredAdherent", false)
mod:AddBoolOption("ShieldHealthFrame", true, "misc")
mod:RemoveOption("HealthFrame")
mod:AddBoolOption("EqUneqWeapons", (mod:IsWeaponDependent() or isHunter) and not mod:IsTank() and (mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25")))
mod:AddBoolOption("EqUneqTimer", false)
mod:AddBoolOption("BlockWeapons", false)

if mod.Options.EqUneqWeapons and (mod:IsWeaponDependent() or isHunter) and not mod:IsTank() and (mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25")) and not mod:IsEquipmentSetAvailable("pve") then
	for i = 1, select("#", GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING")) do
		local frame = select(i, GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING"))
		if frame.AddMessage then
			mod:Schedule(10, frame.AddMessage, frame, L.setMissing)
		end
	end
	mod:Schedule(10, RaidNotice_AddMessage, RaidWarningFrame, L.setMissing, ChatTypeInfo["RAID_WARNING"])
end

local lastDD	= 0
local dominateMindTargets	= {}
local dominateMindIcon 	= 6
local deformedFanatic
local empoweredAdherent
local dtime = 0
local lastMc = 0
local UnitGUID = UnitGUID

function mod:OnCombatStart(delay)
	self:SetStage(1)
	dtime = 0
	lastMc = 0
	if self.Options.ShieldHealthFrame then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(36855, L.name)
		self:ScheduleMethod(0.5, "CreateShildHPFrame")
	end
	berserkTimer:Start(-delay)
	timerAdds:Start(7)
	warnAddsSoon:Schedule(4)			-- 3sec pre-warning on start
	self:ScheduleMethod(7, "addsTimer")
	if not mod:IsDifficulty("normal10") then
		timerDominateMindCD:Start(30)		-- Sometimes 1 fails at the start, then the next will be applied 70 secs after start ?? :S
		soundWarnMC:Schedule(25)
		if mod.Options.EqUneqWeapons and not mod:IsTank() and mod.Options.EqUneqTimer then
			specWarnWeapons:Show()
			mod:ScheduleMethod(29, "UnW")
		end
	end
	table.wipe(dominateMindTargets)
	dominateMindIcon = 6
	deformedFanatic = nil
	empoweredAdherent = nil
end

function mod:OnCombatEnd()
	DBM.BossHealth:Clear()
	self:UnscheduleMethod("UnW")
	self:UnscheduleMethod("EqW")
	soundWarnMC:Cancel()
end

do	-- add the additional Shield Bar
	local last = 100
	local function getShieldPercent()

		local unitId = "boss1"
		local guid = UnitGUID(unitId)
		if mod:GetCIDFromGUID(guid) == 36855 then
			last = math.floor(UnitMana(unitId)/UnitManaMax(unitId) * 100)
			return last
		end

		unitId = "boss1"
		guid = UnitGUID(unitId)
		if mod:GetCIDFromGUID(guid) == 36855 then
			last = math.floor(UnitMana(unitId)/UnitManaMax(unitId) * 100)
			return last
		end

		for i = 0, GetNumRaidMembers(), 1 do
			unitId = ((i == 0) and "target") or ("raid"..i.."target")
			guid = UnitGUID(unitId)
			if mod:GetCIDFromGUID(guid) == 36855 then
				last = math.floor(UnitMana(unitId)/UnitManaMax(unitId) * 100)
				return last
			end
		end

		return last
	end
	function mod:CreateShildHPFrame()
		DBM.BossHealth:AddBoss(getShieldPercent, L.ShieldPercent)
	end
end

function mod:addsTimer()  -- Edited add spawn timers, working for heroic mode
	timerAdds:Cancel()
	warnAddsSoon:Cancel()
	if self:IsDifficulty("normal10") or self:IsDifficulty("normal25") then
		warnAddsSoon:Schedule(40)	-- 5 secs prewarning
		self:ScheduleMethod(45, "addsTimer")
		timerAdds:Start(45)
	else
		warnAddsSoon:Schedule(40)	-- 5 secs prewarning
		self:ScheduleMethod(45, "addsTimer")
		timerAdds:Start(45)
	end
end

function mod:UnW()
   if self:IsWeaponDependent() and self.Options.EqUneqWeapons and not self.Options.BlockWeapons and not self:IsTank() and self:IsEquipmentSetAvailable("pve") then
        PickupInventoryItem(16)
        PutItemInBackpack()
        PickupInventoryItem(17)
        PutItemInBackpack()
    elseif isHunter and self.Options.EqUneqWeapons and not self.Options.BlockWeapons and not self:IsTank() and self:IsEquipmentSetAvailable("pve") then
        PickupInventoryItem(18)
        PutItemInBackpack()
    end
end

function mod:EqW()
	if self.Options.EqUneqWeapons and not self.Options.BlockWeapons and not self:IsTank() and self:IsEquipmentSetAvailable("pve") then
		DBM:Debug("trying to equip pve",1)
		UseEquipmentSet("pve")
		CancelUnitBuff("player", (GetSpellInfo(25780)))
	end
end

function mod:TrySetTarget()
	if DBM:GetRaidRank() >= 1 then
		for i = 1, GetNumRaidMembers() do
			if UnitGUID("raid"..i.."target") == deformedFanatic then
				deformedFanatic = nil
				SetRaidTarget("raid"..i.."target", 8)
			elseif UnitGUID("raid"..i.."target") == empoweredAdherent then
				empoweredAdherent = nil
				SetRaidTarget("raid"..i.."target", 7)
			end
			if not (deformedFanatic or empoweredAdherent) then
				break
			end
		end
	end
end

function mod:has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 71289 then
		timerDominateMindCD:Start()
		DBM:Debug("MC on "..args.destName,2)
		if self.Options.EqUneqWeapons and args.destName == UnitName("player") then
			self:UnW()
			self:UnW()
			self:ScheduleMethod(0.01, "UnW")
			DBM:Debug("Unequipping",2)
		end
	end
end

do
	local function showDominateMindWarning(mc_delay)
		if not mc_delay then
			mc_delay = 0
		end
		warnDominateMind:Show(table.concat(dominateMindTargets, "<, >"))
		timerDominateMind:Start()
		timerDominateMindCD:Start(40-mc_delay)
		if (not mod:has_value(dominateMindTargets,UnitName("player")) and mod.Options.EqUneqWeapons and not mod:IsTank()) then
			DBM:Debug("Equipping scheduled",1)
	        mod:ScheduleMethod(0.1, "EqW")
	        mod:ScheduleMethod(1.7, "EqW")
			mod:ScheduleMethod(3.3, "EqW")
			mod:ScheduleMethod(5.5, "EqW")
			mod:ScheduleMethod(7.5, "EqW")
			mod:ScheduleMethod(9.9, "EqW")
		end
		table.wipe(dominateMindTargets)
		dominateMindIcon = 6
		soundWarnMC:Cancel()
		soundWarnMC:Schedule(35-mc_delay)
		if mod.Options.EqUneqWeapons and not mod:IsTank() and mod.Options.EqUneqTimer then
			mod:ScheduleMethod(39-mc_delay, "UnW")
		end
	end

	function mod:SPELL_AURA_APPLIED(args)
		if args:IsSpellID(71289) then
			dominateMindTargets[#dominateMindTargets + 1] = args.destName
			if self.Options.SetIconOnDominateMind then
				self:SetIcon(args.destName, dominateMindIcon, 12)
				dominateMindIcon = dominateMindIcon - 1
			end
			self:Unschedule(showDominateMindWarning)
			if lastMc > 0 then
				dtime = GetTime() - lastMc
			end
			if dtime < 0 then
				dtime = 0
			end
			if mod:IsDifficulty("heroic10") or mod:IsDifficulty("normal25") or (mod:IsDifficulty("heroic25") and #dominateMindTargets >= 3) then
				showDominateMindWarning(dtime)
			else
				self:Schedule(0.9, showDominateMindWarning, dtime)
			end
		elseif args:IsSpellID(71001, 72108, 72109, 72110) then
			if args:IsPlayer() then
				specWarnDeathDecay:Show()
			end
			if (GetTime() - lastDD > 5) then
				warnDeathDecay:Show()
				lastDD = GetTime()
			end
		elseif args:IsSpellID(71237) and args:IsPlayer() then
			specWarnCurseTorpor:Show()
		elseif args:IsSpellID(70674) and not args:IsDestTypePlayer() and (UnitName("target") == L.Fanatic1 or UnitName("target") == L.Fanatic2 or UnitName("target") == L.Fanatic3) then
			specWarnVampricMight:Show(args.destName)
		elseif args:IsSpellID(71204) then
			warnTouchInsignificance:Show(args.destName, args.amount or 1)
			timerTouchInsignificance:Start(args.destName)
			if args:IsPlayer() and (args.amount or 1) >= 3 and (mod:IsDifficulty("normal10") or mod:IsDifficulty("normal25")) then
				specWarnTouchInsignificance:Show(args.amount)
			elseif args:IsPlayer() and (args.amount or 1) >= 5 and (mod:IsDifficulty("heroic10") or mod:IsDifficulty("heroic25")) then
				specWarnTouchInsignificance:Show(args.amount)
			end
		end
	end
	mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70842) then
		self:SetStage(2)
		warnPhase2:Show()
		if mod:IsDifficulty("normal10") or mod:IsDifficulty("normal25") then
			timerAdds:Cancel()
			warnAddsSoon:Cancel()
			self:UnscheduleMethod("addsTimer")
		end
    elseif args:IsSpellID(71289) then
		if (args.destName == UnitName("player") or args:IsPlayer()) and self.Options.EqUneqWeapons and not mod:IsTank() then
	        self:ScheduleMethod(0.1, "EqW")
	        self:ScheduleMethod(1.7, "EqW")
	        self:ScheduleMethod(3.3, "EqW")
			self:ScheduleMethod(5.0, "EqW")
			self:ScheduleMethod(8.0, "EqW")
			self:ScheduleMethod(9.9, "EqW")
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(71420, 72007, 72501, 72502) then
		warnFrostbolt:Show()
		--specWarnFrostbolt:Show(args.sourceName)
		--specWarnFrostbolt:Play("kickcast")
		timerFrostboltCast:Start()
	elseif args:IsSpellID(70900) then
		warnDarkTransformation:Show()
		if self.Options.SetIconOnDeformedFanatic then
			deformedFanatic = args.sourceGUID
			self:TrySetTarget()
		end
	elseif args:IsSpellID(70901) then
		warnDarkEmpowerment:Show()
		if self.Options.SetIconOnEmpoweredAdherent then
			empoweredAdherent = args.sourceGUID
			self:TrySetTarget()
		end
	elseif args:IsSpellID(72499, 72500, 72497, 72496) then
		warnDarkMartyrdom:Show()
		specWarnDarkMartyrdom:Show()
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 71420 or args.extraSpellId == 72007 or args.extraSpellId == 72501 or args.extraSpellId == 72502) then
		timerFrostboltCast:Cancel()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(71426) and self:AntiSpam(5, 1) then -- Summon Vengeful Shade
		warnSummonSpirit:Show()
		timerSummonSpiritCD:Start()
		soundWarnSpirit:Play("Interface\\AddOns\\DBM-Core\\sounds\\beware.ogg")
	end
end

function mod:SWING_DAMAGE(args)
	if args:IsPlayer() and args:GetSrcCreatureID() == 38222 then
		specWarnVengefulShade:Show()
	end
end

function mod:UNIT_TARGET()
	if empoweredAdherent or deformedFanatic then
		self:TrySetTarget()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellReanimatedFanatic or msg:find(L.YellReanimatedFanatic) then
		warnReanimating:Show()
	elseif (msg == L.YellMC or msg:find(L.YellMC)) then
		lastMc = GetTime()
		timerDominateMindCD:Start()
	end
end
