local mod	= DBM:NewMod("ArcanistDoan", "DBM-Party-Classic", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(6487)
--

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 9435 8988",
	"SPELL_CAST_SUCCESS 9433",
	"SPELL_AURA_APPLIED 13323"
)

local warningPolymorph				= mod:NewTargetNoFilterAnnounce(13323, 2)
local warningSilence				= mod:NewCastAnnounce(8988, 2)
local warningArcaneExplosion		= mod:NewSpellAnnounce(9433, 2, nil, false, 2)--Can be spammy if cast multiple times in succession

local specWarnDetonation			= mod:NewSpecialWarningRun(9435, nil, nil, nil, 4, 2)

--local timerDetonationCD			= mod:NewCDTimer(180, 9435, nil, nil, nil, 2)
local timerSilenceCD				= mod:NewCDTimer(15.5, 8988, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)--15-19

function mod:OnCombatStart(delay)
	--timerDetonationCD:Start(17.5-delay)--17.5-24
	timerSilenceCD:Start(9.9-delay)--9.9-16
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 9435 then
		specWarnDetonation:Show()
		specWarnDetonation:Play("justrun")
		--timerDetonationCD:Start()
	elseif args.spellId == 8988 and args:IsSrcTypeHostile() then
		warningSilence:Show()
		timerSilenceCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 9433 and args:IsSrcTypeHostile()  then
		warningArcaneExplosion:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 13323 and args:IsDestTypePlayer() then
		warningPolymorph:Show(args.destName)
	end
end
