local mod	= DBM:NewMod("Thorim", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4177 $"):sub(12, -3))
mod:SetCreatureID(32865)
mod:SetUsedIcons(7)

mod:RegisterCombat("yell", L.YellPhase1)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 62605 64390",
	"SPELL_AURA_APPLIED 62042 62507 62130 62526 62527",
	"SPELL_CAST_SUCCESS 62042 62466 62130 62604",
	"SPELL_DAMAGE 62017",
	"CHAT_MSG_MONSTER_YELL"
)

local warnPhase2					= mod:NewPhaseAnnounce(2, 1)
local warnStormhammer				= mod:NewTargetAnnounce(62470, 2)
local warnLightningCharge			= mod:NewSpellAnnounce(62466, 2)
local warningBomb					= mod:NewTargetAnnounce(62526, 4)

local yellBomb						= mod:NewYell(62526)
local specWarnBomb					= mod:NewSpecialWarningClose(62526, nil, nil, nil, 1, 2)
local specWarnLightningShock		= mod:NewSpecialWarningMove(62017, nil, nil, nil, 1, 2)
local specWarnUnbalancingStrikeSelf	= mod:NewSpecialWarningDefensive(62130, nil, nil, nil, 1, 2)
local specWarnUnbalancingStrike		= mod:NewSpecialWarningTaunt(62130, nil, nil, nil, 1, 2)

mod:AddBoolOption("AnnounceFails", false, "announce")

local enrageTimer					= mod:NewBerserkTimer(369)
local timerStormhammer				= mod:NewBuffActiveTimer(16, 62042, nil, nil, nil, 3)--Cast timer? Review if i ever do this boss again.
local timerLightningCharge	 		= mod:NewCDTimer(16, 62466, nil, nil, nil, 3)
local timerUnbalancingStrike		= mod:NewCDTimer(25.6, 62130, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerHardmode					= mod:NewTimer(150, "TimerHardmode", 62042)
local timerFrostNova				= mod:NewNextTimer(20, 62605)
local timerFrostNovaCast			= mod:NewCastTimer(2.5, 62605)
local timerChainLightning			= mod:NewNextTimer(15, 64390)
local timerFBVolley					= mod:NewCDTimer(13, 62604)

mod:AddRangeFrameOption("8")
mod:AddSetIconOption("SetIconOnRunic", 62527, false, false, {7})

local lastcharge = {}

function mod:OnCombatStart(delay)
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
		for k, v in pairs(lastcharge) do
			table.insert(sortedFailsC, k)
		end
		table.sort(sortedFailsC, sortFails1C)
		for i, v in ipairs(sortedFailsC) do
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
	if spellId == 62042 then 					-- Storm Hammer
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
	elseif args:IsSpellID(62526, 62527) then	-- Runic Detonation
		if args:IsPlayer() then
			yellBomb:Yell()
		elseif self:CheckNearby(10, args.destName) then
			specWarnBomb:Show(args.destName)
			specWarnBomb:Play("runaway")
		else
			warningBomb:Show(args.destName)
		end
		if self.Options.SetIconOnRunic then
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

function mod:OnSync(event, arg)
	if event == "Phase2" and self.vb.phase < 2 then
		self:SetStage(2)
		warnPhase2:Show()
		enrageTimer:Stop()
		timerHardmode:Stop()
		enrageTimer:Start(300)
	end
end