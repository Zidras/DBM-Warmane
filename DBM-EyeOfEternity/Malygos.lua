local mod	= DBM:NewMod("Malygos", "DBM-EyeOfEternity")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(28859)
mod:SetEncounterID(734)

--mod:RegisterCombat("yell", L.YellPull)
mod:RegisterCombat("combat")
mod:SetWipeTime(45)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 60936 57407 55853",
	"SPELL_CAST_START 56505",
	"SPELL_CAST_SUCCESS 56105 57430",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)
-- General
local enrageTimer				= mod:NewBerserkTimer(615)
local timerAchieve				= mod:NewAchievementTimer(360, 1875)

-- Stage One
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1))
local warnSummonPowerSpark		= mod:NewSpellAnnounce(56140, 2, 59381)
local warnVortex				= mod:NewSpellAnnounce(56105, 3)
local warnVortexSoon			= mod:NewSoonAnnounce(56105, 2)

local timerSummonPowerSpark		= mod:NewNextTimer(30, 56140, nil, nil, nil, 1, 59381, DBM_COMMON_L.DAMAGE_ICON)
local timerVortex				= mod:NewCastTimer(10, 56105, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerVortexCD				= mod:NewNextTimer(64, 56105, nil, nil, nil, 2)

-- Stage Two
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2))
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnBreathInc				= mod:NewSoonAnnounce(56505, 3)

local specWarnBreath			= mod:NewSpecialWarningSpell(56505, nil, nil, nil, 2, 2)

local timerBreath				= mod:NewBuffActiveTimer(8, 56505, nil, nil, nil, 5) --lasts 5 seconds plus 3 sec cast.
local timerBreathCD				= mod:NewCDTimer(60, 56505, nil, nil, nil, 2)
local timerIntermission			= mod:NewPhaseTimer(20)

-- Stage Three
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(3))
local warnPhase3				= mod:NewPhaseAnnounce(3)
local warnSurge					= mod:NewTargetAnnounce(60936, 3)
local warnStaticField			= mod:NewTargetNoFilterAnnounce(57430, 3)

local specWarnSurge				= mod:NewSpecialWarningDefensive(60936, nil, nil, nil, 1, 2)
local specWarnP3SurgeOfPowerSoon= mod:NewSpecialWarningYou(60936, nil, nil, nil, 1, 2)
local specWarnStaticField		= mod:NewSpecialWarningYou(57430, nil, nil, nil, 1, 2)
local specWarnStaticFieldNear	= mod:NewSpecialWarningClose(57430, nil, nil, nil, 1, 2)
local yellStaticField			= mod:NewYellMe(57430)

local timerStaticFieldCD		= mod:NewCDTimer(10, 57430, nil, nil, nil, 3, nil, nil, true)

local tableBuild = false
local guids = {}

local function buildGuidTable()
	table.wipe(guids)
	for uId in DBM:GetGroupMembers() do
		local name, server = UnitName(uId)
		local fullName = name .. (server and server ~= "" and ("-" .. server) or "")
		guids[UnitGUID(uId.."pet") or "none"] = fullName
	end
	tableBuild = true
end

function mod:StaticFieldTarget()
	local targetname, uId = self:GetBossTarget(28859)
	if not targetname or not uId then return end
	local targetGuid = UnitGUID(uId)
	if not tableBuild then
		buildGuidTable()
	end
	local announcetarget = guids[targetGuid]
	if announcetarget == UnitName("player") then
		specWarnStaticField:Show()
		specWarnStaticField:Play("runaway")
		yellStaticField:Yell()
	elseif announcetarget and self:CheckNearby(13, announcetarget) then
		specWarnStaticFieldNear:Show(announcetarget)
		specWarnStaticFieldNear:Play("runaway")
	else
		warnStaticField:Show(announcetarget)
	end
end

function mod:OnCombatStart(delay)
	tableBuild = false
	self:SetStage(1)
	enrageTimer:Start(-delay)
	timerAchieve:Start(-delay)
	timerVortexCD:Start(38.7)
	timerSummonPowerSpark:Start(29-delay)
	table.wipe(guids)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(60936, 57407) then
		DBM:Debug("SURGE" .. guids[args.destGUID], 2)
		local target = guids[args.destGUID or 0]
		if target then
			warnSurge:CombinedShow(0.5, target)
			if target == UnitName("player") then
				specWarnSurge:Show()
				specWarnSurge:Play("defensive")
			end
		end
	elseif args.spellId == 55853 and self:AntiSpam(2, 1) then
		timerVortexCD:Start()
		warnVortexSoon:Schedule(60)
		warnVortex:Show()
		timerVortex:Start()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if self:GetCIDFromGUID(args.sourceGUID) == 28859 then
		DBM:Debug("SCStart " .. spellId .. GetSpellLink(spellId) , 2)
	end
	if spellId == 56505 then--His deep breath
		specWarnBreath:Show()
		specWarnBreath:Play("findshield")
		timerBreath:Start()
		timerBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if self:GetCIDFromGUID(args.sourceGUID) == 28859 then
		DBM:Debug("SCSuccess " .. spellId .. GetSpellLink(spellId) , 2)
	end
	if spellId == 57430 then
		self:ScheduleMethod(0.1, "StaticFieldTarget")
		DBM:Debug("Champ Statique detecté, merci de reporter sur le Discord DBM Way of Elendil.")
		--warnStaticField:Show()
		--timerStaticFieldCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	--Secondary pull trigger, so we can detect combat when he's pulled while already in combat (which is about 99% of time)
	if (msg == L.YellPull or msg:find(L.YellPull)) and not self:IsInCombat() then
		DBM:StartCombat(self, 0)
	elseif msg:sub(0, L.YellPhase2:len()) == L.YellPhase2 then
		self:SendSync("Phase2")
	elseif msg == L.YellBreath or msg:find(L.YellBreath) then
		self:SendSync("BreathSoon")
	elseif msg:sub(0, L.YellPhase3:len()) == L.YellPhase3 then
		self:SendSync("Phase3")
	elseif msg == L.EnoughScream then
		timerBreathCD:Stop()
		timerStaticFieldCD:Start(24+15.5)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteSpark or msg:find(L.EmoteSpark) then
		self:SendSync("Spark")
	elseif msg == L.EmoteSurge or msg:find(L.EmoteSurge) then
		self:SendSync("MalygosSurge", UnitName("player"))
	end
end

function mod:OnSync(event, arg)
	if not self:IsInCombat() then return end
	if event == "Spark" then
		warnSummonPowerSpark:Show()
		timerSummonPowerSpark:Start()
	elseif event == "Phase2" then
		self:SetStage(2)
		timerSummonPowerSpark:Cancel()
		timerVortexCD:Cancel()
		warnVortexSoon:Cancel()
		warnPhase2:Show()
		timerIntermission:Start()
		timerBreathCD:Start(67)
	elseif event == "BreathSoon" then
		warnBreathInc:Show()
	elseif event == "Phase3" then
		self:SetStage(3)
		warnPhase3:Show()
		self:Schedule(6, buildGuidTable)
		timerBreathCD:Cancel()
		--timerStaticFieldCD:Start(20.2) -- StaticField bugué sur Way of Elendil, aucun trigger disponible
	elseif event == "MalygosSurge" then
		warnSurge:CombinedShow(0.2, arg)
		if arg == UnitName("player") then
			specWarnP3SurgeOfPowerSoon:Show()
			specWarnP3SurgeOfPowerSoon:Play("findshield")
		end
	end
end
