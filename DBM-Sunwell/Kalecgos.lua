local mod	= DBM:NewMod("Kal", "DBM-Sunwell")
local Kal	= DBM:GetModByName("Kal")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(24850)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 44799",
	"SPELL_CAST_SUCCESS 45018",
	"SPELL_AURA_APPLIED 44978 45001 45002 45004 45006 45010 45029 46021 45018",
	"SPELL_AURA_APPLIED_DOSE 45018",
	"UNIT_DIED"
)

local warnPortal		= mod:NewAnnounce("WarnPortal", 4, 46021)
local warnBuffet		= mod:NewSpellAnnounce(45018, 3, nil, false, 2)
local warnBreath		= mod:NewSpellAnnounce(44799, 3, nil, false)
local warnCorrupt		= mod:NewTargetAnnounce(45029, 3)

local specWarnBuffet	= mod:NewSpecialWarningStack(45018, nil, 10, nil, nil, 1, 6)
local specWarnWildMagic	= mod:NewSpecialWarning("SpecWarnWildMagic")

local timerNextPortal	= mod:NewNextCountTimer(25, 46021, nil, nil, nil, 5)
local timerBreathCD		= mod:NewCDTimer(15, 44799, nil, false, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Tanks?
local timerBuffetCD		= mod:NewCDTimer(8, 45018, nil, nil, nil, 2)
local timerPorted		= mod:NewBuffActiveTimer(60, 46021, nil, nil, nil, 6)
local timerExhausted	= mod:NewBuffActiveTimer(60, 44867, nil, nil, nil, 6)

local berserkTimer
if mod:IsTimewalking() then
	berserkTimer		= mod:NewBerserkTimer(300) -- Doesn't exist on retail
end

mod:AddRangeFrameOption("12")
mod:AddBoolOption("ShowRespawn", true)
mod:AddBoolOption("ShowFrame", true)
mod:AddBoolOption("FrameLocked", false)
mod:AddBoolOption("FrameClassColor", true, nil, function()
	Kal:UpdateColors()
end)
mod:AddBoolOption("FrameUpwards", false, nil, function()
	Kal:ChangeFrameOrientation()
end)
mod:AddButton(L.FrameGUIMoveMe, function() Kal:CreateFrame() end, nil, 130, 20)

mod.vb.portCount = 1

function mod:OnCombatStart(delay)
	self.vb.portCount = 1
	if self:IsTimewalking() then
		berserkTimer:Start(-delay)
	end
	if self.Options.ShowFrame then
		Kal:CreateFrame()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show()
	end
	if self.Options.HealthFrame then
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(24850, L.name)
		DBM.BossHealth:AddBoss(24892, L.Demon)
	end
end

function mod:OnCombatEnd()
	Kal:DestroyFrame()
	DBM.RangeCheck:Hide()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 44978 and args:IsPlayer() and self:IsHealer() then
		specWarnWildMagic:Show(L.Heal)
	elseif args.spellId == 45001 and args:IsPlayer() then
		specWarnWildMagic:Show(L.Haste)
	elseif args.spellId == 45002 and args:IsPlayer() and self:IsMelee() then
		specWarnWildMagic:Show(L.Hit)
	elseif args.spellId == 45004 and args:IsPlayer() and not self:IsHealer() then
		specWarnWildMagic:Show(L.Crit)
	elseif args.spellId == 45006 and args:IsPlayer() and not self:IsHealer() then
		specWarnWildMagic:Show(L.Aggro)
	elseif args.spellId == 45010 and args:IsPlayer() then
		specWarnWildMagic:Show(L.Mana)
	elseif args.spellId == 45029 and self:IsInCombat() then
		warnCorrupt:Show(args.destName)
	elseif args.spellId == 46021 then
		if args:IsPlayer() then
			timerPorted:Start()
			timerExhausted:Schedule(60)
		end
		if self:AntiSpam(20, 2) then
			local grp, class
			if GetNumRaidMembers() > 0 then
				for i = 1, GetNumRaidMembers() do
					local name, _, subgroup, _, _, fileName = GetRaidRosterInfo(i)
					if name == args.destName then
						grp = subgroup
						class = fileName
						break
					end
				end
			else
				-- solo raid
				grp = 0
				class = select(2, UnitClass("player"))
			end
			Kal:AddEntry(("%s (%d)"):format(args.destName, grp or 0), class)
			warnPortal:Show(self.vb.portCount, args.destName, grp or 0)
			self.vb.portCount = self.vb.portCount + 1
			timerNextPortal:Start(nil, self.vb.portCount)
		end
	elseif args.spellId == 45018 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 10 and amount % 2 == 0 then
			specWarnBuffet:Show(amount)
			specWarnBuffet:Play("stackhigh")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args.spellId == 44799 then
		warnBreath:Show()
		timerBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 45018 and self:AntiSpam(7, 1) then
		warnBuffet:Show()
		timerBuffetCD:Start()
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 24892 then
		DBM:EndCombat(self)
	end
	if bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
		local grp
		if GetNumRaidMembers() > 0 then
			for i = 1, GetNumRaidMembers() do
				local name, _, subgroup = GetRaidRosterInfo(i)
				if name == args.destName then
					grp = subgroup
					break
				end
			end
		else
			grp = 0
		end
		Kal:RemoveEntry(("%s (%d)"):format(args.destName, grp or 0))
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if self:IsInCombat() and not UnitExists("boss1") and self.Options.ShowRespawn then
		DBT:CreateBar(30, DBM_CORE_L.TIMER_RESPAWN:format(L.name), "Interface\\Icons\\Spell_Holy_BorrowedTime")
	end
end
