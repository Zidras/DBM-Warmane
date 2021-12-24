local mod	= DBM:NewMod("Sapphiron", "DBM-Naxx", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2248 $"):sub(12, -3))
mod:SetCreatureID(15989)

mod:RegisterCombat("combat")
mod:SetModelScale(0.1)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 28542 55665",
	"SPELL_AURA_APPLIED 28522 55699 28547",
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_HEALTH boss1"
)

local warnDrainLifeNow	= mod:NewSpellAnnounce(28542, 2)
local warnDrainLifeSoon	= mod:NewSoonAnnounce(28542, 1)
local warnIceBlock		= mod:NewTargetAnnounce(28522, 2)
local warnAirPhaseSoon	= mod:NewAnnounce("WarningAirPhaseSoon", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnAirPhaseNow	= mod:NewAnnounce("WarningAirPhaseNow", 4, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnLanded		= mod:NewAnnounce("WarningLanded", 4, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

local specWarnDeepBreath= mod:NewSpecialWarning("WarningDeepBreath", nil, nil, nil, 1, 2)
local specWarnLowHP		= mod:NewSpecialWarning("SpecWarnSapphLow")
local specWarnFrostrain	= mod:NewSpecialWarningMove(55699, nil, nil, nil, 1, 2)
local yellIceBlock		= mod:NewYell(28522)

local timerDrainLife	= mod:NewCDTimer(22, 28542, nil, nil, nil, 3, nil, DBM_CORE_L.CURSE_ICON)
local timerAirPhase		= mod:NewTimer(66, "TimerAir", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)
local timerLanding		= mod:NewTimer(28.5, "TimerLanding", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6)
local timerIceBlast		= mod:NewTimer(9.3, "TimerIceBlast", 15876, nil, nil, 2, DBM_CORE_L.DEADLY_ICON)

local berserkTimer		= mod:NewBerserkTimer(900)

local UnitAffectingCombat = UnitAffectingCombat
local noTargetTime = 0
local warned_lowhp = false
mod.vb.isFlying = false

mod:AddRangeFrameOption("12")

local function resetIsFlying(self)
	self.vb.isFlying = false
end

local function Landing(self)
	warnAirPhaseSoon:Schedule(50)
	warnLanded:Show()
	timerAirPhase:Start()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	self:Schedule(60, DBM.RangeCheck.Show, DBM.RangeCheck, 12)
end

function mod:OnCombatStart(delay)
	noTargetTime = 0
	warned_lowhp = false
	self.vb.isFlying = false
	warnAirPhaseSoon:Schedule(38.5 - delay)
	timerAirPhase:Start(48.5 - delay)
	self:Schedule(46 - delay, DBM.RangeCheck.Show, DBM.RangeCheck, 12)
	self:RegisterOnUpdateHandler(function(self, elapsed)
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
			self.vb.isFlying = true
			self:Schedule(60, resetIsFlying, self)
			timerDrainLife:Cancel()
			timerAirPhase:Cancel()
			warnAirPhaseNow:Show()
			timerLanding:Start()
		end
	end, 0.2)
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
	elseif args:IsSpellID(55699, 28547) and args.destName == UnitName("player") and self:AntiSpam(1) then
		specWarnFrostrain:Show()
		specWarnFrostrain:Play("runout")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(28542, 55665) then -- Life Drain
		warnDrainLifeNow:Show()
		warnDrainLifeSoon:Schedule(18.5)
		timerDrainLife:Start()
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.EmoteBreath or msg:find(L.EmoteBreath) then
		self:SendSync("DeepBreath")
	end
end
mod.CHAT_MSG_RAID_BOSS_EMOTE = mod.CHAT_MSG_MONSTER_EMOTE -- used to be a normal emote

function mod:UNIT_HEALTH(uId)
	if not warned_lowhp and self:GetUnitCreatureId(uId) == 15989 and UnitHealth(uId) / UnitHealthMax(uId) < 0.1 then
		warned_lowhp = true
		specWarnLowHP:Show()
		timerAirPhase:Cancel()
	end
end

function mod:OnSync(event)
	if event == "DeepBreath" then
		timerIceBlast:Start()
		timerLanding:Update(14)
		self:Schedule(14.5, Landing, self)
		specWarnDeepBreath:Show()
		specWarnDeepBreath:Play("findshelter")
	end
end