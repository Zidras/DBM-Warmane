local mod	= DBM:NewMod("RomuloAndJulianne", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(17534, 17533, 99999)--99999 bogus creature id to keep mod from pre mature combat end.
--
mod:SetModelID(17068)
mod:RegisterCombat("yell", L.RJ_Pull)
mod:SetWipeTime(25)--guesswork

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 30878",
	"SPELL_AURA_APPLIED 30822 30830 30841 30887",
	"SPELL_AURA_APPLIED_DOSE 30830",
	"SPELL_AURA_REMOVED 30841 30887",
	"UNIT_DIED"
)

local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warningHeal		= mod:NewCastAnnounce(30878, 3)
local warningDaring		= mod:NewTargetNoFilterAnnounce(30841, 3, nil, "Tank|MagicDispeller", 2)
local warningDevotion	= mod:NewTargetNoFilterAnnounce(30887, 3, nil, "Tank|MagicDispeller", 2)
local warningPoison		= mod:NewStackAnnounce(30830, 2, nil, "Tank|Healer")

local timerHeal			= mod:NewCastTimer(2.5, 30878)
local timerDaring		= mod:NewTargetTimer(8, 30841, nil, "Tank|MagicDispeller", 2, 5, nil, DBM_CORE_L.TANK_ICON..DBM_CORE_L.MAGIC_ICON)
local timerDevotion		= mod:NewTargetTimer(10, 30887, nil, "Tank|MagicDispeller", 2, 5, nil, DBM_CORE_L.TANK_ICON..DBM_CORE_L.MAGIC_ICON)
local timerCombatStart	= mod:NewCombatTimer(55)

mod.vb.JulianneDied = 0
mod.vb.RomuloDied = 0

function mod:OnCombatStart(delay)
	self.vb.JulianneDied = 0
	self.vb.RomuloDied = 0
	self:SetStage(1)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 30878 then
		warningHeal:Show()
		timerHeal:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(30822, 30830) then
		warningPoison:Show(args.destName, args.amount or 1)
	elseif args.spellId == 30841 then
		warningDaring:Show(args.destName)
		timerDaring:Start(args.destName)
	elseif args.spellId == 30887 then
		warningDevotion:Show(args.destName)
		timerDevotion:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 30841 then
		timerDaring:Cancel(args.destName)
	elseif args.spellId == 30887 then
		timerDevotion:Cancel(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_RJ_PHASE2_YELL or msg:find(L.DBM_RJ_PHASE2_YELL) then
		warnPhase3:Show()
		self:SetStage(3)
	elseif msg == L.Event or msg:find(L.Event) then
		timerCombatStart:Start()
	end
end


function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 17534 and self:IsInCombat() then
		if self.vb.phase == 3 then--kill only in phase 3.
			self.vb.JulianneDied = GetTime()
			if (GetTime() - self.vb.RomuloDied) < 10 then
				DBM:EndCombat(self)
			end
		else
			warnPhase2:Show()
			self:SetStage(2)
		end
	elseif cid == 17533 and self:IsInCombat() then
		if self.vb.phase == 3 then--kill only in phase 3.
			self.vb.RomuloDied = GetTime()
			if (GetTime() - self.vb.JulianneDied) < 10 then
				DBM:EndCombat(self)
			end
		end
	end
end
