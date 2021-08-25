local mod	= DBM:NewMod("BPCouncil", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4408 $"):sub(12, -3))
mod:SetCreatureID(37970, 37972, 37973)
mod:SetUsedIcons(7, 8)
mod:SetBossHPInfoToHighest()

mod:SetBossHealthInfo(
	37972, L.Keleseth,
	37970, L.Valanar,
	37973, L.Taldaram
)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_SUMMON",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_TARGET",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

local warnTargetSwitch			= mod:NewAnnounce("WarnTargetSwitch", 3, 70952)
local warnTargetSwitchSoon		= mod:NewAnnounce("WarnTargetSwitchSoon", 2, 70952)
local warnConjureFlames			= mod:NewCastAnnounce(71718, 2)
local warnEmpoweredFlamesCast	= mod:NewCastAnnounce(72040, 3)
local warnEmpoweredFlames		= mod:NewTargetAnnounce(72040, 4)
local warnGliteringSparks		= mod:NewTargetAnnounce(71807, 2, nil, false)
local warnShockVortex			= mod:NewTargetAnnounce(72037, 3)				-- 1,5sec cast
local warnKineticBomb			= mod:NewSpellAnnounce(72053, 3, nil, "Ranged")
local warnDarkNucleus			= mod:NewSpellAnnounce(71943, 1, nil, false)	-- instant cast

local specWarnVortex			= mod:NewSpecialWarningYou(72037, nil, nil, nil, 1, 2)
local yellVortex				= mod:NewYellMe(72037)
local yellEmpoweredFlames		= mod:NewYellMe(72040)
local specWarnVortexNear		= mod:NewSpecialWarningClose(72037, nil, nil, nil, 1, 2)
local specWarnEmpoweredShockV	= mod:NewSpecialWarningMoveAway(72039, nil, nil, nil, 1, 2)
local specWarnEmpoweredFlames	= mod:NewSpecialWarningRun(72040, nil, nil, nil, 4, 2)
local specWarnShadowPrison		= mod:NewSpecialWarningStack(72999, nil, 6, nil, nil, 1, 6)

local timerCombatStart			= mod:NewCombatTimer(29) -- Roleplay for first pull
local timerTargetSwitch			= mod:NewTimer(47, "TimerTargetSwitch", 70952)	-- every 46-47seconds
local timerDarkNucleusCD		= mod:NewCDTimer(10, 71943, nil, false, nil, 5)	-- usually every 10 seconds but sometimes more
local timerConjureFlamesCD		= mod:NewCDTimer(20, 71718, nil, nil, nil, 3) -- every 20-30 seconds but never more often than every 20sec
local timerGlitteringSparksCD	= mod:NewCDTimer(20, 71807, nil, nil, nil, 2) -- This is pretty nasty on heroic
local timerShockVortex			= mod:NewCDTimer(15, 72037, nil, nil, nil, 3) -- Seen a range from 16,8 - 21,6
local timerKineticBombCD		= mod:NewCDTimer(18, 72053, nil, "Ranged", nil, 1) -- Might need tweaking :23
local timerShadowPrison			= mod:NewBuffFadesTimer(10, 72999, nil, nil, nil, 5) -- Hard mode debuff

local soundSpecWarnVortexNear	= mod:NewSoundClose(72037)
local soundKineticBomb			= mod:NewSound(72053, nil, "Ranged")
local soundEmpoweredShockV		= mod:NewSound(72039)
local soundEmpoweredFlames		= mod:NewSound(72040)

local berserkTimer				= select(3, DBM:GetMyPlayerInfo()) == "Lordaeron" and mod:NewBerserkTimer(360) or mod:NewBerserkTimer(600)

mod:AddBoolOption("EmpoweredFlameIcon", true)
mod:AddBoolOption("ActivePrinceIcon", false)
mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("VortexArrow")

local activePrince
local glitteringSparksTargets	= {}

local function warnGlitteringSparksTargets()
	warnGliteringSparks:Show(table.concat(glitteringSparksTargets, "<, >"))
	table.wipe(glitteringSparksTargets)
	timerGlitteringSparksCD:Start()
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	warnTargetSwitchSoon:Schedule(42-delay)
	warnTargetSwitchSoon:ScheduleVoice(42, "swapsoon")
	timerTargetSwitch:Start(-delay)
	timerShockVortex:Start(-delay)
	timerKineticBombCD:Start(20-delay)
	activePrince = nil
	table.wipe(glitteringSparksTargets)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(12)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:ShockVortexTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnVortex:Show()
		specWarnVortex:Play("watchstep")
		yellVortex:Yell()
	else
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnVortexNear:Show(targetname)
				specWarnVortexNear:Play("watchstep")
				soundSpecWarnVortexNear:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\vortexNear.mp3")
				if self.Options.VortexArrow then
					local x, y = GetPlayerMapPosition(uId)
					if x == 0 and y == 0 then
						SetMapToCurrentZone()
						x, y = GetPlayerMapPosition(uId)
					end
					DBM.Arrow:ShowRunAway(x, y, 10, 5)
				end
			else
				warnShockVortex:Show(targetname)
			end
		end
	end
end

function mod:HideRange()
	DBM.RangeCheck:Hide()
end

function mod:TrySetTarget()
	if DBM:GetRaidRank() >= 1 then
		for uId in DBM:GetGroupMembers() do
			if UnitGUID(uId.."target") == activePrince then
				activePrince = nil
				SetRaidTarget(uId.."target", 8)
			end
			if not (activePrince) then
				break
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 72037 then		-- Shock Vortex
		timerShockVortex:Start()
		self:BossTargetScanner(37970, "ShockVortexTarget", 0.05, 6)
	elseif args:IsSpellID(72039, 73037, 73038, 73039) then	-- Empowered Shock Vortex(73037, 73038, 73039 drycoded from wowhead)
		specWarnEmpoweredShockV:Show()
		if not self.Options.Sound72039 then
			specWarnEmpoweredShockV:Play("scatter")
		end
		timerShockVortex:Start(30)
		soundEmpoweredShockV:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\EmpoweredVortex.mp3")
	elseif args.spellId == 71718 then	-- Conjure Flames
		warnConjureFlames:Show()
		timerConjureFlamesCD:Start()
	elseif args.spellId == 72040 then	-- Conjure Empowered Flames
		warnEmpoweredFlamesCast:Show()
		timerConjureFlamesCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 70952 then
		activePrince = args.destGUID
		if self:IsInCombat() then
			warnTargetSwitch:Show(L.Valanar)
			warnTargetSwitchSoon:Schedule(42)
			warnTargetSwitchSoon:ScheduleVoice(42, "swapsoon")
			timerTargetSwitch:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(12)
		end
	end
	elseif args.spellId == 70981 and self:IsInCombat() then
		warnTargetSwitch:Show(L.Keleseth)
		warnTargetSwitchSoon:Schedule(42)
		warnTargetSwitchSoon:ScheduleVoice(42, "swapsoon")
		timerTargetSwitch:Start()
		activePrince = args.destGUID
		if self.Options.RangeFrame then
			self:ScheduleMethod(4.5, "HideRange")--delay hiding range frame for a few seconds after change incase valanaar got a last second vortex cast off
		end
	elseif args.spellId == 70982 and self:IsInCombat() then
		warnTargetSwitch:Show(L.Taldaram)
		warnTargetSwitchSoon:Schedule(42)
		warnTargetSwitchSoon:ScheduleVoice(42, "swapsoon")
		timerTargetSwitch:Start()
		activePrince = args.destGUID
		if self.Options.RangeFrame then
			self:ScheduleMethod(4.5, "HideRange")--delay hiding range frame for a few seconds after change incase valanaar got a last second vortex cast off
		end
	elseif args.spellId == 72999 then	--Shadow Prison (hard mode)
		if args:IsPlayer() then
			timerShadowPrison:Start()
			if (args.amount or 1) >= 10 then	--Placeholder right now, might use a different value
				specWarnShadowPrison:Show(args.amount)
				specWarnShadowPrison:Play("stackhigh")
			end
		end
	elseif args:IsSpellID(71807, 72796, 72797, 72798) and args:IsDestTypePlayer() then	-- Glittering Sparks(Dot/slow, dangerous on heroic during valanaar)
		glitteringSparksTargets[#glitteringSparksTargets + 1] = args.destName
		self:Unschedule(warnGlitteringSparksTargets)
		self:Schedule(1, warnGlitteringSparksTargets)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_SUMMON(args)
	if args.spellId == 71943 then
		warnDarkNucleus:Show()
		timerDarkNucleusCD:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:match(L.EmpoweredFlames) and target then
		target = DBM:GetUnitFullName(target)
		if target == UnitName("player") then
			specWarnEmpoweredFlames:Show()
			if not self.Options.Sound72040 then
				specWarnEmpoweredFlames:Play("justrun")
			end
			soundEmpoweredFlames:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\EmpoweredOrbOnYou.mp3")
			yellEmpoweredFlames:Yell()
		else
			warnEmpoweredFlames:Show(target)
		end
		if self.Options.EmpoweredFlameIcon then
			self:SetIcon(target, 7, 10)
		end
	end
end

function mod:UNIT_TARGET()
	if self.Options.ActivePrinceIcon and activePrince then
		self:TrySetTarget()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(72080) then
		warnKineticBomb:Show()
		soundKineticBomb:Play("Interface\\AddOns\\DBM-Core\\sounds\\RaidAbilities\\KineticSpawn.mp3")
		if self:IsDifficulty("normal10", "heroic10") then
			timerKineticBombCD:Start(27)
		else
			timerKineticBombCD:Start()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.FirstPull or msg:find(L.FirstPull) then
		timerCombatStart:Start()
	end
end