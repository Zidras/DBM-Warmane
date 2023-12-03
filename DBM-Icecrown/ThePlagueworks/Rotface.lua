local mod	= DBM:NewMod("Rotface", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20231203191447")
mod:SetCreatureID(36627)
mod:SetUsedIcons(1, 2)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 69508 69774 69839",
	"SPELL_AURA_APPLIED 71208 69760 69558 69674 71224 73022 73023 72272 72273",
	"SPELL_AURA_APPLIED_DOSE 69558",
	"SPELL_CAST_SUCCESS 72272 72273",
	"SPELL_AURA_REMOVED 69674 71224 73022 73023",
	"CHAT_MSG_MONSTER_YELL"
)

local warnSlimeSpray			= mod:NewSpellAnnounce(69508, 2)
local warnMutatedInfection		= mod:NewTargetNoFilterAnnounce(69674, 4)
local warnRadiatingOoze			= mod:NewSpellAnnounce(69760, 3)
local warnOozeSpawn				= mod:NewAnnounce("WarnOozeSpawn", 1)
local warnStickyOoze			= mod:NewSpellAnnounce(69774, 1)
local warnUnstableOoze			= mod:NewStackAnnounce(69558, 2)
local warnVileGas				= mod:NewTargetAnnounce(72272, 3)

local specWarnMutatedInfection	= mod:NewSpecialWarningYou(69674, nil, nil, nil, 1, 2)
local specWarnStickyOoze		= mod:NewSpecialWarningMove(69774, nil, nil, nil, 1, 2)
local specWarnOozeExplosion		= mod:NewSpecialWarningDodge(69839, nil, nil, nil, 1, 2)
local specWarnSlimeSpray		= mod:NewSpecialWarningSpell(69508, false, nil, nil, 1, 2)--For people that need a bigger warning to move
local specWarnRadiatingOoze		= mod:NewSpecialWarningSpell(69760, "-Tank", nil, nil, 1, 2)
local specWarnLittleOoze		= mod:NewSpecialWarning("SpecWarnLittleOoze", false, nil, nil, 1, 2)
local specWarnVileGas			= mod:NewSpecialWarningYou(72272, nil, nil, nil, 1, 2, 3) -- Heroic Ability

local timerStickyOoze			= mod:NewNextTimer(15, 69774, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerWallSlime			= mod:NewNextTimer(25, 69789) -- Edited.
local timerSlimeSpray			= mod:NewNextTimer(20, 69508, nil, nil, nil, 3) -- Some instances, timer is not fixed (cause unknown, but self-corrected on the next timer). (25H Lordaeron 2022/07/09 || 10N Icecrown 2022/08/25 || 25H Lordaeron [2023-08-23]@[20:45:25]) - 20.1, 20.0, 20.0, 20.1, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0 || 20.0, 20.1, 20.0, 20.0 || pull:20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.1, 20.0, 21.4, 18.6, 20.0, 20.0
local timerMutatedInfection		= mod:NewTargetTimer(12, 69674, nil, nil, nil, 5)
local timerOozeExplosion		= mod:NewCastTimer(4, 69839, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON, nil, 3)
local timerVileGasCD			= mod:NewCDTimer(29.1, 72272, nil, nil, nil, 3) -- REVIEW! ~5s variance [29.1-35]? (25H Lordaeron 2022/07/09 || 25H Lordaeron 2022/09/23 || 10H Lordaeron 2022/10/02) "Vile Gas-72273-npc:36678 = pull:28.9[+2], 1.4, 0.9, 28.5[+1], 0.8, 0.7, 31.7, 2.2[+1], 35.6, 0.1[+3], 38.9, 1.0, 0.8[+1], 30.4, 2.0, 0.9, 30.2, 0.4, 0.1, 33.4, 0.3[+1], 1.5[+1], 38.2" || "Vile Gas-72273-npc:36678-1684 = pull:29.1, 1.5[+1], 0.2, 29.9[+2], 1.9, 30.9[+2], 1.4, 33.9[+1], 2.0, 0.7, 29.8[+1], 0.8[+1], 29.6, 1.1[+2], 0.1, 28.4, 0.6, 1.6, 28.8[+1], 0.1, 2.0" || "Vile Gas-72273-npc:36678-577 = pull:31.1, 0.1, 0.6, 28.4[+2], 1.3, 29.7[+2], 1.7, 0.1, 36.3[+1], 0.1, 1.2, 32.2, 1.6, 0.6[+1], 30.7, 0.8[+1], 1.5, 31.3, 1.6, 0.9[+1], 27.1, 1.2, 0.4[+2]"


mod:AddRangeFrameOption(10, 72272, "Ranged")
mod:AddSetIconOption("InfectionIcon", 69674, true, 0, {1, 2})
mod:AddBoolOption("TankArrow", true, nil, nil, nil, nil, 69674)

local spamOoze = 0
mod.vb.InfectionIcon = 1

--[[ local function WallSlime(self)
	self:Unschedule(WallSlime)
	if self:IsInCombat() then
		timerWallSlime:Start()
		self:Schedule(20, WallSlime, self)
	end
end ]]

function mod:OnCombatStart(delay)
	timerWallSlime:Start(9-delay) -- Adjust from 25 to 9 to have a correct timer from the start
	timerSlimeSpray:Start(20-delay) -- Custom add for the first Slime Spray. Log reviewed (25H Lordaeron 2022/07/09) - 20.0
	if self:IsHeroic() then
		timerVileGasCD:Start(28.9-delay) -- Edited. REVIEW! variance? (25H Lordaeron 2022/07/09 || 25H Lordaeron 2022/09/23) - 28.9 || 29.1
	end
--	self:Schedule(25-delay, WallSlime, self)
	self.vb.InfectionIcon = 1
	spamOoze = 0
	if self.Options.RangeFrame and self:IsHeroic() then
		DBM.RangeCheck:Show(10) -- Increased from 8 to 10
	end
	self:RegisterShortTermEvents(
		"SPELL_DAMAGE", -- unfiltered for DBM arrow
		"SPELL_MISSED", -- unfiltered for DBM arrow
		"SWING_DAMAGE",
		"SWING_MISSED"
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 69508 then
		timerSlimeSpray:Start()
		specWarnSlimeSpray:Show()
		warnSlimeSpray:Show()
	elseif spellId == 69774 then
		timerStickyOoze:Start(args.sourceGUID)
		warnStickyOoze:Show()
	elseif spellId == 69839 then --Unstable Ooze Explosion (Big Ooze)
		if GetTime() - spamOoze < 4 then --This will prevent spam but breaks if there are 2 oozes. GUID work is required
			specWarnOozeExplosion:Cancel()
			specWarnOozeExplosion:CancelVoice()
		end
		if GetTime() - spamOoze < 4 or GetTime() - spamOoze > 5 then --Attempt to ignore a cast that may fire as an ooze is already exploding.
			timerOozeExplosion:Start()
			specWarnOozeExplosion:Schedule(4)
			specWarnOozeExplosion:ScheduleVoice(4, "watchstep")
		end
		spamOoze = GetTime()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 71208 and args:IsPlayer() then
		specWarnStickyOoze:Show()
		specWarnStickyOoze:Play("runaway")
	elseif spellId == 69760 then
		warnRadiatingOoze:Show()
	elseif spellId == 69558 then
		warnUnstableOoze:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(69674, 71224, 73022, 73023) then
		timerMutatedInfection:Start(args.destName)
		if args:IsPlayer() then
			specWarnMutatedInfection:Show()
			specWarnMutatedInfection:Play("movetotank")
		else
			warnMutatedInfection:Show(args.destName)
		end
		if self.Options.InfectionIcon then
			self:SetIcon(args.destName, self.vb.InfectionIcon, 12)
		end
		if self.vb.InfectionIcon == 1 then	-- After ~3mins there is a chance 2 ppl will have the debuff, so we are alternating between 2 icons
			self.vb.InfectionIcon = 2
		else
			self.vb.InfectionIcon = 1
		end
	elseif args:IsSpellID(72272, 72273) and args:IsDestTypePlayer() then	-- Vile Gas (Heroic Rotface only)
		if args:IsPlayer() then
			specWarnVileGas:Show()
			specWarnVileGas:Play("scatter")
		end
		warnVileGas:CombinedShow(2.5, args.destName) -- Yes it does take this long to travel to all 3 targets sometimes, qq.
		if self:AntiSpam(5, 3) then
			timerVileGasCD:Start()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(72272, 72273) then
		DBM:AddMsg("Vile Gas SPELL_CAST_SUCCESS unhidden from combat log. Notify Zidras on Discord or GitHub")
		timerVileGasCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(69674, 71224, 73022, 73023) then
		timerMutatedInfection:Cancel(args.destName)
		warnOozeSpawn:Show()
		if self.Options.InfectionIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, sourceFlags, destGUID, _, _, spellId)
	if (spellId == 69761 or spellId == 71212 or spellId == 73026 or spellId == 73027) and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnRadiatingOoze:Show()
		specWarnRadiatingOoze:Play("runaway")
	elseif (spellId ~= 53189 or spellId ~= 53190 or spellId ~= 53194 or spellId ~= 53195) and self:GetCIDFromGUID(destGUID) == 36899 and bit.band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 and self:IsInCombat() then--Any spell damage except for starfall (ranks 3 and 4)
		if sourceGUID ~= UnitGUID("player") then
			if self.Options.TankArrow then
				DBM.Arrow:ShowRunTo(sourceName, 0, 0)
			end
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SWING_DAMAGE(sourceGUID, sourceName, sourceFlags, destGUID)
	if self:GetCIDFromGUID(sourceGUID) == 36897 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then --Little ooze hitting you
		specWarnLittleOoze:Show()
		specWarnLittleOoze:Play("keepmove")
	elseif self:GetCIDFromGUID(destGUID) == 36899 and bit.band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 and self:IsInCombat() then
		if sourceGUID ~= UnitGUID("player") then
			if self.Options.TankArrow then
				DBM.Arrow:ShowRunTo(sourceName, 0, 0)
			end
		end
	end
end
mod.SWING_MISSED = mod.SWING_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellSlimePipes1 or msg:find(L.YellSlimePipes1)) or (msg == L.YellSlimePipes2 or msg:find(L.YellSlimePipes2)) then
		-- WallSlime(self) -- I can't explain the need for using a scheduling here
		timerWallSlime:Start()
	end
end
