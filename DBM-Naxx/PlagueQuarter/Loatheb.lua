local mod	= DBM:NewMod("Loatheb", "DBM-Naxx", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221022102923")
mod:SetCreatureID(16011)

mod:RegisterCombat("combat")--Maybe change to a yell later so pull detection works if you chain pull him from tash gauntlet

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 29234 29204 55052 30281 55593",
	"SPELL_AURA_APPLIED 29185 29194 29196 29198",-- 29184 29195 29197 29199
	"SPELL_AURA_REMOVED 29185 29194 29196 29198",-- 29184 29195 29197 29199
	"SPELL_DAMAGE",
	"SWING_DAMAGE",
	"UNIT_DIED"
)

--TODO, verify infoframe and spellIds ported from Classic as accurate, they didn't have to be accurate in classic since it just matched name, but here it does
--Also, 55593 is used instead of classic ID since classic ID has no tooltip
local warnSporeNow	= mod:NewCountAnnounce(32329, 2)
local warnSporeSoon	= mod:NewSoonAnnounce(32329, 1)
local warnDoomNow	= mod:NewSpellAnnounce(29204, 3)
local warnRemoveCurse		= mod:NewSpellAnnounce(30281, 3)
local warnHealSoon	= mod:NewAnnounce("WarningHealSoon", 4, 48071, nil, nil, nil, 55593)
local warnHealNow	= mod:NewAnnounce("WarningHealNow", 1, 48071, false, nil, nil, 55593)

local timerSpore	= mod:NewNextTimer(36, 32329, nil, nil, nil, 5, 42524, DBM_COMMON_L.DAMAGE_ICON)
local timerDoom		= mod:NewNextTimer(180, 29204, nil, nil, nil, 2)
--local timerRemoveCurseCD	= mod:NewNextTimer(30.8, 30281, nil, nil, nil, 5)
local timerAura		= mod:NewBuffActiveTimer(17, 55593, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)

mod:AddInfoFrameOption(55593, "Tank|Healer")
mod:AddBoolOption("SporeDamageAlert", false)
if not DBM.Options.GroupOptionsBySpell then
	mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
end
mod:AddDropdownOption("CorruptedSorting", {"Alphabetical", "Duration"}, "Alphabetical", "misc", nil, 55593)

mod.vb.doomCounter	= 0
mod.vb.sporeTimer	= 36
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
--	timerRemoveCurseCD:Start(3 - delay)
	if self:IsDifficulty("normal25") then
		self.vb.sporeTimer = 15
		timerDoom:Start(90 - delay, 1)
	else
		self.vb.sporeTimer = 36
		timerDoom:Start(120 - delay, 1)
	end
	timerSpore:Start(self.vb.sporeTimer - delay, 1)
	warnSporeSoon:Schedule(self.vb.sporeTimer - 5 - delay)

	local startTime = GetTime()
	table.wipe(hadCorrupted)
	for unit in DBM:GetGroupMembers() do
		local _, cls = UnitClass(unit)
		if not UnitIsDeadOrGhost(unit) and (cls == "DRUID" or cls == "PALADIN" or cls == "PRIEST" or cls == "SHAMAN") then
			hadCorrupted[UnitName(unit)] = startTime
		end
	end
	if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(55593))
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
		warnSporeSoon:Schedule(self.vb.sporeTimer - 5)
	elseif args:IsSpellID(29204, 55052) then  -- Inevitable Doom
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
--		timerRemoveCurseCD:Start()
	elseif spellId == 55593 then
		timerAura:Start()
		warnHealSoon:Schedule(14)
		warnHealNow:Schedule(17)
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
	if args:IsSpellID(29194, 29196, 29185, 29198) and DBM:UnitDebuff(args.destName, 29184, 29195, 29197, 29199) then
		hadCorrupted[args.destName] = GetTime() + 60
		if args:IsPlayer() then
			warnHealSoon:Schedule(55)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(29194, 29196, 29185, 29198) and not DBM:UnitDebuff(args.destName, 29184, 29195, 29197, 29199) then
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
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 16011 then
		warnSporeSoon:Cancel()
		warnHealSoon:Cancel()
		warnHealNow:Cancel()
	elseif hadCorrupted[args.destName] then
		hadCorrupted[args.destName] = nil
	end
end
