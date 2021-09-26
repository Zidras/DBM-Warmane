local mod = DBM:NewMod(547, "DBM-Party-BC", 10, 253)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(18708)

mod:SetModelID(18839)
mod:SetModelScale(0.05)
mod:SetModelOffset(10, -2, 0)
mod:SetUsedIcons(8)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 33711",
	"SPELL_AURA_REMOVED 33711",
	"SPELL_CAST_START 33923 38796"
)

local warnTouch         = mod:NewTargetAnnounce(33711, 3)

local specWarnBoom		= mod:NewSpecialWarningRun(33923, nil, nil, nil, 4, 2)
local specWarnTouch		= mod:NewSpecialWarningMoveAway(33711, nil, nil, nil, 1, 2)

local timerBoomCast     = mod:NewCastTimer(5, 33923, nil, nil, nil, 2)
local timerTouch        = mod:NewTargetTimer(14, 33711, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnTouchTarget", 33711, true, false, {8})

function mod:SPELL_CAST_START(args)
	if args.spellId == 33923 or args.spellId == 38796 then
		specWarnBoom:Show()
		specWarnBoom:Play("justrun")
		timerBoomCast:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 33711 then
		timerTouch:Start(args.destName)
		if self.Options.SetIconOnTouchTarget then
			self:SetIcon(args.destName, 8, 14)
		end
		if args:IsPlayer() then
            specWarnTouch:Show()
            specWarnTouch:Play("runout")
        else
			warnTouch:Show(args.destName)
        end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 33711 then
		timerTouch:Stop(args.destName)
		if self.Options.SetIconOnTouchTarget then
			self:SetIcon(args.destName, 0)
		end
	end
end
