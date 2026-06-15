local mod	= DBM:NewMod("Gyrokill", "DBM-Party-BC", 13)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(19218)

--mod:SetModelID(??)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 39193 35322",
	"SPELL_AURA_REMOVED 39193 35322"
)

local warnShadowpower		= mod:NewTargetNoFilterAnnounce(35322, 3)

local specWarnShadowpower	= mod:NewSpecialWarningDispel(35322, "MagicDispeller", nil, nil, 1, 2)

local timerShadowpower		= mod:NewBuffActiveTimer(15, 35322, nil, "Tank|MagicDispeller", 2, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(39193, 35322) and not args:IsDestTypePlayer() then	--Shadow Power
		timerShadowpower:Start(args.destName)
		if self.Options.SpecWarn35322dispel then
			specWarnShadowpower:Show(args.destName)
			specWarnShadowpower:Play("dispelboss")
		else
			warnShadowpower:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(39193, 35322) and not args:IsDestTypePlayer() then	--Shadow Power
		timerShadowpower:Stop(args.destName)
	end
end
