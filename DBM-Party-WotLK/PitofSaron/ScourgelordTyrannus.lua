local mod	= DBM:NewMod("ScourgelordTyrannus", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220809190725")
mod:SetCreatureID(36658, 36661)
mod:SetUsedIcons(8)
mod:SetHotfixNoticeRev(20220809000000)
mod:SetMinSyncRevision(20220809000000)

-- mod:RegisterCombat("yell", L.CombatStart)
-- mod:RegisterKill("yell", L.YellCombatEnd)
mod:RegisterCombat("combat")
-- mod:SetMinCombatTime(40)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 69629 69167 69172",
	"SPELL_CAST_SUCCESS 69155 69627",
	"SPELL_AURA_APPLIED 69172",
	"SPELL_AURA_REMOVED 69172",
	"SPELL_PERIODIC_DAMAGE 69238 69628",
	"SPELL_PERIODIC_MISSED 69238 69628",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

local warnForcefulSmash			= mod:NewSpellAnnounce(69155, 2, nil, "Tank")
local warnOverlordsBrand		= mod:NewTargetAnnounce(69172, 4)
local warnHoarfrost				= mod:NewTargetAnnounce(69246, 2)

local specWarnHoarfrost			= mod:NewSpecialWarningMoveAway(69246, nil, nil, nil, 1, 2)
local yellHoarfrost				= mod:NewYell(69246)
local specWarnHoarfrostNear		= mod:NewSpecialWarningClose(69246, nil, nil, nil, 1, 2)
local specWarnIcyBlast			= mod:NewSpecialWarningMove(69238, nil, nil, nil, 1, 2)
local specWarnOverlordsBrand	= mod:NewSpecialWarningReflect(69172, nil, nil, nil, 3, 2)
local specWarnUnholyPower		= mod:NewSpecialWarningSpell(69167, "Tank", nil, nil, 1, 2) --Spell for now. may change to run away if damage is too high for defensive

local timerCombatStart			= mod:NewCombatTimer(45) -- 2022/08/09 Icecrown log
local timerOverlordsBrandCD		= mod:NewCDTimer(11, 69172, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON) -- ~1s variance (2022/08/08 Lordaeron log || 2022/08/09 Icecrown log) - 11.2, 11.3, 11.7, 11.7, 11.8, 11.5, 12.0, 12.0 || 11.1, 11.7, 12.1, 11.3
local timerOverlordsBrand		= mod:NewTargetTimer(8, 69172, nil, nil, nil, 5)
local timerUnholyPower			= mod:NewBuffActiveTimer(10, 69167, nil, "Tank|Healer", 2, 5)
local timerUnholyPowerCD		= mod:NewCDTimer(41.3, 69167, nil, "Tank|Healer", nil, 5) -- REVIEW! Doesn't cast if kited? ~1s variance? (2022/08/08 Lordaeron log || 2022/08/09 Icecrown log) - 41.3, 41.9 || -
local timerHoarfrostCD			= mod:NewCDTimer(24.8, 69246, nil, nil, nil, 3) -- SPELL_CAST_START fires 1s after EMOTE, so use EMOTE instead for time diffs. REVIEW! ~2s variance? (2022/08/08 Lordaeron log || 2022/08/09 Icecrown log) - 24.8, 25.9, 25,6 || 26.0
local timerForcefulSmash		= mod:NewCDTimer(41.4, 69155, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON) -- REVIEW! Doesn't cast if kited? ~1s variance (2022/08/08 Lordaeron log || 2022/08/09 Icecrown log) - 41.4, 41.9 || -

mod:AddSetIconOption("SetIconOnHoarfrostTarget", 69246, true, false, {8})
mod:AddRangeFrameOption(8, 69246)

function mod:OnCombatStart(delay)
	timerForcefulSmash:Start(14.3-delay) -- REVIEW! ~1s variance? (2022/08/08 Lordaeron log || 2022/08/09 Icecrown log) - 14.3 || 14.8
	timerOverlordsBrandCD:Start(4.5-delay) -- REVIEW! ~1s variance? (2022/08/08 Lordaeron log || 2022/08/09 Icecrown log) - 5.5 || 4.5
	timerHoarfrostCD:Start(26.3-delay) -- REVIEW! ~1s variance? (2022/08/08 Lordaeron log || 2022/08/09 Icecrown log) - 25.3 || 25.8
	timerUnholyPowerCD:Start(15.3-delay) -- REVIEW! ~1s variance? (2022/08/08 Lordaeron log || 2022/08/09 Icecrown log) - 15.3 || 15.8
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69629, 69167) then					-- Unholy Power
		specWarnUnholyPower:Show()
		specWarnUnholyPower:Play("justrun")
		timerUnholyPower:Start()
		timerUnholyPowerCD:Start()
	elseif args.spellId == 69172 then						-- Overlord's Brand
		timerOverlordsBrandCD:Start() -- more accurate here than on SPELL_AURA_APPLIED due to ability travel time
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(69155, 69627) then					-- Forceful Smash
		warnForcefulSmash:Show()
		timerForcefulSmash:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69172 then							-- Overlord's Brand
		timerOverlordsBrand:Start(args.destName)
		if args:IsPlayer() then
			specWarnOverlordsBrand:Show(args.sourceName)
			specWarnOverlordsBrand:Play("stopattack")
		else
			warnOverlordsBrand:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69172 then							-- Overlord's Brand
		timerOverlordsBrand:Stop(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if (spellId == 69238 or spellId == 69628) and destGUID == UnitGUID("player") and self:AntiSpam() then		-- Icy Blast, MOVE!
		specWarnIcyBlast:Show()
		specWarnIcyBlast:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 36658 then
		DBM:EndCombat(self)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg == L.HoarfrostTarget or msg:find(L.HoarfrostTarget) then
		target = target or msg and msg:match(L.HoarfrostTarget)
		if not target then return end
		timerHoarfrostCD:Start()
		target = DBM:GetUnitFullName(target)
		if target == UnitName("player") then
			specWarnHoarfrost:Show()
			specWarnHoarfrost:Play("targetyou")
			yellHoarfrost:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8, nil, nil, nil, nil, 5)
			end
		elseif self:CheckNearby(8, target) then
			specWarnHoarfrostNear:Show(target)
			specWarnHoarfrostNear:Play("watchstep")
		else
			warnHoarfrost:Show(target)
		end
		if self.Options.SetIconOnHoarfrostTarget then
			self:SetIcon(target, 8, 5)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.CombatStart or msg == L.CombatStart) then
		timerCombatStart:Start()
	end
end
