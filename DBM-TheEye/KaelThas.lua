local mod	= DBM:NewMod("KaelThas", "DBM-TheEye")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(19622)

mod:SetZone()

mod:RegisterCombat("yell", L.YellPull1, L.YellPull2)
mod:SetUsedIcons(1, 6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_MISSED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED target"
)

local warnGaze			= mod:NewAnnounce("WarnGaze", 4, 39414)
local warnFear			= mod:NewCastAnnounce(44863, 3)
local warnConflag		= mod:NewTargetAnnounce(37018, 4)
local warnToy			= mod:NewTargetAnnounce(37027, 2)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnMobDead		= mod:NewAnnounce("WarnMobDead", 3, nil, false)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnPhase4		= mod:NewPhaseAnnounce(4)
local warnDisruption	= mod:NewSpellAnnounce(36834, 3)
local warnMC			= mod:NewTargetAnnounce(36797, 4)
local warnPhoenix		= mod:NewSpellAnnounce(36723, 2)
local warnFlamestrike	= mod:NewSpellAnnounce(36735, 4)
local warnEgg			= mod:NewAnnounce("WarnEgg", 4, 36723)
local warnPyro			= mod:NewCastAnnounce(36819, 4)
local warnPhase5		= mod:NewPhaseAnnounce(5)
local warnGravity		= mod:NewSpellAnnounce(35966, 4)

local specWarnGaze		= mod:NewSpecialWarning("SpecWarnGaze")
local specWarnToy		= mod:NewSpecialWarningYou(37027, mod:IsTank())
local specWarnEgg		= mod:NewSpecialWarning("SpecWarnEgg")
local specWarnShield	= mod:NewSpecialWarningSpell(36815)
local specWarnPyro		= mod:NewSpecialWarningInterrupt(36819)
local specWarnVapor		= mod:NewSpecialWarningStack(35859, nil, 2)

local timerPhase		= mod:NewTimer(105, "TimerPhase", 28131)
local timerPhase1mob	= mod:NewTimer(30, "TimerPhase1mob", 28131)
local timerNextGaze		= mod:NewTimer(8.5, "TimerNextGaze", 39414)
local timerFearCD		= mod:NewCDTimer(31, 39427)
local timerToy			= mod:NewTargetTimer(60, 37027)
local timerPhoenixCD	= mod:NewCDTimer(45, 36723)
local timerRebirth		= mod:NewTimer(15, "TimerRebirth", 36723)
local timerShieldCD		= mod:NewCDTimer(60, 36815)
local timerGravityCD	= mod:NewNextTimer(92, 35941)
local timerGravity		= mod:NewBuffActiveTimer(32, 35941)
local timerMCCD			= mod:NewCDTimer(60, 36797)
mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("MCIcon", true)
mod:AddBoolOption("GazeIcon", false)
mod:AddBoolOption("RangeFrame", true)

local mcIcon = 8
local warnConflagTargets = {}
local warnMCTargets = {}
--local shieldDown = false
local phase5 = false
local flamestrike = GetSpellInfo(36735)

local function showConflag()
	warnConflag:Show(table.concat(warnConflagTargets, "<, >"))
	table.wipe(warnConflagTargets)
end

function mod:MCFailsafe()
	timerMCCD:Start(70)
	self:ScheduleMethod(70, "MCFailsafe")
end

local function showMC()
	warnMC:Show(table.concat(warnMCTargets, "<, >"))
	table.wipe(warnMCTargets)
	mcIcon = 8
	timerMCCD:Start()
end

local showShieldHealthBar, hideShieldHealthBar
do
	local frame = CreateFrame("Frame") -- using a separate frame avoids the overhead of the DBM event handlers which are not meant to be used with frequently occuring events like all damage events...
	local shieldedMob
	local absorbRemaining = 0
	local maxAbsorb = 0
	local function getShieldHP()
		return math.max(1, math.floor(absorbRemaining / maxAbsorb * 100))
	end
	frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	frame:SetScript("OnEvent", function(self, event, timestamp, subEvent, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
		if shieldedMob == destGUID then
			local absorbed
			if subEvent == "SWING_MISSED" then
				absorbed = select( 2, ... )
			elseif subEvent == "RANGE_MISSED" or subEvent == "SPELL_MISSED" or subEvent == "SPELL_PERIODIC_MISSED" then
				absorbed = select( 5, ... )
			end
			if absorbed then
				absorbRemaining = absorbRemaining - absorbed
			end
		end
	end)

	function showShieldHealthBar(self, mob, shieldName, absorb)
		shieldedMob = mob
		absorbRemaining = absorb
		maxAbsorb = absorb
		DBM.BossHealth:RemoveBoss(getShieldHP)
		DBM.BossHealth:AddBoss(getShieldHP, shieldName)
		self:Schedule(15, hideShieldHealthBar)
	end

	function hideShieldHealthBar()
		DBM.BossHealth:RemoveBoss(getShieldHP)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(warnConflagTargets)
	table.wipe(warnMCTargets)
	mcIcon = 8
	--shieldDown = false
	phase5 = false
	timerPhase1mob:Start(30, L.Thaladred)
	if self.Options.HealthFrame then
		DBM.BossHealth:Clear()
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(20064, L.Thaladred)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 37018 then
		warnConflagTargets[#warnConflagTargets + 1] = args.destName
		self:Unschedule(showConflag)
		self:Schedule(0.3, showConflag)
	elseif args.spellId == 36797 then
		warnMCTargets[#warnMCTargets + 1] = args.destName
		self:Unschedule(showMC)
		if self.Options.MCIcon then
			self:SetIcon(args.destName, mcIcon, 25)
			mcIcon = mcIcon - 1
		end
		if #warnMCTargets >= 3 then
			showMC()
		else
			self:Schedule(0.3, showMC)
		end
	elseif args.spellId == 37027 then
		warnToy:Show(args.destName)
		timerToy:Start(args.destName)
		if args:IsPlayer() then
			specWarnToy:Show()
		end
	elseif args.spellId == 36815 and not phase5 then
		--shieldDown = false
		showShieldHealthBar(self, args.destGUID, args.spellName, 80000)
		specWarnShield:Show()
		timerShieldCD:Start()
	elseif args.spellId == 35859 and args:IsPlayer() and self:IsInCombat() and (args.amount or 1) >= 2 then
		specWarnVapor:Show(args.amount)
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 36815 and not phase5 then
		--shieldDown = true
		specWarnPyro:Show(args.sourceName)
		hideShieldHealthBar()
	elseif args.spellId == 36797 then
		if self.Options.MCIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 37027 then
		timerToy:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 44863 then
		warnFear:Show()
		timerFearCD:Start()
	elseif args.spellId == 36819 then
		warnPyro:Show()
	elseif args.spellId == 35941 then
		warnGravity:Show()
		timerGravity:Start()
		timerGravityCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 36723 then
		warnPhoenix:Show()
		if phase5 then
			timerPhoenixCD:Start(90)
		else
			timerPhoenixCD:Start()
		end
	elseif args.spellId == 36834 then
		warnDisruption:Show()
	elseif args.spellId == 34341 and self:IsInCombat() then
		warnEgg:Show()
		specWarnEgg:Show()
		timerRebirth:Show()
		DBM.BossHealth:AddBoss(21364, L.Egg)
		self:Schedule(15, function()
			DBM.BossHealth:RemoveBoss(21364)
		end)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 20064 then
		timerNextGaze:Cancel()
		DBM.BossHealth:RemoveBoss(20064)
	elseif cid == 20060 then
		timerFearCD:Cancel()
		DBM.BossHealth:RemoveBoss(20060)
	elseif cid == 20062 then
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		DBM.BossHealth:RemoveBoss(20062)
	elseif cid == 20063 then
		DBM.BossHealth:RemoveBoss(20063)
	elseif cid == 21268 then
		warnMobDead:Show(L.Bow)
		DBM.BossHealth:RemoveBoss(21268)
	elseif cid == 21269 then
		warnMobDead:Show(L.Axe)
		DBM.BossHealth:RemoveBoss(21269)
	elseif cid == 21270 then
		warnMobDead:Show(L.Mace)
		DBM.BossHealth:RemoveBoss(21270)
	elseif cid == 21271 then
		warnMobDead:Show(L.Dagger)
		DBM.BossHealth:RemoveBoss(21271)
	elseif cid == 21272 then
		warnMobDead:Show(L.Sword)
		DBM.BossHealth:RemoveBoss(21272)
	elseif cid == 21273 then
		warnMobDead:Show(L.Shield)
		DBM.BossHealth:RemoveBoss(21273)
	elseif cid == 21274 then
		warnMobDead:Show(L.Staff)
		DBM.BossHealth:RemoveBoss(21274)
	elseif cid == 21364 then
		timerRebirth:Cancel()
		DBM.BossHealth:RemoveBoss(21364)
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if msg == L.EmoteGaze or msg:find(L.EmoteGaze) then
		local target = DBM:GetUnitFullName(target) or target
		warnGaze:Show(target)
		timerNextGaze:Start()
		if target == UnitName("player") then
			specWarnGaze:Show()
		end
		if self.Options.GazeIcon then
			self:SetIcon(target, 1, 15)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellSang or msg:find(L.YellSang) then
		timerPhase1mob:Start(12.5, L.Sanguinar)
		DBM.BossHealth:AddBoss(20060, L.Sanguinar)
	elseif msg == L.YellCaper or msg:find(L.YellCaper) then
		timerPhase1mob:Start(7, L.Capernian)
		DBM.BossHealth:AddBoss(20062, L.Capernian)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show()
		end
	elseif msg == L.YellTelo or msg:find(L.YellTelo) then
		timerPhase1mob:Start(8.4, L.Telonicus)
		DBM.BossHealth:AddBoss(20063, L.Telonicus)
	elseif msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		timerPhase:Start(105)
		warnPhase2:Show()
		--warnPhase3:Schedule(105)
		DBM.BossHealth:AddBoss(21268, L.Bow)
		DBM.BossHealth:AddBoss(21269, L.Axe)
		DBM.BossHealth:AddBoss(21270, L.Mace)
		DBM.BossHealth:AddBoss(21271, L.Dagger)
		DBM.BossHealth:AddBoss(21272, L.Sword)
		DBM.BossHealth:AddBoss(21273, L.Shield)
		DBM.BossHealth:AddBoss(21274, L.Staff)
	elseif msg == L.YellPhase3 or msg:find(L.YellPhase3) then
		warnPhase3:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show()
		end
		self:Schedule(10, function()
			DBM.BossHealth:AddBoss(20064, L.Thaladred)
			DBM.BossHealth:AddBoss(20060, L.Sanguinar)
			DBM.BossHealth:AddBoss(20062, L.Capernian)
			DBM.BossHealth:AddBoss(20063, L.Telonicus)
			--timerPhase:Start(173)
		end)
	elseif msg == L.YellPhase4 or msg:find(L.YellPhase4) then
		DBM.BossHealth:AddBoss(19622, L.name)
		warnPhase4:Show()
		--timerPhase:Cancel()
		timerPhoenixCD:Start(45)
		timerShieldCD:Start(60)
		timerMCCD:Start(40)
		self:ScheduleMethod(40, "MCFailsafe")
	elseif msg == L.YellPhase5 or msg:find(L.YellPhase5) then
		phase5 = true
		timerPhoenixCD:Cancel()
		timerShieldCD:Cancel()
		timerPhase:Start(45)
		warnPhase5:Schedule(45)
		timerGravityCD:Start(60)
		timerPhoenixCD:Start(137)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == flamestrike then
		self:SendSync("Flamestrike")
	end
end

function mod:OnSync(event, arg)
	if event == "Flamestrike" then
		warnFlamestrike:Show()
	end
end
