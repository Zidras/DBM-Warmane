local mod = DBM:NewMod("Falric", "DBM-Party-WotLK", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(38112)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 72422 72453 72426 72452 72435",
	"SPELL_AURA_REMOVED 72422 72453 72426"
)

local warnFear					= mod:NewSpellAnnounce(72435, 3)
local warnImpendingDespair		= mod:NewTargetNoFilterAnnounce(72426, 3)
local warnQuiveringStrike		= mod:NewTargetNoFilterAnnounce(72422, 3)

local timerFear					= mod:NewBuffActiveTimer(4, 72452)
local timerImpendingDespair		= mod:NewTargetTimer(6, 72426, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerQuiveringStrike		= mod:NewTargetTimer(5, 72422, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(72422, 72453) then
		timerQuiveringStrike:Start(args.destName)
		warnQuiveringStrike:Show(args.destName)
	elseif args.spellId == 72426 then
		timerImpendingDespair:Start(args.destName)
		warnImpendingDespair:Show(args.destName)
	elseif args:IsSpellID(72452, 72435) and self:AntiSpam() then
		warnFear:Show()
		timerFear:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(72422, 72453) then
		timerQuiveringStrike:Cancel(args.destName)
	elseif args.spellId == 72426 then
		timerImpendingDespair:Cancel(args.destName)
	end
end
