local mod	= DBM:NewMod("Janalai", "DBM-ZulAman")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250105230600")
mod:SetCreatureID(23578)

mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat_yell", L.YellPull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 43140",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_HEALTH"
)

local warnFlame			= mod:NewTargetNoFilterAnnounce(43140, 3)
local warnAddsSoon		= mod:NewSoonAnnounce(43962, 3)

local specWarnAdds		= mod:NewSpecialWarningSpell(43962, "dps", nil, nil, 1, 2)
local specWarnBomb		= mod:NewSpecialWarningDodge(42630, nil, nil, nil, 2, 2)
local specWarnBreath	= mod:NewSpecialWarningYou(43140, nil, nil, nil, 1, 2)
local yellFlamebreath	= mod:NewYell(43140)

local timerBomb			= mod:NewCastTimer(11, 42630, nil, nil, nil, 3)  --11s on AC
local timerAdds			= mod:NewNextTimer(90, 43962, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON) -- 90s on AC

--At 35% all remaining eggs will hatch
local warnHatchSoon     = mod:NewAnnounce("warnHatchSoon", 4, 58542)


local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddSetIconOption("FlameIcon", 43140, true, false, {1})
mod.vb.warned_preHatch = false


function mod:FlameTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnBreath:Show()
		specWarnBreath:Play("targetyou")
		yellFlamebreath:Yell()
	else
		warnFlame:Show(targetname)
	end
	if self.Options.FlameIcon then
		self:SetIcon(targetname, 1, 1)
	end
end

function mod:OnCombatStart(delay)
	timerAdds:Start(10-delay) -- 10s on AC
	berserkTimer:Start(-delay)
	self.vb.warned_preHatch = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 43140 then -- Flame Breath
		self:BossTargetScanner(args.sourceGUID, "FlameTarget", 0.1, 8)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellAdds or msg:find(L.YellAdds) then
		specWarnAdds:Show()
		warnAddsSoon:Schedule(82)
		timerAdds:Start()
	elseif msg == L.YellBomb or msg:find(L.YellBomb) then
		specWarnBomb:Show()
		specWarnBomb:Play("watchstep")
		timerBomb:Start()
	end
end

function mod:UNIT_HEALTH(uId) --warning at 40%. At 35% all remaining eggs will hatch
	local cid = self:GetUnitCreatureId(uId)
	if not self.vb.warned_preHatch and cid == 23578 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.40 then
		self.vb.warned_preHatch = true
		warnHatchSoon:Show()
	end
end