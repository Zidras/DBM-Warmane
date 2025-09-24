if GetLocale() ~= "esES" then return end
local L

------------
-- Skeram --
------------
L = DBM:GetModLocalization("Skeram")

L:SetGeneralLocalization({
	name = "El profeta Skeram"
})

L:SetMiscLocalization({
	YellKillSkeram = "¡Únicamente estáis aplazando lo inevitable!"
})

----------------
-- Three Bugs --
----------------
L = DBM:GetModLocalization("ThreeBugs")

L:SetGeneralLocalization({
	name = "Realeza silítida"
})

L:SetMiscLocalization({
	Yauj = "Princesa Yauj",
	Vem = "Vem",
	Kri = "Lord Kri"
})

-------------
-- Sartura --
-------------
L = DBM:GetModLocalization("Sartura")

L:SetGeneralLocalization({
	name = "Guardia de batalla Sartura"
})

--------------
-- Fankriss --
--------------
L = DBM:GetModLocalization("Fankriss")

L:SetGeneralLocalization({
	name = "Fankriss el Implacable"
})

--------------
-- Viscidus --
--------------
L = DBM:GetModLocalization("Viscidus")

L:SetGeneralLocalization({
	name = "Viscidus"
})

L:SetWarningLocalization({
	WarnFreeze	= "Congelación: %d/3",
	WarnShatter	= "Hacerse añicos: %d/3"
})

L:SetOptionLocalization({
	WarnFreeze	= "Anunciar congelación",
	WarnShatter	= "Anunciar hacerse añicos"
})

L:SetMiscLocalization({
	Slow	= "comienza a remitir!",
	Freezing= "se queda inmóvil!",
	Frozen	= "está paralizada!",
	Phase4	= "empieza a desmoronarse!",
	Phase5	= "parece a punto de hacerse añicos!",
	Phase6	= "explota!",

	HitsRemain	= "Golpes restantes",
	Frost		= "Escarcha",
	Physical	= "Daño físico"
})

-------------
-- Huhuran --
-------------
L = DBM:GetModLocalization("Huhuran")

L:SetGeneralLocalization({
	name = "Princesa Huhuran"
})

---------------
-- Twin Emps --
---------------
L = DBM:GetModLocalization("TwinEmpsAQ")

L:SetGeneralLocalization({
	name = "Los Emperadores Gemelos"
})

L:SetMiscLocalization({
	Veklor = "Emperador Vek'lor",
	Veknil = "Emperador Vek'nilash"
})

------------
-- C'Thun --
------------
L = DBM:GetModLocalization("CThun")

L:SetGeneralLocalization({
	name = "C'Thun"
})

L:SetWarningLocalization({
	WarnEyeTentacle			= "Tentáculo ocular",
	WarnClawTentacle2		= "Tentáculo Garral",
	WarnGiantEyeTentacle	= "Tentáculo ocular gigante",
	WarnGiantClawTentacle	= "Tentáculo garral gigante",
	SpecWarnWeakened		= "¡C'Thun está débil!"
})

L:SetTimerLocalization({
	TimerEyeTentacle		= "Siguiente Tentáculo ocular",
	TimerClawTentacle		= "Siguiente Tentáculo Garral",
	TimerGiantEyeTentacle	= "Siguiente Tentáculo ocular gigante",
	TimerGiantClawTentacle	= "Siguiente Tentáculo garral gigante",
	TimerWeakened			= "Debilidad termina"
})

L:SetOptionLocalization({
	WarnEyeTentacle			= "Mostrar aviso cuando aparezca un Tentáculo ocular",
	WarnClawTentacle2		= "Mostrar aviso cuando aparezca un Tentáculo Garral",
	WarnGiantEyeTentacle	= "Mostrar aviso cuando aparezca un Tentáculo ocular gigante",
	WarnGiantClawTentacle	= "Mostrar aviso cuando aparezca un Tentáculo garral gigante",
	WarnWeakened			= "Mostrar aviso cuando C'Thun se vuelva débil",
	SpecWarnWeakened		= "Mostrar aviso especial cuando C'Thun se vuelva débil",
	TimerEyeTentacle		= "Mostrar temporizador para el siguiente Tentáculo ocular",
	TimerClawTentacle		= "Mostrar temporizador para el siguiente Tentáculo Garral",
	TimerGiantEyeTentacle	= "Mostrar temporizador para el siguiente Tentáculo ocular gigante",
	TimerGiantClawTentacle	= "Mostrar temporizador para el siguiente Tentáculo garral gigante",
	TimerWeakened			= "Mostrar temporizador para la duración de la debilidad de C'Thun",
	RangeFrame				= "Mostrar marco de distancia (10 m)"
})

L:SetMiscLocalization({
	Stomach		= "Estómago",
	Eye			= "Ojo de C'Thun",
	FleshTent	= "Tentáculo de carne",
	Weakened	= "está débil!",
	NotValid	= "AQ40 parcialmente limpiado. Quedan %s jefes opcionales."
})

----------------
-- Ouro --
----------------
L = DBM:GetModLocalization("Ouro")

L:SetGeneralLocalization({
	name = "Ouro"
})

L:SetWarningLocalization({
	WarnSubmerge		= "Ouro se sumerge",
	WarnEmerge			= "Ouro regresa"
})

L:SetTimerLocalization({
	TimerSubmerge		= "Sumersión",
	TimerEmerge			= "Emersión"
})

L:SetOptionLocalization({
	WarnSubmerge		= "Mostrar aviso cuando Ouro se sumerja",
	TimerSubmerge		= "Mostrar temporizador para cuando Ouro se sumerja",
	WarnEmerge			= "Mostrar aviso cuando Ouro regrese a la superficie",
	TimerEmerge			= "Mostrar temporizador para cuando Ouro regrese a la superficie"
})

----------------
-- AQ40 Trash --
----------------
L = DBM:GetModLocalization("AQ40Trash")

L:SetGeneralLocalization({
	name = "AQ40: Bichos"
})
