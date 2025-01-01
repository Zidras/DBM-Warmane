local mod	= DBM:NewMod("Supremus", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250101120130")
mod:SetCreatureID(22898)
mod:SetModelID(21145)
mod:SetUsedIcons(8)
mod:SetHotfixNoticeRev(20230108000000)
mod:SetMinSyncRevision(20230108000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 41581",
	"SPELL_CAST_SUCCESS 40126",
	"SPELL_AURA_APPLIED 41951",
	"CHAT_MSG_RAID_BOSS_EMOTE",
    "UNIT_SPELLCAST_SUCCEEDED"
)

--TODO, see if CLEU method is reliable enough to scrap scan method. scan method may still have been faster.

-- General
local warnPhase			= mod:NewAnnounce("WarnPhase", 4, 42052)

local timerPhase		= mod:NewTimer(60, "TimerPhase", 42052, nil, nil, 6)
local timerNextPhase	= mod:NewTimer(60, "TimerPhase", 2565, nil, nil, 6)
local berserkTimer		= mod:NewBerserkTimer(600)

local timerFixate		= mod:NewTimer(10, "Fixate", nil, nil, nil, 1) --added timer for fixate

-- Stage One: Supremus
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1)..": "..L.name)
local specWarnMolten		= mod:NewSpecialWarningMove(40265, nil, nil, nil, 1, 2)
local timerMoltenPunch		= mod:NewCDTimer(15, 40126, nil, nil, nil, 1) --AC 15s-20s; first is always 20
s
-- Stage Two: Pursuit
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2)..": "..DBM:GetSpellInfo(68987))
local warnFixate		= mod:NewTargetNoFilterAnnounce(41295, 3)

local specWarnVolcano		= mod:NewSpecialWarningMove(42052, nil, nil, nil, 1, 2)
local specWarnFixate		= mod:NewSpecialWarningRun(41295, nil, nil, nil, 4, 2)

mod:AddBoolOption("KiteIcon", true)

--mod.vb.phase2 = false
mod.vb.lastTarget = "None"

local function ScanTarget(self)
	local target, uId = self:GetBossTarget(22898)
	if target then
		if self.vb.lastTarget ~= target then
			self.vb.lastTarget = target
			if UnitIsUnit(uId, "player") and not self:IsTrivial() then
				specWarnFixate:Show()
				specWarnFixate:Play("justrun")
				specWarnFixate:ScheduleVoice(1, "keepmove")
			else
				warnFixate:Show(target)
			end
			if self.Options.KiteIcon then
				self:SetIcon(target, 8)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName)
    DBM:Debug("UNIT_SPELLCAST_SUCCEEDED fired. Unit: " .. tostring(unit) .. ", Spell: " .. tostring(spellName))
    
    if unit == "target" or unit == "targettarget" and spellName == GetSpellInfo(40126) then
        DBM:Debug("Molten Punch detected from target unit")
        timerMoltenPunch:Start()
    end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	berserkTimer:Start(-delay)
	timerPhase:Start(-delay, L.Kite)
	timerNextPhase:Schedule(60-delay, L.Tank)
	timerMoltenPunch:Start(20-delay)
	self.vb.lastTarget = "None"
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"SPELL_DAMAGE 40265 42052",
			"SPELL_MISSED 40265 42052"
		)
	end

end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.vb.lastTarget ~= "None" then
		self:SetIcon(self.vb.lastTarget, 0)
	end
	self:Unschedule(Moltenflame)
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if spellId == 40265 and destGUID == UnitGUID("player") and self:AntiSpam(4, 1) and not self:IsTrivial() then
		specWarnMolten:Show()
		specWarnMolten:Play("runaway")
	elseif spellId == 42052 and destGUID == UnitGUID("player") and self:AntiSpam(4, 2) and not self:IsTrivial() then
		specWarnVolcano:Show()
		specWarnVolcano:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg) --fixed to be emote instead of whisper
	if msg == L.PhaseKite or msg:find(L.PhaseKite) then
		self:SetStage(2)
--		warnPhase:Show(L.Kite)
--		timerPhase:Start(L.Tank)
		self:Unschedule(ScanTarget)
		self:Schedule(4, ScanTarget, self)
		if self.vb.lastTarget ~= "None" then
			self:SetIcon(self.vb.lastTarget, 0)
		end
		if self:IsMelee() and not self:IsTrivial() then
			specWarnFixate:Show()
			specWarnFixate:Play("justrun")
		end
	elseif msg == L.PhaseTank or msg:find(L.PhaseTank) then
		self:SetStage(1)
		warnPhase:Show(L.Tank)
		timerPhase:Start(L.Kite)
		timerNextPhase:Schedule(60, L.Tank)
		self:Unschedule(ScanTarget)
		if self.vb.lastTarget ~= "None" then
			self:SetIcon(self.vb.lastTarget, 0)
		end
	elseif msg == L.ChangeTarget or msg:find(L.ChangeTarget) then
		timerFixate:Start()
		self:Unschedule(ScanTarget)
		self:Schedule(0.5, ScanTarget, self)
	end
end
