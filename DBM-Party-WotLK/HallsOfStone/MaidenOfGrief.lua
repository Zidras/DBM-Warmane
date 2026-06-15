local mod	= DBM:NewMod("MaidenOfGrief", "DBM-Party-WotLK", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(27975)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 50760 59726",
	"SPELL_CAST_SUCCESS 50760 59726 50752 59772",
	"SPELL_AURA_APPLIED 50761 59727",
	"SPELL_AURA_REMOVED 50761 59727"
)

local warningWoe		= mod:NewTargetNoFilterAnnounce(50761, 2, nil, "Healer", 2)
local warningStorm		= mod:NewSpellAnnounce(50752, 2)

local specWarnSorrow	= mod:NewSpecialWarningMoveTo(50760, nil, nil, nil, 2, 2)

local timerWoe			= mod:NewTargetTimer(10, 50761, nil, "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerSorrow		= mod:NewBuffActiveTimer(6, 50760)
local timerStormCD		= mod:NewCDTimer(20, 50752, nil, nil, nil, 3)
local timerSorrowCD		= mod:NewCDTimer(30, 50760, nil, nil, nil, 2)
local timerAchieve		= mod:NewAchievementTimer(60, 1866)

local stormName = DBM:GetSpellInfo(50752)

function mod:OnCombatStart(delay)
	if not self:IsDifficulty("normal5") then
		timerAchieve:Start(-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(50760, 59726) then
		specWarnSorrow:Show(stormName)
		specWarnSorrow:Play("takedamage")
		timerSorrowCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(50760, 59726) then
		timerSorrow:Start()
	elseif args:IsSpellID(50752, 59772) then
		warningStorm:Show()
		timerStormCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(50761, 59727) then
		warningWoe:Show(args.destName)
		timerWoe:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(50761, 59727) then
		timerWoe:Stop(args.destName)
	end
end
