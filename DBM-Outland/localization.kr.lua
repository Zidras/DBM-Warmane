if GetLocale() ~= "koKR" then return end
local L

-- Doom Lord Kazzak
L = DBM:GetModLocalization("Kazzak")

L:SetGeneralLocalization{
	name = "파멸의 군주 카자크"
}

L:SetMiscLocalization{
	DBM_KAZZAK_EMOTE_ENRAGE		= "%s|1이;가; 분노에 휩싸입니다!"--Probalby won't be used, at least not long. Once spellid replaces it
}

-- Doomwalker
L = DBM:GetModLocalization("Doomwalker")

L:SetGeneralLocalization{
	name = "파멸의 절단기"
}

L:SetMiscLocalization{
	DBM_DOOMW_EMOTE_ENRAGE	= "%s|1이;가; 분노에 휩싸입니다!"----Probalby won't be used, at least not long. Once spellid replaces it
}

-- Quest
L = DBM:GetModLocalization("Quest")

L:SetGeneralLocalization{
	name = "퀘스트",
}

L:SetOptionLocalization{
	Timers = "몇가지 호위 퀘스트의 타이머 바 보기"
}