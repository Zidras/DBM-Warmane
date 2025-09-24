if GetLocale() ~= "koKR" then return end
local L

--Maulgar
L = DBM:GetModLocalization("Maulgar")

L:SetGeneralLocalization({
	name = "왕중왕 마울가르"
})

--Gruul the Dragonkiller
L = DBM:GetModLocalization("Gruul")

L:SetGeneralLocalization({
	name = "용 학살자 그룰"
})

L:SetOptionLocalization({
	WarnGrowth	= "$spell:36300 알림 보기",
	RangeDistance	= "$spell:33654 거리 창 범위 설정",
	Smaller			= "좁은 범위 (11m)",
	Safe			= "안전 범위 (18m)"
})
