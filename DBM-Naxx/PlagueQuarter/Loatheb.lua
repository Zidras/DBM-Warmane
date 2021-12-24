local mod	= DBM:NewMod("Loatheb", "DBM-Naxx", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2568 $"):sub(12, -3))
mod:SetCreatureID(16011)

mod:RegisterCombat("combat")--Maybe change to a yell later so pull detection works if you chain pull him from tash gauntlet

mod:EnableModel()

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 29234 29204 55052 55593",
	"SPELL_DAMAGE",
	"SWING_DAMAGE",
	"UNIT_DIED"
)

local warnSporeNow	= mod:NewSpellAnnounce(32329, 2)
local warnSporeSoon	= mod:NewSoonAnnounce(32329, 1)
local warnDoomNow	= mod:NewSpellAnnounce(29204, 3)
local warnHealSoon	= mod:NewAnnounce("WarningHealSoon", 4, 48071)
local warnHealNow	= mod:NewAnnounce("WarningHealNow", 1, 48071, false)

local timerSpore	= mod:NewNextTimer(36, 32329, nil, nil, nil, 5, 42524, DBM_CORE_L.DAMAGE_ICON)
local timerDoom		= mod:NewNextTimer(180, 29204, nil, nil, nil, 2)
local timerAura		= mod:NewBuffActiveTimer(17, 55593, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)

mod:AddBoolOption("SporeDamageAlert", false)

mod.vb.doomCounter	= 0
mod.vb.sporeTimer	= 36

function mod:OnCombatStart(delay)
	self.vb.doomCounter = 0
	if self:IsDifficulty("normal25") then
		self.vb.sporeTimer = 18
	else
		self.vb.sporeTimer = 36
	end
	timerSpore:Start(self.vb.sporeTimer - delay)
	warnSporeSoon:Schedule(self.vb.sporeTimer - 5 - delay)
	timerDoom:Start(120 - delay, self.vb.doomCounter + 1)
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 29234 then
		timerSpore:Start(self.vb.sporeTimer)
		warnSporeNow:Show()
		warnSporeSoon:Schedule(self.vb.sporeTimer - 5)
	elseif args:IsSpellID(29204, 55052) then  -- Inevitable Doom
		self.vb.doomCounter = self.vb.doomCounter + 1
		local timer = 30
		if self.vb.doomCounter >= 7 then
			if self.vb.doomCounter % 2 == 0 then timer = 17
			else timer = 12 end
		end
		warnDoomNow:Show(self.vb.doomCounter)
		timerDoom:Start(timer, self.vb.doomCounter + 1)
	elseif spellId == 55593 then
		timerAura:Start()
		warnHealSoon:Schedule(14)
		warnHealNow:Schedule(17)
	end
end

--Spore loser function. Credits to Forte guild and their old discontinued dbm plugins. Sad to see that guild disband, best of luck to them!
function mod:SPELL_DAMAGE(_, sourceName, _, _, destName, _, spellId, _, _, amount)
	if self.Options.SporeDamageAlert and destName == "Spore" and spellId ~= 62124 and self:IsInCombat() then
		SendChatMessage(sourceName..", You are damaging a Spore!!! ("..amount.." damage)", "RAID_WARNING")
		SendChatMessage(sourceName..", You are damaging a Spore!!! ("..amount.." damage)", "WHISPER", nil, sourceName)
	end
end

function mod:SWING_DAMAGE(_, sourceName, _, _, destName, _, _, _, _, amount)
	if self.Options.SporeDamageAlert and destName == "Spore" and self:IsInCombat() then
		SendChatMessage(sourceName..", You are damaging a Spore!!! ("..amount.." damage)", "RAID_WARNING")
		SendChatMessage(sourceName..", You are damaging a Spore!!! ("..amount.." damage)", "WHISPER", nil, sourceName)
	end
end

--because in all likelyhood, pull detection failed (cause 90s like to chargein there trash and all and pull it
--We unschedule the pre warnings on death as a failsafe
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 16011 then
		warnSporeSoon:Cancel()
		warnHealSoon:Cancel()
		warnHealNow:Cancel()
	end
end