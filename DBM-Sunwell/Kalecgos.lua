local mod	= DBM:NewMod("Kal", "DBM-Sunwell")
local Kal	= DBM:GetModByName("Kal")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250531110528") --based on cafe&yars_20250329v12
mod:SetCreatureID(24850)
mod.statTypes = "normal25, mythic"
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 44799",
	"SPELL_CAST_SUCCESS 45018",
	"SPELL_AURA_APPLIED 44978 45001 45002 45004 45006 45010 45029 46021 45018 45032 45034",
	"SPELL_AURA_APPLIED_DOSE 45018",
	"UNIT_DIED",
	"UNIT_HEALTH",
	"SPELL_AURA_REMOVED 45032 45034"
)

local warnPortal		= mod:NewAnnounce("WarnPortal", 4, 46021)
local warnBuffet		= mod:NewSpellAnnounce(45018, 3, nil, false, 2)
local warnBreath		= mod:NewSpellAnnounce(44799, 3, nil, false)
local warnCorrupt		= mod:NewTargetAnnounce(45029, 3)
local warnPhase2Soon	= mod:NewPrePhaseAnnounce(2, 3) -- warn at 15% health 20250313

local specWarnBuffet	= mod:NewSpecialWarningStack(45018, nil, 10, nil, nil, 1, 6)
local specWarnWildMagic	= mod:NewSpecialWarning("SpecWarnWildMagic")

local timerNextPortal	= mod:NewNextCountTimer(20, 46021, nil, nil, nil, 5) --CC set at 20-30s 2025.03.15
local timerBreathCD		= mod:NewCDTimer(15, 44799, nil, false, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Tanks?
local timerBuffetCD		= mod:NewCDTimer(8, 45018, nil, nil, nil, 2)
local timerPorted		= mod:NewBuffActiveTimer(60, 46021, nil, nil, nil, 6)
local timerExhausted	= mod:NewBuffActiveTimer(60, 44867, nil, nil, nil, 6)
local timerCurse		= mod:NewTargetTimer(30, 45032, nil, nil, nil, 3) --new curse timer to keep track of curses 20250321

--[[
local berserkTimer
if mod:IsTimewalking() then
	berserkTimer		= mod:NewBerserkTimer(300) -- Doesn't exist on retail
end
]]-- does not exist on chromiecraft 20250319

mod:AddRangeFrameOption("11")
mod:AddBoolOption("ShowRespawn", true)
mod:AddBoolOption("ShowFrame", true)
mod:AddBoolOption("InfoFrame", true)
mod:AddBoolOption("FrameLocked", false)
mod:AddBoolOption("FrameClassColor", true, nil, function()
	Kal:UpdateColors()
end)
mod:AddBoolOption("FrameUpwards", false, nil, function()
	Kal:ChangeFrameOrientation()
end)
mod:AddButton(L.FrameGUIMoveMe, function() Kal:CreateFrame() end, nil, 130, 20)

mod:AddSetIconOption("PortalIcon", 44869, true, false, {2})

mod.vb.phase = nil
mod.vb.portCount = nil
mod.vb.KalecgosHealth = nil
mod.vb.SathrovarrHealth = nil

local updateInfoFrame
do
	local twipe = table.wipe
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		twipe(lines)
		twipe(sortedLines)
	        addLine(L.name, math.ceil(mod.vb.KalecgosHealth)..'%')
	        addLine(L.Demon, math.ceil(mod.vb.SathrovarrHealth)..'%')
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.portCount = 1
	self.vb.KalecgosHealth = 100
	self.vb.SathrovarrHealth = 100
--	if self:IsTimewalking() then
--		berserkTimer:Start(-delay)
--	end
	if self.Options.ShowFrame then
		Kal:CreateFrame()
	end
--	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(11)
--	end
--[[
	if self.Options.HealthFrame then
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(24850, L.name)
		DBM.BossHealth:AddBoss(24892, L.Demon)
	end
]]--DBM.BossHealth doesn't work on ChromieCraft. Using a DBM.InfoFrame instead for now.
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader("Boss Health")
		DBM.InfoFrame:Show(2, "function", updateInfoFrame, false, false)
		DBM.InfoFrame:SetColumns(1)
	end
	timerBreathCD:Start(-delay)
	timerNextPortal:Start(13-delay) -- 20250313 new timer for first portal
end

function mod:OnCombatEnd()
	Kal:DestroyFrame()
	DBM.RangeCheck:Hide()
	DBM.InfoFrame:Hide()
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
		if self:AntiSpam(19, 2) then
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
			timerNextPortal:Start(20, self.vb.portCount)
		end
	elseif args.spellId == 45018 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 6 and amount % 2 == 0 then --lowered to 6 stacks so people can start looking for portal for 2nd time going in
			specWarnBuffet:Show(amount)
			specWarnBuffet:Play("stackhigh")
		end
--new curse tracker
	elseif args.spellId == 45032 then
		timerCurse:Start(args.destName)
	elseif 	args.spellId == 45034 then
		timerCurse:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--new curse remove when decursed
function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 45032 then
		timerCurse:Stop(args.destName)
	elseif args.spellId == 45034 then
		timerCurse:Stop(args.destName)	
	end
	
end


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


-- DBM.InfoFrame to replicate a BossHealth frame, using DBM's sync functionality.
function mod:OnSync(msg, bossHealth, sender)
	if self.Options.InfoFrame and not(sender == UnitName("player")) then
		if msg == "KalecgosHealth" and self:AntiSpam(1, 3) then
			self.vb.KalecgosHealth = tonumber(bossHealth)
			DBM:Debug("Received BossHealth data from "..sender.." for "..msg..": "..bossHealth)
		elseif msg == "SathrovarrHealth" and self:AntiSpam(1, 4) then
			self.vb.SathrovarrHealth = tonumber(bossHealth)
			DBM:Debug("Received BossHealth data from "..sender.." for "..msg..": "..bossHealth)
		end
	end
end

function mod:UNIT_HEALTH(uID)
	if self.Options.InfoFrame and self:AntiSpam(1, 5) then
		--Kalecgos
		local health, id, name = DBM:GetBossHP(24850)
		if health then
			DBM:Debug("Sending BossHealth data for "..name..": "..health)
			self.vb.KalecgosHealth = health
			self:SendSync("KalecgosHealth", self.vb.KalecgosHealth)
		end
		--Sathrovarr
		local health, id, name = DBM:GetBossHP(24892)
		if health then
			DBM:Debug("Sending BossHealth data for "..name..": "..health)		
			self.vb.SathrovarrHealth = health
			self:SendSync("SathrovarrHealth", self.vb.SathrovarrHealth)
		end
	end

	if (self.vb.KalecgosHealth <= 15 or self.vb.SathrovarrHealth <= 15) and self.vb.phase == 1 then
		warnPhase2Soon:Show()
		self.vb.phase = 2
	end
end

--[[
    SPELL_SPECTRAL_EXHAUSTION           = 44867,
    SPELL_SPECTRAL_BLAST                = 44869,
    SPELL_SPECTRAL_BLAST_PORTAL         = 44866,
    SPELL_SPECTRAL_BLAST_AA             = 46648,
    SPELL_TELEPORT_SPECTRAL             = 46019,

    SPELL_TELEPORT_NORMAL_REALM         = 46020,
    SPELL_SPECTRAL_REALM                = 46021,
    SPELL_SPECTRAL_INVISIBILITY         = 44801,
    SPELL_DEMONIC_VISUAL                = 44800,

    SPELL_ARCANE_BUFFET                 = 45018,
    SPELL_FROST_BREATH                  = 44799,
    SPELL_TAIL_LASH                     = 45122,

    SPELL_BANISH                        = 44836,
    SPELL_TRANSFORM_KALEC               = 44670,
    SPELL_CRAZED_RAGE                   = 44807,

    SPELL_CORRUPTION_STRIKE             = 45029,
    SPELL_CURSE_OF_BOUNDLESS_AGONY      = 45032,
    SPELL_CURSE_OF_BOUNDLESS_AGONY_PLR  = 45034,
    SPELL_SHADOW_BOLT                   = 45031,

    SPELL_HEROIC_STRIKE                 = 45026,
    SPELL_REVITALIZE                    = 45027
]]-- Spell IDs
