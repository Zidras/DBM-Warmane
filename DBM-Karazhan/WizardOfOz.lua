local mod	= DBM:NewMod("Oz", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(18168, 17535)
--
mod:SetModelID(17550)
mod:RegisterCombat("yell", L.DBM_OZ_YELL_DOROTHEE)
mod:SetMinCombatTime(25)
mod:SetWipeTime(30)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL"
)

local WarnRoar		= mod:NewAnnounce("DBM_OZ_WARN_ROAR", 2, nil, nil, false)--Hidden Object, conrolled by AnnounceBosses bool option
local WarnStrawman	= mod:NewAnnounce("DBM_OZ_WARN_STRAWMAN", 2, nil, nil, false)--Hidden Object, conrolled by AnnounceBosses bool option
local WarnTinhead	= mod:NewAnnounce("DBM_OZ_WARN_TINHEAD", 2, nil, nil, false)--Hidden Object, conrolled by AnnounceBosses bool option
local WarnTido		= mod:NewAnnounce("DBM_OZ_WARN_TITO", 2, nil, nil, false)--Hidden Object, conrolled by AnnounceBosses bool option
local WarnCrone		= mod:NewAnnounce("DBM_OZ_WARN_CRONE", 2, nil, nil, false)--Hidden Object, conrolled by AnnounceBosses bool option
local warnFear		= mod:NewSpellAnnounce(31013, 4)
local warnBrainBash	= mod:NewTargetNoFilterAnnounce(31046, 2)
local warnChain		= mod:NewSpellAnnounce(32337, 3)

--local timerFearCD	= mod:NewCDTimer(19, 31013, nil, nil, nil, 2)
local timerRoar		= mod:NewTimer(12+4.67, "DBM_OZ_WARN_ROAR", "132117", nil, false, 1)
local timerStrawman	= mod:NewTimer(21+5.3, "DBM_OZ_WARN_STRAWMAN", "133136", nil, false, 1)
local timerTinhead	= mod:NewTimer(29+5.47, "DBM_OZ_WARN_TINHEAD", "133070", nil, false, 1)
local timerTito		= mod:NewTimer(47.5-6.5+11.7, "DBM_OZ_WARN_TITO", "132266", nil, false, 1)

local timerCombatStart	= mod:NewCombatTimer(11.7)
local timerFearCD		= mod:NewCDSourceTimer(20, 31013, nil, nil, nil, 2, nil)

mod:AddRangeFrameOption(10, 32337, true)
mod:AddBoolOption("AnnounceBosses", true, "announce")
mod:AddBoolOption("ShowBossTimers", true, "timer")

function mod:OnCombatStart(delay)
	timerCombatStart:Start()
	timerFearCD:Start(15+12,"#1")
	if self.Options.ShowBossTimers then
		timerRoar:Start(-delay)
		timerStrawman:Start(-delay)
		timerTinhead:Start(-delay)
		timerTito:Start(-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31046 then
		warnBrainBash:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 31014 then
		if self.Options.AnnounceBosses then
			WarnTido:Schedule(1)
		end
	elseif args.spellId == 32337 then
		warnChain:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local cid = self:GetCIDFromGUID(args.sourceGUID)
	if args.spellId == 31013 and cid == 17535 then
		warnFear:Show()
		timerFearCD:Start(30, args.sourceName)
	elseif args.spellId == 31013 and cid == 17546 then
		warnFear:Show()
		timerFearCD:Start(20, args.sourceName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_OZ_YELL_ROAR then
		timerFearCD:Start(15,"#2")
		if self.Options.AnnounceBosses then
			WarnRoar:Show()
		end
	elseif msg == L.DBM_OZ_YELL_STRAWMAN then
		if self.Options.AnnounceBosses then
			WarnStrawman:Show()
		end
	elseif msg == L.DBM_OZ_YELL_TINHEAD then
		if self.Options.AnnounceBosses then
			WarnTinhead:Show()
		end
	elseif msg == L.DBM_OZ_YELL_CRONE then
		if self.Options.AnnounceBosses then
			WarnCrone:Show()
			timerFearCD:Stop("Dorothee")
			timerFearCD:Stop("Roar")
			timerTito:Cancel()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10+3)
		end
	end
end
