if GetLocale() ~= "esES" then return end
local L

-----------
--  Alar --
-----------
L = DBM:GetModLocalization("Alar")

L:SetGeneralLocalization{
	name = "Al'ar"
}

L:SetTimerLocalization{
	NextPlatform	= "Siguiente plataforma (max.)"
}

L:SetOptionLocalization{
	NextPlatform	= "Mostrar temporizador para el tiempo máximo que Al'ar puede permanecer en una plataforma"
}

------------------
--  Void Reaver --
------------------
L = DBM:GetModLocalization("VoidReaver")

L:SetGeneralLocalization{
	name = "Atracador del vacío"
}

--------------------------------
--  High Astromancer Solarian --
--------------------------------
L = DBM:GetModLocalization("Solarian")

L:SetGeneralLocalization{
	name = "Gran astromante Solarian"
}

L:SetWarningLocalization{
	WarnSplit		= "Separación de banda",
	WarnSplitSoon	= "Separación de banda en 5 s",
	WarnAgent		= "Agentes",
	WarnPriest		= "Sacerdotes y Solarian"

}

L:SetTimerLocalization{
	TimerSplit		= "Siguiente separación",
	TimerAgent		= "Siguientes agentes",
	TimerPriest		= "Sacerdotes y Solarian"
}

L:SetOptionLocalization{
	WarnSplit		= "Mostrar aviso para la separación de banda",
	WarnSplitSoon	= "Mostrar aviso previo para la separación de banda",
	WarnAgent		= "Mostrar aviso cuando aparezcan Agentes Solarium",
	WarnPriest		= "Mostrar aviso cuando aparezcan los Sacerdotes Solarium y la Gran astromante Solarian",
	TimerSplit		= "Mostrar temporizador para la separación de banda",
	TimerAgent		= "Mostrar temporizador para los siguientes Agentes Solarium",
	TimerPriest		= "Mostrar temporizador para cuando vuelva a aparecer la Gran astromante Solarian con los Sacerdotes Solarium"
}

L:SetMiscLocalization{
	YellSplit1		= "¡Aplastaré vuestros delirios de grandeza!",
	YellSplit2		= "¡Os superamos con creces!",
	YellPhase2		= "Me FUNDO... ¡con el VACÍO!"
}

---------------------------
--  Kael'thas Sunstrider --
---------------------------
L = DBM:GetModLocalization("KaelThas")

L:SetGeneralLocalization{
	name = "Kael'thas Caminante del Sol"
}

L:SetWarningLocalization{
	WarnGaze		= "Mirada en >%s<",
	WarnMobDead		= "%s muerto",
	WarnEgg			= "Huevo de fénix",
	SpecWarnGaze	= "Mirada en ti - ¡huye!",
	SpecWarnEgg		= "Huevo de Fénix - ¡cambia de objetivo!"
}

L:SetTimerLocalization{
	TimerPhase		= "Siguiente fase",
	TimerPhase1mob	= "%s",
	TimerNextGaze	= "Mirada: Cambio de objetivo",
	TimerRebirth	= "Fénix: Renacimiento"
}

L:SetOptionLocalization{
	WarnGaze		= "Anunciar objetivos de la Mirada de Thaladred",
	WarnMobDead		= "Mostrar aviso cuando muera un esbirro en Fase 2",
	WarnEgg			= "Mostrar aviso cuando aparezca un Huevo de fénix",
	SpecWarnGaze	= "Mostrar aviso especial cuando te afecte Mirada",
	SpecWarnEgg		= "Mostrar aviso especial cuando aparezca un Huevo de fénix",
	TimerPhase		= "Mostrar temporizador para la siguiente faseShow time for next phase",
	TimerPhase1mob	= "Mostrar temporizador para cuando se active cada jefe de Fase 1",
	TimerNextGaze	= "Show timer for Thaladred's Gaze target changes",
	TimerRebirth	= "Mostrar temporizador para el renacimiento de los Huevos de fénix",
	GazeIcon		= "Poner icono en el objetivo de la Mirada de Thaladred"
}

L:SetMiscLocalization{
	YellPhase2	= "Como veis, dispongo de un amplio arsenal...",
	YellPhase3	= "Quizás os subestimé. Sería injusto que os enfrentarais a los cuatro consejeros al mismo tiempo, pero... nunca se le ha brindado un trato justo a mi gente. Así que os devuelvo el favor.",
	YellPhase4	= "Desafortunadamente hay veces en las que tienes que hacer las cosas con tus propias manos. ¡Balamore shanal!",
	YellPhase5	= "¡No he llegado hasta aquí para que me detengáis! ¡El futuro que he planeado no se pondrá en peligro! ¡Vais a probar el verdadero poder!",
	YellSang	= "Habéis sobrevivido a algunos de mis mejores consejeros... pero nadie puede resistir el poder del Martillo de Sangre. ¡He aquí Lord Sanguinar!",
	YellCaper	= "Capernian se encargará de que vuestra visita sea breve.",
	YellTelo	= "Bien hecho. Parecéis dignos de probar vuestras habilidades con mi maestro ingeniero Telonicus.",
	EmoteGaze	= "mira a ([^%s]+)!",
	Thaladred	= "Thaladred el Ensombrecedor",
	Sanguinar	= "Lord Sanguinar",
	Capernian	= "Gran astromante Capernian",
	Telonicus	= "Maestro ingeniero Telonicus",
	Bow			= "Arco largo de fibra abisal",
	Axe			= "Devastación",
	Mace		= "Inyector cósmico",
	Dagger		= "Hoja de infinidad",
	Sword		= "Cercenador de distorsión",
	Shield		= "Baluarte de cambio de fase",
	Staff		= "Bastón de desintegración",
	Egg			= "Huevo de fénix"
}
