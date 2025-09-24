local mod	= DBM:NewMod("Noth-Vanilla", "DBM-VanillaNaxx", 3)
local L		= mod:GetLocalizedStrings()

local GetSpellInfo = GetSpellInfo

mod:SetRevision("20240730223300")
mod:SetCreatureID(15954)

mod:RegisterCombat("combat_yell", L.Pull)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 29213 54835 29212 29208 29209 29210 29211",
	"CHAT_MSG_RAID_BOSS_EMOTE", -- 2024/07/14 it was confirmed to be left out of the script on purpose, to keep it Vanilla.
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
local timerCurseCD		= mod:NewCDTimer(50, 29213, nil, nil, nil, 5, nil, DBM_COMMON_L.CURSE_ICON) -- REVIEW! variance? (Onyxia PTR: [2024-07-13]@[13:54:46]) - "Curse of the Plaguebringer-29213-npc:15954-267 = pull:9.98, 50.05, 117.46"
local timerAddsCD		= mod:NewAddsTimer(30, 29247, nil, "-Healer") -- (missing beg) 8.19 > 38.23 > (TP: 68.20) > 70.20 > 100.19 > (TP return: 138.22) > 148.21 > 178.22 > 208.24 > 238.25 > (TP: 248.24) > 250.24 > 295.26 > (TP return:338.26) > 348.26 > 378.26 > 408.26 > 438.29 > 468.30 > 498.29 > (TP: 518.27) > 520.27 > 580.28 > (TP return: 643.28) > 653.29 > 683.29 > 713.31 > 743.31 > 773.32 > 803.31 > (TP: 823.29) > 825.31 > 885.31 > (TP return: 948.30) > 958.32 > 988.35 > 1018.34 > 1048.34 > 1078.35 > 1108.34 > (TP: 1128.33) > 1130.35 > 1190.35
local timerBlink		= mod:NewNextTimer(30, 29208) -- No variance (Onyxia PTR: [2024-07-13]@[13:54:46]) - "Blink-npc:15954-267 = pull:22.57, 30.03, 30.03"

local timerBerserk		= mod:NewBerserkTimer(665.07) -- spellId = 27680

mod:GroupSpells(29216, 29231) -- Teleport, Teleport Return

mod.vb.teleCount = 0
mod.vb.addsCount = 0
mod.vb.curseCount = 0
mod.vb.blinkCount = 0
local teleported = false
local teleportBalconyName = GetSpellInfo(29216) -- Teleport
local teleportBackName = GetSpellInfo(29231) -- Teleport Return
-- Ground phase
local summonPlaguedWarriorName = GetSpellInfo(29247)
-- Balcony phase, 1st teleport (Champions only)
local summonPlaguedChampionName = GetSpellInfo(29217)
-- Balcony phase, 2nd teleport (2 Champions and 2 Guardians)
local summonPlaguedGuardianName = GetSpellInfo(29226)
-- Balcony phase, 3rd teleport (3 Guardians + 1 Guardian and Construct)
local summonPlaguedGuardianAndConstructName = GetSpellInfo(29269)
-- Balcony phase, 4st teleport onwards (3 Guardians + 1 Guardian and Construct ; 3 Guardians + 1 Champion and Construct)
local summonPlaguedChampionAndConstructName = GetSpellInfo(29240)

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
	teleported = false
	timerAddsCD:Start(-delay)
	timerCurseCD:Start(10-delay)
	timerBlink:Start(22.57-delay)
	warnBlinkSoon:Schedule(17.57-delay)
	timerTeleport:Start(-delay)
	warnTeleportSoon:Schedule(80-delay)
--	self:ScheduleMethod(90.8-delay, "Balcony")
	timerBerserk:Start(-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(29213, 54835) then	-- Curse of the Plaguebringer
		self.vb.curseCount = self.vb.curseCount + 1
		warnCurse:Show()
		timerCurseCD:Start()
--	elseif args.spellId == 29212 then--Cripple that's always cast when he teleports away

	elseif args:IsSpellID(29208, 29209, 29210, 29211) and args:GetSrcCreatureID() == 15954 then -- Blink
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
		DBM:AddMsg("Noth adds emote implemented on Warmane Onyxia server script. Notify Zidras on Discord or GitHub")
--		self:SendSync("Adds")--Syncing to help unlocalized clients
	elseif msg == L.AddsTwo or msg:find(L.AddsTwo) then
		DBM:AddMsg("Noth adds2 emote implemented on Warmane Onyxia server script. Notify Zidras on Discord or GitHub")
--		self:SendSync("AddsTwo")--Syncing to help unlocalized clients
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName ==  teleportBalconyName then -- Teleport
		self.vb.teleCount = self.vb.teleCount + 1
		DBM:AddSpecialEventToTranscriptorLog(format("Teleport %d", self.vb.teleCount))
		self.vb.addsCount = 0
		teleported = true
		timerCurseCD:Stop()
--		timerAddsCD:Stop()
		timerBlink:Stop()
		warnBlinkSoon:Cancel()
		local timer
		if self.vb.teleCount == 1 then
			timer = 70
--			timerAddsCD:Start(5)--Always 5
		elseif self.vb.teleCount == 2 then
			timer = 90
--			timerAddsCD:Start(5)--Always 5
		else
			timer = 125
		end
		timerTeleportBack:Start(timer)
		warnTeleportSoon:Schedule(timer - 10)
		warnTeleportNow:Show()
	elseif spellName ==  teleportBackName then -- Teleport Return
		DBM:AddSpecialEventToTranscriptorLog("Teleport Return")
		self.vb.addsCount = 0
		self.vb.curseCount = 0
		teleported = false
--		timerAddsCD:Stop()
		local timer
		if self.vb.teleCount == 1 then
			timer = 110
--			timerAddsCD:Start(10)
		else
			timer = 180
		end
		timerTeleport:Start(timer)
		warnTeleportSoon:Schedule(timer - 10)
		warnTeleportNow:Show()
		if self.vb.teleCount == 1 then -- REVIEW! More data needed. 5s variance? (Onyxia PTR) - 1: [15.25-16.75]; 2: [12.25-15.83]; 3: [13.45-17.52]; 4: [15.71]
			timerCurseCD:Start(15.25)
		elseif self.vb.teleCount == 2 then
			timerCurseCD:Start(12.25)
		elseif self.vb.teleCount == 3 then
			timerCurseCD:Start(13.45)
		else
			timerCurseCD:Start(15.71)
		end
--		self:ScheduleMethod(timer, "Balcony")
	elseif (spellName == summonPlaguedWarriorName or spellName == summonPlaguedChampionName or spellName == summonPlaguedGuardianName or spellName == summonPlaguedGuardianAndConstructName or spellName == summonPlaguedChampionAndConstructName) and self:AntiSpam(2, 1) then
		self.vb.addsCount = self.vb.addsCount + 1
		specWarnAdds:Show()
		specWarnAdds:Play("killmob")
		local teleportRemainingTimer = timerTeleport:GetRemaining()
		local teleportBackRemainingTimer = timerTeleportBack:GetRemaining()
		if not teleported then
			if teleportRemainingTimer > 30 then -- Check if teleport will happen before next Warriors summon
				timerAddsCD:Start() -- always 30s on Warriors
			else
				timerAddsCD:Start(teleportRemainingTimer+2) -- always 2s after teleport to balcony
			end
		else
			-- Check teleport counter, since timing changes with each teleport
			if self.vb.teleCount == 1 then
				if self.vb.addsCount == 1 then
					timerAddsCD:Start(30) -- always 30s on Champions in 1st teleport
				else
					timerAddsCD:Start(teleportBackRemainingTimer+10) -- always 10s after teleport back, regardless of teleport counter
				end
			elseif self.vb.teleCount == 2 then
				if self.vb.addsCount == 1 then
					timerAddsCD:Start(45) -- always 45s on Guardians in 2nd teleport
				else
					timerAddsCD:Start(teleportBackRemainingTimer+10) -- always 10s after teleport back, regardless of teleport counter
				end
			elseif self.vb.teleCount >= 3 then
				if self.vb.addsCount == 1 then
					timerAddsCD:Start(60) -- always 60s on Constructs in 3rd teleport
				else
					timerAddsCD:Start(teleportBackRemainingTimer+10) -- always 10s after teleport back, regardless of teleport counter
				end
			end
		end
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
