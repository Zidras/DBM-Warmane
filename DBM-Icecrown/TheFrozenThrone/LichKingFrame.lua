local LichKing	= DBM:GetModByName("LichKing")
local L		= LichKing:GetLocalizedStrings()
local floor = math.floor

function LichKing:InitializeMenu()
--	self is DBMLichKingMenu, not LichKing
	local info = UIDropDownMenu_CreateInfo()
	info.text = L.name
	info.notClickable = 1
	info.isTitle = 1
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info, 1)

	local info1 = UIDropDownMenu_CreateInfo()
	info1.text = L.FrameLock
	info1.value = LichKing.Options.FrameLocked
	info1.func = function() LichKing.Options.FrameLocked = not LichKing.Options.FrameLocked end
	info1.checked = LichKing.Options.FrameLocked
	info1.keepShownOnClick = 1
	UIDropDownMenu_AddButton(info1, 1)

	local info2 = UIDropDownMenu_CreateInfo()
	info2.text = L.FrameClassColor
	info2.value = LichKing.Options.FrameClassColor
	info2.func = function() LichKing.Options.FrameClassColor = not LichKing.Options.FrameClassColor LichKing:UpdateColors() end
	info2.checked = LichKing.Options.FrameClassColor
	info2.keepShownOnClick = 1
	UIDropDownMenu_AddButton(info2, 1)

	local info3 = UIDropDownMenu_CreateInfo()
	info3.text = L.FrameOrientation
	info3.value = LichKing.Options.FrameUpwards
	info3.func = function() LichKing.Options.FrameUpwards = not LichKing.Options.FrameUpwards LichKing:ChangeFrameOrientation() end
	info3.checked = LichKing.Options.FrameUpwards
	info3.keepShownOnClick = 1
	UIDropDownMenu_AddButton(info3, 1)

	local info4 = UIDropDownMenu_CreateInfo()
	info4.text = L.FrameHide
	info4.func = function() DBMLichKingFrameDrag:Hide() end
	info4.notCheckable = 1
	UIDropDownMenu_AddButton(info4, 1)

	local info5 = UIDropDownMenu_CreateInfo()
	info5.text = L.FrameClose
	info5.func = function() end
	info5.notCheckable = 1
	UIDropDownMenu_AddButton(info5, 1)
end

local firstEntry = nil
local lastEntry = nil
local frames = {}

local fCounter = 1
local function createBarFrame(name, grp, rt)
	local frame
	if frames[#frames] then
		frame = frames[#frames]
		frames[#frames] = nil
		frame:Show()
	else
		frame = CreateFrame("Frame", "DBMLichKingFrame"..fCounter, DBMLichKingFrameDrag, "DBMLichKingFrameTemplate")
		fCounter = fCounter + 1
	end
	_G[frame:GetName().."BarName"]:SetText(string.format("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:22:22|t%s (%d)", rt, name, grp))
	return frame
end

local barMethods = {}
local function createBar(name, grp, rt)
	local newEntry = setmetatable({
		prev = lastEntry,
		next = nil,
		data = {
			frame = createBarFrame(name, grp, rt),
			name = name,
			timer = 35
		}
	},
	{
		__index = barMethods
	})
	if lastEntry then
		lastEntry.next = newEntry
	end
	lastEntry = newEntry
	firstEntry = firstEntry or newEntry

	newEntry.data.frame.entry = newEntry
	newEntry:Update(0)

	return newEntry
end

function barMethods:Update(elapsed)
	local bar = _G[self.data.frame:GetName().."Bar"]
	local cooldown = _G[self.data.frame:GetName().."BarCooldown"]
	local spark = _G[self.data.frame:GetName().."BarSpark"]
	self.data.timer = self.data.timer - elapsed
	if self.data.timer <= 0 then
		LichKing:RemoveEntry(self.data.name)
	else
		cooldown:SetText(floor(self.data.timer))
		bar:SetValue(self.data.timer)
		spark:ClearAllPoints()
		spark:SetPoint("CENTER", bar, "LEFT", ((bar:GetValue() / 35) * bar:GetWidth()), 0)
		spark:Show()
	end
end

function barMethods:GetNext()
	return self.next
end

function barMethods:GetPrev()
	return self.prev
end

function barMethods:SetPosition()
	self.data.frame:ClearAllPoints()
	if self == firstEntry then
		if LichKing.Options.FrameUpwards then
			self.data.frame:SetPoint("BOTTOM", DBMLichKingFrameDrag, "TOP", 0, -10)
		else
			self.data.frame:SetPoint("TOP", DBMLichKingFrameDrag, "BOTTOM", 0, 0)
		end
	else
		if LichKing.Options.FrameUpwards then
			self.data.frame:SetPoint("BOTTOM", self:GetPrev().data.frame, "TOP", 0, -3)
		else
			self.data.frame:SetPoint("TOP", self:GetPrev().data.frame, "BOTTOM", 0, 3)
		end
	end
end

function barMethods:GetFrame()
	return self.data.frame
end

function barMethods:GetBar()
	return _G[self.data.frame:GetName().."Bar"]
end

function barMethods:GetSpark()
	return _G[self.data.frame:GetName().."BarSpark"]
end

function LichKing:CreateFrame()
	DBMLichKingFrameDragTitle:SetText(L.FrameTitle)
	if firstEntry then
		local entry = firstEntry
		while entry do
			table.insert(frames, entry.data.frame)
			entry.data.frame:Hide()
			entry.data = nil
			entry = entry:GetNext()
		end
		firstEntry = nil
		lastEntry = nil
	end
	DBMLichKingFrameDrag:Show()
	DBMLichKingFrameDrag:SetPoint(self.Options.PermanentFramePoint or "CENTER", nil, self.Options.PermanentFramePoint or "CENTER", self.Options.PermanentFrameX or 150, self.Options.PermanentFrameY or -50)
end

function LichKing:SaveFramePosition()
	local point, _, _, x, y = DBMLichKingFrameDrag:GetPoint()
	self.Options.PermanentFramePoint = point
	self.Options.PermanentFrameX = x
	self.Options.PermanentFrameY = y
end

function LichKing:DestroyFrame()
	DBMLichKingFrameDrag:Hide()
end

function LichKing:ChangeFrameOrientation()
	if firstEntry then
		local entry = firstEntry
		while entry do
			entry:SetPosition()
			entry = entry:GetNext()
		end
	end
end

function LichKing:UpdateColors()
	if firstEntry then
		local entry = firstEntry
		while entry do
			if self.Options.FrameClassColor then
				local _, _, name = entry.data.name:find("(.+) %(%d%)")
				local class
				for uId in DBM:GetGroupMembers() do
					local name2 = UnitName(uId)
					local _, fileName = UnitClass(uId)
					if name2 == name then
						class = fileName
						break
					end
				end
				local r, g, b = 1, 0.7, 0
				if self.Options.FrameClassColor then
					if RAID_CLASS_COLORS[class or ""] then
						r = RAID_CLASS_COLORS[class].r
						g = RAID_CLASS_COLORS[class].g
						b = RAID_CLASS_COLORS[class].b
					end
				end
				entry:GetBar():SetStatusBarColor(r, g, b)
				entry:GetSpark():SetVertexColor(r, g, b)
			else
				entry:GetBar():SetStatusBarColor(1, 0.7, 0)
				entry:GetSpark():SetVertexColor(1, 0.7, 0)
			end
			entry = entry:GetNext()
		end
	end
end

function LichKing:AddEntry(name, grp, class, rt)
	local entry = createBar(name, grp, rt)
	local r, g, b = 1, 0.7, 0
	if self.Options.FrameClassColor then
		if RAID_CLASS_COLORS[class or ""] then
			r = RAID_CLASS_COLORS[class].r
			g = RAID_CLASS_COLORS[class].g
			b = RAID_CLASS_COLORS[class].b
		end
	end
	entry:GetBar():SetStatusBarColor(r, g, b)
	entry:GetSpark():SetVertexColor(r, g, b)
	entry:SetPosition()
end

function LichKing:RemoveEntry(name)
	if firstEntry then
		local entry = firstEntry
		while entry do
			if entry.data.name == name then
				table.insert(frames, entry.data.frame)
				entry.data.frame:Hide()
				entry.data = nil
				if entry == firstEntry then
					local nextEntry = entry:GetNext()
					if nextEntry then
						nextEntry.prev = nil
						firstEntry = nextEntry
					else
						firstEntry = nil
						lastEntry = nil
					end
				elseif entry == lastEntry then
					local prevEntry = entry:GetPrev()
					if prevEntry then
						prevEntry.next = nil
						lastEntry = prevEntry
					else
						firstEntry = nil
						lastEntry = nil
					end
				else
					entry:GetPrev().next = entry:GetNext()
					entry:GetNext().prev = entry:GetPrev()
				end
				if entry:GetNext() then
					entry:GetNext():SetPosition()
				end
				break
			end
			entry = entry:GetNext()
		end
	end
end
