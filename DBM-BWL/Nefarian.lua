local mod	= DBM:NewMod("Nefarian-Classic", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240208235105")
mod:SetCreatureID(11583)
mod:SetModelID(11380)
mod:RegisterCombat("combat_yell", L.YellP1)--ENCOUNTER_START appears to fire when he lands, so start of phase 2, ignoring all of phase 1
mod:SetWipeTime(50)--guesswork
mod:SetHotfixNoticeRev(20240208000000)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 22539 22686",
	"SPELL_AURA_APPLIED 22687 22667",
	"UNIT_DIED",
	"UNIT_HEALTH boss1 mouseover target"
)

local WarnAddsLeft			= mod:NewAnnounce("WarnAddsLeft", 2, "136116")
local warnClassCall			= mod:NewAnnounce("WarnClassCall", 3, "136116")
local warnPhase				= mod:NewPhaseChangeAnnounce()
local warnPhase3Soon		= mod:NewPrePhaseAnnounce(3)
local warnShadowFlame		= mod:NewCastAnnounce(22539, 2)
local warnFear				= mod:NewCastAnnounce(22686, 2)

local specwarnShadowCommand	= mod:NewSpecialWarningTarget(22667, nil, nil, 2, 1, 2)
local specwarnVeilShadow	= mod:NewSpecialWarningDispel(22687, "RemoveCurse", nil, nil, 1, 2)
local specwarnClassCall		= mod:NewSpecialWarning("specwarnClassCall", nil, nil, nil, 1, 2)

local timerPhase			= mod:NewPhaseTimer(15)
local timerClassCall		= mod:NewTimer(30, "TimerClassCall", "136116", nil, nil, 5)
local timerFearNext			= mod:NewCDTimer(26.7, 22686, nil, nil, nil, 2)--26-42.5

mod.vb.addLeft = 42
local addsGuidCheck = {}
local firstBossMod = DBM:GetModByName("Razorgore")

function mod:OnCombatStart()
	table.wipe(addsGuidCheck)
	self.vb.addLeft = 42
	self:SetStage(1)
end

function mod:OnCombatEnd(wipe)
	if not wipe then
		DBT:CancelBar(DBM_CORE_L.SPEED_CLEAR_TIMER_TEXT)
		if firstBossMod.vb.firstEngageTime then
			local thisTime = time() - firstBossMod.vb.firstEngageTime
			if thisTime and thisTime > 0 then
				if not firstBossMod.Options.FastestClear then
					--First clear, just show current clear time
					DBM:AddMsg(DBM_CORE_L.RAID_DOWN:format("BWL", DBM:strFromTime(thisTime)))
					firstBossMod.Options.FastestClear = thisTime
				elseif (firstBossMod.Options.FastestClear > thisTime) then
					--Update record time if this clear shorter than current saved record time and show users new time, compared to old time
					DBM:AddMsg(DBM_CORE_L.RAID_DOWN_NR:format("BWL", DBM:strFromTime(thisTime), DBM:strFromTime(firstBossMod.Options.FastestClear)))
					firstBossMod.Options.FastestClear = thisTime
				else
					--Just show this clear time, and current record time (that you did NOT beat)
					DBM:AddMsg(DBM_CORE_L.RAID_DOWN_L:format("BWL", DBM:strFromTime(thisTime), DBM:strFromTime(firstBossMod.Options.FastestClear)))
				end
			end
			firstBossMod.vb.firstEngageTime = nil
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 22539 then
		warnShadowFlame:Show()
	elseif spellId == 22686 then
		warnFear:Show()
		timerFearNext:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 22687 then
		if self:CheckDispelFilter("curse") then
			specwarnVeilShadow:Show(args.destName)
			specwarnVeilShadow:Play("dispelnow")
		end
	elseif spellId == 22667 then
		specwarnShadowCommand:Show(args.destName)
		specwarnShadowCommand:Play("findmc")
	end
end

function mod:UNIT_DIED(args)
	local guid = args.destGUID
	local cid = self:GetCIDFromGUID(guid)
	if cid == 14264 or cid == 14263 or cid == 14261 or cid == 14265 or cid == 14262 or cid == 14302 then--Red, Bronze, Blue, Black, Green, Chromatic
		if not addsGuidCheck[guid] then
			addsGuidCheck[guid] = true
			self.vb.addLeft = self.vb.addLeft - 1
			--40, 35, 30, 25, 20, 15, 12, 9, 6, 3
			if self.vb.addLeft >= 15 and (self.vb.addLeft % 5 == 0) or self.vb.addLeft >= 1 and (self.vb.addLeft % 3 == 0) then
				WarnAddsLeft:Show(self.vb.addLeft)
			end
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 and self:GetUnitCreatureId(uId) == 11583 and self.vb.phase < 2.5 then
		warnPhase3Soon:Show()
		self:SetStage(2.5)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellDK or msg:find(L.YellDK) then
		self:SendSync("ClassCall", "DEATHKNIGHT")
	elseif msg == L.YellDruid or msg:find(L.YellDruid) then
		self:SendSync("ClassCall", "DRUID")
	elseif msg == L.YellHunter or msg:find(L.YellHunter) then
		self:SendSync("ClassCall", "HUNTER")
	elseif msg == L.YellWarlock or msg:find(L.YellWarlock) then
		self:SendSync("ClassCall", "WARLOCK")
	elseif msg == L.YellMage or msg:find(L.YellMage) then
		self:SendSync("ClassCall", "MAGE")
	elseif msg == L.YellPaladin or msg:find(L.YellPaladin) then
		self:SendSync("ClassCall", "PALADIN")
	elseif msg == L.YellPriest or msg:find(L.YellPriest) then
		self:SendSync("ClassCall", "PRIEST")
	elseif msg == L.YellRogue or msg:find(L.YellRogue) then
		self:SendSync("ClassCall", "ROGUE")
	elseif msg == L.YellShaman or msg:find(L.YellShaman) then
		self:SendSync("ClassCall", "SHAMAN")
	elseif msg == L.YellWarrior or msg:find(L.YellWarrior) then
		self:SendSync("ClassCall", "WARRIOR")
	elseif msg == L.YellP2 or msg:find(L.YellP2) then
		self:SendSync("Phase", 2)
	elseif msg == L.YellP3 or msg:find(L.YellP3) then
		self:SendSync("Phase", 3)
	end
end

do
	local playerClass = UnitClass("player")

	function mod:OnSync(msg, arg, sender)
		if msg == "Phase" and sender then
			local phase = tonumber(arg) or 0
			if phase == 2 then
				self:SetStage(2)
				timerPhase:Start(15)--15 til encounter start fires, not til actual land?
				--timerFearNext:Start(46.6)
			elseif phase == 3 then
				self:SetStage(3)
			end
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(arg))
		end
		if not self:IsInCombat() then return end
		if msg == "ClassCall" and sender then
			local className = LOCALIZED_CLASS_NAMES_MALE[arg]
			if playerClass == className then
				specwarnClassCall:Show()
				specwarnClassCall:Play("targetyou")
			else
				warnClassCall:Show(className)
			end
			timerClassCall:Start(30, className)
		end
	end
end
