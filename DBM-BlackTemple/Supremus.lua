local mod	= DBM:NewMod("Supremus", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(22898)

mod:SetModelID(21145)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 41951",
	"RAID_BOSS_EMOTE"
)

--TODO, see if CLEU method is reliable enough to scrap scan method. scan method may still have been faster.
local warnPhase			= mod:NewAnnounce("WarnPhase", 4, 42052)
local warnFixate		= mod:NewTargetNoFilterAnnounce(41951, 3)

local specWarnMolten	= mod:NewSpecialWarningMove(40265, nil, nil, nil, 1, 2)
local specWarnVolcano	= mod:NewSpecialWarningMove(42052, nil, nil, nil, 1, 2)
local specWarnFixate	= mod:NewSpecialWarningRun(41951, nil, nil, nil, 4, 2)

local timerPhase		= mod:NewTimer(60, "TimerPhase", 42052, nil, nil, 6)

local berserkTimer		= mod:NewBerserkTimer(900)

mod:AddBoolOption("KiteIcon", true)

--mod.vb.phase2 = false
mod.vb.lastTarget = "None"

--[[
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
--]]

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerPhase:Start(-delay, L.Kite)
	self.vb.lastTarget = "None"
	if not self:IsTrivial() then--Only warning that uses these events is remorseless winter and that warning is completely useless spam for level 90s.
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
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 41951 then
		if self.vb.lastTarget ~= args.destName then
			self.vb.lastTarget = args.destName
			if args:IsPlayer() and not self:IsTrivial() then
				specWarnFixate:Show()
				specWarnFixate:Play("justrun")
				specWarnFixate:ScheduleVoice(1, "keepmove")
			else
				warnFixate:Show(args.destName)
			end
			if self.Options.KiteIcon then
				self:SetIcon(args.destName, 8)
			end
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 40265 and destGUID == UnitGUID("player") and self:AntiSpam(4, 1) and not self:IsTrivial() then
		specWarnMolten:Show()
		specWarnMolten:Play("runaway")
	elseif spellId == 42052 and destGUID == UnitGUID("player") and self:AntiSpam(4, 2) and not self:IsTrivial() then
		specWarnVolcano:Show()
		specWarnVolcano:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.PhaseKite or msg:find(L.PhaseKite) then
		warnPhase:Show(L.Kite)
		timerPhase:Start(L.Tank)
		--self:Unschedule(ScanTarget)
		--self:Schedule(4, ScanTarget, self)
		if self.vb.lastTarget ~= "None" then
			self:SetIcon(self.vb.lastTarget, 0)
		end
		if self:IsMelee() and not self:IsTrivial() then
			--Melee Dps Not technically fixated but melee should run out at start of kite phase in case chosen.
			--Tank should run out because boss actually fixates tank for couple seconds before choosing new target.
			specWarnFixate:Show()
			specWarnFixate:Play("justrun")
		end
	elseif msg == L.PhaseTank or msg:find(L.PhaseTank) then
		warnPhase:Show(L.Tank)
		timerPhase:Start(L.Kite)
		--self:Unschedule(ScanTarget)
		if self.vb.lastTarget ~= "None" then
			self:SetIcon(self.vb.lastTarget, 0)
		end
	--elseif msg == L.ChangeTarget or msg:find(L.ChangeTarget) then
		--self:Unschedule(ScanTarget)
		--self:Schedule(0.5, ScanTarget, self)
	end
end
