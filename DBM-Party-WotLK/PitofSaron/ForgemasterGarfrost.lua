local mod	= DBM:NewMod("ForgemasterGarfrost", "DBM-Party-WotLK", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(36494)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 68788",
	"SPELL_AURA_APPLIED 70381 72930 68785 70335",
	"SPELL_AURA_APPLIED_DOSE 68786 70336",
	"CHAT_MSG_RAID_BOSS_WHISPER"
)

local warnForgeWeapon			= mod:NewSpellAnnounce(68785, 2)
local warnDeepFreeze			= mod:NewTargetAnnounce(70381, 2)
local warnSaroniteRock			= mod:NewTargetAnnounce(68789, 3)

local specWarnSaroniteRock		= mod:NewSpecialWarningYou(68789, nil, nil, nil, 1, 2)
local yellRock					= mod:NewYellMe(68789)
local specWarnSaroniteRockNear	= mod:NewSpecialWarningClose(68789, nil, nil, nil, 1, 2)
local specWarnPermafrost		= mod:NewSpecialWarningStack(68786, nil, 9, nil, nil, 1, 2)

local timerSaroniteRockCD		= mod:NewCDTimer(15.5, 68789, nil, nil, nil, 3)--15.5-20
local timerDeepFreezeCD			= mod:NewCDTimer(19, 70381, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerDeepFreeze			= mod:NewTargetTimer(14, 70381, nil, false, 3, 5)

mod:AddSetIconOption("SetIconOnSaroniteRockTarget", 68789, true, false, {8})
mod:AddBoolOption("AchievementCheck", false, "announce")

mod.vb.warnedfailed = false

function mod:OnCombatStart()
	self.vb.warnedfailed = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 68788 then								-- Throw Saronite
		timerSaroniteRockCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(70381, 72930) then						-- Deep Freeze
		warnDeepFreeze:Show(args.destName)
		timerDeepFreeze:Start(args.destName)
		timerDeepFreezeCD:Start()
	elseif args:IsSpellID(68785, 70335) then					-- Forge Frostborn Mace
		warnForgeWeapon:Show()
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(68786, 70336) then
		local amount = args.amount or 1
		if amount >= 9 and args:IsPlayer() and self:AntiSpam(5) then --11 stacks is what's needed for achievement, 9 to give you time to clear/dispel
			specWarnPermafrost:Show(amount)
			specWarnPermafrost:Play("stackhigh")
		end
		if self.Options.AchievementCheck and not self.vb.warnedfailed then
			if amount == 9 or amount == 10 then
				SendChatMessage(L.AchievementWarning:format(args.destName, amount), "PARTY")
			elseif amount > 11 then
				SendChatMessage(L.AchievementFailed:format(args.destName, amount), "PARTY")
				self.vb.warnedfailed = true
			end
		end
	end
end

-- commenting this out (for now?) since warnSaroniteRock fires only when the Rock spawns on the fight, and does not carry dest arg.
-- therefore we are relying on the sync boss_whisper to provide this warning with proper args.
--[[function mod:SPELL_CREATE(args)
	if args:IsSpellID(68789, 70851) then						-- Saronite Rock
		warnSaroniteRock:Show()
	end
end]]

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg, _, _, _, target)
	if msg == L.SaroniteRockThrow or msg:match(L.SaroniteRockThrow) then
		if target then
			self:SendSync("SaroniteRock", target)
		end
	end
end

function mod:OnSync(msg, targetName)
	if msg == "SaroniteRock" then
		if not targetName then return end
		if targetName == UnitName("player") then
				specWarnSaroniteRock:Show()
				specWarnSaroniteRock:Play("watchstep")
				yellRock:Yell()
		else
			local uId = DBM:GetRaidUnitId(targetName)
			if uId and not UnitIsUnit(uId, "player") and self:CheckNearby(10, targetName) then
				specWarnSaroniteRockNear:Show(targetName)
				specWarnSaroniteRockNear:Play("watchstep")
			else
				warnSaroniteRock:Show(targetName)
			end
		end
		if self.Options.SetIconOnSaroniteRockTarget then
			self:SetIcon(targetName, 8, 5)
		end
	end
end
