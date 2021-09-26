local mod	= DBM:NewMod("NightbaneRaid", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(17225)

mod:SetModelID(18062)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_EMOTE"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 36922",
	"SPELL_CAST_SUCCESS 37098 30128",
	"SPELL_AURA_APPLIED 30129 30130",
	"CHAT_MSG_MONSTER_YELL"
)

local warningFear			= mod:NewSpellAnnounce(36922, 4)
local warningAsh			= mod:NewTargetAnnounce(30130, 2, nil, false)
local WarnAir				= mod:NewAnnounce("DBM_NB_AIR_WARN", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warningBone			= mod:NewSpellAnnounce(37098, 3)

local specWarnCharred		= mod:NewSpecialWarningGTFO(30129, nil, nil, nil, 1, 6)
local specWarnSmoke			= mod:NewSpecialWarningTarget(30128, "Healer", nil, nil, 1, 2)

local timerNightbane		= mod:NewCombatTimer(36)
local timerFearCD			= mod:NewCDTimer(31.5, 36922, nil, nil, nil, 2)
local timerAirPhase			= mod:NewTimer(57, "timerAirPhase", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp", nil, nil, 6)
local timerBone				= mod:NewBuffActiveTimer(11, 37098, nil, nil, nil, 1)

mod:AddSetIconOption("SetIconOnCharred", 30128, true, false, {1})

mod.vb.lastBlastTarget = "none"

function mod:OnCombatStart()
	self.vb.lastBlastTarget = "none"
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.DBM_NB_EMOTE_PULL then
		timerNightbane:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 36922 then
		warningFear:Show()
		timerFearCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 37098 then
		warningBone:Show()
		timerBone:Start()
	elseif args.spellId == 30128 and self.vb.lastBlastTarget ~= args.destName then
		self.vb.lastBlastTarget = args.destName
		specWarnSmoke:Show(args.destName)
		specWarnSmoke:Play("targetchange")
		if self.Options.SetIconOnCharred then
			self:SetIcon(args.destName, 1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30129 and args:IsPlayer() and not self:IsTrivial() and self:AntiSpam() then
		specWarnCharred:Show(args.spellName)
		specWarnCharred:Play("watchfeet")
	elseif args.spellId == 30130 then
		warningAsh:Show(args.destName)
	end
end

do
	local function clearSetIcon(self)
		if self.Options.SetIconOnCharred and self.vb.lastBlastTarget ~= "none" then
			self:SetIcon(self.vb.lastBlastTarget , 0)
		end
	end

	function mod:CHAT_MSG_MONSTER_YELL(msg)
		self.vb.lastBlastTarget = "none"
		if msg == L.DBM_NB_YELL_AIR then
			WarnAir:Show()
			timerAirPhase:Stop()
			timerAirPhase:Start()
			self:Unschedule(clearSetIcon)
			self:Schedule(57, clearSetIcon, self)
		elseif msg == L.DBM_NB_YELL_GROUND or msg == L.DBM_NB_YELL_GROUND2 then--needed. because if you deal more 25% damage in air phase, air phase repeated and shorten. So need to update exact ground phase.
			timerAirPhase:Update(43, 57)
			self:Unschedule(clearSetIcon)
			self:Schedule(14, clearSetIcon, self)
		end
	end
end

