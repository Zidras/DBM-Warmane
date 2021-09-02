if GetLocale() ~= "zhCN" then return end

local L

-- Doom Lord Kazzak
L = DBM:GetModLocalization("Kazzak")

L:SetGeneralLocalization{
	name = "末日领主卡扎克"
}

L:SetMiscLocalization{
	DBM_KAZZAK_EMOTE_ENRAGE		= "%s becomes enraged!"--Probalby won't be used, at least not long. Once spellid replaces it
}

-- Doomwalker
L = DBM:GetModLocalization("Doomwalker")

L:SetGeneralLocalization{
	name = "末日行者"
}

L:SetMiscLocalization{
	DBM_DOOMW_EMOTE_ENRAGE	= "%s becomes enraged!"--Probalby won't be used, at least not long. Once spellid replaces it
}