local mod	= DBM:NewMod("Noth", "DBM-Naxx", 3)
local L		= mod:GetLocalizedStrings()

local GetSpellInfo = GetSpellInfo

mod:SetRevision("20240715212942")
mod:SetCreatureID(15954)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 29213 54835 29212 29208 29209 29210 29211",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnTeleportNow	= mod:NewAnnounce("WarningTeleportNow", 3, 46573, nil, nil, nil, 29216)
local warnTeleportSoon	= mod:NewAnnounce("WarningTeleportSoon", 1, 46573, nil, nil, nil, 29216)
local warnCurse			= mod:NewSpellAnnounce(29213, 2)
local warnBlinkSoon		= mod:NewSoonAnnounce(29208, 1)
local warnBlink			= mod:NewSpellAnnounce(29208, 3)

local specWarnAdds		= mod:NewSpecialWarningAdds(29247, "-Healer", nil, nil, 1, 2)

local timerTeleport		= mod:NewTimer(90, "TimerTeleport", 46573, nil, nil, 6, nil, nil, nil, nil, nil, nil, nil, 29216)
local timerTeleportBack	= mod:NewTimer(70, "TimerTeleportBack", 46573, nil, nil, 6, nil, nil, nil, nil, nil, nil, nil, 29231)
local timerCurseCD		= mod:NewCDTimer(56.7, 29213, nil, nil, nil, 5, nil, DBM_COMMON_L.CURSE_ICON) -- REVIEW! variance? (25man Frostmourne 2022/05/25 || 25man Lordaeron 2022/10/16) -  56.7, 99.1! || 57.4
local timerAddsCD		= mod:NewAddsTimer(30, 29247, nil, "-Healer")
local timerBlink		= mod:NewNextTimer(30, 29208) -- (25N Lordaeron 2022/10/16) - 30.1, 30.0

--local timerBerserk		= mod:NewBerserkTimer(665.07) -- spellId = 27680

mod:GroupSpells(29216, 29231) -- Teleport, Teleport Return

mod.vb.teleCount = 0
mod.vb.addsCount = 0
mod.vb.curseCount = 0
mod.vb.blinkCount = 0
local teleportBalconyName = GetSpellInfo(29216) -- Teleport
local teleportBackName = GetSpellInfo(29231) -- Teleport Return

--[[function mod:Balcony()
	self.vb.teleCount = self.vb.teleCount + 1
	self.vb.addsCount = 0
	timerCurseCD:Stop()
	timerAddsCD:Stop()
	timerBlink:Stop()
	local timer
	if self.vb.teleCount == 1 then
		timer = 70
		timerAddsCD:Start(5)--Always 5
	elseif self.vb.teleCount == 2 then
		timer = 97
		timerAddsCD:Start(5)--Always 5
	elseif self.vb.teleCount == 3 then
		timer = 126
		timerAddsCD:Start(5)--Always 5
	else
		timer = 55
	end
	timerTeleportBack:Start(timer)
	warnTeleportSoon:Schedule(timer - 10)
	warnTeleportNow:Schedule(timer)
--	self:ScheduleMethod(timer, "BackInRoom")
end

function mod:BackInRoom(delay)
	delay = delay or 0
	self:SetStage(0)
	local timer
	if self.vb.phase == 1 then timer = 90 - delay
	elseif self.vb.phase == 2 then timer = 110 - delay
	elseif self.vb.phase == 3 then timer = 180 - delay
	else return end
	timerTeleport:Show(timer)
	warnTeleportSoon:Schedule(timer - 10)
	warnTeleportNow:Schedule(timer)
	self:ScheduleMethod(timer, "Balcony")
end]]

function mod:OnCombatStart(delay)
	self.vb.phase = 0
	self.vb.teleCount = 0
	self.vb.addsCount = 0
	self.vb.curseCount = 0
	self.vb.blinkCount = 0
	timerAddsCD:Start(-delay)
	timerCurseCD:Start(15-delay) -- REVIEW! variance? (25man Lordaeron 2022/10/16) - 15.0
	timerBlink:Start(23.8-delay) -- REVIEW! variance? (25man Lordaeron 2022/10/16) - 23.8
	warnBlinkSoon:Schedule(18.8-delay)
	timerTeleport:Start(90-delay)
	warnTeleportSoon:Schedule(80-delay)
--	self:ScheduleMethod(90.8-delay, "Balcony")
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(29213, 54835) then	-- Curse of the Plaguebringer
		self.vb.curseCount = self.vb.curseCount + 1
		warnCurse:Show()
		if self.vb.teleCount == 2 and self.vb.curseCount == 2 or self.vb.teleCount == 3 and self.vb.curseCount == 1 then
			timerCurseCD:Start(67)--Niche cases it's 67 and not 53-55
		elseif self.vb.curseCount < 2 then
			timerCurseCD:Start()
		end
--	elseif args.spellId == 29212 then--Cripple that's always cast when he teleports away

	elseif args:IsSpellID(29208, 29209, 29210, 29211) and args:GetDestCreatureID() == 15954 then -- Blink
		self.vb.blinkCount = self.vb.blinkCount + 1
		warnBlink:Show()
		if self.vb.blinkCount < 3 then
			timerBlink:Start()
			warnBlinkSoon:Schedule(25)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Adds or msg:find(L.Adds) then
		self:SendSync("Adds")--Syncing to help unlocalized clients
	elseif msg == L.AddsTwo or msg:find(L.AddsTwo) then
		self:SendSync("AddsTwo")--Syncing to help unlocalized clients
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName ==  teleportBalconyName then -- Teleport
		self.vb.teleCount = self.vb.teleCount + 1
		DBM:AddSpecialEventToTranscriptorLog(format("Teleport %d", self.vb.teleCount))
		self.vb.addsCount = 0
		timerCurseCD:Stop()
		timerAddsCD:Stop()
		timerBlink:Stop()
		warnBlinkSoon:Cancel()
		local timer
		if self.vb.teleCount == 1 then
			timer = 70
			timerAddsCD:Start(5)--Always 5
		elseif self.vb.teleCount == 2 then
			timer = 97
			timerAddsCD:Start(5)--Always 5
		elseif self.vb.teleCount == 3 then
			timer = 126
			timerAddsCD:Start(5)--Always 5
		else
			timer = 55
		end
		timerTeleportBack:Start(timer)
		warnTeleportSoon:Schedule(timer - 10)
		warnTeleportNow:Show()
	elseif spellName ==  teleportBackName then -- Teleport Return
		DBM:AddSpecialEventToTranscriptorLog("Teleport Return")
		self.vb.addsCount = 0
		self.vb.curseCount = 0
		timerAddsCD:Stop()
		local timer
		if self.vb.teleCount == 1 then
			timer = 109
			timerAddsCD:Start(10)
		elseif self.vb.teleCount == 2 then
			timer = 173
			timerAddsCD:Start(17)
		elseif self.vb.teleCount == 3 then
			timer = 93
		else
			timer = 35
		end
		timerTeleport:Start(timer)
		warnTeleportSoon:Schedule(timer - 10)
		warnTeleportNow:Show()
		if self.vb.teleCount == 4 then--11-12 except after 4th return it's 17
			timerCurseCD:Start(17)--verify consistency though
		else
			timerCurseCD:Start(11)
		end
--		self:ScheduleMethod(timer, "Balcony")
	end
end

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "Adds" then--Boss Grounded
		self.vb.addsCount = self.vb.addsCount + 1
		specWarnAdds:Show()
		specWarnAdds:Play("killmob")
		if self.vb.teleCount < 4 then
			if self.vb.teleCount == 0 and self.vb.addsCount < 3 then--3 waves 30 seconds apart
				timerAddsCD:Start(30)
			elseif self.vb.teleCount == 1 then--3 waves 34 then 47 seconds apart
				if self.vb.addsCount == 1 then
					timerAddsCD:Start(33.9)
				elseif self.vb.addsCount == 1 then
					timerAddsCD:Start(47.3)
				end
			elseif self.vb.teleCount == 2 then--30, 32, 32, 30
				if self.vb.addsCount == 1 or self.vb.addsCount == 4 then
					timerAddsCD:Start(30)
				elseif self.vb.addsCount == 2 or self.vb.addsCount == 3 then
					timerAddsCD:Start(32)
				end
			end
		end
	elseif msg == "AddsTwo" then--Boss away
		self.vb.addsCount = self.vb.addsCount + 1
		specWarnAdds:Show()
		specWarnAdds:Play("killmob")
		--He won't do anymore adds when teleported way on 4th and later teleport
		--He'll never do more than 2 waves
		if self.vb.teleCount < 4 and self.vb.addsCount == 1 then
			if self.vb.teleCount == 3 then
				timerAddsCD:Start(60)--2 big waves, 60 seconds apart
			elseif self.vb.teleCount == 2 then--2 medium waves 46 seconds apart
				timerAddsCD:Start(46)
			else--2 smaller waves 30 seconds apart
				timerAddsCD:Start(30)
			end
		end
	end
end
