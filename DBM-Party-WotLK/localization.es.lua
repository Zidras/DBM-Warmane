if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

---------------------------------
-- Ahn'Kahet: El Antiguo Reino --
---------------------------------
-----------------------
-- Príncipe Taldaram --
-----------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "Príncipe Taldaram"
})

--------------------
-- Ancestro Nadox --
--------------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "Ancestro Nadox"
})

-------------------------
-- Jedoga Buscasombras --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "Jedoga Buscasombras"
})

--------------------
-- Heraldo Volazj --
--------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "Heraldo Volazj"
})

--------------
-- Amanitar --
--------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "Amanitar"
})

-----------------
-- Azjol-Nerub --
-----------------
---------------
-- Krik'thir --
---------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "Krik'thir el Vigía..."
})

--------------
-- Hadronox --
--------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "Hadronox"
})

---------------
-- Anub'arak --
---------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "Anub'arak H"
})

------------------------------
-- La Matanza de Stratholme --
------------------------------
------------
-- Gancho --
------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "Gancho"
})

--------------
--  Salramm --
--------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "El Modelador de carne"
})

-----------------------
--  Cronolord Época  --
-----------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "Cronolord Época"
})

-----------------
--  Mal'Ganis  --
-----------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "Mal'Ganis"
})

L:SetMiscLocalization({
	Outro	= "Tu viaje acaba de comenzar, joven Príncipe. Reúne a tus tropas y ven a verme en las árticas tierras de Rasganorte. Allí ajustaremos cuentas. Allí es donde se desvelará tu verdadero destino."
	-- esMX: "Recién comienza tu viaje, joven príncipe. Reúne a tus fuerzas y encuéntrame en las tierras árticas de Rasganorte. Allí será donde saldaremos nuestras cuentas pendientes, y donde se revelará tu verdadero destino."
})

-------------------------------
-- Temporizadores de oleadas --
-------------------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "Oleadas de Stratholme"
})

L:SetWarningLocalization({
	WarningWaveNow		= "Oleada %d: %s"
})

L:SetTimerLocalization({
	TimerWaveIn	=	"Siguiente oleada (6)",
	TimerRoleplay	= "Diálogo"
})

L:SetOptionLocalization({
	WarningWaveNow	= "Mostrar avisos para nuevas oleadas",
	TimerWaveIn		= "Mostrar temporizador para próximas oleadas (despues del jefe de la quinta oleada)",
	TimerRoleplay	= "Mostrar temporizador para el diálogo inicial"
})

L:SetMiscLocalization({
	Meathook	= "Gancho",
	Salramm		= "Salramm el Modelador de carne",
	Devouring	= "Necrófago devorador",
	Enraged		= "Necrófago iracundo",
	Necro		= "Nigromante oscuro",
	Fiend		= "Maligno de cripta",
	Stalker		= "Acechador de tumbas",
	Abom		= "Ensamblaje de retazos",
	Acolyte		= "Acólito",
	Wave1		= "%d %s",
	Wave2		= "%d %s and %d %s",
	Wave3		= "%d %s, %d %s and %d %s",
	Wave4		= "%d %s, %d %s, %d %s and %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "Oleada de la Plaga = (%d+)/10",
	Roleplay	= "Me alegra que lo consiguieras, Uther.",
	Roleplay2	= "Parece que todo el mundo está listo. Recordad, esta gente está infectada por la peste y pronto morirá. Debemos purgar Stratholme para proteger de la Plaga lo que queda de Lordaeron. Vamos."
})

------------------------------
-- Fortaleza de Drak'Tharon --
------------------------------
----------------
-- Cuernotrol --
----------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "Cuernotrol"
})

L:SetMiscLocalization({
	YellExplosion = "¡Cueh'po háse bum!"
})

------------------------
-- Novos el Invocador --
------------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "Novos el Invocador"
})

L:SetWarningLocalization({
	WarnCrystalHandler	= "Sale un Manipulador de cristal (quedan %d)"
})

L:SetTimerLocalization({
	timerCrystalHandler	= "Sale Manipulador de cristal"
})

L:SetOptionLocalization({
	WarnCrystalHandler	= "Mostrar aviso cuando sale Manipulador de cristal",
	timerCrystalHandler	= "Mostrar tiempo para próximo Manipulador de cristal"
})

L:SetMiscLocalization({
	YellPull		= "¡El frío que sentís es el presagio de vuestro sino!",
	HandlerYell		= "¡Refuerza mis defensas! ¡Deprisa, maldito!",
	Phase2			= "¡Seguro que ahora veis la inutilidad de todo ello!",
	YellKill		= "Vos efforts sont... vains."
})

--------------
-- Rey Dred --
--------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "Rey Dred"
})

--------------------------
-- El profeta Tharon'ja --
--------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "El profeta Tharon'ja"
})

-------------
-- Gundrak --
-------------
--------------
-- Slad'ran --
--------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "Slad'ran"
})

-------------
-- Moorabi --
-------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "Moorabi"
})

---------------------
-- Coloso Drakkari --
---------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "Coloso Drakkari"
})

L:SetWarningLocalization({
	WarningElemental	= "Fase 2: El elemental",
	WarningStone		= "Fase 1: El coloso"
})

L:SetOptionLocalization({
	WarningElemental	= "Mostrar aviso para Fase 2: El elemental",
	WarningStone		= "Mostrar aviso para Fase 1: El coloso"
})

---------------
-- Gal'darah --
---------------
L = DBM:GetModLocalization("Galdarah")

L:SetGeneralLocalization({
	name = "Gal'darah"
})

L:SetWarningLocalization({
	TimerPhase2		= "Fase 2: El avatar de Akali",
	TimerPhase1		= "Fase 1: Gran profeta de Akali"
})

L:SetTimerLocalization({
	TimerPhase2		= "Fase 2: El avatar de Akali",
	TimerPhase1		= "Fase 1: Gran profeta de Akali"
})

L:SetOptionLocalization({
	TimerPhase2		= "Mostrar aviso para Fase 2: El avatar de Akali",
	TimerPhase1		= "Mostrar aviso para Fase 1: Gran profeta de Akali"
})

L:SetMiscLocalization({
	YellPhase2_1	= "¡No quedará ni rastro después de esto!", --esMX: ¡Después de esto no quedar nada!
	YellPhase2_2	= "¿Queréis ver poder? ¡OS MOSTRARÉ PODER!" --esMX: ¿Tú querer ver poder? ¡TE MOSTRARÉ PODER!
})

------------------
-- Eck el Feroz --
------------------
L = DBM:GetModLocalization("Eck")

L:SetGeneralLocalization({
	name = "Eck el Feroz"
})

---------------------------
-- Cámaras de Relámpagos --
---------------------------
-----------------------
-- General Bjarngrim --
-----------------------
L = DBM:GetModLocalization("Bjarngrin")

L:SetGeneralLocalization({
	name = "General Bjarngrim"
})

-----------
-- Ionar --
-----------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "Ionar"
})

-------------
-- Volkhan --
-------------
L = DBM:GetModLocalization("Volkhan")

L:SetGeneralLocalization({
	name = "Volkhan"
})

-----------
-- Loken --
-----------
L = DBM:GetModLocalization("Loken")

L:SetGeneralLocalization({
	name = "Loken"
})

-----------------------
-- Cámaras de Piedra --
-----------------------
----------------------
-- Doncella de Pena --
----------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "Doncella de Pena"
})

----------------
-- Krystallus --
----------------
L = DBM:GetModLocalization("Krystallus")

L:SetGeneralLocalization({
	name = "Krystallus"
})

-------------------------
-- Sjonnir el Afilador --
-------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "Sjonnir el Afilador"
})

--------------------------------
-- El Tribunal de los Tiempos --
--------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "Salvar a Brann"
})

L:SetWarningLocalization({
	WarningPhase	= "Fase %d"
})

L:SetTimerLocalization({
	timerEvent	= "Tiempo restante"
})

L:SetOptionLocalization({
	WarningPhase	= "Mostrar aviso para el cambio de fase",
	timerEvent		= "Mostrar tiempo restante del evento"
})

L:SetMiscLocalization({
	Pull	= "¡Atentos! Tendré esto listo en un par de...",
	Phase1	= "Incumplimiento del código de seguridad en progreso. Análisis de los archivos históricos relegado a la cola de menor prioridad. Contramedidas activadas.",
	Phase2	= "Límite de índice de amenaza superado. Archivo celestial cancelado. Nivel de seguridad aumentado.",
	Phase3	= "Índice de amenaza crítico. Análisis del vacío desviado. Iniciando protocolo de higienización.",
	Kill	= "Alerta: sistema de seguridad desactivado. Comenzando purga de memoria y..."
})

-------------
-- El Nexo --
-------------
--------------
-- Anomalus --
--------------
L = DBM:GetModLocalization("Anomalus")

L:SetGeneralLocalization({
	name = "Anomalus"
})

------------------------
-- Ormorok el Talador --
------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "Ormorok el Cortador de árboles"
})

------------------------
-- Gran maga Telestra --
------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "Gran maga Telestra"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "Dividir pronto",
	WarningSplitNow		= "Se divide",
	WarningMerge		= "Se une"
})
L:SetOptionLocalization({
	WarningSplitSoon	= "Mostrar aviso para Dividir pronto",
	WarningSplitNow		= "Mostrar aviso para División",
	WarningMerge		= "Mostrar aviso para Unión"
})

L:SetMiscLocalization({
	SplitTrigger1		= "¡Tendréis más de lo que podéis soportar!",
	SplitTrigger2		= "¡Tendréis más de lo que podéis soportar!",
	MergeTrigger		= "Ahora, ¡a terminar el trabajo!"
})

-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "Keristrasza"
})

-----------------------------------
-- Comandante Kolurg/Barbarrecia --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "Comandante"
if UnitFactionGroup("player") == "Alliance" then
	commander = "Comandante Kolurg"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "Comandante Barbarrecia"
end

L:SetGeneralLocalization({
	name = commander
})

---------------
-- El Oculus --
---------------
----------------------------
-- Drakos el Interrogador --
----------------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "Drakos el Interrogador"
})


L:SetOptionLocalization({
	MakeitCountTimer	= "Mostrar temporizador para el logro 'Haz que cuente'"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Logro: Haz que cuente"
})

----------------------------
-- Señor de la magia Urom --
----------------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "Señor de la Magia Urom"
})

L:SetMiscLocalization({
	CombatStart		= "¡Pobres necios ciegos!"
})

----------------------
-- Varos Zancanubes --
----------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "Varos Zancanubes"
})

-------------------------
-- Guardián-Ley Eregos --
-------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "Guardián-Ley Eregos"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "Haz que cuente"
})

--------------------------
-- Fortaleza de Utgarde --
--------------------------
-----------------------
-- Príncipe Keleseth --
-----------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "Príncipe Keleseth"
})

------------------------
-- Skarvald y Dalronn --
------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "Constructor & Controlador"
})

----------------------------
-- Ingvar el Desvalijador --
----------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "Ingvar el Desvalijador"
})

L:SetMiscLocalization({
	YellIngvarPhase2	= "¡He vuelto! ¡Otra oportunidad para despedazarte el cráneo!", -- esMX: ¡Regreso! ¡Una segunda oportunidad de perforar tu alma!
	YellCombatEnd		= "¡No! Puedo hacerlo... ¡mejor! Puedo..."
})

-------------------------
-- Pináculo de Utgarde --
-------------------------
-------------------------
-- Skadi el Despiadado --
-------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "Skadi el Despiadado"
})

L:SetMiscLocalization({
	CombatStart		= "¿Qué chuchos son los que se atreven a irrumpir aquí? ¡Adelante, hermanos! ¡Un festín para quien me traiga sus cabezas!",
	Phase2			= "¡Bastardos malnacidos! ¡Vuestros cadáveres serán un buen bocado para mis nuevos dracos!"
})

----------------
-- Rey Ymiron --
----------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "Rey Ymiron"
})

---------------------
-- Svala Tumbapena --
---------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "Svala Tumbapena"
})

L:SetTimerLocalization({
	timerRoleplay		= "Comienza el encuentro"
})

L:SetOptionLocalization({
	timerRoleplay		= "Mostrar tiempo de diálogo antes de que Svala ataque"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "¡Mi señor! He hecho lo que pedisteis, ¡y ahora suplico vuestra bendición!"
})

--------------------------
-- Gortok Pezuña Pálida --
--------------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "Gortok Pezuña Pálida"
})

------------------------
-- El Bastión Violeta --
------------------------
---------------
-- Cianigosa --
---------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "Cyanigosa"
})

L:SetMiscLocalization({
	CyanArrived	= "Una defensa valiente, pero esta ciudad debe ser arrasada. ¡Yo misma cumpliré los deseos de Malygos!"
})

------------
-- Erekem --
------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "Erekem"
})

------------
-- Ícoron --
------------
L = DBM:GetModLocalization("Ichoron")

L:SetGeneralLocalization({
	name = "Ícoron"
})

---------------
-- Lavanthor --
---------------
L = DBM:GetModLocalization("Lavanthor")

L:SetGeneralLocalization({
	name = "Lavanthor"
})

------------
-- Moragg --
------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "Moragg"
})

------------
-- Xevozz --
------------
L = DBM:GetModLocalization("Xevoss")

L:SetGeneralLocalization({
	name = "Xevozz"
})

----------------------------
-- Zuramat el Obliterador --
----------------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "Zuramat el Obliterador"
})

--------------------------------
-- Temporizadores de portales --
--------------------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "Temporizador de portales"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Siguiente portal en breve",
	WarningPortalNow	= "Portal %d",
	WarningBossNow		= "Jefe en breve"
})

L:SetTimerLocalization({
	TimerPortalIn	= "Portal %d" ,
})

L:SetOptionLocalization({
	WarningPortalNow		= "Mostrar aviso cuando aparezca un portal",
	WarningPortalSoon		= "Mostrar aviso previo para el siguiente portales",
	WarningBossNow			= "Mostrar aviso previo para el siguiente jefe",
	TimerPortalIn			= "Mostrar temporizador para el siguiente portal (después de jefe)",
	ShowAllPortalTimers		= "Mostrar temporizadores para todos los portales (impreciso)"
})

L:SetMiscLocalization({
	Sealbroken	= "¡Hemos atravesado la puerta de la prisión! ¡El camino hacia Dalaran está despejado! ¡Por fin hemos puesto punto y final a la guerra de El Nexo!",
	WavePortal	= "Portales abiertos: (%d+)/18"
})

------------------------
-- Prueba del Campeón --
------------------------
------------------------
-- El Caballero Negro --
------------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "El Caballero Negro"
})

L:SetOptionLocalization({
	AchievementCheck		= "Anunciar fallo del logro 'Podría ser peor' al grupo"
})

L:SetMiscLocalization({
	Pull				= "Bien hecho. Hoy has demostrado algo...",
	AchievementFailed	= ">> LOGRO FALLADO: %s ha sido alcanzado por Explosión de necrófago <<",
	YellCombatEnd		= "¡No! No debo fallar... otra vez..."
})

-----------------------
-- Grandes Campeones --
-----------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "Grand Champions"
})

L:SetMiscLocalization({
	YellCombatEnd	= "¡Bien luchado! Vuestro próximo reto llega de entre las filas de la propia Cruzada. Se os pondrá a prueba contra su considerable destreza."
})

----------------------------
-- Confesora Cabelloclaro --
----------------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "Confesora Argenta"
})


L:SetMiscLocalization({
	YellCombatEnd	= "¡Un trabajo excelente!"
})

--------------------
-- Eadric el Puro --
--------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "Eadric el Puro"
})

L:SetMiscLocalization({
	YellCombatEnd	= "¡Me rindo! Lo admito. Un trabajo excelente. ¿Puedo escaparme ya?"
})

-------------------
-- Foso de Saron --
-------------------
-----------------
-- Agh y Puagh --
-----------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "Agh y Puagh"
})

-------------------------------
-- Maestro de forja Gargelus --
-------------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "Maestro de forja Gargelus"
})

L:SetOptionLocalization({
	AchievementCheck	= "Anunciar avisos del logro 'Solo once campanadas' en el chat de grupo"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "¡%s te lanza un pedrusco de saronita enorme!",
	AchievementWarning	= "Aviso: %s tiene %d acumulaciones de Escarcha permanente",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d acumulaciones de Escarcha permanente <<"
})

--------------------------------
-- Señor de la Plaga Tyrannus --
--------------------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "Señor de la Plaga Tyrannus"
})

L:SetMiscLocalization({
	CombatStart			= "¡Ay! Valientes aventureros, vuestra intromisión ha llegado a su fin. ¿Oís el ruido de huesos y acero acercándose por ese túnel? Es el sonido de vuestra inminente muerte.", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
	HoarfrostTarget		= "¡La vermis de escarcha Dientrefrío mira a (%S+) y prepara un helado ataque!",
	YellCombatEnd		= "Imposible... Dientefrío... Avisa..."
})

-----------------------
-- La Forja de Almas --
-----------------------
----------------
--  Bronjahm  --
----------------
L = DBM:GetModLocalization("Bronjahm")

L:SetGeneralLocalization({
	name = "Bronjahm"
})

-----------------
-- Devoraalmas --
-----------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "Devoraalmas"
})

--------------------------
-- Cámaras de Reflexión --
--------------------------
-------------------------------
-- Temporizadores de oleadas --
-------------------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "Temporizador de oleadas"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "Nueva oleada pronto",
	WarnNewWave		= "%s"
})

L:SetTimerLocalization({
	TimerNextWave	= "Siguiente oleada"
})

L:SetOptionLocalization({
	WarnNewWave			= "Mostrar aviso cuando llega una oleada",
	WarnNewWaveSoon		= "Mostrar aviso previo para nueva oleada (después del primer jefe)",
	ShowAllWaveWarnings	= "Mostrar avisos previos para todas las oleadas",	--Is this a warning or a pre-warning?
	TimerNextWave		= "Mostrar temporizador para la siguiente tanda de oleadas (después del primer jefe)",
	ShowAllWaveTimers	= "Mostrar temporizadores para todas las oleadas (impreciso)"
})

L:SetMiscLocalization({
	Falric		= "Falric",
	WaveCheck	= "Oleada de espíritus = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization("Falric")

L:SetGeneralLocalization({
	name = "Falric"
})

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization("Marwyn")

L:SetGeneralLocalization({
	name = "Marwyn"
})

---------------------
-- Huida de Arthas --
---------------------
L = DBM:GetModLocalization("LichKingEvent")

L:SetGeneralLocalization({
	name = "Huida de Arthas"
})

L:SetTimerLocalization({
	achievementEscape	= "Logro: No nos retiramos"
})

L:SetOptionLocalization({
	WarnWave	= "Mostrar avisos para las oleadas próximas"
})

L:SetMiscLocalization({
	ArthasYellKill	= "¡FUEGO! ¡FUEGO!",
	Ghoul			= "Necrófago enfurecido",	--creature id 36940. Not sure how to use these in function above to simplify locals though. :\
	Abom			= "Abominación torpe",		--creature id 37069
	WitchDoctor		= "Médico brujo resucitado",--creature id 36941
	Wave1			= "¡No hay escapatoria!",
	Wave2			= "Sucumbid al frío de la tumba.",
	Wave3			= "Otro final sin salida.",
	Wave4			= "¿Cuánto vais a aguantar?"
})
