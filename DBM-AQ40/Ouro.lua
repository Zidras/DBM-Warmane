local mod	= DBM:NewMod("Ouro", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(15517)

mod:SetModelID(15517)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 26615",
	"SPELL_CAST_START 26102 26103",
	"SPELL_CAST_SUCCESS 26058",
	"UNIT_HEALTH mouseover focus target"
)

--Submerge timer is not timer based, it has some kind of hidden condition we do not know. It's not health based either (other than fact the faster you kill boss less likely you are to see it)
--[[
(ability.id = 26102 or ability.id = 26103) and type = "begincast"
 or ability.id = 26058 and type = "cast"
 or ability.id = 26615
--]]
local warnSubmerge		= mod:NewAnnounce("WarnSubmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerge		= mod:NewAnnounce("WarnEmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnSweep			= mod:NewSpellAnnounce(26103, 2, nil, "Tank", 3)
local warnBerserk		= mod:NewSpellAnnounce(26615, 3)
local warnBerserkSoon	= mod:NewSoonAnnounce(26615, 2)

local specWarnBlast		= mod:NewSpecialWarningSpell(26102, nil, nil, nil, 2, 2)

local timerSubmerge		= mod:NewTimer(30, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, nil, 6)
local timerEmerge		= mod:NewTimer(30, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)
local timerSweepCD		= mod:NewNextTimer(20.5, 26103, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerBlastCD		= mod:NewNextTimer(23, 26102, nil, nil, nil, 2)

mod.vb.prewarn_Berserk = false
mod.vb.Berserked = false

function mod:OnCombatStart(delay)
	self.vb.prewarn_Berserk = false
	self.vb.Berserked = false
	timerSweepCD:Start(22-delay)--22-25
	timerBlastCD:Start(20-delay)--20-26
	timerSubmerge:Start(184-delay)
end

function mod:Emerge()
	warnEmerge:Show()
	timerSweepCD:Start(23)--23-24 (it might be 22-25 like pull)
	timerBlastCD:Start(24)--24-26 (it might be 20-26 like pull)
	timerSubmerge:Start(184)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 26615 and args:IsDestTypeHostile() then
		self.vb.Berserked = true
		warnBerserk:Show()
		timerSubmerge:Stop()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 26102 then
		specWarnBlast:Show()
		specWarnBlast:Play("stunsoon")
		timerBlastCD:Start()
	elseif args.spellId == 26103 and args:IsSrcTypeHostile() then
		warnSweep:Show()
		timerSweepCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 26058 and self:AntiSpam(3) and not self.vb.Berserked then
		timerBlastCD:Stop()
		timerSweepCD:Stop()
		timerSubmerge:Stop()
		warnSubmerge:Show()
		timerEmerge:Start()
		self:ScheduleMethod(30, "Emerge")
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 15517 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.23 and not self.vb.prewarn_Berserk then
		self.vb.prewarn_Berserk = true
		warnBerserkSoon:Show()
	end
end
