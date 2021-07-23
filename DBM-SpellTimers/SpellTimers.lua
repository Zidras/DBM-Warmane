-- **********************************************************
-- **             Deadly Boss Mods - SpellsUsed            **
-- **             http://www.deadlybossmods.com            **
-- **********************************************************
--
-- This addon is written and copyrighted by:
--    * Martin Verges (Nitram @ EU-Azshara)
--    * Paul Emmerich (Tandanu @ EU-Aegwynn)
--
-- The localizations are written by:
--    * enGB/enUS: Nitram/Tandanu        http://www.deadlybossmods.com
--    * deDE: Nitram/Tandanu             http://www.deadlybossmods.com
--    * zhCN: yleaf(yaroot@gmail.com)
--    * zhTW: yleaf(yaroot@gmail.com)/Juha
--    * koKR: BlueNyx(bluenyx@gmail.com)
--    * esES: Interplay/1nn7erpLaY       http://www.1nn7erpLaY.com
--
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
--
--  You are free:
--    * to Share  to copy, distribute, display, and perform the work
--    * to Remix  to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--

local Revision = ("$Revision: 55 $"):sub(12, -3)

local default_bartext = "%spell: %player"
local default_bartextwtarget = "%spell: %player on %target"	-- Added by Florin Patan
local default_settings = {
	enabled = false,
	showlocal = true,
	only_from_raid = true,
	active_in_pvp = true,
	own_bargroup = false,
	show_portal = true,
	spells = {
		{ spell = 6346, bartext = default_bartext, cooldown = 180 },	-- Priest: Fear Ward
		{ spell = 1161, bartext = default_bartext, cooldown = 180 },	-- Warrior: Challenging Shout (AE Taunt)
		{ spell = 871, bartext = "%spell on %player", cooldown = 12 },	-- Warrior: Shieldwall Duration (for Healers to see how long cooldown runs)
		{ spell = 12975, bartext = "%spell on %player", cooldown = 20 },-- Warrior: Last Stand Duration (for Healers to see how long cooldown runs)
		{ spell = 48792, bartext = "%spell on %player", cooldown = 12 },-- Death Knight: Icebound Fortitude Duration (for Healers to see how long cooldown runs)
		{ spell = 498, bartext = "%spell on %player", cooldown = 12 },	-- Paladin: Divine Protection Duration (for Healers to see how long cooldown runs)
		{ spell = 61336, bartext = "%spell on %player", cooldown = 20 },-- Druid: Survival Instincts Duration (for Healers to see how long cooldown runs)
		{ spell = 48477, bartext = default_bartext, cooldown = 600 },	-- Druid: Rebirth (Rank 7)
		{ spell = 29166, bartext = default_bartext, cooldown = 180 },	-- Druid: Innervate
		{ spell = 5209, bartext = default_bartext, cooldown = 180 }, 	-- Druid: Challenging Roar (AE Taunt)
		{ spell = 33206, bartext = "%spell on %target", cooldown = 8 }, -- Priest: Pain Suppression Duration (for Healers to see how long cooldown runs)
		{ spell = 6940, bartext = "%spell on %target", cooldown = 12 }, -- Paladin: Hand of Sacrifice Duration (for Healers to see how long cooldown runs)
		{ spell = 64205, bartext = default_bartext, cooldown = 10 },	-- Paladin: Divine Sacrifice Duration (for Healers to see how long cooldown runs)
		{ spell = 34477, bartext = default_bartext, cooldown = 30 },	-- Hunter: Missdirect
		{ spell = 57934, bartext = default_bartext, cooldown = 30 },	-- Rogue: Tricks of the Trade
		{ spell = 32182, bartext = default_bartext, cooldown = 300 },	-- Shaman: Heroism (alliance)
		{ spell = 2825, bartext = default_bartext, cooldown = 300 },	-- Shaman: Bloodlust (horde)
		{ spell = 20608, bartext = default_bartext, cooldown = 1800 },	-- Shaman: Reincarnation
		{ spell = 22700, bartext = default_bartext, cooldown = 600 }, 	-- Field Repair Bot 74A
		{ spell = 44389, bartext = default_bartext, cooldown = 600 }, 	-- Field Repair Bot 110G
		{ spell = 54711, bartext = default_bartext, cooldown = 300 }, 	-- Scrapbot Construction Kit
		{ spell = 67826, bartext = default_bartext, cooldown = 600 }, 	-- Jeeves

	},
	portal_alliance = {
		{ spell = 53142, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dalaran
		{ spell = 33691, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Shattrath (Alliance)
		{ spell = 11416, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Ironforge
		{ spell = 10059, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Stormwind
		{ spell = 49360, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Theramore
		{ spell = 11419, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Darnassus
		{ spell = 32266, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Exodar
	},
	portal_horde = {
		{ spell = 53142, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dalaran
		{ spell = 35717, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Shattrath (Horde)
		{ spell = 11417, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Orgrimmar
		{ spell = 11418, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Undercity
		{ spell = 11420, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Thunder Bluff
		{ spell = 32667, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Silvermoon
		{ spell = 49361, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Stonard
	}
}
DBM_SpellTimers_Settings = {}
local settings = default_settings

local L = DBM_SpellsUsed_Translations

local SpellBars
local SpellBarIndex = {}
local SpellIDIndex = {}
local function rebuildSpellIDIndex()
  SpellIDIndex = {}
	for k,v in pairs(settings.spells) do
	  if v.spell then
	    SpellIDIndex[v.spell] = k
	  end
	end
end

-- functions
local addDefaultOptions, clearAllSpellBars
do
	local function creategui()
		local createnewentry
		local CurCount = 0
		local panel = DBM_GUI:CreateNewPanel(L.TabCategory_SpellsUsed, "option")
		local generalarea = panel:CreateArea(L.AreaGeneral, nil, 150, true)
		local auraarea = panel:CreateArea(L.AreaAuras, nil, 20, true)

		local function regenerate()
			-- FIXME here we can reuse the frames to save some memory (if the player deletes entries)
			for i=select("#", auraarea.frame:GetChildren()), 1, -1 do
				local v = select(i, auraarea.frame:GetChildren())
				v:Hide()
				v:SetParent(UIParent)
				v:ClearAllPoints()
			end
			auraarea.frame:SetHeight(20)
			CurCount = 0

			if #settings.spells == 0 then
				createnewentry()
			else
				for i=1, #settings.spells, 1 do
					createnewentry()
				end
			end
		end


		do
			local area = generalarea
			local enabled = area:CreateCheckButton(L.Enabled, true)
			enabled:SetScript("OnShow", function(self) self:SetChecked(settings.enabled) end)
			enabled:SetScript("OnClick", function(self) settings.enabled = not not self:GetChecked() end)

			local showlocal = area:CreateCheckButton(L.ShowLocalMessage, true)
			showlocal:SetScript("OnShow", function(self) self:SetChecked(settings.showlocal) end)
			showlocal:SetScript("OnClick", function(self) settings.showlocal = not not self:GetChecked() end)

			local showinraid = area:CreateCheckButton(L.OnlyFromRaid, true)
			showinraid:SetScript("OnShow", function(self) self:SetChecked(settings.only_from_raid) end)
			showinraid:SetScript("OnClick", function(self) settings.only_from_raid = not not self:GetChecked() end)

			local showinpvp = area:CreateCheckButton(L.EnableInPVP, true)
			showinpvp:SetScript("OnShow", function(self) self:SetChecked(settings.active_in_pvp) end)
			showinpvp:SetScript("OnClick", function(self) settings.active_in_pvp = not not self:GetChecked() end)

			local show_portal = area:CreateCheckButton(L.EnablePortals, true)
			show_portal:SetScript("OnShow", function(self) self:SetChecked(settings.show_portal) end)
			show_portal:SetScript("OnClick", function(self) settings.show_portal = not not self:GetChecked() end)

			local resetbttn = area:CreateButton(L.Reset, 140, 20)
			resetbttn:SetPoint("TOPRIGHT", area.frame, "TOPRIGHT", -15, -15)
			resetbttn:SetScript("OnClick", function(self)
				table.wipe(DBM_SpellTimers_Settings)
				addDefaultOptions(settings, default_settings)
				for k,v in pairs(settings.spells) do
					if v.enabled == nil then
						v.enabled = true
					end
				end
				regenerate()
				DBM_GUI_OptionsFrame:DisplayFrame(panel.frame)
			end)

			local version = area:CreateText("r"..Revision, nil, nil, GameFontDisableSmall, "RIGHT")
			version:SetPoint("BOTTOMRIGHT", area.frame, "BOTTOMRIGHT", -5, 5)
		end
		do
			local function onchange_spell(field)
				return function(self)
					settings.spells[self.guikey] = settings.spells[self.guikey] or {}
					if field == "spell" then
						settings.spells[self.guikey][field] = self:GetNumber()
						rebuildSpellIDIndex()
					elseif field == "cooldown" then
						settings.spells[self.guikey][field] = self:GetNumber()
					elseif field == "enabled" then
						settings.spells[self.guikey].enabled = not not self:GetChecked()
					else
						settings.spells[self.guikey][field] = self:GetText()
					end
				end
			end
			local function onshow_spell(field)
				return function(self)
					settings.spells[self.guikey] = settings.spells[self.guikey] or {}
					if field == "bartext" and settings.spells[self.guikey].spell and settings.spells[self.guikey].spell > 0 then
						local text = settings.spells[self.guikey][field] or ""
						local spellinfo = GetSpellInfo(settings.spells[self.guikey].spell)
						if spellinfo == nil then
							DBM:AddMsg("Illegal SpellID found. Please remove the Spell "..settings.spells[self.guikey].spell.." from your DBM Options GUI (spelltimers)");
						else
							self:SetText( string.gsub(text, "%%spell", spellinfo) )
						end
					elseif field == "enabled" then
						self:SetChecked( settings.spells[self.guikey].enabled )
					else
						self:SetText( settings.spells[self.guikey][field] or "" )
					end
				end
			end

			local area = auraarea

			local getadditionalid = CreateFrame("Button", "GetAdditionalID_Pull", area.frame)
			getadditionalid:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP");
			getadditionalid:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-DOWN");
			getadditionalid:SetWidth(15)
			getadditionalid:SetHeight(15)

			function createnewentry()
				CurCount = CurCount + 1
				local spellid = area:CreateEditBox(L.SpellID, "", 75)
				spellid.guikey = CurCount
				spellid:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 40, 15-(CurCount*35))
				spellid:SetScript("OnTextChanged", onchange_spell("spell"))
				spellid:SetScript("OnShow", onshow_spell("spell"))
				spellid:SetNumeric(true)

				local bartext = area:CreateEditBox(L.BarText, "", 245)
				bartext.guikey = CurCount
				bartext:SetPoint('TOPLEFT', spellid, "TOPRIGHT", 20, 0)
				bartext:SetScript("OnTextChanged", onchange_spell("bartext"))
				bartext:SetScript("OnShow", onshow_spell("bartext"))

				local cooldown = area:CreateEditBox(L.Cooldown, "", 45)
				cooldown.guikey = CurCount
				cooldown:SetPoint("TOPLEFT", bartext, "TOPRIGHT", 20, 0)
				cooldown:SetScript("OnTextChanged", onchange_spell("cooldown"))
				cooldown:SetScript("OnShow", onshow_spell("cooldown"))
				cooldown:SetNumeric(true)

				local enableit = area:CreateCheckButton("")
				enableit.guikey = CurCount
				enableit:SetScript("OnShow", onshow_spell("enabled"))
				enableit:SetScript("OnClick", onchange_spell("enabled"))
				enableit:SetPoint("LEFT", cooldown, "RIGHT", 5, 0)

				getadditionalid:ClearAllPoints()
				getadditionalid:SetPoint("RIGHT", spellid, "LEFT", -15, 0)
				area.frame:SetHeight( area.frame:GetHeight() + 35 )
				area.frame:GetParent():SetHeight( area.frame:GetParent():GetHeight() + 35 )

				panel:SetMyOwnHeight()
				if DBM_GUI_OptionsFramePanelContainer.displayedFrame and CurCount > 1 then
					DBM_GUI_OptionsFrame:DisplayFrame(panel.frame)
				end

				getadditionalid:SetScript("OnClick", function()
					if spellid:GetNumber() > 0 and bartext:GetText():len() > 0 and cooldown:GetNumber() > 0 then
						createnewentry()
					else
						DBM:AddMsg(L.Error_FillUp)
					end
				end)
			end

			if #settings.spells == 0 then
				createnewentry()
			else
				for i=1, #settings.spells, 1 do
					createnewentry()
				end
			end
		end
		panel:SetMyOwnHeight()
	end
	DBM:RegisterOnGuiLoadCallback(creategui, 19)
end


do
	function addDefaultOptions(t1, t2)
		for i, v in pairs(t2) do
			if t1[i] == nil then
				t1[i] = v
			elseif type(v) == "table" then
				addDefaultOptions(v, t2[i])
			end
		end
	end

	function clearAllSpellBars()
		for k,v in pairs(SpellBarIndex) do
			SpellBars:CancelBar(k)
			SpellBarIndex[k] = nil
		end
	end

	local myportals = {}
	local lastmsg = "";
	local mainframe = CreateFrame("frame", "DBM_SpellTimers", UIParent)
	local spellEvents = {
		["SPELL_CAST_SUCCESS"] = true,
		["SPELL_RESURRECT"] = true,
		["SPELL_HEAL"] = true,
		["SPELL_AURA_APPLIED"] = true,
		["SPELL_AURA_REFRESH"] = true,
	}
	mainframe:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-SpellTimers" then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			self:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")

			-- Update settings of this Addon
			settings = DBM_SpellTimers_Settings
			addDefaultOptions(settings, default_settings)

			-- CreateBarObject
			--[[ hmm, damm mass options. this sucks!
			if settings.own_bargroup then
				SpellBars = DBT:New()
				print_t(SpellBars.options)
				addDefaultOptions(SpellBars.options, DBM.Bars.options)
			else
				SpellBars = DBM.Bars
			end --]]
			SpellBars = DBM.Bars


			if UnitFactionGroup("player") == "Alliance" then
				myportals = settings.portal_alliance
			else
				myportals = settings.portal_horde
			end

			for k,v in pairs(settings.spells) do
				if v.enabled == nil then
					v.enabled = true
				end
			end

			rebuildSpellIDIndex()

		elseif settings.enabled and event == "COMBAT_LOG_EVENT_UNFILTERED" and spellEvents[select(2, ...)] then
			-- first some exeptions (we don't want to see any skill around the world)
			if settings.only_from_raid and not DBM:IsInRaid() then return end
			if not settings.active_in_pvp and (select(2, IsInInstance()) == "pvp") then return end

			local fromplayer = select(4, ...)
			local toplayer = select(7, ...)		-- Added by Florin Patan
			local spellid = select(9, ...)

			-- now we filter if cast is from outside raidgrp (we don't want to see mass spam in Dalaran/...)
			if settings.only_from_raid and not DBM:GetRaidUnitId(fromplayer) then return end

			local guikey = SpellIDIndex[spellid]
			local v = (guikey and settings.spells[guikey])
			if v and v.enabled == true then
				if v.spell ~= spellid then
					print("DBM-SpellTimers Index mismatch error! "..guikey.." "..spellid)
				end

				local spellinfo, _, icon = GetSpellInfo(spellid)
				local bartext = v.bartext:gsub("%%spell", spellinfo):gsub("%%player", fromplayer):gsub("%%target", toplayer)	-- Changed by Florin Patan
				if (spellid == 34477 or spellid == 57934) and (fromplayer == toplayer) then
					return
				end
				SpellBarIndex[bartext] = SpellBars:CreateBar(v.cooldown, bartext, icon, nil, true)

				if settings.showlocal then
					local msg =  L.Local_CastMessage:format(bartext)
					if not lastmsg or lastmsg ~= msg then
						DBM:AddMsg(msg)
						lastmsg = msg
					end
				end
			end

		elseif settings.enabled and event == "COMBAT_LOG_EVENT_UNFILTERED" and settings.show_portal and select(2, ...) == "SPELL_CREATE" then
			if settings.only_from_raid and not DBM:IsInRaid() then return end

			local fromplayer = select(4, ...)
			local toplayer = select(7, ...)		-- Added by Florin Patan
			local spellid = select(9, ...)

			if settings.only_from_raid and not DBM:GetRaidUnitId(fromplayer) then return end

			for k,v in pairs(myportals) do
				if v.spell == spellid then
					local spellinfo, _, icon = GetSpellInfo(spellid)
					local bartext = v.bartext:gsub("%%spell", spellinfo):gsub("%%player", fromplayer):gsub("%%target", toplayer)	-- Changed by Florin Patan
					SpellBarIndex[bartext] = SpellBars:CreateBar(v.cooldown, bartext, icon, nil, true)

					if settings.showlocal then
						DBM:AddMsg( L.Local_CastMessage:format(bartext) )
					end
				end
			end
		elseif settings.enabled and event == "PLAYER_ENTERING_BATTLEGROUND" then
		  -- spell cooldowns all reset on entering an arena or bg
		  clearAllSpellBars()
		end
	end)
	mainframe:RegisterEvent("ADDON_LOADED")
end

