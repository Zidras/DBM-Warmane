local mod	= DBM:NewMod("GeneralVezax", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230221144717")
mod:SetCreatureID(33271)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 62661 62662",
	"SPELL_CAST_SUCCESS 62660 63276 63364",
	"SPELL_AURA_APPLIED 62662",
	"SPELL_AURA_REMOVED 62662",
	"SPELL_INTERRUPT 62661",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
--	"UNIT_SPELLCAST_START boss1",
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnShadowCrash				= mod:NewTargetAnnounce(62660, 4)
local warnLeechLife					= mod:NewTargetNoFilterAnnounce(63276, 3)
local warnSaroniteVapor				= mod:NewCountAnnounce(63322, 2)

local specWarnShadowCrash			= mod:NewSpecialWarningDodge(62660, nil, nil, nil, 1, 2)
local specWarnShadowCrashNear		= mod:NewSpecialWarningClose(62660, nil, nil, nil, 1, 2)
local yellShadowCrash				= mod:NewYell(62660)
local specWarnSurgeDarkness			= mod:NewSpecialWarningDefensive(62662, nil, nil, 2, 1, 2)
local specWarnMarkoftheFacelessYou	= mod:NewSpecialWarningMoveAway(63276, nil, nil, nil, 3, 2)
local yellMarkoftheFaceless			= mod:NewYell(63276)
local specWarnMarkoftheFacelessNear	= mod:NewSpecialWarningClose(63276, nil, nil, 2, 1, 2)
local specWarnSearingFlames			= mod:NewSpecialWarningInterruptCount(62661, "HasInterrupt", nil, nil, 1, 2)

local timerEnrage					= mod:NewBerserkTimer(600)
local timerSearingFlamesCast		= mod:NewCastTimer(2, 62661, nil, nil, nil, 5, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerSurgeofDarkness			= mod:NewBuffActiveTimer(10, 62662, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerNextSurgeofDarkness		= mod:NewCDTimer(51.9, 62662, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON) -- REVIEW! 10s variance [50-60; 50-70 from TC]? (25 man NM log 2022/07/10 || S3 HM log 2022/07/21) - 58.0, 51.9 || 55.7, 60.1
local timerSaroniteVapors			= mod:NewNextCountTimer(30, 63322, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON) -- Emote not fired if out of range (confirmed as of 2022/07/25). Has variance, but apply 30s regardless
local timerShadowCrashCD			= mod:NewCDTimer(8.1, 62660, nil, "Ranged", nil, 3) -- 4s variance [8-12] (25 man NM log review 2022/07/10) - 8.8, 10.5, 8.6, 10.6, 10.3, 8.1, 11.8, 9.7, 10.6, 9.8, 14.2, 9.3, 9.1, 8.7, 8.4, 11.5, 8.9
local timerMarkoftheFaceless		= mod:NewTargetTimer(10, 63276, nil, false, 2, 3, nil, DBM_COMMON_L.IMPORTANT_ICON)
local timerMarkoftheFacelessCD		= mod:NewCDTimer(35.9, 63276, nil, nil, nil, 3, nil, DBM_COMMON_L.IMPORTANT_ICON) -- 15s variance [35-45] (25 man NM log 2022/07/10 || S3 HM log 2022/07/21) - 35.9, 41.1, 36.6 || 36.3, 37.6, 37.9, 43.9, 43.8, 40.1

mod:AddSetIconOption("SetIconOnShadowCrash", 62660, true, false, {8})
mod:AddSetIconOption("SetIconOnLifeLeach", 63276, true, false, {7})
mod:AddArrowOption("CrashArrow", 62660, true)

-- Hard Mode
mod:AddTimerLine(DBM_COMMON_L.HEROIC_ICON..DBM_CORE_L.HARD_MODE)
local specWarnAnimus			= mod:NewSpecialWarningSwitch(63145, nil, nil, nil, 1, 2)

local timerHardmode				= mod:NewTimer(212, "hardmodeSpawn", nil, nil, nil, 1) -- S3 VOD review 2022/07/15

mod.vb.interruptCount = 0
mod.vb.vaporsCount = 0

local function saroniteVaporsSpawned(self)
	self.vb.vaporsCount = self.vb.vaporsCount + 1
	warnSaroniteVapor:Show(self.vb.vaporsCount)
	if self.vb.vaporsCount < 6 then
		timerSaroniteVapors:Start(nil, self.vb.vaporsCount + 1)
		self:Schedule(30, saroniteVaporsSpawned, self) -- only first 6 spawns are relevant for Hard Mode
	end
end

--[[function mod:ShadowCrashTarget(targetname, uId)
	if not targetname then return end
	if self.Options.SetIconOnShadowCrash then
		self:SetIcon(targetname, 8, 5)
	end
	if targetname == UnitName("player") then
		specWarnShadowCrash:Show()
		specWarnShadowCrash:Play("runaway")
		yellShadowCrash:Yell()
	elseif self:CheckNearby(11, targetname) then
		specWarnShadowCrashNear:Show(targetname)
		specWarnShadowCrashNear:Play("runaway")
	else
		warnShadowCrash:Show(targetname)
	end
	if uId and self.Options.CrashArrow then
		local x, y = GetPlayerMapPosition(uId)
		if x == 0 and y == 0 then
			SetMapToCurrentZone()
			x, y = GetPlayerMapPosition(uId)
		end
		DBM.Arrow:ShowRunAway(x, y, 13, 5) -- 15yd was too conservative. Try 13yd instead (from personal testing, the hitbox was around ~12.5yd)
	end
end]]

function mod:OnCombatStart(delay)
	self.vb.interruptCount = 0
	self.vb.vaporsCount = 0
	timerShadowCrashCD:Start(8.0-delay) -- REVIEW! variance [8-12s?] (25 man NM log 2022/07/10 || S3 HM log 2022/07/21) - 8.0 || 9.6
	timerMarkoftheFacelessCD:Start(35.1-delay) -- REVIEW! variance 35-45s? (25 man NM log 2022/07/10 || S3 HM log 2022/07/21) - 37.3 || 35.1
	timerSaroniteVapors:Start(30.0-delay, 1) -- Log reviewed (25 man NM log review 2022/07/10)
	self:Schedule(30-delay, saroniteVaporsSpawned, self)
	timerEnrage:Start(-delay)
	timerHardmode:Start(-delay)
	timerNextSurgeofDarkness:Start(60.0-delay) -- REVIEW! 10s variance [50-60]? (25 man NM log 2022/07/10 || S3 HM log 2022/07/21) - 60.0 || 60.0
end

-- Confirmed as of 2022/07/25: CLEU SPELL_CAST_x is randomly failing on Warmane and not firing - https://www.warmane.com/bugtracker/report/112497. Resort to AURA/UNIT_SPELLCAST_x events for now.
-- EDIT 20/09/2022: after several log reviews and troubleshooting, https://www.warmane.com/bugtracker/report/112497 has been fixed serverside. Reinstating CLEU events.
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 62661 then	-- Searing Flames
		self.vb.interruptCount = self.vb.interruptCount + 1
		if self.vb.interruptCount == 4 then
			self.vb.interruptCount = 1
		end
		local kickCount = self.vb.interruptCount
		specWarnSearingFlames:Show(args.sourceName, kickCount)
		specWarnSearingFlames:Play("kick"..kickCount.."r")
		timerSearingFlamesCast:Start()
	elseif spellId == 62662 then
		if self:IsTanking("player", "boss1", nil, true) then--Player is current target
			specWarnSurgeDarkness:Show()
			specWarnSurgeDarkness:Play("defensive")
		end
		timerNextSurgeofDarkness:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 62660 then		-- Shadow Crash
--		self:BossTargetScanner(33271, "ShadowCrashTarget", 0.05, 20) -- this method is not needed, since CLEU has destName
		timerShadowCrashCD:Start()
		if self.Options.SetIconOnShadowCrash then
			self:SetIcon(args.destName, 8, 5)
		end
		if args:IsPlayer() then
			specWarnShadowCrash:Show()
			specWarnShadowCrash:Play("runaway")
			yellShadowCrash:Yell()
		elseif self:CheckNearby(11, args.destName) then
			specWarnShadowCrashNear:Show(args.destName)
			specWarnShadowCrashNear:Play("runaway")
		else
			warnShadowCrash:Show(args.destName)
		end
		if self.Options.CrashArrow then
			local uId = DBM:GetRaidUnitId(args.destName)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			DBM.Arrow:ShowRunAway(x, y, 13, 5) -- 15yd was too conservative. Try 13yd instead (from personal testing, the hitbox was around ~12.5yd)
		end
	elseif spellId == 63276 then	-- Mark of the Faceless
		if self.Options.SetIconOnLifeLeach then
			self:SetIcon(args.destName, 7, 10)
		end
		timerMarkoftheFaceless:Start(args.destName)
		timerMarkoftheFacelessCD:Start()
		if args:IsPlayer() then
			specWarnMarkoftheFacelessYou:Show()
			specWarnMarkoftheFacelessYou:Play("runout")
			yellMarkoftheFaceless:Yell()
		elseif self:CheckNearby(11, args.destName) then
			specWarnMarkoftheFacelessNear:Show(args.destName)
			specWarnMarkoftheFacelessNear:Play("runaway")
		else
			warnLeechLife:Show(args.destName)
		end
	elseif spellId == 63364 then
		specWarnAnimus:Show()
		specWarnAnimus:Play("bigmob")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 62662 then	-- Surge of Darkness
		timerSurgeofDarkness:Start()
--[[elseif spellId == 63276 then	-- Mark of the Faceless
		if self.Options.SetIconOnLifeLeach then
			self:SetIcon(args.destName, 7, 10)
		end
		timerMarkoftheFaceless:Start(args.destName)
		timerMarkoftheFacelessCD:Start()
		if args:IsPlayer() then
			specWarnMarkoftheFacelessYou:Show()
			specWarnMarkoftheFacelessYou:Play("runout")
			yellMarkoftheFaceless:Yell()
		elseif self:CheckNearby(11, args.destName) then
			specWarnMarkoftheFacelessNear:Show(args.destName)
			specWarnMarkoftheFacelessNear:Play("runaway")
		else
			warnLeechLife:Show(args.destName)
		end]]
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62662 then
		timerSurgeofDarkness:Stop()
	end
end

function mod:SPELL_INTERRUPT(args)
	if args.spellId == 62661 then
		timerSearingFlamesCast:Stop()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 33488 then--Saronite Vapor
		timerHardmode:Stop()
	end
end

-- Range restriced, not reliable enough to sync CHAT_MSG_RAID_BOSS_EMOTE, so a repeating schedule was implemented instead and emote is only used for timer correction.
function mod:CHAT_MSG_RAID_BOSS_EMOTE(emote)
	if emote == L.EmoteSaroniteVapors or emote:find(L.EmoteSaroniteVapors) then
		self:SendSync("SaroniteVaporsSpawned")
	end
end

--[[function mod:UNIT_SPELLCAST_START(_, spellName)
	if spellName == GetSpellInfo(62661) then	-- Searing Flames
		self.vb.interruptCount = self.vb.interruptCount + 1
		if self.vb.interruptCount == 4 then
			self.vb.interruptCount = 1
		end
		local kickCount = self.vb.interruptCount
		specWarnSearingFlames:Show(L.name, kickCount)
		specWarnSearingFlames:Play("kick"..kickCount.."r")
		timerSearingFlamesCast:Start()
	elseif spellName == GetSpellInfo(62662) then
		if self:IsTanking("player", "boss1", nil, true) then--Player is current target
			specWarnSurgeDarkness:Show()
			specWarnSurgeDarkness:Play("defensive")
		end
		timerNextSurgeofDarkness:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(62660) then		-- Shadow Crash
		self:BossTargetScanner(33271, "ShadowCrashTarget", 0.05, 20)
		timerShadowCrashCD:Start()
	elseif spellName == GetSpellInfo(63364) then
		self:Unschedule(saroniteVaporsSpawned)
		timerSaroniteVapors:Stop()
		specWarnAnimus:Show()
		specWarnAnimus:Play("bigmob")
	end
end]]

function mod:OnSync(msg)
	if msg == "SaroniteVaporsSpawned" and self:AntiSpam(3, 1) then
		self:Unschedule(saroniteVaporsSpawned)
		self:Schedule(30, saroniteVaporsSpawned, self)
		timerSaroniteVapors:Restart(30, self.vb.vaporsCount + 1)
	end
end
