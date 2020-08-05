local mod	= DBM:NewMod("Anub'Rekhan", "DBM-Naxx", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4902 $"):sub(12, -3))
mod:SetCreatureID(15956)

mod:RegisterCombat("combat")

mod:EnableModel()

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED"
)

local warningLocustSoon		= mod:NewSoonAnnounce(28785, 2)
local warningLocustNow		= mod:NewSpellAnnounce(28785, 3)
local warningLocustFaded	= mod:NewAnnounce("WarningLocustFaded", 1, 28785)

local specialWarningLocust	= mod:NewSpecialWarning("SpecialLocust")

local timerLocustIn			= mod:NewCDTimer(55, 28785)
local timerLocustFade 		= mod:NewBuffActiveTimer(23, 28785)

mod:AddBoolOption("ArachnophobiaTimer", true, "timer")


function mod:OnCombatStart(delay)
	timerLocustIn:Start(70 - delay)
	warningLocustSoon:Schedule(65 - delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(28785, 54021) then  -- Locust Swarm
		warningLocustNow:Show()
		specialWarningLocust:Show()
		timerLocustIn:Stop()
		timerLocustFade:Start(23)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(28785, 54021)
	and args.auraType == "BUFF" then
		warningLocustFaded:Show()
		timerLocustIn:Start()
		warningLocustSoon:Schedule(70-23)
		timerLocustIn:Start(75-23)
	end
end

function mod:UNIT_DIED(args)
	if self.Options.ArachnophobiaTimer and not DBM.Bars:GetBar(L.ArachnophobiaTimer) then
		local guid = tonumber(args.destGUID:sub(9, 12), 16)
		if guid == 15956 then		-- Anub'Rekhan
			DBM.Bars:CreateBar(1200, L.ArachnophobiaTimer)
		end
	end
end
