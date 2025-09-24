local mod	= DBM:NewMod("Illidan", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230311092740")
mod:SetCreatureID(22917)

mod:SetModelID(21135)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 40904 41117 39849 41032",
	"SPELL_CAST_SUCCESS 41126",
	"SPELL_AURA_APPLIED 41917 41914 40585 40932 41083 40683 40695 41032 39869",
	"SPELL_AURA_REMOVED 41917 41914",
--	"SPELL_SUMMON 40018",
	"UNIT_DIED"
)

--TODO, phase 4 log where I don't overkill boss too fast.

-- General
local timerCombatStart		= mod:NewCombatTimer(36)
local berserkTimer			= mod:NewBerserkTimer(1500)

-- Stage One: You Are Not Prepared
mod:AddTimerLine(L.S1YouAreNotPrepared)
local warnShearSoon			= mod:NewSoonAnnounce(41032, 2, nil, "Tank")
local warnDrawSoul			= mod:NewSpellAnnounce(40904, 3, nil, "Tank", 2)--Needed?
local warnParasite			= mod:NewTargetAnnounce(41917, 3)
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 3)

local specWarnShearBlock	= mod:NewSpecialWarningDefensive(41032, "Tank", nil, nil, 1, 2)
local specWarnShearTaunt	= mod:NewSpecialWarningTaunt(41032, "Tank", nil, nil, 1, 2)
local specWarnGTFO			= mod:NewSpecialWarningGTFO(40832, nil, nil, nil, 1, 2) -- Phase 1: Flame Crash // Phase 2: Blaze
local specWarnParasite		= mod:NewSpecialWarningYou(41917, nil, nil, nil, 1, 2)
local yellParasiteFades		= mod:NewShortFadesYell(41917)

local timerShearCD			= mod:NewCDTimer(10, 41032, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON) -- (Timewalking Frostmourne [2023-02-18]@[22:07:38]) - "Shear-41032-npc:22917-337 = pull:10.0/Stage 1/10.0, 10.1, 11.3, 10.6, 10.1, 10.6, 10.8, 10.5, 11.9, 11.9, 10.5, 10.0, 10.5, Stage 2/13.0, Stage 3/76.5, 27.6/104.1/117.1, 10.0, 11.3, 10.1, 10.7, 88.9, 11.8, 11.3, 10.6, 10.0, Stage 4/81.4, 39.1/120.5, 10.1, 11.7, 10.2, 102.9"
local timerDrawSoul			= mod:NewCDTimer(35, 40904, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON) -- (Timewalking Frostmourne [2023-02-18]@[22:07:38]) - "Draw Soul-40904-npc:22917-337 = pull:35.0/Stage 1/35.0, 35.0, 35.0, 35.6, Stage 2/11.4, Stage 3/76.5, 52.6/129.1/140.5, 131.0, Stage 4/100.1, 64.1/164.2", -- [3]
local timerFlameCrash		= mod:NewNextTimer(30, 40832, nil, nil ,nil, 3) -- (Timewalking Frostmourne [2023-02-18]@[22:07:38]) - "Flame Crash-40832-npc:22917-337 = pull:30.0/Stage 1/30.0, 30.0, 30.0, 30.0, Stage 2/31.9, Stage 3/76.5, 47.5/124.0/156.0, 131.0, Stage 4/105.1, 59.1/164.2"
local timerParasite			= mod:NewTargetTimer(10, 41917, nil, false, nil, 1, nil, DBM_COMMON_L.IMPORTANT_ICON)

mod:AddSetIconOption("ParasiteIcon", 41917)

-- Stage Two: Flames of Azzinoth
mod:AddTimerLine(L.S2FlamesOfAzzinoth)
--Illidan Stormrage
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnBarrage			= mod:NewTargetAnnounce(40585, 3)
local warnEyebeam			= mod:NewSpellAnnounce(40018, 3)

local specWarnBarrage		= mod:NewSpecialWarningMoveAway(40585, nil, nil, nil, 1, 2)
local specWarnUncagedWrath	= mod:NewSpecialWarningDefensive(39869, nil, nil, nil, 3, 2)

local timerBarrage			= mod:NewTargetTimer(10, 40585, nil, false, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerNextBarrage		= mod:NewCDTimer(44, 40585, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON) -- REVIEW! broken?? Fired on P3...
local timerEyebeam			= mod:NewCDTimer(30, 40018, nil, nil, nil, 2) -- (Timewalking Frostmourne [2023-02-18]@[22:07:38]) - "?-Stare into the eyes of the Betrayer!-npc:Illidan Stormrage = pull:182.7/Stage 2/31.2, 30.3, Stage 3/15.0, Stage 4/283.7", -- [16]
-- Flame of Azzinoth
--local specWarnGTFO			= mod:NewSpecialWarningGTFO(40611, nil, nil, nil, 1, 2) -- Phase 2: Blaze

-- Stage Three: The Demon Within
mod:AddTimerLine(L.S3TheDemonWithin)
local warnPhase3			= mod:NewPhaseAnnounce(3)
local warnFlame				= mod:NewTargetAnnounce(40932, 3)
local warnPhase4Soon		= mod:NewPrePhaseAnnounce(4, 3)

--local timerFlame			= mod:NewTargetTimer(60, 40932)

-- [Stage Three: The Demon Within] Demon Form
mod:AddTimerLine(DBM:GetSpellInfo(40506))
local warnDemon				= mod:NewSpellAnnounce(40506, 3)
local warnFlameBurst		= mod:NewSpellAnnounce(41131, 3)
local warnShadowDemon		= mod:NewTargetNoFilterAnnounce(41117, 3)
local warnHuman				= mod:NewAnnounce("WarnHuman", 3, 62844, nil, nil, nil, 40506)

local specWarnShadowDemon	= mod:NewSpecialWarningSwitch(41117, "Dps", nil, nil, 3, 2)
local timerNextFlameBurst	= mod:NewCDTimer(20, 41131, nil, nil, nil, 3)

local timerNextDemon		= mod:NewCDTimer(60, 40506, nil, nil, nil, 6, nil, DBM_COMMON_L.IMPORTANT_ICON) -- REVIEW! phase 3 and 5 variance? (Timewalking Frostmourne [2023-02-18]@[21:51:02] || Timewalking Frostmourne [2023-02-18]@[22:07:38]) - ?-Behold the power... of the demon within!-npc:Illidan Stormrage = pull:296.2/Stage 3/77.8, 131.0, Stage 4/90.6, 89.1/179.7, 114.8 || pull:305.6/Stage 3/77.6, 131.0, Stage 4/75.1, 93.0/168.1"
local timerShadowDemon		= mod:NewCDTimer(34, 41117, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerNextHuman		= mod:NewTimer(60, "TimerNextHuman", 62844, nil, nil, 6, nil, nil, nil, nil, nil, nil, nil, 40506)

-- Stage Four: The Long Hunt
mod:AddTimerLine(L.S4TheLongHunt)
local warnPhase4			= mod:NewPhaseAnnounce(4)
local warnEnrage			= mod:NewSpellAnnounce(40683, 3) -- Frenzy

local timerPhase4			= mod:NewPhaseTimer(30)
local timerEnrage			= mod:NewBuffActiveTimer(10, 40683)
--local timerNextEnrage		= mod:NewCDTimer(40, 40683)

-- Maiev Shadowsong
local warnCaged				= mod:NewSpellAnnounce(40695, 3)

local timerCaged			= mod:NewBuffActiveTimer(15, 40695, nil, nil, nil, 6)

mod:AddRangeFrameOption("6/8")-- 40932: Spell is 5 yards, but give it 6 or good measure since 5 yard check is probably least precise one since nerfs. / 41917: Parasitic. REVIEW! arbitrary range

mod.vb.flamesDown = 0
mod.vb.flameBursts = 0
mod.vb.warned_preP2 = false
mod.vb.warned_preP4 = false
mod.vb.demonForm = false

local parasiticDebuffName = DBM:GetSpellInfo(41917)

local parasiticDebuffFilter
do
	parasiticDebuffFilter = function(uId)
		return DBM:UnitDebuff(uId, parasiticDebuffName)
	end
end

local function humanForms(self) -- corrected on the fly using UNIT_AURA, and checking debuff 40506 to OnSync
	self:Unschedule(humanForms)
	self.vb.demonForm = false
	warnHuman:Show()
	timerNextFlameBurst:Cancel()
	timerNextDemon:Start()
	timerShearCD:Start()
	timerFlameCrash:Start()
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
	self.vb.demonForm = false
	timerShearCD:Start()
	timerFlameCrash:Start()
	berserkTimer:Start(-delay)
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"SPELL_DAMAGE 40841 40832 40611",
			"SPELL_MISSED 40841 40832 40611",
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

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 40904 then
		warnDrawSoul:Show()
		timerDrawSoul:Start()
	elseif spellId == 41117 then
		specWarnShadowDemon:Show()
		specWarnShadowDemon:Play("killmob")
	elseif spellId == 39849 then--Throw Glaive
		self:SetStage(2)
		self.vb.flamesDown = 0
		self.vb.warned_preP2 = true
		timerShearCD:Cancel()
		timerFlameCrash:Cancel()
		warnPhase2:Show()
		timerNextBarrage:Start(85)
		timerEyebeam:Start()
	elseif spellId == 41032 then -- Shear
		warnShearSoon:Schedule(7) -- 3s (+1.5s from cast time) is good enough to plan ahead
		timerShearCD:Start()
		specWarnShearBlock:Show()
		specWarnShearBlock:Play("defensive")
	elseif spellId == 40832 then -- Flame Crash
		timerFlameCrash:Start()
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
		if self.Options.RangeFrame then
			if DBM:UnitDebuff("player", args.spellName) then -- You have debuff, show everyone
				DBM.RangeCheck:Show(8, nil)
			else -- You do not have debuff, only show players who do
				DBM.RangeCheck:Show(8, parasiticDebuffFilter)
			end
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
	elseif spellId == 41032 then -- Shear
		if not args:IsPlayer() then
			specWarnShearTaunt:Show(args.destName)
			specWarnShearTaunt:Play("tauntboss")
		end
	elseif spellId == 39869 then -- Uncaged Wrath
		specWarnUncagedWrath:Show()
		specWarnUncagedWrath:Play("defensive")
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

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if (spellId == 40841 or spellId == 40832 or spellId == 40611) and destGUID == UnitGUID("player") and self:AntiSpam(4, 5) then -- Flame Crash / Blaze (Flame of Azzinoth)
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
			timerEyebeam:Cancel()
			warnPhase3:Show()
			timerNextDemon:Start(77.6) -- (Timewalking Frostmourne [2023-02-18]@[22:07:38]) - 77.6
			timerShearCD:Start(27.6)
			timerFlameCrash:Start(47.5)
			self:RegisterShortTermEvents(
				"UNIT_AURA focus target mouseover"
			)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Pull or msg:find(L.Pull) then
		timerCombatStart:Start()
	elseif msg == L.Eyebeam or msg:find(L.Eyebeam) then
		warnEyebeam:Show()
		timerEyebeam:Start()
	elseif msg == L.Demon or msg:find(L.Demon) then
		self.vb.flameBursts = 0
		self.vb.demonForm = true
		timerNextDemon:Cancel()
		warnDemon:Show()
		timerNextHuman:Start()
		timerNextFlameBurst:Start()
		timerShadowDemon:Start()
--		self:Schedule(74, humanForms, self)
	elseif (msg == L.Phase4 or msg:find(L.Phase4)) and self.vb.phase < 4 then
		self:SetStage(4)
		self.vb.warned_preP4 = true
--		self:Unschedule(humanForms)
		timerParasite:Cancel()
		--timerFlame:Cancel()
		timerNextFlameBurst:Cancel()
		timerShadowDemon:Cancel()
		timerNextHuman:Cancel()
		timerNextDemon:Cancel()
		timerPhase4:Start()
		warnPhase4:Schedule(30)
		timerNextDemon:Start(89.1) -- REVIEW! 5s variance? (Timewalking Frostmourne [2023-02-18]@[21:51:02] || Timewalking Frostmourne [2023-02-18]@[22:07:38]) - 89.1 || 93.0

	end
end

function mod:UNIT_AURA(uId)
	if not self.vb.demonForm then return end -- Demon phase
	if DBM:GetUnitCreatureId(uId) ~= 22917 then return end -- Illidan

	local demonForm = DBM:UnitBuff(uId, 40506)
	if self.vb.demonForm and not demonForm then -- Illidan was in Demon Form but just lost buff and morphed into Human Form
--		self.vb.demonForm = false -- redundancy. untested if it is actually needed, but theoretically I want to prevent UNIT_AURA from rerunning during OnSync runtime
		DBM:Debug("<personal> Illidan switched to Human Form!")
		self:SendSync("humanForm")
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

function mod:OnSync(msg)
	if msg == "humanForm" and self.vb.demonForm then
		DBM:Debug("<sync> Illidan switched to Human Form!")
		humanForms(self)
	end
end
