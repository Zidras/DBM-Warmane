local mod = DBM:NewMod(532, "DBM-Party-BC", 16, 249)
local L = mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(24560)--24560 is main boss.

mod:SetModelID(22596)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 17843 44256 46181",
	"SPELL_CAST_SUCCESS 27621 44178 46195",
	"SPELL_AURA_APPLIED 13323 44141 44175 44291 46193 44174 46192"
)

--TODO, maybe more anti spam or tweaks and some timers?
--TODO, GTFO for blizzard?
local warnWindFury		= mod:NewSpellAnnounce(27621, 2, nil, false)
local warnBlizzard		= mod:NewSpellAnnounce(46195, 2)
local warnRenew			= mod:NewTargetAnnounce(46192, 3, nil, false, 2)
local warnSoC			= mod:NewTargetAnnounce(44141, 2, nil, false, 2)
local warnPolymorph		= mod:NewTargetAnnounce(13323, 4)

local specWarnFlashHeal	= mod:NewSpecialWarningInterrupt(17843, "HasInterrupt", nil, 3, 1, 2)
local specWarnLHW		= mod:NewSpecialWarningInterrupt(46181, "HasInterrupt", nil, 3, 1, 2)
local specWarnPWS		= mod:NewSpecialWarningDispel(44175, "MagicDispeller", nil, 2, 1, 2)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 17843 and self:CheckInterruptFilter(args.sourceGUID, false, true) then		-- Delrissa's Flash Heal
		specWarnFlashHeal:Show(args.sourceName)
		specWarnFlashHeal:Play("kickcast")
	elseif args:IsSpellID(44256, 46181) and self:CheckInterruptFilter(args.sourceGUID, false, true) then					-- Apoko's LHW
		specWarnLHW:Show(args.sourceName)
		specWarnLHW:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 27621 and self:IsInCombat() then	-- Apoko's Windfury Totem
		warnWindFury:Show()
	elseif args:IsSpellID(44178, 46195) then	-- Yazzai's Blizzard
		warnBlizzard:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 13323 then	-- Yazzai's Polymorph
		warnPolymorph:Show(args.destName)
	elseif spellId == 44141 then	-- Ellrys SoC
		warnSoC:Show(args.destName)
	elseif args:IsSpellID(44175, 44291, 46193) and not args:IsDestTypePlayer() then	-- Delrissa's PWShield
		specWarnPWS:Show(args.destName)
		specWarnPWS:Play("dispelboss")
	elseif args:IsSpellID(44174, 46192) and not args:IsDestTypePlayer() then	-- Delrissa's Renew
		warnRenew:Show(args.destName)
	end
end
