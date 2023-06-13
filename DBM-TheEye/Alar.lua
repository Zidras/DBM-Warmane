local mod	= DBM:NewMod("Alar", "DBM-TheEye")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(19514)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 34229 35383 35410",
	"SPELL_AURA_REMOVED 35410",
	"SPELL_HEAL 34342"
)

local warnPhase2		= mod:NewPhaseAnnounce(2, 2)
local warnArmor			= mod:NewTargetAnnounce(35410, 2)
local warnMeteor		= mod:NewSpellAnnounce(35181, 3)

local specWarnQuill		= mod:NewSpecialWarningDodge(34229, nil, nil, nil, 2, 2)
local specWarnFire		= mod:NewSpecialWarningMove(35383, nil, nil, nil, 1, 2)
local specWarnArmor		= mod:NewSpecialWarningTaunt(35410, nil, nil, nil, 1, 2)

local timerQuill		= mod:NewCastTimer(10, 34229, nil, nil, nil, 3)
local timerMeteor		= mod:NewCDTimer(52, 35181, nil, nil, nil, 2)
local timerArmor		= mod:NewTargetTimer(60, 35410, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerNextPlatform	= mod:NewTimer(34, "NextPlatform", 40192, nil, nil, 6)--This has no spell trigger, the target scanning bosses target is still required if loop isn't accurate enough.

local berserkTimer		= mod:NewBerserkTimer(600)

local buffetName = DBM:GetSpellInfo(34121)
local UnitName = UnitName
mod.vb.phase2Start = 0
mod.vb.flying = false

--Loop doesn't work do to varying travel time between platforms. We just need to do target scanning and start next platform timer when Al'ar reaches a platform and starts targeting player again
--Still semi inaccurate. Sometimes Al'ar changes platforms 5-8 seconds early with no explanation. I have a feeling it's just tied to Al'ars behavior being buggy with one person.
--I don't remember code being faulty when you actually had 4 people up there.
local function Platform(self)--An attempt to avoid ugly target scanning, but i get feeling this won't be accurate enough.
	timerNextPlatform:Start()
	self.vb.flying = false
end

local function Add(self)--An attempt to avoid ugly target scanning, but i get feeling this won't be accurate enough.
	timerNextPlatform:Cancel()
	timerNextPlatform:Start(7)
	self.vb.flying = true
	self:Schedule(7, Platform, self)
end

function mod:OnCombatStart(delay)
	self:AntiSpam(30, 1)--Prevent it thinking add spawn on pull and messing up first platform timer
	self.vb.flying = false
	self:SetStage(1)
	self.vb.phase2Start = 0
	timerNextPlatform:Start(35-delay)
	self:RegisterOnUpdateHandler(function(self)
		if self:IsInCombat() then
			local foundIt
			local target
			if UnitExists("boss1") then
				foundIt = true
				target = UnitName("boss1target")
				if not target and UnitCastingInfo("boss1") == buffetName then
					target = "Dummy"
				end
			else
				for uId in DBM:GetGroupMembers() do
					if self:GetUnitCreatureId(uId.."target") == 19514 then
						foundIt = true
						target = UnitName(uId.."targettarget")
						if not target and UnitCastingInfo(uId.."target") == buffetName then
							target = "Dummy"
						end
						break
					end
				end
			end

			if foundIt and not target and self.vb.phase == 1 and self:AntiSpam(30, 1) then--Al'ar is no longer targeting anything, which means he spawned an add and is moving platforms
				Add(self)
				--Could also be quills though, which is why we can't really put in an actual add warning.
			elseif not target and self.vb.phase == 2 and self:AntiSpam(30, 2) and (GetTime() - self.vb.phase2Start) > 25 then--No target in phase 2 means meteor
				warnMeteor:Show()
				timerMeteor:Start()
			elseif target and self.vb.flying then--Al'ar has reached a platform and is once again targeting aggro player
				Platform(self)
			end
		end
	end, 0.25)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 34229 then
		specWarnQuill:Show()
		specWarnQuill:Play("findshelter")
		timerQuill:Start()
	elseif args.spellId == 35383 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnFire:Show()
		specWarnFire:Play("runaway")
	elseif args.spellId == 35410 then
		warnArmor:Show(args.destName)
		if not args:IsPlayer() then
			specWarnArmor:Show(args.destName)
			specWarnArmor:Play("tauntboss")
		end
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
		self.vb.phase2Start = GetTime()
		self:SetStage(2)
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
