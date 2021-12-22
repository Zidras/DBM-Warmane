local mod	= DBM:NewMod("Algalon", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal"

mod:SetRevision(("$Revision: 3804 $"):sub(12, -3))
mod:SetCreatureID(32871)
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)
mod:SetWipeTime(20)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 64584 64443",
	"SPELL_CAST_SUCCESS 65108 64122 64598 62301",
	"SPELL_AURA_APPLIED 64412",
	"SPELL_AURA_APPLIED_DOSE 64412",
	"SPELL_AURA_REMOVED 64412",
	"SPELL_DAMAGE 65108 64122",
	"SPELL_MISSED 65108 64122",
	"CHAT_MSG_RAID_BOSS_EMOTE",
--	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH boss1"
)

local warnPhase2				= mod:NewPhaseAnnounce(2, 2)
local warnPhase2Soon			= mod:NewPrePhaseAnnounce(2, 2)
local announcePreBigBang		= mod:NewPreWarnAnnounce(64584, 10, 3)
local announceBlackHole			= mod:NewSpellAnnounce(65108, 2)
local announcePhasePunch		= mod:NewStackAnnounce(65108, 4, nil, "Tank|Healer")

local specwarnStarLow			= mod:NewSpecialWarning("warnStarLow", "Tank|Healer", nil, nil, 1, 2)
local specWarnPhasePunch		= mod:NewSpecialWarningStack(64412, nil, 4, nil, nil, 1, 6)
local specWarnBigBang			= mod:NewSpecialWarningSpell(64584, nil, nil, nil, 3, 2)
local specWarnCosmicSmash		= mod:NewSpecialWarningDodge(64596, nil, nil, nil, 2, 2)

local timerNextBigBang			= mod:NewNextTimer(90.5, 64584, nil, nil, nil, 2)
local timerBigBangCast			= mod:NewCastTimer(8, 64584, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)
local timerNextCollapsingStar	= mod:NewTimer(15, "NextCollapsingStar", "Interface\\Icons\\INV_Enchant_EssenceCosmicGreater", nil, nil, 2, DBM_CORE_L.HEALER_ICON)
local timerCDCosmicSmash		= mod:NewCDTimer(24.6, 64596, nil, nil, nil, 3)
local timerCastCosmicSmash		= mod:NewCastTimer(4.5, 64596)
local timerPhasePunch			= mod:NewTargetTimer(45, 64412, nil, "Tank", 2, 5, nil, DBM_CORE_L.TANK_ICON)
local timerNextPhasePunch		= mod:NewNextTimer(15.5, 64412, nil, "Tank", 2, 5, nil, DBM_CORE_L.TANK_ICON)
local enrageTimer				= mod:NewBerserkTimer(360)

local warned_star = {}
local stars = {}
local stars_hp = {}
local star_num = 1
mod.vb.warned_preP2 = false

function mod:OnCombatStart(delay)
	self:SetStage(1)
	stars = {}
	warned_star = {}
	stars_hp = {}
	star_num = 1
	self.vb.warned_preP2 = false
end

function mod:OnCombatEnd()
	DBM.BossHealth:Clear()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64584, 64443) then 	-- Big Bang
		timerBigBangCast:Start()
		timerNextBigBang:Start()
		announcePreBigBang:Schedule(80)
		specWarnBigBang:Show()
		if self:IsTank() then
			specWarnBigBang:Play("defensive")
		else
			specWarnBigBang:Play("findshelter")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(65108, 64122) then 	-- Black Hole Explosion
		announceBlackHole:Show()
	elseif args:IsSpellID(64598, 62301) then	-- Cosmic Smash
		timerCastCosmicSmash:Start()
		timerCDCosmicSmash:Start()
		specWarnCosmicSmash:Show()
		specWarnCosmicSmash:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 64412 then
		timerNextPhasePunch:Start()
		local amount = args.amount or 1
		if args:IsPlayer() and amount >= 4 then
			specWarnPhasePunch:Show(args.amount)
			specWarnPhasePunch:Play("stackhigh")
		end
		timerPhasePunch:Start(args.destName)
		announcePhasePunch:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 64412 then
		timerPhasePunch:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, _, _, spellId)
	if (spellId == 65108 or spellId == 64122) and self:AntiSpam(2, spellId .. sourceGUID) then 	-- Black Hole Explosion
		announceBlackHole:Show()
		if stars[sourceGUID] then
			local id = stars[sourceGUID]
			DBM.BossHealth:RemoveBoss(id)
		else
			DBM.BossHealth:RemoveLowest()
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Emote_CollapsingStar or msg:find(L.Emote_CollapsingStar) then
		timerNextCollapsingStar:Start()
	end
end

--[[
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		timerNextCollapsingStar:Cancel()
		warnPhase2:Show()
		self:SetStage(2)
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(32871)
	end
end
--]]

function mod:UNIT_HEALTH(uId)
	local cid = self:GetUnitCreatureId(uId)
	local guid = UnitGUID(uId)
	if cid == 32871 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.23 and not self.vb.warned_preP2 then
		self.vb.warned_preP2 = true
		warnPhase2Soon:Show()
	elseif cid == 32955 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 and not warned_star[guid] then
		warned_star[guid] = true
		specwarnStarLow:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(65311) then--Supermassive Fail (fires when he becomes actually active)
		timerNextCollapsingStar:Start(16)
		timerCDCosmicSmash:Start(26)
		announcePreBigBang:Schedule(80)
		timerNextBigBang:Start(90)
		enrageTimer:Start(360)
	elseif spellName == GetSpellInfo(65256) then--Self Stun (phase 2)
		self:SetStage(2)
		self.vb.warned_preP2 = true
		timerNextCollapsingStar:Stop()
		warnPhase2:Show()
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(32871)
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
										specwarnStarLow:Play("aesoon")
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