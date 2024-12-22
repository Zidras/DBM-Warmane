local mod	= DBM:NewMod("Sapphiron-Vanilla", "DBM-VanillaNaxx", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240814163209")
mod:SetCreatureID(15989)
mod:SetMinSyncRevision(20220904000000)

mod:RegisterCombat("combat")
mod:SetModelScale(0.1)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 28524",
	"SPELL_CAST_SUCCESS 28542 55665 28560 55696",
	"SPELL_AURA_APPLIED 28522 28547 55699",
	"CHAT_MSG_RAID_BOSS_EMOTE", -- 2024/07/10 it was confirmed to be left out of the script on purpose, to keep it Vanilla.
	"UNIT_HEALTH boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_TARGET boss1"
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

local timerDrainLife	= mod:NewCDTimer(24, 28542, nil, nil, nil, 3, nil, DBM_COMMON_L.CURSE_ICON) -- (Onyxia PTR: [2024-07-13]@[15:10:23] ||| Onyxia: [2024-07-29]@[20:01:58]) - "Life Drain-28542-npc:15989-1847 = pull:12.01/[Stage 1/0.00] 12.01, 23.99, Stage 2/8.99, ||| "Life Drain-28542-npc:15989-3730 = pull:11.99/[Stage 1/0.00] 11.99, 24.03, Stage 2/9.00, Stage 1/22.22, 12.98/35.20/44.20, 24.03, 24.00, Stage 2/6.00, Stage 1/22.87, 13.00/35.87/41.86, 24.03"
local timerAirPhase		= mod:NewTimer(67, "TimerAir", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)
local timerBlizzard		= mod:NewNextTimer(20, 28560, nil, nil, nil, 3) -- REVIEW!
local timerTailSweep	= mod:NewNextTimer(9, 55696, nil, nil, nil, 2) -- (Onyxia PTR: [2024-07-13]@[15:10:23]) - "Tail Sweep-55697-npc:15989-1847 = pull:9.01/[Stage 1/0.00] 9.01, 9.01, 8.99, 9.04, Stage 2/8.94,...

-- Stage Two (Air Phase)
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2))
local warnAirPhaseNow	= mod:NewAnnounce("WarningAirPhaseNow", 4, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnIceBlock		= mod:NewTargetAnnounce(28522, 2)

local specWarnDeepBreath= mod:NewSpecialWarningSpell(28524, nil, nil, nil, 1, 2)
local yellIceBlock		= mod:NewYell(28522)

local timerLanding		= mod:NewTimer(30, "TimerLanding", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6)
local timerIceBlast		= mod:NewCastTimer(7, 28524, nil, nil, nil, 2, DBM_COMMON_L.DEADLY_ICON)
local timerIcebolt		= mod:NewNextTimer(3, 28522, nil, nil, nil, 2)

mod:AddRangeFrameOption("12")

--local UnitAffectingCombat = UnitAffectingCombat
--local noTargetTime = 0
local warned_lowhp = false
mod.vb.isFlying = false
mod.vb.iceboltCount = 0
local iceboltSpellName = DBM:GetSpellInfo(28522)

--[[local function resetIsFlying(self)
	self.vb.isFlying = false
end]]

-- "<0.00 19:29:35> [DBM_Pull] Sapphiron-Vanilla#0#nil#99.647332005526#", -- [1]
-- "<0.00 19:29:35> [DBM_SetStage] Sapphiron-Vanilla#1#1#", -- [2]
-- "<44.99 19:30:20> [UNIT_TARGET] -boss1:Sapphiron- [CanAttack:1#Exists:1#IsVisible:1#ID:15989#GUID:0xF130003E75000A74#Classification:worldboss#Health:2310647] - Target: ??#TargetOfTarget: ??", -- [3]
-- "<75.76 19:30:51> [UNIT_TARGET] -boss1:Sapphiron- [CanAttack:1#Exists:1#IsVisible:1#ID:15989#GUID:0xF130003E75000A74#Classification:worldboss#Health:2244077] - Target: Name#TargetOfTarget: Sapphiron", -- [4]
-- "<142.67 19:31:57> [UNIT_TARGET] -boss1:Sapphiron- [CanAttack:1#Exists:1#IsVisible:1#ID:15989#GUID:0xF130003E75000A74#Classification:worldboss#Health:1940109] - Target: ??#TargetOfTarget: ??", -- [5]
-- "<173.89 19:32:29> [UNIT_TARGET] -boss1:Sapphiron- [CanAttack:1#Exists:1#IsVisible:1#ID:15989#GUID:0xF130003E75000A74#Classification:worldboss#Health:1672129] - Target: Name#TargetOfTarget: Sapphiron", -- [6]
-- "<193.60 19:32:48> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#boss1#nil#nil#nil#??#1#nil#normal#0#boss2#nil#nil#nil#??#1#nil#normal#0#boss3#nil#nil#nil#??#1#nil#normal#0#boss4#nil#nil#nil#??#1#nil#normal#0#boss5#nil#nil#nil#??#1#nil#normal#0#Real Args:#", -- [7]
-- "<193.61 19:32:48> [UNIT_TARGET] -target:Sapphiron- [CanAttack:1#Exists:1#IsVisible:1#ID:15989#GUID:0xF130003E75000A74#Classification:worldboss#Health:1] - Target: ??#TargetOfTarget: ??", -- [8]
-- "<193.61 19:32:48> [DBM_Kill] Sapphiron-Vanilla#", -- [9]

local function Flying(self)
	self:SetStage(2)
	self.vb.isFlying = true
	timerDrainLife:Cancel()
	timerAirPhase:Cancel()
	warnAirPhaseNow:Show()
	timerLanding:Start() -- this will be innacurate as it does not account for boss travel distance to center. Updated on Frost Breath timer
end

local function Landing(self)
	self:SetStage(1)
	self.vb.isFlying = false
	self.vb.iceboltCount = 0
	warnLanded:Show()
	warnDrainLifeSoon:Schedule(8)
	timerDrainLife:Start(13)
	warnAirPhaseSoon:Schedule(62)
	timerAirPhase:Start() -- 67s after first landing onwards
	self:Schedule(67, Flying, self)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
		self:Schedule(65, DBM.RangeCheck.Show, DBM.RangeCheck, 12)
	end
end

function mod:OnCombatStart(delay)
--	noTargetTime = 0
	warned_lowhp = false
	self:SetStage(1)
	self.vb.isFlying = false
	self.vb.iceboltCount = 0
	warnDrainLifeSoon:Schedule(6.5-delay)
	timerDrainLife:Start(12-delay)
	timerBlizzard:Start(15-delay) -- REVIEW!
	timerTailSweep:Start(-delay)
	warnAirPhaseSoon:Schedule(40-delay)
	timerAirPhase:Start(45-delay) -- 45s since Combat Start
	self:Schedule(45, Flying, self)
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		self:Schedule(43-delay, DBM.RangeCheck.Show, DBM.RangeCheck, 12)
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


function mod:SPELL_CAST_START(args)
	if args.spellId == 28524 then
		timerIceBlast:Start()
		timerLanding:Update(11, 30) -- 11s after Frost Breath cast start
		self:Schedule(11, Landing, self)
		specWarnDeepBreath:Show()
		specWarnDeepBreath:Play("findshelter")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(28542, 55665) then -- Life Drain
		warnDrainLifeNow:Show()
		warnDrainLifeSoon:Schedule(18.5)
		timerDrainLife:Start()
	elseif spellId == 28560 then
		DBM:AddMsg("Sapphiron Blizzard SPELL_CAST_SUCCESS implemented on Warmane Onyxia server script. Notify Zidras on Discord or GitHub")
		warnBlizzard:Show()
		timerBlizzard:Start()
	elseif spellId == 55696 then
		timerTailSweep:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteBreath or msg:find(L.EmoteBreath) then
		DBM:AddMsg("Sapphiron Breath emote implemented on Warmane Onyxia server script. Notify Zidras on Discord or GitHub")
--		self:SendSync("DeepBreath") -- this does not need syncing and spam comms
--		timerIceBlast:Start()
--		timerLanding:Update(13.5) -- 8s until breath + 3.5s until emote + ~2s until UNIT_TARGET
		specWarnDeepBreath:Show()
		specWarnDeepBreath:Play("findshelter")
	elseif msg == L.AirPhase or msg:find(L.AirPhase) then
		DBM:AddMsg("Sapphiron Air Phase emote implemented on Warmane Onyxia server script. Notify Zidras on Discord or GitHub")
		self:SetStage(2)
		self.vb.isFlying = true
		timerDrainLife:Cancel()
		timerAirPhase:Cancel()
		warnAirPhaseNow:Show()
		timerLanding:Start()
	elseif msg == L.LandingPhase or msg:find(L.LandingPhase) then
		DBM:AddMsg("Sapphiron Landing Phase emote implemented on Warmane Onyxia server script. Notify Zidras on Discord or GitHub")
		self:SetStage(1)
		self.vb.isFlying = false
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_lowhp and self:GetUnitCreatureId(uId) == 15989 and UnitHealth(uId) / UnitHealthMax(uId) < 0.1 then
		warned_lowhp = true
		specWarnLowHP:Show()
		timerAirPhase:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == iceboltSpellName then -- Icebolt
		self.vb.iceboltCount = self.vb.iceboltCount + 1
		if self.vb.iceboltCount < 5 then -- 5 Icebolts on each Flight phase
			timerIcebolt:Start()
		end
	end
end

function mod:UNIT_TARGET(uId)
	-- REVIEW! Check if this is accurate to rely on
	if UnitExists(uId.."target") then
		DBM:Debug("UNIT_TARGET event fired, flying status: " .. tostring(self.vb.isFlying or "nil"))
		if self.vb.isFlying then
			self:SendSync("SapphironLanded") -- Sync landing with raid since UNIT_TARGET:boss1 event requires boss to be target/focus, which not all members do
		end
	else
		DBM:Debug("UNIT_TARGET found no boss target, flying status: " .. tostring(self.vb.isFlying or "nil"))
		if not self.vb.isFlying then
			self:SendSync("SapphironFlying") -- Sync airphase with raid since UNIT_TARGET:boss1 event requires boss to be target/focus, which not all members do
		end
	end
end

function mod:OnSync(msg)
	--[[if msg == "DeepBreath" then
		timerIceBlast:Start()
		timerLanding:Update(14)
		self:Schedule(14.5, Landing, self)
		specWarnDeepBreath:Show()
		specWarnDeepBreath:Play("findshelter")]]
	if msg == "SapphironFlying" and self.vb.phase == 1 then
		Flying(self)
	elseif msg == "SapphironLanded" and self.vb.phase == 2 then
		Landing(self)
	end
end
