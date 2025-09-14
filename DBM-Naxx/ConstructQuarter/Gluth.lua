local mod	= DBM:NewMod("Gluth", "DBM-Naxx", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250914210600")
mod:SetCreatureID(15932)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 28371 54427", -- Added 25-man enrage spell
	"SPELL_AURA_REMOVED 28371 54427", -- Added 25-man enrage spell
	"SPELL_DAMAGE 28375 54426"
)

--TODO, is it really necessary to use SPELL_DAMAGE here?
--TODO, verify decimate timer is actually accurate for wrath (it certainly wasn't for naxx 40)
local warnEnrage		= mod:NewTargetNoFilterAnnounce(28371, 3, nil , "Healer|Tank|RemoveEnrage", 2)
local warnDecimateSoon	= mod:NewSoonAnnounce(28374, 2)
local warnDecimateNow	= mod:NewSpellAnnounce(28374, 3)

local specWarnEnrage	= mod:NewSpecialWarningDispel(28371, "RemoveEnrage", nil, nil, 1, 6)

local timerEnrage		= mod:NewBuffActiveTimer(8, 28371, nil, nil, nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON)
local timerDecimate		= mod:NewCDTimer(110, 28374, nil, nil, nil, 2)
local enrageTimer		= mod:NewBerserkTimer(360)


local function getDecimateTimer()
	if mod:IsDifficulty("normal10", "heroic10") then
		return 110 -- 10-man: 110 seconds
	else
		return 90  -- 25-man: 90 seconds
	end
end

function mod:OnCombatStart(delay)
	local decimateTime = getDecimateTimer()
	enrageTimer:Start(360 - delay) -- 6 minutes berserk timer
	timerDecimate:Update(decimateTime, decimateTime) -- Set correct timer duration
	timerDecimate:Start(decimateTime - delay)
	warnDecimateSoon:Schedule(decimateTime - 10 - delay) -- 10 seconds before
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 28371 or args.spellId == 54427 then
		if self.Options.SpecWarn28371dispel then -- Updated option name
			specWarnEnrage:Show(args.destName)
			specWarnEnrage:Play("enrage")
		else
			warnEnrage:Show(args.destName)
		end
		timerEnrage:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 28371 or args.spellId == 54427 then
		timerEnrage:Stop()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, _, spellId)
	if (spellId == 28375 or spellId == 54426) and self:AntiSpam(20) then
		local decimateTime = getDecimateTimer()
		warnDecimateNow:Show()
		timerDecimate:Update(decimateTime, decimateTime)
		timerDecimate:Start()
		warnDecimateSoon:Schedule(decimateTime - 10)
	end
end
