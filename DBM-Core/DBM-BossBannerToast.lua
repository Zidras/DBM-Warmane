-- ************************************************************************************************************************************************************
-- **** BOSS BANNER *******************************************************************************************************************************************
-- ************************************************************************************************************************************************************
local _, private = ...

--------------
--  Locals  --
--------------
local strfind, strformat, tostring = strfind, string.format, tostring
local next, pairs, tconcat, tinsert, wipe = next, pairs, table.concat, tinsert, table.wipe
local max, tonumber = max, tonumber

local CreateFrame = CreateFrame
local GetCurrentMapAreaID = GetCurrentMapAreaID
local GetCurrentMapContinent = GetCurrentMapContinent
local GetItemInfo = GetItemInfo
local GetLocale = GetLocale
local GetLootSlotInfo = GetLootSlotInfo
local GetLootSlotLink = GetLootSlotLink
local GetNumLootItems = GetNumLootItems
local GetRealZoneText = GetRealZoneText
local IsDressableItem = IsDressableItem
local PlaySoundFile = PlaySoundFile
local UnitIsDead = UnitIsDead
local UnitIsFriend = UnitIsFriend
local UnitGUID = UnitGUID
local UnitName = UnitName

local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS
--local ITEM_SET_NAME = ITEM_SET_NAME

local L = DBM_CORE_L

local BB_EXPAND_TIME = 0.25			-- time to expand per item
local BB_EXPAND_HEIGHT = 50			-- pixels to expand per item
local BB_MAX_LOOT = 8				-- changed retail value from 7 to 8, since TOC Tribute chest (gob 195665) can drop 8 items

local BB_STATE_BANNER_IN = 1		-- banner is animating in
local BB_STATE_KILL_HOLD = 2		-- banner is holding with kill info
local BB_STATE_SWITCH = 3			-- banner is switching from kill to loot look
local BB_STATE_LOOT_EXPAND = 4		-- banner is expanding for loot items
local BB_STATE_LOOT_INSERT = 5		-- loot item is being inserted. banner will hold for longer than insertion animation to catch more loot.
local BB_STATE_BANNER_OUT = 6		-- banner is animating out

local SOUNDKIT = {
	["UI_RAID_BOSS_DEFEATED"] = "Interface\\AddOns\\DBM-Core\\sounds\\RetailSupport\\UI_Raid_Boss_Defeated_01.ogg", -- 50111
	["UI_PERSONAL_LOOT_BANNER"] = "Interface\\AddOns\\DBM-Core\\sounds\\RetailSupport\\UI_Raid_Loot_Banner_01.ogg", -- 50893
}

--Hard code STANDARD_TEXT_FONT since skinning mods like to taint it (or worse, set it to nil, wtf?)
local standardFont
local BBfont = nil -- keep Luacheck happy
if LOCALE_koKR then
	standardFont = "Fonts\\2002.TTF"
elseif LOCALE_zhCN then
	standardFont = "Fonts\\ARKai_T.ttf"
elseif LOCALE_zhTW then
	standardFont = "Fonts\\blei00d.TTF"
elseif LOCALE_ruRU then
	standardFont = "Fonts\\FRIZQT___CYR.TTF"
else
	standardFont = "Fonts\\FRIZQT__.TTF"
end

-- math toolkit
local function round(value, dp)
	return tonumber(strformat("%."..(dp or 14).."f", tostring(value)))
end

-- Animations
local function CreateScaleAnim(group, order, duration, scaleX, scaleY, delay, smoothing, endDelay, originPoint, originOffsetX, originOffsetY)
	local anim = group:CreateAnimation("Scale")
	anim:SetOrder(order)
	anim:SetDuration(duration)
	anim:SetScale(scaleX, scaleY) -- Multipliers. Example: fromScaleX="5" toScaleX="1" is 1/5

	if delay then
		anim:SetStartDelay(delay)
	end
	if endDelay then
		anim:SetEndDelay(endDelay)
	end
	if smoothing then
		anim:SetSmoothing(smoothing)
	end
	if originPoint then
		anim:SetOrigin(originPoint, originOffsetX or 0, originOffsetY or 0)
	end
end

local function CreateAlphaAnim(group, order, duration, change, delay, smoothing, endDelay)
	local anim = group:CreateAnimation("Alpha")
	anim:SetOrder(order)
	anim:SetDuration(duration)
	anim:SetChange(change)

	if delay then
		anim:SetStartDelay(delay)
	end
	if endDelay then
		anim:SetEndDelay(endDelay)
	end
	if smoothing then
		anim:SetSmoothing(smoothing)
	end
	-- OnFinished scripts do not work to set alpha since the group resets the alpha of the region back to its original value on the first frame after OnFinished.
end

local function CreateTranslationAnim(group, order, duration, xOffset, yOffset, delay, smoothing, endDelay)
	local anim = group:CreateAnimation("Translation")
	anim:SetOrder(order)
	anim:SetDuration(duration)
	anim:SetOffset(xOffset, yOffset)

	if delay then
		anim:SetStartDelay(delay)
	end
	if endDelay then
		anim:SetEndDelay(endDelay)
	end
	if smoothing then
		anim:SetSmoothing(smoothing)
	end
end

-- Loot Handling
local tooltipTextCache
local tooltipSwitchCounter = 0
local function GameTooltipCacheName(self)
	-- Fetch tooltip text from mouseover to also catch gob container name (e.g. Treasure chest).

	-- Don't keep cache indefinitely. Main use is to preserve the gob container name.
	tooltipSwitchCounter = tooltipSwitchCounter + 1
	if tooltipSwitchCounter > 2 then -- REVIEW!
		tooltipTextCache = nil
	end

	if not self:IsOwned(UIParent) then return end -- Only cache if tooltip refers to UIParent (used by gob tooltips). Discards many false positives like PlayerFrame, Interface Options, ElvUI, etc, that are picked up by below color text.

	-- Will fail with Interact with Target keybind if mouseover on something else, so attempt to mitigate it by restricting the caching to tooltips with only yellow text on the first line (can't restrict to only 1 line since there is, at least, one chest, on Hodir [gob 194201] - Rare Cache of Winter - which will have more than 1 line with the Quest [13822] "Heroic: Hodir's Sigil")
	local rt, gt, bt, at = _G["GameTooltipTextLeft1"]:GetTextColor()
	if round(rt) == 0.99999780301005 and round(gt) == 0.82352757453918 and round(bt) == 0 and round(at) == 0.99999779462814 then -- yellow text from gob
		tooltipSwitchCounter = 0
		tooltipTextCache = _G["GameTooltipTextLeft1"]:GetText()
	end
end
GameTooltip:SetScript("OnShow", GameTooltipCacheName) -- Tooltip fetching resulting in unreliable results, where on a split frame it would not update the text (either nil or different than expected), so run it always to catch it as fast as possible. Will fail if mouseover another unit, since TT updates before LOOT_OPENED.

local encounterLootCache = {}
local locale = GetLocale()
local function BossBanner_FetchAndSyncLootItems(self)
	local numLootItems = GetNumLootItems()
	local encounterId = self.encounterID
	local encounterName = self.encounterName or "Unknown encounter"
	local targetNpcDead = not UnitIsFriend("player", "target") and UnitIsDead("target")
	local lootSourceTTName = tooltipTextCache -- Not reliable to fetch tooltip text here (see above)
	local lootSourceMobName = targetNpcDead and UnitName("target") -- targeted loot always refreshes in time
	local lootSourceName = lootSourceMobName or lootSourceTTName -- Prefer target unit rather than mouseover (chances of this being wrong are lower than the inverse)
	local lootSourceGUID = targetNpcDead and UnitGUID("target")
	local lootSourceID = lootSourceGUID or lootSourceName

	-- build encounter loot cache
	encounterLootCache[encounterId] = encounterLootCache[encounterId] or {}

	-- check if looted corpse belongs to the DBM boss mod
	DBM:Debug("BossBanner for "..encounterId.." ("..encounterName.."), with loot arguments --> lootSourceGUID: "..tostring(lootSourceGUID).. " ; lootSourceName: "..tostring(lootSourceName).. " ; TT name: "..tostring(_G["GameTooltipTextLeft1"]:GetText()), 3)
	if lootSourceGUID then
		local lootSourceCID = DBM:GetCIDFromGUID(lootSourceGUID)
		DBM:Debug("BossBanner: pre-check on CID: "..tostring(lootSourceCID).." and lootSouceName: "..tostring(lootSourceName).." and lootSourceMobName: "..tostring(lootSourceMobName)..". Npcdead is: "..tostring(targetNpcDead), 3)
		if lootSourceName == lootSourceMobName then
			local encounterBossMod = DBM:GetModByName(encounterId)

			if not encounterBossMod then
				DBM:Debug("BossBanner: no mod found for encounter "..tostring(encounterId)..". Ending fetching and syncing process.")
				return
			end

			if encounterBossMod.combatInfo.killMobs then -- Mod has multiple mobs
				local found = false
				for mobId in pairs(encounterBossMod.combatInfo.killMobs) do -- key checking required, as value can be either true or false
					if mobId == lootSourceCID then
						found = true
						break
					end
				end
				if not found then
					DBM:Debug("BossBanner: LootSourceCID ("..lootSourceCID..") does not belong to DBM mod (multiboss). Ending fetching and syncing process.", 3)
					return
				end
			else
				if encounterBossMod.creatureId ~= lootSourceCID then
					DBM:Debug("BossBanner: LootSourceCID ("..lootSourceCID..") does not belong to DBM mod. Ending fetching and syncing process.", 3)
					return
				end
			end
		end
	end

	-- check if lootSourceID exists
	if not lootSourceID then
		DBM:Debug("BossBanner: no lootSourceID. Ending fetching and syncing process.", 3)
		return
	end

	-- check if player already opened loot window
	if encounterLootCache[encounterId][lootSourceID] and encounterLootCache[encounterId][lootSourceID].looted then
		DBM:Debug("BossBanner: Boss/Container ("..lootSourceID..") already looted. Ending fetching and syncing process.", 3)
		return
	end

	encounterLootCache[encounterId][lootSourceID] = encounterLootCache[encounterId][lootSourceID] or {}
	encounterLootCache[encounterId][lootSourceID].looted = true

	local tempLootItemCounter = {}
	if numLootItems > 0 then
		for slot = 1, numLootItems do
			local texture, _, quantity = GetLootSlotInfo(slot) -- texture, itemName, quantity, quality, locked
			local itemLink = GetLootSlotLink(slot)
			-- Duplicate loot items cannot be distinguished from each other. Only by lootslot, which will only be preserved during looting while loot window is open. If loot window reopened after item(s) have been looted, it will be repopulated with ascending index.
			-- Dump: value=GetLootSlotLink(3)
			-- [1]="|cffa335ee|Hitem:50603:0:0:0:0:0:0:0:80|h[Cryptmaker]|h|r"
			-- Dump: value=GetLootSlotLink(4)
			-- [1]="|cffa335ee|Hitem:50603:0:0:0:0:0:0:0:80|h[Cryptmaker]|h|r"
			if itemLink then
				local _, _, _, _, itemID --[[_, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, unique, LinkLvl, Name]] = strfind(itemLink, "|?c?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
				local finalItem = tostring(slot == numLootItems)

				encounterLootCache[encounterId][lootSourceID][itemID] = encounterLootCache[encounterId][lootSourceID][itemID] or {}
				tempLootItemCounter[itemID] = (tempLootItemCounter[itemID] or 0) + 1

				if next(encounterLootCache[encounterId][lootSourceID][itemID]) == nil then
					tinsert(encounterLootCache[encounterId][lootSourceID][itemID], false) -- insert it this way to account for duplicates. Boolean will be used in the Core sync handler
				else

					for key, synced in ipairs(encounterLootCache[encounterId][lootSourceID][itemID]) do
						if key < tempLootItemCounter[itemID] and not synced then
							tinsert(encounterLootCache[encounterId][lootSourceID][itemID], false) -- insert it this way to account for duplicates. Boolean will be used in the Core sync handler
							break
						end
					end
				end

				if finalItem == "true" then
					wipe(tempLootItemCounter)
				end

				DBM:Debug("BossBanner: Sending sync (v3) with the following args: "..locale..", "..encounterId..", "..encounterName..", "..lootSourceName..", "..tostring(lootSourceGUID)..", "..itemID..", "..itemLink..", "..tostring(quantity)..", "..tostring(slot)..", "..texture..", "..finalItem, 3)
				private.sendSync("DBMv4-L", ("%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s"):format(--[[version:]]"3", locale, encounterId, encounterName, lootSourceName, tostring(lootSourceGUID), itemID, itemLink, tostring(quantity), tostring(slot), texture, finalItem)) -- needs to be less than 255 characters, otherwise it won't be sent
			end
		end
	end
end

-- https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_FrameXML/TopBannerManager.lua
------------------------------------------------------------------
-- Top Banner Display Manager
--
-- Manager for displaying large UI elements at the top of the HUD.
--
-- Frames that want to display must have the following functions defined:
-- PlayBanner(self, [data, [isExclusiveQueued]])
-- StopBanner(self)
--
-- The following functions are optional:
-- ResumeBanner(self) -- restart banner animation
--
------------------------------------------------------------------
local TopBannerMgr = {}
local TopBannerQueue = {}

local function TopBannerManager_Show(frame, data, isExclusiveQueued)
	local banner = {frame = frame, data = data}
	if TopBannerMgr.currentBanner then
		-- queue up this frame to play later
		if (isExclusiveQueued) then
			-- check if multiple instances of this frame should be queued
			for _, queuedBanner in pairs(TopBannerQueue) do
				if (isExclusiveQueued(banner, queuedBanner)) then
					return
				end
			end
		end
		tinsert(TopBannerQueue, banner)
	else
		TopBannerMgr.currentBanner = banner
		frame:PlayBanner(data)
	end
end

-- LOADING_SCREEN events not currently supported on 3.3.5a
--[[local function TopBannerManager_LoadingScreenEnabled()
	if TopBannerMgr.currentBanner then
		TopBannerMgr.currentBanner.frame:StopBanner()
	end
end

local function TopBannerManager_LoadingScreenDisabled()
	local currentBanner = TopBannerMgr.currentBanner
	if currentBanner and currentBanner.frame.ResumeBanner then
		currentBanner.frame:ResumeBanner(currentBanner.data)
	else
		TopBannerManager_BannerFinished()
	end
end]]

local function TopBannerManager_BannerFinished()
	if #TopBannerQueue > 0 then
		TopBannerMgr.currentBanner = table.remove(TopBannerQueue, 1)
--		TopBannerMgr.currentBanner.frame:PlayBanner(TopBannerMgr.currentBanner.data) -- Needs investigation, crashes the client!
		DBM:Schedule(0, TopBannerMgr.currentBanner.frame.PlayBanner, TopBannerMgr.currentBanner.frame, TopBannerMgr.currentBanner.data)
	else
		if TopBannerMgr.currentBanner and next(TopBannerMgr.currentBanner.frame.pendingLoot) then -- has pending loot, send next. Checking for currentBanner to prevent nil Lua error on right-click
			TopBannerMgr.currentBanner.data.mode = "LOOT" -- change mode to LOOT, since KILL would show kill banner again
			DBM:Schedule(0, TopBannerMgr.currentBanner.frame.PlayBanner, TopBannerMgr.currentBanner.frame, TopBannerMgr.currentBanner.data)
		else
			TopBannerMgr.currentBanner = nil
		end
	end
end

--[[local function TopBannerManager_IsIdle()
	return TopBannerMgr.currentBanner == nil
end]]

------------------------------------------------------------------
-- https://www.townlong-yak.com/framexml/live/Helix/AtlasInfo.lua
local AtlasInfo = {
--	["Interface/LevelUp/BossBanner"]={
		["BossBanner-BottomFillagree"]={66, 28, 0.865234, 0.994141, 0.314453, 0.369141, false, false, "1x"},
		["BossBanner-SkullCircle"]={44, 44, 0.865234, 0.951172, 0.134766, 0.220703, false, false, "1x"},
		["BossBanner-TopFillagree"]={176, 74, 0.244141, 0.587891, 0.576172, 0.720703, false, false, "1x"},
		["BossBanner-RedFlash"]={92, 92, 0.00195312, 0.181641, 0.810547, 0.990234, false, false, "1x"},
		["BossBanner-LeftFillagree"]={72, 40, 0.591797, 0.732422, 0.576172, 0.654297, false, false, "1x"},
		["BossBanner-RightFillagree"]={72, 40, 0.736328, 0.876953, 0.576172, 0.654297, false, false, "1x"},
		["BossBanner-SkullSpikes"]={50, 66, 0.865234, 0.962891, 0.00195312, 0.130859, false, false, "1x"},
		["BossBanner-BgBanner-Bottom"]={440, 112, 0.00195312, 0.861328, 0.00195312, 0.220703, false, false, "1x"},
		["BossBanner-BgBanner-Top"]={440, 112, 0.00195312, 0.861328, 0.224609, 0.443359, false, false, "1x"},
		["LootBanner-IconGlow"]={40, 40, 0.865234, 0.943359, 0.447266, 0.525391, false, false, "1x"},
		["LootBanner-ItemBg"]={269, 41, 0.244141, 0.769531, 0.724609, 0.804688, false, false, "1x"},
		["LootBanner-LootBagCircle"]={44, 44, 0.865234, 0.951172, 0.224609, 0.310547, false, false, "1x"},
		["BossBanner-BgBanner-Mid"]={440, 64, 0.00195312, 0.861328, 0.447266, 0.572266, false, false, "1x"},
		["BossBanner-RedLightning"]={122, 118, 0.00195312, 0.240234, 0.576172, 0.806641, false, false, "1x"},
--	}, -- Interface/LevelUp/BossBanner
}

local function SetAtlas(textureObject, atlasName, useAtlasSize)
	local atlas = AtlasInfo[atlasName]
	if textureObject and atlas then
		textureObject:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\BossBannerToast\\BossBanner") -- hardcode texture, since there is only one required for this Toast
		textureObject:SetTexCoord(atlas[3], atlas[4], atlas[5], atlas[6])
		if useAtlasSize then
			textureObject:SetSize(atlas[1], atlas[2])
		end
		return textureObject
	end
end

------------------------------------------------------------------
-- https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_FrameXML/BossBannerToast.xml
-- BossBanner frame from XML
local BossBanner = CreateFrame("Frame", "BossBanner", UIParent)
BossBanner:Hide()
BossBanner:SetSize(128, 156)
BossBanner:SetPoint("TOP", UIParent, 0, -120)
BossBanner:EnableMouse(true) -- required for Mouse scripts
BossBanner:SetAlpha(1)
BossBanner.LootFrames = {}
BossBanner.encounterLootCache = encounterLootCache -- custom, for debugging purposes

local bossBannerEffectiveScale = BossBanner:GetEffectiveScale() -- workaround to 3.3.5a bug with UIScale not being accounted for in Translation animations

-- BORDER
BossBanner.BannerTop = BossBanner:CreateTexture("BannerTop", "BORDER")
local BannerTop = BossBanner.BannerTop
BannerTop:SetBlendMode("BLEND")
BannerTop = SetAtlas(BannerTop, "BossBanner-BgBanner-Top", true)
BannerTop:SetPoint("TOP", 0, -44)
--BannerTop:SetAlpha(0)

BossBanner.BannerTopGlow = BossBanner:CreateTexture("BannerTopGlow", "BORDER")
local BannerTopGlow = BossBanner.BannerTopGlow
BannerTopGlow:SetBlendMode("ADD")
BannerTopGlow = SetAtlas(BannerTopGlow, "BossBanner-BgBanner-Top", true)
BannerTopGlow:SetPoint("TOP", 0, -44)
BannerTopGlow:SetAlpha(0)

BossBanner.BannerBottom = BossBanner:CreateTexture("BannerBottom", "BORDER")
local BannerBottom = BossBanner.BannerBottom
BannerBottom:SetBlendMode("BLEND")
BannerBottom = SetAtlas(BannerBottom, "BossBanner-BgBanner-Bottom", true)
BannerBottom:SetPoint("BOTTOM", 0, 0)
--BannerBottom:SetAlpha(0)

BossBanner.BannerBottomGlow = BossBanner:CreateTexture("BannerBottomGlow", "BORDER")
local BannerBottomGlow = BossBanner.BannerBottomGlow
BannerBottomGlow:SetBlendMode("ADD")
BannerBottomGlow = SetAtlas(BannerBottomGlow, "BossBanner-BgBanner-Bottom", true)
BannerBottomGlow:SetPoint("BOTTOM", 0, 0)
BannerBottomGlow:SetAlpha(0)

-- BACKGROUND
BossBanner.BannerMiddle = BossBanner:CreateTexture("BannerMiddle", "BACKGROUND")
local BannerMiddle = BossBanner.BannerMiddle
BannerMiddle = SetAtlas(BannerMiddle, "BossBanner-BgBanner-Mid", true)
BannerMiddle:SetBlendMode("BLEND")
BannerMiddle:SetPoint("TOPLEFT", BannerTop, 0, -34)
BannerMiddle:SetPoint("BOTTOMRIGHT", BannerBottom, 0, 25)
--BannerMiddle:SetAlpha(0)

BossBanner.BannerMiddleGlow = BossBanner:CreateTexture("BannerMiddleGlow", "BACKGROUND")
local BannerMiddleGlow = BossBanner.BannerMiddleGlow
BannerMiddleGlow = SetAtlas(BannerMiddleGlow, "BossBanner-BgBanner-Mid", true)
BannerMiddleGlow:SetBlendMode("ADD")
BannerMiddleGlow:SetPoint("TOPLEFT", BannerTop, 0, -34)
BannerMiddleGlow:SetPoint("BOTTOMRIGHT", BannerBottom, 0, 25)
BannerMiddleGlow:SetAlpha(0)

-- OVERLAY
BossBanner.SkullCircle = BossBanner:CreateTexture("SkullCircle", "OVERLAY")
local SkullCircle = BossBanner.SkullCircle
SkullCircle:SetBlendMode("BLEND")
SkullCircle = SetAtlas(SkullCircle, "BossBanner-SkullCircle", true)
SkullCircle:SetPoint("CENTER", BannerTop, 0, 36)
--SkullCircle:SetAlpha(0)

BossBanner.LootCircle = BossBanner:CreateTexture("LootCircle", "OVERLAY")
local LootCircle = BossBanner.LootCircle
LootCircle:SetBlendMode("BLEND")
LootCircle = SetAtlas(LootCircle, "LootBanner-LootBagCircle", true)
LootCircle:SetPoint("CENTER", BannerTop, 0, 36)
--LootCircle:SetAlpha(0)

-- BossBanner.RedFlash = BossBanner:CreateTexture("RedFlash", "OVERLAY") -- unused, see below on sublevel 4
-- local RedFlash = BossBanner.RedFlash
-- RedFlash:SetBlendMode("ADD")
-- RedFlash = SetAtlas(RedFlash, "BossBanner-RedFlash", true)
-- RedFlash:SetPoint("CENTER", SkullCircle, 0, 3)
-- RedFlash:SetAlpha(0)

-- ARTWORK
BossBanner.BottomFillagree = BossBanner:CreateTexture("BottomFillagree", "ARTWORK")
local BottomFillagree = BossBanner.BottomFillagree
BottomFillagree:SetBlendMode("BLEND")
BottomFillagree = SetAtlas(BottomFillagree, "BossBanner-BottomFillagree", true)
BottomFillagree:SetPoint("BOTTOM", 0, 8)
--BottomFillagree:SetAlpha(0)

BossBanner.SkullSpikes = BossBanner:CreateTexture("SkullSpikes", "ARTWORK")
local SkullSpikes = BossBanner.SkullSpikes
SkullSpikes:SetBlendMode("BLEND")
SkullSpikes = SetAtlas(SkullSpikes, "BossBanner-SkullSpikes", true)
SkullSpikes:SetPoint("CENTER", SkullCircle, -1, 6)
--SkullSpikes:SetAlpha(0)

BossBanner.RightFillagree = BossBanner:CreateTexture("RightFillagree", "ARTWORK")
local RightFillagree = BossBanner.RightFillagree
RightFillagree:SetBlendMode("BLEND")
RightFillagree = SetAtlas(RightFillagree, "BossBanner-RightFillagree", true)
RightFillagree:SetPoint("CENTER", SkullCircle, 47, 6) -- edited to final position
--RightFillagree:SetAlpha(0)

BossBanner.LeftFillagree = BossBanner:CreateTexture("LeftFillagree", "ARTWORK")
local LeftFillagree = BossBanner.LeftFillagree
LeftFillagree:SetBlendMode("BLEND")
LeftFillagree = SetAtlas(LeftFillagree, "BossBanner-LeftFillagree", true)
LeftFillagree:SetPoint("CENTER", SkullCircle, -47, 6) -- edited to final position
--LeftFillagree:SetAlpha(0)

BossBanner.Title = BossBanner:CreateFontString("Title", "ARTWORK", "QuestFont_Large") -- REVIEW for non latin locales. Retail uses QuestFont_Enormous with 30 value height
local Title = BossBanner.Title
Title:SetHeight(30) -- Doesn't increase text height, only FontString height
local titleFont, _, titleFlag = Title:GetFont()
Title:SetFont(titleFont, 30, titleFlag) -- Doesn't reach size 30. Client limitation. SetTextHeight would pixelify the font, so keep it tiny
Title:SetText(L.BOSS_YOU_DEFEATED)
Title:SetPoint("TOP", BannerTop, 0, -47)
Title:SetTextColor(1, 0, 0, 0)
Title:SetAlpha(1) -- Workaround for alpha animation bug. Keep it below SetTextColor, since it sets alpha to zero

BossBanner.SubTitle = BossBanner:CreateFontString("SubTitle", "ARTWORK", "GameFontNormalLarge")
local SubTitle = BossBanner.SubTitle
SubTitle:SetText(L.BOSS_KILL_SUBTITLE)
SubTitle:SetPoint("TOP", BottomFillagree, "BOTTOM", 0, 0)
SubTitle:SetTextColor(1, 0, 0, 0)
SubTitle:SetAlpha(1) -- Workaround for alpha animation bug. Keep it below SetTextColor, since it sets alpha to zero

-- OVERLAY, texture sublevel 2
BossBanner.FlashBurst = BossBanner:CreateTexture("FlashBurst", "OVERLAY", nil, 2)
local FlashBurst = BossBanner.FlashBurst
FlashBurst:SetBlendMode("ADD")
FlashBurst = SetAtlas(FlashBurst, "BossBanner-RedLightning", true)
FlashBurst:SetPoint("CENTER", SkullSpikes, 15, -4)
FlashBurst:SetAlpha(0.01)

BossBanner.FlashBurstLeft = BossBanner:CreateTexture("FlashBurstLeft", "OVERLAY", nil, 2)
local FlashBurstLeft = BossBanner.FlashBurstLeft
FlashBurstLeft:SetBlendMode("ADD")
FlashBurstLeft = SetAtlas(FlashBurstLeft, "BossBanner-RedLightning", true)
FlashBurstLeft:SetPoint("CENTER", SkullSpikes, -15, -4)
FlashBurstLeft:SetAlpha(0.01)

-- OVERLAY, texture sublevel 3
BossBanner.FlashBurstCenter = BossBanner:CreateTexture("FlashBurstCenter", "OVERLAY", nil, 3)
local FlashBurstCenter = BossBanner.FlashBurstCenter
FlashBurstCenter:SetBlendMode("ADD")
FlashBurstCenter = SetAtlas(FlashBurstCenter, "BossBanner-RedLightning", true)
FlashBurstCenter:SetPoint("CENTER", SkullSpikes)
FlashBurstCenter:SetAlpha(0.01)

-- OVERLAY, texture sublevel 4
BossBanner.RedFlash = BossBanner:CreateTexture("RedFlash", "OVERLAY", nil, 4) -- retail writes RedFlash twice, but the animation runs on this texture
local RedFlash = BossBanner.RedFlash
RedFlash:SetBlendMode("ADD")
RedFlash = SetAtlas(RedFlash, "BossBanner-RedFlash", true)
RedFlash:SetPoint("CENTER", SkullSpikes, 1, -4)
RedFlash:SetAlpha(0.01)


-- OnItemEnter/Leave functions, for the loot frame
local function BossBanner_OnLootItemEnter(self)
	-- no tooltip when banner is animating out
	if BossBanner.animState ~= BB_STATE_BANNER_OUT and not BossBanner.showingTooltip then -- avoid OnEnter spam by checking for tooltip being visible
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:SetHyperlink(self:GetParent().itemLink)
		GameTooltip:Show()
		BossBanner.showingTooltip = true
	end
end

local function BossBanner_OnLootItemLeave() -- self
	if BossBanner.showingTooltip then
		GameTooltip:Hide()
		BossBanner.showingTooltip = false
	end
end

-- Loot frame factory, based on BossBannerLootFrameTemplate
local function createLootFrame(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetSize(269, 44)

	local effectiveScale = frame:GetEffectiveScale()

	-- Background texture
	frame.Background = frame:CreateTexture(nil, "BACKGROUND")
	local Background = frame.Background
	Background:SetBlendMode("BLEND")
	Background = SetAtlas(Background, "LootBanner-ItemBg", true)
	Background:SetPoint("CENTER")

	-- Icon texture
	frame.Icon = frame:CreateTexture(nil, "BORDER")
	local Icon = frame.Icon
	Icon:SetSize(37, 37)
	Icon:SetPoint("LEFT", --[[124]] 14, 0) -- Workaround for Translation last frame flicker of IconHitBox animations 124 initial point is mimicked in animations. Also prevents the need for OnFinished SetPoint
	Icon:SetTexture("Interface\\Icons\\inv_misc_bag_felclothbag")

	-- FontString for Item Count
	frame.Count = frame:CreateFontString(nil, "ARTWORK", "NumberFontNormal")
	local Count = frame.Count
	if BBfont then
		Count:SetFont(BBfont, 14 + DBM.Options.BBFontSize, DBM.Options.BBFontStyle)
		if DBM.Options.BBFontShadow then
			Count:SetShadowOffset(1, -1)
		end
	end
	Count:SetJustifyH("RIGHT")
	Count:SetPoint("BOTTOMRIGHT", Icon, -5, 2)
	Count:Hide()

	-- FontString for Item Name
	frame.ItemName = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalMed3") -- Same as retail GameFontNormalMed2
	local ItemName = frame.ItemName
	if BBfont then
		ItemName:SetFont(BBfont, 14 + DBM.Options.BBFontSize, DBM.Options.BBFontStyle)
		if DBM.Options.BBFontShadow then
			ItemName:SetShadowOffset(1, -1)
		end
	end
	ItemName:SetWordWrap(false) -- try to mimic maxLines = 1
	ItemName:SetJustifyH("LEFT")
	ItemName:SetSize(204, 0)
	ItemName:SetPoint("TOPLEFT", frame, 56, -7)

	-- FontString for Set Name (hidden)
	frame.SetName = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	local SetName = frame.SetName
	if BBfont then
		SetName:SetFont(BBfont, 12 + DBM.Options.BBFontSize, DBM.Options.BBFontStyle)
		if DBM.Options.BBFontShadow then
			SetName:SetShadowOffset(1, -1)
		end
	end
	SetName:SetWordWrap(false) -- try to mimic maxLines = 1
	SetName:SetJustifyH("LEFT")
	SetName:SetSize(204, 0)
	SetName:SetPoint("TOPLEFT", ItemName, "BOTTOMLEFT", 0, 0)
	SetName:SetTextColor(0, 1.0, 0)
	SetName:Hide()

	-- FontString for Player Name (originally), re-used for looted Boss name)
	frame.PlayerName = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	local PlayerName = frame.PlayerName
	if BBfont then
		PlayerName:SetFont(BBfont, 12 + DBM.Options.BBFontSize, DBM.Options.BBFontStyle)
		if DBM.Options.BBFontShadow then
			PlayerName:SetShadowOffset(1, -1)
		end
	end
	PlayerName:SetWordWrap(false) -- try to mimic maxLines = 1
	PlayerName:SetJustifyH("LEFT")
	PlayerName:SetSize(204, 0)
	PlayerName:SetPoint("TOPLEFT", ItemName, "BOTTOMLEFT", 0, 0)

	-- Icon Hitbox Frame
	frame.IconHitBox = CreateFrame("Frame", nil, frame)
	local IconHitBox = frame.IconHitBox
	IconHitBox:SetSize(37, 37)
	IconHitBox:SetPoint("CENTER", Icon)
	IconHitBox:EnableMouse(true) -- required for Mouse scripts

	-- IconBorder (hidden)
	IconHitBox.IconBorder = IconHitBox:CreateTexture(nil, "BORDER")
	local IconBorder = IconHitBox.IconBorder
	IconBorder:SetTexture("Interface\\Common\\WhiteIconFrame")
	IconBorder:SetSize(37, 37)
	IconBorder:SetPoint("CENTER")
	IconBorder:Hide()

	-- Glow Texture
	IconHitBox.Glow = IconHitBox:CreateTexture(nil, "ARTWORK")
	local Glow = IconHitBox.Glow
	Glow:SetBlendMode("ADD")
	Glow = SetAtlas(Glow, "LootBanner-IconGlow", true)
	Glow:SetPoint("CENTER")
	Glow:SetVertexColor(0.63921568627451, 0.2078431372549, 0.93333333333333)
	Glow:SetAlpha(0) -- Workaround to SetAlpha bug on OnFinished

	-- GlowWhite Texture
	IconHitBox.GlowWhite = IconHitBox:CreateTexture(nil, "ARTWORK")
	local GlowWhite = IconHitBox.GlowWhite
	GlowWhite:SetBlendMode("ADD")
	GlowWhite = SetAtlas(GlowWhite, "LootBanner-IconGlow", true)
	GlowWhite:SetPoint("CENTER")
	GlowWhite:SetAlpha(0) -- Workaround to SetAlpha bug on OnFinished

	-- Icon Overlay
	IconHitBox.IconOverlay = IconHitBox:CreateTexture(nil, "OVERLAY", nil, 1)
	local IconOverlay = IconHitBox.IconOverlay
	IconOverlay:SetSize(37, 37)
	IconOverlay:SetPoint("CENTER")
	IconOverlay:Hide()

	-- Icon Overlay 2
	IconHitBox.IconOverlay2 = IconHitBox:CreateTexture(nil, "OVERLAY", nil, 2)
	local IconOverlay2 = IconHitBox.IconOverlay2
	IconOverlay2:SetSize(37, 37)
	IconOverlay2:SetPoint("CENTER")
	IconOverlay2:Hide()

	-- Add the frame to the LootFrames table
	tinsert(parent.LootFrames, frame)

	-- Add scripts
	-- Add OnLoad script manually
	IconHitBox.UpdateTooltip = function(owner)
		BossBanner_OnLootItemEnter(owner)
	end
	IconHitBox:SetScript("OnEnter", BossBanner_OnLootItemEnter)
	IconHitBox:SetScript("OnLeave", BossBanner_OnLootItemLeave)

	-- Animations
	Background.animForAnim = Background:CreateAnimationGroup()
	Icon.animForAnim = Icon:CreateAnimationGroup()
	IconBorder.animForAnim = IconBorder:CreateAnimationGroup()
	IconOverlay.animForAnim = IconOverlay:CreateAnimationGroup()
	IconOverlay2.animForAnim = IconOverlay2:CreateAnimationGroup()
	Glow.animForAnim = Glow:CreateAnimationGroup()
	IconHitBox.animForAnim = IconHitBox:CreateAnimationGroup()
	GlowWhite.animForAnim = GlowWhite:CreateAnimationGroup()
	ItemName.animForAnim = ItemName:CreateAnimationGroup()
	PlayerName.animForAnim = PlayerName:CreateAnimationGroup()
	SetName.animForAnim = SetName:CreateAnimationGroup()

	-- Animation
	CreateAlphaAnim(Background.animForAnim, 1, 0, -1) -- Workaround to SetAlpha bug on OnFinished. fromAlpha="0" toAlpha="1"
	CreateAlphaAnim(Background.animForAnim, 1, 0.45, 1)

	CreateAlphaAnim(Icon.animForAnim, 1, 0, -1, 0.1) -- Workaround to SetAlpha bug on OnFinished. fromAlpha="0" toAlpha="1"
	CreateAlphaAnim(Icon.animForAnim, 1, 0.25, 1, 0.1)

	CreateAlphaAnim(IconBorder.animForAnim, 1, 0, -1, 0.1) -- Workaround to SetAlpha bug on OnFinished. fromAlpha="0" toAlpha="1"
	CreateAlphaAnim(IconBorder.animForAnim, 1, 0.25, 1, 0.1)

	CreateAlphaAnim(IconOverlay.animForAnim, 1, 0, -1, 0.1) -- Workaround to SetAlpha bug on OnFinished. fromAlpha="0" toAlpha="1"
	CreateAlphaAnim(IconOverlay.animForAnim, 1, 0.25, 1, 0.1)

	CreateAlphaAnim(IconOverlay2.animForAnim, 1, 0, -1, 0) -- Workaround to SetAlpha bug on OnFinished. fromAlpha="0" toAlpha="1"
	CreateAlphaAnim(IconOverlay2.animForAnim, 1, 0.25, 1, 0)

	CreateTranslationAnim(Icon.animForAnim, 1, 0, 110*effectiveScale, 0)
	CreateTranslationAnim(Icon.animForAnim, 1, 0.4, -110*effectiveScale, 0, 0.25, "OUT")

	CreateTranslationAnim(IconHitBox.animForAnim, 1, 0, 110*effectiveScale, 0)
	CreateTranslationAnim(IconHitBox.animForAnim, 1, 0.4, -110*effectiveScale, 0, 0.25, "OUT") -- group, order, duration, xOffset, yOffset, delay, smoothing

	CreateAlphaAnim(Glow.animForAnim, 1, 0, -1) -- Workaround to SetAlpha bug on OnFinished. fromAlpha="0" toAlpha="1"
	CreateAlphaAnim(Glow.animForAnim, 1, 0.15, 1, nil, "IN")
	CreateAlphaAnim(Glow.animForAnim, 1, 0.10, 1, 0.15) -- Workaround to SetAlpha bug on OnFinished. fromAlpha="1" toAlpha="0"
	CreateAlphaAnim(Glow.animForAnim, 1, 1, -1, 0.25) -- REVIEW order of this animation. May change order and delays

	CreateAlphaAnim(GlowWhite.animForAnim, 1, 0, -1) -- Workaround to SetAlpha bug on OnFinished. fromAlpha="0" toAlpha="1"
	CreateAlphaAnim(GlowWhite.animForAnim, 1, 0.25, 1, nil, "IN")
	CreateAlphaAnim(GlowWhite.animForAnim, 1, 0.25, -1, 0.25) --  REVIEW order
--	CreateScaleAnim(GlowWhite.animForAnim, 1, 0, 1, 1)
	CreateScaleAnim(GlowWhite.animForAnim, 1, 0.25, 1.25, 1.25, nil, "IN_OUT") -- group, order, duration, scaleX, scaleY, delay, smoothing)

	CreateAlphaAnim(ItemName.animForAnim, 1, 0, -1, 0.4)
	CreateAlphaAnim(ItemName.animForAnim, 1, 0.25, 1, 0.4)

	CreateAlphaAnim(PlayerName.animForAnim, 1, 0, -1, 0.4)
	CreateAlphaAnim(PlayerName.animForAnim, 1, 0.25, 1, 0.4)

	CreateAlphaAnim(SetName.animForAnim, 1, 0, -1, 0.4)
	CreateAlphaAnim(SetName.animForAnim, 1, 0.25, 1, 0.4)

	-- AnimationGroup
	frame.Anim = {}
	local Anim = frame.Anim
	Anim.Background = Background.animForAnim
	Anim.Icon = Icon.animForAnim
	Anim.IconBorder = IconBorder.animForAnim
	Anim.IconOverlay = IconOverlay.animForAnim
	Anim.IconOverlay2 = IconOverlay2.animForAnim
	Anim.Glow = Glow.animForAnim
	Anim.IconHitBox = IconHitBox.animForAnim
	Anim.GlowWhite = GlowWhite.animForAnim
	Anim.ItemName = ItemName.animForAnim
	Anim.PlayerName = PlayerName.animForAnim
	Anim.SetName = SetName.animForAnim

	Anim.Background.DebugName = "Background"
	Anim.Icon.DebugName = "Icon"
	Anim.IconBorder.DebugName = "IconBorder"
	Anim.IconOverlay.DebugName = "IconOverlay"
	Anim.IconOverlay2.DebugName = "IconOverlay2"
	Anim.Glow.DebugName = "Glow"
	Anim.IconHitBox.DebugName = "IconHitBox"
	Anim.GlowWhite.DebugName = "GlowWhite"
	Anim.ItemName.DebugName = "ItemName"
	Anim.PlayerName.DebugName = "PlayerName"
	Anim.SetName.DebugName = "SetName"

--	local animCounter, animFinishedCounter = 0,0
	Anim.Play = function(self)
		-- Add OnPlay functionality manually
		-- SetAlpha cannot be set manually with OnPlay/OnFinished scripts, due to 3.3.5a animation system limitation. It will blink for 1 frame since AnimationGroup resets alpha to previous value.
--		Icon:SetPoint("LEFT", 124, 0)

		-- Play the AnimationGroup
		for _, anim in pairs(self) do
			if type(anim) == "table" then
--				animCounter = animCounter + 1
				anim:Stop()
				anim:Play()
				--[[
				anim:SetScript("OnFinished", function()
					animFinishedCounter = animFinishedCounter + 1
					if animFinishedCounter == animCounter then
						Anim.OnFinished()
					end
				end)
				]]
			end
		end
	end

	--[[ Add OnFinished functionality manually
	Anim.OnFinished = function()
		animCounter, animFinishedCounter = 0,0
		Icon:SetPoint("LEFT", 14, 0)
	end]]

	-- Return the frame
	return frame
end

-- Frames
local bossBannerLootFrame = createLootFrame(BossBanner)
bossBannerLootFrame:Hide()
bossBannerLootFrame:SetPoint("TOP", 0, -84)

-- Animations
-- AnimationGroup: AnimIn
SkullCircle.animForAnimIn = SkullCircle:CreateAnimationGroup()
BannerTop.animForAnimIn = BannerTop:CreateAnimationGroup()
BannerBottom.animForAnimIn = BannerBottom:CreateAnimationGroup()
BannerMiddle.animForAnimIn = BannerMiddle:CreateAnimationGroup()
BottomFillagree.animForAnimIn = BottomFillagree:CreateAnimationGroup()
SkullSpikes.animForAnimIn = SkullSpikes:CreateAnimationGroup()
RightFillagree.animForAnimIn = RightFillagree:CreateAnimationGroup()
LeftFillagree.animForAnimIn = LeftFillagree:CreateAnimationGroup()
BannerTopGlow.animForAnimIn = BannerTopGlow:CreateAnimationGroup()
BannerBottomGlow.animForAnimIn = BannerBottomGlow:CreateAnimationGroup()
BannerMiddleGlow.animForAnimIn = BannerMiddleGlow:CreateAnimationGroup()
RedFlash.animForAnimIn = RedFlash:CreateAnimationGroup()
FlashBurst.animForAnimIn = FlashBurst:CreateAnimationGroup()
FlashBurstLeft.animForAnimIn = FlashBurstLeft:CreateAnimationGroup()
FlashBurstCenter.animForAnimIn = FlashBurstCenter:CreateAnimationGroup()
Title.animForAnimIn = Title:CreateAnimationGroup()
SubTitle.animForAnimIn = SubTitle:CreateAnimationGroup()

-- Order 1 of AnimIn (0.15s duration)
CreateScaleAnim(SkullCircle.animForAnimIn, 1, 0, 5, 5)
CreateScaleAnim(SkullCircle.animForAnimIn, 1, 0.15, 0.2, 0.2)
CreateAlphaAnim(SkullCircle.animForAnimIn, 1, 0, -1)
CreateAlphaAnim(SkullCircle.animForAnimIn, 1, 0.1, 1)

-- Order 2 of AnimIn (with order 1 set to 0.15s endDelay)
CreateAlphaAnim(BannerTop.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(BannerTop.animForAnimIn, 2, 0.25, 1, 0.2)
CreateScaleAnim(BannerTop.animForAnimIn, 1, 0, 0.1, 1, 0.15)
CreateScaleAnim(BannerTop.animForAnimIn, 2, 0.3, 10, 1, 0.1)

CreateAlphaAnim(BannerBottom.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(BannerBottom.animForAnimIn, 2, 0.25, 1, 0.2)
CreateScaleAnim(BannerBottom.animForAnimIn, 1, 0, 0.1, 1, 0.15)
CreateScaleAnim(BannerBottom.animForAnimIn, 2, 0.3, 10, 1, 0.1)

CreateAlphaAnim(BannerMiddle.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(BannerMiddle.animForAnimIn, 2, 0.25, 1, 0.2)
CreateScaleAnim(BannerMiddle.animForAnimIn, 1, 0, 0.1, 1, 0.15)
CreateScaleAnim(BannerMiddle.animForAnimIn, 2, 0.3, 10, 1, 0.1)

CreateAlphaAnim(BottomFillagree.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(BottomFillagree.animForAnimIn, 2, 0.15, 1)

CreateScaleAnim(SkullSpikes.animForAnimIn, 1, 0, 0.5, 0.5, 0.15)
CreateScaleAnim(SkullSpikes.animForAnimIn, 2, 0.1, 2, 2, 0.1)
CreateAlphaAnim(SkullSpikes.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(SkullSpikes.animForAnimIn, 2, 0.1, 1)

CreateAlphaAnim(RightFillagree.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(RightFillagree.animForAnimIn, 2, 0.1, 1)
--CreateTranslationAnim(RightFillagree.animForAnimIn, 1, 0, -37*bossBannerEffectiveScale, 0, 0.15)
CreateTranslationAnim(RightFillagree.animForAnimIn, 2, 0.15, 37*bossBannerEffectiveScale, 0, 0.15)
CreateScaleAnim(RightFillagree.animForAnimIn, 1, 0, 0.5, 0.5, 0.15, nil, nil, "BOTTOMLEFT")
CreateScaleAnim(RightFillagree.animForAnimIn, 2, 0.15, 2, 2, 0.15, nil, nil, "BOTTOMLEFT")
RightFillagree.animForAnimIn:SetScript("OnFinished", function()
	RightFillagree:SetPoint("CENTER", SkullCircle, "CENTER", 47, 6)
end)

CreateAlphaAnim(LeftFillagree.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(LeftFillagree.animForAnimIn, 2, 0.1, 1)
--CreateTranslationAnim(LeftFillagree.animForAnimIn, 1, 0, 37*bossBannerEffectiveScale, 0, 0.15)
CreateTranslationAnim(LeftFillagree.animForAnimIn, 2, 0.15, -37*bossBannerEffectiveScale, 0, 0.15)
CreateScaleAnim(LeftFillagree.animForAnimIn, 1, 0, 0.5, 0.5, 0.15, nil, nil, "BOTTOMRIGHT")
CreateScaleAnim(LeftFillagree.animForAnimIn, 2, 0.15, 2, 2, 0.15, nil, nil, "BOTTOMRIGHT")
LeftFillagree.animForAnimIn:SetScript("OnFinished", function()
	LeftFillagree:SetPoint("CENTER", SkullCircle, "CENTER", -47, 6)
end)

CreateAlphaAnim(BannerTopGlow.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(BannerTopGlow.animForAnimIn, 2, 0.25, 1, 0.9)
CreateScaleAnim(BannerTopGlow.animForAnimIn, 1, 0, 0.5, 1, 0.15)
CreateScaleAnim(BannerTopGlow.animForAnimIn, 2, 0.5, 3.2, 1, 0.9)
CreateAlphaAnim(BannerTopGlow.animForAnimIn, 2, 0.6, -1, 1.1)

CreateAlphaAnim(BannerBottomGlow.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(BannerBottomGlow.animForAnimIn, 2, 0.25, 1, 0.9)
CreateScaleAnim(BannerBottomGlow.animForAnimIn, 1, 0, 0.5, 1, 0.15)
CreateScaleAnim(BannerBottomGlow.animForAnimIn, 2, 0.5, 3.2, 1, 0.9)
CreateAlphaAnim(BannerBottomGlow.animForAnimIn, 2, 0.6, -1, 1.1)

CreateAlphaAnim(BannerMiddleGlow.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(BannerMiddleGlow.animForAnimIn, 2, 0.25, 1, 0.9)
CreateScaleAnim(BannerMiddleGlow.animForAnimIn, 1, 0, 0.5, 1, 0.15)
CreateScaleAnim(BannerMiddleGlow.animForAnimIn, 2, 0.5, 3.2, 1, 0.9)
CreateAlphaAnim(BannerMiddleGlow.animForAnimIn, 2, 0.6, -1, 1.1)

CreateAlphaAnim(Title.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(Title.animForAnimIn, 2, 0.25, 1, 0.2)

CreateAlphaAnim(SubTitle.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(SubTitle.animForAnimIn, 1, 0.25, 1, 0.2)

CreateAlphaAnim(RedFlash.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(RedFlash.animForAnimIn, 2, 0.1, 1)
CreateScaleAnim(RedFlash.animForAnimIn, 1, 0, 2.5, 2.5, 0.15)
CreateScaleAnim(RedFlash.animForAnimIn, 2, 0.25, 0.4, 0.4, nil, "IN")
CreateAlphaAnim(RedFlash.animForAnimIn, 2, 0.5, -1, 0.25)

CreateAlphaAnim(FlashBurst.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(FlashBurst.animForAnimIn, 2, 0.25, 1, 0.25)
CreateScaleAnim(FlashBurst.animForAnimIn, 1, 0, 1, 0.75, 0.15, nil, nil, "LEFT")
CreateScaleAnim(FlashBurst.animForAnimIn, 2, 0.4, 1.25, 1, 0.25, nil, nil, "LEFT")
--CreateTranslationAnim(FlashBurst.animForAnimIn, 1, 0, 0, 0, nil, nil, 0.15)
CreateTranslationAnim(FlashBurst.animForAnimIn, 2, 0.5, 10*bossBannerEffectiveScale, 0, 0.25)
CreateAlphaAnim(FlashBurst.animForAnimIn, 2, 0.4, -1, 0.25)

CreateAlphaAnim(FlashBurstLeft.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(FlashBurstLeft.animForAnimIn, 2, 0.25, 1, 0.25)
CreateScaleAnim(FlashBurstLeft.animForAnimIn, 1, 0, 1, 0.75, 0.15, nil, nil, "RIGHT")
CreateScaleAnim(FlashBurstLeft.animForAnimIn, 2, 0.5, 1.25, 1, 0.25, nil, nil, "RIGHT")
--CreateTranslationAnim(FlashBurstLeft.animForAnimIn, 1, 0, 0, 0, nil, nil, 0.15)
CreateTranslationAnim(FlashBurstLeft.animForAnimIn, 2, 0.5, -10*bossBannerEffectiveScale, 0, 0.25)
CreateAlphaAnim(FlashBurstLeft.animForAnimIn, 2, 0.5, -1, 0.25)

CreateAlphaAnim(FlashBurstCenter.animForAnimIn, 1, 0, -1, nil, nil, 0.15)
CreateAlphaAnim(FlashBurstCenter.animForAnimIn, 2, 0.25, 1, 0.25)
CreateScaleAnim(FlashBurstCenter.animForAnimIn, 1, 0, 1, 1, 0.15)
CreateScaleAnim(FlashBurstCenter.animForAnimIn, 2, 0.5, 1.25, 1.25, 0.25)
CreateAlphaAnim(FlashBurstCenter.animForAnimIn, 2, 0.5, -1, 0.25)

BossBanner.AnimIn = {}
local AnimIn = BossBanner.AnimIn
AnimIn.SkullCircle = SkullCircle.animForAnimIn
AnimIn.BannerTop = BannerTop.animForAnimIn
AnimIn.BannerBottom = BannerBottom.animForAnimIn
AnimIn.BannerMiddle = BannerMiddle.animForAnimIn
AnimIn.BottomFillagree = BottomFillagree.animForAnimIn
AnimIn.SkullSpikes = SkullSpikes.animForAnimIn
AnimIn.RightFillagree = RightFillagree.animForAnimIn
AnimIn.LeftFillagree = LeftFillagree.animForAnimIn
AnimIn.BannerTopGlow = BannerTopGlow.animForAnimIn
AnimIn.BannerBottomGlow = BannerBottomGlow.animForAnimIn
AnimIn.BannerMiddleGlow = BannerMiddleGlow.animForAnimIn
AnimIn.RedFlash = RedFlash.animForAnimIn
AnimIn.FlashBurst = FlashBurst.animForAnimIn
AnimIn.FlashBurstLeft = FlashBurstLeft.animForAnimIn
AnimIn.FlashBurstCenter = FlashBurstCenter.animForAnimIn
AnimIn.Title = Title.animForAnimIn
AnimIn.SubTitle = SubTitle.animForAnimIn

AnimIn.Play = function(self)
	if BossBanner.AnimOut:IsPlaying() then
		BossBanner.AnimOut:Stop()
	end

	LeftFillagree:SetPoint("CENTER", SkullCircle, "CENTER", -10, 6)
	RightFillagree:SetPoint("CENTER", SkullCircle, "CENTER", 10, 6)
	SkullCircle:SetAlpha(1)
	LootCircle:SetAlpha(0)

	for _, anim in pairs(self) do
		if type(anim) == "table" then -- reject functions
			anim:Stop()
			anim:Play()
		end
	end
end

AnimIn.Stop = function(self)
	for _, anim in pairs(self) do
		if type(anim) == "table" then
			anim:Stop()
		end
	end
end

-- AnimationGroup: AnimSwitch
SkullCircle.animForAnimSwitch = SkullCircle:CreateAnimationGroup()
Title.animForAnimSwitch = Title:CreateAnimationGroup()
SubTitle.animForAnimSwitch = SubTitle:CreateAnimationGroup()
LootCircle.animForAnimSwitch = LootCircle:CreateAnimationGroup()

CreateAlphaAnim(SkullCircle.animForAnimSwitch, 1, 0, 1)
CreateAlphaAnim(SkullCircle.animForAnimSwitch, 1, 0.5, -1)

CreateAlphaAnim(Title.animForAnimSwitch, 1, 0, 1)
CreateAlphaAnim(Title.animForAnimSwitch, 1, 0.25, -1)

CreateAlphaAnim(SubTitle.animForAnimSwitch, 1, 0, 1)
CreateAlphaAnim(SubTitle.animForAnimSwitch, 1, 0.25, -1)

CreateAlphaAnim(LootCircle.animForAnimSwitch, 1, 0, 0)
CreateAlphaAnim(LootCircle.animForAnimSwitch, 1, 0.5, 1)

BossBanner.AnimSwitch = {}
local AnimSwitch = BossBanner.AnimSwitch
AnimSwitch.SkullCircle = SkullCircle.animForAnimSwitch
AnimSwitch.Title = Title.animForAnimSwitch
AnimSwitch.SubTitle = SubTitle.animForAnimSwitch
AnimSwitch.LootCircle = LootCircle.animForAnimSwitch

AnimSwitch.Play = function(self)
	-- intended final alpha, and animation will workaround OnFinished alpha bug
	SkullCircle:SetAlpha(0)
	Title:SetAlpha(0)
	SubTitle:SetAlpha(0)
	LootCircle:SetAlpha(1)

	for _, anim in pairs(self) do
		if type(anim) == "table" then
			anim:Stop()
			anim:Play()
		end
	end
end

AnimSwitch.Stop = function(self)
	for _, anim in pairs(self) do
		if type(anim) == "table" then
			anim:Stop()
		end
	end
end

local function BossBanner_OnAnimOutFinished(self) -- moved up from retail source code, to avoid globals
	local banner = self:GetParent()
	banner.animState = nil
	banner.lootShown = 0
	banner:Hide()
	banner:SetHeight(banner.baseHeight)
	-- Disabling all of these SetAlpha due to 3.3.5a animation bug that holds attributes like alpha hostage until AnimationGroup OnFinished ends.
	-- banner.BannerTop:SetAlpha(0)
	-- banner.BannerBottom:SetAlpha(0)
	-- banner.BannerMiddle:SetAlpha(0)
	-- banner.BottomFillagree:SetAlpha(0)
	-- banner.SkullSpikes:SetAlpha(0)
	-- banner.RightFillagree:SetAlpha(0)
	-- banner.LeftFillagree:SetAlpha(0)
	-- banner.Title:SetAlpha(0)
	-- banner.SubTitle:SetAlpha(0)
	-- banner.FlashBurst:SetAlpha(0)
	-- banner.FlashBurstLeft:SetAlpha(0)
	-- banner.FlashBurstCenter:SetAlpha(0)
	-- banner.RedFlash:SetAlpha(0)
	for i = 1, #banner.LootFrames do
		banner.LootFrames[i]:Hide()
	end
	banner:SetHeight(banner.baseHeight)
	TopBannerManager_BannerFinished()
end

-- AnimationGroup: AnimOut
BossBanner.AnimOut = BossBanner:CreateAnimationGroup()
CreateAlphaAnim(BossBanner.AnimOut, 1, 0, 1)
CreateAlphaAnim(BossBanner.AnimOut, 1, 0.5, -1)
BossBanner.AnimOut:SetScript("OnFinished", function(self)
	BossBanner_OnAnimOutFinished(self)
end)

------------------------------------------------------------------
-- https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_FrameXML/BossBannerToast.lua
local function BossBanner_AnimBannerIn(self)
	self.lootShown = 0		-- how many items the UI is displaying
	self.AnimIn:Play()
end

local function BossBanner_AnimKillHold() -- self
	-- nothing here
end

local function BossBanner_AnimSwitch(self, entry)
	if next(self.pendingLoot) then
		-- we have loot
		self.AnimSwitch:Play()
		if DBM.Options.PlayBBSound then
			PlaySoundFile(SOUNDKIT.UI_PERSONAL_LOOT_BANNER)
		end
		entry.duration = 0.5
	else
		entry.duration = 0
	end
end

local function BossBanner_AnimLootExpand(self, entry)
	-- don't need to expand for first item
	if self.lootShown > 0 and self.lootShown < BB_MAX_LOOT and next(self.pendingLoot) then
		entry.duration = BB_EXPAND_TIME
	else
		entry.duration = 0
	end
end

local function SetItemButtonQuality(button, quality)
	if button and button.IconBorder then
		button.IconBorder:SetTexture("Interface\\Addons\\DBM-Core\\textures\\WhiteIconFrame")

		local color = quality and ITEM_QUALITY_COLORS[quality]
		button.IconBorder:SetVertexColor(color.r, color.g, color.b)
	end
end

local colorRarity = {
	["ff9d9d9d"] = 0,	-- Poor
	["ffffffff"] = 1,	-- Common
	["ff1eff00"] = 2,	-- Uncommon
	["ff0070dd"] = 3,	-- Rare
	["ffa335ee"] = 4,	-- Epic
	["ffff8000"] = 5,	-- Legendary
	["ffe6cc80"] = 6,	-- Artifact/Heirloom
}

local function findSetName(text)
    -- Pattern to match (X/Y) at the end of a string
    local pattern = "(.+)%s?%((%d+)/(%d+)%)$"

	local setName, current, total = text:match(pattern)

	if setName then
		return setName:trim(), tonumber(current), tonumber(total)
	end

    return nil  -- Set name not found
end

local itemScanTooltip
local function BossBanner_ConfigureLootFrame(lootFrame, data) -- moved up from retail source code, to avoid globals
	-- data: { itemID = itemID, quantity = quantity, slot = slot, lootSourceName = lootSourceName, itemLink = itemLink, texture = texture }
	local _, itemName, itemRarity, itemTexture, colorString, rarityColor, setName
	itemName, _, itemRarity, _, _, _, _, _, _, itemTexture = GetItemInfo(data.itemLink)

	if not itemTexture then -- uncached item
		DBM:Debug("BossBanner caught an uncached item: " .. data.itemLink)
		-- retrieve itemName and itemRarity from itemLink
		_, _, colorString, _, _, _, _, _, _, _, _, _, _, itemName = strfind(data.itemLink, "|?c?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
		itemRarity = colorRarity[colorString]

		itemTexture = data.texture
	end

	if IsDressableItem(data.itemLink) then -- is gear
		-- retrieve item set through a hidden tooltip
		itemScanTooltip = itemScanTooltip or CreateFrame("GameTooltip", "BossBannerItemScanningTooltip", nil, "GameTooltipTemplate")
		itemScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
		itemScanTooltip:SetHyperlink(data.itemLink)
		for i = 2, itemScanTooltip:NumLines() do
			local text = _G["BossBannerItemScanningTooltipTextLeft"..i]:GetText()
			setName = findSetName(text)
			if setName then
				break
			end
		end
	end

	lootFrame.ItemName:SetText(itemName)
	rarityColor = ITEM_QUALITY_COLORS[itemRarity]
	lootFrame.ItemName:SetTextColor(rarityColor.r, rarityColor.g, rarityColor.b)
	lootFrame.Background:SetVertexColor(rarityColor.r, rarityColor.g, rarityColor.b)
	lootFrame.Icon:SetTexture(itemTexture)

	SetItemButtonQuality(lootFrame.IconHitBox, itemRarity)

	if data.quantity > 1 then
		lootFrame.Count:Show()
		lootFrame.Count:SetText(data.quantity)
	else
		lootFrame.Count:Hide()
	end

	if setName then
		lootFrame.ItemName:ClearAllPoints()
		lootFrame.ItemName:SetPoint("TOPLEFT", 56, -2)
		lootFrame.SetName:SetText(("Set: %s"):format(setName))
		lootFrame.SetName:Show()
		lootFrame.PlayerName:ClearAllPoints()
		lootFrame.PlayerName:SetPoint("TOPLEFT", lootFrame.SetName, "BOTTOMLEFT", 0, 0)
	else
		lootFrame.ItemName:ClearAllPoints()
		lootFrame.ItemName:SetPoint("TOPLEFT", 56, -7)
		lootFrame.SetName:Hide()
		lootFrame.PlayerName:ClearAllPoints()
		lootFrame.PlayerName:SetPoint("TOPLEFT", lootFrame.ItemName, "BOTTOMLEFT", 0, 0)
	end

	lootFrame.PlayerName:SetText(data.lootSourceName) -- Will be used for looted Boss/Treasure Chest name, so replaced data.playerName with a custom value
--	local classColor = RAID_CLASS_COLORS[data.className]
--	lootFrame.PlayerName:SetTextColor(classColor.r, classColor.g, classColor.b)
	lootFrame.itemLink = data.itemLink
end

local function BossBanner_AnimLootInsert(self, entry)
	local key, data = next(self.pendingLoot)
	if key and self.lootShown < BB_MAX_LOOT then
		-- we have an item, show it
		self.pendingLoot[key] = nil
		self.lootShown = self.lootShown + 1
		local lootFrame = self.LootFrames[self.lootShown]
		if not lootFrame then
			lootFrame = createLootFrame(self)
			lootFrame:SetPoint("TOP", self.LootFrames[self.lootShown - 1], "BOTTOM", 0, -6)
		end
		BossBanner_ConfigureLootFrame(lootFrame, data)
		lootFrame:Show()
		lootFrame.Anim:Play()
		-- loop back if more items
		if next(self.pendingLoot) and self.lootShown < BB_MAX_LOOT then
			BossBanner.SetAnimState(self, BB_STATE_LOOT_EXPAND)
			return true
		end
	end
	if self.lootShown > 0 then
		entry.duration = 4
	else
		entry.duration = 0
	end
end

local function BossBanner_AnimBannerOut(self) -- self, entry
	self.AnimOut:Play()
end

local BB_ANIMATION_CONTROL = {
	[BB_STATE_BANNER_IN] =	{ duration = 1.85,	onStartFunc = BossBanner_AnimBannerIn },
	[BB_STATE_KILL_HOLD] =	{ duration = 2,		onStartFunc = BossBanner_AnimKillHold },
	[BB_STATE_SWITCH] =		{ duration = nil,	onStartFunc = BossBanner_AnimSwitch },
	[BB_STATE_LOOT_EXPAND] ={ duration = nil,	onStartFunc = BossBanner_AnimLootExpand },
	[BB_STATE_LOOT_INSERT] ={ duration = nil,	onStartFunc = BossBanner_AnimLootInsert },

	-- The duration for BB_STATE_BANNER_OUT only needs to be longer than the animation time of AnimOut,
	-- which is 0.5 seconds. BossBanner_OnAnimOutFinished will then preempt the state machine and end the animation.
	[BB_STATE_BANNER_OUT] =	{ duration = 5,	onStartFunc = BossBanner_AnimBannerOut },
}

local function BossBanner_BeginAnims(self, animState)
	BossBanner.SetAnimState(self, animState or BB_STATE_BANNER_IN)
end

function BossBanner.SetAnimState(self, animState)
	local entry = BB_ANIMATION_CONTROL[animState]
	if entry then
		local redirected = entry.onStartFunc(self, entry)
		if not redirected then
			self.animState = animState
			self.animTimeLeft = entry.duration
		end
	else
		self.animState = nil
		self.animTimeLeft = nil
	end
end

local defaultTranslationOffsetsTable = {
	["RightFillagree-From"] = {-37, 0},
	["RightFillagree-To"] = {37, 0},
	["LeftFillagree-From"] = {37, 0},
	["LeftFillagree-To"] = {-37, 0},
--	["FlashBurst-From"] = {0, 0},
	["FlashBurst-To"] = {10, 0},
--	["FlashBurstLeft-From"] = {0, 0},
	["FlashBurstLeft-To"] = {-10, 0},
	["LootFrame-Icon-From"] = {110, 0},
	["LootFrame-Icon-To"] = {-110, 0},
}

local xOffset, yOffset
local function validateOffsets(animation, defaultkey, effectiveScale)
	xOffset, yOffset = animation:GetOffset()
	if round(xOffset, 0) ~= round((defaultTranslationOffsetsTable[defaultkey][1]*effectiveScale), 0) then -- due to inconsistent precision with floats, use round for a preventive measure
		xOffset = defaultTranslationOffsetsTable[defaultkey][1]*effectiveScale
	end
	if round(yOffset, 0) ~= round((defaultTranslationOffsetsTable[defaultkey][2]*effectiveScale), 0) then -- due to inconsistent precision with floats, use round for a preventive measure
		yOffset = defaultTranslationOffsetsTable[defaultkey][2]*effectiveScale
	end

	animation:SetOffset(xOffset, yOffset)
end

local function fixTranslationAnim()
	local effectiveScale = BossBanner:GetEffectiveScale() -- Lootframes inherit from this too, so keep it as is
--	local rightFillagreeTranslationAnimFrom = (select(3, BossBanner.RightFillagree.animForAnimIn:GetAnimations()))
--	local rightFillagreeTranslationAnimTo = (select(4, BossBanner.RightFillagree.animForAnimIn:GetAnimations()))
	local rightFillagreeTranslationAnimTo = (select(3, BossBanner.RightFillagree.animForAnimIn:GetAnimations()))
--	local leftFillagreeTranslationAnimFrom = (select(3, BossBanner.LeftFillagree.animForAnimIn:GetAnimations()))
--	local leftFillagreeTranslationAnimTo = (select(4, BossBanner.LeftFillagree.animForAnimIn:GetAnimations()))
	local leftFillagreeTranslationAnimTo = (select(3, BossBanner.LeftFillagree.animForAnimIn:GetAnimations()))
--	local flashBurstTranslationAnimTo = (select(6, BossBanner.FlashBurst.animForAnimIn:GetAnimations()))
--	local flashBurstLeftTranslationAnimTo = (select(6, BossBanner.FlashBurstLeft.animForAnimIn:GetAnimations()))
	local flashBurstTranslationAnimTo = (select(5, BossBanner.FlashBurst.animForAnimIn:GetAnimations()))
	local flashBurstLeftTranslationAnimTo = (select(5, BossBanner.FlashBurstLeft.animForAnimIn:GetAnimations()))

	local lootFrameIconTranslationAnimFrom, lootFrameIconTranslationAnimTo

--	validateOffsets(rightFillagreeTranslationAnimFrom, "RightFillagree-From", effectiveScale)
	validateOffsets(rightFillagreeTranslationAnimTo, "RightFillagree-To", effectiveScale)
--	validateOffsets(leftFillagreeTranslationAnimFrom, "LeftFillagree-From", effectiveScale)
	validateOffsets(leftFillagreeTranslationAnimTo, "LeftFillagree-To", effectiveScale)
	validateOffsets(flashBurstTranslationAnimTo, "FlashBurst-To", effectiveScale)
	validateOffsets(flashBurstLeftTranslationAnimTo, "FlashBurstLeft-To", effectiveScale)

	for _, lootFrame in ipairs(BossBanner.LootFrames) do
		lootFrameIconTranslationAnimFrom, lootFrameIconTranslationAnimTo = select(3, lootFrame.Icon.animForAnim:GetAnimations())
		validateOffsets(lootFrameIconTranslationAnimFrom, "LootFrame-Icon-From", effectiveScale)
		validateOffsets(lootFrameIconTranslationAnimTo, "LootFrame-Icon-To", effectiveScale)

		lootFrameIconTranslationAnimFrom, lootFrameIconTranslationAnimTo = lootFrame.IconHitBox.animForAnim:GetAnimations()
		validateOffsets(lootFrameIconTranslationAnimFrom, "LootFrame-Icon-From", effectiveScale)
		validateOffsets(lootFrameIconTranslationAnimTo, "LootFrame-Icon-To", effectiveScale)
	end
end

local function BossBanner_Play(self, data)
	if data then
		fixTranslationAnim()
		if data.mode == "KILL" then
			self.Title:SetAlpha(1)
			self.SubTitle:SetAlpha(1)
			self.Title:SetText(data.name)
			self.SubTitle:Show()
			self.Title:Show()
			self:Show()
			self.encounterID = data.encounterID
			self.encounterName = data.name
			BossBanner_BeginAnims(self)
			if DBM.Options.PlayBBSound then
				PlaySoundFile(SOUNDKIT.UI_RAID_BOSS_DEFEATED)
			end
		elseif data.mode == "LOOT" then
			self.BannerTop:SetAlpha(1)
			self.BannerBottom:SetAlpha(1)
			self.BannerMiddle:SetAlpha(1)
			self.RightFillagree:SetAlpha(1)
			self.LeftFillagree:SetAlpha(1)
			self.BottomFillagree:SetAlpha(1)
			self.SkullSpikes:SetAlpha(1)
			self.SkullCircle:SetAlpha(0)
			self.LootCircle:SetAlpha(1)
			self.Title:Hide()
			self.SubTitle:Hide()
			self:Show()
			BossBanner_BeginAnims(self, BB_STATE_LOOT_EXPAND)
			if DBM.Options.PlayBBSound then
				PlaySoundFile(SOUNDKIT.UI_PERSONAL_LOOT_BANNER)
			end
		end
	end
end

local function BossBanner_Stop(self)
	self.AnimIn:Stop()
	self.AnimSwitch:Stop()
	self.AnimOut:Stop()
	self:Hide()
end

local function BossBanner_IsExclusiveQueued() -- moved up from retail source code, to avoid globals
	return true
end


function BossBanner:OnEvent(event, ...)
	if not DBM.Options.EnableBB then return end
	DBM:Debug("DBM BossBanner:OnEvent called with the following args--> event: "..event..", vararg: "..tconcat({...}, ", "), 3)
	if event == "BOSS_KILL" then
		wipe(self.pendingLoot)
		local encounterID, name = ...
		TopBannerManager_Show(self, { encounterID = encounterID, name = name, mode = "KILL" }, BossBanner_IsExclusiveQueued)
		DBM:Unschedule(BossBanner.ClearEncounterCache)
		DBM:Schedule(150, BossBanner.ClearEncounterCache, BossBanner)
	elseif event == "ENCOUNTER_LOOT_RECEIVED" and DBM.Options.PlayBBLoot then -- encounterId, itemID, itemLink, quantity, slot, texture, lootSourceName, lootSourceGUID
		local encounterID, itemID, itemLink, quantity, slot, texture, lootSourceName = ...
		-- local _, instanceType = GetInstanceInfo()
		if encounterID == self.encounterID --[[and (instanceType == "party" or instanceType == "raid")]] then
			-- add loot to pending list
			local data = { itemID = itemID, quantity = quantity, slot = slot, lootSourceName = lootSourceName, itemLink = itemLink, texture = texture } -- added texture to circumvent uncached items
			tinsert(self.pendingLoot, data)
			-- check state
			if ( self.animState == BB_STATE_LOOT_INSERT and self.lootShown < BB_MAX_LOOT ) then
				-- show it now
				BossBanner.SetAnimState(self, BB_STATE_LOOT_EXPAND)
			elseif ( not self.animState and self.lootShown == 0 ) then
				-- banner is not displaying and have not done loot for this encounter yet
				-- TODO: animate in kill banner
				TopBannerManager_Show(self, { encounterID = encounterID, name = nil, mode = "LOOT" }, BossBanner_IsExclusiveQueued)
			end
		end
	end
end

local function BossBanner_OnLoad(self)
	self.PlayBanner = BossBanner_Play
	self.StopBanner = BossBanner_Stop
	self:RegisterEvent("LOOT_OPENED")
	self.pendingLoot = {}
	self.baseHeight = self:GetHeight()
end

local function keyPairsConcat(table, separator)
	local array = {}
	for k in pairs(table) do
		tinsert(array, k)
	end
	if not array then return "" end
	return tconcat(array, separator or ", ")
end

local function BossBanner_OnEvent(self, event)
	if event == "LOOT_OPENED" then
		if self.encounterID then
			local encounterBossMod = DBM:GetModByName(self.encounterID)
			-- check if DBM mod exists/is loaded
			if not encounterBossMod then
				DBM:Debug("BossBanner: no mod found for encounter "..tostring(self.encounterID)..". Loot fetching denied.", 3)
				return
			end

			-- check if player is in DBM mod mapID/zone
			local zoneName = GetRealZoneText()
			local mapID = GetCurrentMapAreaID() > 4 and GetCurrentMapAreaID() or GetCurrentMapContinent() -- workaround to support world bosses mod loading
			local encounterBossModMapOrZone = encounterBossMod.zones
			DBM:Debug("BossBanner: Before fetching loot, checking encounter "..tostring(self.encounterID).." zones {"..keyPairsConcat(encounterBossModMapOrZone).."}, for map: "..tostring(mapID).." or zone: "..tostring(zoneName)..". Results are: map-"..tostring(encounterBossModMapOrZone[mapID])..", zone-"..tostring(encounterBossModMapOrZone[zoneName]), 3)
			if not encounterBossModMapOrZone[mapID] and not encounterBossModMapOrZone[zoneName] then
				DBM:Debug("BossBanner: Looting outside of zone for encounter "..tostring(self.encounterID)..". Loot fetching denied.", 3)
				return
			end
			DBM:Debug("BossBanner: Loot fetching allowed for encounter "..tostring(self.encounterID), 3)
			BossBanner_FetchAndSyncLootItems(self)
		end
	end
end

local function BossBanner_OnUpdate(self, elapsed)
	if not self.animState then
		return
	end
	self.animTimeLeft = self.animTimeLeft - elapsed
	if self.animState == BB_STATE_LOOT_EXPAND then
		local newHeight = self.baseHeight + (self.lootShown * BB_EXPAND_HEIGHT) - (max(self.animTimeLeft, 0) / BB_EXPAND_TIME * BB_EXPAND_HEIGHT)
		self:SetHeight(newHeight)
	elseif self.animState == BB_STATE_LOOT_INSERT and self.showingTooltip then
		-- keep it at 2 seconds left
		self.animTimeLeft = 2
	end
	if ( self.animTimeLeft <= 0 ) then
		BossBanner.SetAnimState(self, self.animState + 1)
		if ( not self.animTimeLeft ) then
			self.animState = nil
		end
	end
end

local function BossBanner_OnMouseDown(...)
	local frame, button = ...
	if button == "RightButton" then
		BossBanner_Stop(frame)
		wipe(frame.pendingLoot) -- prevent pending loot from refiring BossBanner on my workaround in TopBannerManager_BannerFinished
		BossBanner_OnAnimOutFinished(frame.AnimOut) -- passing a children frame of BossBanner to reuse code of self:GetParent, without disrupting the retail diff.
--		TopBannerManager_BannerFinished(frame) -- disabling this since it does not properly cancel the banner, and will cause previous shown loot to populate lootframes. This is a bug that is present on Retail blizzard code. To work around it, fire BossBanner_OnAnimOutFinished instead.
	end
end

BossBanner_OnLoad(BossBanner) -- simulate OnLoad script
BossBanner:SetScript("OnEvent", BossBanner_OnEvent)
BossBanner:SetScript("OnUpdate", BossBanner_OnUpdate)
BossBanner:SetScript("OnMouseDown", BossBanner_OnMouseDown)

function BossBanner:ClearEncounterCache()
	wipe(self.pendingLoot)
	self.encounterID = nil
	DBM:Debug("BossBanner:ClearEncounterCache called", 3)
end

function BossBanner:UpdateStyle()
	if not DBM.Options.OverrideBBFont then return end
	BBfont = DBM.Options.BBFont == "standardFont" and standardFont or DBM.Options.BBFont
	Title:SetFont(BBfont, 30 + DBM.Options.BBFontSize, DBM.Options.BBFontStyle)
	SubTitle:SetFont(BBfont, 16 + DBM.Options.BBFontSize, DBM.Options.BBFontStyle)
	if DBM.Options.BBFontShadow then
		Title:SetShadowOffset(1, -1)
		SubTitle:SetShadowOffset(1, -1)
	else
		Title:SetShadowOffset(0, 0)
		SubTitle:SetShadowOffset(0, 0)
	end

	for _, lootFrame in ipairs(BossBanner.LootFrames) do
		lootFrame.Count:SetFont(BBfont, 14 + DBM.Options.BBFontSize, DBM.Options.BBFontStyle)
		lootFrame.ItemName:SetFont(BBfont, 14 + DBM.Options.BBFontSize, DBM.Options.BBFontStyle)
		lootFrame.SetName:SetFont(BBfont, 12 + DBM.Options.BBFontSize, DBM.Options.BBFontStyle)
		lootFrame.PlayerName:SetFont(BBfont, 12 + DBM.Options.BBFontSize, DBM.Options.BBFontStyle)

		if DBM.Options.BBFontShadow then
			lootFrame.Count:SetShadowOffset(1, -1)
			lootFrame.ItemName:SetShadowOffset(1, -1)
			lootFrame.SetName:SetShadowOffset(1, -1)
			lootFrame.PlayerName:SetShadowOffset(1, -1)
		else
			lootFrame.Count:SetShadowOffset(0, 0)
			lootFrame.ItemName:SetShadowOffset(0, 0)
			lootFrame.SetName:SetShadowOffset(0, 0)
			lootFrame.PlayerName:SetShadowOffset(0, 0)
		end
	end
end

function BossBanner:Test(mode)
	if mode == "KILL" then
		-- self:OnEvent("BOSS_KILL", "TestMod", "DBM Boss Test") -- goes into queue manager, so not great for testing
		BossBanner_Play(self, { encounterID = "TestMod", name = "DBM Test Boss", mode = "KILL" })
	elseif mode == "LOOT" then
		self.encounterID = "TestMod"
		self.encounterName = "DBM Test Boss"
		self.lootShown = 0		-- how many items the UI is displaying

		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 3377, "|cff9d9d9d|Hitem:3377:0:0:0:0:0:0:0:80|h[Canvas Bracers]|h|r", 1, 1, "Interface\\Icons\\INV_Bracer_13","Large Battered Chest", "") -- grey loot (from chest)
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 2770, "|cffffffff|Hitem:2770:0:0:0:0:0:0:0:80|h[Copper Ore]|h|r", 4, 2, "Interface\\Icons\\INV_Ore_Copper_01", "Large Battered Chest", "") -- white loot (from chest), with count
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 2977, "|cff1eff00|Hitem:2977:0:0:0:0:0:0:0:80|h[Veteran Armor]|h|r", 1, 3, "Interface\\Icons\\INV_Chest_Chain_09", "Large Battered Chest", "") -- green loot (from chest)
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 45087, "|cff0070dd|Hitem:45087:0:0:0:0:0:0:0:80|h[Runed Orb]|h|r", 1, 4, "Interface\\Icons\\inv_misc_runedorb_01", "Auriaya", "0xF1300082EB000A6D") -- blue loot (from boss)
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 45857, "|cffa335ee|Hitem:45857:0:0:0:0:0:0:0:80|h[Archivum Data Disc]|h|r", 1, 5, "Interface\\Icons\\INV_Misc_Platnumdisks", "Runemaster Molgeim", "0xF13000809F00091F") -- purple loot (from boss), quest item
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 45466, "|cffa335ee|Hitem:45466:0:0:0:0:0:0:0:80|h[Scale of Fates]|h|r", 1, 6, "Interface\\Icons\\INV_SpiritShard_02", "Cache of Storms", "") -- purple loot (from chest)
--		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 45246, "|cffa335ee|Hitem:45246:0:0:0:0:0:0:0:80|h[Golem-Shard Sticker]|h|r", 1, 7, "Interface\\Icons\\INV_Weapon_Shortblade_78", "XT-002 Deconstructor", "0xF15000820D0001AB#") -- purple loot (from boss)
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 51172, "|cffa335ee|Hitem:51172:0:0:0:0:0:0:0:80|h[Sanctified Lightsworn Handguards]|h|r", 1, 7, "Interface\\Icons\\inv_gauntlets_85", "Toravon the Ice Watcher", "0xF13000962100000F") -- purple loot (from boss), setitem
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 45038, "|cffff8000|Hitem:45038:0:0:0:0:0:0:0:80|h[Fragment of Val'anyr]|h|r", 1, 8, "Interface\\Icons\\INV_Ingot_Titansteel_red", "Cache of Storms", "") -- legendary loot (from chest)
	else
		self:OnEvent("BOSS_KILL", "TestMod", "DBM Boss Test")

		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 3377, "|cff9d9d9d|Hitem:3377:0:0:0:0:0:0:0:80|h[Canvas Bracers]|h|r", 1, 1, "Interface\\Icons\\INV_Bracer_13","Large Battered Chest", "") -- grey loot (from chest)
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 2770, "|cffffffff|Hitem:2770:0:0:0:0:0:0:0:80|h[Copper Ore]|h|r", 4, 2, "Interface\\Icons\\INV_Ore_Copper_01", "Large Battered Chest", "") -- white loot (from chest), with count
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 2977, "|cff1eff00|Hitem:2977:0:0:0:0:0:0:0:80|h[Veteran Armor]|h|r", 1, 3, "Interface\\Icons\\INV_Chest_Chain_09", "Large Battered Chest", "") -- green loot (from chest)
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 45087, "|cff0070dd|Hitem:45087:0:0:0:0:0:0:0:80|h[Runed Orb]|h|r", 1, 4, "Interface\\Icons\\inv_misc_runedorb_01", "Auriaya", "0xF1300082EB000A6D") -- blue loot (from boss)
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 45857, "|cffa335ee|Hitem:45857:0:0:0:0:0:0:0:80|h[Archivum Data Disc]|h|r", 1, 5, "Interface\\Icons\\INV_Misc_Platnumdisks", "Runemaster Molgeim", "0xF13000809F00091F") -- purple loot (from boss), quest item
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 45466, "|cffa335ee|Hitem:45466:0:0:0:0:0:0:0:80|h[Scale of Fates]|h|r", 1, 6, "Interface\\Icons\\INV_SpiritShard_02", "Cache of Storms", "") -- purple loot (from chest)
--		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 45246, "|cffa335ee|Hitem:45246:0:0:0:0:0:0:0:80|h[Golem-Shard Sticker]|h|r", 1, 7, "Interface\\Icons\\INV_Weapon_Shortblade_78", "XT-002 Deconstructor", "0xF15000820D0001AB#") -- purple loot (from boss)
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 51172, "|cffa335ee|Hitem:51172:0:0:0:0:0:0:0:80|h[Sanctified Lightsworn Handguards]|h|r", 1, 7, "Interface\\Icons\\inv_gauntlets_85", "Toravon the Ice Watcher", "0xF13000962100000F") -- purple loot (from boss), setitem
		self:OnEvent("ENCOUNTER_LOOT_RECEIVED", "TestMod", 45038, "|cffff8000|Hitem:45038:0:0:0:0:0:0:0:80|h[Fragment of Val'anyr]|h|r", 1, 8, "Interface\\Icons\\INV_Ingot_Titansteel_red", "Cache of Storms", "") -- legendary loot (from chest)
	end
end
