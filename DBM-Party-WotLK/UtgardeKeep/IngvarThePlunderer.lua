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

local warningSmash		= mod:NewSpellAnnounce(42723, 1)
local warningGrowl		= mod:NewSpellAnnounce(42708, 3)
local warningWoeStrike	= mod:NewTargetAnnounce(42730, 2)
local timerSmash		= mod:NewCastTimer(3, 42723)
local timerSmashCD		= mod:NewCDTimer(13, 42723)
local timerWoeStrike	= mod:NewTargetTimer(10, 42723)
local timerNova			= mod:NewCDTimer(25, 59435)
local specwarnNova		= mod:NewSpecialWarning("SpecWarnSpecial")
local warnNova			= mod:NewSpellAnnounce(42723, 4)
local timerRuneCD		= mod:NewCDTimer(10, 64851)
local warningRune		= mod:NewTargetAnnounce(64852, 2, "Interface\\Icons\\Spell_Fire_SelfDestruct")
local specwarnRune		= mod:NewSpecialWarningMove(64989)
local specWarnSpelllock	= mod:NewSpecialWarningCast(42729)


function mod:OnCombatStart()
	self:SetStage(1)
	timerSmashCD:Start(15)
	timerNova:Start(18.5)
end

function mod:OnCombatEnd()
	timerRuneCD:Cancel()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(42723, 42669, 59706) then
		warningSmash:Show()
		timerSmash:Start()
		timerSmashCD:Start()
	elseif args:IsSpellID(42708, 42729, 59708, 59734) then
		warningGrowl:Show()
	end
	if args:IsSpellID(42729, 59734) then
		specWarnSpelllock:Show()
	end
	if args.spellId == 59435 then
		timerNova:Start()
		specwarnNova:Show()
		warnNova:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 64852 then
		timerRuneCD:Start()
		warningRune:Show(args.destName)
		if args.destName == UnitName("player") then
			specwarnRune:Show()
		end
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
	if msg == "Я вернулся! Еще один шанс раскроить вам головы!" or msg == "I return! A second chance to carve your skull!" then
		self:SetStage(2)
		timerNova:Cancel()
		timerNova:Start(15)
		timerRuneCD:Start(5)
	end
end