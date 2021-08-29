local mod	= DBM:NewMod("NovosTheSummoner", "DBM-Party-WotLK", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3635 $"):sub(12, -3))
mod:SetCreatureID(26631)
mod:SetZone()

mod:RegisterCombat("yell", L.YellPull)
mod:RegisterKill("yell", L.YellKill)
mod:SetWipeTime(25)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local WarnCrystalHandler 	= mod:NewAnnounce("WarnCrystalHandler", 1, "Interface\\Icons\\Spell_Shadow_ShadesOfDarkness")
local warnPhase2			= mod:NewPhaseAnnounce(2)
local timerInsanity			= mod:NewCDTimer(35, 57496)
local timerInsanityDie		= mod:NewCastTimer(5, 57496)
local specwarnInsanity		= mod:NewSpecialWarningDodge(57496)
local specwarnCurse			= mod:NewSpecialWarningDispel(59856, "RemoveCurse")
local warnCurseTarget		= mod:NewTargetAnnounce(59856)
local timerNextCurse		= mod:NewCDTimer(20, 59856)
local specwarnSnow			= mod:NewSpecialWarningMove(59854)
local timerFrenzy			= mod:NewCDTimer(16, 39249)
local warnFrenzy			= mod:NewTargetAnnounce(39249)
local timerCrystalHandler 	= mod:NewTimer(30, "timerCrystalHandler", 72262, nil, nil, 1, DBM_CORE_L.DAMAGE_ICON)

mod:AddSetIconOption("SetIconOnEnragedMob", 39249, true, true)

mod.vb.CrystalHandlers = 4

function mod:OnCombatStart(delay)
	self:SetStage(1)
	timerCrystalHandler:Start(25.5-delay)
	timerInsanity:Start(20)
	timerFrenzy:Start(10)
	self.vb.CrystalHandlers = 4
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.HandlerYell then
		self.vb.CrystalHandlers = self.vb.CrystalHandlers - 1
		WarnCrystalHandler:Show(self.vb.CrystalHandlers)
		if self.vb.CrystalHandlers > 0 then
			timerCrystalHandler:Start()
		end
	elseif msg == L.Phase2 then
		warnPhase2:Show()
		self:SetStage(2)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if (args.spellId == 57496  or args.spellId == 6767) and not self:IsCreatureGUID(args.destGUID) and self:AntiSpam(1,1) then
		timerInsanity:Start()
		timerInsanityDie:Start()
		specwarnInsanity:Show()
	elseif args.spellId == 39249 then
		warnFrenzy:Show(args.destName)
		if self.Options.SetIconOnEnragedMob then
			self:ScanForMobs(args.destGUID, nil, nil, nil, nil, nil, "SetIconOnEnragedMob")
		end
		timerFrenzy:Start()
	elseif args.spellId == 59856 then
		warnCurseTarget:Show(args.destName)
		specwarnCurse:Show()
		timerNextCurse:Start()
	elseif args.spellId == 59854 and self:AntiSpam(1,2) then
		specwarnSnow:Show()
	end
end
mod.SPELL_AURA_APPLIED = mod.SPELL_CAST_SUCCESS