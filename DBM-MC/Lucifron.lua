local mod	= DBM:NewMod("Lucifron", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(12118)--, 12119

mod:SetModelID(13031)
mod:SetUsedIcons(1, 2)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 20604",
	"SPELL_CAST_SUCCESS 19702 19703",
--	"SPELL_AURA_APPLIED 20604",
	"SPELL_AURA_REMOVED 20604"
)

--[[
(ability.id = 19702 or ability.id = 19703 or ability.id = 20604) and type = "cast"
--]]
local warnDoom		= mod:NewSpellAnnounce(19702, 2)
local warnCurse		= mod:NewSpellAnnounce(19703, 3)
local warnMC		= mod:NewTargetNoFilterAnnounce(20604, 4)

local specWarnMC	= mod:NewSpecialWarningYou(20604, nil, nil, nil, 1, 2)
local yellMC		= mod:NewYell(20604)

local timerCurseCD	= mod:NewCDTimer(20.5, 19703, nil, nil, nil, 3, nil, DBM_CORE_L.CURSE_ICON)--20-25N)
local timerDoomCD	= mod:NewCDTimer(20, 19702, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)--20-25
--local timerDoom		= mod:NewCastTimer(10, 19702, nil, nil, nil, 3, nil, DBM_CORE_L.MAGIC_ICON)

mod:AddSetIconOption("SetIconOnMC", 20604, true, false, {1, 2})

mod.vb.lastIcon = 1

function mod:OnCombatStart(delay)
	self.vb.lastIcon = 1
	timerDoomCD:Start(7-delay)--7-8
	timerCurseCD:Start(12-delay)--12-15
end

function mod:MCTarget(targetname, uId)
	if not targetname then return end
	if self.Options.SetIconOnMC then
		self:SetIcon(targetname, self.vb.lastIcon)
	end
	warnMC:CombinedShow(1, targetname)
	if targetname == UnitName("player") then
		specWarnMC:Show()
		specWarnMC:Play("targetyou")
		yellMC:Yell()
	end
	--Alternate icon between 1 and 2
	if self.vb.lastIcon == 1 then
		self.vb.lastIcon = 2
	else
		self.vb.lastIcon = 1
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 20604 and args:IsSrcTypeHostile() then
		self:BossTargetScanner(args.sourceGUID, "MCTarget", 0.2, 8)
	end
end

--[[function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 20604 then
		warnMC:CombinedShow(1, args.destName)
	end
end--]]

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 20604 and args:IsDestTypePlayer() then
		if self.Options.SetIconOnMC then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 19702 then
		warnDoom:Show()
		--timerDoom:Start()
		timerDoomCD:Start()
	elseif args.spellId == 19703 then
		warnCurse:Show()
		timerCurseCD:Start()
	end
end
