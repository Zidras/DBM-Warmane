local mod	= DBM:NewMod(574, "DBM-Party-BC", 6, 261)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(17796)

mod:SetModelID(18638)
mod:SetModelOffset(-10, 0, 1)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 35107",
	"SPELL_AURA_REMOVED 35107",
	"CHAT_MSG_MONSTER_YELL"
)

local WarnNet			= mod:NewTargetAnnounce(35107, 2)

local specWarnSummon	= mod:NewSpecialWarning("warnSummon", "-Healer", nil, nil, 1, 2)

local timerNet			= mod:NewTargetTimer(6, 35107, nil, nil, nil, 3)

local enrageTimer		= mod:NewBerserkTimer(300)

function mod:OnCombatStart(delay)
	if self:IsHeroic() then
		enrageTimer:Start(-delay)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 35107 then
		WarnNet:Show(args.destName)
		timerNet:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 35107 then
		timerNet:Stop(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Mechs then		-- Adds
		specWarnSummon:Show()
		specWarnSummon:Play("killmob")
	end
end
