local mod	= DBM:NewMod("NorthrendBeasts", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220702173444")
mod:SetMinSyncRevision(7007)
mod:SetCreatureID(34796, 35144, 34799, 34797)
mod:SetMinCombatTime(30)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)
mod:RegisterEventsInCombat(
	"SPELL_CAST_START 66689 67650 67651 67652 66313 66330 67647 67648 67649 66794 67644 67645 67646 66821 66818 66901 67615 67616 67617 66902 67627 67628 67629",
	"SPELL_CAST_SUCCESS 67641 66883 67642 67643 66824 67612 67613 67614 66879 67624 67625 67626",
	"SPELL_AURA_APPLIED 67477 66331 67478 67479 67657 66759 67658 67659 66823 67618 67619 67620 66869 66758 66636 68335",
	"SPELL_AURA_APPLIED_DOSE 67477 66331 67478 67479 66636",
	"SPELL_AURA_REMOVED 66869",
	"SPELL_DAMAGE 66320 67472 67473 67475 66317 66881 67638 67639 67640",
	"SPELL_MISSED 66320 67472 67473 67475 66317 66881 67638 67639 67640",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

-- General
local enrageTimer			= mod:NewBerserkTimer(223)
local timerCombatStart		= mod:NewCombatTimer(23)
local timerNextBoss			= mod:NewTimer(190, "TimerNextBoss", 2457, nil, nil, 1)

mod:AddRangeFrameOption("10")

-- Stage One: Gormok the Impaler
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(1)..": "..L.Gormok)
local warnImpaleOn			= mod:NewStackAnnounce(66331, 2, nil, "Tank|Healer")
local warnFireBomb			= mod:NewSpellAnnounce(66317, 3, nil, false)
local WarningSnobold		= mod:NewAnnounce("WarningSnobold", 4)

local specWarnImpale3		= mod:NewSpecialWarningStack(66331, nil, 3, nil, nil, 1, 6)
local specWarnAnger3		= mod:NewSpecialWarningStack(66636, "Tank|Healer", 3, nil, nil, 1, 6)
local specWarnGTFO			= mod:NewSpecialWarningGTFO(66317, nil, nil, nil, 1, 2)
local specWarnSilence		= mod:NewSpecialWarningSpell(66330, "SpellCaster", nil, nil, 1, 2)

local timerNextStomp		= mod:NewNextTimer(20, 66330, nil, nil, nil, 2, nil, DBM_COMMON_L.INTERRUPT_ICON, nil, mod:IsSpellCaster() and 3 or nil, 3)
local timerNextImpale		= mod:NewNextTimer(10, 66331, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerRisingAnger		= mod:NewNextTimer(20.5, 66636, nil, nil, nil, 1)

-- Stage Two: Acidmaw & Dreadscale
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(2)..": "..L.Acidmaw.." & "..L.Dreadscale)
local warnSlimePool			= mod:NewSpellAnnounce(66883, 2, nil, "Melee")
local warnToxin				= mod:NewTargetAnnounce(66823, 3)
local warnBile				= mod:NewTargetAnnounce(66869, 3)
local warnEnrageWorm		= mod:NewSpellAnnounce(68335, 3)

local specWarnToxin			= mod:NewSpecialWarningMoveTo(66823, nil, nil, nil, 1, 2)
local specWarnBile			= mod:NewSpecialWarningYou(66869, nil, nil, nil, 1, 2)

local timerSubmerge			= mod:NewCDTimer(45, 66948, nil, nil, nil, 6, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local timerEmerge			= mod:NewBuffActiveTimer(10, 66947, nil, nil, nil, 6, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerSweepCD			= mod:NewCDTimer(21, 66794, nil, "Melee", nil, 3)
local timerAcidicSpewCD		= mod:NewCDTimer(21, 66819, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerMoltenSpewCD		= mod:NewCDTimer(21, 66820, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerParalyticSprayCD	= mod:NewCDTimer(21, 66901, nil, nil, nil, 3)
local timerBurningSprayCD	= mod:NewCDTimer(21, 66902, nil, nil, nil, 3)
local timerParalyticBiteCD	= mod:NewCDTimer(25, 66824, nil, "Melee", nil, 3)
local timerBurningBiteCD	= mod:NewCDTimer(15, 66879, nil, "Melee", nil, 3)
local timerSlimePoolCD		= mod:NewCDTimer(12, 66883, nil, "Melee", nil, 3)

mod:AddSetIconOption("SetIconOnBileTarget", 66869, false, 0, {1, 2, 3, 4, 5, 6, 7, 8})

-- Stage Three: Icehowl
mod:AddTimerLine(DBM_CORE_L.SCENARIO_STAGE:format(3)..": "..L.Icehowl)
local warnBreath			= mod:NewSpellAnnounce(66689, 2)
local warnRage				= mod:NewSpellAnnounce(66759, 3)
local warnCharge			= mod:NewTargetNoFilterAnnounce(52311, 4)

local specWarnCharge		= mod:NewSpecialWarningRun(52311, nil, nil, nil, 4, 2)
local specWarnChargeNear	= mod:NewSpecialWarningClose(52311, nil, nil, nil, 3, 2)
local specWarnFrothingRage	= mod:NewSpecialWarningDispel(66759, "RemoveEnrage", nil, nil, 1, 2)

local timerBreath			= mod:NewCastTimer(5, 66689, nil, nil, nil, 3)--3 or 5? is it random target or tank?
local timerStaggeredDaze	= mod:NewBuffActiveTimer(15, 66758, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerNextCrash		= mod:NewCDTimer(51, 66683, nil, nil, nil, 2, nil, DBM_COMMON_L.MYTHIC_ICON)

mod:AddSetIconOption("SetIconOnChargeTarget", 52311, true, 0, {8})
mod:AddBoolOption("ClearIconsOnIceHowl", true)
mod:AddBoolOption("IcehowlArrow")

mod:GroupSpells(66902, 66869)--Burning Spray with Burning Bile
mod:GroupSpells(66901, 66823)--Paralytic Spray with Toxic Bile
mod:GroupSpells(52311, 66758, 66759)--Furious Charge, Staggering Daze, and Frothing Rage

local bileName = DBM:GetSpellInfo(66869)
local phases = {}
mod.vb.burnIcon = 1
mod.vb.DreadscaleActive = true
mod.vb.DreadscaleDead = false
mod.vb.AcidmawDead = false

local function updateHealthFrame(phase)
	if phases[phase] then
		return
	end
	phases[phase] = true
	mod.vb.phase = phase
	if phase == 1 then
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(34796, L.Gormok)
	elseif phase == 2 then
		DBM.BossHealth:AddBoss(35144, L.Acidmaw)
		DBM.BossHealth:AddBoss(34799, L.Dreadscale)
	elseif phase == 3 then
		DBM.BossHealth:AddBoss(34797, L.Icehowl)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(phases)
	self.vb.burnIcon = 8
	self.vb.DreadscaleActive = true
	self.vb.DreadscaleDead = false
	self.vb.AcidmawDead = false
	self:SetStage(1)
	specWarnSilence:Schedule(14-delay)
	specWarnSilence:ScheduleVoice(14-delay, "silencesoon")
	if self:IsHeroic() then
		timerNextBoss:Start(152-delay)
		timerNextBoss:Schedule(147)
		timerRisingAnger:Start(18-delay)
	else
		timerRisingAnger:Start(27-delay)
	end
	timerNextStomp:Start(15-delay)
	updateHealthFrame(1)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

--These remain methods since they can't reverse schedule each other as local functions
function mod:WormsEmerge()
	timerSubmerge:Show()
	if not self.vb.AcidmawDead then
		if self.vb.DreadscaleActive then
			timerSweepCD:Start(22)			-- Log review: 22-24s (N/H?)
			timerParalyticSprayCD:Start(18)	-- Log review: 18-20s (N/H?)
		else
			timerSlimePoolCD:Start(14)
			timerParalyticBiteCD:Start(5)
			timerAcidicSpewCD:Start(10)
		end
	end
	if not self.vb.DreadscaleDead then
		if self.vb.DreadscaleActive then
			timerSlimePoolCD:Start(15)
			timerMoltenSpewCD:Start(26)
			timerBurningBiteCD:Start(5)
		else
			timerSweepCD:Start(16)
			timerBurningSprayCD:Start(17)
		end
	end
	self:ScheduleMethod(45, "WormsSubmerge")
end

function mod:WormsSubmerge()
	timerEmerge:Show()
	timerSweepCD:Cancel()
	timerSlimePoolCD:Cancel()
	timerMoltenSpewCD:Cancel()
	timerParalyticSprayCD:Cancel()
	timerBurningBiteCD:Cancel()
	timerAcidicSpewCD:Cancel()
	timerBurningSprayCD:Cancel()
	timerParalyticBiteCD:Cancel()
	self.vb.DreadscaleActive = not self.vb.DreadscaleActive
	self:ScheduleMethod(6, "WormsEmerge")
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if args:IsSpellID(66689, 67650, 67651, 67652) then			-- Arctic Breath
		timerBreath:Start()
		warnBreath:Show()
	elseif spellId == 66313 then						-- FireBomb (Impaler)
		warnFireBomb:Show()
	elseif args:IsSpellID(66330, 67647, 67648, 67649) then		-- Staggering Stomp
		timerNextStomp:Start()
		specWarnSilence:Schedule(19)							-- prewarn ~1,5 sec before next
		specWarnSilence:ScheduleVoice(19, "silencesoon")
	elseif args:IsSpellID(66794, 67644, 67645, 67646) then		-- Sweep stationary worm
		timerSweepCD:Start()
	elseif spellId == 66821 then							-- Molten spew
		timerMoltenSpewCD:Start()
	elseif spellId == 66818 then							-- Acidic Spew
		timerAcidicSpewCD:Start()
	elseif args:IsSpellID(66901, 67615, 67616, 67617) then		-- Paralytic Spray
		timerParalyticSprayCD:Start()
	elseif args:IsSpellID(66902, 67627, 67628, 67629) then		-- Burning Spray
		self.vb.burnIcon = 1
		timerBurningSprayCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(67641, 66883, 67642, 67643) then			-- Slime Pool Cloud Spawn
		warnSlimePool:Show()
		timerSlimePoolCD:Show()
	elseif args:IsSpellID(66824, 67612, 67613, 67614) then		-- Paralytic Bite
		timerParalyticBiteCD:Start()
	elseif args:IsSpellID(66879, 67624, 67625, 67626) then		-- Burning Bite
		timerBurningBiteCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args:IsSpellID(67477, 66331, 67478, 67479) then	-- Impale
		timerNextImpale:Start()
		warnImpaleOn:Show(args.destName, 1)
	elseif args:IsSpellID(67657, 66759, 67658, 67659) then	-- Frothing Rage
		warnRage:Show()
		specWarnFrothingRage:Show()
		specWarnFrothingRage:Play("trannow")
	elseif args:IsSpellID(66823, 67618, 67619, 67620) then	-- Paralytic Toxin
		warnToxin:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnToxin:Show(bileName)
			specWarnToxin:Play("targetyou")
		end
	elseif spellId == 66869 then	-- Burning Bile
		warnBile:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnBile:Show()
			specWarnBile:Play("targetyou")
		end
		if self.Options.SetIconOnBileTarget and self.vb.burnIcon < 9 then
			self:SetIcon(args.destName, self.vb.burnIcon)
			self.vb.burnIcon = self.vb.burnIcon + 1
		end
	elseif spellId == 66758 then	-- Staggered Daze
		timerStaggeredDaze:Start()
	elseif spellId == 66636 then	-- Rising Anger
		WarningSnobold:Show(args.destName)
		timerRisingAnger:Show()
	elseif spellId == 68335 then	-- Enrage
		warnEnrageWorm:Show()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(67477, 66331, 67478, 67479) then	-- Impale
		local amount = args.amount or 1
		timerNextImpale:Start()
		if (amount >= 3) or (amount >= 2 and self:IsHeroic()) then
			if args:IsPlayer() then
				specWarnImpale3:Show(amount)
				specWarnImpale3:Play("stackhigh")
			else
				warnImpaleOn:Show(args.destName, amount)
			end
		end
	elseif args.spellId == 66636 then	-- Rising Anger
		local amount = args.amount or 1
		WarningSnobold:Show()
		if amount <= 3 then
			timerRisingAnger:Show()
		elseif amount >= 3 then
			specWarnAnger3:Show(amount)
			specWarnAnger3:Play("stackhigh")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 66869 then
		if self.Options.SetIconOnBileTarget then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
	if (spellId == 66320 or spellId == 67472 or spellId == 67473 or spellId == 67475 or spellId == 66317) and destGUID == UnitGUID("player") then	-- Fire Bomb (66317 is impact damage, not avoidable but leaving in because it still means earliest possible warning to move. Other 4 are tick damage from standing in it)
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("runaway")
	elseif (spellId == 66881 or spellId == 67638 or spellId == 67639 or spellId == 67640) and destGUID == UnitGUID("player") then	-- Slime Pool
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if (msg:match(L.Charge) or msg:find(L.Charge)) and target then
		target = DBM:GetUnitFullName(target)
		warnCharge:Show(target)
		timerNextCrash:Start(59)
		if self.Options.ClearIconsOnIceHowl then
			self:ClearIcons()
		end
		if target == UnitName("player") then
			specWarnCharge:Show()
			specWarnCharge:Play("justrun")
			if self.Options.PingCharge then
				Minimap:PingLocation()
			end
		else
			local uId = DBM:GetRaidUnitId(target)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				if inRange then
					specWarnChargeNear:Show()
					specWarnChargeNear:Play("runaway")
					if self.Options.IcehowlArrow then
						DBM.Arrow:ShowRunAway(x, y, 12, 5)
					end
				end
			end
		end
		if self.Options.SetIconOnChargeTarget then
			self:SetIcon(target, 8, 5)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.CombatStart or msg:find(L.CombatStart) then
		timerCombatStart:Start()
	elseif msg == L.Phase2 or msg:find(L.Phase2) then
		self:ScheduleMethod(13.5, "WormsEmerge")
		timerCombatStart:Start(13.5)
		updateHealthFrame(2)
		self:SetStage(2)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	elseif msg == L.Phase3 or msg:find(L.Phase3) then
		updateHealthFrame(3)
		self:SetStage(3)
		if self:IsHeroic() then
			enrageTimer:Start()
		end
		self:UnscheduleMethod("WormsSubmerge")
		self:UnscheduleMethod("WormsEmerge")
		timerCombatStart:Start(10)
		timerNextCrash:Start() -- 10 + 41
		timerNextBoss:Cancel()
		timerSubmerge:Cancel()
		timerEmerge:Cancel()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34796 then
		specWarnSilence:Cancel()
		specWarnSilence:CancelVoice()
		timerNextStomp:Stop()
		timerNextImpale:Stop()
		timerRisingAnger:Stop()
		DBM.BossHealth:RemoveBoss(cid) -- remove Gormok from the health frame
	elseif cid == 35144 then
		self.vb.AcidmawDead = true
		timerParalyticSprayCD:Cancel()
		timerParalyticBiteCD:Cancel()
		timerAcidicSpewCD:Cancel()
		if self.vb.DreadscaleActive then
			timerSweepCD:Cancel()
		else
			timerSlimePoolCD:Cancel()
		end
		if self.vb.DreadscaleDead then
			timerNextBoss:Cancel()
			DBM.BossHealth:RemoveBoss(35144)
			DBM.BossHealth:RemoveBoss(34799)
		end
	elseif cid == 34799 then
		self.vb.DreadscaleDead = true
		timerBurningSprayCD:Cancel()
		timerBurningBiteCD:Cancel()
		timerMoltenSpewCD:Cancel()
		if self.vb.DreadscaleActive then
			timerSlimePoolCD:Cancel()
		else
			timerSweepCD:Cancel()
		end
		if self.vb.AcidmawDead then
			timerNextBoss:Cancel()
			DBM.BossHealth:RemoveBoss(35144)
			DBM.BossHealth:RemoveBoss(34799)
		end
	elseif cid == 34797 then
		DBM:EndCombat(self)
	end
end