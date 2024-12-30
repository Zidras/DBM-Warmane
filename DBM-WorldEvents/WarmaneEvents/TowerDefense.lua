local mod	= DBM:NewMod("WarmaneTowerDefense", "DBM-WorldEvents", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241230194607")
mod.noStatistics = true

mod:RegisterEvents(
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

-- General
local warnBossNow					= mod:NewSpellAnnounce(31315, 1)

local timerToRessurect				= mod:NewNextTimer(30, 72423, nil, nil, nil, 6)
local timerCombatStart				= mod:NewCombatTimer(45)

-- Trash
local specWarnSpellReflectDispel	= mod:NewSpecialWarningDispel(36096, "MagicDispeller", nil, nil, 1, 2)
local specWarnHandOfProtectionDispel= mod:NewSpecialWarningDispel(66009, "ImmunityDispeller", nil, nil, 1, 2)

-- Bosses
-- Shade of Aran (400024)
local specWarnCounterspellStopCast	= mod:NewSpecialWarningCast(31999, "SpellCaster", nil, nil, 1, 2) -- TBC spellId
local specWarnIceBlastRun			= mod:NewSpecialWarningRun(73775, "Melee", nil, nil, 4, 2) -- TBC spellId
local specWarnLivingBombMoveAway	= mod:NewSpecialWarningMoveAway(73061, "Melee", nil, nil, 1, 2) -- TBC spellId

-- Azuregos (400052)
local warnReflection				= mod:NewSpellAnnounce(22067, 2)

local specWarnChillDispel			= mod:NewSpecialWarningDispel(21098, "MagicDispeller", nil, nil, 1, 2)

local timerTailSweep				= mod:NewVarTimer("v15-20", 15847, nil, nil, nil, 2) -- 5s variance [15-20] (Lordaeron Horde [2024-12-27]@[13:17:37]) - "Tail Sweep-15847-npc:6836-432 = pull:1152.8, 18.2, 16.3, 18.7, 16.7, 16.3, 16.3, 17.3, 19.6, 16.4"
local timerFrostBreath				= mod:NewVarTimer("v15-20", 21099, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON) -- 5s variance [15-20] (Lordaeron Horde [2024-12-27]@[13:17:37]) - "Frost Breath-21099-npc:6836-432 = pull:1148.1, 18.7, 16.1, 18.6, 15.9, 19.5, 16.5, 15.2, 20.0, 15.8"
local timerNextChill				= mod:NewNextTimer(15, 21098, nil, nil, nil, 2) -- (Lordaeron Horde [2024-12-27]@[13:17:37]) - "Chill-21098-npc:6836-432 = pull:1160.1[+41], 14.7[+10], 0.1[+20], 15.0[+38], 14.9[+26], 15.0[+18], 15.0[+21], 14.9[+21], 15.0[+18], 14.9[+8], 0.1[+18], 14.9, 0.1[+4], 14.9"

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
	elseif spellId == 15847 then -- Tail Sweep
		timerTailSweep:Start()
	elseif spellId == 21099 then -- Frost Breath
		timerFrostBreath:Start()
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
	elseif spellId == 21098 and args:IsDestTypePlayer() then -- Chill
		timerNextChill:Start()
		specWarnChillDispel:Show()
		specWarnChillDispel:Play("dispelnow")
	elseif spellId == 22067 then -- Reflection
		warnReflection:Show()
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
			"SPELL_CAST_START 31999 73775 15847 21099",
			"SPELL_AURA_APPLIED 36096 66009 73061 21098 22067"
		)
	elseif msg:match(L.RoundComplete) then -- victory
		timerCombatStart:Start()
		-- DBM:EndCombat(self)
		self:Stop()
		DBM:AddSpecialEventToTranscriptorLog("Completed round" .. self.vb.roundCounter or "nil")
		self:Unschedule(resurrectionTicker)
		self:UnregisterShortTermEvents()

		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif msg:find(L.RoundFailed) then -- wipe
		-- DBM:EndCombat(self, true)
		self:Stop()
		DBM:AddSpecialEventToTranscriptorLog("Wiped on round" .. self.vb.roundCounter or "nil")
		self:Unschedule(resurrectionTicker)
		self:UnregisterShortTermEvents()

		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end
