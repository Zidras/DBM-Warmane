local mod	= DBM:NewMod("AQ40Trash", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240529121936")
mod:SetModelID(15264) -- Anubisath Sentinel

mod.isTrashMod = true

mod:RegisterEvents(
	--"ENCOUNTER_END",
	"SPELL_AURA_APPLIED 22997 26556 25698 26079",
	"SPELL_AURA_REMOVED 22997 26556",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)

--TODO, meteor those big guys use, maybe some other stuff
--local specWarnPrimalRampage			= mod:NewSpecialWarningDodge(198379, "Melee", nil, nil, 1, 2)

mod:AddRangeFrameOption(10, 22997)
mod:AddSpeedClearOption("AQ40", true)

--Speed Clear variables
mod.vb.firstEngageTime = nil
mod.vb.requiredBosses = 0

--Register all damage events on mod load
local eventsRegistered = true
mod:RegisterShortTermEvents(
	"SWING_DAMAGE",
	"SWING_MISSED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED"
)

--Request speed clear variables, in case it was already started before mod loaded
mod:SendSync("IsAQ40Started")

do-- Anubisath Plague/Explode - keep in sync - AQ40/AQ40Trash.lua AQ20/AQ20Trash.lua
	local warnPlague					= mod:NewTargetNoFilterAnnounce(22997, 2)
	local warnCauseInsanity				= mod:NewTargetNoFilterAnnounce(26079, 2)

	local specWarnPlague				= mod:NewSpecialWarningMoveAway(22997, nil, nil, nil, 1, 2)
	local yellPlague					= mod:NewYell(22997)
	local specWarnExplode				= mod:NewSpecialWarningRun(25698, "Melee", nil, 3, 4, 2)

	-- aura applied didn't seem to catch the reflects and other buffs
	function mod:SPELL_AURA_APPLIED(args)
		local spellId = args.spellId
		if spellId == 22997 or spellId == 26556 then
			if args:IsPlayer() then
				specWarnPlague:Show()
				specWarnPlague:Play("runout")
				yellPlague:Yell()
				if self.Options.RangeFrame then
					DBM.RangeCheck:Show(10)
				end
			else
				warnPlague:Show(args.destName)
			end
		elseif spellId == 25698 then
			specWarnExplode:Show()
			specWarnExplode:Play("justrun")
		elseif spellId == 26079 then
			warnCauseInsanity:CombinedShow(0.75, args.destName)
		end
	end

	function mod:SPELL_AURA_REMOVED(args)
		if args.spellId == 22997 or args.spellId == 26556 then
			if args:IsPlayer() and self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

do
	local startCreatureIds = {
		[15264] = true,--Anubisath Sentinel
		[15262] = true--Obsidian Eradicator
	}
	local function checkFirstPull(self, GUID)
		local cid = self:GetCIDFromGUID(GUID)
		if startCreatureIds[cid] then
			if not self.vb.firstEngageTime then
				self.vb.firstEngageTime = time()
				if self.Options.FastestClear3 and self.Options.SpeedClearTimer then
					--Custom bar creation that's bound to core, not mod, so timer doesn't stop when mod stops it's own timers
					DBT:CreateBar(self.Options.FastestClear3, DBM_CORE_L.SPEED_CLEAR_TIMER_TEXT, "Interface\\Icons\\Spell_Nature_TimeStop")
				end
				self:SendSync("AQ40Started", self.vb.firstEngageTime)--Also sync engage time
			end
			--Unregister high CPU combat log events
			self:UnregisterShortTermEvents()
			eventsRegistered = false
		end
	end

	-- Anubisath Reflect - keep in sync - AQ40/AQ40Trash.lua AQ20/AQ20Trash.lua
	local specWarnShadowFrostReflect	= mod:NewSpecialWarningReflect(19595, nil, nil, nil, 1, 2)
	local specWarnFireArcaneReflect		= mod:NewSpecialWarningReflect(13022, nil, nil, nil, 1, 2)
	local specWarnShadowStorm			= mod:NewSpecialWarningMoveTo(26555, nil, nil, nil, 1, 2)

	-- todo: thorns
	local playerGUID = UnitGUID("player")
	function mod:SPELL_DAMAGE(_, sourceName, _, destGUID, _, _, spellId)
		if spellId == 26555 and destGUID == playerGUID and self:AntiSpam(3, 3) then
			specWarnShadowStorm:Show(sourceName)
			specWarnShadowStorm:Play("findshelter")
		end
		if eventsRegistered then-- for AQ40 timer
			checkFirstPull(self, destGUID or 0)
		end
	end
	function mod:SPELL_MISSED(sourceGUID, _, _, destGUID, destName, _, _, _, spellSchool, missType)
		if (missType == "REFLECT" or missType == "DEFLECT") and sourceGUID == playerGUID then
			if (spellSchool == 32 or spellSchool == 16) and self:AntiSpam(3, 1) then
				specWarnShadowFrostReflect:Show(destName)
				specWarnShadowFrostReflect:Play("stopattack")
			elseif (spellSchool == 4 or spellSchool == 64) and self:AntiSpam(3, 2) then
				specWarnFireArcaneReflect:Show(destName)
				specWarnFireArcaneReflect:Play("stopattack")
			end
		end
		if eventsRegistered then-- for AQ40 timer
			checkFirstPull(self, destGUID or 0)
		end
	end

	function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID)
		checkFirstPull(self, destGUID or 0)
	end
	mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

	function mod:SWING_DAMAGE(_, _, _, destGUID)
		checkFirstPull(self, destGUID or 0)
	end
	mod.SWING_MISSED = mod.SWING_DAMAGE

--[[	local function updateDefeatedBosses(self, encounterId)
		if self:AntiSpam(10, encounterId) then
			if encounterId == 710 or encounterId == 713 or encounterId == 716 or encounterId == 717 or encounterId == 714 then
				self.vb.requiredBosses = self.vb.requiredBosses + 1
				if self.vb.requiredBosses == 5 then
					DBT:CancelBar(DBM_CORE_L.SPEED_CLEAR_TIMER_TEXT)
					if self.vb.firstEngageTime then
						local thisTime = time() - self.vb.firstEngageTime
						if thisTime and thisTime > 0 then
							if not self.Options.FastestClear3 then
								--First clear, just show current clear time
								DBM:AddMsg(DBM_CORE_L.RAID_DOWN:format("AQ40", DBM:strFromTime(thisTime)))
								self.Options.FastestClear3 = thisTime
							elseif (self.Options.FastestClear3 > thisTime) then
								--Update record time if this clear shorter than current saved record time and show users new time, compared to old time
								DBM:AddMsg(DBM_CORE_L.RAID_DOWN_NR:format("AQ40", DBM:strFromTime(thisTime), DBM:strFromTime(self.Options.FastestClear3)))
								self.Options.FastestClear3 = thisTime
							else
								--Just show this clear time, and current record time (that you did NOT beat)
								DBM:AddMsg(DBM_CORE_L.RAID_DOWN_L:format("AQ40", DBM:strFromTime(thisTime), DBM:strFromTime(self.Options.FastestClear3)))
							end
						end
						self.vb.firstEngageTime = nil
					end
				end
			end
		end
	end
 ]]
	function mod:OnSync(msg, timeOrEncounter, sender)
		--Sync recieved with start time and ours is currently not started
		--The reason this doesn't just check self.vb.firstEngageTime is nil, because it might not be if SendVariableInfo send it first
		if msg == "AQ40Started" and timeOrEncounter --[[ and not DBT:GetBar(DBM_CORE_L.SPEED_CLEAR_TIMER_TEXT) ]] then
			if not self.vb.firstEngageTime then
				self.vb.firstEngageTime = tonumber(timeOrEncounter)
			end
			if self.Options.FastestClear3 and self.Options.SpeedClearTimer then
				--Custom bar creation that's bound to core, not mod, so timer doesn't stop when mod stops it's own timers
				local adjustment = time() - self.vb.firstEngageTime
				DBT:CreateBar(self.Options.FastestClear3 - adjustment, DBM_CORE_L.SPEED_CLEAR_TIMER_TEXT, "Interface\\Icons\\Spell_Nature_TimeStop")
			end
			--Unregister high CPU combat log events
			self:UnregisterShortTermEvents()
		elseif msg == "IsAQ40Started" and self.vb.firstEngageTime then
			--Sadly this has to be done with two syncs, one for variables for bosses that have been killed and one to instruct starting of timer
			self:SendSync("AQ40Started", self.vb.firstEngageTime)
			--Send all variables from the mod.vb table in whisper comm to requester (and not sent to whole raid)
			--This is sadly still going to generate a LOT of comm traffic on zone in. upwards of 4-117 syncs, per player zone in
			--Reviewing code, it's hard to do this in less comms, it's either don't support recovering the speed clear timer in all situations (disconnect, reloadui, zoning in late) or cause a burst of syncs :\
			DBM:SendVariableInfo(self, sender)
		--[[ elseif msg == "EncounterEnd" and timeOrEncounter then
			updateDefeatedBosses(self, timeOrEncounter)--In case player misses event (ie they released or are outside the raid for that particular boss ]]
		end
	end

	--[[function mod:ENCOUNTER_END(encounterId, _, _, _, success)
		if success == 0 then return end--wipe
		--All the required bosses for the raid to be full cleared.
		if encounterId == 710 or encounterId == 713 or encounterId == 716 or encounterId == 717 or encounterId == 714 then
			updateDefeatedBosses(self, encounterId)--Still want to fire this on event because the event will always be faster than sync
			self:SendSync("EncounterEnd", encounterId)
		end
	end]]
end
