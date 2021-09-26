local mod	= DBM:NewMod("Zarithrian", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4380 $"):sub(12, -3))
mod:SetCreatureID(39746)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"CHAT_MSG_MONSTER_YELL"
)

local warningAdds				= mod:NewAnnounce("WarnAdds", 3, 74398)
local warnCleaveArmor			= mod:NewStackAnnounce(74367, 2, nil, "Tank|Healer")
local warnFearSoon              = mod:NewSoonAnnounce(74384, 2, nil, nil, nil, nil, nil, 2)

local specWarnFear				= mod:NewSpecialWarningSpell(74384, nil, nil, nil, 2, 2)
local specWarnCleaveArmor		= mod:NewSpecialWarningStack(74367, nil, 2, nil, nil, 1, 6)--ability lasts 30 seconds, has a 15 second cd, so tanks should trade at 2 stacks.

local timerAddsCD				= mod:NewTimer(40, "TimerAdds", 74398, nil, nil, 1)
local timerAddsTravel			= mod:NewTimer(10, "AddsArrive") -- Timer to indicate when the summoned adds arive
local timerCleaveArmor			= mod:NewTargetTimer(30, 74367, nil, "Tank|Healer", nil, 5)
local timerFearCD				= mod:NewCDTimer(30, 74384, nil, nil, nil, 2)

mod:AddBoolOption("CancelBuff")
local CleaveArmorTargets = {}

function mod:OnCombatStart(delay)
    timerFearCD:Start(14-delay)
    warnFearSoon:ScheduleVoice(11, "fearsoon") -- 3 secs prewarning
    timerAddsCD:Start(18-delay)
end

function mod:OnCombatEnd()
    table.wipe(CleaveArmorTargets)
end

function mod:SPELL_CAST_START(args)
    if args.spellId == 74384 then
        specWarnFear:Show()
        warnFearSoon:ScheduleVoice(27, "fearsoon") -- 3 secs prewarning
        timerFearCD:Start()
    end
end

function mod:SPELL_AURA_APPLIED(args)
    if args.spellId == 74367 then
		if self.Options.CancelBuff and not tContains(CleaveArmorTargets, args.destName) then
			CleaveArmorTargets[#CleaveArmorTargets+1] = args.destName
        end
		local amount = args.amount or 1
        timerCleaveArmor:Start(args.destName)
        if args:IsPlayer() and amount >= 2 then
            specWarnCleaveArmor:Show(amount)
            specWarnCleaveArmor:Play("stackhigh")
        else
            warnCleaveArmor:Show(args.destName, amount)
        end
    elseif (args.spellId == 10278 or args.spellId == 642) and self.Options.CancelBuff and self:IsInCombat() and args:IsPlayer() and #CleaveArmorTargets > 0 then
		for i = 1, #CleaveArmorTargets do
			local targetName = CleaveArmorTargets[i]
			if targetName == DBM:GetMyPlayerInfo() then
				CancelUnitBuff("player", GetSpellInfo(10278))        -- Hand of Protection
				CancelUnitBuff("player", GetSpellInfo(642))        -- Divine Shield
				CleaveArmorTargets[i] = nil
			end
        end
    end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SummonMinions or msg:match(L.SummonMinions) then
		warningAdds:Show()
		timerAddsCD:Start()
		timerAddsTravel:Start() -- Added timer for travel time on summoned adds
	end
end