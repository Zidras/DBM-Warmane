local mod	= DBM:NewMod("TerestianIllhoof", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(15688)

mod:SetModelID(11343)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 30115 30065",
	"SPELL_AURA_REMOVED 30115",
	"SPELL_CAST_SUCCESS 30066"
)

local warningWeakened	= mod:NewTargetNoFilterAnnounce(30065, 2)
local warningImp		= mod:NewSpellAnnounce(30066, 3)
local warningSacrifice	= mod:NewTargetNoFilterAnnounce(30115, 4)

local specWarnSacrifice	= mod:NewSpecialWarningYou(30115, nil, nil, nil, 1, 2)
local yellSacrifice		= mod:NewYell(30115)

local timerWeakened		= mod:NewBuffActiveTimer(31, 30065, nil, nil, nil, 6)
local timerSacrifice	= mod:NewTargetTimer(30, 30115, nil, nil, nil, 3)
local timerSacrificeCD	= mod:NewCDTimer(40.4, 30115, nil, nil, nil, 1)--40.4-47

local berserkTimer		= mod:NewBerserkTimer(600)

function mod:OnCombatStart(delay)
	--timerSacrificeCD:Start(30-delay)--30-50?
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30115 then
		timerSacrifice:Start(args.destName)
		timerSacrificeCD:Start()
		if args:IsPlayer() then
			specWarnSacrifice:Show()
			specWarnSacrifice:Play("targetyou")
			yellSacrifice:Yell()
		else
			warningSacrifice:Show(args.destName)
		end
	elseif args.spellId == 30065 then
		warningWeakened:Show(args.destName)
		timerWeakened:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 30115 then
		timerSacrifice:Stop(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 30066 then
		warningImp:Show()
	end
end
