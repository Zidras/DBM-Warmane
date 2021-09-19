local mod	= DBM:NewMod("Lethon", "DBM-Azeroth")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(14888)--121821 TW ID, 14888 classic ID
--mod:SetModelID(17887)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors

mod:RegisterCombat("yell", L.Pull)


mod:RegisterEventsInCombat(
--	"SPELL_CAST_START 24818 243468",
	"SPELL_CAST_SUCCESS 24814 24813"
--	"SPELL_AURA_APPLIED 243401",
--	"SPELL_AURA_APPLIED_DOSE 243401"
)

--TODO, maybe taunt special warnings for classic version when it matters more.
--TODO, needs valid spellIds for Classic
local warnNoxiousBreath			= mod:NewStackAnnounce(24818, 2, nil, "Tank", 2)

local specWarnSleepingFog		= mod:NewSpecialWarningDodge(24814, nil, nil, nil, 2, 2)
--local specWarnShadowBoltWhirl	= mod:NewSpecialWarningDodge(243468, nil, nil, nil, 2, 2)

--local timerNoxiousBreathCD		= mod:NewCDTimer(18.3, 24818, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--Iffy
local timerSleepingFogCD		= mod:NewCDTimer(16.8, 24814, nil, nil, nil, 3)
--local timerShadowBoltWhirlCD	= mod:NewCDTimer(15.8, 243468, nil, nil, nil, 3)

--mod:AddReadyCheckOption(48620, false)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		--timerNoxiousBreathCD:Start(11.9-delay)
		--timerSleepingFogCD:Start(18.4-delay)
	end
end

--[[
function mod:SPELL_CAST_START(args)
	if args.spellId == 24818 then
		--timerNoxiousBreathCD:Start()
	elseif args.spellId == 243468 and self:AntiSpam(5, 1) then
		--specWarnShadowBoltWhirl:Show()
		--specWarnShadowBoltWhirl:Play("watchorb")
		--timerShadowBoltWhirlCD:Start()
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
		if self:IsTanking(nil, nil, args.destName, nil, args.sourceGUID) then--Basically, HAS to be bosses current target
			warnNoxiousBreath:Show(args.destName, args.amount or 1)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
