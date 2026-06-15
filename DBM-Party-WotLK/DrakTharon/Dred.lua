local mod	= DBM:NewMod("KingDred", "DBM-Party-WotLK", 4)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(27483)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 22686",
	"SPELL_AURA_APPLIED 48920 48873 48878"
)

local warningSlash	= mod:NewSpellAnnounce(48873, 3)
local warningBite	= mod:NewTargetNoFilterAnnounce(48920, 2, nil, "Healer")
local warningFear	= mod:NewSpellAnnounce(22686, 1)

local timerFearCD	= mod:NewCDTimer(15, 22686, nil, nil, nil, 2)  -- cooldown ??
local timerSlash	= mod:NewTargetTimer(10, 48873)
local timerSlashCD	= mod:NewCDTimer(18, 48873, nil, "Tank|Healer", nil, 5)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 22686 and args.sourceGUID == 27483 then
		warningFear:Show()
		timerFearCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48920 then
		warningBite:Show(args.destName)
	elseif args.spellId == 48873 then
		warningSlash:Show()
		timerSlash:Start(15, args.destName)
		timerSlashCD:Start()
	elseif args.spellId == 48878 then
		warningSlash:Show()
		timerSlash:Start(10, args.destName)
		timerSlashCD:Start()
	end
end
