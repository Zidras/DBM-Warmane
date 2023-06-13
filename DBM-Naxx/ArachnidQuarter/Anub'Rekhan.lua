local mod	= DBM:NewMod("Anub'Rekhan", "DBM-Naxx", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221106133531")
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

local timerLocustIn			= mod:NewCDTimer(80, 28785, nil, nil, nil, 6)
local timerLocustFade		= mod:NewBuffActiveTimer(23, 28785, nil, nil, nil, 6)
local timerImpale			= mod:NewCDTimer(13, 56090, nil, nil, nil, 3) -- REVIEW! ~7s variance [13.0-19.8]? (25m Lordaeron 2022/10/16) -- 13.7, 13.6, 19.8, 13.0

mod:AddBoolOption("ArachnophobiaTimer", true, "timer", nil, nil, nil, "at1859")--Sad caveat that 10 and 25 man have own achievements and we have to show only 1 in GUI

function mod:OnCombatStart(delay)
	if self:IsDifficulty("normal25") then
		timerLocustIn:Start(100 - delay)
		warningLocustSoon:Schedule(90 - delay)
	else
		timerLocustIn:Start(91 - delay)
		warningLocustSoon:Schedule(76 - delay)
	end
	timerImpale:Start(12.7-delay) -- REVIEW! variance? (25m Lordaeron 2022/10/16) - pull:12.7
end

function mod:OnCombatEnd(wipe)
	if not wipe and self.Options.ArachnophobiaTimer then
		DBT:CreateBar(1200, L.ArachnophobiaTimer, "Interface\\Icons\\INV_Misc_MonsterSpiderCarapace_01")
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(28785, 54021) then  -- Locust Swarm
		specialWarningLocust:Show()
		specialWarningLocust:Play("aesoon")
		timerLocustIn:Stop()
		if self:IsDifficulty("normal25") then
			timerLocustFade:Start(23)
		else
			timerLocustFade:Start(19)
		end
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
		timerLocustIn:Start()
		warningLocustSoon:Schedule(62)
	end
end
