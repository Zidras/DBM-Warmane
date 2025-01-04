local mod	= DBM:NewMod("Akama", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250104110528")
mod:SetCreatureID(22841, 23191, 23215, 23216, 23523, 23318, 23524, 23319)

mod:SetModelID(21357)

mod:RegisterCombat("combat")
mod:SetWipeTime(50)--Adds come about every 50 seconds, so require at least this long to wipe combat if they die instantly

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START 39945", --not really needed boss is a trash mob on Chromiecraft; 
	"SPELL_CAST_SUCCESS 34189",
	"SPELL_AURA_APPLIED ",
	"SPELL_AURA_REMOVED ",
	"SPELL_SUMMON 42035 40476 40474",
	"UNIT_DIED"
)

mod:RegisterEvents(
	"SPELL_AURA_REMOVED 34189"
)

local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnDefender		= mod:NewAnnounce("warnAshtongueDefender", 2, 41180)
local warnSorc			= mod:NewAnnounce("warnAshtongueSorcerer", 2, 40520)

local specWarnAdds		= mod:NewSpecialWarningAddsCustom(42035, "-Healer", nil, nil, 1, 2)

local timerCombatStart		= mod:NewCombatTimer(12)
local timerAddsCD		= mod:NewAddsCustomTimer(25+25, 42035)--NewAddsCustomTimer
local timerDefenderCD		= mod:NewTimer(25+5, "timerAshtongueDefender", 41180, nil, nil, 1)
local timerSorcCD		= mod:NewTimer(25+5, "timerAshtongueSorcerer", 40520, nil, nil, 1)



--[[
mod.vb.AddsWestCount = 0
mod.vb.AddsEastCount = 0
mod.vb.AddsDefCount = 0
mod.vb.AddsSorcCount = 0
]]--

--note: west is right side, east is left side, left spawns first

local function addsWestLoop(self)
--	self.vb.AddsWestCount = self.vb.AddsWestCount + 1
	specWarnAdds:Show(DBM_COMMON_L.WEST)
	specWarnAdds:Play("killmob")
	specWarnAdds:ScheduleVoice(1, "west")
--	if self.vb.AddsWestCount == 2 then
--		self:Schedule(51-2, addsWestLoop, self)
--		timerAddsCD:Start(51-2, DBM_COMMON_L.WEST)
--	else
		self:Schedule(47+7+1, addsWestLoop, self)
		timerAddsCD:Start(47+7+1, DBM_COMMON_L.WEST)
--	end
end

local function addsEastLoop(self)
--	self.vb.AddsEastCount = self.vb.AddsEastCount + 1
	specWarnAdds:Show(DBM_COMMON_L.EAST)
	specWarnAdds:Play("killmob")
	specWarnAdds:ScheduleVoice(1, "east")
--	if self.vb.AddsEastCount == 2 then
--		self:Schedule(51-2, addsEastLoop, self)
--		timerAddsCD:Start(51-2, DBM_COMMON_L.EAST)
--	else
		self:Schedule(51+3+1, addsEastLoop, self)
		timerAddsCD:Start(51+3+1, DBM_COMMON_L.EAST)
--	end
end

local function sorcLoop(self)
--	self.vb.AddsSorcCount = self.vb.AddsSorcCount + 1
	warnSorc:Show()
--	if self.vb.AddsSorcCount == 2 then
--		self:Schedule(25+9, sorcLoop, self)
--		timerSorcCD:Start(25+9)
--	else
		self:Schedule(25+4+3.5, sorcLoop, self)
		timerSorcCD:Start(25+4+3.5)
--	end
end

local function defenderLoop(self)
--	self.vb.AddsDefCount = self.vb.AddsDefCount + 1
	warnDefender:Show()
--	if self.vb.AddsDefCount == 2 then
		self:Schedule(30+4+1, defenderLoop, self)
		timerDefenderCD:Start(30+4+1)
--	else
--		self:Schedule(30-1, defenderLoop, self)
--		timerDefenderCD:Start(30-1)
--	end
end

function mod:OnCombatStart()
--	timerAddsCD:Start(18, DBM_COMMON_L.EAST or "East")
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	self:Unschedule(addsWestLoop)
	self:Unschedule(addsEastLoop)
	self:Unschedule(sorcLoop)
	self:Unschedule(defenderLoop)
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 34189 and args:GetDestCreatureID() == 23191 then--Coming out of stealth (he's been activated)
		timerCombatStart:Start()
		self:RegisterShortTermEvents("SWING_DAMAGE", "SWING_MISSED", "UNIT_SPELLCAST_SUCCEEDED")
		self:SetStage(1)
		self.vb.AddsWestCount = 0
		self.vb.AddsEastCount = 0
		self:Schedule(1-1+10, defenderLoop, self) --moved here
		self:Schedule(1-1+10, sorcLoop, self) --moved here
		self:Schedule(1+7+11, addsWestLoop, self) --moved here
		self:Schedule(18-16+10, addsEastLoop, self) --moved here
	end
end

function mod:SWING_DAMAGE(_, sourceName)
	if sourceName == L.name and self.vb.phase == 1 then
		self:UnregisterShortTermEvents()
		self:SetStage(2)
		warnPhase2:Show()
		timerAddsCD:Stop()
		timerDefenderCD:Stop()
		timerSorcCD:Stop()
		self:Unschedule(addsWestLoop)
		self:Unschedule(addsEastLoop)
		self:Unschedule(sorcLoop)
		self:Unschedule(defenderLoop)
	end
end
mod.SWING_MISSED = mod.SWING_DAMAGE

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
--	if (spellName == GetSpellInfo(40607) or spellName == GetSpellInfo(40955)) and self.vb.phase == 1 and self:AntiSpam(3, 1) then--Fixate/Summon Shade of Akama Trigger
	if args.spellId == 40607 then
		self:UnregisterShortTermEvents()
		self:SetStage(2)
		warnPhase2:Show()
--		timerAddsCD:Stop()
		timerDefenderCD:Stop()
		timerSorcCD:Stop()
		self:Unschedule(addsWestLoop)
		self:Unschedule(addsEastLoop)
		self:Unschedule(sorcLoop)
		self:Unschedule(defenderLoop)
	end
end
]]-- 40607 and 40955 does not appear in combat log

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 22841 then
		DBM:EndCombat(self)
	end
end
