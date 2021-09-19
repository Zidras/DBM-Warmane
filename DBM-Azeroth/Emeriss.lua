local mod	= DBM:NewMod("Emeriss", "DBM-Azeroth")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(14889)--121913 TW ID, 14889 classic ID
--mod:SetModelID(17887)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors

mod:RegisterCombat("yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 24814 24813 24818",
	"SPELL_AURA_APPLIED 24818",
	"SPELL_AURA_APPLIED_DOSE 24818"
)

--TODO, maybe taunt special warnings for classic version when it matters more.
--TODO, Needs valid spellIDs for Classic
local warnNoxiousBreath			= mod:NewStackAnnounce(24818, 2, nil, "Tank", 2)

local specWarnSleepingFog		= mod:NewSpecialWarningDodge(24814, nil, nil, nil, 2, 2)
--local specWarnMushroom			= mod:NewSpecialWarningYou(243451, nil, nil, nil, 1, 2)

--local timerNoxiousBreathCD		= mod:NewCDTimer(18.3, 24818, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--Iffy
local timerSleepingFogCD		= mod:NewCDTimer(15.8, 24814, nil, nil, nil, 3)

--mod:AddReadyCheckOption(48620, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerNoxiousBreathCD:Start(11.9-delay)--13
		timerSleepingFogCD:Start(18.4-delay)--19.2
	end
end

--[[
function mod:SPELL_CAST_START(args)
	if args.spellId == 243401 and self:AntiSpam(3, 1) then
		timerNoxiousBreathCD:Start()
	end
end
--]]

function mod:SPELL_CAST_SUCCESS(args)
	--if args.spellId == 24814 or args.spellId == 24813 then
	if args.spellId == 24814 then
		specWarnSleepingFog:Show()
		specWarnSleepingFog:Play("watchstep")
		timerSleepingFogCD:Start()
	--elseif args.spellId == 24818 and self:AntiSpam(3, 1) then
		--timerNoxiousBreathCD
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 24818 then
		if self:IsTanking(nil, nil, args.destName, nil, args.sourceGUID) then
			warnNoxiousBreath:Show(args.destName, args.amount or 1)
		end
	--elseif args.spellId == 243451 then
		--9.7-20 second timer
		--if args:IsPlayer() then
		--	specWarnMushroom:Show()
		--	specWarnMushroom:Play("targetyou")
		--end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
