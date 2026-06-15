-- this file uses the texture Textures/arrow.tga. This image was created by Everaldo Coelho and is licensed under the GNU Lesser General Public License. See Textures/lgpl.txt.
local mod	= DBM:NewMod("Thaddius", "DBM-Naxx", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221008164846")
mod:SetCreatureID(15928)

mod:RegisterCombat("combat_yell", L.Yell)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 28089",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_AURA player"
)

local warnShiftSoon			= mod:NewPreWarnAnnounce(28089, 5, 3)
local warnShiftCasting		= mod:NewCastAnnounce(28089, 4)
--local warnThrow				= mod:NewSpellAnnounce(28338, 2)
local warnThrowSoon			= mod:NewSoonAnnounce(28338, 1)

local warnChargeChanged		= mod:NewSpecialWarning("WarningChargeChanged", nil, nil, nil, 3, 2, nil, nil, 28089)
local warnChargeNotChanged	= mod:NewSpecialWarning("WarningChargeNotChanged", false, nil, nil, 1, 12, nil, nil, 28089)
local yellShift				= mod:NewShortPosYell(28089, DBM_CORE_L.AUTO_YELL_CUSTOM_POSITION)

local enrageTimer			= mod:NewBerserkTimer(365)
local timerNextShift		= mod:NewNextTimer(30, 28089, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerShiftCast		= mod:NewCastTimer(3, 28089, nil, nil, nil, 2)
local timerThrow			= mod:NewNextTimer(20.6, 28338, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

if not DBM.Options.GroupOptionsBySpell then
	mod:AddMiscLine(DBM_CORE_L.OPTION_CATEGORY_DROPDOWNS)
end
mod:AddDropdownOption("ArrowsEnabled", {"Never", "TwoCamp", "ArrowsRightLeft", "ArrowsInverse"}, "Never", "misc", nil, 28089) --not grouping to prevent padding issue (aggravated with ElvUI) and ungrouped dropdown line workaround

mod:SetBossHealthInfo(
	15930, L.Boss1,
	15929, L.Boss2
)

local currentCharge
local down = 0

local function TankThrow(self)
	if not self:IsInCombat() or self.vb.phase == 2 then
		DBM.BossHealth:Hide()
		return
	end
	timerThrow:Start()
	warnThrowSoon:Schedule(17.6)
	self:Schedule(20.6, TankThrow, self)
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	currentCharge = nil
	down = 0
	self:Schedule(20.6 - delay, TankThrow, self)
	timerThrow:Start(-delay)
	warnThrowSoon:Schedule(17.6 - delay)
end

do
	local lastShift
	function mod:SPELL_CAST_START(args)
		if args.spellId == 28089 then
			self:SetStage(2)
			timerNextShift:Start()
			timerShiftCast:Start()
			warnShiftCasting:Show()
			warnShiftSoon:Schedule(25)
			lastShift = GetTime()
		end
	end

	function mod:UNIT_AURA()
		if self.vb.phase ~= 2 or not lastShift or (GetTime() - lastShift) < 3 then return end
		local charge
		local i = 1
		while UnitDebuff("player", i) do
			local _, _, icon, count = UnitDebuff("player", i)
			if icon == "Interface\\Icons\\Spell_ChargeNegative" then
				if count > 1 then return end --Incorrect aura, it's stacking damage one
				charge = L.Charge1
				yellShift:Yell(7, "- -")
			elseif icon == "Interface\\Icons\\Spell_ChargePositive" then
				if count > 1 then return end --Incorrect aura, it's stacking damage one
				charge = L.Charge2
				yellShift:Yell(6, "+ +")
			end
			i = i + 1
		end
		if charge then
			lastShift = nil
			if charge == currentCharge then
				warnChargeNotChanged:Show()
				warnChargeNotChanged:Play("dontmove")
				if self.Options.ArrowsEnabled == "ArrowsInverse" then
					self:ShowLeftArrow()
				elseif self.Options.ArrowsEnabled == "ArrowsRightLeft" then
					self:ShowRightArrow()
				end
			else
				warnChargeChanged:Show(charge)
				warnChargeChanged:Play("stilldanger")
				if self.Options.ArrowsEnabled == "ArrowsInverse" then
					self:ShowRightArrow()
				elseif self.Options.ArrowsEnabled == "ArrowsRightLeft" then
					self:ShowLeftArrow()
				elseif self.Options.ArrowsEnabled == "TwoCamp" then
					self:ShowUpArrow()
				end
			end
			currentCharge = charge
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:match(L.Emote) or msg:match(L.Emote2) or msg:find(L.Emote) or msg:find(L.Emote2) or msg == L.Emote or msg == L.Emote2 then
		down = down + 1
		if down >= 2 then
			self:Unschedule(TankThrow)
			timerThrow:Cancel()
			warnThrowSoon:Cancel()
			DBM.BossHealth:Hide()
			enrageTimer:Start()
		end
	end
end

local function arrowOnUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed >= 3.5 and self.elapsed < 4.5 then
		self:SetAlpha(4.5 - self.elapsed)
	elseif self.elapsed >= 4.5 then
		self:Hide()
	end
end

local function arrowOnShow(self)
	self.elapsed = 0
	self:SetAlpha(1)
end

local arrowLeft = CreateFrame("Frame", nil, UIParent)
arrowLeft:Hide()
local arrowLeftTexture = arrowLeft:CreateTexture(nil, "BACKGROUND")
arrowLeftTexture:SetTexture("Interface\\AddOns\\DBM-Naxx\\ConstructQuarter\\Textures\\arrow")
arrowLeftTexture:SetPoint("CENTER", arrowLeft, "CENTER")
arrowLeft:SetHeight(1)
arrowLeft:SetWidth(1)
arrowLeft:SetPoint("CENTER", UIParent, "CENTER", -150, -30)
arrowLeft:SetScript("OnShow", arrowOnShow)
arrowLeft:SetScript("OnUpdate", arrowOnUpdate)

local arrowRight = CreateFrame("Frame", nil, UIParent)
arrowRight:Hide()
local arrowRightTexture = arrowRight:CreateTexture(nil, "BACKGROUND")
arrowRightTexture:SetTexture("Interface\\AddOns\\DBM-Naxx\\ConstructQuarter\\Textures\\arrow")
arrowRightTexture:SetPoint("CENTER", arrowRight, "CENTER")
arrowRightTexture:SetTexCoord(1, 0, 0, 1)
arrowRight:SetHeight(1)
arrowRight:SetWidth(1)
arrowRight:SetPoint("CENTER", UIParent, "CENTER", 150, -30)
arrowRight:SetScript("OnShow", arrowOnShow)
arrowRight:SetScript("OnUpdate", arrowOnUpdate)

local arrowUp = CreateFrame("Frame", nil, UIParent)
arrowUp:Hide()
local arrowUpTexture = arrowUp:CreateTexture(nil, "BACKGROUND")
arrowUpTexture:SetTexture("Interface\\AddOns\\DBM-Naxx\\ConstructQuarter\\Textures\\arrow")
arrowUpTexture:SetRotation(math.pi * 3 / 2)
arrowUpTexture:SetPoint("CENTER", arrowUp, "CENTER")
arrowUp:SetHeight(1)
arrowUp:SetWidth(1)
arrowUp:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
arrowUp:SetScript("OnShow", arrowOnShow)
arrowUp:SetScript("OnUpdate", arrowOnUpdate)

function mod:ShowRightArrow()
	arrowRight:Show()
end

function mod:ShowLeftArrow()
	arrowLeft:Show()
end

function mod:ShowUpArrow()
	arrowUp:Show()
end
