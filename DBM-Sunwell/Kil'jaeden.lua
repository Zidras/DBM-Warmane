local mod	= DBM:NewMod("Kil", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250512125330")
mod:SetCreatureID(25315)
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 45641",
	"SPELL_AURA_REMOVED 45641",
	"SPELL_CAST_START 46605 45737 46680",
	"SPELL_CAST_SUCCESS 45848 45892 46589", 
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_DAMAGE", 
	"SPELL_MISSED",  
	"UNIT_SPELLCAST_SUCCEEDED",
	"COMBAT_LOG_EVENT_UNFILTERED"
)

local warnBloom			= mod:NewTargetAnnounce(45641, 2)
local warnArmageddon	= mod:NewTargetAnnounce(45915, 2)

local warnDarkOrb		= mod:NewAnnounce("WarnDarkOrb", 4, 51512) --51512 for soulstone icon otherwise it may be confused with warnBlueOrb
local warnDart			= mod:NewSpellAnnounce(45737, 3)
local warnShield		= mod:NewSpellAnnounce(45848, 1)
local warnBlueOrb		= mod:NewAnnounce("WarnBlueOrb", 1, 45109) --45109 for green orb icon
local warnSpikeTarget	= mod:NewTargetAnnounce(46589, 3) --all spike related things except timerSpike dont work and are not supposed to. Its blizzlike to watch out yourself 
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnPhase4		= mod:NewPhaseAnnounce(4)

local specWarnArmaYou	= mod:NewSpecialWarningYou(45915, nil, nil, nil, 3, 2)
local yellArmageddon	= mod:NewYellMe(45915)
local specWarnSpike		= mod:NewSpecialWarningMove(46589) --all spike related things except timerSpike dont work and are not supposed to. 
local yellSpike			= mod:NewYellMe(46589)			--all spike related things except timerSpike dont work and are not supposed to. 
local specWarnBloom		= mod:NewSpecialWarningYou(45641, nil, nil, nil, 1, 2)
local yellBloom			= mod:NewYellMe(45641)
local specWarnBomb		= mod:NewSpecialWarningMoveTo(46605, nil, nil, nil, 3, 2)--findshield
local specWarnShield	= mod:NewSpecialWarningSpell(45848)
local specWarnDarkOrb	= mod:NewSpecialWarning("SpecWarnDarkOrb", false)
local specWarnBlueOrb	= mod:NewSpecialWarning("SpecWarnBlueOrb", false)

local timerBloomCD		= mod:NewCDTimer(40, 45641, nil, nil, nil, 2) --AC: In P1-P3: 40 seconds. In P4: 20 seconds. 
local timerDartCD		= mod:NewCDTimer(20, 45737, nil, nil, nil, 2)--Currently (12.05.25): 10s on AC, but should be fixed soon. 20s is the correct blizzard value. 
local timerBomb			= mod:NewCastTimer(9, 46605, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBombCD		= mod:NewCDTimer(45, 46605, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON) --AC: first cast after 50s, every subsequent every 45s; P4: first after 30s, every subsequent every 25s
local timerSpike		= mod:NewCastTimer(28, 46680, nil, nil, nil, 3)
local timerBlueOrb		= mod:NewTimer(38, "TimerBlueOrb", 45109, nil, nil, 5) --AC: 38s

mod:AddRangeFrameOption("10") --only 10 yards are needed 
mod:AddSetIconOption("BloomIcon", 45641, true, false, {4, 5, 6, 7, 8})

local warnBloomTargets = {}
local orbGUIDs = {}
mod.vb.bloomIcon = 8

local function showBloomTargets(self)
	warnBloom:Show(table.concat(warnBloomTargets, "<, >"))
	table.wipe(warnBloomTargets)
	self.vb.bloomIcon = 8
    if self.vb.phase == 4 then
        timerBloomCD:Start(20) 
    else
        timerBloomCD:Start()
	end
end

function mod:OnCombatStart(delay)
	table.wipe(warnBloomTargets)
	table.wipe(orbGUIDs) --not needed anymore it think? 
	self.vb.bloomIcon = 8
	self:SetStage(1)
	timerBloomCD:Start(9)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show()
	end
	print("DBM Debug: Kil Mod OnCombatStart FIRED.")  
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45641 then
		warnBloomTargets[#warnBloomTargets + 1] = args.destName
		self:Unschedule(showBloomTargets)
		if self.Options.BloomIcon then
			self:SetIcon(args.destName, self.vb.bloomIcon)
		end
		self.vb.bloomIcon = self.vb.bloomIcon - 1
		if args:IsPlayer() then
			specWarnBloom:Show()
			specWarnBloom:Play("targetyou")
			yellBloom:Yell()
		end
		if #warnBloomTargets >= 5 then
			showBloomTargets(self)
		else
			self:Schedule(0.3, showBloomTargets, self)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 45641 then
		if self.Options.BloomIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unitId, spellName, rank) --not sure this should also be changed to a CLEU
--  print("Spell cast by " .. unitId .. ": " .. spellName .. " (Rank: " .. tostring(rank or "N/A") .. ")")
    if spellName == "Armageddon" then -- Check by NAME, not ID; UNIT_SPELLCAST_SUCCEEDED did not support SpellID in 3.3.5: https://warcraft.wiki.gg/wiki/UNIT_SPELLCAST_SUCCEEDED
        local targetName = UnitName(unitId .. "target")
        if targetName then
            self:ArmageddonTarget(targetName)
        else
            print("Armageddon target name not found for caster: " .. unitId)
        end
    end
end

function mod:COMBAT_LOG_EVENT_UNFILTERED(...) --overly complex solution because SPELL_DAMAGE wouldnt parse SPELL ID 45680 correctly. Dont know if thats a DBM CORE or a server issue. 
	if not self:IsInCombat() then
		return
	end
    local argsStrings = {} -- Renamed from 'args' to avoid confusion with DBM's typical 'args' table parameter
    for i = 1, select("#", ...) do
        argsStrings[i] = tostring(select(i, ...))
    end
    local function findInArgs(tbl, pattern) 
        for i, arg_str in ipairs(tbl) do
            if arg_str:match(pattern) then
                return arg_str, i 
            end
        end
        return nil, nil
    end

	local spellIdMatch, spellIdIndex = findInArgs(argsStrings, "^45680$") 
    local shieldOrbMatch, shieldOrbIndex = findInArgs(argsStrings, "Shield Orb")

    local eventType = argsStrings[2]
    local isRelevantEvent = (eventType == "SPELL_DAMAGE" or eventType == "SPELL_MISSED")
    if isRelevantEvent and (spellIdMatch or shieldOrbMatch) then
        if self:AntiSpam(10, "WarnDarkOrb") then --10s should be enough to kill one orb
            warnDarkOrb:Show() 
            specWarnDarkOrb:Show()
        end
    end
end


function mod:SPELL_CAST_START(args)
	if args.spellId == 46605 then
		specWarnBomb:Show(SHIELDSLOT)
		specWarnBomb:Play("findshield")
		timerBomb:Start()
		if self.vb.phase == 4 then
			timerBombCD:Start(25)
		else
			timerBombCD:Start()
		end
	elseif args.spellId == 45737 then
		warnDart:Show()
		timerDartCD:Start()
	elseif args.spellId == 46680 then
		timerSpike:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 45848 then
		warnShield:Show()
		specWarnShield:Show()
	elseif args.spellId == 45892 then --sinister reflection
		self:SetStage(0)
		if self.vb.phase == 2 then
			warnPhase2:Show()
			timerBloomCD:Cancel()
			timerBloomCD:Start()
			timerBlueOrb:Start()
			timerDartCD:Start(59) --12.05.25: currently only 3s, but should be fixed soon
			timerBombCD:Start(72) --happens 72s after DBM P2; 45seconds + 28 seconds of soul spike after reaching 85% HP
		elseif self.vb.phase == 3 then
			warnPhase3:Show()
			timerBloomCD:Cancel()
			timerBlueOrb:Cancel()
			timerDartCD:Cancel()
			timerBombCD:Cancel()
			timerBloomCD:Start()
			timerBlueOrb:Start()
			timerDartCD:Start(48.7) 
			timerBombCD:Start(55)
		elseif self.vb.phase == 4 then
			warnPhase4:Show()
			timerBlueOrb:Cancel()
			timerDartCD:Cancel()
			timerBombCD:Cancel()
			timerBloomCD:Cancel()
			timerBlueOrb:Start(48) --AC: 48s
			timerBloomCD:Start(20) 
			timerBombCD:Start(74) --last try it was 74s 12.05.2025 feels too long
			timerDartCD:Start(72.3)
		end
	elseif args.spellId == 46589 and args.destName ~= nil then --This Spike trigger doesnt work. There are no target indications currently (12.05.25) for shadow spike. 
		if args.destName == UnitName("player") then
			specWarnSpike:Show()
			yellSpike:Yell()
		else
			warnSpikeTarget:Show(args.destName)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.OrbYell1 or msg:find(L.OrbYell1) or msg == L.OrbYell2 or msg:find(L.OrbYell2) or msg == L.OrbYell3 or msg:find(L.OrbYell3) or msg == L.OrbYell4 or msg:find(L.OrbYell4) then
		warnBlueOrb:Show()
		specWarnBlueOrb:Show()
	end
end


function mod:ArmageddonTarget(targetName)
	if not targetName then return end
	local myName = UnitName("player")
	if targetName == myName then
		specWarnArmaYou:Show()
		specWarnArmaYou:Play("targetyou")
		yellArmageddon:Yell()
	else
		warnArmageddon:Show(targetName)
	end
end