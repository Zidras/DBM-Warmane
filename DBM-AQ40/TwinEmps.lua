local mod	= DBM:NewMod("TwinEmpsAQ", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(15276, 15275)

--mod:SetModelID(15778)--Renders too close
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 799 800 26613 26607 804",
	"SPELL_AURA_REMOVED 804",
	"SPELL_CAST_SUCCESS 802 804"--26613
)

--Add warning for classic to actually swap for strike? boss taunt immune though.
local warnStrike			= mod:NewTargetNoFilterAnnounce(26613, 3, nil, "Tank|Healer", 2)
local warnTeleport			= mod:NewSpellAnnounce(800, 3)
local warnMutateBug			= mod:NewSpellAnnounce(802, 2, nil, false)

local specWarnStrike		= mod:NewSpecialWarningDefensive(26613, nil, nil, nil, 1, 2)
local specWarnExplodeBug	= mod:NewSpecialWarningMove(804, nil, nil, nil, 1, 2)
local specWarnGTFO			= mod:NewSpecialWarningGTFO(26607, nil, nil, nil, 8, 2)

local timerTeleport			= mod:NewCDTimer(29.2, 800, nil, nil, nil, 6, nil, nil, true, 1, 4)--29.2-40.2
local timerExplodeBugCD		= mod:NewCDTimer(4.9, 804, nil, false, nil, 1)--4.9-9
local timerMutateBugCD		= mod:NewCDTimer(11, 802, nil, false, nil, 1)--11-16
--local timerStrikeCD		= mod:NewCDTimer(9.7, 26613, nil, "Tank", nil, 5, nil, DBM_CORE_L.TANK_ICON)--9.7-42.6

local berserkTimer			= mod:NewBerserkTimer(900)

--mod:AddNamePlateOption("NPAuraOnMutateBug", 802)

function mod:OnCombatStart(delay)
	--timerStrikeCD:Start(14.2-delay)
	berserkTimer:Start()
	timerTeleport:Start(-delay)
	if self.Options.NPAuraOnMutateBug then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
--	if self.Options.NPAuraOnMutateBug then
--		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
--	end
end

--pull:30.6, 35.2, 37.8, 40.1, 36.5, 36.6, 37.7, 31.9, 31.7, 38.8, 32.9, 30.4, 40.2, 30.6, 37.6, 35.4, 32.9, 34.2, 35.3, 36.5, 30.4, 29.2, 34.3, 32.8, 40.0, 35.4, 36.5, 35.3

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(799, 800) and self:AntiSpam(5, 1) then
		warnTeleport:Show()
		timerTeleport:Start()
	--elseif args.spellId == 26613 and not self:IsTrivial(80) then
	elseif args.spellId == 26613 then
		if args:IsPlayer() then
			specWarnStrike:Show()
			specWarnStrike:Play("defensive")
		else
			warnStrike:Show(args.destName)
		end
	elseif args.spellId == 26607 and args:IsPlayer() and args:IsSrcTypeHostile() then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif args.spellId == 804 then
--		if self.Options.NPAuraOnMutateBug then
--			DBM.Nameplate:Show(true, args.destGUID, 804, 135826, 4)
--		end
--		for i = 1, 40 do
--			local GUID = UnitGUID("nameplate"..i)
--			if GUID and GUID == args.destGUID then--Bug is in nameplate range
--				specWarnExplodeBug:Show()
--				specWarnExplodeBug:Play("runaway")
--				break
--			end
--		end
	end
end
function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 804 then
--		if self.Options.NPAuraOnMutateBug then
--			DBM.Nameplate:Hide(true, args.destGUID, 804, 135826)
--		end
	end
end
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 802 then
		warnMutateBug:Show()
		timerMutateBugCD:Start()
	elseif args.spellId == 804 then
		timerExplodeBugCD:Start()
	--elseif spellId == 26613 then
		--timerStrikeCD:Start()
	end
end
