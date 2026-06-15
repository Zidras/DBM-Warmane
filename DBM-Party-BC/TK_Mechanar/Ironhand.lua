local mod	= DBM:NewMod("Ironhand", "DBM-Party-BC", 13)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(19710)

mod:SetModelID(21191)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 39193 35322",
	"SPELL_AURA_REMOVED 39193 35322",
	"SPELL_CAST_SUCCESS 39194 35327",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnShadowpower		= mod:NewTargetNoFilterAnnounce(35322, 3)
local WarnJackHammer		= mod:NewSpellAnnounce(39194, 4)

local specWarnJackHammer	= mod:NewSpecialWarningRun(39194, "Melee", nil, nil, 4, 2)
local specWarnShadowpower	= mod:NewSpecialWarningDispel(35322, "MagicDispeller", nil, nil, 1, 2)

local timerShadowpower		= mod:NewBuffActiveTimer(15, 35322, nil, "Tank|MagicDispeller", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerJackhammer		= mod:NewBuffActiveTimer(8, 39194, nil, nil, nil, 2)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(39193, 35322) and not args:IsDestTypePlayer() then	--Shadow Power
		timerShadowpower:Start(args.destName)
		if self.Options.SpecWarn35322dispel then
			specWarnShadowpower:Show(args.destName)
			specWarnShadowpower:Play("dispelboss")
		else
			warnShadowpower:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(39193, 35322) and not args:IsDestTypePlayer() then	--Shadow Power
		timerShadowpower:Stop(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(39194, 35327) then	--Jackhammer
		timerJackhammer:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.JackHammer then
		if self.Options.SpecWarn39194run then
			specWarnJackHammer:Show()
			specWarnJackHammer:Play("justrun")
		else
			WarnJackHammer:Show()
		end
	end
end
