local mod	= DBM:NewMod("Akilzon", "DBM-ZulAman")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250103132545")
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

local StormCast			= mod:NewCastTimer(8.5, 43648, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON) --8.5s on AC
local TimerStorm 		= mod:NewNextTimer(60, 43648, "TimerStorm", nil, nil, 3) -- Fixed 60s on AC

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption("10") 
mod:AddSetIconOption("StormIcon", 43648, true, false, {1})

function mod:OnCombatStart(delay)
	warnStormSoon:Schedule(55)
	TimerStorm:Start(-delay) 
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
		StormCast:Start()
		warnStormSoon:Schedule(55)
		TimerStorm:Start()
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
