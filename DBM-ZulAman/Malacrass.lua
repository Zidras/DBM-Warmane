local mod	= DBM:NewMod("Malacrass", "DBM-ZulAman")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221101172357")
mod:SetCreatureID(24239)

mod:SetZone()

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 43548 43451 43431",
	"SPELL_CAST_SUCCESS 43383 43429",
	"SPELL_AURA_APPLIED 43501 43421",
	"SPELL_SUMMON 43436"
)

--TODO, GTFO for standing in shit
local warnSiphon	= mod:NewTargetNoFilterAnnounce(43501, 3)
local warnBoltSoon	= mod:NewPreWarnAnnounce(43383, 5, 3)
local warnHeal1		= mod:NewCastAnnounce(43548, 3)
local warnHeal2		= mod:NewCastAnnounce(43451, 3)
local warnHeal3		= mod:NewCastAnnounce(43431, 3)
local warnHeal4		= mod:NewTargetNoFilterAnnounce(43421, 3)
local warnPatch		= mod:NewSpellAnnounce(43429, 3)

local specWarnBolt	= mod:NewSpecialWarningSpell(43383, nil, nil, nil, 2, 2)
local specWarnHeal1	= mod:NewSpecialWarningInterrupt(43548, "HasInterrupt", nil, nil, 1, 2)
local specWarnHeal2	= mod:NewSpecialWarningInterrupt(43451, "HasInterrupt", nil, nil, 1, 2)
local specWarnHeal3	= mod:NewSpecialWarningInterrupt(43431, "HasInterrupt", nil, nil, 1, 2)
local specWarnHeal4	= mod:NewSpecialWarningDispel(43421, "MagicDispeller", nil, nil, 1, 2)
local specWarnTotem	= mod:NewSpecialWarningSwitch(43436, "Dps", nil, nil, 1, 2)

local timerSiphon	= mod:NewTargetTimer(30, 43501, nil, nil, nil, 6)
local timerBoltCD	= mod:NewCDTimer(41, 43383, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON) -- ~3s variance? (10m Frostmourne 2022/10/28) - 43.0, 42.3, 44.0, 44.1, 44.0
local timerBolt		= mod:NewCastTimer(10, 43383, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerPatch	= mod:NewCastTimer(20, 43429, nil, nil, nil, 3)

function mod:OnCombatStart()
	timerBoltCD:Start(30) -- (10m Frostmourne 2022/10/28) - pull:30.0
	warnBoltSoon:Schedule(25)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 43548 then -- Healing Wave
		if self.Options.SpecWarn43548interrupt and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHeal1:Show(args.sourceName)
			specWarnHeal1:Play("kickcast")
		else
			warnHeal1:Show()
		end
	elseif spellId == 43451 then -- Holy Light
		if self.Options.SpecWarn43451interrupt and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHeal2:Show(args.sourceName)
			specWarnHeal2:Play("kickcast")
		else
			warnHeal2:Show()
		end
	elseif spellId == 43431 then -- Flash Heal
		if self.Options.SpecWarn43431interrupt and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHeal3:Show(args.sourceName)
			specWarnHeal3:Play("kickcast")
		else
			warnHeal3:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 43383 then -- Spirit Bolts
		specWarnBolt:Show()
		specWarnBolt:Play("aesoon")
		warnBoltSoon:Schedule(35)
		timerBolt:Start()
		timerBoltCD:Start()
	elseif spellId == 43429 then -- Consescration
		warnPatch:Show()
		timerPatch:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 43501 then -- Siphon Soul
		warnSiphon:Show(args.destName)
		timerSiphon:Show(args.destName)
	elseif spellId == 43421 and not args:IsDestTypePlayer() then -- Lifebloom
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHeal4:Show(args.destName)
			specWarnHeal4:Play("dispelboss")
		else
			warnHeal4:Show(args.destName)
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 43436 then -- Fire Nova Totem
		specWarnTotem:Show()
		specWarnTotem:Play("attacktotem")
	end
end
