local mod	= DBM:NewMod("Brutallus", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4436 $"):sub(12, -3))
mod:SetCreatureID(24882)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")
mod:RegisterCombat("yell", L.YellPull)

mod.disableHealthCombat = true


mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

local warnMeteor		= mod:NewSpellAnnounce(45150, 3)
local warnBurn			= mod:NewTargetAnnounce(46394, 3)
local warnStomp			= mod:NewTargetAnnounce(45185, 3)

local specwarnStompYou	= mod:NewSpecialWarningYou(45185, mod:IsTank())
local specwarnStomp		= mod:NewSpecialWarningTaunt(45185, mod:IsTank())
local specWarnMeteor	= mod:NewSpecialWarningStack(45150, nil, 4)
local specWarnBurn		= mod:NewSpecialWarningYou(46394)

local timerMeteorCD		= mod:NewCDTimer(10, 45150)
local timerStompCD		= mod:NewCDTimer(30, 45185)
local timerBurn			= mod:NewTargetTimer(59, 46394)
local timerBurnCD		= mod:NewCDTimer(59, 46394)

local berserkTimer		= mod:NewBerserkTimer(360)

mod:AddBoolOption("BurnIcon", true)
mod:AddBoolOption("RangeFrame", true)

local burnIcon = 8

local DebuffFilter
do
	DebuffFilter = function(uId)
		return UnitDebuff(uId, GetSpellInfo(46394))
	end
end

function mod:OnCombatStart(delay)
	burnIcon = 8
	timerBurnCD:Start(-delay)
	timerStompCD:Start(-delay)
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5, nil)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 46394 then
		warnBurn:Show(args.destName)
		timerBurn:Start(args.destName)
		if self:AntiSpam(19, 1) then
			timerBurnCD:Start()
		end
		if self.Options.BurnIcon then
			self:SetIcon(args.destName, burnIcon)
			if burnIcon == 1 then
				burnIcon = 8
			else
				burnIcon = burnIcon - 1
			end
		end
		if args:IsPlayer() then
			specWarnBurn:Show()
			SendChatMessage("Огонь на МНЕ!", "YELL")
		end
	elseif args.spellId == 45185 then
		warnStomp:Show(args.destName)
		if not args:IsPlayer() then
			specwarnStomp:Show(args.destName)
		else
			specwarnStompYou:Show()
		end
		timerStompCD:Start()
	elseif args.spellId == 45150 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 2 then
			specWarnMeteor:Show(amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 46394 then
		if self.Options.BurnIcon then
			self:SetIcon(args.destName, 0)
		end
		timerBurn:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 45150 then
		warnMeteor:Show()
		timerMeteorCD:Start()
	end
end

function mod:SPELL_MISSED(args)
	if args.spellId == 46394 then
		warnBurn:Show("MISSED")
		if self:AntiSpam(19, 1) then
			timerBurnCD:Start()
		end
	end
end

function mod:UNIT_DIED(args)
	timerBurn:Cancel(args.destName)
end