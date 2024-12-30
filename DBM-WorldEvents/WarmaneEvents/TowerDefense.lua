local mod	= DBM:NewMod("WarmaneTowerDefense", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241230183312")
mod.noStatistics = true

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnBossNow					= mod:NewSpellAnnounce(31315, 1)

local specWarnSpellReflectDispel	= mod:NewSpecialWarningDispel(36096, "MagicDispeller", nil, nil, 1, 2)
local specWarnHandOfProtectionDispel= mod:NewSpecialWarningDispel(66009, "ImmunityDispeller", nil, nil, 1, 2)
-- Shade of Aran
local specWarnCounterspellStopCast	= mod:NewSpecialWarningCast(31999, "SpellCaster", nil, nil, 1, 2) -- TBC spellId
local specWarnIceBlastRun			= mod:NewSpecialWarningRun(73775, "Melee", nil, nil, 4, 2) -- TBC spellId
local specWarnLivingBombMoveAway	= mod:NewSpecialWarningMoveAway(73061, "Melee", nil, nil, 1, 2) -- TBC spellId

local timerToRessurect				= mod:NewNextTimer(30, 72423, nil, nil, nil, 6)
local timerCombatStart				= mod:NewCombatTimer(45)

mod:AddRangeFrameOption(15, 73775) -- TBC spellId
mod:RemoveOption("HealthFrame")

mod.vb.roundCounter = 0

local function resurrectionTicker(self)
	timerToRessurect:Start()
	self:Schedule(30, resurrectionTicker, self)
end

-- function mod:OnCombatStart(delay)
-- end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 31999 then -- Counterspell
		specWarnCounterspellStopCast:Show()
		specWarnCounterspellStopCast:Play("stopcast")
	elseif spellId == 73775 then -- Ice Blast
		specWarnIceBlastRun:Show()
		specWarnIceBlastRun:Play("runout")

		if self.Options.RangeFrame then
			if not DBM.RangeCheck:IsShown() then
				DBM.RangeCheck:Show(15)
				DBM.RangeCheck:SetHideTime(3) -- boss casted for 2.86s with Curse of Tongues, 2.20s without
			end

			DBM.RangeCheck:SetBossRange(15, self:GetBossUnitByCreatureId(400024)) -- Shade of Aran
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 36096 and args:IsDestTypeHostile() then -- Spell Reflection
		specWarnSpellReflectDispel:Show()
		specWarnSpellReflectDispel:Play("dispelboss")
	elseif spellId == 66009 and args:IsDestTypeHostile() then -- Hand of Protection
		specWarnHandOfProtectionDispel:Show()
		specWarnHandOfProtectionDispel:Play("dispelboss")
	elseif spellId == 73061 and args:IsDestTypePlayer() then -- Living Bomb
		specWarnLivingBombMoveAway:Show()
		specWarnLivingBombMoveAway:Play("runout")
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:match(L.RoundStart) then
		self.vb.roundCounter = msg:match(L.RoundStart)
		-- DBM:StartCombat(self, 0, "MONSTER_MESSAGE")
		DBM:AddSpecialEventToTranscriptorLog("Started round" .. self.vb.roundCounter or "nil")
		resurrectionTicker()
		if (self.vb.roundCounter % 4 == 0) then -- Boss spawns every 4 rounds
			warnBossNow:Show()
		end
		self:RegisterShortTermEvents(
			"SPELL_CAST_START 31999 73775",
			"SPELL_AURA_APPLIED 36096 66009 73061"
		)
	elseif msg:match(L.RoundComplete) then -- victory
		timerCombatStart:Start()
		-- DBM:EndCombat(self)
		-- self:Stop()
		DBM:AddSpecialEventToTranscriptorLog("Completed round" .. self.vb.roundCounter or "nil")
		timerToRessurect:Stop()

		self:Unschedule(resurrectionTicker)
		self:UnregisterShortTermEvents()

		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif msg:find(L.RoundFailed) then -- wipe
		-- DBM:EndCombat(self, true)
		-- self:Stop()
		DBM:AddSpecialEventToTranscriptorLog("Wiped on round" .. self.vb.roundCounter or "nil")
		timerToRessurect:Stop()
		self:Unschedule(resurrectionTicker)
		self:UnregisterShortTermEvents()

		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end
