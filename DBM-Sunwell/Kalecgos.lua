local mod	= DBM:NewMod("Kal", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 530 $"):sub(12, -3))
mod:SetCreatureID(24850)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"UNIT_DIED"
)

local warnPortal		= mod:NewAnnounce("WarnPortal", 4, 46021)
local warnBuffet		= mod:NewSpellAnnounce(45018, 3)
local warnBreath		= mod:NewSpellAnnounce(44799, 3, nil, false)
local warnCorrupt		= mod:NewTargetAnnounce(45029, 3)

local specWarnBuffet	= mod:NewSpecialWarningStack(45018, nil, 10)
local specWarnWildMagic	= mod:NewSpecialWarning("SpecWarnWildMagic")

local timerNextPortal	= mod:NewNextCountTimer(25, 46021)
local timerBreathCD		= mod:NewCDTimer(15, 44799, false)
local timerBuffetCD		= mod:NewCDTimer(4, 45018)
local timerPorted		= mod:NewBuffActiveTimer(60, 46021)
local timerExhausted	= mod:NewBuffActiveTimer(60, 44867)

mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("ShowFrame", true)
mod:AddBoolOption("FrameLocked", false)
mod:AddBoolOption("FrameClassColor", true, nil, function()
	mod:UpdateColors()
end)
mod:AddBoolOption("FrameUpwards", false, nil, function()
	mod:ChangeFrameOrientation()
end)
mod:AddEditboxOption("FramePoint", "CENTER")
mod:AddEditboxOption("FrameX", 150)
mod:AddEditboxOption("FrameY", -50)

local portCount = 1

function mod:OnCombatStart(delay)
	portCount = 1
	if self.Options.ShowFrame then
		self:CreateFrame()
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
	self:DestroyFrame()
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
			self:AddEntry(("%s (%d)"):format(args.destName, grp or 0), class)
			warnPortal:Show(portCount, args.destName, grp or 0)
			portCount = portCount + 1
			timerNextPortal:Start(nil, portCount)
		end
	elseif args.spellId == 45018 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 15 and amount % 2 == 0 then
			specWarnBuffet:Show(amount)
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
		self:RemoveEntry(("%s (%d)"):format(args.destName, grp or 0))
	end
end
