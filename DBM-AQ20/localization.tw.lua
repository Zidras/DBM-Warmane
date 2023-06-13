if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Kurinnaxx --
---------------
L = DBM:GetModLocalization("Kurinnaxx")

L:SetGeneralLocalization({
	name		= "庫林納克斯"
})

------------
-- Rajaxx --
------------
L = DBM:GetModLocalization("Rajaxx")

L:SetGeneralLocalization({
	name		= "拉賈克斯將軍"
})

L:SetWarningLocalization({
	WarnWave	= "進攻波數%s",
})

L:SetOptionLocalization({
	WarnWave	= "為下一次波進攻顯示提示"
})

L:SetMiscLocalization({
	Wave12		= "記得嗎，拉賈克斯，上次我說會殺了你？",
	Wave12Alt	= "它們來了。盡量別被它們幹掉，新兵。",
	Wave3		= "我們復仇的時刻就在眼前！讓黑暗掌控敵人的內心吧！",
	Wave4		= "我們不用在被堵住的門和石牆後面等待了！沒有人能抵抗我們的復仇！巨龍將在我們的憤怒之前顫抖！",
	Wave5		= "恐懼留給敵人！恐懼吧！去死吧！",
	Wave6		= "鹿盔會為了活命而哭著乞求，就像他的兒子一樣！千年來的不公不義會在今天昭雪！",
	Wave7		= "范達爾！時候到了！躲進翡翠夢境，祈禱我們永遠不會找到你吧！",
	Wave8		= "不要臉的笨蛋！我要親手殺了你！"
})

----------
-- Moam --
----------
L = DBM:GetModLocalization("Moam")

L:SetGeneralLocalization({
	name		= "莫阿姆"
})

----------
-- Buru --
----------
L = DBM:GetModLocalization("Buru")

L:SetGeneralLocalization({
	name		= "『暴食者』布魯"
})

L:SetWarningLocalization({
	WarnPursue		= ">%s<被追擊了",
	SpecWarnPursue	= "你被追擊了",
	WarnDismember	= ">%2$s<中了%1$s(%s)"
})

L:SetOptionLocalization({
	WarnPursue		= "提示被追擊的目標",
	SpecWarnPursue	= "當你被追擊的時候顯示特別警告"
})

L:SetMiscLocalization({
	PursueEmote	= "%s凝視著"
})

-------------
-- Ayamiss --
-------------
L = DBM:GetModLocalization("Ayamiss")

L:SetGeneralLocalization({
	name		= "『狩獵者』阿亞米斯"
})

--------------
-- Ossirian --
--------------
L = DBM:GetModLocalization("Ossirian")

L:SetGeneralLocalization({
	name		= "『無疤者』奧斯里安"
})

L:SetWarningLocalization({
	WarnVulnerable	= "%s"
})

L:SetTimerLocalization({
	TimerVulnerable	= "%s"
})

L:SetOptionLocalization({
	WarnVulnerable	= "提示虛弱",
	TimerVulnerable	= "為虛弱顯示計時器"
})

----------------
-- AQ20 Trash --
----------------
L = DBM:GetModLocalization("AQ20Trash")

L:SetGeneralLocalization({
	name = "AQ20：全程計時"
})
