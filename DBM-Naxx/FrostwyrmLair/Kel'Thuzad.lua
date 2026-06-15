local mod	= DBM:NewMod("Kel'Thuzad", "DBM-Naxx", 5)
local L		= mod:GetLocalizedStrings()

local select, tContains = select, tContains
local PickupInventoryItem, PutItemInBackpack, UseEquipmentSet, CancelUnitBuff = PickupInventoryItem, PutItemInBackpack, UseEquipmentSet, CancelUnitBuff
local UnitClass = UnitClass

mod:SetRevision("20240716154330")
mod:SetCreatureID(15990)
mod:SetModelID("creature/lich/lich.m2")
mod:SetMinCombatTime(60)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat_yell", L.Yell)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 27808 27819 28410",
	"SPELL_AURA_REMOVED 28410",
	"SPELL_CAST_SUCCESS 27810 27819 27808 28410",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH boss1"
)

local specWarnWeapons		= mod:NewSpecialWarning("WeaponsStatus", false)

local warnAddsSoon			= mod:NewAnnounce("warnAddsSoon", 1, "Interface\\Icons\\INV_Misc_MonsterSpiderCarapace_01")
local warnPhase2			= mod:NewPhaseAnnounce(2, 3)
local warnBlastTargets		= mod:NewTargetAnnounce(27808, 2)
local warnFissure			= mod:NewTargetNoFilterAnnounce(27810, 4)
local warnMana				= mod:NewTargetAnnounce(27819, 2)
local warnChainsTargets		= mod:NewTargetNoFilterAnnounce(28410, 4)
local warnMindControlSoon	= mod:NewSoonAnnounce(28410, 4)
local warnPhase3			= mod:NewPhaseAnnounce(3, 3)

local specwarnP2Soon		= mod:NewSpecialWarning("specwarnP2Soon")
local specWarnManaBomb		= mod:NewSpecialWarningMoveAway(27819, nil, nil, nil, 1, 2)
local specWarnManaBombNear	= mod:NewSpecialWarningClose(27819, nil, nil, nil, 1, 2)
local yellManaBomb			= mod:NewShortYell(27819)
local specWarnBlast			= mod:NewSpecialWarningTarget(27808, "Healer", nil, nil, 1, 2)
local specWarnFissureYou	= mod:NewSpecialWarningYou(27810, nil, nil, nil, 3, 2)
local specWarnFissureClose	= mod:NewSpecialWarningClose(27810, nil, nil, nil, 2, 8)
local yellFissure			= mod:NewYellMe(27810)
local specWarnAddsGuardians	= mod:NewSpecialWarningAdds(29897, "-Healer", nil, nil, 1, 2) -- "Guardians of Icecrown. There's no spellID for this, so used something close: Guardians of Icecrown Passive"

local blastTimer			= mod:NewBuffActiveTimer(4, 27808, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerManaBomb			= mod:NewCDTimer(20, 27819, nil, nil, nil, 3)--20-50
local timerFrostBlast		= mod:NewCDTimer(30, 27808, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--40-46 (retail 40.1)
local timerFissure			= mod:NewTargetTimer(5, 27810, nil, nil, 2, 3)
local timerFissureCD 		= mod:NewCDTimer(11.5, 27810, nil, nil, nil, 3, nil, nil, true) -- Huge variance! Added "keep" arg (25m Lordaeron 2022/10/16) - Stage 2/*, 22.8, 41.2, 77.5, 11.5
local timerMC				= mod:NewBuffActiveTimer(20, 28410, nil, nil, nil, 3)
local timerMCCD				= mod:NewCDTimer(90, 28410, nil, nil, nil, 3)--actually 60 second cdish but its easier to do it this way for the first one.
local timerPhase2			= mod:NewTimer(228, "TimerPhase2", nil, nil, nil, 6) -- P2 script starts on Yell or Emote, and IEEU fires 0.55s after. (25m Lordaeron 2022/10/16) - 228.0

mod:AddRangeFrameOption(12, 27819)
mod:AddSetIconOption("SetIconOnMC", 28410, true, false, {1, 2, 3})
mod:AddSetIconOption("SetIconOnManaBomb", 27819, false, false, {8})
mod:AddSetIconOption("SetIconOnFrostTomb", 27808, true, false, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddDropdownOption("RemoveBuffsOnMC", {"Never", "Gift", "CCFree", "ShortOffensiveProcs", "MostOffensiveBuffs"}, "Never", "misc", nil, 28410)

mod.vb.warnedAdds = false
mod.vb.MCIcon = 1
local frostBlastTargets = {}
local chainsTargets = {}

local playerClass = select(2, UnitClass("player"))
local isHunter = playerClass == "HUNTER"

local RaidWarningFrame = RaidWarningFrame
local GetFramesRegisteredForEvent, RaidNotice_AddMessage = GetFramesRegisteredForEvent, RaidNotice_AddMessage
local function selfWarnMissingSet()
	if (mod.Options.EqUneqWeaponsKT or mod.Options.EqUneqWeaponsKT2) and not mod:IsEquipmentSetAvailable("pve") then
		for i = 1, select("#", GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING")) do
			local frame = select(i, GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING"))
			if frame.AddMessage then
				frame.AddMessage(frame, L.setMissing)
			end
		end
		RaidNotice_AddMessage(RaidWarningFrame, L.setMissing, ChatTypeInfo["RAID_WARNING"])
	end
end

mod:AddMiscLine(L.EqUneqLineDescription)
mod:AddBoolOption("EqUneqWeaponsKT", false) -- automation by timer
mod:AddBoolOption("EqUneqWeaponsKT2", mod:IsDps(), nil, selfWarnMissingSet) -- automation by event
mod:AddDropdownOption("EqUneqFilter", {"OnlyDPS", "DPSTank", "NoFilter"}, "OnlyDPS", "misc")

local function selfSchedWarnMissingSet(self)
	if (self.Options.EqUneqWeaponsKT or self.Options.EqUneqWeaponsKT2) and not self:IsEquipmentSetAvailable("pve") then
		for i = 1, select("#", GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING")) do
			local frame = select(i, GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING"))
			if frame.AddMessage then
				self:Schedule(10, frame.AddMessage, frame, L.setMissing)
			end
		end
		self:Schedule(10, RaidNotice_AddMessage, RaidWarningFrame, L.setMissing, ChatTypeInfo["RAID_WARNING"])
	end
end
mod:Schedule(0.5, selfSchedWarnMissingSet, mod) -- mod options default values were being read before SV ones, so delay this

local function checkWeaponRemovalSetting(self)
	if (not self.Options.EqUneqWeaponsKT and not self.Options.EqUneqWeaponsKT2) then return false end

	local removalOption = self.Options.EqUneqFilter
	if removalOption == "OnlyDPS" and self:IsDps() then return true
	elseif removalOption == "DPSTank" and not self:IsHealer() then return true
	elseif removalOption == "NoFilter" then return true
	end
	return false
end

local function UnWKT(self)
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

local function EqWKT(self)
	if self:IsEquipmentSetAvailable("pve") then
		DBM:Debug("trying to equip pve")
		UseEquipmentSet("pve")
		if not self:IsTank() then
			CancelUnitBuff("player", (GetSpellInfo(25780))) -- Righteous Fury
		end
	end
end

local aurastoRemove = { -- ordered by aggressiveness {degree, classFilter}
	-- 1 (Gift)
	[48469] = {1, nil}, -- Mark of the Wild
	[48470] = {1, nil}, -- Gift of the Wild
	[69381] = {1, nil}, -- Drums of the Wild
	-- 2 (CCFree)
	[48169] = {2, nil}, -- Shadow Protection
	[48170] = {2, nil}, -- Prayer of Shadow Protection
	-- 3 (ShortOffensiveProcs)
	[13877] = {3, "ROGUE"}, -- Blade Flurry (Combat Rogue)
	[70721] = {3, "DRUID"}, -- Omen of Doom (Balance Druid)
	[48393] = {3, "DRUID"}, -- Owlkin Frenzy (Balance Druid)
	[53201] = {3, "DRUID"}, -- Starfall (Balance Druid)
	[50213] = {3, "DRUID"}, -- Tiger's Fury (Feral Druid)
	[31572] = {3, "MAGE"}, -- Arcane Potency (Arcane Mage)
	[54490] = {3, "MAGE"}, -- Missile Barrage (Arcane Mage)
	[48108] = {3, "MAGE"}, -- Hot Streak (Fire Mage)
	[71165] = {3, "WARLOCK"}, -- Molten Core (Warlock)
	[63167] = {3, "WARLOCK"}, -- Decimation (Warlock)
	[70840] = {3, "WARLOCK"}, -- Devious Minds (Warlock)
	[17941] = {3, "WARLOCK"}, -- Shadow Trance (Warlock)
	[47197] = {3, "WARLOCK"}, -- Eradication (Affliction Warlock)
	[34939] = {3, "WARLOCK"}, -- Backlash (Destruction Warlock)
	[47260] = {3, "WARLOCK"}, -- Backdraft (Destruction Warlock)
	[16246] = {3, "SHAMAN"}, -- Clearcasting (Elemental Shaman)
	[64701] = {3, "SHAMAN"}, -- Elemental Mastery (Elemental Shaman)
	[26297] = {3, nil}, -- Berserking (Troll racial)
	[54758] = {3, nil}, -- Hyperspeed Acceleration (Hands engi enchant)
	[59626] = {3, nil}, -- Black Magic (Weapon enchant)
	[72416] = {3, nil}, -- Frostforged Sage (ICC Rep ring)
	[64713] = {3, nil}, -- Flame of the Heavens (Flare of the Heavens)
	[67669] = {3, nil}, -- Elusive Power (Trinket Abyssal Rune)
	[60064] = {3, nil}, -- Now is the Time! (Trinket Sundial of the Exiled/Mithril Pocketwatch)
	-- 4 (MostOffensiveBuffs)
	[48168] = {4, "PRIEST"}, -- Inner Fire (Priest)
	[15258] = {4, "PRIEST"}, -- Shadow Weaving (Shadow Priest)
	[48420] = {4, "DRUID"}, -- Master Shapeshifter (Druid)
	[24932] = {4, "DRUID"}, -- Leader of the Pack (Feral Druid)
	[67355] = {4, "DRUID"}, -- Agile (Feral Druid idol)
	[52610] = {4, "DRUID"}, -- Savage Roar (Feral Druid)
	[24907] = {4, "DRUID"}, -- Moonkin Aura (Balance Druid)
	[71199] = {4, "DRUID"}, -- Furious (Shaman EoF: Bizuri's Totem of Shattered Ice)
	[67360] = {4, "DRUID"}, -- Blessing of the Moon Goddess (Druid EoT: Idol of Lunar Fury)
	[48943] = {4, "PALADIN"}, -- Shadow Resistance Aura (Paladin)
	[43046] = {4, "MAGE"}, -- Molten Armor (Mage)
	[47893] = {4, "WARLOCK"}, -- Fel Armor (Warlock)
	[63321] = {4, "WARLOCK"}, -- Life Tap (Warlock)
	[55637] = {4, nil}, -- Lightweave (Back tailoring enchant)
	[71572] = {4, nil}, -- Cultivated Power (Muradin Spyglass)
	[60235] = {4, nil}, -- Greatness (Darkmoon Card: Greatness)
	[71644] = {4, nil}, -- Surge of Power (Dislodged Foreign Object)
	[75473] = {4, nil}, -- Twilight Flames (Charred Twilight Scale)
	[71636] = {4, nil}, -- Siphoned Power (Phylactery of the Nameless Lich)
}
local optionToDegree = {
	["Gift"] = 1, -- Cyclones resists
	["CCFree"] = 2, -- CC Shadow resists, life Fear from Psychic Scream
	["ShortOffensiveProcs"] = 3, -- Short-term procs that would expire during Mind Control anyway
	["MostOffensiveBuffs"] = 4, -- Most offensive buffs that are easily renewable but would expire after Mind Control ends
}

local function RemoveBuffs(option) -- Spell is removed based on name so no longer need SpellID for each rank
	if not option then return end
	local degreeOption = optionToDegree[option]
	for aura, infoTable in pairs(aurastoRemove) do
		local degree, classFilter = unpack(infoTable)
		if degree <= degreeOption then
			if not classFilter or classFilter == playerClass then
				CancelUnitBuff("player", (GetSpellInfo(aura)))
			end
		end
	end
	DBM:Debug("Buffs removed, using option \"" .. option .. "\" and degree: " .. tostring(degreeOption), 2)
end

local function AnnounceChainsTargets(self)
	warnChainsTargets:Show(table.concat(chainsTargets, "< >"))
	if self.Options.EqUneqWeaponsKT and checkWeaponRemovalSetting(self) then
		if not tContains(chainsTargets, UnitName("player")) then
			DBM:Debug("Equipping scheduled", 2)
			self:Schedule(1.0, EqWKT, self)
			self:Schedule(2.0, EqWKT, self)
			self:Schedule(3.6, EqWKT, self)
			self:Schedule(5.0, EqWKT, self)
			self:Schedule(6.0, EqWKT, self)
			self:Schedule(8.0, EqWKT, self)
			self:Schedule(10.0, EqWKT, self)
			self:Schedule(12.0, EqWKT, self)
		end
	end
	table.wipe(chainsTargets)
	self.vb.MCIcon = 1
end

local function AnnounceBlastTargets(self)
	if self.Options.SpecWarn27808target then
		specWarnBlast:Show(table.concat(frostBlastTargets, "< >"))
		specWarnBlast:Play("healall")
	else
		warnBlastTargets:Show(table.concat(frostBlastTargets, "< >"))
	end
	blastTimer:Start(3.5)
	if self.Options.SetIconOnFrostTomb then
		for i = #frostBlastTargets, 1, -1 do
			self:SetIcon(frostBlastTargets[i], 8 - i, 4.5)
			frostBlastTargets[i] = nil
		end
	end
end

local function StartPhase2(self)
	if self.vb.phase == 1 then
		self:SetStage(2)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		if self:IsDifficulty("normal25") then
			timerMCCD:Start(30)
			warnMindControlSoon:Schedule(25)
			specWarnWeapons:Show(checkWeaponRemovalSetting(self) and ENABLE or ADDON_DISABLED, (self.Options.EqUneqWeaponsKT2 and self.Options.EqUneqWeaponsKT and (SLASH_STOPWATCH2):sub(2)) or (self.Options.EqUneqWeaponsKT2 and COMBAT_LOG) or NONE, self.Options.EqUneqFilter)
			if self.Options.EqUneqWeaponsKT and checkWeaponRemovalSetting(self) then
				self:Schedule(29.95, UnWKT, self)
				self:Schedule(30, UnWKT, self)
			end
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(12)
		end
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	table.wipe(chainsTargets)
	table.wipe(frostBlastTargets)
	self.vb.warnedAdds = false
	self.vb.MCIcon = 1
	specwarnP2Soon:Schedule(218-delay)
	timerPhase2:Start()
--	self:Schedule(226, StartPhase2, self)
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
	)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 27810 then
		timerFissure:Start(args.destName)
		timerFissureCD:Start()
		if args:IsPlayer() then
			specWarnFissureYou:Show()
			specWarnFissureYou:Play("targetyou")
			yellFissure:Yell()
		elseif self:CheckNearby(8, args.destName) then
			specWarnFissureClose:Show(args.destName)
			specWarnFissureClose:Play("watchfeet")
		else
			warnFissure:Show(args.destName)
			warnFissure:Play("watchstep")
		end
	elseif args.spellId == 28410 then
		DBM:Debug("MC on "..args.destName, 2)
		if args.destName == UnitName("player") then
			if self.Options.RemoveBuffsOnMC ~= "Never" then
				RemoveBuffs(self.Options.RemoveBuffsOnMC)
			end
			if self.Options.EqUneqWeaponsKT2 and checkWeaponRemovalSetting(self) then
				UnWKT(self)
				self:Schedule(0.01, UnWKT, self)
				DBM:Debug("Unequipping", 2)
			end
		end
		if self:AntiSpam(2, 2) then
			timerMCCD:Start()
			if self.Options.EqUneqWeaponsKT and checkWeaponRemovalSetting(self) then
				self:Schedule(89.95, UnWKT, self)
				self:Schedule(90, UnWKT, self)
			end
		end
	elseif spellId == 27819 then
		timerManaBomb:Start()
	elseif spellId == 27808 then
		timerFrostBlast:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 27808 then -- Frost Blast
		table.insert(frostBlastTargets, args.destName)
		self:Unschedule(AnnounceBlastTargets)
		self:Schedule(0.5, AnnounceBlastTargets, self)
	elseif spellId == 27819 then -- Detonate Mana
		if self.Options.SetIconOnManaBomb then
			self:SetIcon(args.destName, 8, 5.5)
		end
		if args:IsPlayer() then
			specWarnManaBomb:Show()
			specWarnManaBomb:Play("bombrun")
			yellManaBomb:Yell()
		elseif self:CheckNearby(12, args.destName) then
			specWarnManaBombNear:Show(args.destName)
			specWarnManaBombNear:Play("scatter")
		else
			warnMana:Show(args.destName)
		end
	elseif spellId == 28410 then -- Chains of Kel'Thuzad
		chainsTargets[#chainsTargets + 1] = args.destName
		if self:AntiSpam() then
			timerMC:Start()
			timerMCCD:Start()
			warnMindControlSoon:Schedule(60)
		end
		if self.Options.SetIconOnMC then
			self:SetIcon(args.destName, self.vb.MCIcon)
		end
		self.vb.MCIcon = self.vb.MCIcon + 1
		self:Unschedule(AnnounceChainsTargets)
		if #chainsTargets >= 3 then
			AnnounceChainsTargets(self)
		else
			self:Schedule(1.0, AnnounceChainsTargets, self)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 28410 then
		if self.Options.SetIconOnMC then
			self:SetIcon(args.destName, 0)
		end
		if (args.destName == UnitName("player") or args:IsPlayer()) and checkWeaponRemovalSetting(self) then
			DBM:Debug("Equipping scheduled", 2)
			self:Schedule(0.1, EqWKT, self)
			self:Schedule(1.7, EqWKT, self)
			self:Schedule(3.7, EqWKT, self)
			self:Schedule(7.0, EqWKT, self)
			self:Schedule(9.0, EqWKT, self)
			self:Schedule(11.0, EqWKT, self)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Yell1Phase2 or msg:find(L.Yell1Phase2) or msg == L.Yell2Phase2 or msg:find(L.Yell2Phase2) or msg == L.Yell3Phase2 or msg:find(L.Yell3Phase2) then
		StartPhase2(self)
		self:UnregisterShortTermEvents() -- Unregister IEEU
	elseif msg == L.YellPhase3 or msg:find(L.YellPhase3) then
		self:SetStage(3)
		warnPhase3:Show()
	elseif msg == L.YellGuardians or msg:find(L.YellGuardians) then
		specWarnAddsGuardians:Show()
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT() -- Keeping this just in case one of the YellPhase2 Localizations is wrong
	if UnitExists("boss1") and self:GetUnitCreatureId("boss1") == 15990 then
		StartPhase2(self)
		self:UnregisterShortTermEvents()
	end
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warnedAdds and self:GetUnitCreatureId(uId) == 15990 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.48 then
		self.vb.warnedAdds = true
		warnAddsSoon:Show()
	end
end
