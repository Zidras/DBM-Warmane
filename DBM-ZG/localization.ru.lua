if GetLocale() ~= "ruRU" then return end

local L

-------------------
--  Venoxis  --
-------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization({
	name = "Верховный жрец Веноксис"
})

-------------------
--  Jeklik  --
-------------------
L = DBM:GetModLocalization("Jeklik")

L:SetGeneralLocalization({
	name = "Верховная жрица Джеклик"
})

-------------------
--  Marli  --
-------------------
L = DBM:GetModLocalization("Marli")

L:SetGeneralLocalization({
	name = "Верховная жрица Мар'ли"
})

-------------------
--  Thekal  --
-------------------
L = DBM:GetModLocalization("Thekal")

L:SetGeneralLocalization({
	name = "Верховный жрец Текал"
})

L:SetWarningLocalization({
	WarnSimulKill	= "Первый адд пал - воскрешение через ~15 сек."
})

L:SetTimerLocalization({
	TimerSimulKill	= "Воскрешение"
})

L:SetOptionLocalization({
	WarnSimulKill	= "Объявлять о смерти первого адда",
	TimerSimulKill	= "Показывать время до воскрешения жреца"
})

L:SetMiscLocalization({
	PriestDied	= "%s умирает.",
	YellPhase2	= "Ширвалла, наполни меня своим ГНЕВОМ!",
	YellKill	= "Хаккар больше не властен надо мной! Наконец-то я обрел покой!",
	Thekal		= "Верховный жрец Текал",
	Zath		= "Ревнитель Зат",
	LorKhan		= "Ревнитель Лор'Кхан"
})

-------------------
--  Arlokk  --
-------------------
L = DBM:GetModLocalization("Arlokk")

L:SetGeneralLocalization({
	name = "Верховная жрица Арлокк"
})

-------------------
--  Hakkar  --
-------------------
L = DBM:GetModLocalization("Hakkar")

L:SetGeneralLocalization({
	name = "Хаккар"
})

-------------------
--  Bloodlord  --
-------------------
L = DBM:GetModLocalization("Bloodlord")

L:SetGeneralLocalization({
	name = "Мандокир Повелитель Крови"
})

L:SetMiscLocalization({
	Bloodlord	= "Мандокир Повелитель Крови",
	Ohgan		= "Охган",
	GazeYell	= "Я за тобой слежу"
})

-------------------
--  Edge of Madness  --
-------------------
L = DBM:GetModLocalization("EdgeOfMadness")

L:SetGeneralLocalization({
	name = "Грань Безумия"
})

L:SetMiscLocalization({
	Hazzarah = "Хазза'рах",
	Renataki = "Ренатаки",
	Wushoolay = "Вушулай",
	Grilek = "Гри'лек"
})

-------------------
--  Gahz'ranka  --
-------------------
L = DBM:GetModLocalization("Gahzranka")

L:SetGeneralLocalization({
	name = "Газ'ранка"
})

-------------------
--  Jindo  --
-------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization({
	name = "Мастер проклятий Джин'до"
})
