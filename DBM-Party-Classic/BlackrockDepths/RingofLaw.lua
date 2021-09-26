local mod	= DBM:NewMod(372, "DBM-Party-Classic", 2, 228)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(9028, 9031, 9029, 9030, 9032, 9027)--Register combat with any of the 6

mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_DIED"
)

function mod:OnCombatStart(delay)
	self.vb.bossLeft = 1--Force set number of bosses we expect to kill to 1 on engage for wipe/boss statistics
	self.numBoss = 1--^^
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	--Grizzle, Anub'shiah, Eviscerator, Ok'thor the Breaker, Hedrum the Creeper, Gorosh the Dervish
	if cid == 9028 or cid == 9031 or cid == 9029 or cid == 9030 or cid == 9032 or cid == 9027 then
		--self.vb.bossLeft = self.vb.bossLeft - 1
		--if self.vb.bossLeft == 0 then
			DBM:EndCombat(self)
		--end
	end
end
