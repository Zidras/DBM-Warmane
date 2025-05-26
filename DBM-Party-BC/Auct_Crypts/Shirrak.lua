local mod	= DBM:NewMod(523, "DBM-Party-BC", 7, 247)

mod:SetRevision("20220518110528")
mod:SetCreatureID(18371)

mod:SetModelID(18916)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnFocusFire		= mod:NewTargetAnnounce(32300, 3)
local timerFocusFire	= mod:NewCDTimer("v15-20", 32300, nil, nil, nil, 3)
local specWarnFocusFire	= mod:NewSpecialWarningDodge(32300, nil, nil, nil, 1, 2)


function mod:OnCombatStart()
	timerFocusFire:Start(17)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, _, _, target)
	local targetname = DBM:GetUnitFullName(target) or target
	timerFocusFire:Start()
	if targetname == UnitName("player") then
		specWarnFocusFire:Show()
		specWarnFocusFire:Play("watchstep")
	else
		warnFocusFire:Show(target)
	end
end
