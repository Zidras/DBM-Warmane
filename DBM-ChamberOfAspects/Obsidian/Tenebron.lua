local mod	= DBM:NewMod("Tenebron", "DBM-ChamberOfAspects", 1)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25"

mod:SetRevision("20221012211527")
mod:SetCreatureID(30452)
mod:SetHotfixNoticeRev(20221012000000)
mod:SetMinSyncRevision(20221012000000)
mod:DisableMultiBossPulls()

--mod:RegisterCombat("combat") -- Don't use IEEU, because on Warmane 3 Drakes, Sartharion NOT is engaged first, but Tenebron > Shadron > Vesperon > Sartharion (Sartharion will end up on boss1).
mod:RegisterCombat("yell", L.YellTenebronPull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 57579 59127"
)

local warnShadowFissure		= mod:NewSpellAnnounce(59127, 4, nil, nil, nil, nil, 2)
local timerShadowFissure	= mod:NewCastTimer(5, 59128, nil, nil, nil, 3)--Cast timer until Void Blast. it's what happens when shadow fissure explodes.

mod:GroupSpells(59127, 59128)--Shadow fissure with void blast

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(57579, 59127) then
		warnShadowFissure:Show()
		warnShadowFissure:Play("watchstep")
		timerShadowFissure:Start()
	end
end
