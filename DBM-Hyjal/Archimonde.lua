local mod	= DBM:NewMod("Archimonde", "DBM-Hyjal")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:SetCreatureID(17968)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 31972",
	"SPELL_AURA_REMOVED 31972",
	"SPELL_CAST_START 31970 32014",
	"CHAT_MSG_MONSTER_YELL"
)

local warnGrip			= mod:NewTargetNoFilterAnnounce(31972, 3, nil, "RemoveMagic")--Magic on retail, but I think a curse in TBC
local warnBurst			= mod:NewTargetNoFilterAnnounce(32014, 3)
local warnFear			= mod:NewSpellAnnounce(31970, 3)
local warnDoomfire		= mod:NewSpellAnnounce(31943, 3)

local specWarnBurst		= mod:NewSpecialWarningYou(32014, nil, nil, nil, 3, 2)
local yellBurst			= mod:NewYell(32014)

local timerNextFear		= mod:NewNextTimer(42, 31970, nil, nil, nil, 2)
local timerNextDoomfire		= mod:NewNextTimer(8, 31943, nil, nil, nil, 2)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddBoolOption("ShowRespawn", true)

mod:AddSetIconOption("BurstIcon", 32014, true, false, {8})

mod:AddSetIconOption("GripIcon", 31972, false, false, {7})

function mod:BurstTarget(targetname)

	if not targetname then 
		return 
	end
	
	if targetname == UnitName("player") then
		specWarnBurst:Show()
		specWarnBurst:Play("targetyou")
		yellBurst:Yell()
	else
		warnBurst:Show(targetname)
	end
	if self.Options.BurstIcon then
		self:SetIcon(targetname, 8, 5)
	end
end
	
function mod:OnCombatStart(delay)

	berserkTimer:Start(-delay)
	
	timerNextFear:Start(40-delay)
	timerNextDoomfire:Start(-delay)

	timerNextDoomfire:UpdateName("Doomfire CD")
end

function mod:OnCombatEnd(wipe, isSecondRun)

	if wipe and not isSecondRun and self.Options.ShowRespawn then
		DBT:CreateBar(293, DBM_CORE_L.TIMER_RESPAWN:format(L.name), "Interface\\Icons\\Spell_Holy_BorrowedTime")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31972 then
		warnGrip:Show(args.destName)

		if self.Options.GripIcon then 
			self:SetIcon(args.destName, 7)	
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)

	if args.spellId == 31972 then 
		if self.Options.GripIcon then	
			self:SetIcon(args.destName,0) 
		end
	end	
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 31970 then
		warnFear:Show()
		timerNextFear:Start()
	elseif args.spellId == 32014 then
		self:BossTargetScanner(17968, "BurstTarget", 0.05, 10)
		
		timerNextFear:AddTime(5)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)

	if msg == L.ArchimondeDoomfire1
		or msg == L.ArchimondeDoomfire2
	then
		warnDoomfire:Show()
		timerNextDoomfire:Start()
	end
end
