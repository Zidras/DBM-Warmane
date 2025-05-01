local mod	= DBM:NewMod("Jaraxxus", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240521122708")
mod:SetCreatureID(34780)
--mod:SetMinCombatTime(30)
mod:SetUsedIcons(7, 8, 1, 2)
mod:SetMinSyncRevision(20220907000000)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 66532 66963 66964 66965",
	"SPELL_CAST_SUCCESS 66228 67106 67107 67108 67901 67902 67903 66258 66197 68123 68124 68125 67051 67050 67049 66237 66528 67029 67030 67031",
	"SPELL_AURA_APPLIED 67051 67050 67049 66237 66197 68123 68124 68125 66334 67905 67906 67907 66532 66963 66964 66965 66209",
	"SPELL_AURA_REMOVED 67051 67050 67049 66237 66197 68123 68124 68125 66209",
	"SPELL_DAMAGE 66877 67070 67071 67072 66496 68716 68717 68718",
	"SPELL_MISSED 66877 67070 67071 67072 66496 68716 68717 68718",
	"SPELL_HEAL",
	"SPELL_PERIODIC_HEAL",
	"SPELL_SUMMON 66269 67898 67899 67900"
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

local warnToucherJaraxxus 		= mod:NewTargetAnnounce(66209, 3)
local specWarnToucherJaraxxus   = mod:NewSpecialWarningYou(66209, nil, nil, nil, 3, 2)
local timerToucherJaraxxus		= mod:NewTargetTimer(12, 66209, nil, nil, nil, 5)

local timerCombatStart			= mod:NewCombatTimer(85)
local timerFlame				= mod:NewTargetTimer(8, 66197, nil, nil, nil, 3)
local timerFlameCD				= mod:NewNextTimer(30, 66197, nil, nil, nil, 3)
local timerNetherPowerCD		= mod:NewNextTimer(45, 67009, nil, "MagicDispeller", nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)
local timerFlesh				= mod:NewTargetTimer(12, 66237, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerFleshCD				= mod:NewNextTimer(30, 66237, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerPortalCD				= mod:NewCDTimer(120, 66269, nil, nil, nil, 1, nil, nil, true)
local timerVolcanoCD			= mod:NewCDTimer(120, 66258, nil, nil, nil, 1)
local timerFelLightning			= mod:NewCDTimer(10, 67031, nil, nil, nil, 3, nil, nil, true)

local enrageTimer				= mod:NewBerserkTimer(600)

mod:AddSetIconOption("LegionFlameIcon", 66197, true, 0, {7})
mod:AddSetIconOption("IncinerateFleshIcon", 66237, true, 0, {8})
mod:AddSetIconOption("ToucherJaraxxusIcon", 66209, true, 0, {1, 2})
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
	self.vb.toucherIcon = 1 
	timerPortalCD:Start(20-delay)
	warnPortalSoon:Schedule(15-delay)
	timerVolcanoCD:Start(80-delay)
	warnVolcanoSoon:Schedule(75-delay)
	timerNetherPowerCD:Start(15-delay)
	timerFleshCD:Start(13-delay)
	timerFlameCD:Start(20-delay)
	timerFelLightning:Start(-delay)
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
	--elseif args:IsSpellID(66269, 67898, 67899, 67900) then		-- Nether Portal
	--	timerPortalCD:Start()
	--	warnPortalSoon:Schedule(110)
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

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(66269, 67898, 67899, 67900) then
		timerPortalCD:Start()
		warnPortalSoon:Schedule(110)
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
	elseif args.spellId == 66209 then  -- Toucher de Jaraxxus
		timerToucherJaraxxus:Start(args.destName)
        if args:IsPlayer() then
            specWarnToucherJaraxxus:Show()
            specWarnToucherJaraxxus:Play("targetyou")
        else
            warnToucherJaraxxus:Show(args.destName)
        end
        if self.Options.ToucherJaraxxusIcon then
            self:SetIcon(args.destName, self.vb.toucherIcon, 12)
            self.vb.toucherIcon = self.vb.toucherIcon + 1
            if self.vb.toucherIcon > 2 then
                self.vb.toucherIcon = 1
            end
        end
	
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
	elseif args.spellId == 66209 then  -- Toucher de Jaraxxus
        if self.Options.ToucherJaraxxusIcon then
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
