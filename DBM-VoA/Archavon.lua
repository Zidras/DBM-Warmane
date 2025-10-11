local mod	= DBM:NewMod("Archavon", "DBM-VoA")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250929220131")
mod:SetCreatureID(31125)
mod:SetEncounterID(772)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 58663 60880",
	"SPELL_CAST_SUCCESS 58963 60895",
	"SPELL_AURA_APPLIED 58678 58941",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--11/19 19:20:12.949  SPELL_AURA_APPLIED,0xF150007995000007,"Archavon the Stone Watcher",0xa48,0xF140544DF3000002,"Teufelssaurier",0x1114,58678,"Rock Shards",0x1,DEBUFF
--11/19 19:20:16.527  SPELL_AURA_REMOVED,0xF150007995000007,"Archavon the Stone Watcher",0xa48,0xF140544DF3000002,"Teufelssaurier",0x1114,58678,"Rock Shards",0x1,DEBUFF

local warnShards			= mod:NewTargetNoFilterAnnounce(58678, 2)
local warnGrab				= mod:NewAnnounce("WarningGrab", 4, 53041)
local warnLeap				= mod:NewSpellAnnounce(60894, 3)
local warnStomp				= mod:NewSpellAnnounce(60880, 3)
local warnStompSoon			= mod:NewPreWarnAnnounce(60880, 5, 2)

local timerNextStomp		= mod:NewNextTimer(45, 60880, nil, nil, nil, 2)
local timerShards			= mod:NewTargetTimer(4, 58678, nil, nil, nil, 3)
local timerArchavonEnrage	= mod:NewBerserkTimer(300, nil, "ArchavonEnrage")

function mod:OnCombatStart(delay)
	timerArchavonEnrage:Start()
	timerNextStomp:Start(49.4-delay) -- REVIEW! variance? (10N Lordaeron 2022/09/23) - pull:49.4
	warnStompSoon:Schedule(40-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(58663, 60880) then
		warnStomp:Show()
		timerNextStomp:Start()
		warnStompSoon:Schedule(40)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(58963, 60895) then
		warnLeap:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(58678, 58941) then
		warnShards:Show(args.destName)
		timerShards:Start(args.destName)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg and msg:match(L.TankSwitch) or msg:find(L.TankSwitch) then
		warnGrab:Show(DBM:GetUnitFullName(target))
	end
end
