local mod	= DBM:NewMod("Jaraxxus", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4346 $"):sub(12, -3))
mod:SetCreatureID(34780)
mod:SetMinCombatTime(30)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_HEAL",
	"SPELL_MISSED",
	"SPELL_PERIODIC_HEAL",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL"
)

local warnPortalSoon			= mod:NewSoonAnnounce(66269, 3)
local warnVolcanoSoon			= mod:NewSoonAnnounce(66258, 3)
local warnFlame					= mod:NewTargetAnnounce(66197, 4)
local warnFlesh					= mod:NewTargetAnnounce(66237, 4, nil, "Healer")

local specWarnFlame				= mod:NewSpecialWarningRun(66877, nil, nil, 2, 4, 2)
local specWarnFlameGTFO			= mod:NewSpecialWarningMove(66877, nil, nil, 2, 4, 2)
local specWarnFlesh				= mod:NewSpecialWarningYou(66237, nil, nil, nil, 1, 2)
local specWarnKiss				= mod:NewSpecialWarningCast(66334, "SpellCaster", nil, 2, 1, 2)
local specWarnNetherPower		= mod:NewSpecialWarningDispel(67009, "MagicDispeller", nil, nil, 1, 2)
local specWarnFelInferno		= mod:NewSpecialWarningMove(66496, nil, nil, nil, 1, 2)
local SpecWarnFelFireball		= mod:NewSpecialWarningInterrupt(66532, "HasInterrupt", nil, 2, 1, 2)
local SpecWarnFelFireballDispel	= mod:NewSpecialWarningDispel(66532, "RemoveMagic", nil, 2, 1, 2)

local timerCombatStart			= mod:NewCombatTimer(76.5)--roleplay for first pull
local timerFlame 				= mod:NewTargetTimer(8, 66197, nil, nil, nil, 3)--There are 8 debuff Ids. Since we detect first to warn, use an 8sec timer to cover duration of trigger spell and damage debuff.
local timerFlameCD				= mod:NewCDTimer(30, 66197, nil, nil, nil, 3)
local timerNetherPowerCD		= mod:NewCDTimer(42.5, 67009, nil, "MagicDispeller", nil, 5, nil, DBM_CORE_L.MAGIC_ICON)
local timerFlesh				= mod:NewTargetTimer(12, 66237, nil, "Healer", 2, 5, nil, DBM_CORE_L.HEALER_ICON)
local timerFleshCD				= mod:NewCDTimer(23, 66237, nil, "Healer", 2, 5, nil, DBM_CORE_L.HEALER_ICON)
local timerPortalCD				= mod:NewCDTimer(120, 66269, nil, nil, nil, 1)
local timerVolcanoCD			= mod:NewCDTimer(120, 66258, nil, nil, nil, 1)

local enrageTimer				= mod:NewBerserkTimer(600)

mod:AddSetIconOption("LegionFlameIcon", 66197)
mod:AddSetIconOption("IncinerateFleshIcon", 66237)
mod:AddInfoFrameOption(66237, true)
mod:RemoveOption("HealthFrame")
mod:AddBoolOption("IncinerateShieldFrame", false, "misc")

mod.vb.fleshCount = 0
local incinerateFleshTargetName

function mod:OnCombatStart(delay)
	if self.Options.IncinerateShieldFrame then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(34780, L.name)
	end
	self.vb.fleshCount = 0
	timerPortalCD:Start(22-delay)
	warnPortalSoon:Schedule(17-delay)
	timerVolcanoCD:Start(82-delay)
	warnVolcanoSoon:Schedule(77-delay)
    timerNetherPowerCD:Start(15-delay)
	timerFleshCD:Start(14-delay)
	timerFlameCD:Start(20-delay)
	enrageTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	DBM.BossHealth:Clear()
end

function mod:SPELL_DAMAGE(args)
	if args:IsSpellID(66877, 67070, 67071, 67072) and args:IsPlayer() and self:AntiSpam(3, 1) then		-- Legion Flame
		specWarnFlameGTFO:Show()
		specWarnFlameGTFO:Play("runaway")
	elseif args:IsSpellID(66496, 68716, 68717, 68718) and args:IsPlayer() and self:AntiSpam(3, 1) then	-- Fel Inferno
		specWarnFelInferno:Show()
		specWarnFelInferno:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

local setIncinerateTarget, clearIncinerateTarget, updateInfoFrame
local diffMaxAbsorb = {heroic25 = 85000, heroic10 = 40000, normal25 = 60000, normal10 = 30000}
do
	local incinerateTarget
	local healed = 0
	local maxAbsorb = diffMaxAbsorb[DBM:GetCurrentInstanceDifficulty()] or 0

	local twipe = table.wipe
	local lines, sortedLines = {}, {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end

	local function getShieldHP()
		return math.max(1, math.floor(healed / maxAbsorb * 100))
	end

	function mod:SPELL_HEAL(args)
		if args.destGUID == incinerateTarget then
			healed = healed + (args.absorbed or 0)
		end
	end
	mod.SPELL_PERIODIC_HEAL = mod.SPELL_HEAL

	function setIncinerateTarget(mod, target, name)
		incinerateTarget = target
		healed = 0
		DBM.BossHealth:RemoveBoss(getShieldHP)
		DBM.BossHealth:AddBoss(getShieldHP, L.IncinerateTarget:format(name))
	end

	function clearIncinerateTarget(self, name)
		DBM.BossHealth:RemoveBoss(getShieldHP)
		healed = 0
		if self.Options.IncinerateFleshIcon then
			self:RemoveIcon(name)
		end
	end
	updateInfoFrame = function()
		twipe(lines)
		twipe(sortedLines)
		if incinerateFleshTargetName then
			addLine(incinerateFleshTargetName, getShieldHP().."%")
		end
		return lines, sortedLines
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67051, 67050, 67049, 66237) then			-- Incinerate Flesh
		self.vb.fleshCount = self.vb.fleshCount + 1
		timerFlesh:Start(args.destName)
		timerFleshCD:Start()
		if self.Options.IncinerateFleshIcon then
			self:SetIcon(args.destName, 8, 15)
		end
		if args:IsPlayer() then
			specWarnFlesh:Show()
			specWarnFlesh:Play("targetyou")
		else
			warnFlesh:Show(args.destName)
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			incinerateFleshTargetName = args.destName
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(6, "function", updateInfoFrame, false, true)
		end
		setIncinerateTarget(self, args.destGUID, args.destName)
	elseif args:IsSpellID(66228, 67108, 67106, 67107) and self:GetCIDFromGUID(args.destGUID) == 34780 then	-- Nether Power. Warmane Workaround, since it doesn't fire SPELL_CAST_SUCCESS for this ability. https://www.warmane.com/bugtracker/report/104316
		timerNetherPowerCD:Start()
		specWarnNetherPower:Show(args.destName)
		specWarnNetherPower:Play("dispelboss")
	elseif args:IsSpellID(66197, 68123, 68124, 68125) then		-- Legion Flame ids 66199, 68126, 68127, 68128 (second debuff) do the actual damage. First 2 seconds are trigger debuff only.
		if args:IsPlayer() then
			specWarnFlame:Show()
			specWarnFlame:Play("runout")
			specWarnFlame:ScheduleVoice(1.5, "keepmove")
		end
		if self.Options.LegionFlameIcon then
			self:SetIcon(args.destName, 7, 8)
		end
	elseif args:IsSpellID(66334, 67905, 67906, 67907) and args:IsPlayer() then
		specWarnKiss:Show()
		specWarnKiss:Play("stopcast")
	elseif args:IsSpellID(66532, 66963, 66964, 66965) then		-- Fel Fireball (announce if tank gets debuff for dispel)
		SpecWarnFelFireballDispel:Show(args.destName)
		SpecWarnFelFireballDispel:Play("helpdispel")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(67051, 67050, 67049, 66237) then			-- Incinerate Flesh
		self.vb.fleshCount = self.vb.fleshCount - 1
		if self.Options.InfoFrame and self.vb.fleshCount == 0 then
			DBM.InfoFrame:Hide()
		end
		timerFlesh:Stop(args.destName)
		if self.Options.IncinerateFleshIcon then
			self:RemoveIcon(args.destName)
		end
		clearIncinerateTarget(self, args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66532, 66963, 66964, 66965) and self:CheckInterruptFilter(args.sourceGUID) then	-- Fel Fireball (track cast for interupt, only when targeted)
		SpecWarnFelFireball:Show(args.sourceName)
		SpecWarnFelFireball:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 67009  then	-- Nether Power. Broken on Warmane (checked on 08/08/2021; report: https://www.warmane.com/bugtracker/report/104316)
		specWarnNetherPower:Show(args.sourceName)
		specWarnNetherPower:Play("dispelboss")
		timerNetherPowerCD:Start()
	elseif args:IsSpellID(67901, 67902, 67903, 66258) then		-- Infernal Volcano
		timerVolcanoCD:Start()
		warnVolcanoSoon:Schedule(110)
	elseif args:IsSpellID(66269, 67898, 67899, 67900) then		-- Nether Portal. Broken on Warmane (checked on 10/08/2021); report: https://www.warmane.com/bugtracker/report/104340)
		timerPortalCD:Start()
		warnPortalSoon:Schedule(110)
	elseif args:IsSpellID(66197, 68123, 68124, 68125) then		-- Legion Flame
		warnFlame:Show(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(66269, 67898, 67899, 67900) then			-- Nether Portal. Warmane workaround since there is no CLEU:SCSuccess event being fired
		timerPortalCD:Start()
		warnPortalSoon:Schedule(110)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.FirstPull or msg:find(L.FirstPull) then
		timerCombatStart:Start()
	end
end
