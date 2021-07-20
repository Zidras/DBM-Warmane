local mod	= DBM:NewMod("GeneralVezax", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4336 $"):sub(12, -3))
mod:SetCreatureID(33271)

mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_INTERRUPT",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnShadowCrash			= mod:NewTargetAnnounce(62660, 4)
local warnLeechLife				= mod:NewTargetAnnounce(63276, 3)
local warnSaroniteVapor			= mod:NewCountAnnounce(63337, 2)

local specWarnShadowCrash		= mod:NewSpecialWarning("SpecialWarningShadowCrash")
local specWarnShadowCrashNear	= mod:NewSpecialWarning("SpecialWarningShadowCrashNear")
local specWarnSurgeDarkness		= mod:NewSpecialWarningSpell(62662, mod:IsTank() or mod:IsHealer())
local specWarnLifeLeechYou		= mod:NewSpecialWarningYou(63276)
local specWarnLifeLeechNear 	= mod:NewSpecialWarning("SpecialWarningLLNear", false)

local timerSearingFlamesCast	= mod:NewCastTimer(2, 62661)
local timerEnrage				= mod:NewBerserkTimer(600)
local timerSurgeofDarkness		= mod:NewBuffActiveTimer(10, 62662)
local timerNextSurgeofDarkness	= mod:NewCDTimer(61.7, 62662, nil, nil, nil, 5, nil, DBM_CORE_L.TANK_ICON)
local timerSaroniteVapors		= mod:NewNextCountTimer(30, 63322)
local timerShadowCrashCD		= mod:NewCDTimer(9, 62660, nil, nil, nil, 3)
local timerLifeLeech			= mod:NewTargetTimer(10, 63276)
local timerLifeLeechCD			= mod:NewCDTimer(20.4, 63276, nil, nil, nil, 3)
local timerHardmode				= mod:NewTimer(189, "hardmodeSpawn")

mod:AddBoolOption("YellOnLifeLeech", true, "yell")
mod:AddBoolOption("YellOnShadowCrash", true, "yell")
mod:AddBoolOption("SetIconOnShadowCrash", true)
mod:AddBoolOption("SetIconOnLifeLeach", true)
mod:AddBoolOption("CrashArrow")

local vaporsCount = 0

function mod:ShadowCrashTarget(targetname, uId)
	if not targetname then return end
	if self.Options.SetIconOnShadowCrash then
		self:SetIcon(targetname, 8, 10)
	end
	if targetname == UnitName("player") then
		specWarnShadowCrash:Show()
		if self.Options.YellOnShadowCrash then
			SendChatMessage(L.YellCrash, "SAY")
		end
	elseif targetname then
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			if inRange then
				specWarnShadowCrashNear:Show()
				if self.Options.CrashArrow then
					DBM.Arrow:ShowRunAway(x, y, 15, 5)
				end
			end
		end
		warnShadowCrash:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	vaporsCount = 0
	timerShadowCrashCD:Start(10-delay)
	timerLifeLeechCD:Start(16.9-delay)
	timerSaroniteVapors:Start(30-delay, 1)
	timerEnrage:Start(-delay)
	timerHardmode:Start(-delay)
	timerNextSurgeofDarkness:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62661) then	-- Searing Flames
		timerSearingFlamesCast:Start()
	elseif args:IsSpellID(62662) then
		specWarnSurgeDarkness:Show()
		timerNextSurgeofDarkness:Start()
	end
end

function mod:SPELL_INTERRUPT(args)
	if args:IsSpellID(62661) then
		timerSearingFlamesCast:Stop()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62662 then	-- Surge of Darkness
		timerSurgeofDarkness:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62662 then
		timerSurgeofDarkness:Stop()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 62660 then		-- Shadow Crash
		self:ScheduleMethod(0.03, "BossTargetScanner", 33271, "ShadowCrashTarget", 0.01, 10)
		timerShadowCrashCD:Start()
	elseif args.spellId == 63276 then	-- Mark of the Faceless
		if self.Options.SetIconOnLifeLeach then
			self:SetIcon(args.destName, 7, 10)
		end
		timerLifeLeech:Start(args.destName)
		timerLifeLeechCD:Start()
		if args:IsPlayer() then
			specWarnLifeLeechYou:Show()
			if self.Options.YellOnLifeLeech then
				SendChatMessage(L.YellLeech, "SAY")
			end
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local inRange = CheckInteractDistance(uId, 2)
				if inRange then
					specWarnLifeLeechNear:Show(args.destName)
				else
					warnLeechLife:Show(args.destName)
				end
			end
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(emote)
	if emote == L.EmoteSaroniteVapors or emote:find(L.EmoteSaroniteVapors) then
		vaporsCount = vaporsCount + 1
		warnSaroniteVapor:Show(vaporsCount)
		if vaporsCount < 6 then
			timerSaroniteVapors:Start(nil, vaporsCount+1)
		end
	end
end
