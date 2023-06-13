if GetLocale() ~= "zhTW" then return end

local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization({
	name = "大君王莫卡爾"
})

--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization({
	name = "弒龍者戈魯爾"
})

L:SetWarningLocalization({
	WarnGrowth	= "%s (%d)"
})

L:SetOptionLocalization({
	WarnGrowth	= "為$spell:36300顯示警告"
})
