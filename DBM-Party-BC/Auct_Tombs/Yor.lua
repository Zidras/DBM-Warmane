local mod	= DBM:NewMod(536, "DBM-Party-BC", 8, 250)

mod.statTypes = "heroic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(22930)

mod:SetModelID(14173)
mod:SetModelScale(0.8)
mod:SetModelOffset(0, 1, 2)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS"
)

local warnStomp	= mod:NewSpellAnnounce(36405, 2)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 36405 then
		warnStomp:Show()
	end
end
