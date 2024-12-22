local mod	= DBM:NewMod("Anub'Rekhan-Vanilla", "DBM-VanillaNaxx", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240714122130")
mod:SetCreatureID(15956)

mod:RegisterCombat("combat_yell", L.Pull1, L.Pull2)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 28785 54021",
	"SPELL_CAST_SUCCESS 28783 56090",
	"SPELL_AURA_REMOVED 28785 54021"
)

local warningLocustSoon		= mod:NewSoonAnnounce(28785, 2)
local warningLocustFaded	= mod:NewFadesAnnounce(28785, 1)
local warnImpale			= mod:NewTargetNoFilterAnnounce(28783, 3, nil, false)

local specialWarningLocust	= mod:NewSpecialWarningSpell(28785, nil, nil, nil, 2, 2)
local yellImpale			= mod:NewYell(28783, nil, false)

local timerLocustIn			= mod:NewCDTimer(115.17, 28785, nil, nil, nil, 6) -- (Onyxia PTR: [2024-07-13]@[13:41:28]) - "Locust Swarm-28785-npc:15956-805 = pull:115.17"
local timerLocustFade		= mod:NewBuffActiveTimer(23, 28785, nil, nil, nil, 6) -- 3s cast timer + 20s buff active timer
local timerImpale			= mod:NewCDTimer(13, 56090, nil, nil, nil, 3) -- REVIEW! ~7s variance [13.0-19.8]? (25m Lordaeron 2022/10/16) -- 13.7, 13.6, 19.8, 13.0

function mod:OnCombatStart(delay)
	timerLocustIn:Start(115.17 - delay)
	warningLocustSoon:Schedule(105 - delay)
	timerImpale:Start(12.7-delay) -- REVIEW! variance? (25m Lordaeron 2022/10/16) - pull:12.7
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(28785, 54021) then  -- Locust Swarm
		specialWarningLocust:Show()
		specialWarningLocust:Play("aesoon")
		timerLocustIn:Stop()
		timerLocustFade:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(28783, 56090) then  -- Impale. REVIEW! 28783 needed?
		timerImpale:Start()
		warnImpale:Show(args.destName)
		if args:IsPlayer() then
			yellImpale:Yell()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(28785, 54021)
	and args.auraType == "BUFF" then
		warningLocustFaded:Show()
		timerLocustIn:Start() -- REVIEW!
		warningLocustSoon:Schedule(105) -- REVIEW!
	end
end
