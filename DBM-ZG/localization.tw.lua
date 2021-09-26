if GetLocale() ~= "zhTW" then return end
local L

-------------------
--  Venoxis  --
-------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization{
	name = "高階祭司溫諾希斯"
}

-------------------
--  Jeklik  --
-------------------
L = DBM:GetModLocalization("Jeklik")

L:SetGeneralLocalization{
	name = "高階祭司耶克里克"
}

-------------------
--  Marli  --
-------------------
L = DBM:GetModLocalization("Marli")

L:SetGeneralLocalization{
	name = "高階祭司瑪俐"
}

-------------------
--  Thekal  --
-------------------
L = DBM:GetModLocalization("Thekal")

L:SetGeneralLocalization{
	name = "高階祭司塞卡爾"
}

L:SetWarningLocalization({
	WarnSimulKill	= "大約15秒內複活"
})

L:SetTimerLocalization({
	TimerSimulKill	= "複活術"
})

L:SetOptionLocalization({
	WarnSimulKill	= "通告第一個怪物倒下,馬上將複活",
	TimerSimulKill	= "顯示牧師複活計時器"
})

L:SetMiscLocalization({
	PriestDied	= "%s死了。",
	YellPhase2	= "希瓦拉爾，給我憤怒的力量吧！",
	YellKill	= "哈卡再也不能束縛我了！我終於可以安息了！",
	Thekal		= "高階祭司塞卡爾",
	Zath		= "狂熱者札斯",
	LorKhan		= "狂熱者洛卡恩"
})

-------------------
--  Arlokk  --
-------------------
L = DBM:GetModLocalization("Arlokk")

L:SetGeneralLocalization{
	name = "高階祭司阿洛克"
}

-------------------
--  Hakkar  --
-------------------
L = DBM:GetModLocalization("Hakkar")

L:SetGeneralLocalization{
	name = "哈卡"
}

-------------------
--  Bloodlord  --
-------------------
L = DBM:GetModLocalization("Bloodlord")

L:SetGeneralLocalization{
	name = "血領主曼多基爾"
}
L:SetMiscLocalization{
	Bloodlord 	= "血領主曼多基爾",
	Ohgan		= "奧根",
	GazeYell	= "我正在監視你"
}

-------------------
--  Edge of Madness  --
-------------------
L = DBM:GetModLocalization("EdgeOfMadness")

L:SetGeneralLocalization{
	name = "瘋狂之緣"
}
L:SetMiscLocalization{
	Hazzarah = "哈劄拉爾",
	Renataki = "雷納塔基",
	Wushoolay = "烏蘇雷",
	Grilek = "格裏雷克"
}

-------------------
--  Gahz'ranka  --
-------------------
L = DBM:GetModLocalization("Gahzranka")

L:SetGeneralLocalization{
	name = "加茲蘭卡"
}

-------------------
--  Jindo  --
-------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization{
	name = "妖術師金度"
}
