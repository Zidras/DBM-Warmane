local mod	= DBM:NewMod("Grobbulus-Vanilla", "DBM-VanillaNaxx", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240714121055")
mod:SetCreatureID(15931)
mod:SetUsedIcons(1, 2, 3, 4)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 28169",
	"SPELL_AURA_REMOVED 28169",
	"SPELL_CAST_SUCCESS 28240 28157 54364"
)

local warnInjection			= mod:NewTargetNoFilterAnnounce(28169, 2)
local warnCloud				= mod:NewSpellAnnounce(28240, 2)
local warnSlimeSprayNow		= mod:NewSpellAnnounce(54364, 2)
local warnSlimeSpraySoon	= mod:NewSoonAnnounce(54364, 1)

local specWarnInjection		= mod:NewSpecialWarningYou(28169, nil, nil, nil, 1, 2)
local yellInjection			= mod:NewYellMe(28169, nil, false)

local timerInjection		= mod:NewTargetTimer(10, 28169, nil, nil, nil, 3)
local timerCloud			= mod:NewNextTimer(15, 28240, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSlimeSprayCD		= mod:NewCDTimer(27, 54364, nil, nil, nil, 2) -- 5s variance [27.09-32.60] (Onyxia PTR: [2024-07-08]@[18:49:31] || [2024-07-13]@[13:26:41]) - "Slime Spray-28157-npc:15931-797 = pull:32.60, 28.40, 59.54, 32.22, 64.35" || "Slime Spray-28157-npc:15931-797 = pull:27.09"
local enrageTimer			= mod:NewBerserkTimer(720)

mod:AddSetIconOption("SetIconOnInjectionTarget", 28169, false, false, {1, 2, 3, 4})

mod.vb.slimeSprays = 1
local mutateIcons = {}

local function addIcon(self)
	for i,j in ipairs(mutateIcons) do
		local icon = 0 + i
		self:SetIcon(j, icon)
	end
end

local function removeIcon(self, target)
	for i,j in ipairs(mutateIcons) do
		if j == target then
			table.remove(mutateIcons, i)
			self:SetIcon(target, 0)
		end
	end
	addIcon(self)
end

function mod:OnCombatStart(delay)
	self.vb.slimeSprays = 1
	table.wipe(mutateIcons)
	enrageTimer:Start(-delay)
	warnSlimeSpraySoon:Schedule(23)
	timerSlimeSprayCD:Start()
end

function mod:OnCombatEnd()
	for _, j in ipairs(mutateIcons) do
		self:SetIcon(j, 0)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 28169 then
		warnInjection:Show(args.destName)
		timerInjection:Start(args.destName)
		if args:IsPlayer() then
			specWarnInjection:Show()
			specWarnInjection:Play("runout")
			yellInjection:Yell()
		end
		if self.Options.SetIconOnInjectionTarget then
			table.insert(mutateIcons, args.destName)
			addIcon(self)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 28169 then
		timerInjection:Cancel(args.destName)--Cancel timer if someone is dumb and dispels it.
		if self.Options.SetIconOnInjectionTarget then
			removeIcon(self, args.destName)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 28240 then
		warnCloud:Show()
		timerCloud:Start()
	elseif args:IsSpellID(28157, 54364) then
		warnSlimeSprayNow:Show()
		self.vb.slimeSprays = self.vb.slimeSprays + 1
		if self.vb.slimeSprays % 2 == 0 then -- every 2/4/6... spray short cd
			warnSlimeSpraySoon:Schedule(23.4)
			timerSlimeSprayCD:Start(28.4)
		else -- every 3/5/7... spray long cd
			warnSlimeSpraySoon:Schedule(54.5)
			timerSlimeSprayCD:Start(59.5)
		end
	end
end
