local mod	= DBM:NewMod("HeadlessHorseman", "DBM-WorldEvents", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241122155852")
mod:SetCreatureID(23682, 23775)

mod:SetReCombatTime(10)
mod:RegisterCombat("combat")
--mod:RegisterKill("say", L.SayCombatEnd)

mod:RegisterEvents(
	"CHAT_MSG_SAY"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 42380 42514",
	"UNIT_SPELLCAST_SUCCEEDED",
	"CHAT_MSG_MONSTER_SAY",
	"PARTY_KILL",
	"UNIT_DIED"
)

local warnConflag				= mod:NewTargetAnnounce(42380, 3)
local warnSquashSoul			= mod:NewTargetAnnounce(42514, 2, nil, false, 2)
local warnPhase					= mod:NewAnnounce("WarnPhase", 2, "136116")
local warnHorsemanSoldiers		= mod:NewAnnounce("warnHorsemanSoldiers")
local warnHorsemanHead			= mod:NewAnnounce("warnHorsemanHead", 3)

local specWarnHorsemanHead		= mod:NewSpecialWarning("specWarnHorsemanHead")

local timerCombatStart			= mod:NewCombatTimer(21.7)--roleplay for first pull
local timerConflag				= mod:NewTargetTimer(4, 42380)
local timerSquashSoul			= mod:NewTargetTimer(15, 42514)

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 42380 then					-- Conflagration
		warnConflag:Show(args.destName)
		timerConflag:Start(args.destName)
	elseif spellId == 42514 then				-- Squash Soul
		warnSquashSoul:Show(args.destName)
		timerSquashSoul:Start(args.destName)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, spellName)
--	"<48.6> Headless Horseman:Possible Target<Omegal>:target:Headless Horseman Climax - Command, Head Repositions::0:42410", -- [35]
	if spellName == GetSpellInfo(42410) then
		self:SendSync("HeadRepositions")
--	"<23.0> Headless Horseman:Possible Target<nil>:target:Headless Horseman Climax, Body Stage 1::0:42547", -- [1]
	elseif spellName == GetSpellInfo(42547) then
		self:SendSync("BodyStage1")
--	"<49.0> Headless Horseman:Possible Target<Omegal>:target:Headless Horseman Climax, Body Stage 2::0:42548", -- [7]
	elseif spellName == GetSpellInfo(42548) then
		self:SendSync("BodyStage2")
--	"<70.6> Headless Horseman:Possible Target<Omegal>:target:Headless Horseman Climax, Body Stage 3::0:42549", -- [13]
	elseif spellName == GetSpellInfo(42549) then
		self:SendSync("BodyStage3")
	end
end

--Use syncing since these unit events require "target" or "focus" to detect.
--At least someone in group should be targeting this stuff and sync it to those that aren't (like a healer)
function mod:OnSync(event)
	if event == "HeadRepositions" then
		warnHorsemanHead:Show()
	elseif event == "BodyStage1" then
		warnPhase:Show(1)
	elseif event == "BodyStage2" then
		warnPhase:Show(2)
	elseif event == "BodyStage3" then
		warnPhase:Show(3)
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.HorsemanHead then											-- No combatlog event for head spawning, Emote works iffy(head doesn't emote First time, only 2nd and forward)
		specWarnHorsemanHead:Show()
	elseif msg == L.HorsemanSoldiers and self:AntiSpam(5, 1) then	-- Warning for adds spawning. No CLEU or UNIT event for it.
		warnHorsemanSoldiers:Show()
	end
end

function mod:CHAT_MSG_SAY(msg)
	if msg == L.HorsemanSummon and self:AntiSpam(5) then		-- Summoned
		timerCombatStart:Start()
	end
end

function mod:UNIT_DIED(args) -- 2024/10/22: found one log where only PARTY_KILL was fired, no UNIT_DIED
	if not self:IsInCombat() then return end
	if self:GetCIDFromGUID(args.destGUID) == 23775 then
		DBM:EndCombat(self)
	end
end
mod.PARTY_KILL = mod.UNIT_DIED
