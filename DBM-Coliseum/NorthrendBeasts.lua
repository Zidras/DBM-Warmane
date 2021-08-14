local mod	= DBM:NewMod("NorthrendBeasts", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4398 $"):sub(12, -3))
mod:SetMinSyncRevision(4398)
mod:SetCreatureID(34796, 35144, 34799, 34797)
mod:SetMinCombatTime(30)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("yell", L.CombatStart)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

local warnImpaleOn			= mod:NewStackAnnounce(66331, 2, nil, "Tank|Healer")
local warnFireBomb			= mod:NewSpellAnnounce(66317, 3, nil, false)
local warnBreath			= mod:NewSpellAnnounce(66689, 2)
local warnRage				= mod:NewSpellAnnounce(67657, 3)
local warnSlimePool			= mod:NewSpellAnnounce(66883, 2, nil, "Melee")
local warnToxin				= mod:NewTargetAnnounce(66823, 3)
local warnBile				= mod:NewTargetAnnounce(66869, 3)
local WarningSnobold		= mod:NewAnnounce("WarningSnobold", 4)
local warnEnrageWorm		= mod:NewSpellAnnounce(68335, 3)
local warnCharge			= mod:NewTargetAnnounce(52311, 4)

local specWarnImpale3		= mod:NewSpecialWarningStack(66331, nil, 3, nil, nil, 1, 6)
local specWarnAnger3		= mod:NewSpecialWarningStack(66636, "Tank|Healer", 3, nil, nil, 1, 6)
local specWarnGTFO			= mod:NewSpecialWarningGTFO(66317, nil, nil, nil, 1, 2)
local specWarnToxin			= mod:NewSpecialWarningMoveTo(66823, nil, nil, nil, 1, 2)
local specWarnBile			= mod:NewSpecialWarningYou(66869, nil, nil, nil, 1, 2)
local specWarnSilence		= mod:NewSpecialWarningSpell(66330, "SpellCaster", nil, nil, 1, 2)
local specWarnCharge		= mod:NewSpecialWarningRun(52311, nil, nil, nil, 4, 2)
local specWarnChargeNear	= mod:NewSpecialWarningClose(52311, nil, nil, nil, 3, 2)
local specWarnTranq			= mod:NewSpecialWarningDispel(66759, "RemoveEnrage", nil, nil, 1, 2)

local enrageTimer			= mod:NewBerserkTimer(223)
local timerCombatStart		= mod:NewCombatTimer(23)
local timerNextBoss			= mod:NewTimer(190, "TimerNextBoss", 2457, nil, nil, 1)
local timerSubmerge			= mod:NewTimer(45, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp", nil, nil, 6)
local timerEmerge			= mod:NewTimer(10, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)

local timerBreath			= mod:NewCastTimer(5, 66689, nil, nil, nil, 3)--3 or 5? is it random target or tank?
local timerNextStomp		= mod:NewNextTimer(20, 66330, nil, nil, nil, 2, nil, DBM_CORE_L.INTERRUPT_ICON, nil, mod:IsSpellCaster() and 3 or nil, 3)
local timerNextImpale		= mod:NewNextTimer(10, 66331, nil, "Tank|Healer", nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerRisingAnger      = mod:NewNextTimer(20.5, 66636, nil, nil, nil, 1)
local timerStaggeredDaze	= mod:NewBuffActiveTimer(15, 66758, nil, nil, nil, 5, nil, DBM_CORE_L.DAMAGE_ICON)
local timerNextCrash		= mod:NewCDTimer(70, 66683, nil, nil, nil, 2, nil, DBM_CORE_L.MYTHIC_ICON) -- Original timer. The second Massive Crash should happen 70 seconds after the first
local timerSweepCD			= mod:NewCDTimer(17, 66794, nil, "Melee", nil, 3)
local timerSlimePoolCD		= mod:NewCDTimer(12, 66883, nil, "Melee", nil, 3)
local timerAcidicSpewCD		= mod:NewCDTimer(21, 66819, nil, "Tank", 2, 5, nil, DBM_CORE_L.TANK_ICON)
local timerMoltenSpewCD		= mod:NewCDTimer(21, 66820, nil, "Tank", 2, 5, nil, DBM_CORE_L.TANK_ICON)
local timerParalyticSprayCD	= mod:NewCDTimer(21, 66901, nil, nil, nil, 3)
local timerBurningSprayCD	= mod:NewCDTimer(21, 66902, nil, nil, nil, 3)
local timerParalyticBiteCD	= mod:NewCDTimer(25, 66824, nil, "Melee", nil, 3)
local timerBurningBiteCD	= mod:NewCDTimer(15, 66879, nil, "Melee", nil, 3)

mod:AddSetIconOption("SetIconOnChargeTarget", 52311)
mod:AddSetIconOption("SetIconOnBileTarget", 66869, false)
mod:AddBoolOption("ClearIconsOnIceHowl", true)
mod:AddRangeFrameOption("10")
mod:AddBoolOption("IcehowlArrow")

local bileTargets = {}
local bileName = DBM:GetSpellInfo(66869)
local toxinTargets = {}
local phases = {}
mod.vb.burnIcon = 8
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

-- Warmane workaround: there is no combat start specific event for this encounter, so schedule the entire function
function mod:combatStartFix()
	table.wipe(bileTargets)
	table.wipe(toxinTargets)
	table.wipe(phases)
	self.vb.burnIcon = 8
	self.vb.DreadscaleActive = true
	self.vb.DreadscaleDead = false
	self.vb.AcidmawDead = false
	self:SetStage(1)
	specWarnSilence:Schedule(14)
	specWarnSilence:ScheduleVoice(14, "silencesoon")
	if self:IsHeroic() then
		timerNextBoss:Start(152)
		timerNextBoss:Schedule(147)
	end
	timerNextStomp:Start(15)
	timerRisingAnger:Start(25)
	updateHealthFrame(1)
end

function mod:OnCombatStart(delay)
	self:ScheduleMethod(23-delay, "combatStartFix")	-- Warmane workaround
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:warnToxin()
	warnToxin:Show(table.concat(toxinTargets, "<, >"))
	table.wipe(toxinTargets)
end

function mod:warnBile()
	warnBile:Show(table.concat(bileTargets, "<, >"))
	table.wipe(bileTargets)
	self.vb.burnIcon = 8
end

function mod:WormsEmerge()
	timerSubmerge:Show()
	if not self.vb.AcidmawDead then
		if self.vb.DreadscaleActive then
			timerSweepCD:Start(16)
			timerParalyticSprayCD:Start(20)
		else
			timerSlimePoolCD:Start(14)
			timerParalyticBiteCD:Start(5)
			timerAcidicSpewCD:Start(10)
		end
	end
	if not self.vb.DreadscaleDead then
		if self.vb.DreadscaleActive then
			timerSlimePoolCD:Start(14)
			timerMoltenSpewCD:Start(16)
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

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(67477, 66331, 67478, 67479) then	-- Impale
		timerNextImpale:Start()
		warnImpaleOn:Show(args.destName, 1)
	elseif args:IsSpellID(67657, 66759, 67658, 67659) then	-- Frothing Rage
		warnRage:Show()
		specWarnTranq:Show()
		specWarnTranq:Play("trannow")
	elseif args:IsSpellID(66823, 67618, 67619, 67620) then	-- Paralytic Toxin
		self:UnscheduleMethod("warnToxin")
		toxinTargets[#toxinTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnToxin:Show(bileName)
			specWarnToxin:Play("targetyou")
		end
		self:ScheduleMethod(0.2, "warnToxin")
	elseif args.spellId == 66869 then	-- Burning Bile
		self:UnscheduleMethod("warnBile")
		bileTargets[#bileTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnBile:Show()
			specWarnBile:Play("targetyou")
		end
		if self.Options.SetIconOnBileTarget and self.vb.burnIcon > 0 then
			self:SetIcon(args.destName, self.vb.burnIcon, 15)
			self.vb.burnIcon = self.vb.burnIcon - 1
		end
		self:ScheduleMethod(0.2, "warnBile")
	elseif args.spellId == 66758 then	-- Staggered Daze
		timerStaggeredDaze:Start()
	elseif args.spellId == 66636 then	-- Rising Anger
		WarningSnobold:Show(args.destName)
		timerRisingAnger:Show()
	elseif args.spellId == 68335 then	-- Enrage
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

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(66689, 67650, 67651, 67652) then			-- Arctic Breath
		timerBreath:Start()
		warnBreath:Show()
	elseif args.spellId == 66313 then						-- FireBomb (Impaler)
		warnFireBomb:Show()
	elseif args:IsSpellID(66330, 67647, 67648, 67649) then		-- Staggering Stomp
		timerNextStomp:Start()
		specWarnSilence:Schedule(19)							-- prewarn ~1,5 sec before next
		specWarnSilence:ScheduleVoice(19, "silencesoon")
	elseif args:IsSpellID(66794, 67644, 67645, 67646) then		-- Sweep stationary worm
		timerSweepCD:Start()
	elseif args.spellId == 66821 then							-- Molten spew
		timerMoltenSpewCD:Start()
	elseif args.spellId == 66818 then							-- Acidic Spew
		timerAcidicSpewCD:Start()
	elseif args:IsSpellID(66901, 67615, 67616, 67617) then		-- Paralytic Spray
		timerParalyticSprayCD:Start()
	elseif args:IsSpellID(66902, 67627, 67628, 67629) then		-- Burning Spray
		timerBurningSprayCD:Start()
	elseif args:IsSpellID(66683, 67660, 67661, 67662) then		-- Warmane workaound: Icehowl Massive Crash
		timerNextCrash:Cancel()
		timerNextCrash:Start()
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

function mod:SPELL_DAMAGE(args)
	if args:IsPlayer() and (args:IsSpellID(66320, 67472, 67473, 67475) or args.spellId == 66317) then	-- Fire Bomb (66317 is impact damage, not avoidable but leaving in because it still means earliest possible warning to move. Other 4 are tick damage from standing in it)
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("runaway")
	elseif args:IsPlayer() and args:IsSpellID(66881, 67638, 67639, 67640) then	-- Slime Pool
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if (msg:match(L.Charge) or msg:find(L.Charge)) and target then
		target = DBM:GetUnitFullName(target)
		warnCharge:Show(target)
		timerNextCrash:Start()
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
		self:ScheduleMethod(17, "WormsEmerge")
		timerCombatStart:Start(12.5)
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
		timerCombatStart:Start(9)
		timerNextCrash:Start(52)
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
