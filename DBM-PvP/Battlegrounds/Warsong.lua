local mod	= DBM:NewMod("z444", "DBM-PvP", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20200405141240")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_REGEN_ENABLED",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"UPDATE_BATTLEFIELD_SCORE"
)
mod:RemoveOption("HealthFrame")

local locale = GetLocale()

local bgzone = false
local FlagCarrier = {
	[1] = nil,
	[2] = nil
}

local startTimer	= mod:NewTimer(62, "TimerStart")
local flagTimer		= mod:NewTimer(23, "TimerFlag", "Interface\\Icons\\INV_Banner_02")

mod:AddBoolOption("ShowFlagCarrier", true, nil, function()
	if mod.Options.ShowFlagCarrier and bgzone then
		mod:ShowFlagCarrier()
	else
		mod:HideFlagCarrier()
	end
end)
mod:AddBoolOption("ShowFlagCarrierErrorNote", false)

do
	function mod:OnInitialize()
		if select(2, IsInInstance()) == "pvp" and GetRealZoneText() == L.ZoneName then
			bgzone = true
			if self.Options.ShowFlagCarrier then
				self:ShowFlagCarrier()
				self:CreateFlagCarrierButton()
				if self.FlagCarrierFrame1Text then -- check for nil error? ebal ety igry btw
					self.FlagCarrierFrame1Text:SetText("")
					self.FlagCarrierFrame2Text:SetText("")
				end
			end

			FlagCarrier[1] = nil
			FlagCarrier[2] = nil

		elseif bgzone then
			bgzone = false
			if self.Options.ShowFlagCarrier then
				self:HideFlagCarrier()
			end
		end
	end
end

function mod:ZONE_CHANGED_NEW_AREA()
	self:ScheduleMethod(8, "OnInitialize")
end

function mod:CHAT_MSG_BG_SYSTEM_NEUTRAL(arg1)
	if not bgzone then return end
	if arg1 == L.BgStart60 then
		startTimer:Start()
	elseif arg1 == L.BgStart30  then
		startTimer:Update(31, 62)
	end
end

function mod:ShowFlagCarrier()
	if not self.Options.ShowFlagCarrier then return end
	if WorldStateTopCenterFrame then
		if not self.FlagCarrierFrame1 then
			self.FlagCarrierFrame1 = CreateFrame("Frame", nil, WorldStateTopCenterFrame.LeftBar.Container)
			self.FlagCarrierFrame1:SetHeight(10)
			self.FlagCarrierFrame1:SetWidth(100)
			self.FlagCarrierFrame1:SetPoint("RIGHT", WorldStateTopCenterFrame.LeftBar.Container, -24, 0)
			self.FlagCarrierFrame1Text = self.FlagCarrierFrame1:CreateFontString(nil, nil, "GameFontNormal")
			self.FlagCarrierFrame1Text:SetAllPoints(self.FlagCarrierFrame1)
			self.FlagCarrierFrame1Text:SetJustifyH("RIGHT")
		end
		if not self.FlagCarrierFrame2 then
			self.FlagCarrierFrame2 = CreateFrame("Frame", nil, WorldStateTopCenterFrame.RightBar.Container)
			self.FlagCarrierFrame2:SetHeight(10)
			self.FlagCarrierFrame2:SetWidth(100)
			self.FlagCarrierFrame2:SetPoint("LEFT", WorldStateTopCenterFrame.RightBar.Container, 24, 0)
			self.FlagCarrierFrame2Text= self.FlagCarrierFrame2:CreateFontString(nil, nil, "GameFontNormal")
			self.FlagCarrierFrame2Text:SetAllPoints(self.FlagCarrierFrame2)
			self.FlagCarrierFrame2Text:SetJustifyH("LEFT")
		end
		self.FlagCarrierFrame1:Show()
		self.FlagCarrierFrame2:Show()
	end
end

function mod:CreateFlagCarrierButton()
	if not self.Options.ShowFlagCarrier then return end
	if not WorldStateTopCenterFrame then return end
	if not self.FlagCarrierFrame1Button then
		self.FlagCarrierFrame1Button = CreateFrame("Button", nil, nil, "SecureActionButtonTemplate")
		self.FlagCarrierFrame1Button:SetFrameStrata("HIGH")
		self.FlagCarrierFrame1Button:SetHeight(15)
		self.FlagCarrierFrame1Button:SetWidth(150)
		self.FlagCarrierFrame1Button:SetAttribute("type", "macro")
		self.FlagCarrierFrame1Button:SetPoint("RIGHT", WorldStateTopCenterFrame.LeftBar.Container, -12, 0)
	end
	if not self.FlagCarrierFrame2Button then
		self.FlagCarrierFrame2Button = CreateFrame("Button", nil, nil, "SecureActionButtonTemplate")
		self.FlagCarrierFrame2Button:SetFrameStrata("HIGH")
		self.FlagCarrierFrame2Button:SetHeight(15)
		self.FlagCarrierFrame2Button:SetWidth(150)
		self.FlagCarrierFrame2Button:SetAttribute("type", "macro")
		self.FlagCarrierFrame2Button:SetPoint("LEFT", WorldStateTopCenterFrame.RightBar.Container, 12, 0)
	end
	self.FlagCarrierFrame1Button:Show()
	self.FlagCarrierFrame2Button:Show()
end

function mod:HideFlagCarrier()
	if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
		self.FlagCarrierFrame1:Hide()
		self.FlagCarrierFrame2:Hide()
		FlagCarrier[1] = nil
		FlagCarrier[2] = nil
	end
end

function mod:CheckFlagCarrier()
	if not UnitAffectingCombat("player") then
		if FlagCarrier[1] and self.FlagCarrierFrame1 then
			self.FlagCarrierFrame1Button:SetAttribute("macrotext", "/targetexact " .. FlagCarrier[1])
		end
		if FlagCarrier[2] and self.FlagCarrierFrame2 then
			self.FlagCarrierFrame2Button:SetAttribute("macrotext", "/targetexact " .. FlagCarrier[2])
		end
	end
end

do
	local lastCarrier
	function mod:ColorFlagCarrier(carrier)
		local found = false
		for i = 1, GetNumBattlefieldScores() do
			local name, _, _, _, _, faction, _, _, _, class = GetBattlefieldScore(i)
			if (name and class and RAID_CLASS_COLORS[class]) then
				if string.match( name, "-" )  then
					name = string.match(name, "([^%-]+)%-.+")
				end
				if name == carrier then
					if faction == 0 then
						self.FlagCarrierFrame2Text:SetTextColor(RAID_CLASS_COLORS[class].r,
											RAID_CLASS_COLORS[class].g,
											RAID_CLASS_COLORS[class].b)
					elseif faction == 1 then
						self.FlagCarrierFrame1Text:SetTextColor(RAID_CLASS_COLORS[class].r,
											RAID_CLASS_COLORS[class].g,
											RAID_CLASS_COLORS[class].b)
					end
					found = true
				end
			end
		end
		if not found then
			RequestBattlefieldScoreData()
			lastCarrier = carrier
		end
	end

	function mod:UPDATE_BATTLEFIELD_SCORE()
		if lastCarrier then
			self:ColorFlagCarrier(lastCarrier)
			lastCarrier = nil
		end
	end
end

function mod:PLAYER_REGEN_ENABLED()
	if bgzone then
		self:CheckFlagCarrier()
	end
end

do
	local function updateflagcarrier(self, event, arg1)
		if not self.Options.ShowFlagCarrier then return end
		if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
			if string.match(arg1, L.ExprFlagPickUp) or (locale == "ruRU" and string.match(arg1, L.ExprFlagPickUp2)) then
				local sArg1, sArg2
				local mSide, mNick
				if locale == "ruRU" and string.match(arg1, L.ExprFlagPickUp2) then
					sArg1, sArg2 = string.match(arg1, L.ExprFlagPickUp2)
				else
					local sArg3, sArg4
					sArg1, sArg2 = string.match(arg1, L.ExprFlagPickUp)

					if locale == "ruRU" then
						sArg3 = sArg1
						sArg4 = sArg2
						sArg1 = sArg4
						sArg2 = sArg3
					end
				end

				mSide = sArg1
				mNick = sArg2

				if mSide == L.Alliance then
					FlagCarrier[2] = mNick
					self.FlagCarrierFrame2Text:SetText(mNick)
					self.FlagCarrierFrame2:Show()
					self:ColorFlagCarrier(mNick)
					if UnitAffectingCombat("player") then
						if self.Options.ShowFlagCarrierErrorNote then
							self:AddMsg(L.InfoErrorText)
						end
					else
						self.FlagCarrierFrame2Button:SetAttribute( "macrotext", "/targetexact " .. mNick )
					end
				elseif mSide == L.Horde then
					FlagCarrier[1] = mNick
					self.FlagCarrierFrame1Text:SetText(mNick)
					self.FlagCarrierFrame1:Show()
					self:ColorFlagCarrier(mNick)
					if UnitAffectingCombat("player") then
						if self.Options.ShowFlagCarrierErrorNote then
							self:AddMsg(L.InfoErrorText)
						end
					else
						self.FlagCarrierFrame1Button:SetAttribute( "macrotext", "/targetexact " .. mNick )
					end
				end
			elseif string.match(arg1, L.ExprFlagDropped) then
				local mSide
				local sArg1, sArg2 =  string.match(arg1, L.ExprFlagDropped)

				if locale == "ruRU" then
					mSide = sArg2
				else
					mSide = sArg1
				end

				if mSide == L.Alliance then
					self.FlagCarrierFrame2:Hide()
					FlagCarrier[2] = nil

				elseif mSide == L.Horde then
					self.FlagCarrierFrame1:Hide()
					FlagCarrier[1] = nil
				end
			end
		end
		if string.match(arg1, L.ExprFlagCaptured) then
			flagTimer:Start()

			if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
				self.FlagCarrierFrame1:Hide()
				self.FlagCarrierFrame2:Hide()
				FlagCarrier[1] = nil
				FlagCarrier[2] = nil
			end
		end
	end
	function mod:CHAT_MSG_BG_SYSTEM_ALLIANCE(...)
		updateflagcarrier(self, "CHAT_MSG_BG_SYSTEM_ALLIANCE", ...)
	end
	function mod:CHAT_MSG_BG_SYSTEM_HORDE(...)
		updateflagcarrier(self, "CHAT_MSG_BG_SYSTEM_HORDE", ...)
	end
end



