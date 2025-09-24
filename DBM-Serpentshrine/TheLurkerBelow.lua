local mod	= DBM:NewMod("LurkerBelow", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250213133410")
mod:SetCreatureID(21217)

--mod:SetModelID(20216)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 20568",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	--"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnSubmerge		= mod:NewAnnounce("WarnSubmerge", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerge		= mod:NewAnnounce("WarnEmerge", 1, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnWhirl			= mod:NewSpellAnnounce(37363, 2)

local specWarnSpout		= mod:NewSpecialWarningSpell(37433, nil, nil, nil, 2, 2)

local timerSubmerge		= mod:NewTimer(120, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6)
local timerEmerge		= mod:NewTimer(60, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)
local timerSpoutCD		= mod:NewCDTimer(71, 37433, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON) -- REVIEW! variance? (25 man FM log 2022/08/11) - 118.5 (happened right after emerge)
local timerSpoutCast	= mod:NewCastTimer(3, 37433, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerSpout		= mod:NewBuffActiveTimer(22, 37433, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerWhirlCD		= mod:NewCDTimer(18, 37363, nil, nil, nil, 2, nil, nil, true) -- REVIEW! variance? (25 man FM log 2022/08/11) - 18.0, (after emerge) 100.5

mod.vb.submerged = false
--mod.vb.guardianKill = 0
--mod.vb.ambusherKill = 0

local whirlName = GetSpellInfo(37660)

--[[
local function emerged(self)
	self.vb.submerged = false
	timerEmerge:Cancel()
	warnEmerge:Show()
	timerSubmerge:Start()
end
]]

local function submerged(self)
	self:SetStage(2)
	self.vb.submerged = true
	self.vb.guardianKill = 0
	self.vb.ambusherKill = 0
	timerSubmerge:Cancel()
	timerSpoutCD:Cancel()
	timerWhirlCD:Cancel()
	warnSubmerge:Show()
	timerEmerge:Start()
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.submerged = false
	timerWhirlCD:Start(-delay)
	timerSpoutCD:Start(36-delay)
	timerSubmerge:Start(90-delay)
	self:Schedule(90-delay, submerged, self)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 20568 then -- Ragnaros Emerge. Fires when boss emerges
		self:SetStage(1)
		timerEmerge:Cancel()
		warnEmerge:Show()
		timerSubmerge:Start()
		self:Schedule(120, submerged, self)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, source)
	if (source or "") == L.name then
		specWarnSpout:Show()
		specWarnSpout:Play("watchwave")
		timerSpoutCast:Start()
		timerSpout:Schedule(3) -- takes 3 seconds to start Spout (from EMOTE to UNIT_SPELLCAST_SUCCEEDED)
		timerSpoutCD:Start()
	end
end

-- Onyxia PTR as of 13.02.2025 it fires SPELL_CAST_START with spellId 20568 on emerge each time
--[[
function mod:UNIT_DIED(args)
	local cId = self:GetCIDFromGUID(args.destGUID)
	if cId == 21865 then
		self.vb.ambusherKill = self.vb.ambusherKill + 1
		if self.vb.ambusherKill == 6 and self.vb.guardianKill == 3 and self.vb.submerged then
			self:Unschedule(emerged)
			self:Schedule(2, emerged, self)
		end
	elseif cId == 21873 then
		self.vb.guardianKill = self.vb.guardianKill + 1
		if self.vb.ambusherKill == 6 and self.vb.guardianKill == 3 and self.vb.submerged then
			self:Unschedule(emerged)
			self:Schedule(2, emerged, self)
		end
	end
end
]]

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	--[[if spellName == GetSpellInfo(28819) and self:AntiSpam(2, 1) then--Submerge Visual
		DBM:AddMsg("Submerge Visual unhidden from event log. Notify Zidras on Discord or GitHub")
		self:SendSync("Submerge")]]
	if spellName == whirlName and self:AntiSpam(2, 2) then
		self:SendSync("Whirl")
	end
end

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "Submerge" then
		DBM:AddMsg("Submerge is being synced by something. Notify Zidras on Discord or GitHub with a Transcriptor log")
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
