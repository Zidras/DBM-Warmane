local mod	= DBM:NewMod("Valithria", "DBM-Icecrown", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20231121214155")
mod:SetCreatureID(36789)
mod:SetUsedIcons(8)
mod.onlyHighest = true--Instructs DBM health tracking to literally only store highest value seen during fight, even if it drops below that

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 70754 71748 72023 72024 71189",
	"SPELL_CAST_SUCCESS 71179 71741 70588",
	"SPELL_AURA_APPLIED 70633 71283 72025 72026 70751 71738 72022 72023 69325 71730 70873 71941",
	"SPELL_AURA_APPLIED_DOSE 70751 71738 72022 72023 70873 71941",
	"SPELL_AURA_REMOVED 70633 71283 72025 72026 69325 71730 70873 71941",
	"SPELL_DAMAGE 71086 71743 71086 72030",
	"SPELL_MISSED 71086 71743 71086 72030",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnCorrosion			= mod:NewStackAnnounce(70751, 2, nil, false)
local warnGutSpray			= mod:NewTargetAnnounce(70633, 3, nil, "Tank|Healer")
local warnManaVoid			= mod:NewSpellAnnounce(71179, 2, nil, "ManaUser")
local warnSupression		= mod:NewSpellAnnounce(70588, 3)
local warnPortalSoon		= mod:NewSoonAnnounce(72483, 2, nil)
local warnPortal			= mod:NewCountAnnounce(72483, 3, nil)
local warnPortalOpen		= mod:NewAnnounce("WarnPortalOpen", 4, 72483, nil, nil, nil, 72483)

local specWarnGutSpray		= mod:NewSpecialWarningDefensive(70633, nil, nil, nil, 1, 2)
local specWarnLayWaste		= mod:NewSpecialWarningSpell(69325, nil, nil, nil, 2, 2)
local specWarnGTFO			= mod:NewSpecialWarningGTFO(71179, nil, nil, nil, 1, 8)
local specWarnSuppressers	= mod:NewSpecialWarningSpell(70935)

local timerLayWaste			= mod:NewBuffActiveTimer(12, 69325, nil, nil, nil, 2)
local timerNextPortal		= mod:NewCDCountTimer(45, 72483, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON) -- ~3s variance. (25H Lordearon 2022/10/06 || 25H Lordearon 2022/10/09) - pull:45.0, 45.6, 47.9, 46.6 || pull:45.4, 45.4, 45.1, 46.5
local timerPortalsOpen		= mod:NewTimer(15, "TimerPortalsOpen", 72483, nil, nil, 6, nil, nil, nil, nil, nil, nil, nil, 72483)
local timerPortalsClose		= mod:NewTimer(10, "TimerPortalsClose", 72483, nil, nil, 6, nil, nil, nil, nil, nil, nil, nil, 72483)
local timerHealerBuff		= mod:NewBuffFadesTimer(40, 70873, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerGutSpray			= mod:NewBuffFadesTimer(12, 70633, nil, "Tank|Healer", nil, 5)
local timerCorrosion		= mod:NewBuffFadesTimer(6, 70751, nil, false, nil, 3)
local timerBlazingSkeleton	= mod:NewNextTimer(50, 70933, "TimerBlazingSkeleton", nil, nil, 1, 17204)
local timerAbom				= mod:NewNextCountTimer(50, 70922, "TimerAbom", nil, nil, 1)
local timerSuppressers		= mod:NewNextCountTimer(60, 70935, nil, nil, nil, 1)

local soundSpecWarnSuppressers	= mod:NewSound(70935)

local berserkTimer			= mod:NewBerserkTimer(420)

mod:AddSetIconOption("SetIconOnBlazingSkeleton", 70933, true, 5, {8})

mod.vb.BlazingSkeletonTimer = 60
mod.vb.AbomSpawn = 0
mod.vb.AbomTimer = 60
mod.vb.SuppressersWave = 0
mod.vb.portalCount = 0
local portalNameN = GetSpellInfo(71305)
local portalNameH = GetSpellInfo(71987)

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
		timerSuppressers:Start(56, self.vb.SuppressersWave)
		specWarnSuppressers:Cancel()
		specWarnSuppressers:Schedule(56)
		soundSpecWarnSuppressers:Schedule(56, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\suppressersSpawned.mp3")
		self:Unschedule(Suppressers)
		self:Schedule(56, Suppressers, self)
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

local function StartBlazingSkeletonTimer(self)
	timerBlazingSkeleton:Start(self.vb.BlazingSkeletonTimer)
	self:Schedule(self.vb.BlazingSkeletonTimer, StartBlazingSkeletonTimer, self)
	if self.vb.BlazingSkeletonTimer >= 10 then--Keep it from dropping below 5
		self.vb.BlazingSkeletonTimer = self.vb.BlazingSkeletonTimer - 5
	end
end

local function StartAbomTimer(self)
	self.vb.AbomSpawn = self.vb.AbomSpawn + 1
	if self.vb.AbomSpawn == 1 then
		timerAbom:Start(self.vb.AbomTimer, self.vb.AbomSpawn + 1)--Timer is 60 seconds after first early abom, it's set to 60 on combat start.
		self:Schedule(self.vb.AbomTimer, StartAbomTimer, self)
		self.vb.AbomTimer = self.vb.AbomTimer - 5--Right after second abom timer starts, change it from 60 to 55.
	elseif self.vb.AbomSpawn == 2 or self.vb.AbomSpawn == 3 then
		timerAbom:Start(self.vb.AbomTimer, self.vb.AbomSpawn + 1)--Start first and second 55 second timer (third and fourth abom spawn)
		self:Schedule(self.vb.AbomTimer, StartAbomTimer, self)
	elseif self.vb.AbomSpawn >= 4 then--after 4th abom, the timer starts subtracting again.
		timerAbom:Start(self.vb.AbomTimer, self.vb.AbomSpawn + 1)--Start third 55 second timer before subtracting from it again.
		self:Schedule(self.vb.AbomTimer, StartAbomTimer, self)
		if self.vb.AbomTimer >= 10 then--Keep it from dropping below 5
			self.vb.AbomTimer = self.vb.AbomTimer - 5--Rest of timers after 3rd 55 second timer will be 5 less than previous until they come every 5 seconds.
		end
	end
end

local function Portals(self)
	self.vb.portalCount = self.vb.portalCount + 1
	warnPortal:Show(self.vb.portalCount)
	warnPortalOpen:Cancel()
	timerPortalsOpen:Cancel()
	warnPortalSoon:Cancel()
	warnPortalOpen:Schedule(15)
	timerPortalsOpen:Start()
	timerPortalsClose:Schedule(15)
	warnPortalSoon:Schedule(40)
	timerNextPortal:Start(nil, self.vb.portalCount+1)
--	self:Unschedule(Portals)
--	self:Schedule(45.4, Portals, self)--This will never be perfect, since it's never same. 45-48sec variations
end

-- archmage (all times relative to combat start): 45, 75
-- zombie: 65,
function mod:OnCombatStart(delay)
	if self:IsHeroic() then
		berserkTimer:Start(-delay)
	end
	self.vb.portalCount = 0
	timerNextPortal:Start(nil, 1) -- Hardcode 1 on combatStart, there's no need to calculate self.vb.portalCount+1
	warnPortalSoon:Schedule(40)
--	self:Schedule(45.4, Portals, self)--This will never be perfect, since it's never same. 45-48sec variations
	self.vb.BlazingSkeletonTimer = 60
	self.vb.AbomTimer = 60
	self.vb.AbomSpawn = 0
	timerBlazingSkeleton:Start(53-delay)
	self:Schedule(53-delay, StartBlazingSkeletonTimer, self)
	timerAbom:Start(22-delay, 1) -- Hardcode 1 on combatStart, there's no need to calculate self.vb.AbomSpawn+1
	self:Schedule(22-delay, StartAbomTimer, self)
	self.vb.SuppressersWave = 1
	timerSuppressers:Start(28-delay, self.vb.SuppressersWave)
	specWarnSuppressers:Schedule(28)
	soundSpecWarnSuppressers:Schedule(28, "Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\suppressersSpawned.mp3")
	self:Schedule(28, Suppressers, self)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if args:IsSpellID(70754, 71748, 72023, 72024) then--Fireball (its the first spell Blazing SKeleton's cast upon spawning)
		if self.Options.SetIconOnBlazingSkeleton then
			self:ScanForMobs(args.sourceGUID, 2, 8, 1, nil, 12, "SetIconOnBlazingSkeleton")
		end
	elseif spellId == 71189 then
		DBM:EndCombat(self)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(71179, 71741) then--Mana Void
		warnManaVoid:Show()
	elseif spellId == 70588 and self:AntiSpam(5, 1) then--Supression
		warnSupression:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70633, 71283, 72025, 72026) and args:IsDestTypePlayer() then--Gut Spray
		timerGutSpray:Start(args.destName)
		warnGutSpray:CombinedShow(0.3, args.destName)
		if args:IsPlayer() and self:IsTank() then
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

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
	if (spellId == 71086 or spellId == 71743 or spellId == 71086 or spellId == 72030) and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then		-- Mana Void
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if (spellName == portalNameN or spellName == portalNameH) and self:AntiSpam(2, 3) then -- Summon Dream Portal / Summon Nightmare Portal
		Portals(self)
	end
end

-- I have multiple logs where Yell event is missing due to a bad flag in the SQL, most likely. Best to use boss1 unit events that have proven to be reliable for Warmane, which is also much more efficient
--[[function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellPortals or msg:find(L.YellPortals)) and self:LatencyCheck() then
		self:SendSync("NightmarePortal")
	end
end

function mod:OnSync(msg)
	if msg == "NightmarePortal" and self:IsInCombat() then
		self:Unschedule(Portals)
		Portals(self)
	end
end]]
