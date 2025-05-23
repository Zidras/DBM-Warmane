local mod	= DBM:NewMod("Kil", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250522103545")
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
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnBloom			= mod:NewTargetAnnounce(45641, 2)
--local warnArmageddon	= mod:NewTargetAnnounce(45915, 2) --only warning for one player not three; not reliable

local warnDarkOrb		= mod:NewAnnounce("WarnDarkOrb", 4, 51512) --51512 for soulstone icon otherwise it may be confused with warnBlueOrb
local warnDart			= mod:NewSpellAnnounce(45737, 3)
local warnShield		= mod:NewSpellAnnounce(45848, 1)
local warnBlueOrb		= mod:NewAnnounce("WarnBlueOrb", 1, 45109) --45109 for green orb icon
--local warnSpikeTarget	= mod:NewTargetAnnounce(46589, 3) --warnSpikeTarget,yellSpike,specWarnSpike dont work and I am not sure if they are supposed to 
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnPhase4		= mod:NewPhaseAnnounce(4)

local specWarnArmaYou	= mod:NewSpecialWarningMove(45915, nil, nil, nil, 1, 2)
local yellArmageddon	= mod:NewYellMe(45915)
 --warnSpikeTarget,yellSpike,specWarnSpike dont work and I am not sure if they are supposed to  
--local yellSpike			= mod:NewYellMe(46589)			--warnSpikeTarget,yellSpike,specWarnSpike dont work and I am not sure if they are supposed to  
local specWarnBloom		= mod:NewSpecialWarningYou(45641, nil, nil, nil, 1, 2)
local yellBloom			= mod:NewYellMe(45641)
local specWarnBomb		= mod:NewSpecialWarningMoveTo(46605, nil, nil, nil, 3, 2)--findshield
local specWarnShield	= mod:NewSpecialWarningSpell(45848)
local specWarnDarkOrb	= mod:NewSpecialWarning("SpecWarnDarkOrb", false)
local specWarnBlueOrb	= mod:NewSpecialWarning("SpecWarnBlueOrb", false)
local specWarnSpike = mod:NewSpecialWarningSpell(46680, false, nil, nil, 2, nil, nil, nil, 2)

local timerBloomCD		= mod:NewCDTimer(40, 45641, nil, nil, nil, 2) --AC: In P1-P3: 40 seconds. In P4: 20 seconds. 
local timerDartCD		= mod:NewCDTimer(20, 45737, nil, nil, nil, 2)--Currently (12.05.25): 10s on AC, but should be fixed soon. 20s is the correct blizzard value. 
local timerBomb			= mod:NewCastTimer(9, 46605, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBombCD		= mod:NewCDTimer(45, 46605, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON) --AC: 45s regular; P4: 25s
local timerSpike		= mod:NewCastTimer(28, 46680, nil, nil, nil, 3)
local timerBlueOrb		= mod:NewTimer(38, "TimerBlueOrb", 45109, nil, nil, 5) --AC: 38s

mod:AddRangeFrameOption("11") --10 yards was sometimes not enough
mod:AddSetIconOption("BloomIcon", 45641, true, false, {4, 5, 6, 7, 8})
mod:AddInfoFrameOption(45641, false) -- Add InfoFrame option for Fire Bloom - disabled by default
mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
mod:AddDropdownOption("RangeFrameActivation", {"AlwaysOn", "OnDebuff"}, "OnDebuff", "misc")

local warnBloomTargets = {}
local orbGUIDs = {}
mod.vb.bloomIcon = 8

-- Table to track players with Fire Bloom debuff (no duration)
local bloomDebuffs = {}

local function showBloomTargets(self)
    warnBloom:Show(table.concat(warnBloomTargets, "<, >"))
    table.wipe(warnBloomTargets)
    self.vb.bloomIcon = 8
    if self.vb.phase == 4 then
        timerBloomCD:Start(18.7) 
    elseif self.vb.phase == 2 or self.vb.phase == 3 then
        timerBloomCD:Start(31.6) --<DBM> Timer Fire Bloom CD(Timer45641cd-40) (Stage 2) refreshed before expired. Remaining time is : 8.38. Please report this bug
	else					--<DBM> Timer Fire Bloom CD(Timer45641cd-40) (Stage 3) refreshed before expired. Remaining time is : 8.37. Please report this bug
        timerBloomCD:Start()
    end
end

-- Update InfoFrame with current Fire Bloom debuffs (show only player names)
local function updateBloomInfoFrame(self)
	if self.Options.InfoFrame then
		local lines = {}
		for player, _ in pairs(bloomDebuffs) do
			lines[player] = "" -- Empty string to show only player name
		end
		DBM.InfoFrame:SetHeader("Fire Bloom Debuffs")
		DBM.InfoFrame:Show(5, "table", lines, 1) -- No duration column
	end
end

local debuffName = DBM:GetSpellInfo(45641)
local DebuffFilter
do
    DebuffFilter = function(uId)
        return DBM:UnitDebuff(uId, debuffName)
    end
end

function mod:OnCombatStart(delay)
    table.wipe(warnBloomTargets)
    table.wipe(orbGUIDs) 
    table.wipe(bloomDebuffs)
    self.vb.bloomIcon = 8
    self:SetStage(1)
    timerBloomCD:Start(9)
    if self.Options.RangeFrame then
        if self.Options.RangeFrameActivation == "AlwaysOn" then
            DBM.RangeCheck:Show(11)
        else -- OnDebuff
            DBM.RangeCheck:Show(11, DebuffFilter)
        end
    end
    if self.Options.InfoFrame then
        DBM.InfoFrame:SetHeader("Fire Bloom Debuffs")
        DBM.InfoFrame:Show(5, "table", {}, 1)
    end
end

function mod:OnCombatEnd()
    if self.Options.RangeFrame then
        DBM.RangeCheck:Hide()
    end
    if self.Options.InfoFrame then
        DBM.InfoFrame:Hide()
    end
end

function mod:SPELL_AURA_APPLIED(args)
    if args.spellId == 45641 then -- Bloom
        warnBloomTargets[#warnBloomTargets + 1] = args.destName
        if self.Options.BloomIcon then
            self:SetIcon(args.destName, self.vb.bloomIcon)
            self.vb.bloomIcon = self.vb.bloomIcon - 1
        end
        
        -- Add player to bloomDebuffs without duration
        bloomDebuffs[args.destName] = true
        updateBloomInfoFrame(self)
        
        if #warnBloomTargets >= 5 then
            showBloomTargets(self)
        else
            self:Unschedule(showBloomTargets)
            self:Schedule(0.3, showBloomTargets, self)
        end

        -- Check if the debuff is applied to the player
        if args:IsPlayer() then
            -- These will always trigger if the player gets Bloom
            yellBloom:Yell()
            specWarnBloom:Show() 

            -- Additionally, show range frame if options are set
            if self.Options.RangeFrame and self.Options.RangeFrameActivation == "OnDebuff" then
                DBM.RangeCheck:Show(10, nil)
            end
        end
    end
end

-- Add the SPELL_AURA_REMOVED event to handle Bloom removal
function mod:SPELL_AURA_REMOVED(args)
    if args.spellId == 45641 then -- Bloom
        if self.Options.BloomIcon then
            self:SetIcon(args.destName, 0)
        end
        
        -- Remove player from bloomDebuffs
        bloomDebuffs[args.destName] = nil
        updateBloomInfoFrame(self)
        
        -- Update range frame if player loses debuff and option is set to OnDebuff
        if args:IsPlayer() and self.Options.RangeFrame and self.Options.RangeFrameActivation == "OnDebuff" then
            DBM.RangeCheck:Show(10, DebuffFilter) -- Only show others with debuff
        end
    end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unitId, spellName, rank) --not very reliable. Only the one player shows in the Combatlog, but three are targeted. 
    if spellName == "Armageddon" then -- Check by NAME, not ID; UNIT_SPELLCAST_SUCCEEDED did not support SpellID before CATA: https://warcraft.wiki.gg/wiki/UNIT_SPELLCAST_SUCCEEDED
        local targetName = UnitName(unitId .. "target")
        if targetName then
            self:ArmageddonTarget(targetName)
        else
            DBM:AddMsg("Armageddon target name not found for caster: " .. unitId)
        end
    end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, _, _, _, _, spellId)
	if sourceName == "Shield Orb" and spellId == 45680 and self:AntiSpam(10) then
		warnDarkOrb:Show()
		specWarnDarkOrb:Show()
	end
end
function mod:SPELL_MISSED(sourceGUID, sourceName, _, _, _, _, spellId) --so warnDarkOrb also triggers when a Shadowbolt from orbs is missed/resisted
	if sourceName == "Shield Orb" and spellId == 45680 and self:AntiSpam(10) then
		warnDarkOrb:Show()
		specWarnDarkOrb:Show()
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
		specWarnSpike:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 45848 then
		warnShield:Show()
		specWarnShield:Show()
	elseif args.spellId == 45892 then --sinister reflection
		self:SetStage(0)
--Phase 3, 85% Health | Darkness
		if self.vb.phase == 2 then
			warnPhase2:Show()
			timerBloomCD:Cancel()
			timerBloomCD:Start(36) 
			timerBlueOrb:Start()
			timerDartCD:Start(52) --14.05.25 Chromie PTR: 52.37s 
			timerBombCD:Start(72) --14.05.25 Chromie PTR: 72s after P2 starts; 45seconds + 28 seconds of soul spike after reaching 85% HP. Slightly too short should be 77s. 
--Phase 4, 55% Health | Armageddon	
		elseif self.vb.phase == 3 then
			warnPhase3:Show()
			timerBloomCD:Cancel()
			timerBlueOrb:Cancel()
			timerDartCD:Cancel()
			timerBombCD:Cancel()
			timerBloomCD:Start(36) --9s + 28s spike -1s phase delay 
			timerBlueOrb:Start()
			timerDartCD:Start(49) --14.05.25 Chromie PTR: 49.55s 
			timerBombCD:Start(78) --14.05.25 Chromie PTR 78s; 

--Phase 5, 25% health | Sacrifice
		elseif self.vb.phase == 4 then
			warnPhase4:Show()
			timerBlueOrb:Cancel()
			timerDartCD:Cancel()
			timerBombCD:Cancel()
			timerBloomCD:Cancel()
			timerBlueOrb:Start(48) --AC: 48s
			timerBloomCD:Start(20) 
			timerBombCD:Start(59) --14.05.2025 Chromie PTR 74s 
			timerDartCD:Start(67) --14.04.25 Chromie PTR: 67.85s
		end
--[[	elseif args.spellId == 46589 and args.destName ~= nil then --This Spike trigger doesnt work. There are no target indications currently (12.05.25) for shadow spike. Classic TBC does not have this feature. Dunno if its supposed to work
		if args.destName == UnitName("player") then
			specWarnSpike:Show()
			yellSpike:Yell()
		else
			warnSpikeTarget:Show(args.destName)
		end
	end]]
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.OrbYell1 or msg:find(L.OrbYell1) or msg == L.OrbYell2 or msg:find(L.OrbYell2) or msg == L.OrbYell3 or msg:find(L.OrbYell3) or msg == L.OrbYell4 or msg:find(L.OrbYell4) then
		warnBlueOrb:Show()
		specWarnBlueOrb:Show()
	end
end


function mod:ArmageddonTarget(targetName) --only warns the first player targetted. 
	if not targetName then return end
	local myName = UnitName("player")
	if targetName == myName then
		specWarnArmaYou:Show()
		specWarnArmaYou:Play("move")
		yellArmageddon:Yell()
--	else
--		warnArmageddon:Show(targetName)
	end
end