local mod	= DBM:NewMod(537, "DBM-Party-BC", 8, 250)

mod:SetRevision("20220518110528")
mod:SetCreatureID(18344)

mod:SetModelID(19780)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_SPELLCAST_SUCCEEDED"
)

local specWarnAdds	= mod:NewSpecialWarningAdds(32371, "-Healer", nil, nil, 1, 2)

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(32371) then
		self:SendSync("Adds")
	end
end

function mod:OnSync(msg)
	if msg == "Adds" and self:AntiSpam(5, 1) then
		specWarnAdds:Show()
		specWarnAdds:Play("killmob")
	end
end
