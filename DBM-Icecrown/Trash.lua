local mod	= DBM:NewMod("ICCTrash", "DBM-Icecrown", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4408 $"):sub(12, -3))
mod:SetModelID(37007)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)

--Lower Spire
local warnDisruptingShout		= mod:NewSpellAnnounce(71022, 2)
local warnDarkReckoning			= mod:NewTargetAnnounce(69483, 3)
local warnDeathPlague			= mod:NewTargetAnnounce(72865, 4)
--Plagueworks
local warnZombies				= mod:NewSpellAnnounce(71159, 2)
local warnMortalWound			= mod:NewStackAnnounce(71127, 2, nil, "Tank|Healer")
local warnDecimateSoon			= mod:NewSoonAnnounce(71123, 3)
--Crimson Hall
local warnBloodMirror			= mod:NewTargetAnnounce(70451, 3, nil, "Healer")
local warnBloodSap				= mod:NewTargetAnnounce(70432, 4)
local warnChainsofShadow		= mod:NewTargetAnnounce(70645, 3)
--Frostwing Hall
local warnConflag				= mod:NewTargetAnnounce(71785, 4)
local warnBanish				= mod:NewTargetAnnounce(71298, 3)

--Lower Spire
local specWarnDisruptingShout	= mod:NewSpecialWarningCast(71022)
local specWarnDarkReckoning		= mod:NewSpecialWarningMoveAway(69483)
local specWarnDeathPlague		= mod:NewSpecialWarningYou(72865)
local specWarnTrapL				= mod:NewSpecialWarning("SpecWarnTrapL")
--Plagueworks
local specWarnDecimate			= mod:NewSpecialWarningSpell(71123)
local specWarnMortalWound		= mod:NewSpecialWarningStack(71127, "Tank|Healer", 6)
local specWarnTrapP				= mod:NewSpecialWarning("SpecWarnTrapP")
local specWarnBlightBomb		= mod:NewSpecialWarningSpell(71088)
--Frostwing Hall
local specWarnGosaEvent			= mod:NewSpecialWarning("SpecWarnGosaEvent")
local specWarnBlade				= mod:NewSpecialWarningMove(70305)

--Lower Spire
local timerDisruptingShout		= mod:NewCastTimer(3, 71022)
local timerDarkReckoning		= mod:NewTargetTimer(8, 69483)
local timerDeathPlague			= mod:NewTargetTimer(15, 72865)
--Plagueworks
local timerZombies				= mod:NewNextTimer(20, 71159)
local timerMortalWound			= mod:NewTargetTimer(15, 71127)
local timerDecimate				= mod:NewNextTimer(33, 71123)
local timerBlightBomb			= mod:NewCastTimer(5, 71088)
--Crimson Hall
local timerBloodMirror			= mod:NewTargetTimer(30, 70451, nil, "Healer")
local timerBloodSap				= mod:NewTargetTimer(8, 70432)
local timerChainsofShadow		= mod:NewTargetTimer(10, 70645)
--Frostwing Hall
local timerConflag				= mod:NewTargetTimer(10, 71785)
local timerBanish				= mod:NewTargetTimer(6, 71298)

mod:RemoveOption("HealthFrame")
--Lower Spire
mod:AddSetIconOption("SetIconOnDarkReckoning", 69483, true)
mod:AddSetIconOption("SetIconOnDeathPlague", 72865, true)
--Crimson Hall
mod:AddSetIconOption("BloodMirrorIcon", 70451, false)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69483 then
		warnDarkReckoning:Show(args.destName)
		timerDarkReckoning:Start(args.destName)
		if args:IsPlayer() then
			specWarnDarkReckoning:Show()
		end
		if self.Options.SetIconOnDarkReckoning then
			self:SetIcon(args.destName, 8, 8)
		end
	elseif args.spellId == 72865 then
		warnDeathPlague:CombinedShow(0.3, args.destName)
		timerDeathPlague:Start(args.destName)
		if args:IsPlayer() then
			specWarnDeathPlague:Show()
		end
		if self.Options.SetIconOnDeathPlague then
			self:SetSortedIcon(0.3, args.destName, 8, 8, true)
		end
	elseif args.spellId == 71127 then
		local amount = args.amount or 1
		timerMortalWound:Start(args.destName)
		if amount % 2 == 0 then
			warnMortalWound:Show(args.destName, amount)
			if args:IsPlayer() and amount > 5 then
				specWarnMortalWound:Show(amount)
			end
		end
	elseif args.spellId == 70451 and args:IsDestTypePlayer() then
		warnBloodMirror:CombinedShow(0.3, args.destName)
		timerBloodMirror:Start(args.destName)
		if self.Options.BloodMirrorIcon then
			self:SetSortedIcon(0.3, args.destName, 2, 2, true)
		end
	elseif args.spellId == 70432 then
		warnBloodSap:Show(args.destName)
		timerBloodSap:Start(args.destName)
	elseif args.spellId == 70645 and args:IsDestTypePlayer() then
		warnChainsofShadow:Show(args.destName)
		timerChainsofShadow:Start(args.destName)
	elseif args.spellId == 71785 then
		warnConflag:Show(args.destName)
		timerConflag:Start(args.destName)
	elseif args.spellId == 71298 then
		warnBanish:Show(args.destName)
		timerBanish:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 70451 then
		timerBloodMirror:Cancel(args.destName)
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 70432 then
		timerBloodSap:Cancel(args.destName)
	elseif args.spellId == 70645 then
		timerChainsofShadow:Cancel(args.destName)
	elseif args.spellId == 71785 then
		timerConflag:Cancel(args.destName)
	elseif args.spellId == 71298 then
		timerBanish:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 71022 then
		warnDisruptingShout:Show()
		specWarnDisruptingShout:Show()
		timerDisruptingShout:Start()
	elseif args.spellId == 71088 then
		specWarnBlightBomb:Show()
		timerBlightBomb:Start()
	elseif args.spellId == 71123 then
		specWarnDecimate:Show()
		warnDecimateSoon:Cancel()	-- in case the first 1 is inaccurate, you wont have an invalid soon warning
		warnDecimateSoon:Schedule(28)
		timerDecimate:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 71159 and self:AntiSpam(5) then
		warnZombies:Show()
		timerZombies:Start()
	end
end

function mod:SPELL_DAMAGE(args)
	if args.spellId == 70305 and args.destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnBlade:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 37025 then
		warnDecimateSoon:Cancel()
		timerDecimate:Cancel()
	elseif cid == 37217 then
		timerZombies:Cancel()
		warnDecimateSoon:Cancel()
		timerDecimate:Cancel()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.WarderTrap1 or msg == L.WarderTrap2 or msg == L.WarderTrap3) and self:LatencyCheck() then
		self:SendSync("WarderTrap")
	elseif (msg == L.FleshreaperTrap1 or msg == L.FleshreaperTrap2 or msg == L.FleshreaperTrap3) and self:LatencyCheck() then
		self:SendSync("FleshTrap")
	elseif msg == L.SindragosaEvent and self:LatencyCheck() then
		self:SendSync("GauntletStart")
	end
end

function mod:OnSync(msg, arg)
	if msg == "WarderTrap" then
		specWarnTrapL:Show()
	elseif msg == "FleshTrap" then
		specWarnTrapP:Show()
	elseif msg == "GauntletStart" then
		specWarnGosaEvent:Show()
	end
end
