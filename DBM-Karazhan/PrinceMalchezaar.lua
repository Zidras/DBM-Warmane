local mod	= DBM:NewMod("Prince", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7007 $"):sub(12, -3))
mod:SetCreatureID(15690)

mod:SetModelID(19274)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 30852",
	"SPELL_CAST_SUCCESS 30843",
	"SPELL_AURA_APPLIED 30854 30898 39095 30843 30859",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--TODO, improve phase change timer updates, I don't really feel like it right now
--TODO, also switch to pre changed timers, these are probably wrong for classic TBC, they were changed on retail
local warningNovaCast			= mod:NewCastAnnounce(30852, 3)
local warningInfernal			= mod:NewSpellAnnounce(37277, 2)
local warningHellfire			= mod:NewSpellAnnounce(30859, 3)
local warningEnfeeble			= mod:NewTargetNoFilterAnnounce(30843, 4)
local warnPhase2				= mod:NewPhaseAnnounce(2)
local warnPhase3				= mod:NewPhaseAnnounce(3)
local warningAmpMagic			= mod:NewTargetNoFilterAnnounce(39095, 3)
local warningSWP				= mod:NewTargetNoFilterAnnounce(30898, 2, nil, "RemoveMagic")

local specWarnEnfeeble			= mod:NewSpecialWarningYou(30843, nil, nil, nil, 3, 2)
local specWarnNova				= mod:NewSpecialWarningRun(30852, "Melee", nil, nil, 4, 2)

local timerNovaCD				= mod:NewCDTimer(18.1, 30852, nil, nil, nil, 2)--18.1-30
local timerNextInfernal			= mod:NewCDTimer(45, 37277, nil, nil, nil, 1)--Spawning
local timerHellfire				= mod:NewCDTimer(14.5, 30859, nil, nil, nil, 3)--Landing/activating Hellfire
local timerEnfeebleCD			= mod:NewNextTimer(30, 30843, nil, nil, nil, 3, nil, DBM_CORE_L.DEADLY_ICON)
local timerEnfeeble				= mod:NewBuffFadesTimer(9, 30843)

function mod:OnCombatStart(delay)
	self:SetStage(1)
	timerNextInfernal:Start(14.5-delay)--14-21?
	timerEnfeebleCD:Start(30-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 30852 then
		if self.Options.SpecWarn30852run and DBM:UnitDebuff("player", 30843) then
			specWarnNova:Show()--Trivial damage, but because of enfeeble, don't want to do a blind level check here
			specWarnNova:Play("justrun")
		else
			warningNovaCast:Show()
		end
		timerNovaCD:Start(self.vb.phase == 3 and 18.1 or 30)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 30843 then
		timerEnfeebleCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(30854, 30898) then
		warningSWP:Show(args.destName)
	elseif args.spellId == 39095 then
		warningAmpMagic:Show(args.destName)
	elseif args.spellId == 30843 then
		warningEnfeeble:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			timerEnfeeble:Start()
			specWarnEnfeeble:Show()
			specWarnEnfeeble:Play("targetyou")
		end
	elseif args.spellId == 30859 and not args:IsDestTypePlayer() then--Hellfire applied to Infernals
		warningHellfire:Show()
		-- (during TBC there was like a 5 second delay between landing and gaining hellfire, but at some point they changed it to gain instantly
		--If this changes on classic TBC, this will probably need adjustment
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_PRINCE_YELL_INF1 or msg == L.DBM_PRINCE_YELL_INF2 then
		warningInfernal:Show()
		timerHellfire:Start(14.5)--14-16
		timerNextInfernal:Start(self.vb.phase == 3 and 19.3 or 44.7)--44-48
	elseif msg == L.DBM_PRINCE_YELL_P3 then
		self:SendSync("Phase3")
	elseif msg == L.DBM_PRINCE_YELL_P2 then
		self:SetStage(2)
		warnPhase2:Show()
		--Doesn't seem to affect any timers.
	end
end

--"<275.31 12:32:09> [UNIT_SPELLCAST_SUCCEEDED] Prince Malchezaar(Deafstroket) -Summon Axes- [[target:Cast-3-4615-532-1222-30891-0000F6542B:30891]]", -- [3138]
--"<275.56 12:32:10> [CHAT_MSG_MONSTER_YELL] How can you hope to stand against such overwhelming power?#Prince Malchezaar#####0#0##0#1766#nil#0#false#false#false#false", -- [3146]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 30891 and self:AntiSpam(3, 1) then--Summon Axes
		self:SendSync("Phase3")
	end
end

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "Phase3" then
		self:SetStage(3)
		warnPhase3:Show()
		timerNovaCD:Stop()
		timerNextInfernal:Stop()
		timerEnfeebleCD:Stop()
		timerNovaCD:Start(19.2)
		--"<326.45 01:12:48> [DBM_Announce] Stage 3#136116#stage#3#Prince#false", -- [759]
		--"<366.46 01:13:28> [CHAT_MSG_MONSTER_YELL] You face not Malchezaar alone, but the legions I command!#Prince Malchezaar#####0#0##0#163#nil#0#false#false#false#false", -- [883]
		timerNextInfernal:Start(40)
	end
end
