local mod	= DBM:NewMod("AlteracValley", "DBM-PvP")
local L		= mod:GetLocalizedStrings()

local GetCurrentMapAreaID = GetCurrentMapAreaID

mod:SetRevision("20220518110528")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

mod:AddBoolOption("AutoTurnIn")
mod:RemoveOption("HealthFrame")

do
	local bgzone = false

	local function Init(self)
		local zoneID = GetCurrentMapAreaID()
		if not bgzone and zoneID == 402 then
			bgzone = true
			self:RegisterShortTermEvents(
				"CHAT_MSG_MONSTER_YELL",
				"CHAT_MSG_RAID_BOSS_EMOTE",
				"GOSSIP_SHOW",
				"QUEST_PROGRESS",
				"QUEST_COMPLETE"
			)
			local generalMod = DBM:GetModByName("PvPGeneral")
			generalMod:SubscribeAssault(zoneID, 0)
			generalMod:TrackHealth(11946, "HordeBoss")
			generalMod:TrackHealth(11948, "AllianceBoss")
			generalMod:TrackHealth(11947, "Galvangar")
			generalMod:TrackHealth(11949, "Balinda")
			generalMod:TrackHealth(13419, "Ivus")
			generalMod:TrackHealth(13256, "Lokholar")

		elseif bgzone and zoneID ~= 402 then
			bgzone = false
			self:UnregisterShortTermEvents()
			self:Stop()
			DBM:GetModByName("PvPGeneral"):StopTrackHealth()
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		Init(self)
	end
	mod.PLAYER_ENTERING_WORLD	= mod.ZONE_CHANGED_NEW_AREA
	mod.OnInitialize			= mod.ZONE_CHANGED_NEW_AREA
end

do
	local ipairs, type = ipairs, type
	local UnitGUID, GetItemCount, GetNumGossipActiveQuests, SelectGossipActiveQuest, SelectGossipAvailableQuest, IsQuestCompletable, CompleteQuest, GetQuestReward = UnitGUID, GetItemCount, GetNumGossipActiveQuests,SelectGossipActiveQuest, SelectGossipAvailableQuest, IsQuestCompletable, CompleteQuest, GetQuestReward

	local quests = {
		[13442] = { -- Archdruid Renferal [A]
			{17423, 5}, -- Storm Crystal
			{17423, 1}, -- Storm Crystal
		},
		[13257] = {17422, 20}, -- Murgot Deepforge / Armor Scraps[A]
		[13438] = {17502, 1}, -- Wing Commander Slidore / Frostwolf Soldier's Medal [A]
		[13439] = {17503, 1}, -- Wing Commander Vipore / Frostwolf Lieutenant's Medal [A]
		[13437] = {17504, 1}, -- Wing Commander Ichman / Frostwolf Commander's Medal [A]
		[13577] = {17643, 1}, -- Stormpike Ram Rider Commander / Frostwolf Hide [A]
		[13236] = { -- Primalist Thurloga [H]
			{17306, 5}, -- Stormpike Soldier's Blood
			{17306, 1}, -- Stormpike Soldier's Blood
		},
		[13176] = {17422, 20}, -- Smith Regzar / Armor Scraps [H]
		[13179] = {17326, 1}, -- Wing Commander Guse / Stormpike Soldier's Flesh [H]
		[13180] = {17327, 1}, -- Wing Commander Jeztor / Stormpike Lieutenant's Flesh [H]
		[13181] = {17328, 1}, -- Wing Commander Mulverick / Stormpike Commander's Flesh [H]
		[13441] = {17642, 1}, -- Frostwolf Wolf Rider Commander / Alterac Ram Hide [H]
	}

	function mod:GOSSIP_SHOW()
		if not self.Options.AutoTurnIn then
			return
		end
		local quest = quests[self:GetCIDFromGUID(UnitGUID("target") or "") or 0]
		if quest and type(quest[1]) == "table" then
			for _, v in ipairs(quest) do
				local num = GetItemCount(v[1])
				if num > 0 then
					if GetNumGossipActiveQuests() == 1 then
						SelectGossipActiveQuest(1)
					else
						SelectGossipAvailableQuest((v[2] == 5 and num >= 5) and 2 or 1)
					end
					break
				end
			end
		elseif quest then
			if GetItemCount(quest[1]) > quest[2] then
				SelectGossipAvailableQuest(1)
			end
		end
	end

	function mod:QUEST_PROGRESS()
		self:GOSSIP_SHOW()
		if IsQuestCompletable() then
			CompleteQuest()
		end
	end

	function mod:QUEST_COMPLETE()
		GetQuestReward(0)
	end
end

do
	local bossTimer	= mod:NewTimer(600, "TimerBoss")

	function mod:CHAT_MSG_MONSTER_YELL(msg, npc)
		local isAlly = msg == L.BossAlly or msg:match(L.BossAlly)
		if not isAlly and msg ~= L.BossHorde and not msg:match(L.BossHorde) then
			return
		end
		bossTimer:Start(nil, npc)
		if isAlly then
			bossTimer:SetColor({r=0, g=0, b=1})
			bossTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_02")
		else
			bossTimer:SetColor({r=1, g=0, b=0})
			bossTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_01")
		end
	end
end
