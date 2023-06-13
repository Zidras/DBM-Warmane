local mod	= DBM:NewMod("Halazzi", "DBM-ZulAman")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221101172823")
mod:SetCreatureID(23577)

mod:SetZone()

mod:RegisterCombat("combat_yell", L.YellPull) -- on Trinity Core there is no yell

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 43303 43139 43290",
	"SPELL_AURA_REMOVED 43303",
	"SPELL_SUMMON 43302",
	"CHAT_MSG_MONSTER_YELL"
)

local warnShock			= mod:NewTargetNoFilterAnnounce(43303, 3, "RemoveMagic")
local warnEnrage		= mod:NewSpellAnnounce(43139, 3, nil, "Tank|Healer|RemoveEnrage")
local warnFrenzy		= mod:NewSpellAnnounce(43290, 3)
local warnSpirit		= mod:NewAnnounce("WarnSpirit", 4, 39414)
local warnNormal		= mod:NewAnnounce("WarnNormal", 4, 39414)

local specWarnTotem		= mod:NewSpecialWarningSpell(43302, "Dps", nil, nil, 1, 2)
local specWarnEnrage	= mod:NewSpecialWarningDispel(43139, "RemoveEnrage", nil, nil, 1, 6)

local timerShock		= mod:NewTargetTimer(12, 43303, nil, "RemoveMagic", nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)

local berserkTimer		= mod:NewBerserkTimer(600)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 43303 then -- Flame Shock
		warnShock:Show(args.destName)
		timerShock:Show(args.destName)
	elseif spellId == 43139 then -- Enrage
		if self.Options.SpecWarn43139dispel then
			specWarnEnrage:Show(args.destName)
			specWarnEnrage:Play("enrage")
		else
			warnEnrage:Show()
		end
	elseif spellId == 43290 then -- Lynx Flurry
		warnFrenzy:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 43303 then -- Flame Shock
		timerShock:Stop(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 43302 then -- Lightning Totem
		specWarnTotem:Show()
		specWarnTotem:Play("attacktotem")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellSpirit or msg:find(L.YellSpirit) then
		warnSpirit:Show()
	elseif msg == L.YellNormal or msg:find(L.YellNormal) then
		warnNormal:Show()
	end
end
