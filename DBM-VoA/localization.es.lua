if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------------------------
-- Archavon el Vigía de Piedra --
---------------------------------
L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "Archavon el Vigía de Piedra"
})

L:SetWarningLocalization({
	WarningGrab		= "Archavon agarra a >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "Rabia (Archavon)"
})

L:SetOptionLocalization({
	WarningGrab		= "Anunciar objetivo de $spell:58666"
})

L:SetMiscLocalization({
	TankSwitch		= "%%s se abalanza sobre (%S+)"
})

------------------------------------
-- Emalon el Vigía de la Tormenta --
------------------------------------
L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization({
	name = "Emalon el Vigía de la Tormenta"
})

L:SetTimerLocalization({
	timerMobOvercharge	= "Explosión de Sobrecarga",
	EmalonEnrage		= "Rabia (Emalon)"
})

L:SetOptionLocalization({
	timerMobOvercharge	= "Mostrar temporizador para la explosión del Esbirro tempestuoso afectado por Sobrecarga"
})

------------------------------------
-- Koralon el Vigía de las Llamas --
------------------------------------
L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization({
	name = "Koralon el Vigía de las Llamas"
})

L:SetTimerLocalization({
	KoralonEnrage	= "Rabia (Koralon)"
})

-------------------------------
-- Toravon el Vigía de Hielo --
-------------------------------
L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization({
	name = "Toravon el Vigía de Hielo"
})

L:SetTimerLocalization({
	ToravonEnrage	= "Rabia (Toravon)"
})
