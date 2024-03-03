local mod	= DBM:NewMod("Razorgore", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240303220310")
mod:SetCreatureID(12435, 99999)--Bogus detection to prevent invalid kill detection if razorgore happens to die in phase 1
--mod:DisableEEKillDetection()--So disable only EE
mod:SetModelID(12435)

mod:RegisterCombat("yell", L.YellPull)
mod:SetWipeTime(180)--guesswork

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 22425",
	"SPELL_CAST_SUCCESS 23040 19873",
	"SPELL_AURA_APPLIED 23023",
--	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--ability.id = 22425 and type = "begincast" or (ability.id = 23040 or ability.id = 19873) and type = "cast"
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnFireballVolley	= mod:NewCastAnnounce(22425, 3)
local warnConflagration		= mod:NewTargetAnnounce(23023, 2)
local warnEggsLeft			= mod:NewCountAnnounce(19873, 1)

local specWarnFireballVolley= mod:NewSpecialWarningMoveTo(22425, false, nil, nil, 2, 2)

local timerAddsSpawn		= mod:NewTimer(47, "TimerAddsSpawn", 19879, nil, nil, 1)--Only for start of adds, not adds after the adds.

mod:AddSpeedClearOption("BWL", true)

mod.vb.eggsLeft = 30
mod.vb.firstEngageTime = nil
local destroyEggName = DBM:GetSpellInfo(19873)

function mod:OnCombatStart(delay)
	self:SetStage(1)
	timerAddsSpawn:Start(-delay)
	self.vb.eggsLeft = 30
	if not self.vb.firstEngageTime then
		self.vb.firstEngageTime = time()
		if self.Options.FastestClear and self.Options.SpeedClearTimer then
			--Custom bar creation that's bound to core, not mod, so timer doesn't stop when mod stops it's own timers
			DBT:CreateBar(self.Options.FastestClear, DBM_CORE_L.SPEED_CLEAR_TIMER_TEXT, "Interface\\Icons\\Spell_Nature_TimeStop")
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 22425 and args:IsDestTypePlayer() then
		if self.Options.SpecWarn22425moveto then
			specWarnFireballVolley:Show(DBM_COMMON_L.BREAK_LOS)
			specWarnFireballVolley:Play("findshelter")
		else
			warnFireballVolley:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 23040 and self.vb.phase < 2 then
		warnPhase2:Show()
		self:SetStage(2)
	--This may not be accurate, it depends on how large expanded combat log range is
	elseif spellId == 19873 then
		DBM:AddMsg("Destroy Egg SPELL_CAST_SUCCESS unhidden from combat log. Notify Zidras on Discord or GitHub")
--		self.vb.eggsLeft = self.vb.eggsLeft - 1
--		warnEggsLeft:Show(string.format("%d/%d",30-self.vb.eggsLeft,30))
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 23023 and args:IsDestTypePlayer() then
		warnConflagration:CombinedShow(0.3, args.destName)
	end
end

--[[function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if (msg == L.Phase2Emote or msg:find(L.Phase2Emote)) and self.vb.phase < 2 then
		self:SendSync("Phase2")
	end
end]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 12435 then--Only trigger kill for unit_died if he dies in phase 2 with everyone alive, otherwise it's an auto wipe.
		if DBM:NumRealAlivePlayers() > 0 and self.vb.phase == 2 then
			DBM:EndCombat(self)
		else
			DBM:EndCombat(self, true)--Pass wipe arg end combat
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == destroyEggName then
		self.vb.eggsLeft = self.vb.eggsLeft - 1
		warnEggsLeft:Show(string.format("%d/%d",30-self.vb.eggsLeft,30))
	end
end

--[[function mod:OnSync(msg)
	if msg == "Phase2" and self.vb.phase < 2 then
		warnPhase2:Show()
		self:SetStage(2)
	end
end]]
