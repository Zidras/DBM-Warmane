local mod	= DBM:NewMod("Twins", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250608142317") --based on cafe20250416v19
mod:SetCreatureID(25165, 25166)
mod.statTypes = "normal25, mythic"
mod:SetUsedIcons(6, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 45230 45347 45348", 
	"SPELL_AURA_APPLIED_DOSE 45347 45348",
	"SPELL_CAST_START 45248 45342",
	"SPELL_DAMAGE 45256",
	"SPELL_MISSED 45256",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

mod:SetBossHealthInfo(
	25165, L.Sacrolash,
	25166, L.Alythess
)

local warnBlade				= mod:NewSpellAnnounce(45248, 3)
local warnBlow				= mod:NewTargetAnnounce(45256, 3)
local warnConflag			= mod:NewTargetAnnounce(45342, 3)
local warnNova				= mod:NewTargetAnnounce(45329, 3)

local specWarnConflag 		= mod:NewSpecialWarningYou(45342, nil, nil, nil, 1, 2)
local yellConflag			= mod:NewYell(45342) --using 45342 instead of 45333?
local specWarnNova			= mod:NewSpecialWarningYou(45329, nil, nil, nil, 1, 2)
local yellNova				= mod:NewYell(45329)
local specWarnPyro			= mod:NewSpecialWarningDispel(45230, "MagicDispeller", nil, 2, 1, 2)
local specWarnDarkTouch		= mod:NewSpecialWarningStack(45347, nil, 8, nil, 2, 1, 6)
local specWarnFlameTouch	= mod:NewSpecialWarningStack(45348, nil, 5, nil, nil, 1, 6)

local timerBladeCD			= mod:NewCDTimer(10, 45248, nil, false, 2, 2) --corrected to CC value of 10s, 20250315
local timerBlowCD 			= mod:NewCDTimer(20, 45256, nil, false, nil, 3) --turned off by default. 
local timerConflagCD		= mod:NewVarTimer("v30-35", 45342, nil, nil, nil, 3) -- Added new Variance timer for 30 - 35s variance 
local timerNovaCD			= mod:NewVarTimer("v30-35", 45329, nil, nil, nil, 3)
local timerConflag			= mod:NewCastTimer(3.5, 45342, nil, false, 2)
local timerNova				= mod:NewCastTimer(3.5, 45329, nil, false, 2)

local berserkTimer			= mod:NewBerserkTimer(360) --no timewalking on CC, 250326 "(mod:IsTimewalking() and 300 or 360)"

-- Track players with conflagration icon
local conflagIconPlayers = {}

mod:AddRangeFrameOption(11, 45342) --11 yards to make sure
mod:AddDropdownOption("RangeFrameActivation", {"AlwaysOn", "OnDebuff"}, "AlwaysOn", "misc")
mod:AddSetIconOption("ConflagIcon", 45342, true, false, {8}) --fixed icon reference to correct actual usage 250326
mod:AddSetIconOption("NovaIcon", 45329, true, false, {6}) --fixed icon reference to correct actual usage 250326, changed to square for easier visualization 250331

-- Helper function to check if range frame should be shown
local function shouldShowRangeFrame(self)
	if not self.Options.RangeFrame then
		return false
	end
	
	-- Always show if AlwaysOn is selected
	if self.Options.RangeFrameActivation == "AlwaysOn" then
		return true
	end
	
	-- Only show when someone has conflagration icon if OnDebuff is selected
	if self.Options.RangeFrameActivation == "OnDebuff" then
		-- Check if player has conflagration icon
		if conflagIconPlayers[UnitName("player")] then
			return true
		end
		
		-- Check if any player in range has conflagration icon
		for playerName, _ in pairs(conflagIconPlayers) do
			if playerName ~= UnitName("player") then
				return true
			end
		end
	end
	
	return false
end

-- Helper function to update range frame visibility
local function updateRangeFrame(self)
	if shouldShowRangeFrame(self) then
		if not DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Show(10) --changed to 10 yards
		end
	else
		if DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	conflagIconPlayers = {} -- Reset conflag icon tracking
	berserkTimer:Start(-delay)
	timerConflagCD:Start(18+2) -- corrected to CC values at 20s
	timerBlowCD:Start(25) -- new start timer for CONFOUNDING_BLOW at 25s CC times, 20250315
	timerBladeCD:Start(10-delay) -- new start timer for SPELL_SHADOW_BLADES at 10s, 20250316
	timerNovaCD:Start(36) -- new start timer for SHADOW_NOVA at 36s CC times, 20250315
	-- Show range frame based on activation setting
	updateRangeFrame(self)
end

function mod:OnCombatEnd()
	conflagIconPlayers = {} -- Reset conflag icon tracking
	if DBM.RangeCheck:IsShown() then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45230 and not args:IsDestTypePlayer() then
		specWarnPyro:Show(args.destName)
		specWarnPyro:Play("dispelboss")
	end
end

--seperated from SPELL_AURA_APPLIED as mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED was not working somehow
function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 45347 and args:IsPlayer() then
		if (args.amount or 1) >= 5 and (args.amount % 5 == 0) then
			specWarnDarkTouch:Show(args.amount)
			specWarnDarkTouch:Play("stackhigh")
		end
	elseif args.spellId == 45348 and args:IsPlayer() then
		if (args.amount or 1) >= 5 and (args.amount % 5 == 0) then
			specWarnFlameTouch:Show(args.amount)
			specWarnFlameTouch:Play("stackhigh")
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destName, _, spellId)
	if spellId == 45256 then
		warnBlow:Show(destName)
		timerBlowCD:Start()
	end
end

function mod:SPELL_MISSED(_, _, _, _, _, _, spellId)
	if spellId == 45256 then
		timerBlowCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 45248 then
		warnBlade:Show()
		timerBladeCD:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if (msg == L.Nova or msg:find(L.Nova)) and target then
		timerNova:Start()
		target = DBM:GetUnitFullName(target)
		if self.Options.NovaIcon then
			self:SetIcon(target, 6, 5) -- changed to square for easier visualization 250331
		end		
		if self:GetStage() == 2 then
			timerNovaCD:Start("v20-26")
		else
			timerNovaCD:Start()
		end
		if target == UnitName("player") then
			specWarnNova:Show()
			specWarnNova:Play("targetyou")
			yellNova:Yell()
		else
			warnNova:Show(target)
		end
	elseif (msg == L.Conflag or msg:find(L.Conflag)) and target then
		timerConflag:Start()
		timerConflagCD:Start()
		target = DBM:GetUnitFullName(target)
		-- Handle server bug: unresolved placeholders and nil targets --sometimes when Alythess dies a placeholder emote is fired: 20:39:34 Alythess directs Conflagration at $n.
    	if not target or target:match("%$%w") then  -- Catches $n, $r, $c, etc.
        return
   		end
		-- Track player with conflagration icon and show range frame
		conflagIconPlayers[target] = true
		updateRangeFrame(self)
		
		if self.Options.ConflagIcon then
			self:SetIcon(target, 8, 5)
		end
		
		-- Schedule removal of icon tracking after cast time + buffer
		self:Schedule(6, function() -- 3.5s cast + 2.5s buffer
			conflagIconPlayers[target] = nil
			updateRangeFrame(self)
		end)
		
		if target == UnitName("player") then
			specWarnConflag:Show()
			specWarnConflag:Play("targetyou")
			yellConflag:Yell()
		else
			warnConflag:Show(target)
		end

	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 25166 then -- Grand Warlock Alythess
		self:SetStage(2)
		timerConflagCD:Cancel()
		timerNovaCD:Cancel() 
		timerConflagCD:Start(20) --20s according to script
	elseif cid == 25165 then -- Lady Sacrolash
		self:SetStage(2)
		timerConflagCD:Cancel()
		timerNovaCD:Cancel() 
		timerNovaCD:Start("v20-26")
	end
end