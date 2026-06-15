local mod	= DBM:NewMod("ThreeBugs", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240707190747")
mod:SetCreatureID(15544, 15511, 15543)

mod:SetModelID(15544)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 26580 25812",
	"SPELL_CAST_START 25807",
	"UNIT_DIED"
)

local warnFear			= mod:NewSpellAnnounce(26580, 2)
local warnToxicVolley	= mod:NewSpellAnnounce(25812, 2, nil, false)
local warnHeal			= mod:NewCastAnnounce(25807, 3)

local specWarnHeal		= mod:NewSpecialWarningInterrupt(25807, "HasInterrupt", nil, nil, 1, 2)
local specWarnGTFO		= mod:NewSpecialWarningGTFO(25786, nil, nil, nil, 1, 8)

--"Toxic Volley-25812-npc:15511 = pull:11.8, 13.6, 16.8, 34.1, 14.8, 7.3, 8.3, 12.1, 15.8, 9.7, 19.6, 9.8", -- [12]
--If users ask for a toxic volley timer, unless classic is different than retail (which i doubt), 7-34 second variable timer is not acceptable
local timerFearCD		= mod:NewCDTimer(20, 26580, nil, nil, nil, 2) -- (Lordaeron: Timewalking [2024-05-11]@[22:21:34] || Onyxia: 25N [2024-07-05]@[18:18:12]) - "Fear-26580-npc:15543-192 = pull:12.00" || "Fear-26580-npc:15543-193 = pull:11.99, 20.01"

function mod:OnCombatStart(delay)
	timerFearCD:Start(12-delay)
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"SPELL_AURA_APPLIED 25786 25989",
			"SPELL_PERIODIC_DAMAGE 25786 25989",
			"SPELL_PERIODIC_MISSED 25786 25989"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 26580 and args:IsSrcTypeHostile() and self:AntiSpam(3, 1) then
		warnFear:Show()
		timerFearCD:Start()
	elseif args.spellId == 25812 then
		warnToxicVolley:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 25807 and args:IsSrcTypeHostile() then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHeal:Show(args.sourceName)
			specWarnHeal:Play("kickcast")
		else
			warnHeal:Show()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if (args.spellId == 25786 or args.spellId == 25989) and args:IsPlayer() and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
	if (spellId == 25786 or spellId == 25989) and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 15543 then
		timerFearCD:Stop()
	end
end
