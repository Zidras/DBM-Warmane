local mod	= DBM:NewMod("EadricthePure", "DBM-Party-WotLK", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220925180445")
mod:SetCreatureID(35119)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 66935 66867",
	"SPELL_AURA_APPLIED 66940 66889 66905"
)

local warnHammerofRighteous		= mod:NewSpellAnnounce(66867, 3)
local warnVengeance				= mod:NewTargetNoFilterAnnounce(66889, 3)

local specwarnRadiance			= mod:NewSpecialWarningLookAway(66935, nil, nil, nil, 2, 2)
local specwarnHammerofJustice	= mod:NewSpecialWarningDispel(66940, "Healer", nil, nil, 1, 2)
local specwarnHammerofRighteous	= mod:NewSpecialWarningYou(66905, nil, nil, nil, 1, 2)

local timerVengeance			= mod:NewBuffActiveTimer(6, 66889)

mod:AddSetIconOption("SetIconOnHammerTarget", 66940, true, true, {8})

function mod:SPELL_CAST_START(args)
	if args.spellId == 66935 then					-- Radiance Look Away!
		specwarnRadiance:Show(args.sourceName)
		specwarnRadiance:Play("turnaway")
	elseif args.spellId == 66867 then				-- Hammer of the Righteous
		warnHammerofRighteous:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 66940 then								-- Hammer of Justice on <Player>
		if self.Options.SetIconOnHammerTarget then
			self:SetIcon(args.destName, 8, 6)
		end
		if self:CheckDispelFilter("magic") then
			specwarnHammerofJustice:Show(args.destName)
			specwarnHammerofJustice:Play("helpdispel")
		end
	elseif args.spellId == 66889 then							-- Vengeance
		warnVengeance:Show(args.destName)
		timerVengeance:Start(args.destName)
	elseif args.spellId == 66905 and args:IsPlayer() then
		specwarnHammerofRighteous:Show()
		specwarnHammerofRighteous:Play("useitem")
	end
end
