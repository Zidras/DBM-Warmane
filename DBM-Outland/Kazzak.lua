local mod	= DBM:NewMod("Kazzak", "DBM-Outland")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(18728)
mod:SetModelID(17887)
mod:SetUsedIcons(8)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 32960 32964 21063",
	"SPELL_AURA_REMOVED 32960"
)

local warningFrenzy		= mod:NewSpellAnnounce(32964, 3)
local warningMark		= mod:NewTargetNoFilterAnnounce(32960, 4)
local warningTwisted	= mod:NewTargetAnnounce(21063, 4)

local specWarnMark		= mod:NewSpecialWarningYou(32960, nil, nil, nil, 1, 2)
local specWarnTwisted	= mod:NewSpecialWarningDispel(21063, "Healer", nil, nil, 1, 2)

local timerFrenzy		= mod:NewBuffActiveTimer(10, 32964)
local timerFrenzyCD		= mod:NewCDTimer(60, 32964, nil, nil, nil, 3)
--local timerTwistedCD	= mod:NewCDTimer(30, 21063, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)--Unknown, but would be nice to have
local timerMark			= mod:NewTargetTimer(10, 32960, nil, nil, nil, 3)

mod:AddSetIconOption("SetIconOnMark", 32960, true, false, {8})

function mod:OnCombatStart(delay)
	timerFrenzyCD:Start(-delay)
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 32960 then
		timerMark:Start(args.destName)
		if args:IsPlayer() then
			specWarnMark:Show()
			specWarnMark:Play("targetyou")
		else
			warningMark:Show(args.destName)
		end
		if self.Options.SetIconOnMark then
			self:SetIcon(args.destName, 8)
		end
	elseif args.spellId == 32964 then
		warningFrenzy:Show()
		timerFrenzy:Show()
		timerFrenzyCD:Start()
	elseif args.spellId == 21063 then
		if self.Options.SpecWarn21063dispel then
			specWarnTwisted:Show(args.destName)
			specWarnTwisted:Play("dispelnow")
		else
			warningTwisted:Show(args.destName)
		end
--		timerTwistedCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 32960 then
		timerMark:Cancel(args.destName)
		if self.Options.SetIconOnMark then
			self:SetIcon(args.destName, 0)
		end
	end
end
