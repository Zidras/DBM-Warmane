local mod	= DBM:NewMod("Buru", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(15370)

mod:SetModelID(15370)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_EMOTE"
)

--TODO, see if CLASSIC data set has a spellID for pursuit before it can use generic alerts and voice pack suppot
local WarnDismember				= mod:NewStackAnnounce(96, 3, nil, "Tank", 3)
local warnPursue				= mod:NewAnnounce("WarnPursue", 3, 12021, false, 2)

local specWarnDismember			= mod:NewSpecialWarningStack(96, nil, 5, nil, nil, 1, 6)
local specWarnDismemberTaunt	= mod:NewSpecialWarningTaunt(96, nil, nil, nil, 1, 2)
local specWarnPursue			= mod:NewSpecialWarning("SpecWarnPursue", nil, nil, nil, 4, 2)

local timerDismember			= mod:NewTargetTimer(10, 96, nil, "Tank", 3, 5, nil, DBM_CORE_L.TANK_ICON)

function mod:OnCombatStart(delay)
	if not self:IsTrivial(80) then
		self:RegisterShortTermEvents(
			"SPELL_AURA_APPLIED 96",
			"SPELL_AURA_APPLIED_DOSE 96",
			"SPELL_AURA_REMOVED 96"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 96 then
		local amount = args.amount or 1
		timerDismember:Start(args.destName)
		if amount >= 5 then
			if args:IsPlayer() then
				specWarnDismember:Show(amount)
				specWarnDismember:Play("stackhigh")
			elseif not DBM:UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
				specWarnDismemberTaunt:Show(args.destName)
				specWarnDismemberTaunt:Play("tauntboss")
			else
				WarnDismember:Show(args.destName, amount)
			end
		else
			WarnDismember:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 96 then
		timerDismember:Stop(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if (msg:find(L.PursueEmote) or msg == L.PursueEmote) and target then
		target = DBM:GetUnitFullName(target)
		if target == UnitName("player") then
			specWarnPursue:Show()
			specWarnPursue:Play("justrun")
		else
			warnPursue:Show(target)
		end
	end
end
