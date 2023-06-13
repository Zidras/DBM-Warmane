if GetLocale() ~= "ruRU" then return end

local L

----------------------------------
--  Archavon the Stone Watcher  --
----------------------------------
L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Аркавон Страж Камня"
})

L:SetWarningLocalization({
	WarningGrab		= "Аркавон хватает |3-1(>%s<)"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "Берсерк Аркавона"
})

L:SetOptionLocalization({
	WarningGrab		= "Объявлять о захвате цели"
})

L:SetMiscLocalization({
	TankSwitch		= "%%s бросается к (%S+)!"
})

--------------------------------
--  Emalon the Storm Watcher  --
--------------------------------
L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization({
	name = "Эмалон Страж Бури"
})

L:SetTimerLocalization({
	timerMobOvercharge	= "Взрыв в результате перегрузки",
	EmalonEnrage		= "Берсерк Эмалона"
})

L:SetOptionLocalization({
	timerMobOvercharge	= "Отсчет времени для моба с Перегрузкой (стакающего дебафф)"
})

---------------------------------
--  Koralon the Flame Watcher  --
---------------------------------
L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization({
	name = "Коралон Страж Огня"
})

L:SetTimerLocalization({
	KoralonEnrage	= "Берсерк Коралона"
})

-------------------------------
--  Toravon the Ice Watcher  --
-------------------------------
L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization({
	name = "Торавон Страж Льда"
})

L:SetTimerLocalization({
	ToravonEnrage	= "Берсерк Торавона"
})
