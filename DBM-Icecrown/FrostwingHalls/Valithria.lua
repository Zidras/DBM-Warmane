local mod	= DBM:NewMod("Valithria", "DBM-Icecrown", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4436 $"):sub(12, -3))
mod:SetCreatureID(36789)
mod:SetUsedIcons(8)
mod.onlyHighest = true--Instructs DBM health tracking to literally only store highest value seen during fight, even if it drops below that

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_TARGET"
)

local warnCorrosion			= mod:NewStackAnnounce(70751, 2, nil, false)
local warnGutSpray			= mod:NewTargetAnnounce(70633, 3, nil, "Tank|Healer")
local warnManaVoid			= mod:NewSpellAnnounce(71179, 2, nil, "ManaUser")
local warnSupression		= mod:NewSpellAnnounce(70588, 3)
local warnPortalSoon		= mod:NewSoonAnnounce(72483, 2, nil)
local warnPortal			= mod:NewSpellAnnounce(72483, 3, nil)
local warnPortalOpen		= mod:NewAnnounce("WarnPortalOpen", 4, 72483)

local specWarnGutSpray		= mod:NewSpecialWarningDefensive(70633, nil, nil, nil, 1, 2)
local specWarnLayWaste		= mod:NewSpecialWarningSpell(69325, nil, nil, nil, 2, 2)
local specWarnManaVoid		= mod:NewSpecialWarningMove(71179, nil, nil, nil, 1, 2)

local specWarnSuppressers	= mod:NewSpecialWarningSpell(70935)

local timerLayWaste			= mod:NewBuffActiveTimer(12, 69325, nil, nil, nil, 2)
local timerNextPortal		= mod:NewCDTimer(46.5, 72483, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)
local timerPortalsOpen		= mod:NewTimer(15, "TimerPortalsOpen", 72483, nil, nil, 6)
local timerPortalsClose		= mod:NewTimer(10, "TimerPortalsClose", 72483, nil, nil, 6)
local timerHealerBuff		= mod:NewBuffFadesTimer(40, 70873, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)
local timerGutSpray			= mod:NewTargetTimer(12, 70633, nil, "Tank|Healer", nil, 5)
local timerCorrosion		= mod:NewTargetTimer(6, 70751, nil, false, nil, 3)
local timerBlazingSkeleton	= mod:NewTimer(50, "TimerBlazingSkeleton", 17204, nil, nil, 1)
local timerAbom				= mod:NewTimer(50, "TimerAbom", 43392, nil, nil, 1)
local timerSuppressers		= mod:NewNextCountTimer(60, 70935, nil, nil, nil, 1)

local soundSpecWarnSuppressers	= mod:NewSound(70935)

local berserkTimer			= mod:NewBerserkTimer(420)

mod:AddBoolOption("SetIconOnBlazingSkeleton", true)

mod.vb.BlazingSkeletonTimer = 60
mod.vb.AbomSpawn = 0
mod.vb.AbomTimer = 60
mod.vb.blazingSkeleton = nil
mod.vb.SuppressersWave = 0

local function Suppressers(self)
	self.vb.SuppressersWave = self.vb.SuppressersWave + 1
	if self.vb.SuppressersWave == 2 then
		timerSuppressers:Stop()
		timerSuppressers:Start(58, self.vb.SuppressersWave)
		specWarnSuppressers:Cancel()
		specWarnSuppressers:Schedule(58)
		soundSpecWarnSuppressers:Schedule(58, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\suppressersSpawned.mp3")
		self:Unschedule(Suppressers)
		self:Schedule(58, Suppressers, self)
	elseif self.vb.SuppressersWave == 3 then
		timerSuppressers:Stop()
		timerSuppressers:Start(62, self.vb.SuppressersWave)
		specWarnSuppressers:Cancel()
		specWarnSuppressers:Schedule(62)
		soundSpecWarnSuppressers:Schedule(62, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\suppressersSpawned.mp3")
		self:Unschedule(Suppressers)
		self:Schedule(62, Suppressers, self)
	elseif self.vb.SuppressersWave == 4 then
		timerSuppressers:Stop()
		timerSuppressers:Start(50, self.vb.SuppressersWave)
		specWarnSuppressers:Cancel()
		specWarnSuppressers:Schedule(50)
		soundSpecWarnSuppressers:Schedule(50, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\suppressersSpawned.mp3")
		self:Unschedule(Suppressers)
		self:Schedule(50, Suppressers, self)
	elseif self.vb.SuppressersWave > 4 then -- using dummy values since I have no Warmane VODs past 4 waves.
		timerSuppressers:Stop()
		timerSuppressers:Start(50, self.vb.SuppressersWave)
		specWarnSuppressers:Cancel()
		specWarnSuppressers:Schedule(50)
		soundSpecWarnSuppressers:Schedule(50, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\suppressersSpawned.mp3")
		self:Unschedule(Suppressers)
		self:Schedule(50, Suppressers, self)
	end
end

function mod:StartBlazingSkeletonTimer()
	timerBlazingSkeleton:Start(self.vb.BlazingSkeletonTimer)
	self:ScheduleMethod(self.vb.BlazingSkeletonTimer, "StartBlazingSkeletonTimer")
	if self.vb.BlazingSkeletonTimer >= 10 then--Keep it from dropping below 5
		self.vb.BlazingSkeletonTimer = self.vb.BlazingSkeletonTimer - 5
	end
end

function mod:StartAbomTimer()
	self.vb.AbomSpawn = self.vb.AbomSpawn + 1
	if self.vb.AbomSpawn == 1 then
		timerAbom:Start(self.vb.AbomTimer)--Timer is 60 seconds after first early abom, it's set to 60 on combat start.
		self:ScheduleMethod(self.vb.AbomTimer, "StartAbomTimer")
		self.vb.AbomTimer = self.vb.AbomTimer - 5--Right after first abom timer starts, change it from 60 to 55.
	elseif self.vb.AbomSpawn == 2 or self.vb.AbomSpawn == 3 then
		timerAbom:Start(self.vb.AbomTimer)--Start first and second 55 second timer
		self:ScheduleMethod(self.vb.AbomTimer, "StartAbomTimer")
	elseif self.vb.AbomSpawn >= 4 then--after 4th abom, the timer starts subtracting again.
		timerAbom:Start(self.vb.AbomTimer)--Start third 55 second timer before subtracking from it again.
		self:ScheduleMethod(self.vb.AbomTimer, "StartAbomTimer")
		if self.vb.AbomTimer >= 10 then--Keep it from dropping below 5
			self.vb.AbomTimer = self.vb.AbomTimer - 5--Rest of timers after 3rd 55 second timer will be 5 less than previous until they come every 5 seconds.
		end
	end
end

function mod:OnCombatStart(delay)
	if self:IsHeroic() then
		berserkTimer:Start(-delay)
	end
	timerNextPortal:Start()
	warnPortalSoon:Schedule(41)
	self:ScheduleMethod(46.5, "Portals")--This will never be perfect, since it's never same. 45-48sec variations
	self.vb.BlazingSkeletonTimer = 60
	self.vb.AbomTimer = 60
	self.vb.AbomSpawn = 0
	self:ScheduleMethod(30-delay, "StartBlazingSkeletonTimer")
	self:ScheduleMethod(5-delay, "StartAbomTimer")
	timerBlazingSkeleton:Start(30-delay)
	timerAbom:Start(5-delay)
	self.vb.blazingSkeleton = nil
	self.vb.SuppressersWave = 1
	timerSuppressers:Start(30-delay, self.vb.SuppressersWave)
	specWarnSuppressers:Schedule(30)
	soundSpecWarnSuppressers:Schedule(30, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\suppressersSpawned.mp3")
	self:Schedule(30, Suppressers, self)
end

function mod:Portals()
	warnPortal:Show()
	warnPortalOpen:Cancel()
	timerPortalsOpen:Cancel()
	warnPortalSoon:Cancel()
	warnPortalOpen:Schedule(15)
	timerPortalsOpen:Start()
	timerPortalsClose:Schedule(15)
	warnPortalSoon:Schedule(41)
	timerNextPortal:Start()
	self:UnscheduleMethod("Portals")
	self:ScheduleMethod(46.5, "Portals")--This will never be perfect, since it's never same. 45-48sec variations
end

function mod:TrySetTarget()
	if DBM:GetRaidRank() >= 1 then
		for uId in DBM:GetGroupMembers() do
			if UnitGUID(uId.."target") == self.vb.blazingSkeleton then
				self.vb.blazingSkeleton = nil
				SetRaidTarget(uId.."target", 8)
			end
			if not self.vb.blazingSkeleton then
				break
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(70754, 71748, 72023, 72024) then--Fireball (its the first spell Blazing SKeleton's cast upon spawning)
		if self.Options.SetIconOnBlazingSkeleton then
			self.vb.blazingSkeleton = args.sourceGUID
			self:TrySetTarget()
		end
	elseif args.spellId == 71189 then
		DBM:EndCombat(self)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 71179 then--Mana Void
		warnManaVoid:Show()
	elseif args.spellId == 70588 and self:AntiSpam(5, 1) then--Supression
		warnSupression:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70633, 71283, 72025, 72026) and args:IsDestTypePlayer() then--Gut Spray
		timerGutSpray:Start(args.destName)
		warnGutSpray:CombinedShow(0.3, args.destName)
		if self:IsTank() then
			specWarnGutSpray:Show()
			specWarnGutSpray:Play("defensive")
		end
	elseif args:IsSpellID(70751, 71738, 72022, 72023) and args:IsDestTypePlayer() then--Corrosion
		warnCorrosion:Show(args.destName, args.amount or 1)
		timerCorrosion:Start(args.destName)
	elseif args:IsSpellID(69325, 71730) then--Lay Waste
		specWarnLayWaste:Show()
		specWarnLayWaste:Play("aesoon")
		timerLayWaste:Start()
	elseif args:IsSpellID(70873, 71941) and args:IsPlayer() then	--Emerald Vigor/Twisted Nightmares (portal healers)
		timerHealerBuff:Stop()
		timerHealerBuff:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(70633, 71283, 72025, 72026) then--Gut Spray
		timerGutSpray:Cancel(args.destName)
	elseif args:IsSpellID(69325, 71730) then--Lay Waste
		timerLayWaste:Cancel()
	elseif args:IsSpellID(70873, 71941) and args:IsPlayer() then	--Emerald Vigor/Twisted Nightmares (portal healers)
		timerHealerBuff:Stop()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 71086 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then		-- Mana Void
		specWarnManaVoid:Show()
		specWarnManaVoid:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_TARGET()
	if self.vb.blazingSkeleton then
		self:TrySetTarget()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellPortals or msg:find(L.YellPortals)) and self:LatencyCheck() then
		self:SendSync("NightmarePortal")
	end
end

function mod:OnSync(msg, arg)
	if msg == "NightmarePortal" and self:IsInCombat() then
		self:UnscheduleMethod("Portals")
		self:Portals()
	end
end
