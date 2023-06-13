local CallbackHandler = LibStub("CallbackHandler-1.0")
local AddOn = LibStub("AceAddon-3.0"):NewAddon("DBM-TimerTracker", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0")
AddOn.callbacks = AddOn.callbacks or CallbackHandler:New(AddOn)
TT = AddOn:NewModule("Enhanced_TimerTracker", "AceHook-3.0", "AceEvent-3.0")
AddOn.RegisteredModules = {}
AddOn.RegisteredInitialModules = {}
local ipairs = ipairs
local unpack = unpack
local floor, fmod, modf = math.floor, math.fmod, math.modf
local LSM = LibStub("LibSharedMedia-3.0")
local GetTime = GetTime
local GetBattlefieldScore, GetNumBattlefieldScores, GetUnitName, UnitFactionGroup = GetBattlefieldScore, GetNumBattlefieldScores, GetUnitName, UnitFactionGroup
local function GetBattlefieldFaction(unit) -- workaround to detect faction in Cross-Faction BG
	if not unit then return UnitFactionGroup("player") end
	local numScores = GetNumBattlefieldScores()
	if numScores == 0 then return UnitFactionGroup("player")
	else
		local unitName = GetUnitName(unit, true)
		for i = 1, numScores do
			local name, _, _, _, _, faction = GetBattlefieldScore(i)
			if name == unitName then
				if faction == 0 then
					return "Horde"
				else
					return "Alliance"
				end
			end
		end
	end
end
local media = {}
LSM:Register("statusbar", "ElvUI Norm", [[Interface\AddOns\DBM-Core\textures\NormTex2.tga]])
LSM:Register("background", "ElvUI Blank", [[Interface\BUTTONS\WHITE8X8]])
media.blankTex = LSM:Fetch("background", "ElvUI Blank")
media.glossTex = LSM:Fetch("statusbar",  "ElvUI Norm")

local timerTypes = {
	["30-120"] = {1, 30, 120},
	["60-120"] = {1, 60, 120},
	["120-120"] = {1, 120, 120},
	["15-60"] = {1, 15, 60},
	["30-60"] = {1, 30, 60},
	["60-60"] = {1, 60, 60},
}

local chatMessage = {
	-- enUS
	-- WSG
	["The battle for Warsong Gulch begins in 30 seconds. Prepare yourselves!"] = timerTypes["30-120"],
	["The battle for Warsong Gulch begins in 1 minute."] = timerTypes["60-120"],
	["The battle for Warsong Gulch begins in 2 minutes."] = timerTypes["120-120"],
	-- AB
	["The Battle for Arathi Basin begins in 30 seconds. Prepare yourselves!"] = timerTypes["30-120"],
	["The Battle for Arathi Basin begins in 1 minute."] = timerTypes["60-120"],
	["The battle for Arathi Basin begins in 2 minutes."] = timerTypes["120-120"],
	-- EotS
	["The Battle for Eye of the Storm begins in 30 seconds."] = timerTypes["30-120"],
	["The Battle for Eye of the Storm begins in 1 minute."] = timerTypes["60-120"],
	["The battle for Eye of the Storm begins in 2 minutes."] = timerTypes["120-120"],
	-- AV
	["The Battle for Alterac Valley begins in 30 seconds. Prepare yourselves!"] = timerTypes["30-120"],
	["30 seconds until the battle for Alterac Valley begins."] = timerTypes["30-120"],
	["The Battle for Alterac Valley begins in 1 minute."] = timerTypes["60-120"],
	["1 minute until the battle for Alterac Valley begins."] = timerTypes["60-120"],
	["The Battle for Alterac Valley begins in 2 minutes."] = timerTypes["120-120"],
	-- SotA
	["The battle for Strand of the Ancients begins in 30 seconds. Prepare yourselves!."] = timerTypes["30-120"],
	["The battle for Strand of the Ancients begins in 1 minute."] = timerTypes["60-120"],
	["The battle for Strand of the Ancients begins in 2 minutes."] = timerTypes["120-120"],
	-- SotA 2 round
	["Round 2 begins in 30 seconds. Prepare yourselves!"] = timerTypes["30-60"],
	["Round 2 of the Battle for the Strand of the Ancients begins in 1 minute."] = timerTypes["60-60"],
	-- Other
	["The battle will begin in 30 seconds!"] = timerTypes["30-120"],
	["The battle will begin in 1 minute."] = timerTypes["60-120"],
	["The battle will begin in two minutes."] = timerTypes["120-120"],
	["The battle begins in 30 seconds!"] = timerTypes["30-120"],
	["The battle begins in 1 minute!"] = timerTypes["60-120"],
	["The battle begins in 2 minutes!"] = timerTypes["120-120"],
	-- Arena
	["Fifteen seconds until the Arena battle begins!"] = timerTypes["15-60"],
	["Thirty seconds until the Arena battle begins!"] = timerTypes["30-60"],
	["One minute until the Arena battle begins!"] = timerTypes["60-60"],

	-- deDE
	-- WSG
	["Der Kampf um die Kriegshymnenschlucht beginnt in 30 Sekunden. Haltet Euch bereit!"] = timerTypes["30-120"],
	["Der Kampf um die Kriegshymnenschlucht beginnt in 1 Minute."] = timerTypes["60-120"],
	-- AV
	["Der Kampf um das Alteractal beginnt in 30 Sekunden."] = timerTypes["30-120"],
	["Der Kampf um das Alteractal beginnt in 1 Minute."] = timerTypes["60-120"],
	-- SotA 2 round
	["Runde 2 beginnt in 30 Sekunden. Macht Euch bereit!"] = timerTypes["30-60"],
	["Runde 2 der Schlacht um den Strand der Uralten beginnt in 1 Minute."] = timerTypes["60-60"],
	-- Other
	["Die Schlacht beginnt in 30 Sekunden!"] = timerTypes["30-120"],
	["Die Schlacht beginnt in 1 Minute!"] = timerTypes["60-120"],
	["Die Schlacht beginnt in 2 Minuten!"] = timerTypes["120-120"],
	-- Arena
	["Noch fünfzehn Sekunden bis der Arenakampf beginnt!"] = timerTypes["15-60"],
	["Noch dreißig Sekunden bis der Arenakampf beginnt!"] = timerTypes["30-60"],
	["Noch eine Minute bis der Arenakampf beginnt!"] = timerTypes["60-60"],

	-- esES & esMX
	-- WSG
	["La batalla por la Garganta Grito de Guerra comenzará en 30 segundos. ¡Preparaos!"] = timerTypes["30-120"],
	["La batalla por la Garganta Grito de Guerra comenzará en 1 minuto."] = timerTypes["60-120"],
	-- AV
	["30 segundos para que dé comienzo la batalla por el Valle de Alterac."] = timerTypes["30-120"],
	["1 minuto para que dé comienzo la batalla por el Valle de Alterac."] = timerTypes["60-120"],
	-- SotA 2 round
	["La ronda 2 comenzará en 30 segundos. ¡Preparaos!"] = timerTypes["30-60"],
	["La ronda 2 de la batalla por la Playa de los Ancestros comenzará en 1 minuto."] = timerTypes["60-60"],
	-- Other
	["¡La batalla comienza en treinta segundos!"] = timerTypes["30-120"],
	["¡La batalla comienza en un minuto!"] = timerTypes["60-120"],
	["¡La batalla comienza en dos minutos!"] = timerTypes["120-120"],
	-- Arena
	["¡Quince segundos para que comience la batalla de arena!"] = timerTypes["15-60"],
	["¡Treinta segundos hasta que comience la batalla en arena!"] = timerTypes["30-60"],
	["¡Un minuto hasta que dé comienzo la batalla en arena!"] = timerTypes["60-60"],

	-- frFR
	-- WSG
	["La bataille pour le goulet des Chanteguerres commence dans 30 secondes. Préparez-vous !"] = timerTypes["30-120"],
	["La bataille pour le goulet des Chanteguerres commence dans 1 minute."] = timerTypes["60-120"],
	-- AV
	["La bataille pour la vallée d’Alterac commence dans 30 secondes."] = timerTypes["30-120"],
	["La bataille pour la vallée d’Alterac commence dans 1 minute."] = timerTypes["60-120"],
	-- SotA 2 round
	["Début de la deuxième manche dans 30 secondes. Préparez-vous !"] = timerTypes["30-60"],
	["Deuxième manche de la bataille du rivage des Anciens dans 1 minute."] = timerTypes["60-60"],
	-- Other
	["La bataille commence dans 30 secondes !"] = timerTypes["30-120"],
	["La bataille commence dans 1 minute !"] = timerTypes["60-120"],
	["La bataille commence dans 2 minutes !"] = timerTypes["120-120"],
	-- Arena
	["Le combat commence dans quinze secondes !"] = timerTypes["15-60"],
	["Le combat d’arène commence dans trente secondes !"] = timerTypes["30-60"],
	["Le combat d’arène commence dans une minute !"] = timerTypes["60-60"],

	-- koKR
	-- WSG
	["30초 후 전쟁노래 협곡 전투가 시작됩니다. 준비하십시오!"] = timerTypes["30-120"],
	["1분 후 전쟁노래 협곡 전투가 시작됩니다!"] = timerTypes["60-120"],
	-- AV
	["알터랙 계곡 전투 개시 30초 전..."] = timerTypes["30-120"],
	["알터랙 계곡 전투 개시 1분 전..."] = timerTypes["60-120"],
	-- SotA 2 round
	["30초 후 두 번째 전투가 시작됩니다. 준비하세요!"] = timerTypes["30-60"],
	["1분 후 고대의 해안 두 번째 전투가 시작됩니다."] = timerTypes["60-60"],
	-- Other
	["30초 후 전투가 시작됩니다!"] = timerTypes["30-120"],
	["1분 후 전투가 시작됩니다!"] = timerTypes["60-120"],
	["2분 후 전투가 시작됩니다!"] = timerTypes["120-120"],
	-- Arena
	["투기장 전투 시작 15초 전입니다!"] = timerTypes["15-60"],
	["투기장 전투 시작 30초 전입니다!"] = timerTypes["30-60"],
	["투기장 전투 시작 1분 전입니다!"] = timerTypes["60-60"],

	-- ruRU
	-- Ущелье Песни Войны
	["Битва за Ущелье Песни Войны начнется через 30 секунд. Приготовьтесь!"] = timerTypes["30-120"],
	["Битва за Ущелье Песни Войны начнется через 30 секунд. Приготовиться!"] = timerTypes["30-120"],
	["Битва за Ущелье Песни Войны начнется через 1 минуту."] = timerTypes["60-120"],
	["Сражение в Ущелье Песни Войны начнется через 2 минуты."] = timerTypes["120-120"],
	-- Низина Арати
	["Битва за Низину Арати начнется через 30 секунд. Приготовьтесь!"] = timerTypes["30-120"],
	["Битва за Низину Арати начнется через 30 секунд."] = timerTypes["30-120"],
	["Битва за Низину Арати начнется через 1 минуту."] = timerTypes["60-120"],
	["Битва за Низину Арати начнется через минуту."] = timerTypes["60-120"],
	["Сражение в Низине Арати начнется через 2 минуты."] = timerTypes["120-120"],
	-- Око Бури
	["Битва за Око Бури начнется через 30 секунд."] = timerTypes["30-120"],
	["Битва за Око Бури начнется через 1 минуту."] = timerTypes["60-120"],
	["Сражение в Око Бури начнется через 2 минуты."] = timerTypes["120-120"],
	-- Альтеракская долина
	["Сражение на Альтеракской долине начнется через 30 секунд. Приготовьтесь!"] = timerTypes["30-120"],
	["30 секунд до начала битвы в Альтеракской долине."] = timerTypes["30-120"],
	["Сражение на Альтеракской долине начнется через 1 минуту."] = timerTypes["60-120"],
	["До начала сражения за Альтеракскую долину остается 1 минута."] = timerTypes["60-120"],
	["Сражение на Альтеракской долине начнется через 2 минуты."] = timerTypes["120-120"],
	-- Берег Древних
	["Битва за Берег Древних начнется через 30 секунд. Приготовьтесь!"] = timerTypes["30-120"],
	["Сражение за Берег Древних начнется через 30 секунд. Готовьтесь!"] = timerTypes["30-120"],
	["Битва за Берег Древних начнется через 1 минуту."] = timerTypes["60-120"],
	["Сражение за Берег Древних начнется через 1 минуту."] = timerTypes["60-120"],
	["Битва за Берег Древних начнется через 2 минуты."] = timerTypes["120-120"],
	-- Берег древних 2-й раунд
	["Второй раунд начнется через 30 секунд. Приготовьтесь!"] = timerTypes["30-60"],
	["Второй раунд начинается через 30 секунд. Приготовьтесь!"] = timerTypes["30-60"],
	["Второй раунд битвы за Берег Древних начнется через 1 минуту."] = timerTypes["60-60"],
	["Второй раунд сражения за Берег Древних начнется через 1 минуту."] = timerTypes["60-60"],
	-- Другие
	["Битва начнется через 30 секунд!"] = timerTypes["30-120"],
	["Битва начнется через 30 секунд."] = timerTypes["30-120"],
	["Битва начнется через 1 минуту."] = timerTypes["60-120"],
	["Битва начнется через минуту!"] = timerTypes["60-120"],
	["Битва начнется через 60 секунд."] = timerTypes["60-120"],
	["Битва начнется через 2 минуты!"] = timerTypes["120-120"],
	-- Арена
	["15 секунд до начала боя на арене!"] = timerTypes["15-60"],
	["Пятнадцать секунд до начала боя на арене!"] = timerTypes["15-60"],
	["30 секунд до начала боя на арене!"] = timerTypes["30-60"],
	["Тридцать секунд до начала боя на арене !"] = timerTypes["30-60"],
	["1 минута до начала боя на арене!"] = timerTypes["60-60"],
	["Одна минута до начала боя на арене!"] = timerTypes["60-60"],

	-- zhCN
	-- WSG
	["战歌峡谷战斗将在30秒钟内开始。做好准备！"] = timerTypes["30-120"],
	["战歌峡谷战斗将在1分钟内开始。"] = timerTypes["60-120"],
	-- AV
	["奥特兰克山谷的战斗将在30秒之后开始。"] = timerTypes["30-120"],
	["奥特兰克山谷的战斗将在1分钟之后开始。"] = timerTypes["60-120"],
	-- SotA 2 round
	["第2轮比赛将在30秒后开始。备战！"] = timerTypes["30-60"],
	["远古海滩的第2轮比赛将在1分钟后开始。"] = timerTypes["60-60"],
	-- Other
	["战斗将在30秒后开始！"] = timerTypes["30-120"],
	["战斗将在1分钟后开始！"] = timerTypes["60-120"],
	["战斗将在2分钟后开始！"] = timerTypes["120-120"],
	-- Arena
	["竞技场战斗将在十五秒后开始！"] = timerTypes["15-60"],
	["竞技场战斗将在三十秒后开始！"] = timerTypes["30-60"],
	["竞技场战斗将在一分钟后开始！"] = timerTypes["60-60"],

	-- zhTW
	-- WSG
	["戰歌峽谷戰鬥將在30秒鐘內開始。做好準備!"] = timerTypes["30-120"],
	["戰歌峽谷戰鬥將在1分鐘內開始。"] = timerTypes["60-120"],
	-- AV
	["奧特蘭克山谷30秒後開始戰鬥。"] = timerTypes["30-120"],
	["奧特蘭克山谷一分鐘後開始戰鬥。"] = timerTypes["60-120"],
	-- SotA 2 round
	["第2回合將在30秒後開始。做好準備!"] = timerTypes["30-60"],
	["遠祖灘頭的第2回合戰鬥將在1分鐘後開始。"] = timerTypes["60-60"],
	-- Other
	["戰鬥在30秒內開始!"] = timerTypes["30-120"],
	["戰鬥在1分鐘內開始!"] = timerTypes["60-120"],
	["戰鬥在2分鐘內開始!"] = timerTypes["120-120"],
	-- Arena
	["15秒後競技場戰鬥開始!"] = timerTypes["15-60"],
	["30秒後競技場戰鬥開始!"] = timerTypes["30-60"],
	["1分鐘後競技場戰鬥開始!"] = timerTypes["60-60"]
}

local TIMER_MINUTES_DISPLAY = "%d:%02d"
local TIMER_TYPE_PVP = 1
local TIMER_TYPE_CHALLENGE_MODE = 2
local TIMER_TYPE_PLAYER_COUNTDOWN = 3

-- SOUND KITS
local SOUNDKIT = {
	UI_COUNTDOWN_BAR_STATE_STARTS = "Interface\\AddOns\\DBM-Core\\sounds\\Timer\\TempMono.ogg", -- 158958
	UI_COUNTDOWN_BAR_STATE_FINISHED = "Interface\\AddOns\\DBM-Core\\sounds\\Timer\\TempMono.ogg", -- 158959
	UI_COUNTDOWN_MEDIUM_NUMBER_FINISHED = "Interface\\AddOns\\DBM-Core\\sounds\\Timer\\TempMono.ogg", -- 158960
	UI_COUNTDOWN_TIMER = "Interface\\AddOns\\DBM-Core\\sounds\\Timer\\UI_BattlegroundCountdown_Timer.ogg", -- 158565
	UI_COUNTDOWN_FINISHED = "Interface\\AddOns\\DBM-Core\\sounds\\Timer\\UI_BattlegroundCountdown_End.ogg", -- 158566
	UI_BATTLEGROUND_COUNTDOWN_TIMER = "Interface\\AddOns\\DBM-Core\\sounds\\Timer\\UI_BattlegroundCountdown_Timer.ogg", -- 25477
	UI_BATTLEGROUND_COUNTDOWN_FINISHED = "Interface\\AddOns\\DBM-Core\\sounds\\Timer\\UI_BattlegroundCountdown_End.ogg", -- 25478
}

local TIMER_DATA = {
	[1] = {mediumMarker = 11, largeMarker = 6, updateInterval = 10},
	[2] = {mediumMarker = 100, largeMarker = 100, updateInterval = 100},
	[3] = {mediumMarker = 31, largeMarker = 11, updateInterval = 10, finishedSoundKitID = SOUNDKIT.UI_COUNTDOWN_FINISHED, bigNumberSoundKitID = SOUNDKIT.UI_COUNTDOWN_TIMER, mediumNumberFinishedSoundKitID = SOUNDKIT.UI_COUNTDOWN_MEDIUM_NUMBER_FINISHED, barShowSoundKitID = SOUNDKIT.UI_COUNTDOWN_BAR_STATE_STARTS, barHideSoundKitID = SOUNDKIT.UI_COUNTDOWN_BAR_STATE_FINISHED}
}

local TIMER_NUMBERS_SETS = {}
TIMER_NUMBERS_SETS["BigGold"] = {
	texture = "Interface\\AddOns\\DBM-Core\\textures\\Timer\\BigTimerNumbers",
	w = 256, h = 170, texW = 1024, texH = 512,
	numberHalfWidths = {
		35/128, -- 0
		14/128, -- 1
		33/128, -- 2
		32/128, -- 3
		36/128, -- 4
		32/128, -- 5
		33/128, -- 6
		29/128, -- 7
		31/128, -- 8
		31/128, -- 9
	}
}
local scale = UIParent:GetEffectiveScale()
local pixel, ratio = 1, 768 / GetScreenHeight()
AddOn.mult = (pixel / scale) - ((pixel - ratio) / scale)

function AddOn:Scale(x)
	local mult = AddOn.mult
	return mult * floor(x / mult + 0.5)
end

local function Size(frame, width, height)
	assert(width)
	frame:SetSize(AddOn:Scale(width), AddOn:Scale(height or width))
end

local function Width(frame, width)
	assert(width)
	frame:SetWidth(AddOn:Scale(width))
end

local function Height(frame, height)
	assert(height)
	frame:SetHeight(AddOn:Scale(height))
end

local function Point(obj, arg1, arg2, arg3, arg4, arg5)
	if arg2 == nil then arg2 = obj:GetParent() end

	if type(arg2) == "number" then arg2 = AddOn:Scale(arg2) end
	if type(arg3) == "number" then arg3 = AddOn:Scale(arg3) end
	if type(arg4) == "number" then arg4 = AddOn:Scale(arg4) end
	if type(arg5) == "number" then arg5 = AddOn:Scale(arg5) end

	obj:SetPoint(arg1, arg2, arg3, arg4, arg5)
end

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.Size then mt.Size = Size end
	if not object.Point then mt.Point = Point end
	if not object.Width then mt.Width = Width end
	if not object.Height then mt.Height = Height end
end

local function CreateAlphaAnim(group, order, duration, change, delay, smoothing)
	local anim = group:CreateAnimation("Alpha")
	anim:SetOrder(order)
	anim:SetDuration(duration)
	anim:SetChange(change)

	if delay then
		anim:SetStartDelay(delay)
	end
	if smoothing then
		anim:SetSmoothing(smoothing)
	end
end

local function CreateScaleAnim(group, order, duration, scale, delay, smoothing)
	local anim = group:CreateAnimation("Scale")
	anim:SetOrder(order)
	anim:SetDuration(duration)
	anim:SetScale(scale, scale)

	if delay then
		anim:SetStartDelay(delay)
	end
	if smoothing then
		anim:SetSmoothing(smoothing)
	end
end

local function Timer_OnShow(self)
	self.time = self.endTime - GetTime()

	if self.time <= 0 then
		self:Hide()
		self.isFree = true
	elseif self.StartNumbers:IsPlaying() then
		self.StartNumbers:Stop()
		self.StartNumbers:Play()
		self.StartGlowNumbers:Stop()
		self.StartGlowNumbers:Play()
	end
end

local function StartNumbers_OnPlay(self)
	local timer = self:GetParent():GetParent()
	TT:SetTexNumbers(timer, timer.Digit1, timer.Digit2)
end

local function StartNumbers_OnFinished(self)
	local timer = self:GetParent():GetParent()
	timer.time = timer.time - 1

	if timer.time > 0 then
		if timer.time < TIMER_DATA[timer.type].largeMarker and not self.anchorCenter then
			TT:SwitchToLargeDisplay(timer)
		end

		timer.StartNumbers:Play()
		timer.StartGlowNumbers:Play()
	else
		if DBM.Options.PlayTTCountdownFinished then
			if TIMER_DATA[timer.type].finishedSoundKitID then
				PlaySoundFile(TIMER_DATA[timer.type].finishedSoundKitID)
			else
				PlaySoundFile(SOUNDKIT.UI_BATTLEGROUND_COUNTDOWN_FINISHED)
			end
		end
		timer.anchorCenter = false
		timer.isFree = true
		timer.GoTextureAnim:Play()
		timer.GoTextureGlowAnim:Play()
	end
end

local function FadeBarIn_OnPlay(self)
	local timer = self:GetParent():GetParent()
	timer.StatusBar:Show()
end

local function FadeBarOut_OnFinished(self)
	local timer = self:GetParent():GetParent()
	timer.time = timer.time - 0.9
	timer.StatusBar:Hide()
	timer.StartNumbers:Play()
	timer.StartGlowNumbers:Play()
end

function TT:ColorGradient(perc, ...)
	if perc >= 1 then
		return select(select("#", ...) - 2, ...)
	elseif perc <= 0 then
		return ...
	end

	local num = select("#", ...) / 3
	local segment, relperc = modf(perc*(num - 1))
	local r1, g1, b1, r2, g2, b2 = select((segment*3) + 1, ...)

	return r1 + (r2 - r1)*relperc, g1 + (g2 - g1)*relperc, b1 + (b2 - b1)*relperc
end

function TT:CreateTimerBar()
	local timer = CreateFrame("Frame", "DBM_GoldTimer"..(#self.timerList + 1), UIParent)
	timer:Size(206, 26)

	timer.GoFrame = CreateFrame("Frame", "$parentGoFrame", timer)
	timer.GoFrame:SetFrameLevel(1)
	timer.GoFrame:SetAlpha(0)
	timer.GoFrame:SetSize(256, 256)
	timer.GoFrame:SetPoint("CENTER", UIParent)
	timer.GoTextureAnim = timer.GoFrame:CreateAnimationGroup()
	CreateScaleAnim(timer.GoTextureAnim, 1, 0, 0.25)
	CreateAlphaAnim(timer.GoTextureAnim, 1, 0, 1)
	CreateScaleAnim(timer.GoTextureAnim, 2, 0.4, 4, nil, "OUT")
	CreateScaleAnim(timer.GoTextureAnim, 3, 0.2, 1.4, 0.6, "OUT")
	CreateAlphaAnim(timer.GoTextureAnim, 3, 0.2, -1, 0.6, "OUT")

	timer.GoTexture = timer.GoFrame:CreateTexture()
	timer.GoTexture:SetAllPoints()

	timer.GoGlowFrame = CreateFrame("Frame", "$parentGoGlowFrame", timer)
	timer.GoGlowFrame:SetFrameLevel(2)
	timer.GoGlowFrame:SetAlpha(0)
	timer.GoGlowFrame:SetAllPoints(timer.GoFrame)
	timer.GoTextureGlowAnim = timer.GoGlowFrame:CreateAnimationGroup()
	CreateScaleAnim(timer.GoTextureGlowAnim, 1, 0, 0.25)
	CreateAlphaAnim(timer.GoTextureGlowAnim, 1, 0, 1)
	CreateScaleAnim(timer.GoTextureGlowAnim, 2, 0.4, 4, nil, "OUT")
	CreateAlphaAnim(timer.GoTextureGlowAnim, 2, 0.4, -1, nil, "IN")

	timer.GoTextureGlow = timer.GoGlowFrame:CreateTexture()
	timer.GoTextureGlow:SetAllPoints()

	timer.DigitFrame = CreateFrame("Frame", "$parentDigitFrame", timer)
	timer.DigitFrame:SetFrameLevel(1)
	timer.DigitFrame:SetAlpha(0)
	timer.StartNumbers = timer.DigitFrame:CreateAnimationGroup()
	CreateScaleAnim(timer.StartNumbers, 1, 0, 0.25)
	CreateAlphaAnim(timer.StartNumbers, 1, 0, -1)
	CreateAlphaAnim(timer.StartNumbers, 2, 0, 1)
	CreateScaleAnim(timer.StartNumbers, 3, 0.3, 4, nil, "OUT")
	CreateScaleAnim(timer.StartNumbers, 4, 0.1, 1.2, 0.6)
	CreateAlphaAnim(timer.StartNumbers, 4, 0.1, -1, 0.6)
	timer.StartNumbers:SetScript("OnPlay", StartNumbers_OnPlay)
	timer.StartNumbers:SetScript("OnFinished", StartNumbers_OnFinished)

	timer.Digit1 = timer.DigitFrame:CreateTexture()
	timer.Digit2 = timer.DigitFrame:CreateTexture()

	timer.DigitGlowFrame = CreateFrame("Frame", "$parentDigitGlowFrame", timer)
	timer.DigitGlowFrame:SetFrameLevel(2)
	timer.DigitGlowFrame:SetAlpha(0)
	timer.StartGlowNumbers = timer.DigitGlowFrame:CreateAnimationGroup()
	CreateScaleAnim(timer.StartGlowNumbers, 1, 0, 0.25)
	CreateAlphaAnim(timer.StartGlowNumbers, 1, 0, 1)
	CreateScaleAnim(timer.StartGlowNumbers, 2, 0.3, 4, nil, "OUT")
	CreateAlphaAnim(timer.StartGlowNumbers, 2, 0.3, -1, nil, "IN")

	timer.Digit1.Glow = timer.DigitGlowFrame:CreateTexture()
	timer.Digit1.Glow:SetAllPoints(timer.Digit1)
	timer.Digit2.Glow = timer.DigitGlowFrame:CreateTexture()
	timer.Digit2.Glow:SetAllPoints(timer.Digit2)

	timer.StatusBar = CreateFrame("StatusBar", "$parentStatusBar", timer)
	timer.StatusBar:Hide()
	timer.StatusBar:Size(195, 13)
	timer.StatusBar:Point("TOP", 0, -2)
	timer.StatusBar:SetStatusBarTexture(media.glossTex)

	timer.StatusBar.Background = timer.StatusBar:CreateTexture("$parentBackground", "BORDER")
	timer.StatusBar.Background:SetAllPoints()
	timer.StatusBar.Background:SetTexture(media.blankTex)

	timer.StatusBar.Text = timer.StatusBar:CreateFontString("$parentTimeText", "OVERLAY", "GameFontHighlight")
	timer.StatusBar.Text:SetPoint("CENTER", 0, 0)

	timer.FadeBarIn = timer.StatusBar:CreateAnimationGroup()
	CreateAlphaAnim(timer.FadeBarIn, 1, 0, -1)
	CreateAlphaAnim(timer.FadeBarIn, 2, 1.9, 1)
	timer.FadeBarIn:SetScript("OnPlay", FadeBarIn_OnPlay)

	timer.FadeBarOut = timer.StatusBar:CreateAnimationGroup()
	CreateAlphaAnim(timer.FadeBarOut, 1, 0.9, -1)
	timer.FadeBarOut:SetScript("OnFinished", FadeBarOut_OnFinished)

	timer:SetScript("OnShow", Timer_OnShow)

	return timer
end

function TT:CreateTimer(timerType, timeSeconds, totalTime)
	if not timerType then return end

	local timer
	local isTimerRunning = false

	for _, frame in ipairs(self.timerList) do
		if frame.type == timerType and not frame.isFree then
			timer = frame
			isTimerRunning = true
			break
		end
	end

	if isTimerRunning and timer.type ~= TIMER_TYPE_PLAYER_COUNTDOWN then
		if not timer.StartNumbers:IsPlaying() then
			timer.time = timeSeconds
			timer.endTime = GetTime() + timeSeconds
		end
	else
		for _, frame in ipairs(self.timerList) do
			if frame.isFree then
				timer = frame
				break
			end
		end

		if timer and timer.type == TIMER_TYPE_PLAYER_COUNTDOWN then
			self:FreeTimerTrackerTimer(timer)
		end

		if not timer then
			timer = self:CreateTimerBar()
			self.timerList[#self.timerList + 1] = timer
		end

		timer:ClearAllPoints()
		timer:Point("TOP", 0, -100 - (24 * #self.timerList))

		timer.isFree = false
		timer.type = timerType
		timer.time = timeSeconds
		timer.endTime = GetTime() + timeSeconds
		timer.totalTime = totalTime
		timer.StatusBar:SetMinMaxValues(0, totalTime)
		timer.style = TIMER_NUMBERS_SETS["BigGold"]

		timer.Digit1:Size(timer.style.w / 2, timer.style.h / 2)
		timer.Digit2:Size(timer.style.w / 2, timer.style.h / 2)
		timer.Digit1.width = timer.style.w / 2
		timer.Digit2.width = timer.style.w / 2
		timer.Digit1:SetTexture(timer.style.texture)
		timer.Digit2:SetTexture(timer.style.texture)
		timer.Digit1.Glow:SetTexture(timer.style.texture.."Glow")
		timer.Digit2.Glow:SetTexture(timer.style.texture.."Glow")

		timer.updateTime = TIMER_DATA[timer.type].updateInterval
		timer:SetScript("OnUpdate", self.BigNumberOnUpdate)
		timer:Show()
	end

	self:SetGoTexture(timer)
end

function TT:BigNumberOnUpdate(elapsed)
	self.time = self.endTime - GetTime()
	self.updateTime = self.updateTime - elapsed

	if self.time < TIMER_DATA[self.type].mediumMarker then
		if (self.time < TIMER_DATA[self.type].largeMarker) and not self.anchorCenter then
			TT:SwitchToLargeDisplay(self)
		elseif self.anchorCenter then
			self.anchorCenter = false
		end

		self:SetScript("OnUpdate", nil)

		if self.barShowing then
			self.barShowing = false
			self.FadeBarOut:Play()
			if TIMER_DATA[self.type].barHideSoundKitID then
				PlaySoundFile(TIMER_DATA[self.type].barHideSoundKitID)
			end
		else
			self.StartNumbers:Play()
			self.StartGlowNumbers:Play()
		end
	elseif not self.barShowing then
		self.FadeBarIn:Play()
		self.barShowing = true
		if TIMER_DATA[self.type].barShowSoundKitID then
			PlaySoundFile(TIMER_DATA[self.type].barShowSoundKitID)
		end
	elseif self.updateTime <= 0 then
		self.updateTime = TIMER_DATA[self.type].updateInterval
	end

	self.StatusBar:SetValue(self.time)
	local minutes, seconds = floor(self.time / 60), floor(fmod(self.time, 60))
	self.StatusBar.Text:SetFormattedText(TIMER_MINUTES_DISPLAY, minutes, seconds)

	local r, g, b = TT:ColorGradient((self.time - 10) / self.totalTime, 1,0,0, 1,1,0, 0,1,0)
	self.StatusBar:SetStatusBarColor(r, g, b)
	self.StatusBar.Background:SetVertexColor(r * 0.25, g * 0.25, b * 0.25)
end

function TT:SetTexNumbers(timer, ...)
	local digits = {...}
	local timeDigits = floor(timer.time)
	local style = timer.style

	local texCoW = style.w / style.texW
	local texCoH = style.h / style.texH
	local columns = floor(style.texW / style.w)

	local digit, l, r, t, b
	local numberOffset, numShown = 0, 0
	local i = 1

	while digits[i] do
		if timeDigits > 0 then
			digit = fmod(timeDigits, 10)

			digits[i].hw = style.numberHalfWidths[digit + 1] * digits[i].width
			numberOffset = numberOffset + digits[i].hw

			l = fmod(digit, columns) * texCoW
			r = l + texCoW
			t = floor(digit / columns) * texCoH
			b = t + texCoH

			digits[i]:SetTexCoord(l, r, t, b)
			digits[i].Glow:SetTexCoord(l, r, t, b)

			timeDigits = floor(timeDigits / 10)
			numShown = numShown + 1
		else
			digits[i]:SetTexCoord(0, 0, 0, 0)
			digits[i].Glow:SetTexCoord(0, 0, 0, 0)
		end

		i = i + 1
	end

	if numberOffset > 0 then
		if DBM.Options.PlayTTCountdown then
			if TIMER_DATA[timer.type].bigNumberSoundKitID and numShown < TIMER_DATA[timer.type].largeMarker then
				PlaySoundFile(TIMER_DATA[timer.type].bigNumberSoundKitID)
			else
				PlaySoundFile(SOUNDKIT.UI_BATTLEGROUND_COUNTDOWN_TIMER)
			end
		end
		digits[1]:ClearAllPoints()

		if timer.anchorCenter then
			digits[1]:Point("CENTER", UIParent, "CENTER", numberOffset - digits[1].hw, 0)
		else
			digits[1]:Point("CENTER", timer, "CENTER", numberOffset - digits[1].hw, 0)
		end

		for j = 2, numShown do
			digits[j]:ClearAllPoints()
			digits[j]:Point("CENTER", digits[j - 1], "CENTER", -(digits[j].hw + digits[j - 1].hw), 0)
		end
	end
end

function TT:SetGoTexture(timer)
	if timer.type == TIMER_TYPE_PVP then
		local factionGroup = GetBattlefieldFaction("player")

		if factionGroup and factionGroup ~= "Neutral" then
			timer.GoTexture:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\Timer\\"..factionGroup.."-Logo")
			timer.GoTextureGlow:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\Timer\\"..factionGroup.."Glow-Logo")
		end
	elseif timer.type == TIMER_TYPE_CHALLENGE_MODE then
		timer.GoTexture:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\Timer\\Challenges-Logo")
		timer.GoTextureGlow:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\Timer\\ChallengesGlow-Logo")
	elseif timer.type == TIMER_TYPE_PLAYER_COUNTDOWN then
		timer.GoTexture:SetTexture("")
		timer.GoTextureGlow:SetTexture("")
	end
end

function TT:SwitchToLargeDisplay(timer)
	timer.Digit1:Size(timer.style.w, timer.style.h)
	timer.Digit2:Size(timer.style.w, timer.style.h)
	timer.Digit1.width = timer.style.w
	timer.Digit2.width = timer.style.w
	timer.anchorCenter = true
	if TIMER_DATA[timer.type].mediumNumberFinishedSoundKitID then
		PlaySoundFile(TIMER_DATA[timer.type].mediumNumberFinishedSoundKitID)
	end
end

function TT:ReleaseTimers()
	for _, timer in ipairs(self.timerList) do
		timer.barShowing = false
		timer.isFree = true
	end
end

function TT:FreeTimerTrackerTimer(timer)
	timer.time = nil
	timer.type = nil
	timer.isFree = true
	timer.barShowing = false
	timer:SetScript("OnUpdate", nil)
	timer.FadeBarOut:Stop()
	timer.FadeBarIn:Stop()
	timer.StartNumbers:Stop()
	timer.GoTextureAnim:Stop()
	timer.StatusBar:Hide()
end

function TT:OnEvent(event, ...)
	if not DBM.Options.PlayTT then return end
	if event == "START_TIMER" then
		local timerType, timeSeconds, totalTime  = ...
		self:CreateTimer(timerType, timeSeconds + 0.1, totalTime + 0.1)
	elseif event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" then
		local msg = ...
		if msg and chatMessage[msg] then
			self:CreateTimer(unpack(chatMessage[msg]))
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		for _, timer in pairs(self.timerList) do
			if timer.type == TIMER_TYPE_PVP then
				self:FreeTimerTrackerTimer(timer)
			end
		end
	end
end

function TT:ToggleState(force)
	if DBM or force then
		self.timerList = self.timerList or {}

		--self:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL", "OnEvent")
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEvent")

	else
		--self:UnregisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")

		self:ReleaseTimers()
	end
end

function TT:Initialize()
	if not DBM then return end

	self:ToggleState()
end

local function InitializeCallback()
	TT:Initialize()
end

function AddOn:CallLoadedModule(obj, silent, object, index)
	local name, func
	if type(obj) == "table" then name, func = unpack(obj) else name = obj end
	local module = name and self:GetModule(name, silent)

	if not module then return end
	if func and type(func) == "string" then
		AddOn:RegisterCallback(name, module[func], module)
	elseif func and type(func) == "function" then
		AddOn:RegisterCallback(name, func, module)
	elseif module.Initialize then
		AddOn:RegisterCallback(name, module.Initialize, module)
	end

	AddOn.callbacks:Fire(name)

	if object and index then object[index] = nil end
end

function AddOn:RegisterInitialModule(name, func)
	self.RegisteredInitialModules[#self.RegisteredInitialModules + 1] = (func and {name, func}) or name
end

function AddOn:RegisterModule(name, func)
	if self.initialized then
		AddOn:CallLoadedModule((func and {name, func}) or name)
	else
		self.RegisteredModules[#self.RegisteredModules + 1] = (func and {name, func}) or name
	end
end

function AddOn:InitializeInitialModules()
	for index, object in ipairs(AddOn.RegisteredInitialModules) do
		AddOn:CallLoadedModule(object, true, AddOn.RegisteredInitialModules, index)
	end
end

function AddOn:InitializeModules()
	for index, object in ipairs(AddOn.RegisteredModules) do
		AddOn:CallLoadedModule(object, true, AddOn.RegisteredModules, index)
	end
end

if not ElvUI then
	local handled = {["Frame"] = true}
	local object = CreateFrame("Frame")
	addapi(object)
	addapi(object:CreateTexture())
	addapi(object:CreateFontString())
	object = EnumerateFrames()
	while object do
		if not handled[object:GetObjectType()] then
			addapi(object)
			handled[object:GetObjectType()] = true
		end

		object = EnumerateFrames(object)
	end
	addapi(GameFontNormal)
end
AddOn:RegisterModule(TT:GetName(), InitializeCallback)
