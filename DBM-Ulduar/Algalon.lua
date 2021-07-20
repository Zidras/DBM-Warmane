local mod	= DBM:NewMod("Algalon", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3804 $"):sub(12, -3))
mod:SetCreatureID(32871)

mod:RegisterCombat("yell", L.YellPull, L.YellPull2)
mod:RegisterKill("yell", L.YellKill)
mod:SetWipeTime(20)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH"
)

local announceBigBang			= mod:NewSpellAnnounce(64584, 4)
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnPhase2Soon			= mod:NewAnnounce("WarnPhase2Soon", 2)
local announcePreBigBang		= mod:NewPreWarnAnnounce(64584, 10, 3)
local announceBlackHole			= mod:NewSpellAnnounce(65108, 2)
local announceCosmicSmash		= mod:NewAnnounce("WarningCosmicSmash", 3, 62311)
local announcePhasePunch		= mod:NewAnnounce("WarningPhasePunch", 4, 65108, mod:IsHealer() or mod:IsTank())

local specwarnStarLow			= mod:NewSpecialWarning("warnStarLow", mod:IsHealer() or mod:IsTank())
local specWarnPhasePunch		= mod:NewSpecialWarningStack(64412, nil, 4)
local specWarnBigBang			= mod:NewSpecialWarningSpell(64584)
local specWarnCosmicSmash		= mod:NewSpecialWarningSpell(64598)

local timerCombatStart		    = mod:NewTimer(7, "TimerCombatStart", 2457)
local enrageTimer				= mod:NewBerserkTimer(360)
local timerNextBigBang			= mod:NewNextTimer(90.5, 64584, nil, nil, nil, 2, nil, DBM_CORE_L.TANK_ICON, nil, 3)
local timerBigBangCast			= mod:NewCastTimer(8, 64584, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)
local timerNextCollapsingStar	= mod:NewTimer(18, "NextCollapsingStar", "Interface\\Icons\\Spell_Shadow_Shadesofdarkness", nil, nil, 2, DBM_CORE_L.HEALER_ICON)
local timerCDCosmicSmash		= mod:NewTimer(25, "NextCosmicSmash", "Interface\\Icons\\Spell_Fire_SelfDestruct", nil, nil, 2, DBM_CORE_L.DEADLY_ICON)
local timerCastCosmicSmash		= mod:NewCastTimer(4.5, 62311, nil, nil, nil, 2, nil, DBM_CORE_L.IMPORTANT_ICON)
local timerPhasePunch			= mod:NewBuffActiveTimer(45, 64412, nil, nil, nil, 2, nil, DBM_CORE_L.MYTHIC_ICON)
local timerNextPhasePunch		= mod:NewNextTimer(15.5, 64412, nil, nil, nil, 2, nil, DBM_CORE_L.TANK_ICON)

local warned_preP2 = false
local warned_star = {}
local stars = {}
local stars_hp = {}
local star_num = 1

function mod:OnCombatStart(delay)
	self:SetStage(1)
	stars = {}
	warned_star = {}
	stars_hp = {}
	star_num = 1
	warned_preP2 = false
	local text = select(3, GetWorldStateUIInfo(1))
	local _, _, time = string.find(text, L.PullCheck)
	if not time then
		time = 60
	end
	time = tonumber(time)
	if time == 60 then
		timerCombatStart:Start(26.5-delay)
		self:ScheduleMethod(26.5-delay, "startTimers")	-- 26 seconds roleplaying
	else
		timerCombatStart:Start(-delay)
		self:ScheduleMethod(8-delay, "startTimers")	-- 8 seconds roleplaying
	end
end

function mod:OnCombatEnd(wipe)
	DBM.BossHealth:Clear()
end

function mod:startTimers()
	enrageTimer:Start()
	timerNextBigBang:Start()
	announcePreBigBang:Schedule(80)
	timerCDCosmicSmash:Start()
	timerNextCollapsingStar:Start()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64584, 64443) then 	-- Big Bang
		timerBigBangCast:Start()
		timerNextBigBang:Start()
		announceBigBang:Show()
		announcePreBigBang:Schedule(80)
		specWarnBigBang:Show()
		timerCDCosmicSmash:Cancel()
		timerCDCosmicSmash:Start(25-11.5)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(64598, 62301) then	-- Cosmic Smash
		timerCastCosmicSmash:Start()
		timerCDCosmicSmash:Start()
		announceCosmicSmash:Show()
		specWarnCosmicSmash:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(64412) then
		timerNextPhasePunch:Start()
		local amount = args.amount or 1
		if args:IsPlayer() and amount >= 4 then
			specWarnPhasePunch:Show(args.amount)
		end
		timerPhasePunch:Start(args.destName)
		announcePhasePunch:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(65108, 64122) and self:AntiSpam(2, args.spellId .. args.sourceGUID) then 	-- Black Hole Explosion
		announceBlackHole:Show()
		if stars[args.sourceGUID] then
			local id = stars[args.sourceGUID]
			DBM.BossHealth:RemoveBoss(id)
		else
			DBM.BossHealth:RemoveLowest()
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Emote_CollapsingStar or msg:find(L.Emote_CollapsingStar) then
		timerNextCollapsingStar:Start(60)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		timerNextCollapsingStar:Cancel()
		warnPhase2:Show()
		self:SetStage(2)
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(32871)
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_preP2 and self:GetUnitCreatureId(uId) == 32871 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.23 then
		warned_preP2 = true
		warnPhase2Soon:Show()
	elseif not warned_star[UnitGUID(uId)] and self:GetUnitCreatureId(uId) == 32955 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 then
		warned_star[UnitGUID(uId)] = true
		specwarnStarLow:Show()
	end
end

mod:RegisterOnUpdateHandler(function(self, elapsed)
	if not self:IsInCombat() then return end
		for uId in DBM:GetGroupMembers() do
			local target = uId .."target"

			if self:GetUnitCreatureId(target) == 32955 then
				local targetGUID = UnitGUID(target)

				if not stars[targetGUID] then
					stars[targetGUID] = L.CollapsingStar .. " №" .. star_num
					do
						local function getStarPercent()
							local last = 100
							local trackingGUID = targetGUID

							for uId in DBM:GetGroupMembers() do
								local unitId = uId .. "target"
								if trackingGUID == UnitGUID(unitId) and mod:GetCIDFromGUID(trackingGUID) == 32955 then
									last = math.floor(UnitHealth(unitId)/UnitHealthMax(unitId) * 100)
									stars_hp[trackingGUID] = last
									if not warned_star[trackingGUID] and last < 25 then
										warned_star[trackingGUID] = true
										specwarnStarLow:Show()
									end
									return last
								end
							end
							return stars_hp[trackingGUID]
						end
						DBM.BossHealth:AddBoss(getStarPercent, stars[targetGUID])
					end
					star_num = star_num + 1
				end

			end
		end

end, 0.1)