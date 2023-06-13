if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------------------------
-- Murallas del Fuego Infernal --
---------------------------------
------------------------------
-- Guardián vigía Gargolmar --
------------------------------
-- L = DBM:GetModLocalization(527)

-----------------------
-- Omor el Sinmarcas --
-----------------------
-- L = DBM:GetModLocalization(528)

-------------------------
-- Vazruden el Heraldo --
-------------------------
-- L = DBM:GetModLocalization(529)

------------------------
-- El Horno de Sangre --
------------------------
----------------
-- El Hacedor --
----------------
-- L = DBM:GetModLocalization(555)

-------------
-- Broggok --
-------------
-- L = DBM:GetModLocalization(556)

----------------------------
-- Keli'dan el Ultrajador --
----------------------------
-- L = DBM:GetModLocalization(557)

-------------------------
-- Las Salas Arrasadas --
-------------------------
----------------------------
-- Brujo supremo Malbisal --
----------------------------
-- L = DBM:GetModLocalization(566)

------------------------------
-- Guardia de sangre Porung --
------------------------------
-- L = DBM:GetModLocalization(728)

-----------------------
-- Belisario O'mrogg --
-----------------------
-- L = DBM:GetModLocalization(568)

-------------------------
-- Kargath Garrafilada --
-------------------------
-- L = DBM:GetModLocalization(569)

-----------------------------
-- Recinto de los Esclavos --
-----------------------------
----------------------
-- Mennu el Traidor --
----------------------
-- L = DBM:GetModLocalization(570)

------------------------
-- Rokmar el Crujidor --
------------------------
-- L = DBM:GetModLocalization(571)

----------------
-- Quagmirran --
----------------
-- L = DBM:GetModLocalization(572)

------------------
-- La Sotiénaga --
------------------
----------------
-- Panthambre --
----------------
-- L = DBM:GetModLocalization(576)

-------------
-- Ghaz'an --
-------------
-- L = DBM:GetModLocalization(577)

--------------
-- Musel'ek --
--------------
-- L = DBM:GetModLocalization(578)

-------------------------
-- La Acechadora Negra --
-------------------------
-- L = DBM:GetModLocalization(579)

------------------------
-- La Cámara de Vapor --
------------------------
--------------------------
-- Hidromántica Thespia --
--------------------------
-- L = DBM:GetModLocalization(573)

--------------------------
-- Mekigeniero Vaporino --
--------------------------
L = DBM:GetModLocalization(574)

L:SetMiscLocalization({
	Mechs	= "¡Dadles bien, chicos!"
})

----------------
-- Kalithresh --
----------------
-- L = DBM:GetModLocalization(575)

----------------------
-- Criptas Auchenai --
----------------------
-------------
-- Shirrak --
-------------
-- L = DBM:GetModLocalization(523)

---------------------
-- Exarca Maladaar --
---------------------
-- L = DBM:GetModLocalization(524)

--------------------
-- Tumbas de Maná --
--------------------
-----------------
-- Pandemonius --
-----------------
-- L = DBM:GetModLocalization(534)

-------------
-- Tavarok --
-------------
-- L = DBM:GetModLocalization(535)

---------------------------
-- Príncipe-nexo Shaffar --
---------------------------
-- L = DBM:GetModLocalization(537)

---------
-- Yor --
---------
-- L = DBM:GetModLocalization(536)

-------------------
-- Salas Sethekk --
-------------------
---------------------
-- Tejeoscuro Syth --
---------------------
-- L = DBM:GetModLocalization(541)

----------
-- Anzu --
----------
L = DBM:GetModLocalization(542)

L:SetWarningLocalization({
	warnStoned	= "%s ha vuelto a la piedra"
})

L:SetOptionLocalization({
	warnStoned	= "Mostrar aviso cuando los espíritus vuelvan a la piedra"
})

L:SetMiscLocalization({
	BirdStone	= "%s ha vuelto a la piedra."
})

---------------------
-- Rey Garra Ikiss --
---------------------
-- L = DBM:GetModLocalization(543)

------------------------------
-- Laberinto de las Sombras --
------------------------------
---------------------------
-- Embajador Faucinferno --
---------------------------
-- L = DBM:GetModLocalization(544)

---------------------------
-- Negrozón el Incitador --
---------------------------
-- L = DBM:GetModLocalization(545)

--------------------------
-- Maestro mayor Vorpil --
--------------------------
-- L = DBM:GetModLocalization(546)

------------
-- Murmur --
------------
-- L = DBM:GetModLocalization(547)

------------------------------------
-- Antiguas Laderas de Trabalomas --
------------------------------------
--------------------
-- Teniente Drake --
--------------------
-- L = DBM:GetModLocalization(538)

---------------------
-- Capitán Skarloc --
---------------------
-- L = DBM:GetModLocalization(539)

----------------------
-- Cazador de Época --
----------------------
-- L = DBM:GetModLocalization(540)

----------------------
-- La Ciénaga Negra --
----------------------
--------------------
-- Cronolord Deja --
--------------------
-- L = DBM:GetModLocalization(552)

--------------
-- Temporus --
--------------
-- L = DBM:GetModLocalization(553)

------------
-- Aeonus --
------------
L = DBM:GetModLocalization(554)

L:SetMiscLocalization({
	AeonusFrenzy	= "¡%s entra en Frenesí!"
})

--------------------------------
-- Temporizadores de portales --
--------------------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "Temporizadores de portales"
})

L:SetWarningLocalization({
	WarnWavePortalSoon	= "Siguiente portal en breve",
	WarnWavePortal		= "Portal %d",
	WarnBossPortal		= "Jefe en breve"
})

L:SetTimerLocalization({
	TimerNextPortal		= "Portal %d"
})

L:SetOptionLocalization({
	WarnWavePortalSoon	= "Mostrar aviso previo para el siguiente portal",
	WarnWavePortal		= "Mostrar aviso cuando aparezca un portal",
	WarnBossPortal		= "Mostrar aviso previo para el siguiente jefe",
	TimerNextPortal		= "Mostrar temporizador para el siguiente portal (después de jefe)",
	ShowAllPortalTimers	= "Mostrar temporizadores para todos los portales (impreciso)"
})

L:SetMiscLocalization({
	PortalCheck			= "Grietas en el Tiempo abiertas: (%d+)/18",
	Shielddown			= "¡No...malditos sean estos débiles mortales...!"
})

-----------------
-- El Mechanar --
-----------------
-----------------------------------
-- Vigía de las puertas Giromata --
-----------------------------------
L = DBM:GetModLocalization("Gyrokill")--Not in EJ

L:SetGeneralLocalization({
	name = "Vigía de las puertas Giromata"
})

------------------------------------
-- Vigía de las puertas Manoyerro --
------------------------------------
L = DBM:GetModLocalization("Ironhand")--Not in EJ

L:SetGeneralLocalization({
	name = "Vigía de las puertas Manoyerro"
})

L:SetMiscLocalization({
	JackHammer	= "%s alza su martillo amenazadoramente..."
})

---------------------------
-- Mecano-lord Capacitus --
---------------------------
-- L = DBM:GetModLocalization(563)

-------------------------
-- Abisálica Sepethrea --
-------------------------
-- L = DBM:GetModLocalization(564)

-----------------------------
-- Pathaleon el Calculador --
-----------------------------
-- L = DBM:GetModLocalization(565)

--------------------
-- El Invernáculo --
--------------------
-------------------------
-- Comandante Sarannis --
-------------------------
-- L = DBM:GetModLocalization(558)

----------------------------
-- Gran botánico Freywinn --
----------------------------
-- L = DBM:GetModLocalization(559)

---------------------------
-- Thorngrin el Cuidador --
---------------------------
-- L = DBM:GetModLocalization(560)

---------
-- Laj --
---------
-- L = DBM:GetModLocalization(561)

-----------------------------
-- Disidente de distorsión --
-----------------------------
-- L = DBM:GetModLocalization(562)

-----------------
-- El Arcatraz --
-----------------
--------------------------
-- Zereketh el Desatado --
--------------------------
-- L = DBM:GetModLocalization(548)

---------------------------------
-- Dalliah la Oradora del Sino --
---------------------------------
-- L = DBM:GetModLocalization(549)

------------------
-- Soccothrates --
------------------
-- L = DBM:GetModLocalization(550)

------------------------
-- Presagista Cieloriss --
------------------------
L = DBM:GetModLocalization(551)

L:SetMiscLocalization({
	Split	= "¡Abarcamos el universo, somos tantos como las estrellas!"
})

-------------------------
-- Bancal del Magister --
-------------------------
----------------------------
-- Selin Corazón de Fuego --
----------------------------
-- L = DBM:GetModLocalization(530)

--------------
-- Vexallus --
--------------
-- L = DBM:GetModLocalization(531)

--------------------------
-- Sacerdotisa Delrissa --
--------------------------
L = DBM:GetModLocalization(532)

L:SetMiscLocalization({
	DelrissaPull	= "Aniquiladlos.",
	DelrissaEnd		= "Esto no lo había planeado."
})

---------------
-- Kael'thas --
---------------
L = DBM:GetModLocalization(533)

L:SetMiscLocalization({
	KaelP2	= "Pondré vuestro mundo... cabeza... abajo."
})
