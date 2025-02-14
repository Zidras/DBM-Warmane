local mod	= DBM:NewMod("Tidewalker", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250214104945")
mod:SetCreatureID(21213)

--mod:SetModelID(20739)
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 37730",
	"SPELL_CAST_SUCCESS 37764",
	"SPELL_AURA_APPLIED 37850 38023 38024 38025 38049",
	"SPELL_SUMMON 37854",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnTidal			= mod:NewSpellAnnounce(37730, 3)
local warnGrave			= mod:NewTargetNoFilterAnnounce(38049, 4)--TODO, make run out special warning instead?
local warnBubble		= mod:NewSpellAnnounce(37854, 4)

local specWarnMurlocs	= mod:NewSpecialWarning("SpecWarnMurlocs", nil, nil, nil, nil, nil, nil, 24984, 37764)

local timerGraveCD		= mod:NewCDTimer(30, 38049, nil, nil, nil, 3) -- REVIEW! variance? (25 man FM log 2022/07/27 || 25 man FM log 2022/08/11) - 30.1, 30.0, 30.0, 30.0, 30.0 || 32.0, 30.1, 30.1
local timerMurlocs		= mod:NewTimer(45, "TimerMurlocs", 39088, nil, nil, 1, nil, nil, nil, nil, nil, nil, nil, 37764)
local timerBubble		= mod:NewBuffActiveTimer(35, 37854, nil, nil, nil, 1)

mod:AddSetIconOption("GraveIcon", 38049, true, false, {8, 7, 6, 5})

local warnGraveTargets = {}
mod.vb.graveIcon = 8

local function showGraveTargets(self)
	warnGrave:Show(table.concat(warnGraveTargets, "<, >"))
	table.wipe(warnGraveTargets)
	self.vb.graveIcon = 8
end

function mod:OnCombatStart(delay)
	self.vb.graveIcon = 8
	table.wipe(warnGraveTargets)
	timerGraveCD:Start(20-delay)
	timerMurlocs:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 37730 then
		warnTidal:Show()
	end
end

--[[function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 37764 then
		specWarnMurlocs:Show()
		timerMurlocs:Start()
	end
end]]

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(37850, 38023, 38024, 38025, 38049) then -- Watery Grave. Warmane bugged this (as of 2022/08/11) and it's not triggering the ability at random intervals. The emote still fires every 30 seconds, so use that for timer
		warnGraveTargets[#warnGraveTargets + 1] = args.destName
		self:Unschedule(showGraveTargets)
		if self.Options.GraveIcon then
			self:SetIcon(args.destName, self.vb.graveIcon)
		end
		self.vb.graveIcon = self.vb.graveIcon - 1
		if #warnGraveTargets >= 4 then
			showGraveTargets(self)
		else
			self:Schedule(0.3, showGraveTargets, self)
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 37854 and self:AntiSpam(30) then
		warnBubble:Show()
		timerBubble:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Grave or msg:find(L.Grave) then
		timerGraveCD:Show()
	elseif msg == L.Murlocs or msg:find(L.Murlocs) then
		specWarnMurlocs:Show()
		timerMurlocs:Start()
	end
end
