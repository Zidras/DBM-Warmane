local mod	= DBM:NewMod("LordMarrowgar", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4409 $"):sub(12, -3))
mod:SetCreatureID(36612)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"SPELL_SUMMON"
)

local preWarnWhirlwind		= mod:NewSoonAnnounce(69076, 3)
local warnBoneSpike			= mod:NewCastAnnounce(69057, 2)
local warnImpale			= mod:NewTargetAnnounce(72669, 3)

local specWarnColdflame		= mod:NewSpecialWarningMove(69146, nil, nil, nil, 1, 2)
local specWarnWhirlwind		= mod:NewSpecialWarningRun(69076, nil, nil, nil, 4, 2)

local timerBoneSpike		= mod:NewCDTimer(18, 69057, nil, nil, nil, 1, nil, DBM_CORE_L.DAMAGE_ICON)
local timerWhirlwindCD		= mod:NewCDTimer(30, 69076, nil, nil, nil, 2, nil, DBM_CORE_L.MYTHIC_ICON)
local timerWhirlwind		= mod:NewBuffActiveTimer(20, 69076, nil, nil, nil, 6)
local timerBoned			= mod:NewAchievementTimer(8, 4610)
local timerBoneSpikeUp		= mod:NewCastTimer(69057)
local timerWhirlwindStart	= mod:NewCastTimer(69076)

local soundBoneSpike		= mod:NewSound(69057)
local soundBoneStorm		= mod:NewSound(69076)

local berserkTimer			= select(3, DBM:GetMyPlayerInfo()) == "Lordaeron" and mod:NewBerserkTimer(360) or mod:NewBerserkTimer(600)

mod:AddBoolOption("SetIconOnImpale", true)

mod.vb.impaleIcon	= 8

function mod:OnCombatStart(delay)
	preWarnWhirlwind:Schedule(43-delay) -- Edited
	timerWhirlwindCD:Start(48-delay) -- Edited
	timerBoneSpike:Start(15-delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69076 then						-- Bone Storm (Whirlwind)
		specWarnWhirlwind:Show()
		specWarnWhirlwind:Play("justrun")
		if self:IsHeroic() then
			timerWhirlwind:Show(37)			--36-38 on HC
		else
			timerWhirlwind:Show()			--30 on Norm
			timerBoneSpike:Cancel()						-- He doesn't do Bone Spike Graveyard during Bone Storm on normal
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69065 then						-- Impaled
		if self.Options.SetIconOnImpale then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 69076 then
		timerWhirlwind:Cancel()
		timerWhirlwindCD:Start()
		preWarnWhirlwind:Schedule(25)
		if self:IsNormal() then
			timerBoneSpike:Start(15)					-- He will do Bone Spike Graveyard 15 seconds after whirlwind ends on normal
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69057, 70826, 72088, 72089) then	-- Bone Spike Graveyard
		warnBoneSpike:Show()
		timerBoneSpike:Start()
		timerBoneSpikeUp:Start()
		soundBoneSpike:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\Bone_Spike_cast.mp3")
	elseif args.spellId == 69076 then
		timerWhirlwindCD:Cancel()
		timerWhirlwindStart:Start()
		soundBoneStorm:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\Bone_Storm_cast.mp3")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(args)
	if args:IsSpellID(69146, 70823, 70824, 70825) and args:IsPlayer() and self:AntiSpam() then		-- Coldflame, MOVE!
		specWarnColdflame:Show()
		specWarnColdflame:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(69062, 72669, 72670) then			-- Impale
		warnImpale:CombinedShow(0.3, args.sourceName)
		timerBoned:Start()
		if self.Options.SetIconOnImpale then
			self:SetIcon(args.sourceName, self.vb.impaleIcon)
		end
		if self.vb.impaleIcon < 1 then
			self.vb.impaleIcon = 8
		end
		self.vb.impaleIcon = self.vb.impaleIcon - 1
	end
end

function mod:OnCombatEnd(wipe)
	DBM.BossHealth:Clear()
end
