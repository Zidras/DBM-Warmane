local mod	= DBM:NewMod("Tidewalker", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(21213)

mod:SetModelID(20739)
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 37850 38023 38024 38025 38049",
	"SPELL_CAST_START 37730",
	"SPELL_CAST_SUCCESS 37764",
	"SPELL_SUMMON 37854"
)

local warnTidal			= mod:NewSpellAnnounce(37730, 3)
local warnGrave			= mod:NewTargetNoFilterAnnounce(38049, 4)--TODO, make run out special warning instead?
local warnBubble		= mod:NewSpellAnnounce(37854, 4)

local specWarnMurlocs	= mod:NewSpecialWarning("SpecWarnMurlocs")

local timerGraveCD		= mod:NewCDTimer(28.5, 38049, nil, nil, nil, 3)
local timerMurlocs		= mod:NewTimer(51, "TimerMurlocs", 39088, nil, nil, 1)
local timerBubble		= mod:NewBuffActiveTimer(35, 37854, nil, nil, nil, 1)

mod:AddBoolOption("GraveIcon", true)

local warnGraveTargets = {}
mod.vb.graveIcon = 8

local function showGraveTargets()
	warnGrave:Show(table.concat(warnGraveTargets, "<, >"))
	table.wipe(warnGraveTargets)
	timerGraveCD:Show()
end

function mod:OnCombatStart(delay)
	self.vb.graveIcon = 8
	table.wipe(warnGraveTargets)
	timerGraveCD:Start(20-delay)
	timerMurlocs:Start(41-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(37850, 38023, 38024, 38025, 38049) then
		warnGraveTargets[#warnGraveTargets + 1] = args.destName
		self:Unschedule(showGraveTargets)
		if self.Options.GraveIcon then
			self:SetIcon(args.destName, self.vb.graveIcon)
		end
		self.vb.graveIcon = self.vb.graveIcon - 1
		if #warnGraveTargets >= 4 then
			showGraveTargets()
		else
			self:Schedule(0.3, showGraveTargets)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 37730 then
		warnTidal:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 37764 then
		specWarnMurlocs:Show()
		timerMurlocs:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 37854 and self:AntiSpam(30) then
		warnBubble:Show()
		timerBubble:Start()
	end
end
