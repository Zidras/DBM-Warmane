local mod	= DBM:NewMod("IngvarThePlunderer", "DBM-Party-WotLK", 10)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220823234921")
mod:SetCreatureID(23980, 23954)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 42723 42669 59706 59709 42708 42729 59708 59734",
	"SPELL_AURA_APPLIED 42730 59735",
	"SPELL_AURA_REMOVED 42730 59735",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warningWoeStrike	= mod:NewTargetNoFilterAnnounce(42730, 2, nil, "RemoveCurse", 2)

local specWarnSpelllock	= mod:NewSpecialWarningCast(42729, "SpellCaster", nil, 2, 1, 2)
local specWarnSmash		= mod:NewSpecialWarningDodge(42723, "Tank", nil, nil, 1, 2)

local timerSmash		= mod:NewCastTimer(3, 42723)
local timerSmashCD		= mod:NewCDTimer(13, 42723, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerWoeStrike	= mod:NewTargetTimer(10, 42723, nil, "RemoveCurse", nil, 5, nil, DBM_COMMON_L.CURSE_ICON)

mod:AddSetIconOption("WoeStrikeIcon", 42730, true, false, {8})

function mod:OnCombatStart()
	self:SetStage(1)
	timerSmashCD:Start(15)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(42723, 42669, 59706) then
		specWarnSmash:Show()
		specWarnSmash:Play("shockwave")
		timerSmash:Start()
		timerSmashCD:Start()
	elseif args:IsSpellID(42708, 42729, 59708, 59734) then
		specWarnSpelllock:Show()
		specWarnSpelllock:Play("stopcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(42730, 59735) then
		warningWoeStrike:Show(args.destName)
		timerWoeStrike:Start(args.destName)
		if self.Options.WoeStrikeIcon then
			self:SetIcon(args.destName, 8, 10)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(42730, 59735) then
		timerWoeStrike:Cancel()
		if self.Options.WoeStrikeIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 23954 then--Only trigger kill for unit_died if he dies in phase 2 with at least one player alive, otherwise it's an auto wipe.
		if DBM:NumRealAlivePlayers() > 0 and self.vb.phase == 2 then
			DBM:EndCombat(self)
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellIngvarPhase2 or msg:find(L.YellIngvarPhase2) then
		self:SetStage(2)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
	if spellName == GetSpellInfo(42863) then -- Scourge Resurrection
		self:SetStage(2)
	end
end
