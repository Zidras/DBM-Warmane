local mod	= DBM:NewMod("BlackKnight", "DBM-Party-WotLK", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(35451, 10000)		-- work around, DBM API failes to handle a Boss to die, rebirth, die again, rebirth again and die to loot...
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 67729 67886",
	"SPELL_AURA_APPLIED 67823 67882 67751",
	"SPELL_DAMAGE 67781 67876 67729 67886",
	"SPELL_MISSED 67781 67876 67729 67886"
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

function mod:OnCombatStart()
	warnedfailed = false
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(67729, 67886) and self:AntiSpam(2, 2) then							-- Explode (elite explodes self, not BK. Phase 2)
		specWarnExplode:Show()
		specWarnExplode:Play("justrun")
		timerExplode:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, destName, _, spellId)
	if (spellId == 67781 or spellId == 67876) and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then		-- Desecration
		specWarnDesecration:Show()
		specWarnDesecration:Play("watchfeet")
	elseif spellId == 67729 or spellId == 67886 then
		if self.Options.AchievementCheck and not warnedfailed then
			SendChatMessage(L.AchievementFailed:format(destName), "PARTY")
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
