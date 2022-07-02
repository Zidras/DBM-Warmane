local mod	= DBM:NewMod("Thorim", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220701215737")
mod:SetCreatureID(32865)
mod:SetUsedIcons(7)

mod:RegisterCombat("combat_yell", L.YellPhase1)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 62605 64390",
	"SPELL_AURA_APPLIED 62042 62507 62130 62526 62527",
	"SPELL_CAST_SUCCESS 62042 62466 62130 62604",
	"SPELL_DAMAGE 62017",
	"CHAT_MSG_MONSTER_YELL"
)

-- General
local enrageTimer					= mod:NewBerserkTimer(369)

mod:AddRangeFrameOption("8")

-- Stage One
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1))
local warnStormhammer				= mod:NewTargetNoFilterAnnounce(62042, 2)
local warnRuneDetonation			= mod:NewTargetNoFilterAnnounce(62526, 4)

local specWarnRuneDetonation		= mod:NewSpecialWarningClose(62526, nil, nil, nil, 1, 2)
local yellRuneDetonation			= mod:NewYell(62526)
local specWarnLightningShock		= mod:NewSpecialWarningMove(62017, nil, nil, nil, 1, 2)

local timerHardmode					= mod:NewTimer(150, "TimerHardmode", 62042, nil, nil, 0, nil, nil, nil, nil, nil, nil, nil, 62507)
local timerStormhammer				= mod:NewBuffActiveTimer(16, 62042, nil, nil, nil, 3)--Cast timer? Review if i ever do this boss again.

mod:AddSetIconOption("SetIconOnRuneDetonation", 62527, false, false, {7})

-- Stage Two
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2))
local warnPhase2					= mod:NewPhaseAnnounce(2, 1, nil, nil, nil, nil, nil, 2)
local warnLightningCharge			= mod:NewSpellAnnounce(62466, 2)

local specWarnUnbalancingStrikeSelf	= mod:NewSpecialWarningDefensive(62130, nil, nil, nil, 1, 2)
local specWarnUnbalancingStrike		= mod:NewSpecialWarningTaunt(62130, nil, nil, nil, 1, 2)

local timerLightningCharge	 		= mod:NewCDTimer(16, 62466, nil, nil, nil, 3)
local timerUnbalancingStrike		= mod:NewCDTimer(25.6, 62130, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerChainLightning			= mod:NewNextTimer(15, 64390)

mod:AddBoolOption("AnnounceFails", false, "announce", nil, nil, nil, 62466)

-- Hard Mode
mod:AddTimerLine(DBM_COMMON_L.HEROIC_ICON..DBM_CORE_L.HARD_MODE)
local timerFrostNova				= mod:NewNextTimer(20, 62605, nil, nil, nil, 2, nil, DBM_COMMON_L.MAGIC_ICON)
local timerFrostNovaCast			= mod:NewCastTimer(2.5, 62605, nil, nil, nil, 2, nil, DBM_COMMON_L.MAGIC_ICON)
local timerFBVolley					= mod:NewCDTimer(13, 62604)

--mod:GroupSpells(62042, 62470) -- Stormhammer, Deafening Thunder
mod:GroupSpells(62526, 62527) -- Rune of Detonation

local lastcharge = {}

function mod:OnCombatStart()
	self:SetStage(1)
	enrageTimer:Start()
	timerHardmode:Start()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	table.wipe(lastcharge)
end

local sortedFailsC = {}
local function sortFails1C(e1, e2)
	return (lastcharge[e1] or 0) > (lastcharge[e2] or 0)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.AnnounceFails and DBM:GetRaidRank() >= 1 then
		local lcharge = ""
		for k, _ in pairs(lastcharge) do
			table.insert(sortedFailsC, k)
		end
		table.sort(sortedFailsC, sortFails1C)
		for _, v in ipairs(sortedFailsC) do
			lcharge = lcharge.." "..v.."("..(lastcharge[v] or "")..")"
		end
		SendChatMessage(L.Charge:format(lcharge), "RAID")
		table.wipe(sortedFailsC)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 62605 then		-- Frost Nova by Sif
		timerFrostNovaCast:Start()
		timerFrostNova:Start()
	elseif spellId == 64390 then	-- Chain Lightning by Thorim
		timerChainLightning:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62042 and self:CheckBossDistance(args.sourceGUID, true, 34471) then	-- Storm Hammer. Within range of Vial of the Sunwell (43)
		warnStormhammer:Show(args.destName)
	elseif spellId == 62507 then				-- Touch of Dominion
		timerHardmode:Start(150)
	elseif spellId == 62130 then				-- Unbalancing Strike
		if args:IsPlayer() then
			specWarnUnbalancingStrikeSelf:Show()
			specWarnUnbalancingStrikeSelf:Play("defensive")
		else
			specWarnUnbalancingStrike:Show(args.destName)
			specWarnUnbalancingStrike:Play("tauntboss")
		end
	elseif args:IsSpellID(62526, 62527) then	-- Rune Detonation
		if args:IsPlayer() then
			yellRuneDetonation:Yell()
		elseif self:CheckNearby(10, args.destName) then
			specWarnRuneDetonation:Show(args.destName)
			specWarnRuneDetonation:Play("runaway")
		elseif self:CheckBossDistance(args.sourceGUID, true, 1180) then--Within Scroll of Stamina range (33)
			warnRuneDetonation:Show(args.destName)
		end
		if self.Options.SetIconOnRuneDetonation then
			self:SetIcon(args.destName, 7, 5)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 62042 then		-- Storm Hammer
		timerStormhammer:Schedule(2)
	elseif spellId == 62466 then	-- Lightning Charge
		warnLightningCharge:Show()
		timerLightningCharge:Start()
	elseif spellId == 62130 then	-- Unbalancing Strike
		timerUnbalancingStrike:Start()
	elseif spellId == 62604 then	-- Frostbolt Volley by Sif
		timerFBVolley:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destName, destFlags, spellId)
	if spellId == 62017 then -- Lightning Shock
		if bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0
		and bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		and self:AntiSpam(5) then
			specWarnLightningShock:Show()
			specWarnLightningShock:Play("runaway")
		end
	elseif self.Options.AnnounceFails and spellId == 62466 and DBM:GetRaidRank() >= 1 and DBM:GetRaidUnitId(destName) ~= "none" and destName then
		lastcharge[destName] = (lastcharge[destName] or 0) + 1
		SendChatMessage(L.ChargeOn:format(destName), "RAID")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then		-- Bossfight (tank and spank)
		self:SendSync("Phase2")
	-- elseif msg == L.YellKill or msg:find(L.YellKill) then
	-- 	enrageTimer:Stop()
	end
end

function mod:OnSync(event)
	if event == "Phase2" and self.vb.phase < 2 then
		self:SetStage(2)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		enrageTimer:Stop()
		timerHardmode:Stop()
		enrageTimer:Start(300)
	end
end