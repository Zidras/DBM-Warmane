local mod	= DBM:NewMod("Akilzon", "DBM-ZulAman")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221031114005")
mod:SetCreatureID(23574)

mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat_yell", L.YellPull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 43648"
)

local warnStorm			= mod:NewTargetNoFilterAnnounce(43648, 4)
local warnStormSoon		= mod:NewSoonAnnounce(43648, 5, 3)

local specWarnStorm		= mod:NewSpecialWarningSpell(43648, nil, nil, nil, 2, 2)

local timerStorm		= mod:NewCastTimer(8, 43648, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerStormCD		= mod:NewCDTimer(48.3, 43648, nil, nil, nil, 3, nil, nil, true) -- REVIEW! ~5s variance [48.3-53.0]. Added "keep" arg (10m Frostmourne 2022/10/28) - 53.0, 48.3, 52.7

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("10")
mod:AddSetIconOption("StormIcon", 43648, true, false, {1})

function mod:OnCombatStart(delay)
	warnStormSoon:Schedule(43)
	timerStormCD:Start(48) -- (10m Frostmourne 2022/10/28) - 48.0
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show()
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 43648 then
		warnStorm:Show(args.destName)
		specWarnStorm:Show()
		specWarnStorm:Play("specialsoon")
		timerStorm:Start()
		warnStormSoon:Schedule(43)
		timerStormCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
			self:Schedule(10, function()
				DBM.RangeCheck:Show()
			end)
		end
		if self.Options.StormIcon then
			self:SetIcon(args.destName, 1, 1)
		end
	end
end
