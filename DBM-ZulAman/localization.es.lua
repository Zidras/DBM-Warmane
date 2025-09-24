if GetLocale() ~= "esMX" or GetLocale() ~= "esES" then return end
local L

---------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk")

L:SetGeneralLocalization({
	name = "Nalorakk"
})

L:SetWarningLocalization({
	WarnBear		= "Forma de oso",
	WarnBearSoon	= "Forma de oso en 5 seg",
	WarnNormal		= "Forma normal",
	WarnNormalSoon	= "Forma normal en 5 seg"
})

L:SetTimerLocalization({
	TimerBear		= "Bär",
	TimerNormal		= "Normale Form"
})

L:SetOptionLocalization({
	WarnBear		= "Show warning for Bear form",--Translate
	WarnBearSoon	= "Show pre-warning for Bear form",--Translate
	WarnNormal		= "Show warning for Normal form",--Translate
	WarnNormalSoon	= "Show pre-warning for Normal form",--Translate
	TimerBear		= "Show timer for Bear form",--Translate
	TimerNormal		= "Show timer for Normal form"--Translate
})

L:SetMiscLocalization({
	YellPull	= "¡Moveos guardias! ¡Es hora de matar!", -- esES
--	YellPull	= "¡Muévanse guardias! ¡Es hora de matar!", -- esMX
	YellBear	= "¡Si llamáis a la bestia, vais a recibir más de lo que esperáis!",
	YellNormal	= "¡Dejad paso al Nalorakk!"
})

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon")

L:SetGeneralLocalization({
	name = "Akil'zon"
})

L:SetMiscLocalization({
	YellPull	= "¡Yo soy el depredador! Vosotros la presa...", -- esES
--	YellPull	= "¡Yo soy el depredador! Ustedes la presa...", -- esMX
})

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai")

L:SetGeneralLocalization({
	name = "Jan'alai"
})

L:SetMiscLocalization({
	YellPull	= "¡Los eh'píritus del viento serán vueh'tra perdición!", -- esES
--	YellPull	= "¡Los espíritus del viento serán su maldición!", -- esMX
	YellBomb	= "¡Ahora os quemaré!",
	YellAdds	= "¿Dónde está mi criador? ¡A por los huevos!"
})

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi")

L:SetGeneralLocalization({
	name = "Halazzi"
})

L:SetWarningLocalization({
	WarnSpirit	= "Sale espíritu",
	WarnNormal	= "Desaparece espíritu"
})

L:SetOptionLocalization({
	WarnSpirit	= "Show warning for Spirit phase",--Translate
	WarnNormal	= "Show warning for Normal phase"--Translate
})

L:SetMiscLocalization({
	YellPull	= "¡Arrodillaos... ante la garra y el colmillo!", -- esES
--	YellPull	= "¡Arrodíllense... ante la garra y el colmillo!", -- esMX
	YellSpirit	= "Lucho con libertad de espíritu...",
	YellNormal	= "¡Espíritu, vuelve a mí!"
})

--------------------------
--  Hex Lord Malacrass --
--------------------------
L = DBM:GetModLocalization("Malacrass")

L:SetGeneralLocalization({
	name = "Señor aojador Malacrass"
})

L:SetMiscLocalization({
	YellPull	= "Las sombras caerán sobre vosotros..."
})

--------------
--  Zul'jin --
--------------
L = DBM:GetModLocalization("ZulJin")

L:SetGeneralLocalization({
	name = "Zul'jin"
})

L:SetMiscLocalization({
--	YellPull	= "Nobody badduh dan me!",
	YellPhase2	= "Tengo algunos trucos nuevos... como mi hermano el oso...",
	YellPhase3	= "¡No podéis esconderos del águila!",
	YellPhase4	= "¡Dejad que os presente a mis nuevos hermanos: colmillo y garra!",
	YellPhase5	= "¡No tenéis que mirar al cielo para ver al dracohalcón!"
})
