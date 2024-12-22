if GetLocale() ~= "esES" then return end

local L

-------------------------------
-- Las bestias de Rasganorte --
-------------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization({
	name = "Las bestias de Rasganorte"
})

L:SetWarningLocalization({
	WarningSnobold		= "Vasallo snóbold en >%s<"
})

L:SetTimerLocalization({
	TimerNextBoss		= "Siguiente jefe"
--	TimerEmerge			= "Emersión",
--	TimerSubmerge		= "Sumersión"
})

L:SetOptionLocalization({
	soundConcAuraMastery= "Reproducir el sonido de $spell:31821 para anular los efectos de $spelll:66330 (sólo para el |cFFF48CBAPaladín|r que es el propietario de $spell:19746)",
	WarningSnobold		= "Mostrar aviso cuando aparezca un Vasallo snóbold",
	PingCharge			= "Pulsar en el Minimapa si Aullahielo va a por Ti",
	ClearIconsOnIceHowl	= "Quitar todos los iconos antes de cada carga",
	TimerNextBoss		= "Mostrar temporizador para el siguiente jefe",
--	TimerEmerge			= "Mostrar temporizador para cuando Fauceácida y Aterraescama regresen a la superficie",
--	TimerSubmerge		= "Mostrar temporizador para cuando Fauceácida y Aterraescama se sumerjan en la tierra",
	IcehowlArrow		= "Mostrar flecha cuando Aullahielo vaya a cargar hacia ti"
})

L:SetMiscLocalization({
	Charge				= "¡%%s mira a (%S+) y emite un bramido!",
	CombatStart			= "Desde las cavernas más oscuras y profundas de Las Cumbres Tormentosas: ¡Gormok el Empalador! ¡A luchar, héroes!",
	Phase2				= "Preparaos, héroes, para los temibles gemelos: ¡Fauceácida y Aterraescama! ¡A la arena!",
	Phase3				= "El propio aire se congela al presentar a nuestro siguiente combatiente: ¡Aullahielo! ¡Matad o morid, campeones!",
	Gormok				= "Gormok el Empalador",
	Acidmaw				= "Fauceácida",
	Dreadscale			= "Aterraescama",
	Icehowl				= "Aullahielo"
})

-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization({
	name = "Lord Jaraxxus"
})

L:SetOptionLocalization({
	IncinerateShieldFrame	= "Mostrar salud del jefe en una barra de vida durante Incinerar carne"
})

L:SetMiscLocalization({
	IncinerateTarget		= "Incinerar carne: %s",
	FirstPull				= "El gran brujo Wilfred Chispobang invocará al siguiente contrincante. Esperad a que aparezca."
})

-----------------------------
-- Campeones de la facción --
-----------------------------
L = DBM:GetModLocalization("Champions")

local champions = "Campeones de la facción"
if UnitFactionGroup("player") == "Alliance" then
	champions = "Campeones de la Horda"
elseif UnitFactionGroup("player") == "Horde" then
	champions = "Campeones de la Alianza"
end

L:SetGeneralLocalization({
	name = champions
})

L:SetMiscLocalization({
	--Horde NPCs
	Gorgrim				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:64:64:96|t Gorgrim Rajasombra",			-- 34458
	Birana				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Birana Pezuña Tempestuosa",-- 34451
	Erin				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Erin Pezuña de Niebla",	-- 34459
	Rujkah				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t Ruj'kah",						-- 34448
	Ginselle			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:0:32|t Ginselle Lanzaañublo",		-- 34449
	Liandra				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Liandra Clamasol",			-- 34445
	Malithas			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Malithas Hoja Brillante",		-- 34456
	Caiphus				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Caiphus el Austero",		-- 34447
	Vivienne			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Vivienne Susurro Oscuro",	-- 34441
	Mazdinah			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:0:32|t Maz'dinah",					-- 34454
	Thrakgar			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Thrakgar",					-- 34444
	Broln				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Broln Cuernorrecio",		-- 34455
	Harkzog				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:32:64|t Harkzog",					-- 34450
	Narrhok				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:0:32|t Narrhok Rompeacero",			-- 34453
	--Alliance NPCs
	Tyrius				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:64:64:96|t Tyrius Hoja Umbría",			-- 34461
	Kavina				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Kavina Canto Arboleda",	-- 34460
	Melador				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t Melador Caminavalles",		-- 34469
	Alyssia				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t Alyssia Acechalunas",			-- 34467
	Noozle				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:0:32|t Noozle Varapalo",			-- 34468
	Baelnor				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Baelnor Portador de la Luz",	-- 34471
	Velanaa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t Velanaa",						-- 34465
	Anthar				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Anthar Ensalmaforja",		-- 34466
	Brienna				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t Brienna Talanoche",		-- 34473
	Irieth				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:0:32|t Irieth Paso Sombrío",		-- 34472
	Saamul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Saamul",					-- 34470
	Shaabad				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t Shaabad",					-- 34463
	Serissa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:32:64|t Serissa Desventura",		-- 34474
	Shocuul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:0:32|t Shocuul",						-- 34475

	AllianceVictory		= "¡GLORIA A LA ALIANZA!",
	--AllianceVictory	= "¡GLORIA PARA LA ALIANZA!" -- esMX
	HordeVictory		= "Eso solo ha sido una muestra de lo que depara el futuro. ¡POR LA HORDA!"
	--HordeVictory		= "Eso es sólo una probada de lo que traerá el futuro. ¡POR LA HORDA!" -- esMX
	--YellKill			= "Una victoria trágica y fútil. Hoy somos menos por las pérdidas que hemos sufrido. ¿Quién podría beneficiarse de tal insensatez además del Rey Exánime? Grandes guerreros han perdido la vida. ¿Y para qué? La verdadera amenaza aguarda, el Rey Exánime nos espera a todos en la muerte."
	--YellKill			= "Una victoria trágica y superficial. Nuestra integridad se vio debilitada por las pérdidas que hoy sufrimos. ¿Quién más que el Rey Exánime puede haberse beneficiado de tal insensatez? Grandes guerreros han perdido sus vidas. ¿Y para qué? La verdadera amenaza se entreteje en el futuro: el Rey Exánime nos espera en la muerte." -- esMX
})

L:SetOptionLocalization({
	PlaySoundOnBladestorm	= "Reproducir sonido en Filotormenta"
})

---------------------
-- Gemelas Val'kyr --
---------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization({
	name = "Gemelas Val'kyr"
})

L:SetWarningLocalization({
	WarnSpecialSpellSoon		= "Facultad especial en breve",
	SpecWarnSpecial				= "Cambia de color",
	SpecWarnSwitchTarget		= "Cambia de objetivo",
	SpecWarnKickNow				= "Interrumpe ahora",
	WarningTouchDebuff			= "Perjuicio en >%s<",
	WarningPoweroftheTwins2		= "Poder de las Gemelas - ¡más sanación en >%s<!"
})

L:SetTimerLocalization({
	TimerSpecialSpell			= "Siguiente facultad especial",
	TimerAnubRoleplay			= "El piso se rompe en"
})

L:SetOptionLocalization({
	TimerSpecialSpell			= "Mostrar temporizador para la siguiente facultad especial",
	TimerAnubRoleplay			= "Mostrar temporizador de diálogo de El Rey Exánime rompiendo el piso",
	WarnSpecialSpellSoon		= "Mostrar aviso previo para la siguiente facultad especial",
	SpecWarnSpecial				= "Mostrar aviso especial cuando debas cambiar de color",
	SpecWarnSwitchTarget		= "Mostrar aviso especial cuando la otra gemela esté lanzando un hechizo",
	SpecWarnKickNow				= "Mostrar aviso especial cuando debas interrumpir",
	SpecialWarnOnDebuff			= "Mostrar aviso especial cuando estés afectado por un perjuicio (para cambiarlo por otro)",
	SetIconOnDebuffTarget		= "Poner iconos en los objetivos de los perjuicios de $spell:65950 y $spell:66001 (dificultad heroica)",
	WarningTouchDebuff			= "Anunciar objetivos de los perjuicios de $spell:65950 y $spell:66001",
	WarningPoweroftheTwins2		= "Anunciar la gemela afectada por $spell:65916"
})

L:SetMiscLocalization({
--	YellPull	= "En el nombre de nuestro oscuro maestro. Por el Rey Exánime. Morirás.",
--	CombatStart	= "Solo superaréis el reto final si trabajáis juntos. Desde las profundidades de Corona de Hielo, llegan dos de los tenientes más poderosos de la Plaga: las temibles Val'kyr, presagistas aladas del Rey Exánime.",	-- esES
--	CombatStart	= "Sólo trabajando juntos superarán el desafío final. De las profundidades de Corona de Hielo llegan estos poderosos tenientes de la Plaga: ¡los val'kyres, heraldos alados del Rey Exánime!",	-- esMX
	Fjola		= "Fjola Penívea",
	Eydis		= "Eydis Penaumbra",
	ValksRP		= "¡Que comiencen los juegos!", -- 35709
	AnubRP		= "¡Se ha asestado un gran golpe al Rey Exánime! Habéis demostrado ser diestros campeones de la Cruzada Argenta. ¡Juntos atacaremos la Ciudadela de la Corona de Hielo y acabaremos con lo que queda de la Plaga! ¡No hay ningún reto al que no podamos enfrentarnos si estamos unidos!" -- esES
--	AnubRP		= "¡El Rey Exánime ha sufrido un poderoso revés! Han demostrado ser campeones dignos de la Cruzada Argenta. ¡Juntos atacaremos la Ciudadela Corona de Hielo y destruiremos lo que queda de la Plaga! ¡No existe el desafío que no podamos enfrentar unidos!"	-- esMX
})

---------------
-- Anub'arak --
---------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization({
	name					= "Anub'arak"
})

--L:SetTimerLocalization({
--	TimerEmerge				= "Emersión",
--	TimerSubmerge			= "Sumersión",
--	timerAdds				= "Siguientes esbirros"
--})

L:SetWarningLocalization({
	WarnEmerge				= "Anub'arak regresa a la superficie",
	WarnEmergeSoon			= "Emersión en 10 s",
	WarnSubmerge			= "Anub'arak se entierra en el suelo",
	WarnSubmergeSoon		= "Sumersión en 10 s",
	warnAdds				= "Siguientes esbirros"
})

L:SetMiscLocalization({
--	YellPull				= "¡Este lugar será vuestra tumba!",
	Emerge				= "emerge de la tierra!",
	Burrow				= "se entierra en el suelo!",
	YellBurrow			= "Auum na-l ak-k-k-k, isshhh. Alzaos, esbirros. Devorad…",
--	YellBurrow			= "Auum na-l ak-k-k-k, isshhh. Despierten, lacayos. Devoren…" --esMX
	PcoldIconSet		= "Icono {rt%d} colocado en %s",
	PcoldIconRemoved	= "Icono quitado en %s"
})

L:SetOptionLocalization({
	WarnEmerge				= "Mostrar aviso cuando Anub'arak regrese a la superficie",
	WarnEmergeSoon			= "Mostrar aviso previo para cuando Anub'arak regrese a la superficie",
	WarnSubmerge			= "Mostrar aviso cuando Anub'arak se entierre en el suelo",
	WarnSubmergeSoon		= "Mostrar aviso previo para cuando Anub'arak se entierre en el suelo",
	warnAdds				= "Anunciar cuando aparezcan esbirros",
--	timerAdds				= "Mostrar temporizador para los siguientes esbirros",
--	TimerEmerge				= "Mostrar temporizador para cuando Anub'arak regrese a la superficie",
--	TimerSubmerge			= "Mostrar temporizador para cuando Anub'arak se entierre en el suelo",
	AnnouncePColdIcons		= "Anunciar iconos de los objetivos de $spell:66013 en el chat de banda (requiere líder o ayudante)",
	AnnouncePColdIconsRemoved	= "Anunciar iconos quitados de los objetivos de $spell:66013 (requiere que la opción anterior esté habilitada)",
	RemoveHealthBuffsInP3	= "Quitar bufos de vida al inicio de la fase 3"
})
