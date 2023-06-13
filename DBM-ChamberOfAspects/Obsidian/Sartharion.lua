local mod	= DBM:NewMod("Sartharion", "DBM-ChamberOfAspects", 1)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25"

mod:SetRevision("20221012211527")
mod:SetCreatureID(28860)

--mod:RegisterCombat("combat") -- Don't use IEEU, because on Warmane 3 Drakes, Sartharion NOT is engaged first, but Tenebron > Shadron > Vesperon > Sartharion (Sartharion will end up on boss1).
-- "<15.29 22:46:09> [CHAT_MSG_MONSTER_YELL] It is my charge to watch over these eggs. I will see you burn before any harm comes to them!:Sartharion:::::0:0::0:6450::0:", -- [120]
-- "<15.30 22:46:09> [CLEU] SPELL_CAST_SUCCESS:0xF1300076F4000109:Tenebron:0x0000000000000000:nil:61248:Power of Tenebron:nil:nil:", -- [121]
-- "<15.30 22:46:09> [DBM_Debug] INSTANCE_ENCOUNTER_ENGAGE_UNIT event fired for zoneId532:3:", -- [122]
-- "<15.30 22:46:09> [DBM_Debug] StartCombat called by : IEEU for mod : Tenebron. LastInstanceMapID is 532:nil:", -- [123]
-- "<15.30 22:46:09> [DBM_Pull] Tenebron:0:nil:100:", -- [124]
-- "<15.30 22:46:09> [DBM_Debug] DBMv4-Pull 0 Tenebron 20220806121300 100 20221004114721 20220805000000 IEEU:3:", -- [125]
-- "<15.30 22:46:09> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args::boss1:1:1:1:Tenebron:30452:0xF1300076F4000109:worldboss:1337325:boss2:nil:nil:nil:??:1:nil:normal:0:boss3:nil:nil:nil:??:1:nil:normal:0:boss4:nil:nil:nil:??:1:nil:normal:0:boss5:nil:nil:nil:??:1:nil:normal:0:Real Args::", -- [126]
-- "<15.30 22:46:09> [CLEU] SPELL_CAST_SUCCESS:0xF1300076F300010A:Shadron:0x0000000000000000:nil:58105:Power of Shadron:nil:nil:", -- [127]
-- "<15.30 22:46:09> [DBM_Debug] INSTANCE_ENCOUNTER_ENGAGE_UNIT event fired for zoneId532:3:", -- [128]
-- "<15.30 22:46:09> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args::boss1:1:1:1:Tenebron:30452:0xF1300076F4000109:worldboss:1337325:boss2:1:1:1:Shadron:30451:0xF1300076F300010A:worldboss:1337325:boss3:nil:nil:nil:??:1:nil:normal:0:boss4:nil:nil:nil:??:1:nil:normal:0:boss5:nil:nil:nil:??:1:nil:normal:0:Real Args::", -- [129]
-- "<15.30 22:46:09> [DBM_Debug] INSTANCE_ENCOUNTER_ENGAGE_UNIT event fired for zoneId532:3:", -- [130]
-- "<15.30 22:46:09> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args::boss1:1:1:1:Tenebron:30452:0xF1300076F4000109:worldboss:1337325:boss2:1:1:1:Shadron:30451:0xF1300076F300010A:worldboss:1337325:boss3:1:1:1:Vesperon:30449:0xF1300076F100010B:worldboss:1337325:boss4:nil:nil:nil:??:1:nil:normal:0:boss5:nil:nil:nil:??:1:nil:normal:0:Real Args::", -- [131]
-- "<15.30 22:46:09> [UNIT_SPELLCAST_SUCCEEDED] Vesperon(??) -Power of Vesperon- [[boss3:Power of Vesperon::0:]]", -- [132]
-- "<15.30 22:46:09> [CLEU] SPELL_CAST_SUCCESS:0xF1300076F100010B:Vesperon:0x0000000000000000:nil:61251:Power of Vesperon:nil:nil:", -- [133]
-- "<15.30 22:46:09> [UNIT_SPELLCAST_SUCCEEDED] Sartharion(Sanarticon) -Will of Sartharion- [[target:Will of Sartharion::0:]]", -- [134]
-- "<15.30 22:46:09> [CLEU] SPELL_CAST_SUCCESS:0xF1300070BC000062:Sartharion:0x0000000000000000:nil:61254:Will of Sartharion:nil:nil:", -- [135]
-- "<15.30 22:46:09> [DBM_Debug] INSTANCE_ENCOUNTER_ENGAGE_UNIT event fired for zoneId532:3:", -- [136]
-- "<15.30 22:46:09> [DBM_Debug] StartCombat called by : IEEU for mod : Sartharion. LastInstanceMapID is 532:nil:", -- [137]
-- "<15.30 22:46:09> [DBM_Pull] Sartharion:0:nil:100:", -- [138]
-- "<15.30 22:46:09> [DBM_TimerStart] Timer43113next:Next Fire Wall:30:Interface\\Icons\\Spell_Fire_MoltenBlood:next:43113:2:Sartharion:nil:nil:Fire Wall:nil:", -- [139]
-- "<15.30 22:46:09> [DBM_TimerStart] Timer58956cd:Flame Breath CD:10:Interface\\Icons\\Spell_Fire_Fire:cd:58956:5:Sartharion:nil:nil:Flame Breath:nil:", -- [140]
-- "<15.30 22:46:09> [DBM_Debug] DBMv4-Pull 0 Sartharion 20220925145940 100 20221004114721 0 IEEU:3:", -- [141]
-- "<15.30 22:46:09> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args::boss1:1:1:1:Sartharion:28860:0xF1300070BC000062:worldboss:4392675:boss2:1:1:1:Tenebron:30452:0xF1300076F4000109:worldboss:1337325:boss3:1:1:1:Shadron:30451:0xF1300076F300010A:worldboss:1337325:boss4:1:1:1:Vesperon:30449:0xF1300076F100010B:worldboss:1337325:boss5:nil:nil:nil:??:1:nil:normal:0:Real Args::", -- [142]
mod:RegisterCombat("yell", L.YellSarthPull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 56908 58956",
	"SPELL_CAST_SUCCESS 57579 59127",
	"SPELL_AURA_APPLIED 57491",
	"SPELL_DAMAGE 59128",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnShadowFissure			= mod:NewSpellAnnounce(59127, 4, nil, nil, nil, nil, nil, 2)
local warnBreathSoon			= mod:NewSoonAnnounce(58956, 2, nil, "Tank|Healer")
local warnTenebron				= mod:NewAnnounce("WarningTenebron", 2, 61248)
local warnShadron				= mod:NewAnnounce("WarningShadron", 2, 58105)
local warnVesperon				= mod:NewAnnounce("WarningVesperon", 2, 61251)
local warnTenebronWhelpsSoon	= mod:NewAnnounce("WarningWhelpsSoon", 1, 1022, false)
local warnShadronPortalSoon		= mod:NewAnnounce("WarningPortalSoon", 1, 11420, false)
local warnVesperonPortalSoon	= mod:NewAnnounce("WarningReflectSoon", 1, 57988, false)

local specWarnFireWall			= mod:NewSpecialWarning("WarningFireWall", nil, nil, nil, 2, 2)
local specWarnVesperonPortal	= mod:NewSpecialWarning("WarningVesperonPortal", false, nil, nil, 1, 7)
local specWarnTenebronPortal	= mod:NewSpecialWarning("WarningTenebronPortal", false, nil, nil, 1, 7)
local specWarnShadronPortal		= mod:NewSpecialWarning("WarningShadronPortal", false, nil, nil, 1, 7)

local timerShadowFissure		= mod:NewCastTimer(5, 59128, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON) --Cast timer until Void Blast. it's what happens when shadow fissure explodes.
local timerBreath				= mod:NewCDTimer(10, 58956, nil, "Tank|Healer", nil, 5) -- REVIEW! ~1s variance? (25N Lordaeron 2022/09/23) - 10.4, 11.4, 10.4, 10.1
local timerWall					= mod:NewNextTimer(30, 43113, nil, nil, nil, 2) -- (25N Lordaeron 2022/09/23) - pull:30.0, 30.0
local timerTenebron				= mod:NewTimer(30, "TimerTenebron", 61248, nil, nil, 1)
local timerShadron				= mod:NewTimer(80, "TimerShadron", 58105, nil, nil, 1)
local timerVesperon				= mod:NewTimer(120, "TimerVesperon", 61251, nil, nil, 1)
local timerTenebronWhelps		= mod:NewTimer(60, "TimerTenebronWhelps", 1022)
local timerShadronPortal		= mod:NewTimer(94, "TimerShadronPortal", 11420)
local timerVesperonPortal		= mod:NewTimer(139, "TimerVesperonPortal", 57988)
local timerVesperonPortal2		= mod:NewTimer(199, "TimerVesperonPortal2", 57988) -- what's the purpose of this?

mod:AddBoolOption("AnnounceFails", true, "announce")

mod:GroupSpells(59127, 59128)--Shadow fissure with void blast

local lastvoids = {}
local lastfire = {}
local tsort, tinsert, twipe = table.sort, table.insert, table.wipe

local function isunitdebuffed(spellName)
	for uId in DBM:GetGroupMembers() do
		local debuff = DBM:UnitDebuff(uId, spellName)
		if debuff then
			return true
		end
	end
	return false
end

local function CheckDrakes(self, delay)
	if self.Options.HealthFrame then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(28860, "Sartharion")
	end
	if isunitdebuffed(DBM:GetSpellInfo(61248)) then	-- Power of Tenebron
		timerTenebron:Start(26 - delay) -- 30
		warnTenebron:Schedule(21 - delay) -- 25
		timerTenebronWhelps:Start(- delay)
		warnTenebronWhelpsSoon:Schedule(55 - delay)
		if self.Options.HealthFrame then
			DBM.BossHealth:AddBoss(30452, "Tenebron")
		end
	end
	if isunitdebuffed(DBM:GetSpellInfo(58105)) then	-- Power of Shadron
		timerShadron:Start(74 - delay) -- 75
		warnShadron:Schedule(69 - delay) -- 70
		timerShadronPortal:Start(- delay)
		warnShadronPortalSoon:Schedule(89 - delay)
		if self.Options.HealthFrame then
			DBM.BossHealth:AddBoss(30451, "Shadron")
		end
	end
	if isunitdebuffed(DBM:GetSpellInfo(61251)) then	-- Power of Vesperon
		timerVesperon:Start(119 - delay) -- 120
		warnVesperon:Schedule(114 - delay) -- 115
		timerVesperonPortal:Start(- delay)
		timerVesperonPortal2:Start(- delay)
		warnVesperonPortalSoon:Schedule(134 - delay)
		warnVesperonPortalSoon:Schedule(194 - delay)
		if self.Options.HealthFrame then
			DBM.BossHealth:AddBoss(30449, "Vesperon")
		end
	end
end

local sortedFails = {}
local function sortFails1(e1, e2)
	return (lastvoids[e1] or 0) > (lastvoids[e2] or 0)
end
local function sortFails2(e1, e2)
	return (lastfire[e1] or 0) > (lastfire[e2] or 0)
end

function mod:OnCombatStart(delay)
	--Cache spellnames so a solo player check doesn't fail in CheckDrakes in 8.0+
	self:Schedule(5, CheckDrakes, self, delay)
	timerWall:Start(-delay)
	warnBreathSoon:Schedule(5-delay)
	timerBreath:Start(-delay) -- REVIEW! variance? (25N Lordaeron 2022/09/23) - pull:11.0

	twipe(lastvoids)
	twipe(lastfire)
end

function mod:OnCombatEnd()
	if not self.Options.AnnounceFails then return end
	if DBM:GetRaidRank() < 1 or not self.Options.Announce then return end

	local voids = ""
	for k, _ in pairs(lastvoids) do
		tinsert(sortedFails, k)
	end
	tsort(sortedFails, sortFails1)
	for _, v in ipairs(sortedFails) do
		voids = voids.." "..v.."("..(lastvoids[v] or "")..")"
	end
	SendChatMessage(L.VoidZones:format(voids), "RAID")
	twipe(sortedFails)
	local fire = ""
	for k, _ in pairs(lastfire) do
		tinsert(sortedFails, k)
	end
	tsort(sortedFails, sortFails2)
	for _, v in ipairs(sortedFails) do
		fire = fire.." "..v.."("..(lastfire[v] or "")..")"
	end
	SendChatMessage(L.FireWalls:format(fire), "RAID")
	twipe(sortedFails)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(56908, 58956) then -- Flame breath
		warnBreathSoon:Schedule(5)
		timerBreath:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(57579, 59127) then
		warnShadowFissure:Show()
		warnShadowFissure:Play("watchstep")
		timerShadowFissure:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if self.Options.AnnounceFails and self.Options.Announce and args.spellId == 57491 and DBM:GetRaidRank() >= 1 and DBM:GetRaidUnitId(args.destName) ~= "none" and args.destName then
		lastfire[args.destName] = (lastfire[args.destName] or 0) + 1
		SendChatMessage(L.FireWallOn:format(args.destName), "RAID")
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destName, _, spellId)
	if self.Options.AnnounceFails and self.Options.Announce and spellId == 59128 and DBM:GetRaidRank() >= 1 and DBM:GetRaidUnitId(destName) ~= "none" and destName then
		lastvoids[destName] = (lastvoids[destName] or 0) + 1
		SendChatMessage(L.VoidZoneOn:format(destName), "RAID")
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, mob)
	if msg == L.Wall or msg:find(L.Wall) then
		self:SendSync("FireWall")
	elseif msg == L.Portal or msg:find(L.Portal) then
		if mob == L.NameVesperon then
			self:SendSync("VesperonPortal")
		elseif mob == L.NameTenebron then
			self:SendSync("TenebronPortal")
		elseif mob == L.NameShadron then
			self:SendSync("ShadronPortal")
		end
	end
end
mod.CHAT_MSG_MONSTER_EMOTE = mod.CHAT_MSG_RAID_BOSS_EMOTE

function mod:OnSync(event)
	if event == "FireWall" then
		timerWall:Start()
		specWarnFireWall:Show()
		specWarnFireWall:Play("watchwave")
	elseif event == "VesperonPortal" then
		specWarnVesperonPortal:Show()
		specWarnVesperonPortal:Play("newportal")
	elseif event == "TenebronPortal" then
		specWarnTenebronPortal:Show()
		specWarnTenebronPortal:Play("newportal")
	elseif event == "ShadronPortal" then
		specWarnShadronPortal:Show()
		specWarnShadronPortal:Play("newportal")
	end
end
