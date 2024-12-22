local mod	= DBM:NewMod("Bloodboil", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230108171130_cafe20241008v3")
mod:SetCreatureID(22948)
mod:SetModelID(21443)
mod:SetHotfixNoticeRev(20230108000000)
mod:SetMinSyncRevision(20230108000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 40508",
	"SPELL_CAST_SUCCESS 42005 40491 40486 40597 40508 40595", -- added 40486 40597 for eject, 40508 40595 for breath
	"SPELL_AURA_APPLIED 42005 40481 40491 40604 40594",
	"SPELL_AURA_APPLIED_DOSE 40481",
	"SPELL_AURA_REFRESH 40481",
	"SPELL_AURA_REMOVED 40604 40594"
)

-- General
local berserkTimer		= mod:NewBerserkTimer(600)

-- Stage One: Boiling Blood
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1)..": "..DBM:GetSpellInfo(38027))
local warnBlood			= mod:NewTargetAnnounce(42005, 3)
local warnWound			= mod:NewStackAnnounce(40481, 2, nil, "Tank", 2)
local warnStrike		= mod:NewTargetNoFilterAnnounce(40491, 3, nil, "Tank", 2)

local specWarnBlood		= mod:NewSpecialWarningStack(42005, nil, 1, nil, nil, 1, 2)

local timerBloodCD		= mod:NewCDCountTimer(10, 42005, nil, nil, nil, 5, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerStrikeCD		= mod:NewCDCountTimer(20+10, 40491, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON) --adjusted to 30s as in script
local timerEject		= mod:NewCDTimer(20, 40486, nil, nil, nil, 2) --new eject timer
local timerBreath		= mod:NewCDTimer(30, 40508, nil, nil, nil, 2) --new breath timer

-- Stage Two: Fel Rage
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2)..": "..DBM:GetSpellInfo(40594))
local warnRage			= mod:NewTargetAnnounce(40604, 4)
local warnRageSoon		= mod:NewSoonAnnounce(40604, 3)
local warnRageEnd		= mod:NewEndAnnounce(40604, 4)
local warnBreath		= mod:NewSpellAnnounce(40508, 2)

local specWarnRage		= mod:NewSpecialWarningYou(40604, nil, nil, nil, 1, 2)
local yellRage			= mod:NewYell(40604)

local timerRageCD		= mod:NewCDTimer(90, 40604, nil, nil, nil, 3, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerRageEnd		= mod:NewBuffActiveTimer(30, 40604, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
mod:AddInfoFrameOption(42005)

mod.vb.bloodCount = 0
mod.vb.strikeCount = 0

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.bloodCount = 0
	self.vb.strikeCount = 0
	berserkTimer:Start(-delay)
	warnRageSoon:Schedule(54.6-4.6-delay) --adjusted to 10s before change phase
	timerBloodCD:Start(9.5+0.5-delay, 1) --adjust to 10s as in script
	timerStrikeCD:Start(9.4+18.6-delay, 1) --adjust to 28s as in script
	timerRageCD:Start(59.6+0.4-delay) --adjusted to 60s as in script
	timerEject:Start(14-delay) --new eject timer
	timerBreath:Start(38-delay) --new breath timer
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(42005))
		DBM.InfoFrame:Show(30, "playerdebuffstacks", 42005, 1)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 40508 then
		warnBreath:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 42005 then
		self.vb.bloodCount = self.vb.bloodCount + 1
		if self.vb.bloodCount == 5 then
			timerBloodCD:Start(40, 1)
		else
			timerBloodCD:Start(self.vb.bloodCount+1)
		end
	elseif spellId == 40491 then
		self.vb.strikeCount = self.vb.strikeCount + 1
		if self.vb.strikeCount == 3 then
			self.vb.strikeCount = 0
			timerStrikeCD:Start(50, 1)
		else
			timerStrikeCD:Start(nil, self.vb.strikeCount+1)
		end
	elseif spellId == 40486 or 40597 then
		timerEject:Start() --new eject timer
	elseif spellId == 40508 or 40595 then
		timerBreath:Start() --new breath timer
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 42005 then
		warnBlood:CombinedShow(0.8, args.destName)
		if args:IsPlayer() then
			specWarnBlood:Show(args.amount)
			specWarnBlood:Play("targetyou")
		end
	elseif spellId == 40481 then
		local amount = args.amount or 1
		if (amount % 5 == 0) then
			warnWound:Show(args.destName, amount)
		end
	elseif spellId == 40491 then
		warnStrike:Show(args.destName)
	elseif spellId == 40594 then -- Fel Rage (boss)
		timerRageEnd:Start(28+2, args.destName) --adjusted to 30s
		warnRageSoon:Schedule(85)
		timerRageCD:Start()
		timerStrikeCD:AddTime(30) --added delay timer for phase 2
	elseif spellId == 40604 then -- Fel Rage (player)
		self:SetStage(2)
--		timerBloodCD:Stop()
--		timerRageEnd:Start(args.destName) --removed as it seem redundant? track buff on boss only
		if args:IsPlayer() then
			specWarnRage:Show()
			specWarnRage:Play("targetyou")
			yellRage:Yell()
		else
			warnRage:Show(args.destName)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 40604 then--Ending on player
--		timerRageEnd:Stop(args.destName)
	elseif spellId == 40594 then--Ending on Boss
		self.vb.bloodCount = 0
		self:SetStage(1)
		warnRageEnd:Show()
--		timerBloodCD:Start(12.5)
--		warnRageSoon:Schedule(47)
--		timerRageCD:Start()
	end
end
