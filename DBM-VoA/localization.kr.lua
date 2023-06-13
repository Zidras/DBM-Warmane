if GetLocale() ~= "koKR" then return end

local L

----------------
--  아카본  --
----------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "바위 감시자 아카본"
})

L:SetWarningLocalization({
	WarningGrab		= "분쇄의 도약 : >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage	= "아카본 광폭화"
})

L:SetOptionLocalization({
	WarningGrab		= "분쇄의 도약 대상 알림 보기"
})

L:SetMiscLocalization({
	TankSwitch		= "(%S+)에게 돌진합니다!"
})

--------------
--  Emalon  --
--------------

L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization({
	name = "폭풍의 감시자 에말론"
})

L:SetTimerLocalization({
	timerMobOvercharge	= "과충전 폭발",
	EmalonEnrage		= "에말론 광폭화"
})

L:SetOptionLocalization({
	timerMobOvercharge	= "과충전 폭발까지 남은시간 바 보기"
})

---------------
--  Koralon  --
---------------

L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization({
	name = "화염 감시자 코랄론"
})

L:SetTimerLocalization({
	KoralonEnrage		= "코랄론 광폭화"
})

-------------------------------
--  Toravon the Ice Watcher  --
-------------------------------
L = DBM:GetModLocalization("Toravon")

L:SetGeneralLocalization({
	name = "얼음 감시자 토라본"
})

L:SetTimerLocalization({
	ToravonEnrage	= "토라본 광폭화"
})
