local mod	= DBM:NewMod("VarosCloudstrider", "DBM-Party-WotLK", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(27447)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 51054 59371",
	"SPELL_AURA_REMOVED 51054 59371"
)

local warningAmplify	= mod:NewTargetNoFilterAnnounce(51054, 2)

local timerAmplify		= mod:NewTargetTimer(30, 51054, nil, "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(51054, 59371) then
		warningAmplify:Show(args.destName)
		timerAmplify:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(51054, 59371) then
		timerAmplify:Cancel(args.destName)
	end
end
