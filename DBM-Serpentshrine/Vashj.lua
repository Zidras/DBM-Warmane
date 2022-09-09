local mod	= DBM:NewMod("Vashj", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220813164045")
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
	"CHAT_MSG_LOOT"
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
local specWarnElemental	= mod:NewSpecialWarning("SpecWarnElemental")--Changed from soon to a now warning. the soon warning not accurate because of 11 second variation so not useful special warning.
local specWarnToxic		= mod:NewSpecialWarningMove(38575, nil, nil, nil, 1, 2)

local timerEntangleCD	= mod:NewCDTimer(20.9, 38316, nil, nil, nil, 3, nil, nil, true) -- Added "keep" arg. 10s variance (25 man FM log 2022/07/27 || 25 man FM log 2022/08/11) - Stage 1/25.9, Stage 3/30.0, 22.9, 24.2, 27.8 || Stage 1/24.8, Stage 3/30.0, 21.4, 20.9, 29.0, 28.6
local timerCharge		= mod:NewTargetTimer(20, 38280, nil, nil, nil, 3)
local timerChargeCD		= mod:NewCDTimer(10.2, 38280, nil, nil, nil, 3, nil, nil, true) -- Added "keep" arg. 10s variance (25 man FM log 2022/07/27 || 25 man FM log 2022/08/11) - Stage 1/20.0, 19.0, 17.8, Stage 3/15.5, 14.2, 18.7, 18.8, 19.1, 10.5, 17.5 || Stage 1/10.2, 15.9, 11.3, Stage 3/17.5, 12.7, 19.2, 19.9, 15.8, 12.0, 19.9
local timerShockBlastCD	= mod:NewCDTimer(10.1, 38509, nil, nil, nil, 3, nil, nil, true) -- Added "keep" arg. 10s variance (25 man FM log 2022/07/27 || 25 man FM log 2022/08/11) - Stage 1/16.3, 17.8, 11.7, Stage 3/27.8, 11.0, 19.0, 11.3, 17.7, 17.2, 17.4 || Stage 1/16.2, 10.1, Stage 3/24.3, 19.8, 14.1, 10.7, 10.6, 19.3, 12.0, 14.7
local timerElemental	= mod:NewTimer(22, "TimerElementalActive", 39088, nil, nil, 1)--Blizz says they are active 20 seconds per patch notes, but my logs don't match those results. 22 second up time.
local timerElementalCD	= mod:NewTimer(45, "TimerElemental", 39088, nil, nil, 1)--46-57 variation. because of high variation the pre warning special warning not useful, fortunately we can detect spawns with precise timing.
local timerStrider		= mod:NewTimer(63, "TimerStrider", 475, nil, nil, 1)
local timerNaga			= mod:NewTimer(47.5, "TimerNaga", 2120, nil, nil, 1)
--local timerMC			= mod:NewCDTimer(21, 38511, nil, nil, nil, 3) -- removed in patch 2.1.

mod:AddRangeFrameOption(10, 38280)
mod:AddSetIconOption("ChargeIcon", 38280, false, false, {1})
--mod:AddBoolOption("AutoChangeLootToFFA", true)

mod.vb.shieldLeft = 4
mod.vb.nagaCount = 1
mod.vb.striderCount = 1
mod.vb.elementalCount = 1
--local lootmethod, masterlooterRaidID
local elementals = {}

local function StriderSpawn(self)
	self.vb.striderCount = self.vb.striderCount + 1
	warnStrider:Schedule(57, tostring(self.vb.striderCount))
	timerStrider:Start(nil, tostring(self.vb.striderCount))
	self:Schedule(63, StriderSpawn, self)
end

local function NagaSpawn(self)
	warnNaga:Schedule(42.5, tostring(self.vb.nagaCount))
	self.vb.nagaCount = self.vb.nagaCount + 1
	timerNaga:Start(nil, tostring(self.vb.nagaCount))
	self:Schedule(47.5, NagaSpawn, self)
end

function mod:OnCombatStart(delay)
	table.wipe(elementals)
	self:SetStage(1)
	self.vb.shieldLeft = 4
	self.vb.nagaCount = 1
	self.vb.striderCount = 1
	self.vb.elementalCount = 1
	timerEntangleCD:Start(29.5-delay) -- REVIEW! variance? (25 man FM log 2022/07/27 || 25 man FM log 2022/08/11) - 29.5 || 29.5
	timerChargeCD:Start(11.6-delay) -- REVIEW! 10s variance? (25 man FM log 2022/07/27 || 25 man FM log 2022/08/11) - 11.6 || 16.3
	timerShockBlastCD:Start(15.2-delay) -- REVIEW! 10s variance? (25 man FM log 2022/07/27 || 25 man FM log 2022/08/11) - 25.2 || 15.2
--	if DBM:IsInGroup() and DBM:GetRaidRank() == 2 then
--		lootmethod, _, masterlooterRaidID = GetLootMethod()
--	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	self:UnregisterShortTermEvents()
--	if DBM:IsInGroup() and self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
--		if masterlooterRaidID then
--			SetLootMethod(lootmethod, "raid"..masterlooterRaidID)
--		else
--			SetLootMethod(lootmethod)
--		end
--	end
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
		specWarnElemental:Show()
		timerElemental:Start()
		elementals[args.sourceGUID] = true
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
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 22009 then
		self.vb.elementalCount = self.vb.elementalCount + 1
		timerElementalCD:Start(nil, tostring(self.vb.elementalCount))
		warnElemental:Schedule(45, tostring(self.vb.elementalCount))
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
		self.vb.nagaCount = 1
		self.vb.striderCount = 1
		self.vb.elementalCount = 1
		self.vb.shieldLeft = 4
		warnPhase2:Show()
		timerChargeCD:Cancel()
		timerNaga:Start(nil, tostring(self.vb.nagaCount))
		warnNaga:Schedule(42.5, tostring(self.vb.elementalCount))
		self:Schedule(47.5, NagaSpawn, self)
		timerElementalCD:Start(nil, tostring(self.vb.elementalCount))
		warnElemental:Schedule(45, tostring(self.vb.elementalCount))
		timerStrider:Start(nil, tostring(self.vb.striderCount))
		warnStrider:Schedule(57, tostring(self.vb.striderCount))
		self:Schedule(63, StriderSpawn, self)
--		if DBM:IsInGroup() and self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
--			SetLootMethod("freeforall")
--		end
		self:RegisterShortTermEvents(
			"UNIT_SPELLCAST_FAILED_QUIET_UNFILTERED"
		)
	elseif msg == L.DBM_VASHJ_YELL_PHASE3 or msg:find(L.DBM_VASHJ_YELL_PHASE3) then
		self:SetStage(3)
		warnPhase3:Show()
		timerNaga:Cancel()
		warnNaga:Cancel()
		timerElementalCD:Cancel()
		warnElemental:Cancel()
		timerStrider:Cancel()
		warnStrider:Cancel()
		self:Unschedule(NagaSpawn)
		self:Unschedule(StriderSpawn)
		self:UnregisterShortTermEvents()
		timerChargeCD:Start()
--		if DBM:IsInGroup() and self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
--			if masterlooterRaidID then
--				SetLootMethod(lootmethod, "raid"..masterlooterRaidID)
--			else
--				SetLootMethod(lootmethod)
--			end
--		end
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