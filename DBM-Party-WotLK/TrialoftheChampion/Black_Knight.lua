local mod	= DBM:NewMod("BlackKnight", "DBM-Party-WotLK", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4440 $"):sub(12, -3))
mod:SetCreatureID(35451, 10000)		-- work around, DBM API failes to handle a Boss to die, rebirth, die again, rebirth again and die to loot...
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnMarked			= mod:NewTargetNoFilterAnnounce(67823, 3)

local specWarnDesecration	= mod:NewSpecialWarningMove(67781, nil, nil, nil, 1, 8)
local specWarnExplode		= mod:NewSpecialWarningRun(67751, "Melee", nil, 2, 4, 2)

local timerCombatStart		= mod:NewCombatTimer(38.5)
local timerMarked			= mod:NewTargetTimer(10, 67823, nil, nil, nil, 3)
local timerExplode			= mod:NewCastTimer(4, 67729, nil, nil, nil, 2)

mod:AddSetIconOption("SetIconOnMarkedTarget", 67823, false, false, {8})
mod:AddBoolOption("AchievementCheck", false, "announce")

local warnedfailed = false

function mod:OnCombatStart(delay)
	warnedfailed = false
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(67729, 67886) and self:AntiSpam(2, 2) then							-- Explode (elite explodes self, not BK. Phase 2)
		specWarnExplode:Show()
		specWarnExplode:Play("justrun")
		timerExplode:Start()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(67781, 67876) and args:IsPlayer() and self:AntiSpam(3, 1) then		-- Desecration
		specWarnDesecration:Show()
		specWarnDesecration:Play("watchfeet")
	elseif args:IsSpellID(67886) then
		if self.Options.AchievementCheck and not warnedfailed then
			SendChatMessage(L.AchievementFailed:format(args.destName), "PARTY")
			warnedfailed = true
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67823, 67882) and args:IsDestTypePlayer() then							-- Marked For Death
		if self.Options.SetIconOnMarkedTarget then
			self:SetIcon(args.destName, 8, 10)
		end
		warnMarked:Show(args.destName)
		timerMarked:Show(args.destName)
	elseif args.spellId == 67751 and self:AntiSpam(2, 2) then	-- Ghoul Explode (BK exlodes Army of the dead. Phase 3)
		specWarnExplode:Show()
		specWarnExplode:Play("justrun")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Pull or msg:find(L.Pull) then
		timerCombatStart:Start()
	end
end