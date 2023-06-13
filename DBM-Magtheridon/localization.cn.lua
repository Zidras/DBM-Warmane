if GetLocale() ~= "zhCN" then return end

local L

-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization({
	name = "玛瑟里顿"
})

L:SetTimerLocalization({
	timerP2	= "2 阶段"
})

L:SetOptionLocalization({
	timerP2	= "显示2阶段计时器"
})

L:SetMiscLocalization({
	DBM_MAG_EMOTE_PULL		= "%s的禁锢开始变弱！",
	DBM_MAG_YELL_PHASE2		= "我……自由了！",
	DBM_MAG_YELL_PHASE3		= "我是不会轻易倒下的！让这座牢狱的墙壁颤抖并崩塌吧！"
})
