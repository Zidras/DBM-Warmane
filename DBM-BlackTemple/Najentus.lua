local mod	= DBM:NewMod("Najentus", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528_cafe20241008v2")
mod:SetCreatureID(22887)

mod:SetModelID(21174)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 39872 39837",
	"SPELL_AURA_REMOVED 39837"
)

local warnShield		= mod:NewSpellAnnounce(39872, 4)
local warnShieldSoon		= mod:NewSoonAnnounce(39872, 10, 3)
local warnSpine			= mod:NewTargetNoFilterAnnounce(39837, 3)

local specWarnSpineTank	= mod:NewSpecialWarningTaunt(39837, nil, nil, nil, 1, 2)
local yellSpine			= mod:NewYell(39837)

local timerShield		= mod:NewCDTimer(56+4, 39872, nil, nil, nil, 5) --corrected to 60s
local timerSpine		= mod:NewCDTimer(20, 39837, nil, nil, nil, 5) --added spine timer

local berserkTimer		= mod:NewBerserkTimer(300+180) --corrected to be 8m

mod:AddSetIconOption("SpineIcon", 39837)
mod:AddInfoFrameOption(39878, true)
mod:AddRangeFrameOption("8")

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerShield:Start(55.5+4.5-delay) --timer correction
	timerSpine:Start(21-delay) --added spinetimer
	warnShieldSoon:Schedule(50+5-delay) --timer correction
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	if self.Options.InfoFrame and not self:IsTrivial() then
		DBM.InfoFrame:SetHeader(L.HealthInfo)
		DBM.InfoFrame:Show(5, "health", 8500)
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
	if args.spellId == 39872 then
		warnShield:Show()
		warnShieldSoon:Schedule(50+5) --corrected to 5s before 1m
		timerShield:Start()
		timerSpine:AddTime(10) --corrected for delayall
	elseif args.spellId == 39837 then
		warnSpine:Show(args.destName)
		timerSpine:Start()
		if self.Options.SpineIcon then
			self:SetIcon(args.destName, 8)
		end
		if args:IsPlayer() then
			yellSpine:Yell()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if self:IsTanking(uId) then--Tank got spike and it wasn't us
				--Taunt off spiked tank
				specWarnSpineTank:Show(args.destName)
				specWarnSpineTank:Play("tauntboss")
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 39837 and self.Options.SpineIcon then
		self:SetIcon(args.destName, 0)
	end
end
