local mod	= DBM:NewMod("Sapphiron", "DBM-Naxx", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20260207153606")
mod:SetCreatureID(15989)
mod:SetEncounterID(1119)
mod:SetHotfixNoticeRev(20250916000000)
mod:SetMinSyncRevision(20220904000000)

mod:RegisterCombat("combat")
mod:SetModelScale(0.1)

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START 28524",
	"SPELL_CAST_SUCCESS 28542 55665 28560 55696",
	"SPELL_AURA_APPLIED 28522 28547 55699",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_HEALTH boss1"
)

--TODO, verify SPELL_CAST_START on retail to switch to it over emote, same as classicc era was done

-- General
local specWarnLowHP		= mod:NewSpecialWarning("SpecWarnSapphLow")

local berserkTimer		= mod:NewBerserkTimer(900)

-- Stage One (Ground Phase)
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1))
local warnDrainLifeNow	= mod:NewSpellAnnounce(28542, 2)
local warnDrainLifeSoon	= mod:NewSoonAnnounce(28542, 1)
local warnAirPhaseSoon	= mod:NewAnnounce("WarningAirPhaseSoon", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnLanded		= mod:NewAnnounce("WarningLanded", 4, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnBlizzard		= mod:NewSpellAnnounce(28560, 4)

local specWarnBlizzard	= mod:NewSpecialWarningGTFO(28547, nil, nil, nil, 1, 8)

local timerDrainLife	= mod:NewCDTimer(24, 28542, nil, nil, nil, 3, nil, DBM_COMMON_L.CURSE_ICON) -- 12s on phasing, then 24s. (Lordaeron: 25man 2022/09/02 || 25m [2025-10-03]@[20:34:05]) - 24.0 || "Life Drain-55665-npc:15989-1261 = pull:11.92/[Stage 1/0.00] 11.92, 23.98, Stage 2/12.66, Stage 1/23.72, 12.05/35.76/48.42"
local timerAirPhase		= mod:NewTimer(60, "TimerAir", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6) -- REVIEW! (Lordaeron: 25m [2025-10-03]@[20:34:05]) - "?-Sapphiron lifts off into the air!-npc:Sapphiron = pull:48.57/[Stage 1/0.00, Stage 2/48.56] 0.01/48.57, Stage 1/23.71"
local timerBlizzard		= mod:NewNextTimer(7, 28560, nil, nil, nil, 3)
local timerTailSweep	= mod:NewNextTimer(9, 55696, nil, nil, nil, 2) -- (Lordaeron: 25m [2025-10-03]@[20:34:05]) - "Tail Sweep-npc:15989-1261 = pull:8.96/[Stage 1/0.00] 8.96, 9.08, 8.97, 9.03, 9.00, Stage 2/3.53, Stage 1/23.72, 9.05/32.77/36.29, 9.01, 8.99"

-- Stage Two (Air Phase)
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2))
local warnAirPhaseNow	= mod:NewAnnounce("WarningAirPhaseNow", 4, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnIceBlock		= mod:NewTargetAnnounce(28522, 2)

local specWarnDeepBreath= mod:NewSpecialWarningSpell(28524, nil, nil, nil, 1, 2)
local yellIceBlock		= mod:NewYell(28522)

local timerLanding		= mod:NewTimer(24.2, "TimerLanding", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6)
local timerIceBlast		= mod:NewCastTimer(8, 28524, nil, nil, nil, 2, DBM_COMMON_L.DEADLY_ICON)

mod:AddRangeFrameOption("12")

--local UnitAffectingCombat = UnitAffectingCombat
--local noTargetTime = 0
local warned_lowhp = false
mod.vb.isFlying = false

--[[local function resetIsFlying(self)
	self.vb.isFlying = false
end]]

local function Landing(self)
	self:SetStage(1)
	warnLanded:Show()
	warnDrainLifeSoon:Schedule(7)
	timerDrainLife:Start(12)
	warnAirPhaseSoon:Schedule(50)
	timerAirPhase:Start()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
		self:Schedule(59, DBM.RangeCheck.Show, DBM.RangeCheck, 12)
	end
end

function mod:OnCombatStart(delay)
--	noTargetTime = 0
	warned_lowhp = false
	self:SetStage(1)
	self.vb.isFlying = false
	warnDrainLifeSoon:Schedule(6.5-delay)
	timerDrainLife:Start(11.92-delay) -- (Lordaeron: 25man 2022/09/02 || 25m [2025-10-03]@[20:34:05]) - 12.0 || 11.92
	timerBlizzard:Start(6.1-delay) -- REVIEW! ~3s variance? (25man Lordaeron 2022/09/02 || 25man Lordaeron 2022/10/16) - 8.8 || 6.1
	timerTailSweep:Start(-delay)
	warnAirPhaseSoon:Schedule(38.4-delay)
	timerAirPhase:Start(48.4-delay) -- REVIEW! ~0.1s variance? (25man Lordaeron 2022/09/02 || 25man Lordaeron 2022/10/16) - 48.4 || 48.57
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		self:Schedule(46-delay, DBM.RangeCheck.Show, DBM.RangeCheck, 12)
	end
--[[self:RegisterOnUpdateHandler(function(self, elapsed)
		if not self:IsInCombat() then return end
		local foundBoss, target
		for uId in DBM:GetGroupMembers() do
			local unitID = uId.."target"
			if self:GetUnitCreatureId(unitID) == 15989 and UnitAffectingCombat(unitID) then
				target = DBM:GetUnitFullName(unitID.."target")
				foundBoss = true
				break
			end
		end
		if foundBoss and not target then
			noTargetTime = noTargetTime + elapsed
		elseif foundBoss then
			noTargetTime = 0
		end
		if noTargetTime > 0.5 and not self.vb.isFlying then
			noTargetTime = 0
			self:SetStage(2)
			self.vb.isFlying = true
			self:Schedule(60, resetIsFlying, self)
			timerDrainLife:Cancel()
			timerAirPhase:Cancel()
			warnAirPhaseNow:Show()
			timerLanding:Start()
		end
	end, 0.2)]]
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 28522 then
		warnIceBlock:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			yellIceBlock:Yell()
		end
	elseif args:IsSpellID(28547, 55699) and args:IsPlayer() and self:AntiSpam(1) then
		specWarnBlizzard:Show(args.spellName)
		specWarnBlizzard:Play("watchfeet")
	end
end

--[[
function mod:SPELL_CAST_START(args)
	--if args:IsSpellID(28524, 29318) then--NEEDS verification before deployed
		timerIceBlast:Start()
		timerLanding:Update(16.3, 28.5)--Probably not even needed, if base timer is more accurate
		self:Schedule(12.2, Landing, self)
		warnDeepBreath:Show()
		warnDeepBreath:Play("findshelter")
	end
end
--]]

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(28542, 55665) then -- Life Drain
		warnDrainLifeNow:Show()
		warnDrainLifeSoon:Schedule(18.5)
		timerDrainLife:Start()
	elseif spellId == 28560 then
		DBM:AddMsg("Sapphiron Blizzard SPELL_CAST_SUCCESS implemented on Warmane server script. Notify Zidras on Discord or GitHub")
		warnBlizzard:Show()
		timerBlizzard:Start()
	elseif spellId == 55696 then
		timerTailSweep:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteBreath or msg:find(L.EmoteBreath) then
--		self:SendSync("DeepBreath") -- this does not need syncing and spam comms
		timerIceBlast:Start()
		timerLanding:Update(13.5, 24.2) -- 8s until breath + 3.5s until emote + ~2s until UNIT_TARGET
		specWarnDeepBreath:Show()
		specWarnDeepBreath:Play("findshelter")
	elseif msg == L.AirPhase or msg:find(L.AirPhase) then
		self:SetStage(2)
		self.vb.isFlying = true
		timerDrainLife:Cancel()
		timerAirPhase:Cancel()
		warnAirPhaseNow:Show()
		timerLanding:Start()
	elseif msg == L.LandingPhase or msg:find(L.LandingPhase) then
		self.vb.isFlying = false
		self:RegisterShortTermEvents(
			"UNIT_TARGET boss1"
		)
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_lowhp and self:GetUnitCreatureId(uId) == 15989 and UnitHealth(uId) / UnitHealthMax(uId) < 0.1 then
		warned_lowhp = true
		specWarnLowHP:Show()
		timerAirPhase:Cancel()
	end
end

function mod:UNIT_TARGET(uId)
	-- Apparently there's a delay after emote where boss is actually engaged (TC has 3.5s). From S3 Naxx videos this is somewhat still accurate, so check when boss retargets raid member, which is when land phase script restarts
	if UnitExists(uId.."target") then
		Landing(self)
		self:UnregisterShortTermEvents()
	end
end

--[[function mod:OnSync(event)
	if event == "DeepBreath" then
		timerIceBlast:Start()
		timerLanding:Update(14)
		self:Schedule(14.5, Landing, self)
		specWarnDeepBreath:Show()
		specWarnDeepBreath:Play("findshelter")
	end
end]]
