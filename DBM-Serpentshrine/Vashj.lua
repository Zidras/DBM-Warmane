local mod	= DBM:NewMod("Vashj", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250213133410")
mod:SetCreatureID(21212)
--mod:SetModelID(20748)
mod:SetUsedIcons(1)
mod:SetHotfixNoticeRev(20210919000000)
mod:SetMinSyncRevision(20210919000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 38280 38575",
	"SPELL_AURA_REMOVED 38280 38132 38112",
	"SPELL_CAST_START 38253",
	"SPELL_CAST_SUCCESS 38316 38509",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_LOOT",
	"PARTY_LOOT_METHOD_CHANGED"
)

local warnCharge		= mod:NewTargetNoFilterAnnounce(38280, 4)
local warnEntangle		= mod:NewSpellAnnounce(38316, 3)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnElemental		= mod:NewAnnounce("WarnElemental", 4, 31687)
local warnStrider		= mod:NewAnnounce("WarnStrider", 3, 475)
local warnNaga			= mod:NewAnnounce("WarnNaga", 3, 2120)
local warnShield		= mod:NewAnnounce("WarnShield", 3, 38112)
local warnLoot			= mod:NewAnnounce("WarnLoot", 4, 38132)
local warnPhase3		= mod:NewPhaseAnnounce(3)

--local specWarnCore		= mod:NewSpecialWarning("SpecWarnCore", nil, nil, nil, 1, 8)
local specWarnCharge	= mod:NewSpecialWarningMoveAway(38280, nil, nil, nil, 1, 2)
local yellCharge		= mod:NewYell(38280)
local specWarnElemental	= mod:NewSpecialWarning("SpecWarnElemental")
local specWarnToxic		= mod:NewSpecialWarningMove(38575, nil, nil, nil, 1, 2)

local timerEntangleCD	= mod:NewVarTimer("v20-30", 38316, nil, nil, nil, 3) -- Appears to have 10s variance still as of 15.01.2025 on Onyxia PTR -- pull:29.99/[Stage 1/0.00] 29.99, Stage 2/22.77, Stage 3/270.67, 30.01/300.67/323.44, 25.93, 20.98, 20.12, 24.52"
local timerCharge		= mod:NewTargetTimer(20, 38280, nil, nil, nil, 3)
local timerChargeCD		= mod:NewVarTimer("v10-20", 38280, nil, nil, nil, 3) -- At least 10s variance as of 15.01.2025 on Onyxia PTR -- pull:15.65/[Stage 1/0.00] 15.65, 16.30, 16.68, Stage 2/4.14, Stage 3/270.67, 11.79/282.45/286.59, 11.26, 15.86, 12.87, 12.57, 14.43, 16.71, 11.34, 11.73"
local timerShockBlastCD	= mod:NewVarTimer("v10-20", 38509, nil, nil, nil, 3) -- At least 10s variance as of 15.01.2025 on Onyxia PTR -- pull:18.32/[Stage 1/0.00] 18.32, 11.71, 12.37, Stage 2/10.37, Stage 3/270.67, 19.40/290.07/300.44, 14.63, 10.72, 13.05, 16.88, 10.91, 13.39
local timerElemental	= mod:NewTimer(15, "TimerElementalActive", 39088, nil, nil, 1)
local timerElementalCD	= mod:NewTimer(50, "TimerElemental", 39088, nil, nil, 1) -- Seems to be 50s flat as of 15.01.2025 on Onyxia PTR
local timerStrider		= mod:NewTimer(63, "TimerStrider", 475, nil, nil, 1)
local timerNaga			= mod:NewTimer(47.5, "TimerNaga", 2120, nil, nil, 1)
--local timerMC			= mod:NewCDTimer(21, 38511, nil, nil, nil, 3) -- removed in patch 2.1.

mod:AddRangeFrameOption(10, 38280)
mod:AddSetIconOption("ChargeIcon", 38280, false, false, {1})
mod:AddBoolOption("AutoChangeLootToFFA", true)

mod.vb.shieldLeft = 4
mod.vb.nagaCount = 0
mod.vb.striderCount = 0
mod.vb.elementalCount = 0
local cachedLootmethod, _, masterlooterRaidID
local elementals = {}

local function StriderSpawn(self)
	self.vb.striderCount = self.vb.striderCount + 1
	warnStrider:Schedule(57, tostring(self.vb.striderCount + 1))
	timerStrider:Start(nil, tostring(self.vb.striderCount + 1))
	self:Schedule(63, StriderSpawn, self)
end

local function NagaSpawn(self)
	self.vb.nagaCount = self.vb.nagaCount + 1
	warnNaga:Schedule(42.5, tostring(self.vb.nagaCount + 1))
	timerNaga:Start(nil, tostring(self.vb.nagaCount + 1))
	self:Schedule(47.5, NagaSpawn, self)
end

function mod:OnCombatStart(delay)
	table.wipe(elementals)
	self:SetStage(1)
	self.vb.shieldLeft = 4
	self.vb.nagaCount = 0
	self.vb.striderCount = 0
	self.vb.elementalCount = 0
	timerEntangleCD:Start(30-delay) -- Appears to be static 30s upon starting combat (As of 15.01.2025 on Onyxia PTR)
	timerChargeCD:Start()
	timerShockBlastCD:Start()
	-- Cache the loot method in case loot gets manually changed to ffa before Phase 2
	if DBM:GetRaidRank() == 2 then
		cachedLootmethod, _, masterlooterRaidID = GetLootMethod()
		if cachedLootmethod == "freeforall" then cachedLootmethod = nil end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	self:UnregisterShortTermEvents()
	-- Don't change loot if it was manually changed away from ffa
	if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 and GetLootMethod() == "freeforall" and cachedLootmethod then
		if masterlooterRaidID then
			SetLootMethod(cachedLootmethod, "raid"..masterlooterRaidID)
		else
			SetLootMethod(cachedLootmethod)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 38280 then
		timerCharge:Start(args.destName)
		timerChargeCD:Start()
		if args:IsPlayer() then
			specWarnCharge:Show()
			specWarnCharge:Play("runout")
			yellCharge:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		else
			warnCharge:Show(args.destName)
		end
		if self.Options.ChargeIcon then
			self:SetIcon(args.destName, 1, 20)
		end
	elseif spellId == 38575 and args:IsPlayer() and self:AntiSpam() then
		specWarnToxic:Show()
		specWarnToxic:Play("runaway")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 38280 then
		timerCharge:Stop(args.destName)
		if self.Options.ChargeIcon then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif spellId == 38132 then
		if self.Options.LootIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 38112 then--and not self:IsTrivial()
		DBM:AddMsg("Magic Barrier unhidden from combat log. Notify Zidras on Discord or GitHub")
		self.vb.shieldLeft = self.vb.shieldLeft - 1
		warnShield:Show(self.vb.shieldLeft)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 38253 and not elementals[args.sourceGUID] then
		elementals[args.sourceGUID] = true
		self.vb.elementalCount = self.vb.elementalCount + 1
		specWarnElemental:Show()
		timerElemental:Start()
		warnElemental:Schedule(45, tostring(self.vb.elementalCount + 1))
		timerElementalCD:Start(nil, tostring(self.vb.elementalCount + 1))
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 38316 then
		timerEntangleCD:Start()
		warnEntangle:Show()
	elseif spellId == 38509 then
		timerShockBlastCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cId = self:GetCIDFromGUID(args.destGUID)
	if cId == 22009 then
		timerElemental:Cancel()
	end
end

function mod:UNIT_SPELLCAST_FAILED_QUIET_UNFILTERED(uId, spellName)
	if spellName == GetSpellInfo(24390) and self:AntiSpam(2, 2) then -- Opening. This is an experimental feature to try and detect when an Invis KV Shield Generator dies
		DBM:Debug("UNIT_SPELLCAST_FAILED_QUIET_UNFILTERED fired for player:" .. (uId and UnitName(uId) or "Unknown") .. " with the spell: " .. spellName)
		self.vb.shieldLeft = self.vb.shieldLeft - 1
		warnShield:Show(self.vb.shieldLeft)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_VASHJ_YELL_PHASE2 or msg:find(L.DBM_VASHJ_YELL_PHASE2) then
		self:SetStage(2)
		self.vb.nagaCount = 0
		self.vb.striderCount = 0
		self.vb.elementalCount = 0
		self.vb.shieldLeft = 4
		warnPhase2:Show()
		-- Cancel P1 timers
		timerEntangleCD:Cancel()
		timerChargeCD:Cancel()
		timerShockBlastCD:Cancel()
		-- Start P2 timers
		warnNaga:Schedule(42.5, tostring(self.vb.nagaCount + 1))
		timerNaga:Start(nil, tostring(self.vb.nagaCount + 1))
		self:Schedule(47.5, NagaSpawn, self)
		warnStrider:Schedule(57, tostring(self.vb.striderCount + 1))
		timerStrider:Start(nil, tostring(self.vb.striderCount + 1))
		self:Schedule(63, StriderSpawn, self)
		warnElemental:Schedule(45, tostring(self.vb.elementalCount + 1))
		timerElementalCD:Start(nil, tostring(self.vb.elementalCount + 1))
		if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 and GetLootMethod() ~= "freeforall" then
			cachedLootmethod, _, masterlooterRaidID = GetLootMethod()
			SetLootMethod("freeforall")
		end
		self:RegisterShortTermEvents(
			"UNIT_SPELLCAST_FAILED_QUIET_UNFILTERED"
		)
	elseif msg == L.DBM_VASHJ_YELL_PHASE3 or msg:find(L.DBM_VASHJ_YELL_PHASE3) then
		self:SetStage(3)
		warnPhase3:Show()
		warnNaga:Cancel()
		timerNaga:Cancel()
		self:Unschedule(NagaSpawn)
		warnStrider:Cancel()
		timerStrider:Cancel()
		self:Unschedule(StriderSpawn)
		warnElemental:Cancel()
		timerElementalCD:Cancel()
		self:UnregisterShortTermEvents()
		timerEntangleCD:Start(30) -- Appears to be static 30s upon entering P3 (As of 15.01.2025 on Onyxia PTR)
		timerChargeCD:Start()
		timerShockBlastCD:Start()
		-- Don't change loot if it was manually changed
		if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 and GetLootMethod() == "freeforall" and cachedLootmethod then
			if masterlooterRaidID then
				SetLootMethod(cachedLootmethod, "raid"..masterlooterRaidID)
			else
				SetLootMethod(cachedLootmethod)
			end
		end
	end
end

function mod:CHAT_MSG_LOOT(msg)
	-- DBM:AddMsg(msg) --> Meridium receives loot: [Magnetic Core]
	local player, itemID = msg:match(L.LootMsg)
	if player and itemID and tonumber(itemID) == 31088 and self:IsInCombat() then
		-- attempt to correct player name when the player is the one looting
		if DBM:GetGroupId(player) == 0 then -- workaround to determine that player doesn't exist in our group
			if player == DBM_COMMON_L.YOU then -- LOOT_ITEM_SELF = "You receive loot: %s." Not useable in all locales since there is no pronoun or not translateable "YOU" (ES: Recibes botín: %s.")
				player = UnitName("player") -- convert localized "You" to player name
			else -- logically is more prone to be innacurate, but do it anyway to account for the locales without a useable YOU and prevent UNKNOWN player name on sync handler
				player = UnitName("player")
			end
		end
		self:SendSync("LootMsg", player)
	end
end

-- Case where combat was started with the wrong loot and changed manually, and then put to ffa manually before Phase 2
-- This will not protect against misclicks before changing manually to ffa (loot will be returned to last misclicked type)
function mod:PARTY_LOOT_METHOD_CHANGED()
	if self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 and self:GetStage(1) and GetLootMethod() ~= "freeforall" then
		cachedLootmethod, _, masterlooterRaidID = GetLootMethod()
	end
end

function mod:OnSync(event, playerName)
	if not self:IsInCombat() then return end
	if event == "LootMsg" and playerName then
		playerName = DBM:GetUnitFullName(playerName)
		if self:AntiSpam(2, playerName) then
--			if playerName == UnitName("player") then
--				specWarnCore:Show()
--				specWarnCore:Play("useitem")
--			else
				warnLoot:Show(playerName)
--			end
		end
	end
end
