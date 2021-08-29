local mod	= DBM:NewMod("IngvarThePlunderer", "DBM-Party-WotLK", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4154 $"):sub(12, -3))
mod:SetCreatureID(23980, 23954)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_SUCCESS"
)

local warningWoeStrike	= mod:NewTargetNoFilterAnnounce(42730, 2, nil, "RemoveCurse", 2)
local specWarnSpelllock	= mod:NewSpecialWarningCast(42729, "SpellCaster", nil, 2, 1, 2)
local specWarnSmash		= mod:NewSpecialWarningDodge(42723, "Tank", nil, nil, 1, 2)

local timerSmash		= mod:NewCastTimer(3, 42723)
local timerSmashCD		= mod:NewCDTimer(13, 42723)
local timerWoeStrike	= mod:NewTargetTimer(10, 42723, nil, "RemoveCurse", nil, 5, nil, DBM_CORE_L.CURSE_ICON)


function mod:OnCombatStart()
	self:SetStage(1)
	timerSmashCD:Start(15)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(42723, 42669, 59706) then
		specWarnSmash:Show()
		specWarnSmash:Play("shockwave")
		timerSmash:Start()
		timerSmashCD:Start()
	elseif args:IsSpellID(42708, 42729, 59708, 59734) then
		specWarnSpelllock:Show()
		specWarnSpelllock:Play("stopcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(42730, 59735) then
		warningWoeStrike:Show(args.destName)
		timerWoeStrike:Start(args.destName)
		self:SetIcon(args.destName, 8, 10)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(42730, 59735) then
		timerWoeStrike:Cancel()
		self:SetIcon(args.destName, 0)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellIngvarPhase2 or msg:find(L.YellIngvarPhase2) then
		self:SetStage(2)
	end
end