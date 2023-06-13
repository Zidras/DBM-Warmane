local mod	= DBM:NewMod("Confessor", "DBM-Party-WotLK", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220925180445")
mod:SetCreatureID(34928)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 66515 66537 67675 66620 67679 66538 67676 66619 67678",
	"SPELL_AURA_REMOVED 66515 66538 67676 66619 67678"
)

local warnReflectiveShield	= mod:NewTargetNoFilterAnnounce(66515, 2)
local warnOldWounds			= mod:NewTargetNoFilterAnnounce(66620, 3, nil, "Tank|Healer")

local specwarnRenew			= mod:NewSpecialWarningDispel(66537, "MagicDispeller", nil, nil, 1, 2)
local specwarnHolyFire		= mod:NewSpecialWarningDispel(66538, "RemoveMagic", nil, nil, 1, 2)
local specwarnShadows		= mod:NewSpecialWarningDispel(66619, "RemoveMagic", nil, nil, 1, 2)

local timerOldWounds		= mod:NewTargetTimer(12, 67679)
local timerHolyFire			= mod:NewTargetTimer(8, 66538, nil, "RemoveMagic", 2, 5, nil, DBM_COMMON_L.MAGIC_ICON)
local timerShadows			= mod:NewTargetTimer(5, 66619, nil, "RemoveMagic", 2, 5, nil, DBM_COMMON_L.MAGIC_ICON)

mod.vb.shielded = false

function mod:OnCombatStart()
	self.vb.shielded = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 66515 then												-- Shield Gained
		warnReflectiveShield:Show(args.destName)
		self.vb.shielded = true
	elseif args:IsSpellID(66537, 67675) and not args:IsDestTypePlayer() then	-- Renew
		if args.destName == L.name and self.vb.shielded then
			-- nothing, she casted it on herself and you cant dispel
		else
			specwarnRenew:Show(args.destName)
			specwarnRenew:Play("dispelboss")
		end
	elseif args:IsSpellID(66620, 67679) then									-- Old Wounds
		warnOldWounds:Show(args.destName)
		timerOldWounds:Show(args.destName)
	elseif args:IsSpellID(66538, 67676) and args:IsDestTypePlayer() then	-- Holy Fire
		if self:CheckDispelFilter("magic") then
			specwarnHolyFire:Show(args.destName)
			specwarnHolyFire:Play("helpdispel")
		end
		timerHolyFire:Show(args.destName)
	elseif args:IsSpellID(66619, 67678) then									-- Shadows of the Past
		if self:CheckDispelFilter("magic") then
			specwarnShadows:Show(args.destName)
			specwarnShadows:Play("helpdispel")
		end
		timerShadows:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 66515 then
		self.vb.shielded = false
	elseif args:IsSpellID(66538, 67676) then									-- Holy Fire
		timerHolyFire:Cancel(args.destName)
	elseif args:IsSpellID(66619, 67678) then									-- Shadows of the Past
		timerShadows:Cancel(args.destName)
	end
end
