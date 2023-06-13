local mod	= DBM:NewMod("ProphetTharonja", "DBM-Party-WotLK", 4)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220806222721")
mod:SetCreatureID(26632)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 49548 59969",
	"SPELL_AURA_APPLIED 49356",
	"UNIT_HEALTH"
)

local warningDecayFleshSoon		= mod:NewSoonAnnounce(49356, 2)
local warningCloud				= mod:NewSpellAnnounce(49548, 3)
local warningFleshSoon			= mod:NewSoonAnnounce(49356, 3)
local warningFlesh				= mod:NewSpellAnnounce(49356, 3)

mod.vb.warnedDecay = false

function mod:OnCombatStart()
	self.vb.warnedDecay = false
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(49548, 59969) then
		warningCloud:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 49356 and self:AntiSpam(1) then
		warningFleshSoon:Show()
		warningFlesh:Schedule(5)
	end
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warnedDecay and self:GetUnitCreatureId(uId) == 26632 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.58 then
		self.vb.warnedDecay = true
		warningDecayFleshSoon:Show()
	end
end
