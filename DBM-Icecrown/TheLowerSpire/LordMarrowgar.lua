local mod	= DBM:NewMod("LordMarrowgar", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230605220610")
mod:SetCreatureID(36612)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetHotfixNoticeRev(20221117000000)
mod:SetMinSyncRevision(20221117000000)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 69076",
	"SPELL_AURA_REMOVED 69065 69076",
	"SPELL_CAST_START 69057 70826 72088 72089 73144 73145 69076",
	"SPELL_SUMMON 69062 72669 72670",
	"SPELL_PERIODIC_DAMAGE 69146 70823 70824 70825",
	"SPELL_PERIODIC_MISSED 69146 70823 70824 70825"
)

local preWarnWhirlwind		= mod:NewSoonAnnounce(69076, 3)
local warnBoneSpike			= mod:NewCastAnnounce(69057, 2)
local warnImpale			= mod:NewTargetNoFilterAnnounce(72669, 3)

local specWarnColdflame		= mod:NewSpecialWarningGTFO(69146, nil, nil, nil, 1, 8)
local specWarnWhirlwind		= mod:NewSpecialWarningRun(69076, nil, nil, nil, 4, 2)

local timerBoneSpike		= mod:NewCDTimer(18, 69057, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON, true)
local timerWhirlwindCD		= mod:NewCDTimer(90, 69076, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)
local timerWhirlwind		= mod:NewBuffActiveTimer(20, 69076, nil, nil, nil, 6)
local timerBoned			= mod:NewAchievementTimer(8, 4610, nil, false)
local timerBoneSpikeUp		= mod:NewCastTimer(69057)
local timerWhirlwindStart	= mod:NewCastTimer(69076)

local soundBoneSpike		= mod:NewSound(69057)
local soundBoneStorm		= mod:NewSound(69076)

local berserkTimer			= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnImpale", 72669, true, 0, {8, 7, 6, 5, 4, 3, 2, 1})

mod.vb.impaleIcon = 8

function mod:GetBoneStormRemaining()
	local unitIds = { "target", "focus", "mouseover" }
	for _, unit in ipairs(unitIds) do
		local _, _, _, _, _, _, expirationTime, _, _, _, spellId = DBM:UnitBuff(unit, 69076)
		if spellId == 69076 and expirationTime then
			local remaining = expirationTime - GetTime()
			if remaining > 0 and remaining < 40 then
				return remaining
			end
		end
	end
end

function mod:OnCombatStart(delay)
	preWarnWhirlwind:Schedule(40-delay)
	timerWhirlwindCD:Start(45-delay)
	timerBoneSpike:Start(15-delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69076 then						-- Bone Storm (Whirlwind)
		specWarnWhirlwind:Show()
		specWarnWhirlwind:Play("justrun")

		local delay = self:IsHeroic() and 9 or 4
		self:Schedule(delay, function()
			local remaining = mod:GetBoneStormRemaining()
			if remaining then
				timerWhirlwind:Start(remaining)
			end
		end)

		if self:IsNormal() then
			timerBoneSpike:Cancel()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 69065 then						-- Impaled
		if self.Options.SetIconOnImpale then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 69076 then
		timerWhirlwind:Cancel()
		if self:IsNormal() then
			timerBoneSpike:Start(15)					-- He will do Bone Spike Graveyard 15 seconds after whirlwind ends on normal
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69057, 70826, 72088, 72089) or args:IsSpellID(73144, 73145) then	-- Bone Spike Graveyard
		warnBoneSpike:Show()
		timerBoneSpike:Start()
		timerBoneSpikeUp:Start()
		soundBoneSpike:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\Bone_Spike_cast.mp3")
	elseif args.spellId == 69076 then
		preWarnWhirlwind:Schedule(85)
		timerWhirlwindCD:Start()
		timerWhirlwindStart:Start()
		soundBoneStorm:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\Bone_Storm_cast.mp3")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
	if (spellId == 69146 or spellId == 70823 or spellId == 70824 or spellId == 70825) and destGUID == UnitGUID("player") and self:AntiSpam() then		-- Coldflame, MOVE!
		specWarnColdflame:Show(spellName)
		specWarnColdflame:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(69062, 72669, 72670) then			-- Impale
		warnImpale:CombinedShow(0.3, args.sourceName)
		timerBoned:Restart()
		if self.Options.SetIconOnImpale then
			self:SetIcon(args.sourceName, self.vb.impaleIcon)
		end
		if self.vb.impaleIcon < 1 then
			self.vb.impaleIcon = 8
		end
		self.vb.impaleIcon = self.vb.impaleIcon - 1
	end
end