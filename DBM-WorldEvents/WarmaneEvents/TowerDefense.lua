local mod	= DBM:NewMod("WarmaneTowerDefense", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241228224813")
mod.noStatistics = true

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnBossNow		= mod:NewSpellAnnounce(31315, 1)

local timerCombatStart	= mod:NewCombatTimer(45)

mod:RemoveOption("HealthFrame")

mod.vb.roundCounter = 0
-- function mod:OnCombatStart(delay)
-- end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:match(L.RoundStart) then
		self.vb.roundCounter = msg:match(L.RoundStart)
		-- DBM:StartCombat(self, 0, "MONSTER_MESSAGE")
		DBM:AddSpecialEventToTranscriptorLog("Started round" .. self.vb.roundCounter or "nil")
		if (self.vb.roundCounter % 4 == 0) then -- Boss spawns every 4 rounds
			warnBossNow:Show()
		end
	elseif msg:match(L.RoundComplete) then -- victory
		timerCombatStart:Start()
		-- DBM:EndCombat(self)
		DBM:AddSpecialEventToTranscriptorLog("Completed round" .. self.vb.roundCounter or "nil")
	elseif msg:find(L.RoundFailed) then -- wipe
		-- DBM:EndCombat(self, true)
		-- self:Stop()
		DBM:AddSpecialEventToTranscriptorLog("Wiped on round" .. self.vb.roundCounter or "nil")
	end
end
