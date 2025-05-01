local mod	= DBM:NewMod("BrannBronzebeard", "DBM-Party-WotLK", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220809182722")
mod:SetCreatureID(28070)
mod:SetMinSyncRevision(2861)

mod:RegisterCombat("yell", L.Pull)
mod:RegisterKill("yell", L.Kill)
mod:SetMinCombatTime(50)
mod:SetWipeTime(355)

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_DAMAGE 59866 51125",
    "SPELL_MISSED 59866 51125"
)

local warningPhase	= mod:NewAnnounce("WarningPhase", 2, "Interface\\Icons\\Spell_Nature_WispSplode")
local timerEvent	= mod:NewTimer(345, "timerEvent", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 6)

local specWarnRegardIncendiaire = mod:NewSpecialWarningGTFO(59866, nil, nil, nil, 1, 8)

function mod:OnCombatStart(delay)
	timerEvent:Start(-delay)
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if L.Phase1 == msg then
		warningPhase:Show(1)
	elseif msg == L.Phase2 then
		warningPhase:Show(2)
	elseif msg == L.Phase3 then
		warningPhase:Show(3)
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
	if (spellId == 59866 or spellId == 51125) and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
	  specWarnRegardIncendiaire:Show(spellName)
	  specWarnRegardIncendiaire:Play("runaway")
	end
end

mod.SPELL_MISSED = mod.SPELL_DAMAGE
  