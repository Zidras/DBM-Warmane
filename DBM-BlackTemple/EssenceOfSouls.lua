local mod	= DBM:NewMod("Souls", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250717180359")
mod:SetCreatureID(23418) -- 23418: Essence of Suffering ; 23419: Essence of Desire ; 23420: Essence of Anger
mod:SetHotfixNoticeRev(20250717000000)

mod:SetModelID(21483)
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 41305 41431 41376 41303 41294 41410",
	"SPELL_AURA_REMOVED 41305",
	"SPELL_CAST_START 41410 41426",
	"SPELL_CAST_SUCCESS 41350 41337",
	"SPELL_DAMAGE 41545",
	"SPELL_MISSED 41545",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--maybe a warning for Seethe if tanks mess up in phase 3
local warnFixate		= mod:NewTargetNoFilterAnnounce(41294, 3, nil, "Tank|Healer", 2)
local warnDrain			= mod:NewTargetNoFilterAnnounce(41303, 3, nil, "Healer", 2)
local warnFrenzy		= mod:NewSpellAnnounce(41305, 3, nil, "Tank|Healer", 2)
local warnFrenzySoon	= mod:NewPreWarnAnnounce(41305, 5, 2)
local warnFrenzyEnd		= mod:NewEndAnnounce(41305, 1, nil, "Tank|Healer", 2)

local warnPhase2		= mod:NewPhaseAnnounce(2, 2)
local warnMana			= mod:NewAnnounce("WarnMana", 4, 41350)
local warnDeaden		= mod:NewTargetNoFilterAnnounce(41410, 1)
local specWarnShock		= mod:NewSpecialWarningInterrupt(41426, "HasInterrupt", nil, 2)

local warnPhase3		= mod:NewPhaseAnnounce(3, 2)
local warnSoul			= mod:NewSpellAnnounce(41545, 2, nil, "Tank", 2)
local warnSpite			= mod:NewTargetAnnounce(41376, 3)

local specWarnShield	= mod:NewSpecialWarningDispel(41431, "MagicDispeller", nil, 2, 1, 2)
local specWarnSpite		= mod:NewSpecialWarningYou(41376, nil, nil, nil, 1, 2)

--Phase 1
local timerPhaseChange	= mod:NewPhaseTimer(41)
local timerFrenzy		= mod:NewBuffActiveTimer(8, 41305, nil, "Tank|Healer", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerNextFrenzy	= mod:NewNextTimer(40, 41305, nil, "Tank|Healer", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
--Phase 2
local timerDeaden		= mod:NewTargetTimer(10, 41410, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON, nil, mod:IsTank() and select(2, UnitClass("player")) == "WARRIOR" and 2, 4)
local timerNextDeaden	= mod:NewCDTimer(31, 41410, nil, nil, nil, 5)--Roll timer because I don't want to assign it interrupt one when many groups will use prot warrior
local timerMana			= mod:NewTimer(160, "TimerMana", 41350)
local timerNextShock	= mod:NewCDTimer(12, 41426, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--Blizz lied, this is a 12-15 second cd. you can NOT solo interrupt these with most classes
--Phase 3
local timerNextShield	= mod:NewCDTimer(15, 41431, nil, "MagicDispeller", 2, 5, nil, DBM_COMMON_L.MAGIC_ICON)
local timerNextSoul		= mod:NewCDTimer(10, 41545, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("DrainIcon", 41303, false)
mod:AddSetIconOption("SpiteIcon", 41376, false)

mod.vb.lastFixate = "None"

function mod:OnCombatStart(delay)
	self.vb.lastFixate = "None"
	timerNextFrenzy:Start(49-delay)
	warnFrenzySoon:Schedule(44-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 41305 then
		warnFrenzy:Show()
		timerFrenzy:Start()
	elseif args.spellId == 41431 and not args:IsDestTypePlayer() then
		timerNextShield:Start()
		specWarnShield:Show(args.destName)
		specWarnShield:Play("dispelboss")
	elseif args.spellId == 41376 then
		warnSpite:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSpite:Show()
			specWarnSpite:Play("defensive")
		end
		if self.Options.SpiteIcon then
			self:SetAlphaIcon(0.5, args.destName)
		end
	elseif args.spellId == 41303 then
		warnDrain:CombinedShow(1, args.destName)
		if self.Options.DrainIcon then
			self:SetAlphaIcon(1, args.destName)
		end
	elseif args.spellId == 41294 then
		if self.vb.lastFixate ~= args.destName then
			warnFixate:Show(args.destName)
			self.vb.lastFixate = args.destName
		end
	elseif args.spellId == 41410 and not args:IsDestTypePlayer() then
		warnDeaden:Show(args.destName)
		timerDeaden:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 41305 then
		warnFrenzyEnd:Show()
		warnFrenzySoon:Schedule(35)
		timerNextFrenzy:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 41410 then
		timerNextDeaden:Start()
	elseif args.spellId == 41426 then
		timerNextShock:Start()
		specWarnShock:Show(args.sourceName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 41350 then --Aura of Desire
		warnPhase2:Show()
		warnMana:Schedule(130)
		timerMana:Start()
		timerNextShield:Start(13)
		timerNextDeaden:Start(28)
	elseif args.spellId == 41337 then --Aura of Anger
		warnPhase3:Show()
		timerNextSoul:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, _, spellId)
	if spellId == 41545 and self:AntiSpam(3, 1) then
		warnSoul:Show()
		timerNextSoul:Start()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

--Boss Unit IDs stilln ot present in 7.2.5 so mouseover/target and antispam required
function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(28819) and self:AntiSpam(2, 2) then--Submerge Visual
		self:SendSync("PhaseEnd")
	end
end

--Backup to no one targetting boss
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase1End or msg:find(L.Phase1End) or msg == L.Phase2End or msg:find(L.Phase2End) then
		self:SendSync("PhaseEnd")
	end
end

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "PhaseEnd" then
		warnFrenzyEnd:Cancel()
		warnFrenzySoon:Cancel()
		warnMana:Cancel()
		timerNextFrenzy:Stop()
		timerFrenzy:Stop()
		timerMana:Stop()
		timerNextShield:Stop()
		timerNextDeaden:Stop()
		timerNextShock:Stop()
		timerPhaseChange:Start()--41
	end
end
