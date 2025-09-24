local mod	= DBM:NewMod("Rage", "DBM-Hyjal")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(17767)
mod:SetModelID("creature/lich/lich.m2")
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 31249 31258",
	"SPELL_AURA_REMOVED 31249",
	"SPELL_CAST_START 31258"
)

local warnIceBolt		= mod:NewSpellAnnounce(31249, 3)
local warnDnd			= mod:NewSpellAnnounce(31258, 3)

local specWarnIceBolt	= mod:NewSpecialWarningYou(31249, nil, nil, nil, 1, 2)
local specWarnDnD		= mod:NewSpecialWarningGTFO(31258, nil, nil, nil, 1, 8)

local timerDnd			= mod:NewBuffActiveTimer(16, 31258)
local timerDndCD		= mod:NewCDTimer(46, 31258, nil, nil, nil, 3)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddSetIconOption("IceBoltIcon", 31249, false, false, {8})

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31249 then
		if args:IsPlayer() then
			specWarnIceBolt:Show()
			specWarnIceBolt:Play("stunsoon")
		else
			warnIceBolt:Show(args.destName)
		end
		if self.Options.IceBoltIcon then
			self:SetIcon(args.destName, 8)
		end
	elseif args.spellId == 31258 and args:IsPlayer() and self:AntiSpam() then
		specWarnDnD:Show(args.spellName)
		specWarnDnD:Play("watchfeet")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 31249 then
		if self.Options.IceBoltIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 31258 then
		warnDnd:Show()
		timerDnd:Start()
		timerDndCD:Start()
	end
end
