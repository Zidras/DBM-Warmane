if GetLocale() ~= "esES" then return end
local L

----------------
--  Lucifron  --
----------------
L = DBM:GetModLocalization("Lucifron")

L:SetGeneralLocalization({
	name = "Lucifron"
})

----------------
--  Magmadar  --
----------------
L = DBM:GetModLocalization("Magmadar")

L:SetGeneralLocalization({
	name = "Magmadar"
})

----------------
--  Gehennas  --
----------------
L = DBM:GetModLocalization("Gehennas")

L:SetGeneralLocalization({
	name = "Gehennas"
})

------------
--  Garr  --
------------
L = DBM:GetModLocalization("Garr-Classic")

L:SetGeneralLocalization({
	name = "Garr"
})

--------------
--  Geddon  --
--------------
L = DBM:GetModLocalization("Geddon")

L:SetGeneralLocalization({
	name = "Barón Geddon"
})

----------------
--  Shazzrah  --
----------------
L = DBM:GetModLocalization("Shazzrah")

L:SetGeneralLocalization({
	name = "Shazzrah"
})

----------------
--  Sulfuron  --
----------------
L = DBM:GetModLocalization("Sulfuron")

L:SetGeneralLocalization({
	name = "Sulfuron Presagista"
})

----------------
--  Golemagg  --
----------------
L = DBM:GetModLocalization("Golemagg")

L:SetGeneralLocalization({
	name = "Golemagg el Incinerador"
})

-----------------
--  Majordomo  --
-----------------
L = DBM:GetModLocalization("Majordomo")

L:SetGeneralLocalization({
	name = "Mayordomo Executus"
})

L:SetTimerLocalization({
	timerShieldCD		= "Próximo Escudo"
})

L:SetOptionLocalization({
	timerShieldCD		= "Mostrar temporizador para el próximo Escudo de daño/reflejo"
})

----------------
--  Ragnaros  --
----------------
L = DBM:GetModLocalization("Ragnaros-Classic")

L:SetGeneralLocalization({
	name = "Ragnaros"
})

L:SetWarningLocalization({
	WarnSubmerge		= "Ragnaros se sumerge",
	WarnEmerge			= "Ragnaros ha regresado"
})

L:SetTimerLocalization({
	TimerSubmerge		= "Sumersión",
	TimerEmerge			= "Emersión"
})

L:SetOptionLocalization({
	WarnSubmerge		= "Mostrar aviso cuando Ragnaros se sumerja",
	TimerSubmerge		= "Mostrar temporizador para cuando Ragnaros se sumerja",
	WarnEmerge			= "Mostrar aviso cuando Ragnaros regrese a la superficie",
	TimerEmerge			= "Mostrar temporizador para cuando Ragnaros regrese a la superficie"
})

L:SetMiscLocalization({
	Submerge	= "¡AVANZAD, MIS SIRVIENTES! ¡DEFENDED A VUESTRO MAESTRO!",
	Submerge2	= "¡NO PODÉIS VENCER A LA LLAMA VIVIENTE! ¡VENID, ESCLAVOS DEL FUEGO! ¡AVANZAD, CRIATURAS DEL ODIO! ¡VUESTRO MAESTRO OS LLAMA!",
	Pull		= "¡Crías imprudentes! ¡Os habéis precipitado hasta vuestra propia muerte! ¡Ahora mirad, el maestro se agita!"
})

-----------------
--  MC: Trash  --
-----------------
L = DBM:GetModLocalization("MCTrash")

L:SetGeneralLocalization({
	name = "NM: Bichos"
})
