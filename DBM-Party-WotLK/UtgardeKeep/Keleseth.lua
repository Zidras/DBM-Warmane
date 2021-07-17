local mod	= DBM:NewMod("Keleseth", "DBM-Party-WotLK", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(23953)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterCombat("yell", "Ваша кровь принадлежит мне!")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_DAMAGE"
)

local warningTomb	= mod:NewTargetAnnounce(48400, 4)
local timerTomb		= mod:NewTargetTimer(17, 48400)
local timerTombCD	= mod:NewCDTimer(17, 48400)
local specwarnWell  = mod:NewSpecialWarningMove(70323)

function mod:OnCombatStart()
	timerTombCD:Start(17)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48400 then
		warningTomb:Show(args.destName)
		timerTomb:Start(args.destName)
		timerTombCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 48400 then
		timerTomb:Cancel()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(70323) and args:IsPlayer() and self:AntiSpam(0.5) then
		specwarnWell:Show()
	end
end
