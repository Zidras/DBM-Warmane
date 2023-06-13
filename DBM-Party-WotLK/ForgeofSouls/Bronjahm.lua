local mod	= DBM:NewMod("Bronjahm", "DBM-Party-WotLK", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220806222721")
mod:SetCreatureID(36497)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 68872",
	"SPELL_AURA_APPLIED 68839",
	"UNIT_HEALTH"
)

local warnSoulstormSoon		= mod:NewSoonAnnounce(68872, 2)
local warnCorruptSoul		= mod:NewTargetNoFilterAnnounce(68839, 4)

local specwarnSoulstorm		= mod:NewSpecialWarningSpell(68872, nil, nil, nil, 2, 2)
local specwarnCorruptedSoul	= mod:NewSpecialWarningMoveTo(68839, nil, nil, nil, 1, 7)

local timerSoulstormCast	= mod:NewCastTimer(4, 68872, nil, nil, nil, 2)

mod.vb.warned_preStorm = false

function mod:OnCombatStart()
	self.vb.warned_preStorm = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 68872 then							-- Soulstorm
		specwarnSoulstorm:Show()
		specwarnSoulstorm:Play("aesoon")
		timerSoulstormCast:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 68839 then							-- Corrupt Soul
		if args:IsPlayer() then
			specwarnCorruptedSoul:Show(DBM_COMMON_L.EDGE)
			specwarnCorruptedSoul:Play("runtoedge")
		else
			warnCorruptSoul:Show(args.destName)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warned_preStorm and self:GetUnitCreatureId(uId) == 36497 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.40 then
		self.vb.warned_preStorm = true
		warnSoulstormSoon:Show()
	end
end
