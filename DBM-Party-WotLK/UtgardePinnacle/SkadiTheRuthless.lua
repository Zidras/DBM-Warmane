local mod	= DBM:NewMod("SkadiTheRuthless", "DBM-Party-WotLK", 11)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(26693)
mod:SetMinSyncRevision(3108)

mod:RegisterCombat("yell", L.Phase2)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 50255 59331",
	"SPELL_AURA_APPLIED 50258 59334 50228 59322",
	"SPELL_AURA_REMOVED 50258 59334"
)

local warnPhase2			= mod:NewPhaseAnnounce(2)
local warningPoisonDebuff	= mod:NewTargetNoFilterAnnounce(50258, 2, nil, "Healer")

local specWarnWhirlwind		= mod:NewSpecialWarningRun(59322, nil, nil, 2, 4, 2)

local timerPoisonDebuff		= mod:NewTargetTimer(12, 50258, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerPoisonCD			= mod:NewCDTimer(10, 59331, nil, "Healer", nil, 5)
local timerWhirlwindCD		= mod:NewCDTimer(20, 59322, nil, nil, nil, 2)
local timerAchieve			= mod:NewAchievementTimer(180, 1873)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(50255, 59331) then
		timerPoisonCD:Start() -- Poisoned Spear throw
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(50258, 59334) then
		warningPoisonDebuff:Show(args.destName)
		timerPoisonDebuff:Start(args.destName)
	elseif args:IsSpellID(50228, 59322) then
		timerWhirlwindCD:Start()
		specWarnWhirlwind:Show()
		specWarnWhirlwind:Play("runout")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(50258, 59334) then
		timerPoisonDebuff:Cancel(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		warnPhase2:Show()
	elseif msg == L.CombatStart or msg:find(L.CombatStart) then
		if not self:IsDifficulty("normal5") then
			timerAchieve:Start()
		end
	end
end
