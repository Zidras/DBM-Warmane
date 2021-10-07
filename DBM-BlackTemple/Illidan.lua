local mod	= DBM:NewMod("Illidan", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(22917)

mod:SetModelID(21135)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 41917 41914 40585 40932 41083 40683 40695",
	"SPELL_AURA_REMOVED 41917 41914",
	"SPELL_CAST_START 40904 41117 39849",
	"SPELL_CAST_SUCCESS 41126 40647",
	"UNIT_DIED"
)

--Parasites in phase 1? if so range frame needs to be more phases
--TODO, flame crash timer 26?
--TODO, phase 4 log where I don't overkill boss too fast.
--TODO, add shear warning (defensive) to prevent application all together, taunt swap if it does get applied
--TODO, fire for elementals added to GTFO
local warnParasite			= mod:NewTargetAnnounce(41917, 3)
local warnDrawSoul			= mod:NewSpellAnnounce(40904, 3, nil, "Tank", 2)--Needed?
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 3)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnEyebeam			= mod:NewSpellAnnounce(40018, 3)
local warnBarrage			= mod:NewTargetAnnounce(40585, 3)
local warnPhase3			= mod:NewPhaseAnnounce(3)
local warnDemon				= mod:NewAnnounce("WarnDemon", 3 , 40506)
local warnHuman				= mod:NewAnnounce("WarnHuman", 3 , 97061)
local warnFlame				= mod:NewTargetAnnounce(40932, 3)
local warnFlameBurst		= mod:NewSpellAnnounce(41131, 3)
local warnShadowDemon		= mod:NewTargetNoFilterAnnounce(41117, 3)
local warnPhase4Soon		= mod:NewPrePhaseAnnounce(4, 3)
local warnPhase4			= mod:NewPhaseAnnounce(4)
local warnEnrage			= mod:NewSpellAnnounce(40683, 3)
local warnCaged				= mod:NewSpellAnnounce(40695, 3)

local specWarnParasite		= mod:NewSpecialWarningYou(41917, nil, nil, nil, 1, 2)
local yellParasiteFades		= mod:NewShortFadesYell(41917)
local specWarnBarrage		= mod:NewSpecialWarningMoveAway(40585, nil, nil, nil, 1, 2)
local specWarnShadowDemon	= mod:NewSpecialWarningSwitch(41117, "Dps", nil, nil, 3, 2)
local specWarnGTFO			= mod:NewSpecialWarningGTFO(40841, nil, nil, nil, 1, 2)

local timerParasite			= mod:NewTargetTimer(10, 41917, nil, false, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerBarrage			= mod:NewTargetTimer(10, 40585, nil, false, nil, 3)
local timerNextBarrage		= mod:NewCDTimer(44, 40585, nil, nil, nil, 3)
--local timerFlame			= mod:NewTargetTimer(60, 40932)
local timerNextFlameBurst	= mod:NewCDTimer(20, 41131, nil, nil, nil, 3)
local timerShadowDemon		= mod:NewCDTimer(34, 41117, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerNextHuman		= mod:NewTimer(74, "TimerNextHuman", 97061, nil, nil, 6)
local timerNextDemon		= mod:NewTimer(60, "TimerNextDemon", 40506, nil, nil, 6)
local timerEnrage			= mod:NewBuffActiveTimer(10, 40683)
local timerNextEnrage		= mod:NewCDTimer(40, 40683)
local timerCaged			= mod:NewBuffActiveTimer(15, 40695, nil, nil, nil, 6)
local timerPhase4			= mod:NewPhaseTimer(30)

local timerCombatStart		= mod:NewCombatTimer(36)
local berserkTimer			= mod:NewBerserkTimer(1500)

mod:AddRangeFrameOption(6, 40932)--Spell is 5 yards, but give it 6 or good measure since 5 yard check is probably least precise one since nerfs.
mod:AddSetIconOption("ParasiteIcon", 41917)

mod.vb.flamesDown = 0
mod.vb.flameBursts = 0
mod.vb.warned_preP2 = false
mod.vb.warned_preP4 = false

local function humanForms(self)
	warnHuman:Show()
	timerNextFlameBurst:Cancel()
	timerNextDemon:Start()
	if self.vb.phase == 4 then
		timerEnrage:Start()
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.flamesDown = 0
	self.vb.flameBursts = 0
	self.vb.warned_preP2 = false
	self.vb.warned_preP4 = false
	berserkTimer:Start(-delay)
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"SPELL_DAMAGE 40841",
			"SPELL_MISSED 40841",
			"UNIT_HEALTH"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 41917 or spellId == 41914 then
		timerParasite:Start(args.destName)
		if args:IsPlayer() then
			specWarnParasite:Show()
			specWarnParasite:Play("targetyou")
			yellParasiteFades:Countdown(spellId)
		else
			warnParasite:Show(args.destName)
		end
		if self.Options.ParasiteIcon then
			self:SetIcon(args.destName, 8)
		end
	elseif spellId == 40585 then
		timerBarrage:Start(args.destName)
		timerNextBarrage:Start()
		if args:IsPlayer() then
			specWarnBarrage:Show()
			specWarnBarrage:Play("runout")
			specWarnBarrage:ScheduleVoice(1, "keepmove")
		else
			warnBarrage:Show(args.destName)
		end
	elseif spellId == 40932 then
		warnFlame:CombinedShow(0.3, args.destName)
		--timerFlame:Start(args.destName)
	elseif spellId == 41083 then
		warnShadowDemon:CombinedShow(1, args.destName)
	elseif spellId == 40683 then
		warnEnrage:Show()
		timerEnrage:Start()
	elseif spellId == 40695 then
		warnCaged:Show()
		timerCaged:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 41917 or spellId == 41914 then
		timerParasite:Stop(args.destName)
		if args:IsPlayer() then
			yellParasiteFades:Cancel()
		end
		if self.Options.ParasiteIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 40904 then
		warnDrawSoul:Show()
	elseif spellId == 41117 then
		specWarnShadowDemon:Show()
		specWarnShadowDemon:Play("killmob")
	elseif spellId == 39849 then--Throw Glaive
		self:SetStage(2)
		self.vb.flamesDown = 0
		self.vb.warned_preP2 = true
		warnPhase2:Show()
		timerNextBarrage:Start(85)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 41126 then
		warnFlameBurst:Show()
		self.vb.flameBursts = self.vb.flameBursts + 1
		if self.vb.flameBursts < 3 then
			timerNextFlameBurst:Start()
		end
	elseif spellId == 40647 and self.vb.phase < 4 then
		self:SetStage(4)
		self.vb.warned_preP4 = true
		self:Unschedule(humanForms)
		timerParasite:Cancel()
		--timerFlame:Cancel()
		timerNextFlameBurst:Cancel()
		timerShadowDemon:Cancel()
		timerNextHuman:Cancel()
		timerNextDemon:Cancel()
		timerPhase4:Start()
		warnPhase4:Schedule(30)
		timerNextDemon:Start(92)--Verify timer with this trigger, I keep overkilling boss :\
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if spellId == 40841 and destGUID == UnitGUID("player") and self:AntiSpam(4, 5) then--Flame Crash
		specWarnGTFO:Show()
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 22997 then
		self.vb.flamesDown = self.vb.flamesDown + 1
		if self.vb.flamesDown >= 2 then
			self:SetStage(3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(6)
			end
			timerNextBarrage:Cancel()
			warnPhase3:Show()
			timerNextDemon:Start(76)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Pull or msg:find(L.Pull) then
		timerCombatStart:Start()
	elseif msg == L.Eyebeam or msg:find(L.Eyebeam) then
		warnEyebeam:Show()
	elseif msg == L.Demon or msg:find(L.Demon) then
		self.vb.flameBursts = 0
		warnDemon:Show()
		timerNextHuman:Start()
		timerNextFlameBurst:Start()
		timerShadowDemon:Start()
		self:Schedule(74, humanForms, self)
	elseif (msg == L.Phase4 or msg:find(L.Phase4)) and self.vb.phase < 4 then
		self:SetStage(4)
		self.vb.warned_preP4 = true
		self:Unschedule(humanForms)
		timerParasite:Cancel()
		--timerFlame:Cancel()
		timerNextFlameBurst:Cancel()
		timerShadowDemon:Cancel()
		timerNextHuman:Cancel()
		timerNextDemon:Cancel()
		timerPhase4:Start()
		warnPhase4:Schedule(30)
		timerNextDemon:Start(92)--Verify timer with this trigger, I keep overkilling boss :\
	end
end

function mod:UNIT_HEALTH(uId)
	local cid = self:GetUnitCreatureId(uId)
	if not self.vb.warned_preP2 and cid == 22917 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.75 then
		self.vb.warned_preP2 = true
		warnPhase2Soon:Show()
	elseif not self.vb.warned_preP4 and cid == 22917 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.35 then
		self.vb.warned_preP4 = true
		warnPhase4Soon:Show()
	end
end
