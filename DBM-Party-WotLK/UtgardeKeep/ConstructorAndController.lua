local mod	= DBM:NewMod("ConstructorAndController", "DBM-Party-WotLK", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2469 $"):sub(12, -3))
mod:SetCreatureID(24201)
mod:SetZone()

mod:RegisterCombat("combat", 24200, 24201)
mod:RegisterCombat("yell", "Далронн! Хватит ли у тебя смелости атаковать вместе со мной?")
mod:RegisterCombat("yell", "Dalronn! See if you can muster the nerve to join my attack!")

local yell1 = "Быстрых Ударов"
local yell2 = "Темное Мученичество"
local yell1en = "Rapid Strikes"
local yell2en = "Dark Martydroom"


mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON",
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_DAMAGE"
)

local warningEnfeeble	= mod:NewTargetAnnounce(43650, 2)
local warningSummon		= mod:NewSpellAnnounce(52611, 3)
local timerEnfeeble		= mod:NewTargetTimer(6, 43650)
local timerGrip			= mod:NewCDTimer(27, 53276)
local warnGrip			= mod:NewSpellAnnounce(53276, 4)
local timerUdari		= mod:NewCDTimer(21, 72326)
local warnUdari			= mod:NewSpellAnnounce(72326, 4)
local specwarnResidue   = mod:NewSpecialWarningMove(72635)
local specwarnMartydrom = mod:NewSpecialWarningMove(72497)
local timerMartydromCast= mod:NewCastTimer(3.8, 72497)

function mod:OnCombatStart()
	timerGrip:Start(25)
	timerUdari:Start(12)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(43650) then
		warningEnfeeble:Show(args.destName)
		timerEnfeeble:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(43650) then
		timerEnfeeble:Cancel(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(52611) and (args.GUID == 24201 or args.GUID == 24000) then
		warningSummon:Show()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, mob, _, _, target)
	if msg:match(yell1) or msg:match(yell1en) then
		timerUdari:Start()
		warnUdari:Show()
	elseif msg:match(yell2) or msg:match(yell2en) then
		timerGrip:Start()
		warnGrip:Show()
		specwarnMartydrom:Show()
		timerMartydromCast:Start()
	end
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(72635) and args:IsPlayer() and self:AntiSpam(1) then
		specwarnResidue:Show()
	end
end