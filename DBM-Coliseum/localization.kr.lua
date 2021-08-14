if GetLocale() ~= "koKR" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "노스렌드의 야수"
}

L:SetWarningLocalization{
	WarningSnobold			= "스노볼트 부하 생성 : >%s<"
}

L:SetTimerLocalization{
	TimerNextBoss			= "곧 다음 우두머리",
	TimerEmerge				= "출현",
	TimerSubmerge			= "숨기"
}

L:SetOptionLocalization{
	WarningSnobold			= "스노볼트 부하 생성 알림 보기",
	PingCharge				= "얼음울음에게 사나운 돌진의 대상이 될 경우 미니맵에 핑 표시하기",
	ClearIconsOnIceHowl		= "사나운 돌진 전에 모든 전술 목표 아이콘 지움",
	TimerNextBoss			= "다음 우두머리 등장 바 보기",
	TimerEmerge				= "출현 바 보기",
	TimerSubmerge			= "숨기 바 보기",
	IcehowlArrow			= "사나운 돌진 대상이 가까이 있을 경우 DBM 화살표 보기"
}

L:SetMiscLocalization{
	Charge					= "노려보며 큰 소리로 울부짖습니다.",
	CombatStart				= "폭풍우 봉우리의 가장 깊고 어두운 동굴에서 온, 꿰뚫는 자 고르목일세! 영웅들이여, 전투에 임하게!",
	Phase2					= "마음을 단단히 먹게, 영웅들이여. 두 배의 공포, 산성아귀와 공포비늘이 투기장으로 들어온다네!",
	Phase3					= "다음은, 소개하는 순간 공기마저 얼어붙게 하는 얼음울음일세! 죽이지 않으면 죽을 걸세, 용사들이여!",
	Gormok					= "꿰뚫는 자 고르목",
	Acidmaw					= "산성아귀",
	Dreadscale				= "공포비늘",
	Icehowl					= "얼음울음"
}

-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "군주 자락서스"
}

L:SetOptionLocalization{
	IncinerateShieldFrame	= "우두머리 체력 바 사용시 살점 소각 치유량 바 함께 보기"
}

L:SetMiscLocalization{
	IncinerateTarget		= "살점 소각: %s",
	FirstPull				= "대흑마법사 윌프레드 피즐뱅이 다음 상대를 소환할 걸세. 기다리고 있게나."
}

-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "진영 대표 용사"
}

L:SetMiscLocalization{
	--Horde NPCs
	Gorgrim				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:64:64:96|t 고르그림 섀도클리브",		-- 34458
	Birana				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t 비라나 스톰후프",			-- 34451
	Erin				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t 에린 미스트후프",			-- 34459
	Rujkah				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t 루즈카",						-- 34448
	Ginselle			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:0:32|t 진셀 브라이트슬링어",		-- 34449
	Liandra				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t 리안드라 선콜러",				-- 34445
	Malithas			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t 말리타스 브라이트블레이드",	-- 34456
	Caiphus				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t 준엄한 카이푸스",			-- 34447
	Vivienne			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t 비비안 블랙위스퍼",		-- 34441
	Mazdinah			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:0:32|t 마즈디나",					-- 34454
	Thrakgar			= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t 스락가르",					-- 34444
	Broln				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t 브롤른 스타우트혼",		-- 34455
	Harkzog				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:32:64|t 하크조그",				-- 34450
	Narrhok				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:0:32|t 나르호크 스틸브레이커",		-- 34453
	--Alliance NPCs
	Tyrius				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:64:64:96|t 티리우스 더스크블레이드",	-- 34461
	Kavina				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t 카비나 그로브송",			-- 34460
	Melador				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:0:32|t 멜라도르 베일스트라이더",	-- 34469
	Alyssia             = "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:32:64|t 알리시아 문스토커",			-- 34467
	Noozle				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:0:32|t 누즐 위즐스틱",				-- 34468
	Baelnor				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t 밸노르 라이트베어러",			-- 34471
	Velanaa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:64:96|t 벨라나",						-- 34465
	Anthar				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t 안타르 포지멘더",			-- 34466
	Brienna				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:32:64|t 브리에나 나이트펠",		-- 34473
	Irieth				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:63.5:95:0:32|t 이리에스 섀도스텝",			-- 34472
	Saamul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t 사아물",					-- 34470
	Shaabad				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:32:63.5:32:64|t 샤바드",					-- 34463
	Serissa				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:95:126.5:32:64|t 세리사 그림대블러",		-- 34474
	Shocuul				= "|TInterface\\WorldStateFrame\\Icons-Classes.blp:24:24:0:0:128:128:0:32:0:32|t 쇼쿨",							-- 34475

	AllianceVictory 	= "얼라이언스에 영광을!",
	HordeVictory		= "앞으로 일어날 일의 맛보기일 뿐이다. 호드를 위하여!"
	--YellKill			= "상처뿐인 승리로군. 오늘 받은 손해로 우리 전력은 약해졌네. 이런 어리석은 짓으로 리치 왕 말고 또 누가 이득을 보겠나? 위대한 용사들이 목숨을 잃었네. 무엇을 위해서였나? 진짜 위협은 저 앞에 있네. 리치 왕이 우리 모두를 죽음 안에서 기다린다네.",
}

------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "발키르 쌍둥이"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "다음 속성의 소용돌이"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "곧 속성의 소용돌이!",
	SpecWarnSpecial				= "속성(빛/어둠) 변경!",
	SpecWarnSwitchTarget		= "대상 전환!",
	SpecWarnKickNow				= "지금 차단!",
	WarningTouchDebuff			= "디버프 : >%s<",
	WarningPoweroftheTwins		= "쌍둥이의 힘 - 오버힐!!  >%s<",
	SpecWarnPoweroftheTwins		= "쌍둥이의 힘!"
}

L:SetMiscLocalization{
	YellPull 	= "어둠의 주인님을 받들어. 리치 왕을 위하여. 너희에게. 죽음을. 안기리라.",
	--CombatStart	= "Only by working together will you overcome the final challenge. From the depths of Icecrown come two of the Scourge's most powerful lieutenants: fearsome val'kyr, winged harbingers of the Lich King!", -- Needs translating
	Fjola 		= "피욜라 라이트베인",
	Eydis		= "아이디스 다크베인"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "다음 속성의 소용돌이의 타이머 보기",
	WarnSpecialSpellSoon		= "다음 속성의 소용돌이 사전 경고 보기",
	SpecWarnSpecial				= "속성(색) 변경을 해야할 때 특수 경고 보기",
	SpecWarnSwitchTarget		= "다른 보스에게 시전해야 할 경우 특수 경고 보기",
	SpecWarnKickNow				= "당신이 차단을 해야할 경우 특수 경고 보기",
	SpecialWarnOnDebuff			= "디버프일 경우 특수 경고 보기 (디버프를 바꿀 경우)",
	SetIconOnDebuffTarget		= "손길 디버프 대상에게 공격대 아이콘 설정하기(영웅 모드)",
	WarningTouchDebuff			= "빛/어둠의 손길 디버프 대상 알리기",
	WarningPoweroftheTwins		= "쌍둥이의 힘의 현재 대상 알리기",
	SpecWarnPoweroftheTwins		= "쌍둥이의 힘의 특수 경고 보기(탱커일 경우)"
}

------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "아눕아락"
}

L:SetTimerLocalization{
	TimerEmerge				= "출현",
	TimerSubmerge			= "숨기",
	timerAdds				= "다음 네루비안 땅무지"
}

L:SetWarningLocalization{
	WarnEmerge				= "아눕아락 출현!",
	WarnEmergeSoon			= "아눕아락 10초 이내 출현!",
	WarnSubmerge			= "아눕아락 잠수!",
	WarnSubmergeSoon		= "아눕아락 10초 이내 잠수!",
	specWarnSubmergeSoon	= "아눕아락 잠수 10초 전!",
	SpecWarnPursue			= "당신을 추격 합니다!",
	warnAdds				= "네루비안 땅무지 추가!",
	SpecWarnShadowStrike	= "어둠의 일격! 지금 차단!"
}

L:SetMiscLocalization{
	YellPull				= "여기가 네 무덤이 되리라!",
--	Swarm					= "착취의 무리가 너희를 덮치리라!",
	Emerge					= "땅속에서 모습을 드러냅니다!",
	Burrow					= "땅속으로 숨어버립니다!",
	PcoldIconSet			= "냉기 관통 아이콘{rt%d} : %s",
	PcoldIconRemoved		= "냉기 관통 아이콘 제거 : %s"
}

L:SetOptionLocalization{
	WarnEmerge					= "출현 경고 보기",
	WarnEmergeSoon				= "출현의 사전 경고 보기",
	WarnSubmerge				= "숨기 경고 보기",
	WarnSubmergeSoon			= "숨기의 사전 경고 보기",
	specWarnSubmergeSoon		= "숨기 10초전 특수 경고 보기",
	SpecWarnPursue				= "당신을 추격하기 시작할 때 특수 경고 알리기",
	warnAdds					= "새로운 네루비안 땅무지가 추가 될 때 경고 보기",
	timerAdds					= "새로운 네루비안 땅무지 추가 타이머 보기",
	TimerEmerge					= "출현 타이머 보기",
	TimerSubmerge				= "숨기 타이머 보기",
	PlaySoundOnPursue			= "당신을 추격하기 시작할 때 특수 소리 재생",
	PursueIcon					= "추격 대상자 공격대 아이콘 설정하기",
	SetIconsOnPCold				= "$spell:68510 대상자 공격대 아이콘 설정하기",
	SpecWarnShadowStrike		= "$spell:66134 특수 경고 보기(차단 관련)",
	RemoveHealthBuffsInP3		= "3 페이즈를 시작할 때 HP 버프 지우기",
	AnnouncePColdIcons			= "$spell:68510 대상자 및 공격대 아이콘 설정을 공격대 채팅창으로 알리기",
	AnnouncePColdIconsRemoved	= "$spell:68510의 공격대 아이콘이 언제 사라지는지 알리기 \n(위의 옵션을 포함해야 함)"
}
