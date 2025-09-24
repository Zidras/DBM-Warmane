local mod	= DBM:NewMod("Twins", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220925155424")
mod:SetCreatureID(25165, 25166)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 45230 45347 45348",
	"SPELL_AURA_APPLIED_DOSE 45347 45348",
	"SPELL_CAST_START 45248 45329 45342",
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
local warnConflag			= mod:NewTargetAnnounce(45333, 3)
local warnNova				= mod:NewTargetAnnounce(45329, 3)

local specWarnConflag		= mod:NewSpecialWarningYou(45333, nil, nil, nil, 1, 2)
local specWarnConflagNear	= mod:NewSpecialWarningClose(45333)
local yellConflag			= mod:NewYell(45333, nil, false)
local specWarnNova			= mod:NewSpecialWarningYou(45329, nil, nil, nil, 1, 2)
local specWarnNovaNear		= mod:NewSpecialWarningClose(45329)
local yellNova				= mod:NewYell(45329)
local specWarnPyro			= mod:NewSpecialWarningDispel(45230, "MagicDispeller", nil, 2, 1, 2)
local specWarnDarkTouch		= mod:NewSpecialWarningStack(45347, false, 5, nil, 2, 1, 6)
local specWarnFlameTouch	= mod:NewSpecialWarningStack(45348, false, 5, nil, nil, 1, 6)

local timerBladeCD			= mod:NewCDTimer(11.5, 45248, nil, "Melee", 2, 2)
local timerBlowCD			= mod:NewCDTimer(20, 45256, nil, nil, nil, 3)
local timerConflagCD		= mod:NewCDTimer(31, 45333, nil, nil, nil, 3, nil, nil, true) -- Added "keep" arg. Considerable variation, and 31s default might an overexageration
local timerNovaCD			= mod:NewCDTimer(31, 45329, nil, nil, nil, 3)
local timerConflag			= mod:NewCastTimer(3.5, 45333, nil, false, 2)
local timerNova				= mod:NewCastTimer(3.5, 45329, nil, false, 2)

local berserkTimer			= mod:NewBerserkTimer(mod:IsTimewalking() and 300 or 360)

mod:AddRangeFrameOption("12")
mod:AddSetIconOption("ConflagIcon", 45333, false, false, {7})
mod:AddSetIconOption("NovaIcon", 45329, false, false, {8})

function mod:OnCombatStart(delay)
	self:SetStage(1)
	berserkTimer:Start(-delay)
	timerConflagCD:Start(18) -- variable (18-22?)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show()
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 45230 and not args:IsDestTypePlayer() then
		specWarnPyro:Show(args.destName)
		specWarnPyro:Play("dispelboss")
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
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

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
		self:SetIcon(targetname, 7, 5)
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

function mod:SPELL_CAST_START(args)
	if args.spellId == 45248 then
		warnBlade:Show()
		timerBladeCD:Start()
	elseif args.spellId == 45329 then -- Shadow Nova
		timerNova:Start()
		timerNovaCD:Start()
		self:BossTargetScanner(25165, "ShadowNovaTarget", 0.05, 6)
	elseif args.spellId == 45342 then -- Conflagration
		timerConflag:Start()
		timerConflagCD:Start()
		self:BossTargetScanner(self:GetCIDFromGUID(args.sourceGUID), "ConflagrationTarget", 0.05, 6)
	end
end

-- CHAT_MSG_RAID_BOSS_EMOTE bugged on Warmane: https://www.warmane.com/bugtracker/report/106891
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if (msg == L.Nova or msg:find(L.Nova)) and target then
		DBM:AddMsg("Nova emote is working again. Notify me (Zidras) on discord or open a bug report.")
		target = DBM:GetUnitFullName(target)
		timerNova:Start()
		timerNovaCD:Start()
		if target == UnitName("player") then
			specWarnNova:Show()
			specWarnNova:Play("targetyou")
			yellNova:Yell()
		elseif self:CheckNearby(2, target) then
			specWarnNovaNear:Show(target)
			specWarnNovaNear:Play("runaway")
		else
			warnNova:Show(target)
		end
		if self.Options.NovaIcon then
			self:SetIcon(target, 7, 5)
		end
	elseif (msg == L.Conflag or msg:find(L.Conflag)) and target then
		DBM:AddMsg("Conflagration emote is working again. Notify me (Zidras) on discord or open a bug report.")
		target = DBM:GetUnitFullName(target)
		timerConflag:Start()
		timerConflagCD:Start()
		if target == UnitName("player") then
			specWarnConflag:Show()
			specWarnConflag:Play("targetyou")
			yellConflag:Yell()
		elseif self:CheckNearby(2, target) then
			specWarnConflagNear:Show(target)
			specWarnConflagNear:Play("runaway")
		else
			warnConflag:Show(target)
		end
		if self.Options.ConflagIcon then
			self:SetIcon(target, 8, 5)
		end
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 21566 then -- Grand Warlock Alythess
		self:SetStage(2)
	end
end
