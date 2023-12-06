local mod	= DBM:NewMod("ValkTwins", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20231206000342")
mod:SetCreatureID(34497, 34496)
mod:SetMinCombatTime(30)
mod:SetUsedIcons(1, 2, 3, 4)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)
mod:RegisterEventsInCombat(
	"SPELL_CAST_START 66046 67206 67207 67208 66058 67182 67183 67184 65875 67303 67304 67305 65876 67306 67307 67308",
	"SPELL_AURA_APPLIED 65724 67213 67214 67215 65748 67216 67217 67218 65950 67296 67297 67298 66001 67281 67282 67283 67246 65879 65916 67244 67245 67248 67249 67250 65874 67256 67257 67258 65858 67259 67260 67261",
	"SPELL_AURA_REMOVED 65874 67256 67257 67258 65858 67259 67260 67261",
	"SPELL_INTERRUPT"
)

mod:SetBossHealthInfo(
	34497, L.Fjola,
	34496, L.Eydis
)

local warnSpecial					= mod:NewAnnounce("WarnSpecialSpellSoon", 3)
local warnTouchDebuff				= mod:NewAnnounce("WarningTouchDebuff", 2, 66823)
local warnPoweroftheTwins			= mod:NewAnnounce("WarningPoweroftheTwins2", 4, 65916, "Healer", nil, nil, 65916)

local specWarnSpecial				= mod:NewSpecialWarning("SpecWarnSpecial", nil, nil, nil, 1, 14)
local specWarnSwitch				= mod:NewSpecialWarning("SpecWarnSwitchTarget", nil, nil, nil, 1, 2, nil, nil, 65875)
local specWarnKickNow				= mod:NewSpecialWarning("SpecWarnKickNow", "HasInterrupt", nil, nil, 1, 2, nil, nil, 65875)
local specWarnPoweroftheTwins		= mod:NewSpecialWarningDefensive(65916, "Tank", nil, 2, 1, 2)
local specWarnEmpoweredDarkness		= mod:NewSpecialWarningYou(65724)--No voice ideas for this
local specWarnEmpoweredLight		= mod:NewSpecialWarningYou(65748)--No voice ideas for this

local timerCombatStart				= mod:NewCombatTimer(22)
local enrageTimer					= mod:NewBerserkTimer(360)
local timerSpecial					= mod:NewTimer(45, "TimerSpecialSpell", "Interface\\Icons\\INV_Enchant_EssenceMagicLarge", nil, nil, 6)
local timerHeal						= mod:NewCastTimer(15, 65875, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerLightTouch				= mod:NewTargetTimer(20, 65950, nil, false, 2, 3)
local timerDarkTouch				= mod:NewTargetTimer(20, 66001, nil, false, 2, 3)
local timerAchieve					= mod:NewAchievementTimer(180, 3815)

local timerAnubRoleplay				= mod:NewTimer(52, "TimerAnubRoleplay", 43827, nil, nil, 6)

mod:AddBoolOption("SpecialWarnOnDebuff", false, "announce")
--mod:AddBoolOption("SetIconOnDebuffTarget", false) -- only commented since retail groups to only 1 debuff ID, which is not a very good GUI approach.
mod:AddSetIconOption("SetIconOnDebuffTarget", 66001, false, 0, {1, 2, 3, 4})
mod:AddInfoFrameOption(67258, true)
mod:AddBoolOption("HealthFrame", false)

local lightEssence, darkEssence = DBM:GetSpellInfo(65686), DBM:GetSpellInfo(65684)
local debuffTargets = {}
mod.vb.debuffIcon = 1

function mod:OnCombatStart(delay)
	timerSpecial:Start(-delay)
	warnSpecial:Schedule(40-delay)
	timerAchieve:Start(-delay)
	if self:IsHeroic() then
		enrageTimer:Start(360-delay)
	else
		enrageTimer:Start(480-delay)
	end
	self.vb.debuffIcon = 1
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

do
	local function SpecialAbility(debuff)
		if not debuff then
			specWarnSpecial:Show()
			specWarnSpecial:Play("changecolor")
		end
		timerSpecial:Start()
		warnSpecial:Schedule(40)
	end

	function mod:SPELL_CAST_START(args)
		if args:IsSpellID(66046, 67206, 67207, 67208) then			-- Light Vortex
			local debuff = DBM:UnitDebuff("player", lightEssence)
			SpecialAbility(debuff)
		elseif args:IsSpellID(66058, 67182, 67183, 67184) then		-- Dark Vortex
			local debuff = DBM:UnitDebuff("player", darkEssence)
			SpecialAbility(debuff)
		elseif args:IsSpellID(65875, 67303, 67304, 67305) then		-- Twin's Pact
			timerHeal:Start()
			SpecialAbility(true)
			if self:GetUnitCreatureId("target") == 34497 then	-- if lightbane, then switch to darkbane
				specWarnSwitch:Show()
				specWarnSwitch:Play("changetarget")
			end
		elseif args:IsSpellID(65876, 67306, 67307, 67308) then	-- Light Pact
			timerHeal:Start()
			SpecialAbility(true)
			if self:GetUnitCreatureId("target") == 34496 then	-- if darkbane, then switch to lightbane
				specWarnSwitch:Show()
				specWarnSwitch:Play("changetarget")
			end
		end
	end
end

do
	local function resetDebuff(self)
		self.vb.debuffIcon = 1
	end

	local function warnDebuff(self)
		warnTouchDebuff:Show(table.concat(debuffTargets, "<, >"))
		table.wipe(debuffTargets)
		self:Unschedule(resetDebuff)
		self:Schedule(5, resetDebuff, self)
	end

	local function showPowerWarning(self, cid)
		local target = self:GetBossTarget(cid)
		if not target then return end
		if target == UnitName("player") then
			specWarnPoweroftheTwins:Show()
		else
			warnPoweroftheTwins:Show(target)
		end
	end

	local shieldValues = {
		[65874] = 175000,
		[65858] = 175000,
		[67257] = 300000,
		[67260] = 300000,
		[67256] = 700000,
		[67259] = 700000,
		[67261] = 1200000,
		[67258] = 1200000,
	}
	local showShieldHealthBar, hideShieldHealthBar, shieldedBoss, updateInfoFrame
	local frame = CreateFrame("Frame") -- using a separate frame avoids the overhead of the DBM event handlers which are not meant to be used with frequently occuring events like all damage events...
	local shieldedMob
	local absorbRemaining = 0
	local maxAbsorb = 0

	local twipe = table.wipe
	local lines, sortedLines = {}, {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end

	local function getShieldHP()
		return math.max(1, math.floor(absorbRemaining / maxAbsorb * 100))
	end
	frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	frame:SetScript("OnEvent", function(self, _, _, subEvent, _, _, _, destGUID, _, _, ...)
		if shieldedMob == destGUID then
			local absorbed
			if subEvent == "SWING_MISSED" then
				absorbed = select(2, ... )
			elseif subEvent == "RANGE_MISSED" or subEvent == "SPELL_MISSED" or subEvent == "SPELL_PERIODIC_MISSED" then
				absorbed = select(5, ... )
			end
			if absorbed then
				absorbRemaining = absorbRemaining - absorbed
			end
		end
	end)

	function showShieldHealthBar(self, mob, shieldName, absorb)
		shieldedMob = mob
		absorbRemaining = absorb
		maxAbsorb = absorb
		DBM.BossHealth:RemoveBoss(getShieldHP)
		DBM.BossHealth:AddBoss(getShieldHP, shieldName)
		self:Schedule(15, hideShieldHealthBar)
	end

	function hideShieldHealthBar()
		DBM.BossHealth:RemoveBoss(getShieldHP)
	end

	function updateInfoFrame()
		twipe(lines)
		twipe(sortedLines)
		if shieldedBoss then
			addLine(shieldedBoss, getShieldHP().."%")
		end
		return lines, sortedLines
	end

	function mod:SPELL_AURA_APPLIED(args)
		if args:IsPlayer() and args:IsSpellID(65724, 67213, 67214, 67215) then		-- Empowered Darkness
			specWarnEmpoweredDarkness:Show()
		elseif args:IsPlayer() and args:IsSpellID(65748, 67216, 67217, 67218) then	-- Empowered Light
			specWarnEmpoweredLight:Show()
		elseif args:IsSpellID(65950, 67296, 67297, 67298) then	-- Touch of Light
			if args:IsPlayer() and self.Options.SpecialWarnOnDebuff then
				specWarnSpecial:Show()
				specWarnSpecial:Play("changecolor")
			end
			timerLightTouch:Start(args.destName)
			if self.Options.SetIconOnDebuffTarget then
				self:SetIcon(args.destName, self.vb.debuffIcon, 15)
			end
			self.vb.debuffIcon = self.vb.debuffIcon + 1
			debuffTargets[#debuffTargets + 1] = args.destName
			self:Unschedule(warnDebuff)
			self:Schedule(0.9, warnDebuff, self)
		elseif args:IsSpellID(66001, 67281, 67282, 67283) then	-- Touch of Darkness
			if args:IsPlayer() and self.Options.SpecialWarnOnDebuff then
				specWarnSpecial:Show()
				specWarnSpecial:Play("changecolor")
			end
			timerDarkTouch:Start(args.destName)
			if self.Options.SetIconOnDebuffTarget then
				self:SetIcon(args.destName, self.vb.debuffIcon)
			end
			self.vb.debuffIcon = self.vb.debuffIcon - 1
			debuffTargets[#debuffTargets + 1] = args.destName
			self:Unschedule(warnDebuff)
			self:Schedule(0.75, warnDebuff, self)
		elseif args:IsSpellID(67246, 65879, 65916, 67244) or args:IsSpellID(67245, 67248, 67249, 67250) then	-- Power of the Twins
			self:Schedule(0.1, showPowerWarning, self, args:GetDestCreatureID())
		elseif args:IsSpellID(65874, 67256, 67257, 67258) or args:IsSpellID(65858, 67259, 67260, 67261) then  -- Shield of Darkness/Lights
			shieldedBoss = args.destName
			showShieldHealthBar(self, args.destGUID, args.spellName, shieldValues[args.spellId] or 0)
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "function", updateInfoFrame, false, true)
		end
	end

	function mod:SPELL_AURA_REMOVED(args)
		if args:IsSpellID(65874, 67256, 67257, 67258) or args:IsSpellID(65858, 67259, 67260, 67261) then	-- Shield of Darkness/Lights
			shieldedBoss = nil
			specWarnKickNow:Show()
			specWarnKickNow:Play("kickcast")
			if self.Options.InfoFrame then
				DBM.InfoFrame:Hide()
			end
			hideShieldHealthBar()
		elseif args:IsSpellID(65950, 67296, 67297, 67298) then	-- Touch of Light
			timerLightTouch:Stop(args.destName)
			if self.Options.SetIconOnDebuffTarget then
				self:SetIcon(args.destName, 0)
			end
		elseif args:IsSpellID(66001, 67281, 67282, 67283) then	-- Touch of Darkness
			timerDarkTouch:Stop(args.destName)
			if self.Options.SetIconOnDebuffTarget then
				self:SetIcon(args.destName, 0)
			end
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 65875 or args.extraSpellId == 67303 or args.extraSpellId == 67304 or args.extraSpellId == 67305 or args.extraSpellId == 65876 or args.extraSpellId == 67306 or args.extraSpellId == 67307 or args.extraSpellId == 67308) then
		timerHeal:Cancel()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.ValksRP or msg:find(L.ValksRP) then
		timerCombatStart:Start()
	elseif msg == L.AnubRP or msg:find(L.AnubRP) then
		timerAnubRoleplay:Start()
	end
end
