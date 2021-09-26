local mod	= DBM:NewMod("Vashj", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(21212)

mod:SetModelID(20748)
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 38280 38575",
	"SPELL_AURA_REMOVED 38280 38132",
	"SPELL_CAST_START 38253",
	"SPELL_CAST_SUCCESS 38316",
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
--local warnShield		= mod:NewAnnounce("WarnShield", 3)
local warnLoot			= mod:NewAnnounce("WarnLoot", 4, 38132)
local warnPhase3		= mod:NewPhaseAnnounce(3)

local specWarnCharge	= mod:NewSpecialWarningMoveAway(38280, nil, nil, nil, 1, 2)
local yellCharge		= mod:NewYell(38280)
local specWarnElemental	= mod:NewSpecialWarning("SpecWarnElemental")--Changed from soon to a now warning. the soon warning not accurate because of 11 second variation so not useful special warning.
local specWarnToxic		= mod:NewSpecialWarningMove(38575, nil, nil, nil, 1, 2)

local timerCharge		= mod:NewTargetTimer(20, 38280, nil, nil, nil, 3)
local timerElemental	= mod:NewTimer(22, "TimerElementalActive", 39088, nil, nil, 1)--Blizz says they are active 20 seconds per patch notes, but my logs don't match those results. 22 second up time.
local timerElementalCD	= mod:NewTimer(45, "TimerElemental", 39088, nil, nil, 1)--46-57 variation. because of high variation the pre warning special warning not useful, fortunately we can detect spawns with precise timing.
local timerStrider		= mod:NewTimer(63, "TimerStrider", 475, nil, nil, 1)
local timerNaga			= mod:NewTimer(47.5, "TimerNaga", 2120, nil, nil, 1)

mod:AddRangeFrameOption(10, 38280)
mod:AddSetIconOption("ChargeIcon", 38280, false, false, {1})
--mod:AddBoolOption("AutoChangeLootToFFA", true)

mod.vb.shieldLeft = 4
mod.vb.nagaCount = 1
mod.vb.striderCount = 1
mod.vb.elementalCount = 1
--local lootmethod, masterlooterRaidID
local elementals = {}

function mod:StriderSpawn()
	self.vb.striderCount = self.vb.striderCount + 1
	timerStrider:Start(nil, tostring(self.vb.striderCount))
	warnStrider:Schedule(57, tostring(self.vb.striderCount))
	self:ScheduleMethod(63, "StriderSpawn")
end

function mod:NagaSpawn()
	self.vb.nagaCount = self.vb.nagaCount + 1
	timerNaga:Start(nil, tostring(self.vb.nagaCount))
	warnNaga:Schedule(42.5, tostring(self.vb.nagaCount))
	self:ScheduleMethod(47.5, "NagaSpawn")
end

function mod:OnCombatStart(delay)
	table.wipe(elementals)
	self:SetStage(1)
	self.vb.shieldLeft = 4
	self.vb.nagaCount = 1
	self.vb.striderCount = 1
	self.vb.elementalCount = 1
--	if IsInGroup() and DBM:GetRaidRank() == 2 then
--		lootmethod, _, masterlooterRaidID = GetLootMethod()
--	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
--	if IsInGroup() and self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
--		if masterlooterRaidID then
--			SetLootMethod(lootmethod, "raid"..masterlooterRaidID)
--		else
--			SetLootMethod(lootmethod)
--		end
--	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 38280 then
		timerCharge:Start(args.destName)
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
	elseif args.spellId == 38575 and args:IsPlayer() and self:AntiSpam() then
		specWarnToxic:Show()
		specWarnToxic:Play("runaway")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 38280 then
		timerCharge:Stop(args.destName)
		if self.Options.ChargeIcon then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif args.spellId == 38132 then
		if self.Options.LootIcon then
			self:SetIcon(args.destName, 0)
		end
	--[[elseif args.spellId == 38112 then
		self.vb.shieldLeft = self.vb.shieldLeft - 1
		warnShield:Show(self.vb.shieldLeft)]]
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
	if args.spellId == 38316 then
		warnEntangle:Show()
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

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_VASHJ_YELL_PHASE2 or msg:find(L.DBM_VASHJ_YELL_PHASE2) then
		self:SetStage(2)
		self.vb.nagaCount = 1
		self.vb.striderCount = 1
		self.vb.elementalCount = 1
		self.vb.shieldLeft = 4
		warnPhase2:Show()
		timerNaga:Start(nil, tostring(self.vb.nagaCount))
		warnNaga:Schedule(42.5, tostring(self.vb.elementalCount))
		self:ScheduleMethod(47.5, "NagaSpawn")
		timerElementalCD:Start(nil, tostring(self.vb.elementalCount))
		warnElemental:Schedule(45, tostring(self.vb.elementalCount))
		timerStrider:Start(nil, tostring(self.vb.striderCount))
		warnStrider:Schedule(57, tostring(self.vb.striderCount))
		self:ScheduleMethod(63, "StriderSpawn")
--		if IsInGroup() and self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
--			SetLootMethod("freeforall")
--		end
	elseif msg == L.DBM_VASHJ_YELL_PHASE3 or msg:find(L.DBM_VASHJ_YELL_PHASE3) then
		self:SetStage(3)
		warnPhase3:Show()
		timerNaga:Cancel()
		warnNaga:Cancel()
		timerElementalCD:Cancel()
		warnElemental:Cancel()
		timerStrider:Cancel()
		warnStrider:Cancel()
		self:UnscheduleMethod("NagaSpawn")
		self:UnscheduleMethod("StriderSpawn")
--		if IsInGroup() and self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
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
		self:SendSync("LootMsg", player)
	end
end

function mod:OnSync(event, playerName)
	if not self:IsInCombat() then return end
	if event == "LootMsg" and playerName then
		playerName = DBM:GetUnitFullName(playerName)
		if self:AntiSpam(2, playerName) then
			warnLoot:Show(playerName)
		end
	end
end
