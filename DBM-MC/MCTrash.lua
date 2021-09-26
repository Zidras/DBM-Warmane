local mod	= DBM:NewMod("MCTrash", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
--mod:SetModelID(47785)


mod.isTrashMod = true

mod:AddSpeedClearOption("MC", true)

--Speed Clear variables
mod.vb.firstEngageTime = nil

--Register all damage events on mod load
mod:RegisterShortTermEvents(
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SWING_DAMAGE",
	"SWING_MISSED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED"
)

--Request speed clear variables, in case it was already started before mod loaded
mod:SendSync("IsMCStarted")

do
	local startCreatureIds = {
		[11658] = true--Molten Giant
	}
	local function checkFirstPull(self, GUID)
		local cid = self:GetCIDFromGUID(GUID)
		if startCreatureIds[cid] then
			if not self.vb.firstEngageTime then
				self.vb.firstEngageTime = time()
				if self.Options.FastestClear2 and self.Options.SpeedClearTimer then
					--Custom bar creation that's bound to core, not mod, so timer doesn't stop when mod stops it's own timers
					DBT:CreateBar(self.Options.FastestClear2, DBM_CORE_L.SPEED_CLEAR_TIMER_TEXT, 136106)
				end
				self:SendSync("MCStarted", self.vb.firstEngageTime)--Also sync engage time
			end
			--Unregister high CPU combat log events
			self:UnregisterShortTermEvents()
		end
	end

	function mod:SPELL_DAMAGE(_, _, _, _, destGUID)
		checkFirstPull(self, destGUID or 0)
	end
	mod.SPELL_MISSED = mod.SPELL_DAMAGE

	function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID)
		checkFirstPull(self, destGUID or 0)
	end
	mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

	function mod:SWING_DAMAGE(_, _, _, _, destGUID)
		checkFirstPull(self, destGUID or 0)
	end
	mod.SWING_MISSED = mod.SWING_DAMAGE

	function mod:OnSync(msg, startTime, sender)
		--Sync recieved with start time and ours is currently not started
		if msg == "MCStarted" and startTime and not self.vb.firstEngageTime then
			self.vb.firstEngageTime = tonumber(startTime)
			if self.Options.FastestClear2 and self.Options.SpeedClearTimer then
				--Custom bar creation that's bound to core, not mod, so timer doesn't stop when mod stops it's own timers
				local adjustment = time() - self.vb.firstEngageTime
				DBT:CreateBar(self.Options.FastestClear2 - adjustment, DBM_CORE_L.SPEED_CLEAR_TIMER_TEXT)
			end
			--Unregister high CPU combat log events
			self:UnregisterShortTermEvents()
		elseif msg == "IsMCStarted" and self.vb.firstEngageTime then
			--Sadly this has to be done with two syncs, one for variables for bosses that have been killed and one to instruct starting of timer
			self:SendSync("MCStarted", self.vb.firstEngageTime)
		end
	end
end
