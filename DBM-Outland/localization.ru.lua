if GetLocale() ~= "ruRU" then return end

local L

-- Doom Lord Kazzak
L = DBM:GetModLocalization("Kazzak")

L:SetGeneralLocalization({
	name = "Владыка судеб Каззак"
})

L:SetMiscLocalization({
	DBM_KAZZAK_EMOTE_ENRAGE		= "%s впадает в бешенство!"--Probalby won't be used, at least not long. Once spellid replaces it
})

-- Doomwalker
L = DBM:GetModLocalization("Doomwalker")

L:SetGeneralLocalization({
	name = "Судьболом"
})

L:SetMiscLocalization({
	DBM_DOOMW_EMOTE_ENRAGE	= "%s впадает в бешенство!"--Probalby won't be used, at least not long. Once spellid replaces it
})

-- Quest
L = DBM:GetModLocalization("Quest")

L:SetGeneralLocalization({
	name = "Квест",
})

L:SetOptionLocalization({
	Timers = "Показывать таймеры для некоторых квестов сопровождений"
})
