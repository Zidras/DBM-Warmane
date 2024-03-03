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
	WarnGrowth	= "為$spell:36300顯示警告",
	RangeDistance	= "Range frame distance for $spell:33654",
	Smaller			= "Smaller distance (14)",
	Safe			= "Safer distance (20)"
})
