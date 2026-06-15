local mod	= DBM:NewMod("Jaraxxus", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240521122708")
mod:SetCreatureID(34780)
--mod:SetMinCombatTime(30)
mod:SetUsedIcons(7, 8)
mod:SetMinSyncRevision(20220907000000)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 66532 66963 66964 66965",
	"SPELL_CAST_SUCCESS 66228 67106 67107 67108 67901 67902 67903 66258 66269 67898 67899 67900 66197 68123 68124 68125 67051 67050 67049 66237 66528 67029 67030 67031",
	"SPELL_AURA_APPLIED 67051 67050 67049 66237 66197 68123 68124 68125 66334 67905 67906 67907 66532 66963 66964 66965",
	"SPELL_AURA_REMOVED 67051 67050 67049 66237 66197 68123 68124 68125",
	"SPELL_DAMAGE 66877 67070 67071 67072 66496 68716 68717 68718",
	"SPELL_MISSED 66877 67070 67071 67072 66496 68716 68717 68718",
	"SPELL_HEAL",
	"SPELL_PERIODIC_HEAL"
)

--TODO, possibly just use args.amount from combatlog versus debuff scanning for flesh?
local warnPortalSoon			= mod:NewSoonAnnounce(66269, 3)
local warnVolcanoSoon			= mod:NewSoonAnnounce(66258, 3)
local warnFlame					= mod:NewTargetAnnounce(66197, 4)
local warnFlesh					= mod:NewTargetNoFilterAnnounce(66237, 4, nil, "Healer")
local warnFelLightning			= mod:NewSpellAnnounce(67031, 3, nil, false)

local specWarnFlame				= mod:NewSpecialWarningRun(66877, nil, nil, 2, 4, 2)
local specWarnGTFO				= mod:NewSpecialWarningGTFO(66877, nil, nil, 2, 1, 8)
local specWarnFlesh				= mod:NewSpecialWarningYou(66237, nil, nil, nil, 1, 2)
local specWarnKiss				= mod:NewSpecialWarningCast(66334, "SpellCaster", nil, 2, 1, 2)
local specWarnNetherPower		= mod:NewSpecialWarningDispel(67009, "MagicDispeller", nil, nil, 1, 2)
local specWarnFelInferno		= mod:NewSpecialWarningMove(66496, nil, nil, nil, 1, 2)
local SpecWarnFelFireball		= mod:NewSpecialWarningInterrupt(66532, "HasInterrupt", nil, 2, 1, 2)
local SpecWarnFelFireballDispel	= mod:NewSpecialWarningDispel(66532, "RemoveMagic", nil, 2, 1, 2)

local timerCombatStart			= mod:NewCombatTimer(76)--roleplay for first pull
local timerFlame				= mod:NewTargetTimer(8, 66197, nil, nil, nil, 3)--There are 8 debuff Ids. Since we detect first to warn, use an 8sec timer to cover duration of trigger spell and damage debuff.
local timerFlameCD				= mod:NewNextTimer(30, 66197, nil, nil, nil, 3) -- (25H Lordaeron 2022/09/03) - 30.0, 30.0, 30.1, 30.0, 30.1, 30.0
local timerNetherPowerCD		= mod:NewNextTimer(45, 67009, nil, "MagicDispeller", nil, 5, nil, DBM_COMMON_L.MAGIC_ICON) -- (25H Lordaeron 2022/09/03) - 45.1, 45.0, 45.0, 45.0
local timerFlesh				= mod:NewTargetTimer(12, 66237, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerFleshCD				= mod:NewNextTimer(30, 66237, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON) -- (25H Lordaeron 2022/09/03) - 30.0, 30.0, 30.0, 30.1, 30.0, 30.0
local timerPortalCD				= mod:NewCDTimer(120, 66269, nil, nil, nil, 1, nil, nil, true) -- REVIEW! 7s variance? Added "keep" arg (25H Lordaeron 2022/09/03 || 25H Lordaeron 2022/09/24) - 120.0 || 127.0
local timerVolcanoCD			= mod:NewCDTimer(120, 66258, nil, nil, nil, 1) -- REVIEW! ~1s variance? (25H Lordaeron 2022/09/03 || 25H Lordaeron 2022/09/24) - 120.0 || 120.8
local timerFelLightning			= mod:NewCDTimer(10, 67031, nil, nil, nil, 3, nil, nil, true) -- 7s variance [10-17]. Added "keep" arg (25H Lordaeron 2022/09/24 || 10N Lordaeron 2022/10/02) - 15.0, 12.8, 16.3, 12.1, 17.0, 14.8, 11.4, 11.1, 13.7, 14.0, 12.9, 14.2, 10.1, 10.5, 11.7 || 11.5, 12.4, 14.6, 13.4, 13.1

local enrageTimer				= mod:NewBerserkTimer(600)

mod:AddSetIconOption("LegionFlameIcon", 66197, true, 0, {7})
mod:AddSetIconOption("IncinerateFleshIcon", 66237, true, 0, {8})
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
	timerPortalCD:Start(22-delay) -- (25H Lordaeron 2022/09/03 || 25H Lordaeron 2022/09/24) - 22.0 || 22.0
	warnPortalSoon:Schedule(17-delay)
	timerVolcanoCD:Start(82-delay) -- (25H Lordaeron 2022/09/03 || 25H Lordaeron 2022/09/24) - 82.0 || 89.0
	warnVolcanoSoon:Schedule(77-delay)
	timerNetherPowerCD:Start(15-delay) -- (25H Lordaeron 2022/09/03) - 15.0
	timerFleshCD:Start(13-delay) -- (25H Lordaeron 2022/09/03) - 13.0
	timerFlameCD:Start(20-delay) -- (25H Lordaeron 2022/09/03) - 20.0
	timerFelLightning:Start(-delay) -- (25H Lordaeron 2022/09/24 || 10N Lordaeron 2022/10/02) - 10.0 || 10.1
	enrageTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	DBM.BossHealth:Clear()
end

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

	function mod:SPELL_HEAL(_, _, _, destGUID, _, _, _, _, _, _, _, absorbed)
		if destGUID == incinerateTarget then
			healed = healed + (absorbed or 0)
		end
	end
	mod.SPELL_PERIODIC_HEAL = mod.SPELL_HEAL

	function setIncinerateTarget(_, target, name)
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

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66532, 66963, 66964, 66965) and self:CheckInterruptFilter(args.sourceGUID, false, true) then	-- Fel Fireball (track cast for interupt, only when targeted)
		SpecWarnFelFireball:Show(args.sourceName)
		SpecWarnFelFireball:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(66228, 67106, 67107, 67108) then			-- Nether Power
		specWarnNetherPower:Show(args.sourceName)
		specWarnNetherPower:Play("dispelboss")
		timerNetherPowerCD:Start()
	elseif args:IsSpellID(67901, 67902, 67903, 66258) then		-- Infernal Eruption
		timerVolcanoCD:Start()
		warnVolcanoSoon:Schedule(110)
	elseif args:IsSpellID(66269, 67898, 67899, 67900) then		-- Nether Portal
		timerPortalCD:Start()
		warnPortalSoon:Schedule(110)
	elseif args:IsSpellID(66197, 68123, 68124, 68125) then		-- Legion Flame
		timerFlameCD:Start()
		warnFlame:Show(args.destName) -- I prefer to keep this here, rather than a player elseif on aura applied. Faster and unfiltered.
	elseif args:IsSpellID(67051, 67050, 67049, 66237) then		-- Incinerate Flesh
		timerFleshCD:Start()
	elseif args:IsSpellID(66528, 67029, 67030, 67031) then		-- Fel Lightning
		timerFelLightning:Start()
		warnFelLightning:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67051, 67050, 67049, 66237) then			-- Incinerate Flesh
		self.vb.fleshCount = self.vb.fleshCount + 1
		timerFlesh:Start(args.destName)
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
	elseif args:IsSpellID(66197, 68123, 68124, 68125) then		-- Legion Flame ids 66199, 68126, 68127, 68128 (second debuff) do the actual damage. First 2 seconds are trigger debuff only.
		timerFlame:Start(args.destName)
		if args:IsPlayer() then
			specWarnFlame:Show()
			specWarnFlame:Play("runout")
			specWarnFlame:ScheduleVoice(1.5, "keepmove")
		end
		if self.Options.LegionFlameIcon then
			self:SetIcon(args.destName, 7)
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
	elseif args:IsSpellID(66197, 68123, 68124, 68125) then		-- Legion Flame ids 66199, 68126, 68127, 68128 (second debuff) do the actual damage. First 2 seconds are trigger debuff only.
		timerFlame:Stop(args.destName)
		if self.Options.LegionFlameIcon then
			self:RemoveIcon(args.destName)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if (spellId == 66877 or spellId == 67070 or spellId == 67071 or spellId == 67072) and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then	-- Legion Flame
		specWarnGTFO:Show()
		specWarnGTFO:Play("watchfeet")
	elseif (spellId == 66496 or spellId == 68716 or spellId == 68717 or spellId == 68718) and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then	-- Fel Inferno (does not make sense to fire watchfeet for radius AoE)
		specWarnFelInferno:Show()
		specWarnFelInferno:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.FirstPull or msg:find(L.FirstPull) then
		timerCombatStart:Start()
	end
end
