local mod	= DBM:NewMod("Alar", "DBM-TheEye")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(19514)

mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_HEAL"
)

local warnPhase1		= mod:NewPhaseAnnounce(1)
local warnQuill			= mod:NewSpellAnnounce(34229, 4)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnArmor			= mod:NewTargetAnnounce(35410, 2)
local warnMeteor		= mod:NewSpellAnnounce(35181, 3)

local specWarnQuill		= mod:NewSpecialWarningSpell(34229)
local specWarnFire		= mod:NewSpecialWarningMove(35383)

local timerQuill		= mod:NewCastTimer(10, 34229)
local timerMeteor		= mod:NewCDTimer(52, 35181)
local timerArmor		= mod:NewTargetTimer(60, 35410)
local timerNextPlatform	= mod:NewTimer(34, "NextPlatform", 40192)--This has no spell trigger, the target scanning bosses target is still required if loop isn't accurate enough.

local berserkTimer		= mod:NewBerserkTimer(600)

local buffetName = GetSpellInfo(34121)
local UnitGUID = UnitGUID
local UnitName = UnitName
local flying = false
local phase2 = false

--Loop doesn't work do to varying travel time between platforms. We just need to do target scanning and start next platform timer when Al'ar reaches a platform and starts targeting player again
--Still semi inaccurate. Sometimes Al'ar changes platforms 5-8 seconds early with no explanation. I have a feeling it's just tied to Al'ars behavior being buggy with one person.
--I don't remember code being faulty when you actually had 4 people up there.
-- na cirkyle voobshe nixuya ne rabotaet ksta, odni kostili ebanie
function mod:Platform()--An attempt to avoid ugly target scanning, but i get feeling this won't be accurate enough.
	timerNextPlatform:Start()
	flying = false
end

function mod:Add()--An attempt to avoid ugly target scanning, but i get feeling this won't be accurate enough.
	timerNextPlatform:Cancel()
	timerNextPlatform:Start(7)
	mod:ScheduleMethod(7, "Platform")
end

function mod:OnCombatStart(delay)
	self:AntiSpam(30, 1)--Prevent it thinking add spawn on pull and messing up first platform timer
	self:AntiSpam(30, 2)
	flying = false
	phase2 = false
	warnPhase1:Show()
	timerNextPlatform:Start(45-delay)
end

mod:RegisterOnUpdateHandler(function(self)
	if self:IsInCombat() then
		--local foundIt
		local target
		local phoenix
		for uId in DBM:GetGroupMembers() do
			if self:GetUnitCreatureId(uId.."target") == 19551 or self:GetUnitCreatureId("mouseover") == 19551 then
				self:AntiSpam(30, 2)
				--foundIt = true
				phoenix = true
				break
			elseif self:GetUnitCreatureId(uId.."target") == 19514 or self:GetUnitCreatureId("mouseover") == 19514 then
				--foundIt = true
				target = UnitName(uId.."targettarget")
				if not target and UnitCastingInfo(uId.."target") == buffetName then
					target = "Dummy"
				end
				break
			end
		end

		if phoenix and not phase2 and self:AntiSpam(30, 1) then--Al'ar spawned an add and is moving platforms
			self:Add()
			phoenix = false
			--Could also be quills though, which is why we can't really put in an actual add warning.
		elseif not target and type(phase2) == "number" and self:AntiSpam(30, 2) and (GetTime() - phase2) > 25 then--No target in phase 2 means meteor
			warnMeteor:Show()
			timerMeteor:Start()
		elseif target and flying then--Al'ar has reached a platform and is once again targeting aggro player
			self:Platform()
		end
	end
end, 0.25)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 34229 then
		warnQuill:Show()
		specWarnQuill:Show()
		timerQuill:Start()
	elseif args.spellId == 35383 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnFire:Show()
	elseif args.spellId == 35410 then
		warnArmor:Show(args.destName)
		timerArmor:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 35410 then
		timerArmor:Cancel(args.destName)
	end
end

--Target scanning is more accurate for finding phase 2 well before the heal, HOWEVER, fails if soloing alar and you aren't targeting him.
function mod:SPELL_HEAL(_, _, _, _, _, _, spellId)
	if spellId == 34342 then
		phase2 = GetTime()
		warnPhase2:Show()
		berserkTimer:Start()
		timerMeteor:Start(30)--This seems to vary slightly depending on where in room he shoots it.
		timerNextPlatform:Cancel()
	end
end

--[[
function mod:SPELL_DAMAGE(_, _, _, _, _, _, spellId)
	if (spellId == 35181 or spellId == 45680) and self:AntiSpam(30, 2) then
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
--]]
