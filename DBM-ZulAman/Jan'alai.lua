local mod	= DBM:NewMod("Janalai", "DBM-ZulAman")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221101173423")
mod:SetCreatureID(23578)

mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat_yell", L.YellPull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 43140",
	"CHAT_MSG_MONSTER_YELL"
)

local warnFlame			= mod:NewTargetNoFilterAnnounce(43140, 3)
local warnAddsSoon		= mod:NewSoonAnnounce(43962, 3)

local specWarnAdds		= mod:NewSpecialWarningSpell(43962, "dps", nil, nil, 1, 2)
local specWarnBomb		= mod:NewSpecialWarningDodge(42630, nil, nil, nil, 2, 2)
local specWarnBreath	= mod:NewSpecialWarningYou(43140, nil, nil, nil, 1, 2)
local yellFlamebreath	= mod:NewYell(43140)

local timerBomb			= mod:NewCastTimer(12, 42630, nil, nil, nil, 3)--Cast bar?
local timerAdds			= mod:NewNextTimer(89.9, 43962, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON) -- ~0.3s variance. (10m Frostmourne 2022/10/28) - 90.3, 90.0

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddSetIconOption("FlameIcon", 43140, true, false, {1})

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
	timerAdds:Start(10-delay) -- (10m Frostmourne 2022/10/28 +0.5s delay) - 9.8
	berserkTimer:Start(-delay)
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
