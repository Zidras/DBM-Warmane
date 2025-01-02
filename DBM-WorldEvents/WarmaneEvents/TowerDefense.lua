local mod	= DBM:NewMod("WarmaneTowerDefense", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250102122706")
mod:SetUsedIcons(1, 2, 3, 4, 5)
mod:SetHotfixNoticeRev(20241231000000)
mod.noStatistics = true -- needed to avoid Start/End chat messages, as well as other interactions not really suited for this event (wave based)

mod:RegisterCombat("emote_regex", L.RoundStart)
mod:SetWipeTime(100) -- random number, just to reach waves/not assume wipe

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 31999 73775 15847 21099",
	"SPELL_CAST_SUCCESS 28410",
	"SPELL_AURA_APPLIED 36096 66009 73061 21098 22067 28410",
	"SPELL_AURA_REMOVED 28410",
	"SPELL_DAMAGE 34190",
	"SPELL_MISSED 34190"
)

-- General
local warnBossNow					= mod:NewSpellAnnounce(31315, 1)

local timerToResurrect				= mod:NewNextTimer(30, 72423, nil, nil, nil, 6)
local timerCombatStart				= mod:NewCombatTimer(30)

mod:RemoveOption("HealthFrame")

-- Trash
local specWarnSpellReflectDispel	= mod:NewSpecialWarningDispel(36096, "MagicDispeller", nil, nil, 1, 2)
local specWarnHandOfProtectionDispel= mod:NewSpecialWarningDispel(66009, "ImmunityDispeller", nil, nil, 1, 2)

-- Bosses
-- Shade of Aran (400024)
local specWarnCounterspellStopCast	= mod:NewSpecialWarningCast(31999, "SpellCaster", nil, nil, 1, 2) -- TBC spellId
local specWarnIceBlastRun			= mod:NewSpecialWarningRun(73775, "Melee", nil, nil, 4, 2) -- TBC spellId
local specWarnLivingBombMoveAway	= mod:NewSpecialWarningMoveAway(73061, "Melee", nil, nil, 1, 2) -- TBC spellId

mod:AddRangeFrameOption(15, 73775) -- TBC spellId

-- Azuregos (400052)
local warnReflection				= mod:NewSpellAnnounce(22067, 2)

local specWarnChillDispel			= mod:NewSpecialWarningDispel(21098, "MagicDispeller", nil, nil, 1, 2)

local timerTailSweep				= mod:NewVarTimer("v15-20", 15847, nil, nil, nil, 2) -- 5s variance [15-20] (Lordaeron Horde [2024-12-27]@[13:17:37]) - "Tail Sweep-15847-npc:6836-432 = pull:1152.8, 18.2, 16.3, 18.7, 16.7, 16.3, 16.3, 17.3, 19.6, 16.4"
local timerFrostBreath				= mod:NewVarTimer("v15-20", 21099, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON) -- 5s variance [15-20] (Lordaeron Horde [2024-12-27]@[13:17:37]) - "Frost Breath-21099-npc:6836-432 = pull:1148.1, 18.7, 16.1, 18.6, 15.9, 19.5, 16.5, 15.2, 20.0, 15.8"
local timerNextChill				= mod:NewNextTimer(15, 21098, nil, nil, nil, 2) -- (Lordaeron Horde [2024-12-27]@[13:17:37]) - "Chill-21098-npc:6836-432 = pull:1160.1[+41], 14.7[+10], 0.1[+20], 15.0[+38], 14.9[+26], 15.0[+18], 15.0[+21], 14.9[+21], 15.0[+18], 14.9[+8], 0.1[+18], 14.9, 0.1[+4], 14.9"

-- Ysondre (400025)
local warnMindControlSoon			= mod:NewSoonAnnounce(28410, 4)
local warnMindControl				= mod:NewTargetNoFilterAnnounce(28410, 3)

local timerMindControlActive		= mod:NewBuffActiveTimer(20, 28410, nil, nil, nil, 5)
local timerNextMindControl			= mod:NewNextTimer(45, 28410, nil, nil, nil, 3) -- (Lordaeron Horde [2024-12-27]@[13:17:37]) - "Chains of Kel'Thuzad-28410-npc:6809-976 = pull:385.1, 0.0, 0.0, 0.0, 0.0, 45.0, 0.0, 0.0, 0.0, 0.0, 45.0, 0.0, 0.0, 0.0, 0.0"

mod:AddSetIconOption("SetIconOnMindControl", 28410, true, 0, {1, 2, 3, 4, 5})
mod:AddBoolOption("EqUneqWeapons", mod:IsDps(), nil, nil, nil, nil, 28410)

-- Ragnaros (400049)

-- Illidan Stormrage (400022)

-- Void Reaver (400051)
local specWarnArcaneOrbDodge		= mod:NewSpecialWarningDodge(34190, nil, nil, nil, 1, 2) -- No event for this cast, only damage and aura applied

local mindControlledTargets = {}
mod.vb.roundCounter = 0
mod.vb.mindControlIcon = 1

local playerClass = select(2, UnitClass("player"))
local isHunter = playerClass == "HUNTER"

local function resurrectionTicker(self)
	timerToResurrect:Restart()
	self:Schedule(30, resurrectionTicker, self)
end

local function announceMindControlTargets(self)
	warnMindControl:Show(table.concat(mindControlledTargets, "<, >"))
	timerMindControlActive:Start()
	table.wipe(mindControlledTargets)
	self.vb.mindControlIcon = 1
end

local function checkWeaponRemovalSetting(self)
	if not self.Options.EqUneqWeapons then return false end
end

local function UnW(self)
	if self:IsEquipmentSetAvailable("pve") then
		PickupInventoryItem(16)
		PutItemInBackpack()
		PickupInventoryItem(17)
		PutItemInBackpack()
		DBM:Debug("MH and OH unequipped", 2)
		if isHunter then
			PickupInventoryItem(18)
			PutItemInBackpack()
			DBM:Debug("Ranged unequipped", 2)
		end
	end
end

local function EqW(self)
	if self:IsEquipmentSetAvailable("pve") then
		DBM:Debug("trying to equip pve")
		UseEquipmentSet("pve")
	end
end

-- function mod:OnCombatStart(delay)
-- end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 31999 then -- Counterspell
		specWarnCounterspellStopCast:Show()
		specWarnCounterspellStopCast:Play("stopcast")
	elseif spellId == 73775 then -- Ice Blast
		specWarnIceBlastRun:Show()
		specWarnIceBlastRun:Play("runout")

		if self.Options.RangeFrame then
			if not DBM.RangeCheck:IsShown() then
				DBM.RangeCheck:Show(15)
				DBM.RangeCheck:SetHideTime(3) -- boss casted for 2.86s with Curse of Tongues, 2.20s without
			end

			DBM.RangeCheck:SetBossRange(15, self:GetBossUnitByCreatureId(400024)) -- Shade of Aran
		end
	elseif spellId == 15847 then -- Tail Sweep
		timerTailSweep:Start()
	elseif spellId == 21099 then -- Frost Breath
		timerFrostBreath:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 28410 then -- Chains of Kel'Thuzad (Mind Control)
		warnMindControlSoon:Schedule(20)
		timerNextMindControl:Start()
		if (args.destName == UnitName("player") or args:IsPlayer()) and checkWeaponRemovalSetting(self) then
			DBM:Debug("Unequipping", 2)
			UnW(self)
			UnW(self)
		end
		if #mindControlledTargets > 0 then -- reset icon and wipe table if it's not already empty, since there's no boss detection for each wave
			table.wipe(mindControlledTargets)
			self.vb.mindControlIcon = 1
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 36096 and args:IsDestTypeHostile() and self:AntiSpam(5, 1) then -- Spell Reflection
		specWarnSpellReflectDispel:Show(args.destName)
		specWarnSpellReflectDispel:Play("helpdispel")
	elseif spellId == 66009 and args:IsDestTypeHostile() and self:AntiSpam(5, 2) then -- Hand of Protection
		specWarnHandOfProtectionDispel:Show(args.destName)
		specWarnHandOfProtectionDispel:Play("helpdispel")
	elseif spellId == 73061 and args:IsPlayer() then -- Living Bomb
		specWarnLivingBombMoveAway:Show()
		specWarnLivingBombMoveAway:Play("runout")
	elseif spellId == 21098 and args:IsDestTypePlayer() and self:AntiSpam(5, 3) then -- Chill
		timerNextChill:Start()
		if self:CheckDispelFilter("magic") then
			specWarnChillDispel:Show(args.destName)
			specWarnChillDispel:Play("helpdispel")
		end
	elseif spellId == 22067 then -- Reflection
		warnReflection:Show()
	elseif spellId == 28410 then -- Chains of Kel'Thuzad (Mind Control)
		mindControlledTargets[#mindControlledTargets + 1] = args.destName
		if self.Options.SetIconOnMindControl then
			self:SetIcon(args.destName, self.vb.mindControlIcon)
		end
		self.vb.mindControlIcon = self.vb.mindControlIcon + 1
		self:Unschedule(announceMindControlTargets)
		if #mindControlledTargets >= 5 then
			announceMindControlTargets(self)
		else
			self:Schedule(1, announceMindControlTargets, self)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 28410 then -- Chains of Kel'Thuzad (Mind Control)
		if self.Options.SetIconOnMindControl then
			self:SetIcon(args.destName, 0)
		end
		if (args.destName == UnitName("player") or args:IsPlayer()) and checkWeaponRemovalSetting(self) then
			DBM:Debug("Equipping scheduled", 2)
			EqW(self)
			self:Schedule(0.1, EqW, self)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, _, spellId, spellName)
	if spellId == 34190 and self:AntiSpam(7, 4) then -- Arcane Orb (Silence on hit)
		specWarnArcaneOrbDodge:Show(spellName)
		specWarnArcaneOrbDodge:Play("silencesoon")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:match(L.RoundStart) then
		self.vb.roundCounter = msg:match(L.RoundStart)
		DBM:AddSpecialEventToTranscriptorLog("Started round" .. (self.vb.roundCounter or "nil"))
		resurrectionTicker(self)
		if (self.vb.roundCounter % 4 == 0) then -- Boss spawns every 4 rounds
			warnBossNow:Show()
		end
	elseif msg == "30" then
		timerCombatStart:Start()
	elseif msg:match(L.RoundComplete) then -- victory
		DBM:EndCombat(self)
		DBM:AddSpecialEventToTranscriptorLog("Completed round" .. (self.vb.roundCounter or "nil"))
		self:Unschedule(resurrectionTicker)
		self:UnregisterShortTermEvents()
--		timerCombatStart:Start(45) -- Disabled here, since EndCombat schedules timer stops after 3s

		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif msg:find(L.RoundFailed) then -- wipe
		DBM:EndCombat(self, true)
		DBM:AddSpecialEventToTranscriptorLog("Wiped on round" .. (self.vb.roundCounter or "nil"))
		self:Unschedule(resurrectionTicker)
		self:UnregisterShortTermEvents()

		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end
