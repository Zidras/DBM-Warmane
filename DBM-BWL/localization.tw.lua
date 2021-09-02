if GetLocale() ~= "zhTW" then return end
local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "狂野的拉佐格爾"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "小怪重生"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "為第一次小怪重生顯示計時器"
}
L:SetMiscLocalization{
	Phase2Emote	= "奈法利安的部隊在寶珠的控制力消失之前逃走。",
	YellEgg1	= "你會為此付出代價！",
	YellEgg2	= "蠢貨！這些蛋比你想像的還要珍貴！",
	YellEgg3	= "不！不行！我要拿你的頭來彌補這種暴行！",
	YellPull 	= "入侵者闖進孵化室了！拉響警報！無論如何都要保護蛋！"
}
-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name = "墮落的瓦拉斯塔茲"
}

L:SetMiscLocalization{
	Event	= "太遲了，朋友！奈法利斯的腐化掌控了我…我已經無法…控制自己了。"
}
-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name = "勒西雷爾"
}

L:SetMiscLocalization{
	Pull	= "你們根本不應該在這裡出現！我要殺掉你們！"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "費爾默"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "埃博諾克"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "弗萊格爾"
}


-----------------------
--  Vulnerabilities  --
-----------------------
-- Chromaggus, Death Talon Overseer and Death Talon Wyrmguard
L = DBM:GetModLocalization("TalonGuards")

L:SetGeneralLocalization{
	name = "龍人護衛"
}
L:SetWarningLocalization{
	WarnVulnerable		= "%s弱點"
}
L:SetOptionLocalization{
	WarnVulnerable		= "爲法術弱點顯示警告"
}
L:SetMiscLocalization{
	Fire		= "火焰",
	Nature		= "自然",
	Frost		= "冰霜",
	Shadow		= "暗影",
	Arcane		= "祕法",
	Holy		= "神聖"
}


------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "克洛瑪古斯"
}
L:SetWarningLocalization{
	WarnBreath		= "%s",
	WarnVulnerable	= "%s弱點"
}
L:SetTimerLocalization{
	TimerBreathCD	= "%s冷卻",
	TimerBreath		= "%s施放",
	TimerVulnCD		= "弱點冷卻"
}
L:SetOptionLocalization{
	WarnBreath		= "為克洛瑪古斯其中一個吐息顯示警告",
	WarnVulnerable	= "爲法術弱點顯示警告",
	TimerBreathCD	= "顯示吐息冷卻",
	TimerBreath		= "顯示吐息施放",
	TimerVulnCD		= "顯示弱點冷卻"
}
L:SetMiscLocalization{
	Breath1	= "第一次吐息",
	Breath2	= "第二次吐息",
	VulnEmote	= "%s因皮膚閃著微光而驚訝退縮。",
	Fire		= "火焰",
	Nature		= "自然",
	Frost		= "冰霜",
	Shadow		= "暗影",
	Arcane		= "祕法",
	Holy		= "神聖"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization{
	name = "奈法利安"
}
L:SetWarningLocalization{
	WarnAddsLeft		= "剩下%d擊殺",
	WarnClassCall		= "%s點名",
	specwarnClassCall    = "你中了職業點名！"
}
L:SetTimerLocalization{
	TimerClassCall		= "%s點名結束"
}
L:SetOptionLocalization{
	TimerClassCall		= "為職業點名持續時間顯示計時器",
	WarnAddsLeft		= "提示離第二階段開始剩多少擊殺",
	WarnClassCall		= "提示職業點名",
	specwarnClassCall	= "特別警告：當你中了職業點名時"
}
L:SetMiscLocalization{
	YellP1		= "讓賽事開始吧！",
	YellP2		= "幹得好，手下們。凡人的勇氣開始消退了！現在，我們就來看看他們怎麼面對黑石之王的力量吧！",
	YellP3		= "不可能！來吧，我的僕人！再次為你們的主人服務！",
	YellShaman	= "薩滿，讓我看看你圖騰到底是什麼用處的！",
	YellPaladin	= "聖騎士……聽說你有無數條命。讓我看看到底是怎麼樣的吧。",
	YellDruid	= "德魯伊和你們愚蠢的變形。讓我們看看什麼會發生吧！",
	YellPriest	= "牧師！如果你要繼續這麼治療的話，那我們來玩點有趣的東西！",
	YellWarrior	= "戰士，我知道你應該比較抗打！讓我們來見識一下吧！",
	YellRogue	= "盜賊？不要躲了，面對我吧！",
	YellWarlock	= "術士，不要隨便去玩那些你不理解的法術。看看會發生什麼吧？",
	YellHunter	= "獵人和你那討厭的豌豆射擊！",
	YellMage	= "還有法師？你應該小心使用你的魔法……"
}
