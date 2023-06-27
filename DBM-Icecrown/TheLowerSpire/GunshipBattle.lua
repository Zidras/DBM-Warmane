local mod	= DBM:NewMod("GunshipBattle", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230627225738")
local addsIcon
local bossID
mod:RegisterCombat("combat")
if UnitFactionGroup("player") == "Alliance" then
	--mod:RegisterCombat("yell", L.CombatAlliance)
	mod:RegisterKill("yell", L.KillAlliance)
	mod:SetCreatureID(36939, 37215)	-- High Overlord Saurfang, Orgrim's Hammer
	addsIcon = 23334
	bossID = 36939
else
	--mod:RegisterCombat("yell", L.CombatHorde)
	mod:RegisterKill("yell", L.KillHorde)
	mod:SetCreatureID(36948, 37540)	-- Muradin Bronzebeard, The Skybreaker
	addsIcon = 23336
	bossID = 36948
end
mod:SetHotfixNoticeRev(20220921000000)
mod:SetMinSyncRevision(20220921000000) -- prevent old DBM from syncing combatStart on yell Pull

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 71195 71193 71188 69652 69651 72306 69638 69705",
	"SPELL_AURA_APPLIED_DOSE 72306 69638",
	"SPELL_AURA_REMOVED 69705",
	"SPELL_CAST_START 69705",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

local warnBelowZero			= mod:NewSpellAnnounce(69705, 4)
local warnExperienced		= mod:NewTargetNoFilterAnnounce(71188, 1, nil, false)		-- might be spammy
local warnVeteran			= mod:NewTargetNoFilterAnnounce(71193, 2, nil, false)		-- might be spammy
local warnElite				= mod:NewTargetNoFilterAnnounce(71195, 3, nil, false)		-- might be spammy
local warnBattleFury		= mod:NewStackAnnounce(69638, 2, nil, "Tank|Healer", 2)
local warnBladestorm		= mod:NewSpellAnnounce(69652, 3, nil, "Melee")
local warnWoundingStrike	= mod:NewTargetNoFilterAnnounce(69651, 2)
local warnAddsSoon			= mod:NewAnnounce("WarnAddsSoon", 2, addsIcon)

local timerCombatStart		= mod:NewCombatTimer(47.5)
local timerBelowZeroCD		= mod:NewNextTimer(35, 69705, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON, nil, 1)
local timerBattleFuryActive	= mod:NewBuffActiveTimer(17, 69638, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerAdds				= mod:NewTimer(60, "TimerAdds", addsIcon, nil, nil, 1)

local soundFreeze			= mod:NewSound(69705)

mod:RemoveOption("HealthFrame")

mod.vb.firstMage = false

local function Adds(self) -- no longer on a timed loop, since YELL event is available
--	timerAdds:Stop()
	timerAdds:Start()
	warnAddsSoon:Cancel()
	warnAddsSoon:Schedule(55)
--	self:Unschedule(Adds)
--	self:Schedule(60, Adds, self)
end

function mod:OnCombatStart(delay)
	DBM.BossHealth:Clear()
	timerAdds:Start(12-delay)
	warnAddsSoon:Schedule(7-delay)
--	self:Schedule(12-delay, Adds, self)
	self.vb.firstMage = false
	if UnitFactionGroup("player") == "Alliance" then
		timerBelowZeroCD:Start(39-delay) --Approximate, since it depends on cannon damage. Corrected on yell later
	else
		timerBelowZeroCD:Start(37-delay) --Approximate, since it depends on cannon damage. Corrected on yell later
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
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
	elseif args:IsSpellID(72306, 69638) and self:GetCIDFromGUID(args.destGUID) == bossID then
		timerBattleFuryActive:Start()		-- only a timer for 1st stack
	elseif spellId == 69705 and self:AntiSpam(1, 1) then
		soundFreeze:Play("Interface\\AddOns\\DBM-Core\\sounds\\Alert.mp3")
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(72306, 69638) and self:GetCIDFromGUID(args.destGUID) == bossID then
		if args.amount % 5 == 0 then		-- warn every 5 stacks
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

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:find(L.PullAlliance) then
		timerCombatStart:Start()
	elseif msg:find(L.PullHorde) then
		timerCombatStart:Start(45)
	elseif (msg:find(L.AddsAlliance) or msg:find(L.AddsHorde)) and self:IsInCombat() then
--		self:Unschedule(Adds)
		Adds(self)
	elseif (msg:find(L.MageAlliance) or msg == L.MageAlliance) and self:IsInCombat() then
		if not self.vb.firstMage then
			timerBelowZeroCD:Update(34, 39)
			self.vb.firstMage = true
		else
			timerBelowZeroCD:Update(30, 35)--Update the below zero timer to correct it with yells since it tends to be off depending on how bad your cannon operators are.
		end
	elseif (msg:find(L.MageHorde) or msg == L.MageHorde) and self:IsInCombat() then
		if not self.vb.firstMage then
			timerBelowZeroCD:Update(34.5, 37)
			self.vb.firstMage = true
		else
			timerBelowZeroCD:Update(32.5, 35)--Update the below zero timer to correct it with yells since it tends to be off depending on how bad your cannon operators are.
		end
	end
end
