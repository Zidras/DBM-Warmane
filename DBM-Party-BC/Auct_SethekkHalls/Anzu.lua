local mod = DBM:NewMod(542, "DBM-Party-BC", 9, 252)
local L = mod:GetLocalizedStrings()

mod.statTypes = "heroic,mythic"

mod:SetRevision("20220518110528")
mod:SetCreatureID(23035)

mod:SetModelID(21492)
mod:SetModelScale(0.5)
mod:SetModelOffset(0, 1, 3)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 40184",
	"SPELL_AURA_APPLIED 40321 40184 40303",
	"SPELL_AURA_REMOVED 40303",
	"UNIT_HEALTH" ,
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnBirds			 = mod:NewAnnounce("warnBrood", 2, 32038)
local warnStoned			= mod:NewAnnounce("warnStoned", 1, 32810, false)
local warnCyclone		   = mod:NewTargetAnnounce(40321, 2)
local warnSpellBomb		 = mod:NewTargetAnnounce(40303, 2)

local specWarnScreech		= mod:NewSpecialWarningSpell(40184, nil, nil, nil, 2, 2)

local timerScreech		  = mod:NewCastTimer(5, 40184, nil, nil, nil, 2)
local timerScreechDebuff	= mod:NewBuffActiveTimer(6, 40184, nil, nil, nil, 3)
local timerCyclone		  = mod:NewTargetTimer(6, 40321, nil, nil, nil, 3)
local timerSpellBomb		= mod:NewTargetTimer(8, 40303, nil, nil, nil, 3)
local timerScreechCD		= mod:NewCDTimer(30, 40184, nil, nil, nil, 2)--Best guess on screech CD. Might need tweaking.

mod.vb.warnedbirds1 = false
mod.vb.warnedbirds2 = false

function mod:OnCombatStart()
	timerScreechCD:Start()
	self.vb.warnedbirds1 = false
	self.vb.warnedbirds2 = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 40184 then
		specWarnScreech:Show()
		specWarnScreech:Play("aesoon")
		timerScreech:Start()
		timerScreechCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 40321 then
		warnCyclone:Show(args.destName)
		timerCyclone:Start(args.destName)
	elseif args.spellId == 40184 then
		timerScreechDebuff:Show()
	elseif args.spellId == 40303 then
		warnSpellBomb:Show(args.destName)
		timerSpellBomb:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 40303 then
		timerSpellBomb:Stop(args.destName)
	end
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warnedbirds1 and self:GetUnitCreatureId(uId) == 23035 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.70 then
		self.vb.warnedbirds1 = true
		warnBirds:Show()
	elseif not self.vb.warnedbirds2 and self:GetUnitCreatureId(uId) == 23035 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.37 then
		self.vb.warnedbirds2 = true
		warnBirds:Show()
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, npc)
	if msg == L.BirdStone or msg:find(L.BirdStone) then		-- Spirits returning to stone.
		warnStoned:Show(npc)
	end
end
