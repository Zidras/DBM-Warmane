local mod	= DBM:NewMod("Auriaya", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221031104000")

mod:SetCreatureID(33515)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 64678 64389 64386 64688 64422",
	"SPELL_AURA_APPLIED 64396 64455",
	"SPELL_DAMAGE 64459 64675",
	"SPELL_MISSED 64459 64675",
	"UNIT_DIED"
)

local warnSwarm			= mod:NewTargetAnnounce(64396, 2)
local warnFearSoon		= mod:NewSoonAnnounce(64386, 1)
local warnCatDied		= mod:NewAnnounce("WarnCatDied", 3, 64455, nil, nil, nil, 64455)
local warnCatDiedOne	= mod:NewAnnounce("WarnCatDiedOne", 3, 64455, nil, nil, nil, 64455)

local specWarnFear		= mod:NewSpecialWarningSpell(64386, nil, nil, nil, 2, 2)
local specWarnBlast		= mod:NewSpecialWarningInterrupt(64389, "HasInterrupt", nil, 2, 1, 2)
local specWarnVoid		= mod:NewSpecialWarningMove(64675, nil, nil, nil, 1, 2)
local specWarnSonic		= mod:NewSpecialWarningMoveTo(64688, nil, nil, nil, 2, 2)

local enrageTimer		= mod:NewBerserkTimer(600)
local timerDefender		= mod:NewNextCountTimer(30, 64447, nil, nil, nil, 1) -- First timer is time for boss spellcast, afterwards is time to revive
local timerFear			= mod:NewCastTimer(64386, nil, nil, nil, 4)
local timerFearCD		= mod:NewCDTimer(27.7, 64386, nil, nil, nil, 4, nil, nil, true) -- REVIEW! ~9s variance [27.7-36.3]. Added "Keep" arg (25m Frostmourne 2022/09/07 || 25m Lordaeron 2022/10/09 || 25m Lordaeron 2022/10/30) - 33.8, 34.3, 32.6 || 34.5, 36.3, 29.1 || 30.4, 28.9, 27.8, 32.4
local timerSwarmCD		= mod:NewCDTimer(31.8, 64396, nil, nil, nil, 1, nil, nil, true) -- REVIEW! ~4s variance? Added "Keep" arg (25m Frostmourne 2022/09/07 || 25m Lordaeron 2022/10/09) - 34.5, 32.3 || 31.8
local timerSonicCD		= mod:NewCDTimer(27.2, 64688, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON, true) -- REVIEW! ~10s variance [27.2-37.2]. Added "Keep" arg (10m Frostmourne 2022/08/09 || 25m Frostmourne 2022/09/07 || 25m Lordaeron 2022/10/09 || 25m Lordaeron 2022/10/30) - 28.7, 35.4, 37.2 || 30.8, 29.5 || 32.9, 33.4 || 35.1, 27.2, 31.3
local timerSonic		= mod:NewCastTimer(64688, nil, nil, nil, 2)

mod:GroupSpells(64447, 64455) -- Activate Feral Defender, Feral Essence

mod.vb.catLives = 9

function mod:OnCombatStart(delay)
	self.vb.catLives = 9
	enrageTimer:Start(-delay)
	timerFearCD:Start(34.9-delay) -- 18s variance! REVIEW: 25m ~35s, 10m ~50s?? (2022/07/08 10m Lord transcriptor log || 2021 S2 cleu 25m, 10m || VOD review || 10m Frostmourne 2022/08/09 || 25m Lordaeron 2022/10/09 || 25m Lordaeron 2022/10/30) - 53 || 35, 50 || 35, 36 || 34.9 || 34.9 || 35.1
	timerSonicCD:Start(63-delay) -- 33s variance! (... ||| 10m Frostmourne 2022/08/09 || 25m Frostmourne 2022/09/07 || 25m Lordaeron 2022/10/09 || 25m Lordaeron 2022/10/30) 81, 61, 94... ||| 63.0 || 63.0 || 63.0 || 63.0
	timerDefender:Start(59.9-delay, self.vb.catLives)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64678, 64389) then -- Sentinel Blast
		specWarnBlast:Show(args.sourceName)
		specWarnBlast:Play("kickcast")
	elseif args.spellId == 64386 then -- Terrifying Screech
		specWarnFear:Show()
		specWarnFear:Play("fearsoon")
		timerFear:Start()
		timerFearCD:Schedule(2)
		warnFearSoon:Schedule(34)
	elseif args:IsSpellID(64688, 64422) then --Sonic Screech
		specWarnSonic:Show(TANK)
		specWarnSonic:Play("gathershare")
		timerSonic:Start()
		timerSonicCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 64396 then -- Guardian Swarm
		warnSwarm:Show(args.destName)
		timerSwarmCD:Start()
	elseif spellId == 64455 then -- Feral Essence
		DBM.BossHealth:AddBoss(34035, L.Defender:format(9))
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if (spellId == 64459 or spellId == 64675) and destGUID == UnitGUID("player") and self:AntiSpam(3) then -- Feral Defender Void Zone
		specWarnVoid:Show()
		specWarnVoid:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 34035 then
		self.vb.catLives = self.vb.catLives - 1
		if self.vb.catLives > 0 then
			timerDefender:Start(nil, self.vb.catLives)
			if self.vb.catLives == 1 then
				warnCatDiedOne:Show()
			else
				warnCatDied:Show(self.vb.catLives)
			end
			if self.Options.HealthFrame then
				DBM.BossHealth:RemoveBoss(34035)
				DBM.BossHealth:AddBoss(34035, L.Defender:format(self.vb.catLives))
			end
		else
			if self.Options.HealthFrame then
				DBM.BossHealth:RemoveBoss(34035)
			end
		end
	end
end
