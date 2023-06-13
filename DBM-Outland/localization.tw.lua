if GetLocale() ~= "zhTW" then return end

local L

-- Doom Lord Kazzak
L = DBM:GetModLocalization("Kazzak")

L:SetGeneralLocalization({
	name = "毀滅領主卡札克"
})

L:SetMiscLocalization({
	DBM_KAZZAK_EMOTE_ENRAGE		= "%s becomes enraged!"
})

-- Doomwalker
L = DBM:GetModLocalization("Doomwalker")

L:SetGeneralLocalization({
	name = "厄運行者"
})

L:SetMiscLocalization({
	DBM_DOOMW_EMOTE_ENRAGE	= "%s becomes enraged!"
})
