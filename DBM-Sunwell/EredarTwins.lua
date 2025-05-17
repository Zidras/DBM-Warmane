local mod	= DBM:NewMod("Twins", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20251505231320") --based on cafe20250416v19
mod:SetCreatureID(25165, 25166)
mod:SetUsedIcons(3, 6, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 45230 45347 45348 45270", --added shadowfury here (45270) 250403
	"SPELL_AURA_APPLIED_DOSE 45347 45348",
	"SPELL_CAST_START 45248 45329 45342",
	"SPELL_DAMAGE 45256",
	"SPELL_MISSED 45256",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"SPELL_CAST_SUCCESS 45271 45270" --dark strike (45271) & shadowfury (45270) from shadow image 250331
)

mod:SetBossHealthInfo(
	25165, L.Sacrolash,
	25166, L.Alythess
)

local warnBlade				= mod:NewSpellAnnounce(45248, 3)
local warnBlow				= mod:NewTargetAnnounce(45256, 3)
local warnConflag			= mod:NewTargetAnnounce(45333, 3)
local warnNova				= mod:NewTargetAnnounce(45329, 3)

local specWarnConflag		= mod:NewSpecialWarningYou(45342, nil, nil, nil, 1, 2) --using 45342 instead of 45333?
local specWarnConflagNear	= mod:NewSpecialWarningClose(45342) --using 45342 instead of 45333?
local yellConflag			= mod:NewYell(45342, nil, false) --using 45342 instead of 45333?
local specWarnNova			= mod:NewSpecialWarningYou(45329, nil, nil, nil, 1, 2)
local specWarnNovaNear		= mod:NewSpecialWarningClose(45329)
local yellNova				= mod:NewYell(45329)
local specWarnPyro			= mod:NewSpecialWarningDispel(45230, "MagicDispeller", nil, 2, 1, 2)
local specWarnDarkTouch		= mod:NewSpecialWarningStack(45347, nil, 5, nil, 2, 1, 6)
local specWarnFlameTouch	= mod:NewSpecialWarningStack(45348, nil, 5, nil, nil, 1, 6)
local specWarnShadow		= mod:NewSpecialWarningYou(45271, nil, nil, nil, 1, 2) --new warning for being target of shadow image 250331

local timerBladeCD			= mod:NewCDTimer(11.5-1.5, 45248, nil, "Melee", 2, 2) --corrected to CC value of 10s, 20250315
local timerBlowCD			= mod:NewCDTimer(20, 45256, nil, nil, nil, 3)
local timerConflagCD		= mod:NewCDTimer(31-1, 45342, nil, nil, nil, 3, nil, nil, true) -- Added "keep" arg. Considerable variation, and 31s default might an overexageration | using 45342 instead of 45333?
local timerNovaCD			= mod:NewCDTimer(31-1, 45329, nil, nil, nil, 3) -- adjusted to CC values as of 250326_1749
local timerNovaCDP2			= mod:NewCDTimer(31-11, 45329, nil, nil, nil, 3) -- new timer for ShadowNova during P2 20250416
local timerConflag			= mod:NewCastTimer(3.5, 45333, nil, false, 2)
local timerNova				= mod:NewCastTimer(3.5, 45329, nil, false, 2)

local berserkTimer			= mod:NewBerserkTimer(360) --no timewalking on CC, 250326 "(mod:IsTimewalking() and 300 or 360)"

mod:AddInfoFrameOption(45347, false) --testing information 250331

mod:AddRangeFrameOption("11")
mod:AddSetIconOption("ConflagIcon", 45333, false, false, {8}) --fixed icon reference to correct actual usage 250326
mod:AddSetIconOption("NovaIcon", 45329, false, false, {6}) --fixed icon reference to correct actual usage 250326, changed to square for easier visualization 250331

function mod:OnCombatStart(delay)
	self:SetStage(1)
	berserkTimer:Start(-delay)
	timerConflagCD:Start(18+2) -- corrected to CC values at 20s
	timerBlowCD:Start(25) -- new start timer for CONFOUNDING_BLOW at 25s CC times, 20250315
	timerBladeCD:Start(10-delay) -- new start timer for SPELL_SHADOW_BLADES at 10s, 20250316

	timerNovaCD:Start(36) -- new start timer for SHADOW_NOVA at 36s CC times, 20250315
--	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(11) --added range for shadow nova of 10y
--	end

--test code to see if shadow stacks can be shown 250331
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(DBM:GetSpellInfo(45347))
		DBM.InfoFrame:Show(30, "playerdebuffstacks", 45347, 1)
	end

end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45230 and not args:IsDestTypePlayer() then
		specWarnPyro:Show(args.destName)
		specWarnPyro:Play("dispelboss")
--[[
	elseif args.spellId == 45347 and args:IsPlayer() then
		if (args.amount or 1) >= 5 and (args.amount % 5 == 0) then
			specWarnDarkTouch:Show(args.amount)
			specWarnDarkTouch:Play("stackhigh")
		end
	elseif args.spellId == 45348 and args:IsPlayer() then
		if (args.amount or 1) >= 5 and (args.amount % 5 == 0) then
			specWarnFlameTouch:Show(args.amount)
			specWarnFlameTouch:Play("stackhigh")
		end
]]--does not work 250404
    elseif	args.spellId == 45270 then
		target = DBM:GetUnitFullName(target)
		self:SetIcon(target, 3, 8)
		if args:IsPlayer() and self:AntiSpam(3) then -- changed to mark person of shadowfury since shadow image only choose one ability 20250402, kept old code just in case reversion is needed
        specWarnShadow:Show()
		specWarnShadow:Play("runout")
		end
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

--stacks were not giving warning, trying with below code, works 250404
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
--end of new test code

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

--[[
function mod:ShadowNovaTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnNova:Show()
		specWarnNova:Play("targetyou")
		yellNova:Yell()
	elseif self:CheckNearby(2, targetname) then
		specWarnNovaNear:Show(targetname)
		specWarnNovaNear:Play("runaway")
	else
		warnNova:Show(targetname)
	end
	if self.Options.NovaIcon then
		self:SetIcon(targetname, 6, 5) -- changed to square for easier visualization 250331
	end
end

function mod:ConflagrationTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnConflag:Show()
		specWarnConflag:Play("targetyou")
		yellConflag:Yell()
	elseif self:CheckNearby(2, targetname) then
		specWarnConflagNear:Show(targetname)
		specWarnConflagNear:Play("runaway")
	else
		warnConflag:Show(targetname)
	end
	if self.Options.ConflagIcon then
		self:SetIcon(targetname, 8, 5)
	end
end
]]--not using 20250404

function mod:SPELL_CAST_START(args)
	if args.spellId == 45248 then
		warnBlade:Show()
		timerBladeCD:Start()
--[[
	elseif args.spellId == 45329 then -- Shadow Nova
		timerNova:Start()
		if self:GetStage() == 2 then
			timerNovaCDP2:Start()
		else
			timerNovaCD:Start()
		end
		self:BossTargetScanner(25165, "ShadowNovaTarget", 0.05, 6) --obsoleted as boss yell emote works 250326, revert to being used 20250327, using the marking feature only 250404
	elseif args.spellId == 45342 then -- Conflagration
		timerConflag:Start()
		timerConflagCD:Start()
		self:BossTargetScanner(self:GetCIDFromGUID(args.sourceGUID), "ConflagrationTarget", 0.05, 6) --obsoleted as boss yell emote works 250326, revert to being used 20250327, using the marking feature only 250404
]]--not using 20250404
	end
end


function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if (msg == L.Nova or msg:find(L.Nova)) then
		timerNova:Start()
		if self:GetStage() == 2 then
			timerNovaCDP2:Start()
		else
			timerNovaCD:Start()
		end
		
		local targetName
		if target then
			targetName = DBM:GetUnitFullName(target)
		end
		
		if not targetName and msg:find(L.Nova) then
			targetName = msg:match("directs Shadow Nova at (%w+)")
		end
		
		if not targetName then
			warnNova:Show("UNKNOWN")
			DBM:Debug("Failed to get Nova target from emote: " .. msg, 2)
		else
			if targetName == UnitName("player") then
				specWarnNova:Show()
				specWarnNova:Play("targetyou")
				yellNova:Yell()
			elseif self:CheckNearby(2, targetName) then
				specWarnNovaNear:Show(targetName)
				specWarnNovaNear:Play("runaway")
			else
				warnNova:Show(targetName)
			end
			
			if self.Options.NovaIcon then
				self:SetIcon(targetName, 6, 5)
			end
		end
	elseif (msg == L.Conflag or msg:find(L.Conflag)) then
		timerConflag:Start()
		timerConflagCD:Start()
		
		local targetName
		if target then
			targetName = DBM:GetUnitFullName(target)
		end
		
		if not targetName and msg:find(L.Conflag) then
			targetName = msg:match("directs Conflagration at (%w+)")
		end
		
		if not targetName then
			warnConflag:Show("UNKNOWN")
			DBM:Debug("Failed to get Conflag target from emote: " .. msg, 2)
		else
			if targetName == UnitName("player") then
				specWarnConflag:Show()
				specWarnConflag:Play("targetyou")
				yellConflag:Yell()
			elseif self:CheckNearby(2, targetName) then
				specWarnConflagNear:Show(targetName)
				specWarnConflagNear:Play("runaway")
			else
				warnConflag:Show(targetName)
			end
			
			if self.Options.ConflagIcon then
				self:SetIcon(targetName, 8, 5)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 21566 then -- Grand Warlock Alythess
		self:SetStage(2)
	end
end

--testing to warn player with shadow image attacking them but no need to run out 20250406
function mod:SPELL_CAST_SUCCESS(args)
    if args.spellId == 45271 and args:IsPlayer() and self:AntiSpam(8) then
        specWarnShadow:Show()
        specWarnShadow:Play("dontmove")
    end
end

--[[
    //Shared spells
    SPELL_ENRAGE                = 46587,
    SPELL_EMPOWER               = 45366,
    SPELL_DARK_FLAME            = 45345,
    SPELL_FIREBLAST             = 45232,

    //Lady Sacrolash spells
    SPELL_SHADOWFORM            = 45455,
    SPELL_DARK_TOUCHED          = 45347,
    SPELL_SHADOW_BLADES         = 45248,
    SPELL_SHADOW_NOVA           = 45329,
    SPELL_CONFOUNDING_BLOW      = 45256,

    //Grand Warlock Alythess spells
    SPELL_FIREFORM              = 45457,
    SPELL_FLAME_TOUCHED         = 45348,
    SPELL_PYROGENICS            = 45230,
    SPELL_CONFLAGRATION         = 45342,
    SPELL_FLAME_SEAR            = 46771,
    SPELL_BLAZE                 = 45235,
    SPELL_BLAZE_SUMMON          = 45236
]]--spell usage reference
