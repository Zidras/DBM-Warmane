local mod	= DBM:NewMod("Loatheb-Vanilla", "DBM-VanillaNaxx", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240731154436")
mod:SetCreatureID(16011)

mod:RegisterCombat("combat")--Maybe change to a yell later so pull detection works if you chain pull him from tash gauntlet

-- There are two types of Corrupted Mind spells for each class.
-- Let's refer to them as "Corrupted Mind Aura" and "Corrupted Mind Debuff" for clarify
-- Corrupted Mind Aura
--   * This is a 2 min debuff that gives you a Corrupted Mind Debuff if you cast a heal.
--   * This is refreshed every 11 seconds if you're in combat with Loatheb.
-- Corrupted Mind Debuff
--   * This is a 1 min debuff that doesn't let you heal.
--   * This is applied if you heal when you have the Corrupted Mind Aura.

-- Corrupted Mind Aura spell IDs (in the order of Priest, Druid, Paladin, Shaman)
-- 29185 29194 29196 29198

-- Corrupted Mind Debuff spell IDs (in the order of Priest, Druid, Paladin, Shaman)
-- 29184 29195 29197 29199

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 29234 29204 30281",
	"SPELL_AURA_APPLIED 29184 29195 29197 29199",
	"SPELL_AURA_REMOVED 29184 29195 29197 29199",
	"SPELL_DAMAGE",
	"SWING_DAMAGE",
	"UNIT_DIED"
)

local warnSporeNow			= mod:NewCountAnnounce(29234, 2, "Interface\\Icons\\INV_Mushroom_09")
local warnSporeSoon			= mod:NewSoonAnnounce(29234, 1, "Interface\\Icons\\INV_Mushroom_09")
local warnDoomNow			= mod:NewCountAnnounce(29204, 3)
local warnRemoveCurse		= mod:NewSpellAnnounce(30281, 3)
local warnHealSoon			= mod:NewAnnounce("WarningHealSoon", 4, 29184, nil, nil, nil, 29184)
local warnHealNow			= mod:NewAnnounce("WarningHealNow", 1, 29184, false, nil, nil, 29184)

local timerSpore			= mod:NewNextTimer(12, 29234, nil, nil, nil, 5, "Interface\\Icons\\INV_Mushroom_09", DBM_COMMON_L.DAMAGE_ICON) -- (PTR: [2024-07-08]@[18:39:24] ||| Onyxia: [2024-07-26]@[21:27:31])  -- "Summon Spore-29234-npc:16011-130 = pull:11.96, 12.01, 12.01, 12.00, 12.03" ||| "Summon Spore-29234-npc:16011-130 = pull:12.01, 12.01, 12.03, 11.99, 12.01, 12.01, 12.01, 12.00, 12.04, 12.00, 12.02, 12.02, 12.01, 12.03, 12.01, 12.03"
local timerDoom				= mod:NewNextTimer(30, 29204, nil, nil, nil, 2) -- (Onyxia: [2024-07-26]@[21:27:31]) - "Inevitable Doom-29204-npc:16011-130 = pull:119.99, 30.01, 30.01"
local timerRemoveCurseCD	= mod:NewNextTimer(30, 30281, nil, nil, nil, 5) -- (Onyxia: [2024-07-26]@[21:27:31]) - "Remove Curse-30281-npc:16011-130 = pull:2.24, 30.01, 29.99, 30.03, 30.03, 30.01, 30.03"

mod:AddInfoFrameOption(29184, "Tank|Healer")
mod:AddBoolOption("SporeDamageAlert", false)
if not DBM.Options.GroupOptionsBySpell then
	mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
end
mod:AddDropdownOption("CorruptedSorting", {"Alphabetical", "Duration"}, "Alphabetical", "misc", nil, 29184)

mod.vb.doomCounter	= 0
mod.vb.sporeTimer	= 12
mod.vb.sporeCounter = 0
local hadCorrupted	= {}

local updateInfoFrame
do
	local ipairs, pairs, tostring = ipairs, pairs, tostring
	local mfloor, mmax, tinsert, tsort, twipe = math.floor, math.max, table.insert, table.sort, table.wipe
	local lines, sortedLines, corruptKeys = {}, {}, {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		twipe(lines)
		twipe(sortedLines)
		twipe(corruptKeys)

		local refreshTime = GetTime()

		for name, _ in pairs(hadCorrupted) do
			tinsert(corruptKeys, name)
		end
		if mod.Options.CorruptedSorting == "Duration" then
			tsort(corruptKeys, function (a, b) return (hadCorrupted[a] or refreshTime) > (hadCorrupted[b] or refreshTime) end)
		else
			tsort(corruptKeys)
		end

		for _, name in ipairs(corruptKeys) do
			addLine(name, tostring(mfloor(mmax(hadCorrupted[name] - refreshTime, 0))))
		end

		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.doomCounter = 0
	self.vb.sporeCounter = 0
	timerRemoveCurseCD:Start(2.24 - delay) -- ~1s variance
	timerSpore:Start(self.vb.sporeTimer-delay, 1)
	warnSporeSoon:Schedule(self.vb.sporeTimer-5-delay)
	timerDoom:Start(120-delay, 1)

	local startTime = GetTime()
	table.wipe(hadCorrupted)
	for unit in DBM:GetGroupMembers() do
		local _, cls = UnitClass(unit)
		if not UnitIsDeadOrGhost(unit) and (cls == "DRUID" or cls == "PALADIN" or cls == "PRIEST" or cls == "SHAMAN") then
			hadCorrupted[UnitName(unit)] = startTime
		end
	end
	if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(29184))
		DBM.InfoFrame:Show(25, "function", updateInfoFrame, false, false)
		DBM.InfoFrame:SetColumns(2)
	end
end

function mod:OnCombatEnd()
	if DBM.InfoFrame:IsShown() then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 29234 then
		self.vb.sporeCounter = self.vb.sporeCounter + 1
		timerSpore:Start(self.vb.sporeTimer, self.vb.sporeCounter + 1)
		warnSporeNow:Show(self.vb.sporeCounter)
		warnSporeSoon:Schedule(self.vb.sporeTimer-5)
	elseif spellId == 29204 then  -- Inevitable Doom
		self.vb.doomCounter = self.vb.doomCounter + 1
		local timer = 30
		if self.vb.doomCounter >= 7 then
			if self.vb.doomCounter % 2 == 0 then timer = 17
			else timer = 12 end
		end
		warnDoomNow:Show(self.vb.doomCounter)
		timerDoom:Start(timer, self.vb.doomCounter + 1)
	elseif spellId == 30281 then
		warnRemoveCurse:Show()
		timerRemoveCurseCD:Start()
	end
end

--Spore loser function. Credits to Forte guild and their old discontinued dbm plugins. Sad to see that guild disband, best of luck to them!
function mod:SPELL_DAMAGE(_, sourceName, _, _, destName, _, spellId, _, _, amount)
	if self.Options.SporeDamageAlert and destName == "Spore" and spellId ~= 62124 and self:IsInCombat() then
		SendChatMessage(sourceName..", You are damaging a Spore!!! ("..amount.." damage)", "RAID_WARNING")
		SendChatMessage(sourceName..", You are damaging a Spore!!! ("..amount.." damage)", "WHISPER", nil, sourceName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(29184, 29195, 29197, 29199) then -- Corrupted Mind debuff
		hadCorrupted[args.destName] = GetTime() + 60
		if args:IsPlayer() then
			warnHealSoon:Schedule(55)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(29184, 29195, 29197, 29199) then
		if args:IsPlayer() then
			warnHealNow:Show()
		end
	end
end

function mod:SWING_DAMAGE(_, sourceName, _, _, destName, _, _, _, _, amount)
	if self.Options.SporeDamageAlert and destName == "Spore" and self:IsInCombat() then
		SendChatMessage(sourceName..", You are damaging a Spore!!! ("..amount.." damage)", "RAID_WARNING")
		SendChatMessage(sourceName..", You are damaging a Spore!!! ("..amount.." damage)", "WHISPER", nil, sourceName)
	end
end

--because in all likelyhood, pull detection failed (cause 90s like to charge in there trash and all and pull it
--We unschedule the pre warnings on death as a failsafe
function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 16011 then
		warnSporeSoon:Cancel()
		--warnHealSoon:Cancel()
		--warnHealNow:Cancel()
	elseif hadCorrupted[args.destName] then
		hadCorrupted[args.destName] = nil
	end
end
