local mod	= DBM:NewMod("NovosTheSummoner", "DBM-Party-WotLK", 4)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20221004111440")
mod:SetCreatureID(26631)

mod:RegisterCombat("yell", L.YellPull)
mod:RegisterKill("yell", L.YellKill)
mod:SetWipeTime(25)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 59856 59854",
	"SPELL_AURA_APPLIED 59856 59854",
	"CHAT_MSG_MONSTER_YELL"
)

local WarnCrystalHandler		= mod:NewAddsLeftAnnounce(49179, 2, 59910)
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnCurseTarget			= mod:NewTargetAnnounce(59856)

local specwarnCurse				= mod:NewSpecialWarningDispel(59856, "RemoveCurse")
local specwarnSnow				= mod:NewSpecialWarningMove(59854)

local timerCrystalHandler		= mod:NewNextTimer(20, 49179, nil, nil, nil, 1, 59910, DBM_COMMON_L.DAMAGE_ICON)
local timerNextCurse			= mod:NewCDTimer(20, 59856)

mod.vb.CrystalHandlers = 4

function mod:OnCombatStart(delay)
	self:SetStage(1)
	timerCrystalHandler:Start(25.5-delay)
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
		self:SetStage(2)
		warnPhase2:Show()
	end
end

-- need transcriptor logs to validate this. Seems unnecessary to have this event duplication
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 59856 then
		warnCurseTarget:Show(args.destName)
		specwarnCurse:Show()
		timerNextCurse:Start()
	elseif args.spellId == 59854 and self:AntiSpam(1,2) then
		specwarnSnow:Show()
	end
end
mod.SPELL_AURA_APPLIED = mod.SPELL_CAST_SUCCESS
