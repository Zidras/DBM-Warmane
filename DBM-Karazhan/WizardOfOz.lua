local mod	= DBM:NewMod("Oz", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250806215207")
mod:SetCreatureID(18168)
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

local timerFearCD	= mod:NewCDTimer(19, 31013, nil, nil, nil, 2)
local timerRoar		= mod:NewTimer(12, "DBM_OZ_WARN_ROAR", 5209, nil, false, 1)
local timerStrawman	= mod:NewTimer(21, "DBM_OZ_WARN_STRAWMAN", "Interface\\Icons\\Inv_helmet_34", nil, false, 1)
local timerTinhead	= mod:NewTimer(29, "DBM_OZ_WARN_TINHEAD", "Interface\\Icons\\Inv_helmet_02", nil, false, 1)
--local timerTito		= mod:NewTimer(47.5, "DBM_OZ_WARN_TITO", 459, nil, false, 1)

mod:AddRangeFrameOption(10, 32337, true)
mod:AddBoolOption("AnnounceBosses", true, "announce")
mod:AddBoolOption("ShowBossTimers", true, "timer")

function mod:OnCombatStart(delay)
	if self.Options.ShowBossTimers then
		timerRoar:Start(-delay)
		timerStrawman:Start(-delay)
		timerTinhead:Start(-delay)
--		timerTito:Start(-delay)
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
	if args.spellId == 31013 then
		warnFear:Show()
		timerFearCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_OZ_YELL_ROAR then
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
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
	end
end
