if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Trash de la Ciudadela Inferior"
}

L:SetWarningLocalization{
	SpecWarnTrap		= "¡Trampa activada! ¡Sale un Depositario!"
}

L:SetOptionLocalization{
	SpecWarnTrap			= "Mostrar aviso especial cuando se active trampa",
	SetIconOnDarkReckoning	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
}

L:SetMiscLocalization{
	WarderTrap1		= "¿Quién... anda ahí?",
	WarderTrap2		= "Estoy despierto...",
	WarderTrap3		= "El sagrario del maestro ha sido perturbado."
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "Precioso y Apestoso"
}

L:SetWarningLocalization{
	WarnMortalWound	= "%s en >%s< (%d)",
	SpecWarnTrap	= "¡Trampa activada! ¡Salen Siegacarnes vengativos!"--creatureid 37038
}

L:SetOptionLocalization{
	SpecWarnTrap	= "Mostrar aviso especial cuando se active trampa",
	WarnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
}

L:SetMiscLocalization{
	FleshreaperTrap1		= "Rápido, ¡atacaremos por la espalda!",
	FleshreaperTrap2		= "¡No... puedes escapar!",
	FleshreaperTrap3		= "¿Los vivos? ¿¡Aquí!?"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name = "Trash de La Sala Carmsesí"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

---------------------------
--  Trash - Frostwing Hall  --
---------------------------
L = DBM:GetModLocalization("FrostwingHallTrash")

L:SetGeneralLocalization{
	name = "Trash de Las Cámaras de Alaescarcha"
}

L:SetWarningLocalization{
	SpecWarnGosaEvent	= "¡Guantelete de Sindragosa ha empezado!"
}

L:SetTimerLocalization{
	GosaTimer			= "Tiempo restante"
}

L:SetOptionLocalization{
	SpecWarnGosaEvent	= "Mostrar aviso especial para el guantelete de Sindragosa",
	GosaTimer			= "Mostrar tiempo para el evento del guantelete de Sindragosa"
}

L:SetMiscLocalization{
	SindragosaEvent		= "No debéis acercaros a la Reina de Escarcha. ¡Detenedlos, rápido!"
}


----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Tuetano"
}

L:SetTimerLocalization{
	AchievementBoned	= "Tiempo para liberar"
}

L:SetOptionLocalization{
	SetIconOnImpale			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Lady Susurramuerte"
}

L:SetTimerLocalization{
	TimerAdds	= "Nuevos Adds"
}

L:SetWarningLocalization{
	WarnReanimating				= "Resurreccion de Add",			-- Reanimating an adherent or fanatic
	WarnAddsSoon				= "Nuevos adds pronto",
	SpecWarnVengefulShade		= "¡Sombra vengativa te ataca! ¡Corre!",--creatureid 38222
	WeaponsStatus				= "Auto Unequipping enabled" --Needs Translating
}

L:SetOptionLocalization{
	WarnAddsSoon				= "Mostrar un pre-aviso cuando vengan nuevos adds ",
	WarnReanimating				= "Mostrar un aviso cuando un add sea resucitado",											-- Reanimated Adherent/Fanatic spawning
	TimerAdds					= "Mostrar tiempo para nuevos adds",
	SpecWarnVengefulShade		= "Mostrar aviso especial cuando te ataque una Sombra vengativa",--creatureid 38222
	WeaponsStatus				= "Special warning at combat start if unequip/equip function is enabled", --Needs Translating
	ShieldHealthFrame			= "Mostrar barra de vida del boss con una barra de vida para $spell:70842",
	SetIconOnDominateMind		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901),
	SoundWarnCountingMC			= "Play a 5 second audio countdown for Mind Control", --Needs Translating
	RemoveDruidBuff				= "Remove MotW / GotW 24 seconds into the fight", --Needs Translating
	EqUneqWeapons				= "Unequip/equip weapons if MC is cast on you. For equipping to work, create an equipment set called 'pve'.", --Needs Translating
	EqUneqTimer					= "Remove weapons by timer ALWAYS, not on cast (if ping is high). The option above must be enabled.", --Needs Translating
	BlockWeapons				= "Completely block the unequip/equip functions above" --Needs Translating
}

L:SetMiscLocalization{
	YellReanimatedFanatic	= "¡Álzate y goza de tu verdadera forma!",
	ShieldPercent			= "Barrera de maná",
	Fanatic1				= "Fanático del Culto",
	Fanatic2				= "Fanático deformado",
	Fanatic3				= "Fanático reanimado",
	setMissing				= "ATTENTION! DBM automatic weapon unequipping/equipping will not work until you create a equipment set named pve" --Needs Translating
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Batalla de naves de guerra"
}

L:SetWarningLocalization{
	WarnAddsSoon	= "Nuevos adds pronto"
}

L:SetOptionLocalization{
	WarnAddsSoon		= "Mostrar pre-aviso para la salida de nuevos adds",
	TimerAdds			= "Mostrar tiempo para nuevos adds"
}

L:SetTimerLocalization{
	TimerAdds			= "Nuevos adds"
}

L:SetMiscLocalization{
	PullAlliance	= "¡Arrancad motores! ¡Tenemos una cita con el destino, muchachos!",
	PullHorde		= "Rise up, sons and daughters of the Horde! Today we battle a hated enemy! LOK'TAR OGAR!!",--translate
	AddsAlliance	= "¡Atracadores, Sargentos, atacad!",
	AddsHorde		= "¡Atracadores, Marinos, atacad!",
	KillAlliance	= "¡No digáis que no lo avisé, sinvergüenzas! Adelante, hermanos.",
	KillHorde		= "The Alliance falter. Onward to the Lich King!"--translate
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Libramorte Colmillosauro"
}

L:SetOptionLocalization{
	BoilingBloodIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	RangeFrame			= "Mostrar distancia (12 yardas)",
	RunePowerFrame		= "Mostrar barra de vida + barra de $spell:72371"
}

L:SetMiscLocalization{
	RunePower			= "Poder de sangre",
	PullAlliance		= "Por cada soldado de la Horda que matasteis... Por cada perro de la Alianza que cayó, el ejército del Rey Exánime creció. Ahora, hasta las Val'kyr alzan a los caídos para la Plaga.",
	PullHorde			= "Kor'kron, move out! Champions, watch your backs! The Scourge have been..."--translate
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Panzachancro"
}

L:SetOptionLocalization{
	RangeFrame			= "Mostrar distancia (8 yardas)",
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279),
	AnnounceSporeIcons	= "Anunciar los iconos de los objetivos de $spell:69279 en el chat de banda\n(Necesita Anunciar habilitado y ayudante/líder de banda)",
	AchievementCheck	= "Anunciar fallo del logro 'Sin vacunas' a la banda\n(requiere líder/ayudante)"
}

L:SetMiscLocalization{
	SporeSet			= "Icono {rt%d} de espora de gas en %s",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d marcas de Inoculado <<"
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Caraputrea"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Sale moco pequeño",
	SpecWarnLittleOoze			= "¡Moco pequeño te ataca! ¡Corre!" --creatureid 36897
}

L:SetOptionLocalization{
	WarnOozeSpawn				= "Mostrar aviso cuando salgan mocos pequeños",
	SpecWarnLittleOoze			= "Mostrar aviso especial cuando te ataque un Moco pequeño",--creatureid 36897
	RangeFrame					= "Mostrar distancia (8 yardas)",
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	TankArrow					= "Mostrar flecha hacia el tanque del Moco grande (Experimental)"
}

L:SetMiscLocalization{
	YellSlimePipes1	= "¡Buenas noticias, amigos! He arreglado las tuberías de babosas venenosas.",	-- Professor Putricide
	YellSlimePipes2	= "¡Grandes noticias, amigos! Las babosas vuelven a fluir."	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professor Putricidio"
}

L:SetOptionLocalization{
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72856),
	MalleableGooIcon			= "Poner icono en el primero objetivo de $spell:72295",
	GooArrow					= "Mostrar flecha cuando $spell:72295 esté cerca de ti"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Concilio de los Príncipes de Sangre"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Cambiar objetivo a: %s",
	WarnTargetSwitchSoon	= "Cambiar de objetivo pronto"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Cambio de objetivo"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Mostrar aviso para cambiar de objetivos",
	WarnTargetSwitchSoon	= "Mostrar pre-aviso para cambiar de objetivos",
	TimerTargetSwitch		= "Mostrar tiempo para siguiente cambio de objetivo",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "Poner un icono en el príncipe con Invocación (Cruz)",
	RangeFrame				= "Mostrar distancia (12 yardas)",
	VortexArrow				= "Mostrar flecha cuando $spell:72037 esté cerca de ti"
}

L:SetMiscLocalization{
	Keleseth			= "Príncipe Keleseth",
	Taldaram			= "Príncipe Taldaram",
	Valanar				= "Príncipe Valanar",
	--FirstPull			= "Foolish mortals. You thought us defeated so easily? The San'layn are the Lich King's immortal soldiers! Now you shall face their might combined!", -- Needs Translating
	EmpoweredFlames		= "¡Llamas potenciadas arremeten contra (%S+)!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Reina de Sangre Lana'thel"
}

L:SetOptionLocalization{
	SetIconOnDarkFallen			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838),
	RangeFrame					= "Mostrar distancia (8 yardas)"
}

L:SetMiscLocalization{
	SwarmingShadows			= "¡Las sombras se acumulan alrededor de (%S+)!",
	YellFrenzy				= "¡Tengo hambre!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Caminasueños"
}

L:SetWarningLocalization{
	WarnCorrosion	= "%s en >%s< (%d)",
	WarnPortalOpen	= "Se abren los portales"
}

L:SetTimerLocalization{
	TimerPortalsOpen			= "Se abren los portales",
	TimerPortalsClose			= "Portals close", --Needs Translating
	TimerBlazingSkeleton		= "Siguiente Esqueleto llameante",
	TimerAbom					= "Siguiente Abominación",
	TimerSuppressorOne			= "1st wave of Suppressors", --Needs Translating
	TimerSuppressorTwo			= "2nd wave of Suppressors", --Needs Translating
	TimerSuppressorThree		= "3rd wave of Suppressors", --Needs Translating
	TimerSuppressorFour			= "4th wave of Suppressors" --Needs Translating
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Poner icono en Esqueleto llameante (calavera)",
	WarnPortalOpen				= "Mostrar aviso cuando $spell:72483 se abren",
	TimerPortalsOpen			= "Mostrar tiempo para la apertura de Portal Pesadilla",
	TimerPortalsClose			= "Show timer when Nightmare Portals are closed", --Needs Translating
	TimerBlazingSkeleton		= "Mostrar tiempo para la próxima salida de Esqueleto llameante",
	TimerAbom					= "Mostrar tiempo para siguiente Abominación glotona (Experimental)",
	Suppressors					= "Show special warning for new Suppressors", --Needs Translating
	TimerSuppressorOne			= "1st wave of Suppressors", --Needs Translating
	TimerSuppressorTwo			= "2nd wave of Suppressors", --Needs Translating
	TimerSuppressorThree		= "3rd wave of Suppressors", --Needs Translating
	TimerSuppressorFour			= "4th wave of Suppressors" --Needs Translating
}

L:SetMiscLocalization{
	YellPull		= "Han entrado intrusos en el Sagrario Interior. Apresuraos en acabar con el dragón verde. ¡Dejad solo huesos y tendones para la reanimación!",
	YellPortals		= "He abierto un portal al Sueño. Vuestra salvación está dentro, héroes...",
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Sindragosa"
}

L:SetWarningLocalization{
	WarnAirphase			= "Fase aerea",
	WarnGroundphaseSoon		= "Sindragosa aterriza pronto"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "Siguiente fase aerea",
	TimerNextGroundphase	= "Siguiente fase en el suelo",
	AchievementMystic		= "Tiempo para limpiar Sacudida Mística"
}

L:SetOptionLocalization{
	WarnAirphase				= "Anunciar fase aerea",
	WarnGroundphaseSoon			= "Mostrar pre-aviso para fase en el suelo",
	TimerNextAirphase			= "Mostrar tiempo para siguiente fase aerea",
	TimerNextGroundphase		= "Mostrar tiempo para siguiente fase en el suelo",
	AnnounceFrostBeaconIcons	= "Anunciar los iconos de los objetivos de $spell:70126 en el chat de banda\n(Requiere 'anunciar' activado y líder/ayudante)",
	SetIconOnFrostBeacon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase		= "Eliminar todos los iconos antes de la fase aerea",
	AchievementCheck			= "Anunciar avisos del logro 'Sacúdete' a la banda\n(Requiere líder/ayudante)",
	RangeFrame					= "Mostrar distancia (10 normal, 20 heroico)\n(Solo mostrará los jugadores marcados)"
}

L:SetMiscLocalization{
	YellAirphase		= "¡Aquí termina vuestra incursión! ¡Nadie sobrevivirá!",
	YellPhase2			= "¡Ahora sentid el poder sin fin de mi maestro y desesperad!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "Señal de Escarcha, icono {rt%d} en %s",
	AchievementWarning	= "Aviso: %s tiene 5 marcas de Sacudida mística",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d marcas de Sacudida mística <<"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "El Rey Exánime"
}

L:SetWarningLocalization{
	ValkyrWarning			= "¡>%s< ha sido agarrado!",
	SpecWarnYouAreValkd		= "¡Te agarra una Valkyr!",
	WarnNecroticPlagueJump	= "Peste necrótica saltó a >%s<",
	SpecWarnValkyrLow		= "Valkyr con menos del 55%"
}

L:SetTimerLocalization{
	TimerRoleplay				= "Diálogo",
	PhaseTransition				= "Transición de fase",
	TimerNecroticPlagueCleanse	= "Purgar Peste necrótica"
}

L:SetOptionLocalization{
	TimerRoleplay				= "Mostrar tiempo para Diálogo",
	WarnNecroticPlagueJump		= "Anunciar los objetivos donde $spell:73912 ha saltado",
	TimerNecroticPlagueCleanse	= "Mostrar tiempo para purgar Peste necrótica\nantes de la primera marca",
	PhaseTransition				= "Mostrar tiempo para las transiciones de fase",
	ValkyrWarning				= "Anunciar quien ha sido agarrado por las Valkyr",
	SpecWarnYouAreValkd			= "Mostrar aviso especial cuando seas agarrado por una Valkyr",
	DefileIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	NecroticPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912),
	RagingSpiritIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	HarvestSoulIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74327),
	TrapArrow					= "Mostrar flecha cuando $spell:73539 está cerca de ti",
	AnnounceValkGrabs			= "Aunciar el objetivo de Guardia de las Sombras Val'kyr en el chat de banda\n(necesita 'anunciar' activado y líder/ayudante)",
	SpecWarnValkyrLow			= "Mostrar aviso especial cuando la Valkyr está por debajo del 55%",
	AnnouncePlagueStack			= "Anunciar las marcas de $spell:73912 a la banda (10 marcas, cada 5 después)\n(requiere líder/ayudante)",
	ShowFrame					= "Show Val'Kyr Targets frame", --Needs Translating
	FrameClassColor				= "Use Class Colors in Val'Kyr Targets frame", --Needs Translating
	FrameUpwards				= "Expand Val'Kyr target frame upwards", --Needs Translating
	FrameLocked					= "Lock Val'Kyr Targets frame", --Needs Translating
	RemoveImmunes				= "Remove immunity spells before exiting Frostmourne room" --Needs Translating
}

L:SetMiscLocalization{
	LKPull					= "¿Así que por fin ha llegado la elogiada justicia de la Luz? ¿Debería deponer la Agonía de Escarcha y confiar en tu piedad, Vadín?",
	LKRoleplay				= "¿Me pregunto si de verdad os mueve la... rectitud?",
	ValkGrabbedIcon			= "Val'kyr {rt%d} ha agarrado a %s",
	ValkGrabbed				= "Val'kyr ha agarrado a %s",
	PlagueStackWarning		= "Aviso: %s tiene %d marcas de Peste Necrótica",
	AchievementCompleted	= ">> LOGRO COMPLETADO: %s tiene %d marcas de Peste Necrótica <<"
	FrameTitle				= "Valkyr targets",
	FrameLock				= "Frame Lock",
	FrameClassColor			= "Use Class Colors",
	FrameOrientation		= "Expand upwards",
	FrameHide				= "Hide Frame",
	FrameClose				= "Close"
}
