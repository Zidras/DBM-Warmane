local mod	= DBM:NewMod("Leotheras", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(21215)

mod:SetModelID(20514)
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("combat")

--Not using RegisterEventsInCombat on purpose because it uses weird combat rules
mod:RegisterEvents(
	"UNIT_DIED"
)
mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 37640 37676 37749",
	"CHAT_MSG_MONSTER_YELL"
)

local warnPhase			= mod:NewAnnounce("WarnPhase", 2)
local warnDemon			= mod:NewTargetAnnounce(37676, 4)
local warnMC			= mod:NewTargetNoFilterAnnounce(37749, 4)
local warnPhase2		= mod:NewPhaseAnnounce(2, 2)

local specWarnWhirl		= mod:NewSpecialWarningRun(37640, nil, nil, nil, 4, 2)
local specWarnDemon		= mod:NewSpecialWarningYou(37676, nil, nil, nil, 1, 2)

local timerWhirlCD		= mod:NewCDTimer(27, 37640, nil, nil, nil, 2)
local timerWhirl		= mod:NewBuffActiveTimer(12, 37640, nil, nil, nil, 2)
local timerPhase		= mod:NewTimer(60, "TimerPhase", 39088, nil, nil, 6)
local timerDemonCD		= mod:NewCDTimer(23, 37676, nil, nil, nil, 6)
local timerDemon		= mod:NewBuffFadesTimer(30, 37676, nil, nil, nil, 6)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddSetIconOption("DemonIcon", 37676, false, false, {8, 7, 6, 5})

local warnDemonTargets = {}
local warnMCTargets = {}
mod.vb.binderKill = 0
mod.vb.demonIcon = 8
mod.vb.whirlCount = 0

local function humanWarns(self)
	self.vb.whirlCount = 0
	warnPhase:Show(L.Human)
	timerWhirlCD:Start(15)
	timerPhase:Start(nil, L.Demon)
end

local function showDemonTargets(self)
	warnDemon:Show(table.concat(warnDemonTargets, "<, >"))
	table.wipe(warnDemonTargets)
	self.vb.demonIcon = 8
	timerDemon:Start()
end

local function showMCTargets()
	warnMC:Show(table.concat(warnMCTargets, "<, >"))
	table.wipe(warnMCTargets)
end

function mod:OnCombatStart(delay)
	self.vb.demonIcon = 8
	self.vb.whirlCount = 0
	self:SetStage(1)
	table.wipe(warnMCTargets)
	table.wipe(warnDemonTargets)
	timerWhirlCD:Start(15)
	timerPhase:Start(60, L.Demon)
	berserkTimer:Start()
end

function mod:OnCombatEnd(delay)
	self.vb.binderKill = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 37640 then
		specWarnWhirl:Show()
		specWarnWhirl:Play("justrun")
		timerWhirl:Start()
		if self.vb.phase ~= 2 then
			self.vb.whirlCount = self.vb.whirlCount + 1
			if self.vb.whirlCount < 3 then
				timerWhirlCD:Start()
			end
		else
			timerWhirlCD:Start()
		end
	elseif args.spellId == 37676 then
		warnDemonTargets[#warnDemonTargets + 1] = args.destName
		self:Unschedule(showDemonTargets)
		if self.Options.DemonIcon then
			self:SetIcon(args.destName, self.vb.demonIcon)
			self.vb.demonIcon = self.vb.demonIcon - 1
		end
		if args:IsPlayer() then
			specWarnDemon:Show()
			specWarnDemon:Play("targetyou")
		end
		if #warnDemonTargets >= 5 then
			showDemonTargets(self)
		else
			self:Schedule(0.7, showDemonTargets, self)
		end
	elseif args.spellId == 37749 then
		warnMCTargets[#warnMCTargets + 1] = args.destName
		self:Unschedule(showMCTargets)
		self:Schedule(0.3, showMCTargets)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellDemon or msg:find(L.YellDemon) then
		warnPhase:Show(L.Demon)
		timerWhirl:Cancel()
		timerWhirlCD:Cancel()
		timerPhase:Cancel()
		timerDemonCD:Start()
		timerPhase:Start(nil, L.Human)
		self:Schedule(60, humanWarns, self)
	elseif msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		self:SetStage(2)
		self:Unschedule(humanWarns)
		timerPhase:Cancel()
		timerWhirl:Cancel()
		timerWhirlCD:Cancel()
		timerDemonCD:Cancel()
		warnPhase2:Show()
		timerWhirlCD:Start(22.5)
	end
end

--TODO, with ENCOUNTER_START this may not be needed anymore, but also have to make sure ES is in right place too, it wasn't on retail which is why this method exists
function mod:UNIT_DIED(args)
	local cId = self:GetCIDFromGUID(args.destGUID)
	if cId == 21806 then
		self.vb.binderKill = self.vb.binderKill + 1
		if self.vb.binderKill == 3 and not self:IsInCombat() then
			DBM:StartCombat(self, 0)
		end
	end
end
