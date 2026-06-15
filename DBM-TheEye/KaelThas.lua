local mod	= DBM:NewMod("KaelThas", "DBM-TheEye")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(19622)

--mod:RegisterCombat("yell", L.YellPull1, L.YellPull2)
mod:RegisterCombat("combat")
mod:SetUsedIcons(1, 6, 7, 8)

mod:RegisterEvents(
	"SPELL_CAST_START 44863 36819 35941",
	"SPELL_AURA_APPLIED 37018 36797 37027 36815 35859",
	"SPELL_AURA_APPLIED_DOSE 35859",
	"SPELL_AURA_REMOVED 36815 36797 37027",
	"SPELL_CAST_SUCCESS 36723 36834 34341",
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnGaze			= mod:NewAnnounce("WarnGaze", 4, 39414)
local warnFear			= mod:NewCastAnnounce(44863, 3)
local warnConflag		= mod:NewTargetAnnounce(37018, 4, nil, false)
local warnToy			= mod:NewTargetAnnounce(37027, 2, nil, false)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnMobDead		= mod:NewAnnounce("WarnMobDead", 3, nil, false)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnPhase4		= mod:NewPhaseAnnounce(4)
local warnDisruption	= mod:NewSpellAnnounce(36834, 3)
local warnMC			= mod:NewTargetNoFilterAnnounce(36797, 4)
local warnPhoenix		= mod:NewSpellAnnounce(36723, 2)
local warnFlamestrike	= mod:NewSpellAnnounce(36735, 4)
local warnEgg			= mod:NewAnnounce("WarnEgg", 4, 36723)
local warnPyro			= mod:NewCastAnnounce(36819, 4)
local warnPhase5		= mod:NewPhaseAnnounce(5)
local warnGravity		= mod:NewSpellAnnounce(35966, 3)

local specWarnGaze		= mod:NewSpecialWarning("SpecWarnGaze", nil, nil, nil, 4, 2)
local specWarnToy		= mod:NewSpecialWarningYou(37027, nil, nil, nil, 1, 2)
local specWarnEgg		= mod:NewSpecialWarning("SpecWarnEgg", nil, nil, nil, 1, 2)
local specWarnShield	= mod:NewSpecialWarningSpell(36815)--No decent voice for this
local specWarnPyro		= mod:NewSpecialWarningInterrupt(36819, "HasInterrupt", nil, nil, 1, 2)
local specWarnVapor		= mod:NewSpecialWarningStack(35859, nil, 2, nil, nil, 1, 6)

local timerPhase		= mod:NewTimer(105, "TimerPhase", 28131, nil, nil, 6, nil, nil, 1, 4)
local timerPhase1mob	= mod:NewTimer(30, "TimerPhase1mob", 28131, nil, nil, 1, nil, nil, 1, 4)
local timerNextGaze		= mod:NewTimer(8.5, "TimerNextGaze", 39414, nil, nil, 3)
local timerFearCD		= mod:NewCDTimer(31, 39427, nil, nil, nil, 2)
local timerToy			= mod:NewTargetTimer(60, 37027, nil, false, nil, 3)
local timerPhoenixCD	= mod:NewCDTimer(45, 36723, nil, nil, nil, 1)
local timerRebirth		= mod:NewTimer(15, "TimerRebirth", 36723, nil, nil, 1)
local timerShieldCD		= mod:NewCDTimer(60, 36815, nil, nil, nil, 4)
local timerGravityCD	= mod:NewNextTimer(92, 35941, nil, nil, nil, 6)
local timerGravity		= mod:NewBuffActiveTimer(32, 35941, nil, nil, nil, 6)
local timerMCCD			= mod:NewCDTimer(60, 36797)

mod:AddSetIconOption("MCIcon", 36797, true, false, {8, 7, 6})
mod:AddBoolOption("GazeIcon", false)
--mod:AddSetIconOption("GazeIcon", 38280, false, false, {1})--Problem with no auto localized spellID to use
mod:AddRangeFrameOption(10, 37018)

mod.vb.mcIcon = 8
local warnConflagTargets = {}
local warnMCTargets = {}

local function showConflag()
	warnConflag:Show(table.concat(warnConflagTargets, "<, >"))
	table.wipe(warnConflagTargets)
end

local function MCFailsafe(self)
	timerMCCD:Start(70)
	self:Schedule(70, MCFailsafe, self)
end

local function showMC(self)
	warnMC:Show(table.concat(warnMCTargets, "<, >"))
	table.wipe(warnMCTargets)
	self.vb.mcIcon = 8
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
	frame:SetScript("OnEvent", function(self, _, _, subEvent, _, _, _, destGUID, _, _, ...)
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

function mod:OnCombatStart()
	table.wipe(warnConflagTargets)
	table.wipe(warnMCTargets)
	self.vb.mcIcon = 8
	self:SetStage(1)
	timerPhase1mob:Start(32, L.Thaladred)
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
	local spellId = args.spellId
	if spellId == 37018 then
		warnConflagTargets[#warnConflagTargets + 1] = args.destName
		self:Unschedule(showConflag)
		self:Schedule(0.3, showConflag)
	elseif spellId == 36797 then
		warnMCTargets[#warnMCTargets + 1] = args.destName
		self:Unschedule(showMC)
		if self.Options.MCIcon then
			self:SetIcon(args.destName, self.vb.mcIcon, 25)
		end
		self.vb.mcIcon = self.vb.mcIcon - 1
		if #warnMCTargets >= 3 then
			showMC(self)
		else
			self:Schedule(0.3, showMC, self)
		end
	elseif spellId == 37027 then
		timerToy:Start(args.destName)
		if args:IsPlayer() then
			specWarnToy:Show()
		else
			warnToy:Show(args.destName)
		end
	elseif spellId == 36815 and self.vb.phase ~= 5 then
		showShieldHealthBar(self, args.destGUID, args.spellName, 80000)
		specWarnShield:Show()
		timerShieldCD:Start()
	elseif args.spellId == 35859 and args:IsPlayer() and self:IsInCombat() and (args.amount or 1) >= 2 then
		specWarnVapor:Show(args.amount)
		specWarnVapor:Play("stackhigh")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 36815 and self.vb.phase ~= 5 then
		specWarnPyro:Show(args.sourceName)
		specWarnPyro:Play("kickcast")
		hideShieldHealthBar()
	elseif spellId == 36797 then
		if self.Options.MCIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 37027 then
		timerToy:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 44863 then
		warnFear:Show()
		timerFearCD:Start()
	elseif spellId == 36819 then
		warnPyro:Show()
	elseif spellId == 35941 then
		warnGravity:Show()
		timerGravity:Start()
		timerGravityCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 36723 then
		warnPhoenix:Show()
		if self.vb.phase == 5 then
			timerPhoenixCD:Start(90)
		else
			timerPhoenixCD:Start()
		end
	elseif args.spellId == 36834 then
		warnDisruption:Show()
	elseif args.spellId == 34341 and self:IsInCombat() then
		warnEgg:Show()
		specWarnEgg:Show()
		specWarnEgg:Play("killmob")
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
	if (msg == L.EmoteGaze or msg:find(L.EmoteGaze)) and target then
		target = DBM:GetUnitFullName(target)
		timerNextGaze:Start()
		if target == UnitName("player") then
			specWarnGaze:Show()
			specWarnGaze:Play("justrun")
		else
			warnGaze:Show(target)
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
			DBM.RangeCheck:Show(10)
		end
	elseif msg == L.YellTelo or msg:find(L.YellTelo) then
		timerPhase1mob:Start(8.4, L.Telonicus)
		DBM.BossHealth:AddBoss(20063, L.Telonicus)
	elseif msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		self:SetStage(2)
		timerPhase:Start(105)--105
		warnPhase2:Show()
		warnPhase3:Schedule(105)--210
		DBM.BossHealth:AddBoss(21268, L.Bow)
		DBM.BossHealth:AddBoss(21269, L.Axe)
		DBM.BossHealth:AddBoss(21270, L.Mace)
		DBM.BossHealth:AddBoss(21271, L.Dagger)
		DBM.BossHealth:AddBoss(21272, L.Sword)
		DBM.BossHealth:AddBoss(21273, L.Shield)
		DBM.BossHealth:AddBoss(21274, L.Staff)
	elseif msg == L.YellPhase3 or msg:find(L.YellPhase3) then
		self:SetStage(3)
		warnPhase3:Show()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
		self:Schedule(10, function()
			DBM.BossHealth:AddBoss(20064, L.Thaladred)
			DBM.BossHealth:AddBoss(20060, L.Sanguinar)
			DBM.BossHealth:AddBoss(20062, L.Capernian)
			DBM.BossHealth:AddBoss(20063, L.Telonicus)
			timerPhase:Start(73)--83 pre nerf, 183 post nerf
		end)
	elseif msg == L.YellPhase4 or msg:find(L.YellPhase4) then
		self:SetStage(4)
		DBM.BossHealth:AddBoss(19622, L.name)
		warnPhase4:Show()
		timerPhase:Cancel()
		timerPhoenixCD:Start(50)
		timerShieldCD:Start(60)
		timerMCCD:Start(40)
		self:Schedule(40, MCFailsafe, self)
	elseif msg == L.YellPhase5 or msg:find(L.YellPhase5) then
		self:SetStage(5)
		timerPhoenixCD:Cancel()
		timerShieldCD:Cancel()
		timerPhase:Start(45)
		warnPhase5:Schedule(45)
		timerGravityCD:Start(60)
		timerPhoenixCD:Start(137)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(36735) then
		self:SendSync("Flamestrike")
	end
end

function mod:OnSync(event)
	if not self:IsInCombat() then return end
	if event == "Flamestrike" then
		warnFlamestrike:Show()
	end
end
