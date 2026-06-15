local mod	= DBM:NewMod("FlameLeviathan", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221031101217")

mod:SetCreatureID(33113)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_SAY"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 62396 62475 62374 62297",
	"SPELL_AURA_REMOVED 62396 62374",
	"SPELL_SUMMON 62907"
)

local warnHodirsFury			= mod:NewTargetAnnounce(62297, 3)
local warnPursueTarget			= mod:NewAnnounce("PursueWarn", 2, 62374, nil, nil, nil, 62374)
local warnNextPursueSoon		= mod:NewAnnounce("warnNextPursueSoon", 3, 62374, nil, nil, nil, 62374)

local specWarnSystemOverload	= mod:NewSpecialWarningSpell(62475, nil, nil, nil, 1, 12)
local specWarnPursue			= mod:NewSpecialWarning("SpecialPursueWarnYou", nil, nil, 2, 4, 2, nil, 62374, 62374)

local timerSystemOverload		= mod:NewBuffActiveTimer(20, 62475, nil, nil, nil, 6)
local timerFlameVents			= mod:NewCastTimer(10, 62396, nil, nil, nil, 2, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timertFlameVentsCD		= mod:NewCDTimer(19.7, 62396, nil, nil, nil, 2) -- ~0.5s variance (S3 FM Log review 2022/07/17 || 25m Lordaeron 2022/10/30) - 0.1, 20.0, 20.0, 20.1, 20.0, 20.3 || 20.3, 19.7, 20.0, 20.1
local timerPursued				= mod:NewTargetTimer(30, 62374, nil, nil, nil, 3) -- Variance dependent on whether boss is pulled right after gate opens or not. Corrected using count. S3 FM Log review 2022/07/17 - 0.1, 11.0, 19.0, 30.0, 30.0, 30.0

-- Hard Mode
mod:AddTimerLine(DBM_COMMON_L.HEROIC_ICON..DBM_CORE_L.HARD_MODE)
local specWarnWardOfLife		= mod:NewSpecialWarning("warnWardofLife", nil, nil, nil, 1, 2, nil, 62907, 62907)

local timerNextWardOfLife		= mod:NewNextTimer(30, 62907, nil, nil, nil, 1)

mod.vb.pursueCount = 0
local bossMovingSpeed = 0
local gateSmash = 0
local firstRushPull = false
local guids = {}
local function buildGuidTable(self)
	table.wipe(guids)
	for uId in DBM:GetGroupMembers() do
		local name, server = GetUnitName(uId, true)
		local fullName = name .. (server and server ~= "" and ("-" .. server) or "")
		guids[UnitGUID(uId.."pet") or "none"] = fullName
	end
end

local function CheckTowers(self, delay)
	if DBM:UnitBuff("boss1", 64482) then -- Tower of Life
		timerNextWardOfLife:Start(41 - delay) -- S2 VOD review
	end
end

function mod:OnCombatStart(delay)
	firstRushPull = false
	DBM:Debug("OnCombatStart boss1 was pulled ".. (gateSmash and (GetTime() - gateSmash) or "nil") .. " seconds after Radio say")
	bossMovingSpeed = GetUnitSpeed("boss1") -- 2022/07/22: Failed on two logs... || attempt to identify if boss pulled right after gate opens or if it is stationary, since it will affect Pursue timer accuracy.
	if gateSmash ~= 0 and GetTime() - gateSmash < 6.9 then
		firstRushPull = true
		DBM:Debug("OnCombatStart boss1 was rush pulled!")
	end
	buildGuidTable(self)
	self.vb.pursueCount = 0
	timertFlameVentsCD:Start(20-delay) -- 25 man log review (2022/07/10 || 25m Lordaeron 2022/10/30) - 20.0 || 20.0
	self:Schedule(5, CheckTowers, self, delay)
	DBM:Debug("OnCombatStart boss1 had speed: "..bossMovingSpeed)
end

function mod:OnTimerRecovery()
	buildGuidTable(self)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62396 then		-- Flame Vents
		timerFlameVents:Start()
		timertFlameVentsCD:Start()
	elseif spellId == 62475 then	-- Systems Shutdown / Overload
		timerSystemOverload:Start()
		timertFlameVentsCD:Stop()
		timertFlameVentsCD:Start(40) -- Same for 10 and 25m (S3 FM 25HM cleu log 2022/07/16)
		specWarnSystemOverload:Show()
		specWarnSystemOverload:Play("attacktank")
	elseif spellId == 62374 then	-- Pursued
		local target = guids[args.destGUID]
		self.vb.pursueCount = self.vb.pursueCount + 1 -- Variance in 2nd and 3rd, when pulled during gate animation. Hardcoded based on logs. S3 FM Log review 2022/07/17 - 0.1, 11.0, 19.0, 30.0, 30.0, 30.0
		if firstRushPull or bossMovingSpeed ~= 0 then
			DBM:Debug("Running Pursued timer in gate pull mode. boss1 had speed: "..bossMovingSpeed) -- 27.99370765686
			if self.vb.pursueCount == 1 then
				warnNextPursueSoon:Schedule(5.4)
				timerPursued:Start(10.4, target) -- S2 Lord 2022/07/10 || S3 FM 2022/07/17 - 10.4 || 11.0
			elseif self.vb.pursueCount == 2 then
				warnNextPursueSoon:Schedule(14.0)
				timerPursued:Start(19.0, target) -- S2 Lord 2022/07/10 || S3 FM 2022/07/17 - 19.6 || 19.0
			else
				warnNextPursueSoon:Schedule(25)
				timerPursued:Start(target)
			end
		else
			DBM:Debug("Running Pursued timer in stationary pull mode. boss1 had speed: "..bossMovingSpeed) -- 0
			warnNextPursueSoon:Schedule(25)
			timerPursued:Start(target)
		end
		if target then
			warnPursueTarget:Show(target)
			if target == UnitName("player") then
				specWarnPursue:Show()
				specWarnPursue:Play("justrun")
			end
		end
	elseif spellId == 62297 then	-- Hodir's Fury (Person is frozen)
		local target = guids[args.destGUID]
		if target then
			warnHodirsFury:Show(target)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 62396 then
		timerFlameVents:Stop()
	elseif spellId == 62374 then	-- Pursued
		local target = guids[args.destGUID]
		timerPursued:Stop(target)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 62907 and self:AntiSpam(3, 1) then		-- Ward of Life spawned (Creature id: 34275)
		specWarnWardOfLife:Show()
		specWarnWardOfLife:Show("bigmob")
		timerNextWardOfLife:Start() -- S2 VOD review
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.RadioGateSmash then
		gateSmash = GetTime() -- 6.9170000000004 seconds until FL full stop
	end
end
