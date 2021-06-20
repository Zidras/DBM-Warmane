local Kal 	= DBM:GetModByName("Kal")
local L		= Kal:GetLocalizedStrings()

function Kal:InitializeMenu()
	self = Kal -- this function will be called by UIDropDownMenu_Initialize()
	local info = UIDropDownMenu_CreateInfo()
	info.text = L.name
	info.notClickable = 1
	info.isTitle = 1
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info, 1)

	local info1 = UIDropDownMenu_CreateInfo()
	info1.text = L.FrameLock
	info1.value = self.Options.FrameLocked
	info1.func = function() self.Options.FrameLocked = not self.Options.FrameLocked end
	info1.checked = self.Options.FrameLocked
	info1.keepShownOnClick = 1
	UIDropDownMenu_AddButton(info1, 1)

	local info2 = UIDropDownMenu_CreateInfo()
	info2.text = L.FrameClassColor
	info2.value = self.Options.FrameClassColor
	info2.func = function() self.Options.FrameClassColor = not self.Options.FrameClassColor self:UpdateColors() end
	info2.checked = self.Options.FrameClassColor
	info2.keepShownOnClick = 1
	UIDropDownMenu_AddButton(info2, 1)

	local info3 = UIDropDownMenu_CreateInfo()
	info3.text = L.FrameOrientation
	info3.value = self.Options.FrameUpwards
	info3.func = function() self.Options.FrameUpwards = not self.Options.FrameUpwards self:ChangeFrameOrientation() end
	info3.checked = self.Options.FrameUpwards
	info3.keepShownOnClick = 1
	UIDropDownMenu_AddButton(info3, 1)

	local info4 = UIDropDownMenu_CreateInfo()
	info4.text = L.FrameHide
	info4.func = function() DBMKalFrameDrag:Hide() end
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
local function createBarFrame(name)
	local frame
	if frames[#frames] then
		frame = frames[#frames]
		frames[#frames] = nil
		frame:Show()
	else
		frame = CreateFrame("Frame", "DBMKalFrame"..fCounter, DBMKalFrameDrag, "DBMKalFrameTemplate")
		fCounter = fCounter + 1
	end
	_G[frame:GetName().."BarName"]:SetText(name)
	return frame
end

local barMethods = {}
local function createBar(name)
	local newEntry = setmetatable({
		prev = lastEntry,
		next = nil,
		data = {
			frame = createBarFrame(name),
			name = name,
			timer = 60
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
		Kal:RemoveEntry(self.data.name)
	else
		cooldown:SetText(math.floor(self.data.timer))
		bar:SetValue(self.data.timer)
		spark:ClearAllPoints()
		spark:SetPoint("CENTER", bar, "LEFT", ((bar:GetValue() / 60) * bar:GetWidth()), 0)
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
		if Kal.Options.FrameUpwards then
			self.data.frame:SetPoint("BOTTOM", DBMKalFrameDrag, "TOP", 0, -10)
		else
			self.data.frame:SetPoint("TOP", DBMKalFrameDrag, "BOTTOM", 0, 0)
		end
	else
		if Kal.Options.FrameUpwards then
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

function Kal:CreateFrame()
	DBMKalFrameDragTitle:SetText(L.FrameTitle)
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
	DBMKalFrameDrag:Show()
	if self.Options.FramePoint then
		DBMKalFrameDrag:SetPoint(self.Options.FramePoint, nil, self.Options.FramePoint, self.Options.FrameX, self.Options.FrameY)
	end
end

function Kal:SaveFramePosition()
	local point, _, _, x, y = DBMKalFrameDrag:GetPoint()
	self.Options.FramePoint = point
	self.Options.FrameX = x
	self.Options.FrameY = y
end

function Kal:DestroyFrame()
	DBMKalFrameDrag:Hide()
end

function Kal:ChangeFrameOrientation()
	if firstEntry then
		local entry = firstEntry
		while entry do
			entry:SetPosition()
			entry = entry:GetNext()
		end
	end
end

function Kal:UpdateColors()
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

function Kal:AddEntry(name, class)
	local entry = createBar(name)
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

function Kal:RemoveEntry(name)
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
