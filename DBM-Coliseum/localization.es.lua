if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

-------------------------------
-- Las bestias de Rasganorte --
-------------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Las bestias de Rasganorte"
}

L:SetWarningLocalization{
	WarningSnobold		= "Vasallo snóbold en >%s<"
}

L:SetTimerLocalization{
	TimerNextBoss		= "Siguiente jefe",
	TimerEmerge			= "Emersión",
	TimerSubmerge		= "Sumersión"
}

L:SetOptionLocalization{
	WarningSnobold		= "Mostrar aviso cuando aparezca un Vasallo snóbold",
	PingCharge			= "Pulsar en el Minimapa si Aullahielo va a por Ti",
	ClearIconsOnIceHowl	= "Quitar todos los iconos antes de cada carga",
	TimerNextBoss		= "Mostrar temporizador para el siguiente jefe",
	TimerEmerge			= "Mostrar temporizador para cuando Fauceácida y Aterraescama regresen a la superficie",
	TimerSubmerge		= "Mostrar temporizador para cuando Fauceácida y Aterraescama se sumerjan en la tierra",
	IcehowlArrow		= "Mostrar flecha cuando Aullahielo vaya a cargar hacia ti"
}

L:SetMiscLocalization{
	Charge				= "¡Aullahielo mira a (%S+) y emite un bramido!",
	CombatStart			= "Desde las cavernas más oscuras y profundas de Las Cumbres Tormentosas: ¡Gormok el Empalador! ¡A luchar, héroes!",
	Phase2				= "Preparaos, héroes, para los temibles gemelos: ¡Fauceácida y Aterraescama! ¡A la arena!",
	Phase3				= "El propio aire se congela al presentar a nuestro siguiente combatiente: ¡Aullahielo! ¡Matad o morid, campeones!",
	Gormok				= "Gormok el Empalador",
	Acidmaw				= "Fauceácida",
	Dreadscale			= "Aterraescama",
	Icehowl				= "Aullahielo"
}

-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetOptionLocalization{
	IncinerateShieldFrame	= "Mostrar salud del jefe en una barra de vida durante Incinerar carne"
}

L:SetMiscLocalization{
	IncinerateTarget		= "Incinerar carne: %s",
	FirstPull				= "El gran brujo Wilfred Chispobang invocará al siguiente contrincante. Esperad a que aparezca."
}

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

L:SetGeneralLocalization{
	name = champions
}

L:SetMiscLocalization{
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
	Alyssia             = "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t Alyssia Acechalunas",			-- 34467
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
}

L:SetOptionLocalization{
	PlaySoundOnBladestorm	= "Reproducir sonido en Filotormenta"
}

------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "Gemelas Val’kyrs"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Siguiente Habilidad especial"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Habilidad especial pronto!",
	SpecWarnSpecial				= "Cambia color!",
	SpecWarnSwitchTarget		= "Cambio!",
	SpecWarnKickNow				= "Cortar ahora!",
	WarningTouchDebuff			= "Debuff en >%s<",
	WarningPoweroftheTwins		= "Pacto de las Gemelas - curar mas a >%s<",
	SpecWarnPoweroftheTwins		= "Pacto de las Gemelas!"
}

L:SetMiscLocalization{
	YellPull 	= "En el nombre de nuestro oscuro maestro. Por el Rey Exánime. Morirás.",
	--CombatStart	= "Only by working together will you overcome the final challenge. From the depths of Icecrown come two of the Scourge's most powerful lieutenants: fearsome val'kyr, winged harbingers of the Lich King!", -- Needs translating
	Fjola 		= "Fjola Penívea",
	Eydis		= "Eydis Penalumbra"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Mostrar tiempo para la siguiente habilidad especial",
	WarnSpecialSpellSoon		= "Pre-aviso para la siguiente habilidad especial",
	SpecWarnSpecial				= "Mostrar aviso especial si tienes que cambiar de color",
	SpecWarnSwitchTarget		= "Mostrar aviso especial si hay que ir al otro boss",
	SpecWarnKickNow				= "Mostrar aviso especial cuando tienes que cortar el hechizo",
	SpecialWarnOnDebuff			= "Mostrar aviso especial cuando tienes que cambiar de debuff",
	SetIconOnDebuffTarget		= "Poner iconos a los objetivos con debuff ( solo heroico )",
	WarningTouchDebuff			= "Anunciar objetivos del debuff de Toque de Luz/Oscuridad",
	WarningPoweroftheTwins		= "Anunciar objetivo de Pacto de las Gemelas",
	SpecWarnPoweroftheTwins		= "Mostrar aviso especial si eres el tank y estas en una gemela con el pacto de las gemelas"
}

------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge				= "Emerger en",
	TimerSubmerge			= "Sumersion en",
	timerAdds				= "Nuevos adds"
}

L:SetWarningLocalization{
	WarnEmerge				= "Anub'arak emerge",
	WarnEmergeSoon			= "Emerger en 10 seg",
	WarnSubmerge			= "Anub'arak se sumerge",
	WarnSubmergeSoon		= "Sumersion en 10 seg",
	specWarnSubmergeSoon	= "Sumersion en 10 segundos!",
	SpecWarnPursue			= "¡Te persigue a ti!",
	warnAdds				= "Nuevos adds",
	SpecWarnShadowStrike	= "¡Golpe de sombras! ¡Corta ahora!"
}

L:SetMiscLocalization{
	YellPull				= "¡Este lugar será vuestra tumba!",
	Emerge					= "emerge",
	Burrow					= "entierra",
	PcoldIconSet			= "Icono FrioP {rt%d} puesto en %s",
	PcoldIconRemoved		= "Icono FrioP eliminado de %s"
}

L:SetOptionLocalization{
	WarnEmerge					= "Mostrar aviso para Emerger",
	WarnEmergeSoon				= "Mostrar pre-aviso para Emerger",
	WarnSubmerge				= "Mostrar aviso para Sumersion",
	WarnSubmergeSoon			= "Mostrar pre-aviso para Sumersion",
	specWarnSubmergeSoon		= "Mostrar pre-aviso especial Sumersion",
	SpecWarnPursue				= "Mostrar aviso especial si te sigue a ti",
	warnAdds					= "Mostrar aviso para nuevos adds",
	timerAdds					= "Mostrar tiempo para nuevos adds",
	TimerEmerge					= "Mostrar tiempo para Emerger",
	TimerSubmerge				= "Mostrar tiempo para Sumerger",
	PlaySoundOnPursue			= "Reproducir sonidos si te persigue",
	PursueIcon					= "Poner icono en jugador",
	SpecWarnShadowStrike		= "Mostrar aviso especial para Golpe de sombras ( para cortar )",
	RemoveHealthBuffsInP3		= "Quitar bufos de vida al inicio de la fase 3",
	SetIconsOnPCold				= "Poner iconos en los objetivos de $spell:68510",
	AnnouncePColdIcons			= "Anunciar iconos para los ojetivos de $spell:68510 en el chat de banda\n(Requiere 'anunciar' habilitado y lider o ayudante)",
	AnnouncePColdIconsRemoved	= "También anunciar cuando se eliminen los iconos de los objetivos $spell:68510\n(Necesita la opción anterior)"
}
