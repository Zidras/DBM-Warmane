if GetLocale() ~= "zhTW" then return end

local L

----------------------------------
--  Archavon the Stone Watcher  --
----------------------------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "『石之看守者』亞夏梵"
})

L:SetWarningLocalization({
	WarningGrab		= "亞夏梵擒握 >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "亞夏梵狂暴"
})

L:SetOptionLocalization({
	WarningGrab		= "提示擒握的目標"
})

L:SetMiscLocalization({
	TankSwitch		= "%%s撲向(%S+)!"
})

--------------------------------
--  Emalon the Storm Watcher  --
--------------------------------

L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization({
	name = "『風暴看守者』艾瑪隆"
})

L:SetTimerLocalization({
	timerMobOvercharge	= "超載爆炸",
	EmalonEnrage		= "艾瑪隆狂暴"
})

L:SetOptionLocalization({
	timerMobOvercharge	= "為超載的小兵顯示計時器(減益疊加)"
})

---------------------------------
--  Koralon the Flame Watcher  --
---------------------------------

L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization({
	name = "『烈焰看守者』寇拉隆"
})

L:SetTimerLocalization({
	KoralonEnrage	= "寇拉隆狂暴"
})

-------------------------------
--  Toravon the Ice Watcher  --
-------------------------------
L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization({
	name = "『寒冰看守者』拓拉梵"
})

L:SetTimerLocalization({
	ToravonEnrage	= "拓拉梵狂暴"
})
