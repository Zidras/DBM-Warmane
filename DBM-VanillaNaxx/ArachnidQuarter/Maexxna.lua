local mod	= DBM:NewMod("Maexxna-Vanilla", "DBM-VanillaNaxx", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240701222429")
mod:SetCreatureID(15952)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 28622",
	"SPELL_CAST_SUCCESS 29484 54125"
)

--TODO, verify nax40 web wrap timer
local warnWebWrap		= mod:NewTargetNoFilterAnnounce(28622, 2)
local warnWebSpraySoon	= mod:NewSoonAnnounce(29484, 1)
local warnWebSprayNow	= mod:NewSpellAnnounce(29484, 3)
local warnSpidersSoon	= mod:NewAnnounce("WarningSpidersSoon", 2, 17332)
local warnSpidersNow	= mod:NewAnnounce("WarningSpidersNow", 4, 17332)

local specWarnWebWrap	= mod:NewSpecialWarningSwitch(28622, "RangedDps", nil, nil, 1, 2)
local yellWebWrap		= mod:NewYellMe(28622)

local timerWebSpray		= mod:NewNextTimer(40, 29484, nil, nil, nil, 2)
local timerWebWrap		= mod:NewNextTimer(39.6, 28622, nil, "RangedDps|Healer", nil, 3)-- 39.593-40.885
local timerSpider		= mod:NewTimer(30, "TimerSpider", 17332, nil, nil, 1)

local function Spiderlings(self)
	warnSpidersSoon:Schedule(35)
	warnSpidersNow:Schedule(40)
	timerSpider:Start(40)
	self:Unschedule(Spiderlings)
	self:Schedule(40, Spiderlings, self)
end

function mod:OnCombatStart(delay)
	warnWebSpraySoon:Schedule(35 - delay)
	timerWebSpray:Start(40 - delay)
	timerWebWrap:Start(20.1 - delay)--20.095-21.096
	warnSpidersSoon:Schedule(25 - delay)
	warnSpidersNow:Schedule(30 - delay)
	timerSpider:Start(30 - delay)
	self:Schedule(30 - delay, Spiderlings, self)
end

function mod:OnCombatEnd(wipe)
	if not wipe then
		if DBT:GetBar(L.ArachnophobiaTimer) then
			DBT:CancelBar(L.ArachnophobiaTimer)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 28622 then -- Web Wrap
		warnWebWrap:CombinedShow(0.5, args.destName)
		if args.destName == UnitName("player") then
			yellWebWrap:Yell()
		elseif not DBM:UnitDebuff("player", args.spellName) and self:AntiSpam(3, 1) then
			specWarnWebWrap:Show()
			specWarnWebWrap:Play("targetchange")
			timerWebWrap:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(29484, 54125) then -- Web Spray
		warnWebSprayNow:Show()
		warnWebSpraySoon:Schedule(35)
		timerWebSpray:Start()
	end
end
