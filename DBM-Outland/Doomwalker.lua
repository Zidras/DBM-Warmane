local mod	= DBM:NewMod("Doomwalker", "DBM-Outland")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(17711)
mod:SetModelID(21435)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 32637",
	"SPELL_AURA_APPLIED 32686"
)

local warnCharge			= mod:NewSpellAnnounce(32637, 3)
local warnQuake				= mod:NewSpellAnnounce(32686, 3)

local timerChargeCD			= mod:NewCDTimer(42, 32637, nil, nil, nil, 3)
local timerQuakeCD			= mod:NewCDTimer(52, 32686, nil, nil, nil, 2)
local timerQuake			= mod:NewBuffActiveTimer(8, 32686, nil, nil, nil, 2)

mod:AddRangeFrameOption("10")

function mod:OnCombatStart()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 32637 and self:AntiSpam(10, 1) then
		warnCharge:Show()
		timerChargeCD:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 32686 and self:AntiSpam(30, 2) then
		warnQuake:Show()
		timerQuake:Start()
		timerQuakeCD:Show()
	end
end
