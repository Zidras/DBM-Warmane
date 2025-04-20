local mod	= DBM:NewMod("Muru", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528_cafe20250418v24_public")
mod:SetCreatureID(25741, 25840)--25741 Muru, 25840 Entropius

mod:RegisterCombat("combat")
mod:SetUsedIcons(7, 8)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 45996 45998 46262", --Void Zone Periodic (46262) for P2darkness
	"SPELL_CAST_SUCCESS 46177 46217", --46217 entropius summon 250403
	"SPELL_SUMMON 46268 46282 46269", --46269 DarknessP2
	"UNIT_DIED",
	"UNIT_HEALTH",
	"SPELL_CAST_START 46161", --Void Blast
	"SPELL_DAMAGE 46264 46262 46285" --P2 Darkness Void Zone Effect(26264),  negative energy (26285)
)

--Phase 1
local warnHuman				= mod:NewAnnounce("WarnHuman", 4, 27778)
local warnVoid				= mod:NewAnnounce("WarnVoid", 4, 46087)
local warnDarkness			= mod:NewSpellAnnounce(45996, 2)

local specWarnVoid			= mod:NewSpecialWarning("specWarnVoid")
local specWarnVW			= mod:NewSpecialWarning("specWarnVW", "Tank")
local specWarnDarknessSoon	= mod:NewSpecialWarning("specWarnDarknessSoon", "Melee|Tank")

local timerHuman			= mod:NewTimer(60, "TimerHuman", 27778, nil, nil, 6)
local timerVoid				= mod:NewTimer(30, "TimerVoid", 46087, nil, nil, 6)
local timerNextDarkness		= mod:NewNextTimer(45, 45996, nil, nil, nil, 2)
local timerDarknessDura		= mod:NewBuffActiveTimer(20, 45996)
local specWarnVB			= mod:NewSpecialWarningInterrupt(46161, "HasInterrupt", nil, 2) --warning for VoidBlast 20250402

local berserkTimer			= mod:NewBerserkTimer(600) --no timewalking in CC, old code here (mod:IsTimewalking() and 450 or 600)

--Phase 2
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnFiend				= mod:NewAnnounce("WarnFiend", 2, 46268) --associated with p2 darkness
local warnBlackHole			= mod:NewSpellAnnounce(46282, 3)
local warnP2Darkness		= mod:NewSpellAnnounce(46264, 2) --new warning for standing in P2 Darkness to run
local yellP2Darkness		= mod:NewYell(46264)

--local specWarnBH			= mod:NewSpecialWarning("specWarnBH")

local timerBlackHoleCD		= mod:NewNextTimer(15, 46282)
local timerPhase			= mod:NewTimer(10, "TimerPhase", 46087, nil, nil, 6)
--local timerSingularity		= mod:NewNextTimer(3.2, 46238) --feel this is obsolete 20250403
local timerP2Darkness		= mod:NewNextTimer(15, 46268, nil, nil, nil, 2) --new P2 darkness timer 20250402

mod.vb.humanCount = 1
mod.vb.voidCount = 1

mod:AddRangeFrameOption("15")
mod:AddSetIconOption("P2DarknessIcon", 46264, true, false, {8})

local function HumanSpawn(self)
	warnHuman:Show(self.vb.humanCount)
	self.vb.humanCount = self.vb.humanCount + 1
	timerHuman:Start(nil, self.vb.humanCount)
	self:Schedule(60, HumanSpawn, self)
end

local function VoidSpawn(self)
	warnVoid:Show(self.vb.voidCount)
	self.vb.voidCount = self.vb.voidCount + 1
	timerVoid:Start(nil, self.vb.voidCount)
	specWarnVW:Schedule(25)
	self:Schedule(30, VoidSpawn, self)
end

local function phase2(self)
	self:SetStage(2)
	warnPhase2:Show()
	timerBlackHoleCD:Start(17-2) --corrected to CC values 20250315
	timerP2Darkness:Start(10) --new P2 darkness timer 20250402
	timerHuman:Cancel() --cancel timer when enter p2 20250402
	timerVoid:Cancel() --cancel timer when enter p2 20250402
	if self.Options.HealthFrame then
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(25840, L.Entropius)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(15)
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.humanCount = 1
	self.vb.voidCount = 1
	timerHuman:Start(15-5-delay, 1) --corrected to 10s 20250403
	timerVoid:Start(36.5-6.5-delay, 1) --corrected to 30s 20250403
	specWarnVW:Schedule(31.5-6.5) --corrected to 25s 20250403
	timerNextDarkness:Start(-delay)
	specWarnDarknessSoon:Schedule(42-2) --lowered to 40s to allow melee to move out in time 20250402
	self:Schedule(15-5, HumanSpawn, self) --seems like first cast is after 10s? 20250402
	self:Schedule(36.5-6.5, VoidSpawn, self) -- seems like 30s into combat? 20250402
	berserkTimer:Start(-delay)
	DBM.RangeCheck:Show(15)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45996 and args:GetDestCreatureID() == 25741 then
		warnDarkness:Show()
		warnDarkness:Play("dispelnow")
		specWarnVoid:Show()
		timerNextDarkness:Start()
		timerDarknessDura:Start()
		specWarnDarknessSoon:Schedule(40)
--GTFO if you stand in darkness
	elseif args.spellId == 45996 and args:IsPlayer() then
		warnDarkness:Show()
		warnDarkness:Play("runaway")
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, destName, _, spellId) --new test code to check p2darkness, working!! 20250405
	if (spellId == 46264) and destGUID == UnitGUID("player") then
		warnP2Darkness:Show()
		warnP2Darkness:Play("runaway")
		yellP2Darkness:Yell()
		if self.Options.P2DarknessIcon then
			self:SetIcon("player", 8)
		end
	end
end

--[[
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 46177 then
		timerNextDarkness:Cancel()
		timerHuman:Cancel()
		timerVoid:Cancel()
		specWarnVW:Cancel()
		timerPhase:Start()
		specWarnDarknessSoon:Cancel()
		self:Schedule(10, phase2, self)
	end
end
]]--does not work 20250404

function mod:SPELL_SUMMON(args)
	if args.spellId == 46268 then
		warnFiend:Play("dispelnow")
		if self:GetStage() == 1 then
			warnFiend:Show()
		elseif self:GetStage() == 2 then
			timerP2Darkness:Start() --new timer for next darkness 20250402
		end
	elseif args.spellId == 46282 then --singularity
		warnBlackHole:Show()
		warnBlackHole:Play("scatter")
		--specWarnBH:Show()
		timerBlackHoleCD:Start()
		--timerSingularity:Start() --feel this is obsolete 20250403
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 25840 then
		DBM:EndCombat(self)
	end
end

--new announcement for reflect VoidBlast 20250402, working now
function mod:SPELL_CAST_START(args)
	if args.spellId == 46161 then
		specWarnVB:Show()
		specWarnVB:Play("specialsoon")
	end
end

function mod:OnCombatEnd()
	DBM.RangeCheck:Hide()
end

--making code for phase 2 detection 2025.04.05
function mod:UNIT_HEALTH(uId)
	if DBM:GetUnitCreatureId(uId) == 25741 and UnitHealth(uId) == 1 then
		self:SendSync("phase2")
	end
end

function mod:OnSync(msg)
	if msg == "phase2" and self:AntiSpam(5) then
		timerNextDarkness:Cancel()
		timerHuman:Cancel()
		timerVoid:Cancel()
		specWarnVW:Cancel()
		timerPhase:Start()
		specWarnDarknessSoon:Cancel()
		self:Unschedule(HumanSpawn)
		self:Unschedule(VoidSpawn)
		self:Schedule(10, phase2, self)
	end
end

--[[
enum Spells
{
    SPELL_ENRAGE                        = 26662,
    SPELL_NEGATIVE_ENERGY               = 46009,
    SPELL_SUMMON_BLOOD_ELVES_PERIODIC   = 46041,
    SPELL_OPEN_PORTAL_PERIODIC          = 45994,
    SPELL_DARKNESS_PERIODIC             = 45998,
    SPELL_SUMMON_BERSERKER1             = 46037,
    SPELL_SUMMON_FURY_MAGE1             = 46038,
    SPELL_SUMMON_FURY_MAGE2             = 46039,
    SPELL_SUMMON_BERSERKER2             = 46040,
    SPELL_SUMMON_DARK_FIEND             = 46000, // till 46007
    SPELL_OPEN_ALL_PORTALS              = 46177,
    SPELL_SUMMON_ENTROPIUS              = 46217,

    // Entropius's spells
    SPELL_ENTROPIUS_COSMETIC_SPAWN      = 46223,
    SPELL_NEGATIVE_ENERGY_PERIODIC      = 46284,
    SPELL_BLACK_HOLE                    = 46282,
    SPELL_DARKNESS                      = 46268,
    SPELL_SUMMON_DARK_FIEND_ENTROPIUS   = 46263,

    //Black Hole Spells
    SPELL_BLACK_HOLE_SUMMON_VISUAL      = 46242,
    SPELL_BLACK_HOLE_SUMMON_VISUAL2     = 46248,
    SPELL_BLACK_HOLE_VISUAL2            = 46235,
    SPELL_BLACK_HOLE_PASSIVE            = 46228,
    SPELL_BLACK_HOLE_EFFECT             = 46230
};
]]--
