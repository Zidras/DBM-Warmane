local mod	= DBM:NewMod("GunshipBattle", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230627225738")
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.KillHorde, L.KillAlliance)
mod:SetCreatureID(36939, 37215, 36948, 37540)

mod:SetHotfixNoticeRev(20220921000000)
mod:SetMinSyncRevision(20220921000000)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 71195 71193 71188 69652 69651 72306 72307 72308 69638 69705",
	"SPELL_AURA_APPLIED_DOSE 72306 69638 72307 72308",
	"SPELL_AURA_REMOVED 69705",
	"SPELL_CAST_START 69705",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

local warnAddsAlliance = mod:NewAnnounce("WarnAddsSoon", 2, 23334) -- Alliance
local warnAddsHorde    = mod:NewAnnounce("WarnAddsSoon", 2, 23336) -- Horde

local timerAddsAlliance = mod:NewTimer(60, "TimerAdds", 23334, nil, nil, 1)
local timerAddsHorde    = mod:NewTimer(60, "TimerAdds", 23336, nil, nil, 1)

local warnAddsSoon
local timerAdds

local warnBelowZero			= mod:NewSpellAnnounce(69705, 4)
local warnExperienced		= mod:NewTargetNoFilterAnnounce(71188, 1, nil, false)
local warnVeteran			= mod:NewTargetNoFilterAnnounce(71193, 2, nil, false)
local warnElite				= mod:NewTargetNoFilterAnnounce(71195, 3, nil, false)
local warnBattleFury		= mod:NewStackAnnounce(69638, 2, nil, "Tank|Healer", 2)
local warnBladestorm		= mod:NewSpellAnnounce(69652, 3, nil, "Melee")
local warnWoundingStrike	= mod:NewTargetNoFilterAnnounce(69651, 2)

local timerCombatStart		= mod:NewCombatTimer(47.5)
local timerBelowZeroCD		= mod:NewNextTimer(35, 69705, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON, nil, 1)
local timerBattleFuryActive	= mod:NewBuffActiveTimer(17, 69638, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

local soundFreeze			= mod:NewSound(69705)

mod:RemoveOption("HealthFrame")

mod.vb.firstMage = false

local function Adds(self) -- no longer on a timed loop, since YELL event is available
	timerAdds:Start()
	warnAddsSoon:Cancel()
	warnAddsSoon:Schedule(55)
end

function mod:OnCombatStart(delay)
	DBM.BossHealth:Clear()
	timerAdds:Start(12-delay)
	warnAddsSoon:Schedule(7-delay)
	self.vb.firstMage = false
	timerBelowZeroCD:Start(39-delay) --Approximate, since it depends on cannon damage. Corrected on yell later
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:find(L.PullAlliance) then
		timerCombatStart:Start()
		warnAddsSoon = warnAddsAlliance
		timerAdds = timerAddsAlliance
	elseif msg:find(L.PullHorde) then
		timerCombatStart:Start(33.9)
		warnAddsSoon = warnAddsHorde
		timerAdds = timerAddsHorde
	end

	if (msg:find(L.AddsAlliance) or msg:find(L.AddsHorde)) and self:IsInCombat() then
		Adds(self)
	end

	if (msg:find(L.MageAlliance) or msg == L.MageAlliance) and self:IsInCombat() then
		if not self.vb.firstMage then
			timerBelowZeroCD:Update(34, 39)
			self.vb.firstMage = true
		else
			timerBelowZeroCD:Update(30, 35)
		end
	elseif (msg:find(L.MageHorde) or msg == L.MageHorde) and self:IsInCombat() then
		if not self.vb.firstMage then
			timerBelowZeroCD:Update(34.5, 39)
			self.vb.firstMage = true
		else
			timerBelowZeroCD:Update(32.5, 35)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	local cid = self:GetCIDFromGUID(args.destGUID)
	if spellId == 71195 then
		warnElite:Show(args.destName)
	elseif spellId == 71193 then
		warnVeteran:Show(args.destName)
	elseif spellId == 71188 then
		warnExperienced:Show(args.destName)
	elseif spellId == 69652 then
		warnBladestorm:Show()
	elseif spellId == 69651 then
		warnWoundingStrike:Show(args.destName)
	elseif args:IsSpellID(69638, 72306, 72307, 72308) and (cid == 36939 or cid == 36948) then
		timerBattleFuryActive:Start()
	elseif spellId == 69705 and self:AntiSpam(1, 1) then
		soundFreeze:Play("Interface\\AddOns\\DBM-Core\\sounds\\Alert.mp3")
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if args:IsSpellID(69638, 72306, 72307, 72308) and (cid == 36939 or cid == 36948) then
		if args.amount % 5 == 0 then
			warnBattleFury:Show(args.destName, args.amount or 1)
		end
		timerBattleFuryActive:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69705 and self:AntiSpam(2, 2) then -- Fires for all Gunship Cannons
		timerBelowZeroCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 69705 then
		warnBelowZero:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(72340) then
		DBM:EndCombat(self)
	end
end