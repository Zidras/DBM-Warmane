local mod	= DBM:NewMod("Geddon", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(12056)

mod:SetModelID(12129)
mod:SetUsedIcons(8)


mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 20475 19659",
	"SPELL_AURA_REMOVED 20475",
	"SPELL_CAST_SUCCESS 19695 19659 20478 20475"
)

--[[
(ability.id = 19695 or ability.id = 19659 or ability.id = 20478) and type = "cast"
--]]
local warnInferno		= mod:NewSpellAnnounce(19695, 3)
local warnBomb			= mod:NewTargetNoFilterAnnounce(20475, 4)
local warnArmageddon	= mod:NewSpellAnnounce(20478, 3)

local specWarnBomb		= mod:NewSpecialWarningYou(20475, nil, nil, nil, 3, 2)
local yellBomb			= mod:NewYell(20475)
local yellBombFades		= mod:NewShortFadesYell(20475)
local specWarnInferno	= mod:NewSpecialWarningRun(19695, "Melee", nil, nil, 4, 2)
local specWarnIgnite	= mod:NewSpecialWarningDispel(19659, "RemoveMagic", nil, nil, 1, 2)

local timerInfernoCD	= mod:NewCDTimer(21, 19695, nil, nil, nil, 2)--21-27.9
local timerInferno		= mod:NewBuffActiveTimer(8, 19695, nil, nil, nil, 2)
local timerIgniteManaCD	= mod:NewCDTimer(27, 19659, nil, nil, nil, 2)--27-33
local timerBombCD		= mod:NewCDTimer(13.3, 20475, nil, nil, nil, 3)--13.3-18.3
local timerBomb			= mod:NewTargetTimer(8, 20475, nil, nil, nil, 3)
local timerArmageddon	= mod:NewCastTimer(8, 20478, nil, nil, nil, 2)

mod:AddSetIconOption("SetIconOnBombTarget", 20475, false, false, {8})

function mod:OnCombatStart(delay)
	--timerIgniteManaCD:Start(7-delay)--7-19, too much variation for first
	timerBombCD:Start(11-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 20475 then
		timerBomb:Start(args.destName)
		if self.Options.SetIconOnBombTarget then
			self:SetIcon(args.destName, 8)
		end
		if args:IsPlayer() then
			specWarnBomb:Show()
			specWarnBomb:Play("runout")
			if self:IsEvent() or not self:IsTrivial() then
				yellBomb:Yell()
				yellBombFades:Countdown(20475)
			end
		else
			warnBomb:Show(args.destName)
		end
	elseif args.spellId == 19659 and self:CheckDispelFilter() then
		specWarnIgnite:CombinedShow(0.3, args.destName)
		specWarnIgnite:ScheduleVoice(0.3, "helpdispel")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 20475 then
		timerBomb:Stop(args.destName)
		if self.Options.SetIconOnBombTarget then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			yellBombFades:Cancel()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 19695 then
		if self:IsEvent() or not self:IsTrivial() then
			specWarnInferno:Show()
			specWarnInferno:Play("aesoon")
		else
			warnInferno:Show()
		end
		timerInferno:Start()
		timerInfernoCD:Start()
	elseif args.spellId == 19659 and args:IsSrcTypeHostile() then
		--warnIgnite:Show()
		timerIgniteManaCD:Start()
	elseif args.spellId == 20478 then
		warnArmageddon:Show()
		timerArmageddon:Start()
	elseif args.spellId == 20475 then
		timerBombCD:Start()
	end
end
