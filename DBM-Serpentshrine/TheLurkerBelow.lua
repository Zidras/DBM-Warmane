local mod	= DBM:NewMod("LurkerBelow", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220813110833")
mod:SetCreatureID(21217)

--mod:SetModelID(20216)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 20568",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnSubmerge		= mod:NewAnnounce("WarnSubmerge", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerge		= mod:NewAnnounce("WarnEmerge", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnWhirl			= mod:NewSpellAnnounce(37363, 2)

local specWarnSpout		= mod:NewSpecialWarningSpell(37433, nil, nil, nil, 2, 2)

local timerSubmerge		= mod:NewTimer(105-14.25, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6) -- REVIEW! no data to validate, but doesn't match wiki
local timerEmerge		= mod:NewTimer(60, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)
local timerSpoutCD		= mod:NewCDTimer(118.5-108.5, 37433, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON) -- REVIEW! variance? (25 man FM log 2022/08/11) - 118.5 (happened right after emerge)
local timerSpoutCast	= mod:NewCastTimer(3, 37433, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerSpout		= mod:NewBuffActiveTimer(22-4, 37433, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerWhirlCD		= mod:NewCDTimer(18+16.15, 37363, nil, nil, nil, 2) -- REVIEW! variance? (25 man FM log 2022/08/11) - 18.0, (after emerge) 100.5

mod.vb.submerged = false
mod.vb.guardianKill = 0
mod.vb.ambusherKill = 0

function mod:Emerged()
	self.vb.submerged = false
	timerEmerge:Cancel()
	warnEmerge:Show()
	timerSubmerge:Start()
	timerSpoutCD:Start()
	self:ScheduleMethod(90.75, "Submerged")
end

function mod:Submerged()
	self.vb.submerged = true
	self.vb.guardianKill = 0
	self.vb.ambusherKill = 0
	timerSubmerge:Cancel()
	timerSpout:Cancel()
	timerSpoutCD:Cancel()
	timerWhirlCD:Cancel()
	warnSubmerge:Show()
	timerEmerge:Start()
	self:ScheduleMethod(60, "Emerged")
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.submerged = false
	timerWhirlCD:Start(62.5-44.35-delay) -- REVIEW! variance? (25 man FM log 2022/08/11) - 62.5
	timerSpoutCD:Start(35.5+3.8-delay) -- REVIEW! variance? (25 man FM log 2022/08/11) - 35.5
	timerSubmerge:Start(90+1-delay)
	self:ScheduleMethod(90+1-delay, "Submerged")
end

--function mod:SPELL_CAST_START(args)
--	if args.spellId == 20568 then -- Ragnaros Emerge. Fires when boss emerges
--		self:SetStage(1)
--		timerEmerge:Cancel()
--		warnEmerge:Show()
--		timerSubmerge:Start()
--		self:Schedule(60, submerged, self)
--	end
--end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, source)
	if (source or "") == L.name then
		specWarnSpout:Show()
		specWarnSpout:Play("watchwave")
--		timerWhirlCD:Cancel()
		timerSpoutCast:Start()
		timerSpout:Schedule(3) -- takes 3 seconds to start Spout (from EMOTE to UNIT_SPELLCAST_SUCCEEDED)
		timerSpoutCD:Start(60)
		timerWhirlCD:Restart(18)
	end
end

function mod:UNIT_DIED(args)
	local cId = self:GetCIDFromGUID(args.destGUID)
	if cId == 21865 then
		self.vb.ambusherKill = self.vb.ambusherKill + 1
		if self.vb.ambusherKill == 6 and self.vb.guardianKill == 3 and self.vb.submerged then
			self:UnscheduleMethod("Emerged")
			self:ScheduleMethod(2-1.9, "Emerged")
		end
	elseif cId == 21873 then
		self.vb.guardianKill = self.vb.guardianKill + 1
		if self.vb.ambusherKill == 6 and self.vb.guardianKill == 3 and self.vb.submerged then
			self:UnscheduleMethod("Emerged")
			self:ScheduleMethod(2-1.9, "Emerged")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
--	if spellName == GetSpellInfo(28819) and self:AntiSpam(2, 1) then--Submerge Visual
--		DBM:AddMsg("Submerge Visual unhidden from event log. Notify Zidras on Discord or GitHub")
--		self:SendSync("Submerge")
--	elseif spellName == GetSpellInfo(37660) and self:AntiSpam(2, 2) then
	if spellName == GetSpellInfo(37660) and self:AntiSpam(2, 2) then
		self:SendSync("Whirl")
	end
end

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "Submerge" then
--		DBM:AddMsg("Submerge is being synced by something. Notify Zidras on Discord or GitHub with a Transcriptor log")
--[[	self.vb.submerged = true
		self.vb.guardianKill = 0
		self.vb.ambusherKill = 0
		timerSubmerge:Cancel()
		timerSpoutCD:Cancel()
		timerWhirlCD:Cancel()
		warnSubmerge:Show()
		timerEmerge:Start()
		self:Schedule(60, emerged, self)
]]	elseif msg == "Whirl" then
		warnWhirl:Show()
		timerWhirlCD:Start()
	end
end

function mod:OnCombatEnd()
	timerSubmerge:Cancel()
	timerSpoutCD:Cancel()
	timerWhirlCD:Cancel()
	timerEmerge:Cancel()
	self:UnscheduleMethod("Emerged")
	self:UnscheduleMethod("Submerged")
	end
