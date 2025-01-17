local mod	= DBM:NewMod("Netherspite", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250116122738")
mod:SetCreatureID(15689)

mod:SetModelID(15363)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 38523",
	"SPELL_CAST_SUCCESS 37014 37063",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warningPortal			= mod:NewAnnounce("warningPortal", 1, "Interface\\Icons\\Spell_Arcane_PortalIronforge")
local warningBanish			= mod:NewAnnounce("warningBanish", 1, "Interface\\Icons\\Spell_Shadow_Cripple")
local warningBreathCast		= mod:NewCastAnnounce(38523, 2)
local warningVoid			= mod:NewSpellAnnounce(37063, 4)

local specWarnVoid			= mod:NewSpecialWarningGTFO(30533, nil, nil, nil, 1, 6)

local timerPortalPhase		= mod:NewTimer(61.5, "timerPortalPhase", "Interface\\Icons\\Spell_Arcane_PortalIronforge", nil, nil, 6)
local timerBanishPhase		= mod:NewTimer(30, "timerBanishPhase", "Interface\\Icons\\Spell_Shadow_Cripple", nil, nil, 6)
local timerBreathCast		= mod:NewCastTimer(2.5, 38523, nil, nil, nil, 3)

local berserkTimer			= mod:NewBerserkTimer(540)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerPortalPhase:Start(63.5-delay)
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE 30533",
			"SPELL_PERIODIC_MISSED 30533"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 38523 then
		warningBreathCast:Show()
		timerBreathCast:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(37014, 37063) then
		warningVoid:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, destGUID, _, _, spellId, spellName)
	if spellId == 30533 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnVoid:Show(spellName)
		specWarnVoid:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.DBM_NS_EMOTE_PHASE_2 then
		timerPortalPhase:Cancel()
		warningBanish:Show()
		timerBanishPhase:Start()
	elseif msg == L.DBM_NS_EMOTE_PHASE_1 then
		timerBanishPhase:Cancel()
		warningPortal:Show()
		timerPortalPhase:Start()
	end
end
