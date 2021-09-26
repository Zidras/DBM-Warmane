local mod	= DBM:NewMod("Halion", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4390 $"):sub(12, -3))
mod:SetCreatureID(39863)--40142 (twilight form)
mod:SetMinSyncRevision(4358)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Kill)

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UPDATE_WORLD_STATES",
	"UNIT_HEALTH boss1"
)

local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2)
local warnPhase3Soon				= mod:NewPrePhaseAnnounce(3)
local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnPhase3					= mod:NewPhaseAnnounce(3)
local warningShadowConsumption		= mod:NewTargetAnnounce(74792, 4)
local warningFieryCombustion		= mod:NewTargetAnnounce(74562, 4)
local warningMeteor					= mod:NewSpellAnnounce(74648, 3)
local warningShadowBreath			= mod:NewSpellAnnounce(74806, 2, nil, "Tank|Healer")
local warningFieryBreath			= mod:NewSpellAnnounce(74525, 2, nil, "Tank|Healer")
local warningTwilightCutter			= mod:NewAnnounce("TwilightCutterCast", 4, 74769)

local specWarnShadowConsumption		= mod:NewSpecialWarningRun(74792, nil, nil, nil, 4, 2)
local yellShadowconsumption			= mod:NewYellMe(74792)
local specWarnFieryCombustion		= mod:NewSpecialWarningRun(74562, nil, nil, nil, 4, 2)
local yellFieryCombustion			= mod:NewYellMe(74562)
local specWarnMeteorStrike			= mod:NewSpecialWarningMove(74648, nil, nil, nil, 1, 2)
local specWarnTwilightCutter		= mod:NewSpecialWarningSpell(74769, nil, nil, nil, 3, 2)
local specWarnCorporeality			= mod:NewSpecialWarningCount(74826, nil, nil, nil, 1, 2)

local timerShadowConsumptionCD		= mod:NewNextTimer(25, 74792, nil, nil, nil, 3)
local timerFieryConsumptionCD		= mod:NewNextTimer(25, 74562, nil, nil, nil, 3)
local timerMeteorCD					= mod:NewNextTimer(40, 74648, nil, nil, nil, 3)--Target or aoe? tough call. It's a targeted aoe!
local timerMeteorCast				= mod:NewCastTimer(7, 74648)--7-8 seconds from boss yell the meteor impacts.
local timerTwilightCutterCast		= mod:NewCastTimer(5, 74769)
local timerTwilightCutter			= mod:NewBuffActiveTimer(10, 74769, nil, nil, nil, 6)
local timerTwilightCutterCD			= mod:NewNextTimer(15, 74769, nil, nil, nil, 6)
local timerShadowBreathCD			= mod:NewCDTimer(16, 74806, nil, "Tank|Healer", nil, 5)--Edited. Same as debuff timers, same CD, can be merged into 1.
local timerFieryBreathCD			= mod:NewCDTimer(16, 74525, nil, "Tank|Healer", nil, 5)--But unique icons are nice pertaining to phase you're in ;)

local berserkTimer					= mod:NewBerserkTimer(480)

mod:AddBoolOption("AnnounceAlternatePhase", true, "announce")
mod:AddBoolOption("SetIconOnConsumption", true)

mod.vb.warned_preP2 = false
mod.vb.warned_preP3 = false
local phases = {}
local previousCorporeality

function mod:OnCombatStart(delay)--These may still need retuning too, log i had didn't have pull time though.
	table.wipe(phases)
	self.vb.warned_preP2 = false
	self.vb.warned_preP3 = false
	self:SetStage(1)
	berserkTimer:Start(-delay)
	timerMeteorCD:Start(20-delay)
	timerFieryConsumptionCD:Start(15-delay)
	timerFieryBreathCD:Start(10-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(74806, 75954, 75955, 75956) then
		warningShadowBreath:Show()
		timerShadowBreathCD:Start()
	elseif args:IsSpellID(74525, 74526, 74527, 74528) then
		warningFieryBreath:Show()
		timerFieryBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)--We use spell cast success for debuff timers in case it gets resisted by a player we still get CD timer for next one
	if args.spellId == 74792 then
		if self:IsHeroic() then
			timerShadowConsumptionCD:Start(20)
		else
			timerShadowConsumptionCD:Start()
		end
		if self:LatencyCheck() then
			self:SendSync("ShadowCD")
		end
	elseif args.spellId == 74562 then
		if self:IsHeroic() then
			timerFieryConsumptionCD:Start(20)
		else
			timerFieryConsumptionCD:Start()
		end
		if self:LatencyCheck() then
			self:SendSync("FieryCD")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)--We don't use spell cast success for actual debuff on >player< warnings since it has a chance to be resisted.
	if args.spellId == 74792 then
		if self:LatencyCheck() then
			self:SendSync("ShadowTarget", args.destName)
		end
		if args:IsPlayer() then
			specWarnShadowConsumption:Show()
			specWarnShadowConsumption:Play("runout")
			yellShadowconsumption:Yell()
		end
		if not self.Options.AnnounceAlternatePhase then
			warningShadowConsumption:Show(args.destName)
		end
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 7)
		end
	elseif args.spellId == 74562 then
		if self:LatencyCheck() then
			self:SendSync("FieryTarget", args.destName)
		end
		if args:IsPlayer() then
			specWarnFieryCombustion:Show()
			specWarnFieryCombustion:Play("runout")
			yellFieryCombustion:Yell()
		end
		if not self.Options.AnnounceAlternatePhase then
			warningFieryCombustion:Show(args.destName)
		end
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 8)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 74792 then
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 74562 then
		if self.Options.SetIconOnConsumption then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(args)
	if (args:IsSpellID(75952, 75951, 75950, 75949) or args:IsSpellID(75948, 75947)) and args:IsPlayer() and self:AntiSpam() then
		specWarnMeteorStrike:Show()
		specWarnMeteorStrike:Play("runaway")
	end
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warned_preP2 and self:GetUnitCreatureId(uId) == 39863 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.79 then
		self.vb.warned_preP2 = true
		warnPhase2Soon:Show()
	elseif not self.vb.warned_preP3 and self:GetUnitCreatureId(uId) == 40142 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
		self.vb.warned_preP3 = true
		warnPhase3Soon:Show()
	end
end

function mod:UPDATE_WORLD_STATES()
	for i = 1, GetNumWorldStateUI() do
		local _, state, text = GetWorldStateUIInfo(i)
		if state == 1 and strfind(text, "%%") then
			local corporeality = tonumber(strmatch(text, "%d+"))
			if corporeality > 0 and previousCorporeality ~= corporeality then
				specWarnCorporeality:Show(corporeality)
				previousCorporeality = corporeality
				if corporeality > 50 then
					if self:IsTank() then
						specWarnCorporeality:Play("defensive")
					end
				end
				if corporeality < 40 then
					if self:IsDps() then
						specWarnCorporeality:Play("dpsstop")
					end
				elseif corporeality == 40 then
					if self:IsDps() then
						specWarnCorporeality:Play("dpsslow")
					end
				elseif corporeality == 60 then
					if self:IsDps() then
						specWarnCorporeality:Play("dpsmore")
					end
				elseif corporeality > 60 then
					if self:IsDps() then
						specWarnCorporeality:Play("dpshard")
					end
				end
			end
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		self:SendSync("Phase2")
	elseif msg == L.Phase3 or msg:find(L.Phase3) then
		self:SendSync("Phase3")
	elseif msg == L.MeteorCast or msg:find(L.MeteorCast) then--There is no CLEU cast trigger for meteor, only yell
		warningMeteor:Play("153247") -- Voice Pack - 153247.ogg: "Meteor! Run."
		if not self.Options.AnnounceAlternatePhase then
			warningMeteor:Show()
			timerMeteorCast:Start()--7 seconds from boss yell the meteor impacts.
			timerMeteorCD:Start()
		end
		if self:LatencyCheck() then
			self:SendSync("Meteor")
		end
	elseif msg == L.twilightcutter or msg:find(L.twilightcutter) then -- Edited (specific for Warmane since CHAT_MSG_RAID_BOSS_EMOTE fires twice: at 5s and at cutter)
			specWarnTwilightCutter:Schedule(5)
			specWarnTwilightCutter:ScheduleVoice(5, "farfromline")
		if not self.Options.AnnounceAlternatePhase then
			timerTwilightCutterCD:Cancel()
			warningTwilightCutter:Show()
			timerTwilightCutterCast:Start()
			timerTwilightCutter:Schedule(5)--Delay it since it happens 5 seconds after the emote
			timerTwilightCutterCD:Schedule(15)
		end
		if self:LatencyCheck() then
			self:SendSync("TwilightCutter")
		end
	end
end

function mod:OnSync(msg, target)
	if msg == "TwilightCutter" then
		if self.Options.AnnounceAlternatePhase and self:AntiSpam(7, msg) then -- Edited to circumvent Warmane double cutter boss emote
			timerTwilightCutterCD:Cancel()
			warningTwilightCutter:Show()
			timerTwilightCutterCast:Start()
			timerTwilightCutter:Schedule(5)--Delay it since it happens 5 seconds after the emote
			timerTwilightCutterCD:Schedule(15)
		end
	elseif msg == "Meteor" then
		if self.Options.AnnounceAlternatePhase then
			warningMeteor:Show()
			timerMeteorCast:Start()
			timerMeteorCD:Start()
		end
	elseif msg == "ShadowTarget" then
		if self.Options.AnnounceAlternatePhase then
			warningShadowConsumption:Show(target)
		end
	elseif msg == "FieryTarget" then
		if self.Options.AnnounceAlternatePhase then
			warningFieryCombustion:Show(target)
		end
	elseif msg == "ShadowCD" then
		if self.Options.AnnounceAlternatePhase then
			if self:IsHeroic() then
				timerShadowConsumptionCD:Start(20)
			else
				timerShadowConsumptionCD:Start()
			end
		end
	elseif msg == "FieryCD" then
		if self.Options.AnnounceAlternatePhase then
			if self:IsHeroic() then
				timerFieryConsumptionCD:Start(20)
			else
				timerFieryConsumptionCD:Start()
			end
		end
	elseif msg == "Phase2" and self.vb.phase < 2 then
		self:SetStage(2)
		timerFieryBreathCD:Cancel()
		timerMeteorCD:Cancel()
		timerFieryConsumptionCD:Cancel()
		warnPhase2:Show()
		timerShadowBreathCD:Start(18) -- Edited.
		timerShadowConsumptionCD:Start(25)--Edited. not exact, 15 seconds from tank aggro, but easier to add 5 seconds to it as a estimate timer than trying to detect this
		if self:IsHeroic() then --These i'm not sure if they start regardless of drake aggro, or if it should be moved too.
			timerTwilightCutterCD:Start(30)
		else
			timerTwilightCutterCD:Start(35)
		end
	elseif msg == "Phase3" and self.vb.phase < 3 then
		self:SetStage(3)
		warnPhase3:Show()
		timerMeteorCD:Start(30) --These i'm not sure if they start regardless of drake aggro, or if it varies as well.
		timerFieryConsumptionCD:Start(20)--not exact, 15 seconds from tank aggro, but easier to add 5 seconds to it as a estimate timer than trying to detect this
	end
end
