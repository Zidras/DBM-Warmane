if GetLocale() ~= "zhCN" then return end
local L

---------------
-- Kurinnaxx --
---------------
L = DBM:GetModLocalization("Kurinnaxx")

L:SetGeneralLocalization{
	name 		= "库林纳克斯"
}

------------
-- Rajaxx --
------------
L = DBM:GetModLocalization("Rajaxx")

L:SetGeneralLocalization{
	name 		= "拉贾克斯将军"
}
L:SetWarningLocalization{
	WarnWave	= "进攻次数%s",
}
L:SetOptionLocalization{
	WarnWave	= "显示下一次进攻"
}
L:SetMiscLocalization{
	Wave12		= "拉贾克斯，还记得我说过要杀光其它虫子之后再干掉你么？",
	Wave12Alt	= "它们来了。尽量别被它们干掉，新兵。",
	Wave3		= "我们复仇的时刻到了！让敌人的内心被黑暗吞噬吧！",
	Wave4		= "我们不用再呆在这座石墙里面了！我们很快就能报仇了！在我们的怒火面前，就连那些龙也会战栗！",
	Wave5		= "让敌人胆战心惊吧！让他们在恐惧中死去！",
	Wave6		= "鹿盔将会呜咽着哀求我饶他一命，就像他那懦弱的儿子一样！一千年来的屈辱会在今天洗清！",
	Wave7		= "范达尔！你的死期到了！藏到翡翠梦境里去吧，祈祷我们永远都找不到你！",
	Wave8		= "无礼的蠢货！我会亲自要了你们的命！"
}

----------
-- Moam --
----------
L = DBM:GetModLocalization("Moam")

L:SetGeneralLocalization{
	name 		= "莫阿姆"
}

----------
-- Buru --
----------
L = DBM:GetModLocalization("Buru")

L:SetGeneralLocalization{
	name 		= "吞咽者布鲁"
}
L:SetWarningLocalization{
	WarnPursue		= ">%s<被追击了",
	SpecWarnPursue	= "你被追击了",
	WarnDismember	= ">%2$s<中了%1$s(%s)"
}
L:SetOptionLocalization{
	WarnPursue		= "提示被追击的目标",
	SpecWarnPursue	= "当你被追击的时候显示特別警告"
}
L:SetMiscLocalization{
	PursueEmote 	= "%s凝视着"
}

-------------
-- Ayamiss --
-------------
L = DBM:GetModLocalization("Ayamiss")

L:SetGeneralLocalization{
	name 		= "狩猎者阿亚米斯"
}

--------------
-- Ossirian --
--------------
L = DBM:GetModLocalization("Ossirian")

L:SetGeneralLocalization{
	name 		= "无疤者奥斯里安"
}
L:SetWarningLocalization{
	WarnVulnerable	= "%s"
}
L:SetTimerLocalization{
	TimerVulnerable	= "%s"
}
L:SetOptionLocalization{
	WarnVulnerable	= "提示虛弱",
	TimerVulnerable	= "为虛弱显示计时器"
}

----------------
-- AQ20 Trash --
----------------
L = DBM:GetModLocalization("AQ20Trash")

L:SetGeneralLocalization{
	name = "AQ20：全程计时"
}
