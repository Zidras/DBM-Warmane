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
	WarningGrab	= "Archavon agarra a >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "Rabia (Archavon)"
})

L:SetMiscLocalization({
	TankSwitch	= "%%s se abalanza sobre (%S+)"
})

L:SetOptionLocalization({
	WarningGrab		= "Anunciar objetivo de $spell:58666",
	ArchavonEnrage	= "Mostrar temporizador para $spell:26662"
})

------------------------------------
-- Emalon el Vigía de la Tormenta --
------------------------------------
L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name = "Emalon el Vigía de la Tormenta"
}

L:SetTimerLocalization{
	timerMobOvercharge	= "Explosión de Sobrecarga",
	EmalonEnrage		= "Rabia (Emalon)"
}

L:SetOptionLocalization{
	timerMobOvercharge	= "Mostrar temporizador para la explosión del Esbirro tempestuoso afectado por Sobrecarga",
	EmalonEnrage		= "Mostrar temporizador para $spell:26662",
	RangeFrame			= "Mostrar marco de distancia (10 m)"
}

------------------------------------
-- Koralon el Vigía de las Llamas --
------------------------------------
L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name = "Koralon el Vigía de las Llamas"
}

L:SetWarningLocalization{
	BurningFury		= "Furia ardiente >%d<"
}

L:SetTimerLocalization{
	KoralonEnrage	= "Rabia (Koralon)"
}

L:SetOptionLocalization{
	BurningFury			= "Mostrar aviso para $spell:66721",
	KoralonEnrage		= "Mostrar temporizador para $spell:26662"
}

L:SetMiscLocalization{
	Meteor	= "¡%s lanza Puños meteóricos!"
}

-------------------------------
-- Toravon el Vigía de Hielo --
-------------------------------
L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization{
	name = "Toravon el Vigía de Hielo"
}

L:SetWarningLocalization{
	Frostbite	= "Congelamiento en >%s< (%d)"
}

L:SetTimerLocalization{
	ToravonEnrage	= "Rabia (Toravon)"
}

L:SetOptionLocalization{
	Frostbite	= "Mostrar aviso para $spell:72004"
}

L:SetMiscLocalization{
	ToravonEnrage	= "Mostrar temporizador para $spell:26662"
}