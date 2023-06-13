local mod	= DBM:NewMod("Volazj", "DBM-Party-WotLK", 1)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220823234921")
mod:SetCreatureID(29311)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START 60848"
)

mod:RegisterEventsInCombat(
	"UNIT_SPELLCAST_START"
)

local warnShadowCrash			= mod:NewTargetAnnounce(62660, 4)
local warningInsanity			= mod:NewCastAnnounce(57496, 3)--Not currently working, no CLEU for it

local specWarnShadowCrash		= mod:NewSpecialWarningDodge(62660, nil, nil, nil, 1, 2)
local specWarnShadowCrashNear	= mod:NewSpecialWarningClose(62660, nil, nil, nil, 1, 2)
local yellShadowCrash			= mod:NewYell(62660)

local timerInsanity				= mod:NewCastTimer(5, 57496, nil, nil, nil, 6)
local timerAchieve				= mod:NewAchievementTimer(120, 1862)

function mod:OnCombatStart(delay)
	if not self:IsDifficulty("normal5") then
		timerAchieve:Start(-delay)
	end
end

function mod:ShadowCrashTarget(targetname)
	if not targetname then
		if DBM.Options.DebugMode then
			warnShadowCrash:Show(DBM_COMMON_L.UNKNOWN)
		end
		return
	end
	if self:AntiSpam(2, targetname) then--In case more than 1 pulled and target same person, avoid double/tripple warn
		if targetname == UnitName("player") then
			specWarnShadowCrash:Show()
			specWarnShadowCrash:Play("watchstep")
			yellShadowCrash:Yell()
		elseif self:CheckNearby(5, targetname) then
			specWarnShadowCrashNear:Show(targetname)
			specWarnShadowCrashNear:Play("watchstep")
		else
			warnShadowCrash:Show(targetname)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 60848 then
		self:BossTargetScanner(args.sourceGUID, "ShadowCrashTarget", 0.1, 12, nil, nil, nil, nil, true)
	end
end

function mod:UNIT_SPELLCAST_START(_, spellName)
	if spellName == GetSpellInfo(57496) then -- Insanity
		warningInsanity:Show()
		timerInsanity:Start()
	end
end
