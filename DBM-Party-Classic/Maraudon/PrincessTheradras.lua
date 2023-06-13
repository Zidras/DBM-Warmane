local mod	= DBM:NewMod(431, "DBM-Party-Classic", 8, 232)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(12201)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 21832",
	"SPELL_CAST_SUCCESS 21869 21909"
--	"SPELL_AURA_APPLIED 12747"
)

--TODO, fear spread diff ID from initial target? if so, announce initial target
--TODO, target scan Boulder?
--TODO, more data that maybe gaze and dust field ona shared special timer?
--local warningRepulsiveGaze		= mod:NewTargetNoFilterAnnounce(21869, 2)
local warningRepulsiveGaze			= mod:NewSpellAnnounce(21869, 2)
local warningBoulder				= mod:NewSpellAnnounce(21832, 2)
local warningDustField				= mod:NewSpellAnnounce(21909, 2)

local specWarnDustField				= mod:NewSpecialWarningRun(21909, "Melee", nil, nil, 4, 2)

local timerRespulsiveGazeCD			= mod:NewCDTimer(26.8, 21869, nil, nil, nil, 3)--26.8-51
local timerDustFieldCD				= mod:NewCDTimer(21.9, 21909, nil, nil, nil, 2)--21.9-44

function mod:OnCombatStart(delay)
	timerRespulsiveGazeCD:Start(7-delay)
	timerDustFieldCD:Start(8-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 21832 and args:GetSrcCreatureID() == 12201 then
		warningBoulder:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 21869 then
		warningRepulsiveGaze:Show()
		timerRespulsiveGazeCD:Start()
	elseif args.spellId == 21909 then
		if self.Options.SpecWarn21909run and not self:IsTrivial(60) then
			specWarnDustField:Show()
			specWarnDustField:Play("justrun")
		else
			warningDustField:Show()
		end
		timerDustFieldCD:Start()
	end
end

--[[
function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 21869 then
		warningRepulsiveGaze:Show(args.destName)
	end
end
--]]
