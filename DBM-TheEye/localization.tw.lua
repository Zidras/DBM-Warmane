if GetLocale() ~= "zhTW" then return end
local L

-----------
--  Alar --
-----------
L = DBM:GetModLocalization("Alar")

L:SetGeneralLocalization{
	name = "歐爾"
}

L:SetTimerLocalization{
	NextPlatform	= "最長平台停留時間"
}

L:SetOptionLocalization{
	NextPlatform	= "為歐爾最長平台可能停留時間顯示計時器(可能會提早離開不過不會大於這個時間)"
}

------------------
--  Void Reaver --
------------------
L = DBM:GetModLocalization("VoidReaver")

L:SetGeneralLocalization{
	name = "虛無搶奪者"
}

--------------------------------
--  High Astromancer Solarian --
--------------------------------
L = DBM:GetModLocalization("Solarian")

L:SetGeneralLocalization{
	name = "高階星術師索拉瑞恩"
}

L:SetWarningLocalization{
	WarnSplit		= "分裂!",
	WarnSplitSoon	= "5秒後分裂",
	WarnAgent		= "密探出現了",
	WarnPriest		= "牧師和索拉瑞恩出現了"

}

L:SetTimerLocalization{
	TimerSplit		= "下一次分裂",
	TimerAgent		= "密探即將到來",
	TimerPriest		= "牧師和索拉瑞恩即將到來"
}

L:SetOptionLocalization{
	WarnSplit		= "為分裂顯示警告",
	WarnSplitSoon	= "為分裂顯示警告顯示預先警告",
	WarnAgent		= "為密探出現顯示警告",
	WarnPriest		= "為牧師和索拉瑞恩出現顯示警告",
	TimerSplit		= "為分裂顯示計時器",
	TimerAgent		= "為密探出現顯示計時器",
	TimerPriest		= "為牧師和索拉瑞恩出現顯示計時器"
}

L:SetMiscLocalization{
	YellSplit1		= "我會粉碎你那偉大的夢想",
	YellSplit2		= "我的實力遠勝於你!",
	YellPhase2		= "夠了!現在我要呼喚宇宙中失衡的能量。"
}

---------------------------
--  Kael'thas Sunstrider --
---------------------------
L = DBM:GetModLocalization("KaelThas")

L:SetGeneralLocalization{
	name = "凱爾薩斯·逐日者"
}

L:SetWarningLocalization{
	WarnGaze		= ">%s<被凝視了",
	WarnMobDead		= "%s倒下",
	WarnEgg			= "鳳凰蛋出現",
	SpecWarnGaze	= "你被凝視了!快跑!",
	SpecWarnEgg		= "鳳凰蛋出現! - 快換目標!"
}

L:SetTimerLocalization{
	TimerPhase		= "下個階段",
	TimerPhase1mob	= "%s",
	TimerNextGaze	= "下一個凝視目標",
	TimerRebirth	= "鳳凰重生"
}

L:SetOptionLocalization{
	WarnGaze		= "為薩拉瑞德凝視的目標顯示警告",
	WarnMobDead		= "為第2階段小怪倒下顯示警告",
	WarnEgg			= "為鳳凰蛋出現顯示警告",
	SpecWarnGaze	= "當你被凝視時顯示特別警告",
	SpecWarnEgg		= "當鳳凰蛋出現時顯示特別警告",
	TimerPhase		= "為下一階段顯示計時器",
	TimerPhase1mob	= "為第1階段小怪活動顯示計時器",
	TimerNextGaze	= "為薩拉瑞德凝視目標改變顯示計時器",
	TimerRebirth	= "為鳳凰蛋重生顯示計時器",
	GazeIcon		= "標記薩拉瑞德注視的目標"
}

L:SetMiscLocalization{
	YellPhase2	= "你們看，我的個人收藏中有許多武器...",
	YellPhase3	= "也許我低估了你。要你一次對付四位諫言者也許對你來說是不太公平，但是...我的人民從未得到公平的對待。我只是以牙還牙而已。",
	YellPhase4	= "唉，有些時候，有些事情，必須得親自解決才行。(薩拉斯語)受死吧!",
	YellPhase5	= "我的心血是不會被你們輕易浪費的!我精心謀劃的未來是不會被你們輕易破壞的!感受我真正的力量吧!",
	YellSang	= "你已經努力的打敗了我的幾位最忠誠的諫言者...但是沒有人可以抵抗血錘的力量。等著看桑古納爾領主的力量吧!",
	YellCaper	= "卡普尼恩將保證你們不會在這裡停留太久。",
	YellTelo	= "做得好，你已經證明你的實力足以挑戰我的工程大師泰隆尼卡斯。",
	EmoteGaze	= "凝視著(.+)!",
	Thaladred	= "扭曲預言家薩拉瑞德",
	Sanguinar	= "桑古納爾領主",
	Capernian	= "大星術師卡普尼恩",
	Telonicus	= "工程大師泰隆尼卡斯",
	Bow			= "虛空之絃長弓",
	Axe			= "毀滅",
	Mace		= "宇宙灌溉者",
	Dagger		= "無盡之刃",
	Sword		= "扭曲分割者",
	Shield		= "相位壁壘",
	Staff		= "瓦解之杖",
	Egg			= "鳳凰蛋"
}
