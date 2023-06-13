local mod	= DBM:NewMod("Quest", "DBM-Outland")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220518110528")
mod:AddBoolOption("Timers", true)
mod:SetModelID(18921)

--------------
--  Locals  --
--------------
local frame
local questTimers = {
	[10277] = 427,-- The Caverns of Time -- 425 425 419.9 427.7 426.5
	[10211] = 533,-- City of Light (shattrath) -- 528 528 532 533
}
local bars = {}

--------------------
--  Create Frame  --
--------------------
frame = CreateFrame("Frame")
frame:RegisterEvent("QUEST_ACCEPTED")

frame:SetScript("OnEvent", function(self, e, id)
	if not mod.Options.Timers then
		frame:UnregisterAllEvents()
		frame = nil
		return
	end
	if e == "QUEST_ACCEPTED" then
		local title, _, _, _, _, _, _, qid = GetQuestLogTitle(id)
		if questTimers[qid] then
			if bars[qid] then
				bars[qid]:Cancel()
			end
			bars[qid] = DBT:CreateBar(questTimers[qid], tostring(title) or tostring(id), "Interface\\Icons\\Spell_Nature_TimeStop")
			frame:RegisterEvent("QUEST_LOG_UPDATE")
		end
	elseif e == "QUEST_LOG_UPDATE" then
		-- check for the user abandoning the quest
		local quests = {}
		for i = 1, 25 do
			local _, _, _, _, _, complete, _, qid = GetQuestLogTitle(i)
			-- check for completion as the shat escort can complete early if someone elses npc finishes next to you
			if qid and not complete then
				quests[qid] = true
			end
		end
		local nbars = 0
		for qid, bar in pairs(bars) do
			if bar and not quests[qid] then
				bar:Cancel()
				bars[qid] = nil
			elseif bar ~= nil then
				nbars = nbars + 1
			end
		end
		if nbars == 0 then
			frame:UnregisterEvent("QUEST_LOG_UPDATE")
		end
	end
end)
