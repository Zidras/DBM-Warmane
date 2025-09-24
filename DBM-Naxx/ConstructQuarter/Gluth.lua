local mod	= DBM:NewMod("Gluth", "DBM-Naxx", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220806123502")
mod:SetCreatureID(15932)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 28371",
	"SPELL_AURA_REMOVED 28371",
	"SPELL_DAMAGE 28375 54426"
)

--TODO, is it really necessary to use SPELL_DAMAGE here?
--TODO, verify decimate timer is actually accurate for wrath (it certainly wasn't for naxx 40)
local warnEnrage		= mod:NewTargetNoFilterAnnounce(19451, 3, nil , "Healer|Tank|RemoveEnrage", 2)
local warnDecimateSoon	= mod:NewSoonAnnounce(28374, 2)
local warnDecimateNow	= mod:NewSpellAnnounce(28374, 3)

local specWarnEnrage	= mod:NewSpecialWarningDispel(19451, "RemoveEnrage", nil, nil, 1, 6)

local timerEnrage		= mod:NewBuffActiveTimer(8, 19451, nil, nil, nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON)
local timerDecimate		= mod:NewCDTimer(104, 28374, nil, nil, nil, 2)
local enrageTimer		= mod:NewBerserkTimer(420)

function mod:OnCombatStart(delay)
	enrageTimer:Start(420 - delay)
	timerDecimate:Start(110 - delay) -- 25m Log review from 2022-05-05 - 1 minutes 50 seconds
	warnDecimateSoon:Schedule(100 - delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 28371 then
		if self.Options.SpecWarn19451dispel then
			specWarnEnrage:Show(args.destName)
			specWarnEnrage:Play("enrage")
		else
			warnEnrage:Show(args.destName)
		end
		timerEnrage:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 28371 then
		timerEnrage:Stop()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, _, spellId)
	if (spellId == 28375 or spellId == 54426) and self:AntiSpam(20) then
		warnDecimateNow:Show()
		timerDecimate:Start()
		warnDecimateSoon:Schedule(96)
	end
end
