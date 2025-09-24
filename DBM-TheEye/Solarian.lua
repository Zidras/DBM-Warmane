local mod	= DBM:NewMod("Solarian", "DBM-TheEye")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(18805)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 42783 33045",
	"SPELL_AURA_REMOVED 42783 33045",
	"SPELL_CAST_START 37135",
	"CHAT_MSG_MONSTER_YELL"
)

local warnWrath			= mod:NewTargetNoFilterAnnounce(33045, 2)--42783 used later
local warnSplit			= mod:NewAnnounce("WarnSplit", 4, 39414)
local warnAgent			= mod:NewAnnounce("WarnAgent", 1, 39414)
local warnPriest		= mod:NewAnnounce("WarnPriest", 1, 39414)
local warnPhase2		= mod:NewPhaseAnnounce(2)

local specWarnDomination= mod:NewSpecialWarningInterrupt(37135, "HasInterrupt", nil, 2, 1, 2)
local specWarnWrath		= mod:NewSpecialWarningMoveAway(42783, nil, nil, nil, 1, 2)
local yellWrath			= mod:NewYell(42783)

local timerWrath		= mod:NewTargetTimer(8, 33045)--42783 (and 6 seconds) later
local timerSplit		= mod:NewTimer(90, "TimerSplit", 39414, nil, nil, 6)
local timerAgent		= mod:NewTimer(4, "TimerAgent", 39414, nil, nil, 1)
local timerPriest		= mod:NewTimer(20, "TimerPriest", 39414, nil, nil, 1)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, 33045)--Range may be larger pre nerf. it was 8 post nerf
mod:AddSetIconOption("WrathIcon", 33045, true, false, {8})--42783 used later
mod:AddInfoFrameOption(33044)

function mod:OnCombatStart(delay)
	timerSplit:Start(50-delay)
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(33044))
		DBM.InfoFrame:Show(10, "playerdebuffremaining", 33044)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 42783 or spellId == 33045 then
		timerWrath:Start(args.destName)
		if args:IsPlayer() then
			specWarnWrath:Show()
			specWarnWrath:Play("runout")
			yellWrath:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		else
			warnWrath:Show(args.destName)
		end
		if self.Options.WrathIcon then
			self:SetIcon(args.destName, 8, 6)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 42783 or args.spellId == 33045 then
		timerWrath:Cancel(args.destName)
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
		if self.Options.WrathIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 37135 then
		specWarnDomination:Show(args.sourceName)
		specWarnDomination:Play("kickcast")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellSplit1 or msg:find(L.YellSplit1) or msg == L.YellSplit2 or msg:find(L.YellSplit2) then
		warnSplit:Show()
		timerAgent:Start()
		warnAgent:Schedule(4)
		timerPriest:Start()
		warnPriest:Schedule(20)
		timerSplit:Start()
	elseif msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		warnPhase2:Show()
		timerAgent:Cancel()
		warnAgent:Cancel()
		timerPriest:Cancel()
		warnPriest:Cancel()
		timerSplit:Cancel()
	end
end
