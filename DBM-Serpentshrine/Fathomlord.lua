local mod	= DBM:NewMod("Fathomlord", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250213133410")
mod:SetCreatureID(21214)

--mod:SetModelID(20662)

mod:RegisterCombat("combat_yell", L.YellPull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 38451 38452 38455",
	"SPELL_CAST_START 38330 38445",
	"SPELL_CAST_SUCCESS 38441",
	"SPELL_SUMMON 38306 38304 38236"
)

local warnCariPower				= mod:NewSpellAnnounce(38451, 3)
local warnTidalPower			= mod:NewSpellAnnounce(38452, 3)
local warnSharPower				= mod:NewSpellAnnounce(38455, 3)

local specWarnHeal				= mod:NewSpecialWarningInterrupt(38330, "HasInterrupt", nil, nil, 1, 2)
local specWarnCleansingTotem	= mod:NewSpecialWarningSwitch(38306, "Dps", nil, nil, 1, 2)
local specWarnEarthbindTotem	= mod:NewSpecialWarningSwitch(38304, "Dps", nil, nil, 1, 2)
local specWarnSpitfireTotem		= mod:NewSpecialWarningSwitch(38236, "Dps", nil, nil, 1, 2)

local timerCataclysmicBolt		= mod:NewNextTimer(10, 38441, nil, "Healer", nil, 2)
local timerSearNova				= mod:NewVarTimer("v20-40", 38445, nil, nil, nil, 2)
local timerCleansingTotem		= mod:NewNextTimer(30, 38306, nil, nil, nil, 5)
local timerEarthbindTotem		= mod:NewNextTimer(45, 38304, nil, nil, nil, 5)
local timerSpitfireTotem		= mod:NewNextTimer(60, 38236, nil, nil, nil, 5)

local berserkTimer				= mod:NewBerserkTimer(600)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerCataclysmicBolt:Start(-delay)
	timerSearNova:Start(-delay)
	timerCleansingTotem:Start(-delay)
	timerEarthbindTotem:Start(-delay)
	timerSpitfireTotem:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 38451 then
		warnCariPower:Show()
	elseif args.spellId == 38452 then
		warnTidalPower:Show()
		timerCleansingTotem:Cancel()
		timerEarthbindTotem:Cancel()
		timerSpitfireTotem:Start(27) -- Spitfire Totem has a new timer
	elseif args.spellId == 38455 then
		warnSharPower:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 38330 then
		if self:CheckInterruptFilter(args.sourceGUID) then
			specWarnHeal:Show(args.sourceName)
			specWarnHeal:Play("kickcast")
		end
	elseif args.spellId == 38445 then
		timerSearNova:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 38441 then
		timerCataclysmicBolt:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 38306 then
		specWarnCleansingTotem:Show()
		specWarnCleansingTotem:Play("attacktotem")
		timerCleansingTotem:Start()
	elseif args.spellId == 38304 then
		specWarnEarthbindTotem:Show()
		specWarnEarthbindTotem:Play("attacktotem")
		timerEarthbindTotem:Start()
	elseif args.spellId == 38236 then
		specWarnSpitfireTotem:Show()
		specWarnSpitfireTotem:Play("attacktotem")
		local cId = self:GetCIDFromGUID(args.sourceGUID)
		if cId == 21965 then -- Tidalvess
			timerSpitfireTotem:Start()
		elseif cId == 21214 then -- Karathress
			timerSpitfireTotem:Start(27)
		end
	end
end
