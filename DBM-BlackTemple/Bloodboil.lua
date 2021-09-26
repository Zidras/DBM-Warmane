local mod	= DBM:NewMod("Bloodboil", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(22948)

mod:SetModelID(21443)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 42005",
	"SPELL_AURA_APPLIED 42005 40481 40491 40604",
	"SPELL_AURA_APPLIED_DOSE 40481 42005",
	"SPELL_AURA_REFRESH 42005 40481",
	"SPELL_AURA_REMOVED 42005",
	"SPELL_AURA_REMOVED_DOSE 42005"
)

--TODO, verify blood is in combat log like that, otherwise have to use playerdebuffstacks frame instead
local warnBlood			= mod:NewTargetAnnounce(42005, 3)
local warnWound			= mod:NewStackAnnounce(40481, 2, nil, "Tank", 2)
local warnStrike		= mod:NewTargetNoFilterAnnounce(40491, 3, nil, "Tank", 2)
local warnRage			= mod:NewTargetAnnounce(40604, 4)
local warnRageSoon		= mod:NewSoonAnnounce(40604, 3)
local warnRageEnd		= mod:NewEndAnnounce(40604, 4)

local specWarnBlood		= mod:NewSpecialWarningStack(42005, nil, 1, nil, nil, 1, 2)
local specWarnRage		= mod:NewSpecialWarningYou(40604, nil, nil, nil, 1, 2)
local yellRage			= mod:NewYell(40604)

local timerBlood		= mod:NewCDTimer(10, 42005, nil, nil, nil, 5)--10-12. Most of time it's 11 but I have seen as low as 10.1
local timerStrikeCD		= mod:NewCDTimer(25, 40491, nil, "Tank", 2, 5, nil, DBM_CORE_L.TANK_ICON)--25-82? Is this even a CD timer?
local timerRageCD		= mod:NewCDTimer(52, 40604, nil, nil, nil, 3)--Verify?
local timerRageEnd		= mod:NewBuffActiveTimer(28, 40604, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddInfoFrameOption(42005)

mod.vb.rage = false
local bloodStacks = {}

local function nextRage(self)
	self.vb.rage = false
	warnRageEnd:Show()
	timerRageCD:Start()
	warnRageSoon:Schedule(47)
	timerBlood:Start(10.9)
end

function mod:OnCombatStart(delay)
	table.wipe(bloodStacks)
	self.vb.rage = false
	berserkTimer:Start(-delay)
	warnRageSoon:Schedule(47-delay)
	timerBlood:Start(10.9-delay)
	timerStrikeCD:Start(26.8-delay)
	timerRageCD:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(42005))
		--DBM.InfoFrame:Show(30, "playerdebuffstacks", 42005, 1)
		DBM.InfoFrame:Show(30, "table", bloodStacks, 1)--Maybe sort lowest to highest instead of highest to lowest?
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 42005 then
		timerBlood:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 42005 then
		local amount = args.amount or 1
		bloodStacks[args.destName] = amount
		warnBlood:CombinedShow(0.8, args.destName)
		if args:IsPlayer() then
			specWarnBlood:Show(amount)
			specWarnBlood:Play("targetyou")
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(bloodStacks)
		end
	elseif spellId == 40481 and not self.vb.rage then
		local amount = args.amount or 1
		if (amount % 5 == 0) then
			warnWound:Show(args.destName, amount)
		end
	elseif spellId == 40491 then
		warnStrike:Show(args.destName)
		timerStrikeCD:Start()
	elseif spellId == 40604 then
		self.vb.rage = true
		warnRage:Show(args.destName)
		timerBlood:Stop()
		timerRageEnd:Start()
		self:Schedule(28, nextRage, self)
		if args:IsPlayer() then
			specWarnRage:Show()
			specWarnRage:Play("targetyou")
			yellRage:Yell()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 42005 then
		bloodStacks[args.destName] = nil
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(bloodStacks)
		end
	end
end

function mod:SPELL_AURA_REMOVED_DOSE(args)
	local spellId = args.spellId
	if spellId == 42005 then
		bloodStacks[args.destName] = args.amount or 1
		if self.Options.InfoFrame then
			DBM.InfoFrame:UpdateTable(bloodStacks)
		end
	end
end
