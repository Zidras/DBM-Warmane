if GetLocale() ~= "koKR" then return end
local L

-------------------------
--  Hellfire Ramparts  --
-----------------------------
--  Watchkeeper Gargolmar  --
-----------------------------
L = DBM:GetModLocalization(527)

L:SetGeneralLocalization{
	name 		= "감시자 가르골마르"
}

--------------------------
--  Omor the Unscarred  --
--------------------------
L = DBM:GetModLocalization(528)

L:SetGeneralLocalization{
	name 		= "무적의 오모르"
}

------------------------
--  Nazan & Vazruden  --
------------------------
L = DBM:GetModLocalization(529)

L:SetGeneralLocalization{
	name 		= "나잔과 바즈루덴"
}

-------------------------
--  The Blood Furnace  --
-------------------------
--  The Maker  --
-----------------
L = DBM:GetModLocalization(555)

L:SetGeneralLocalization{
	name 		= "재앙의 창조자"
}

---------------
--  Broggok  --
---------------
L = DBM:GetModLocalization(556)

L:SetGeneralLocalization{
	name 		= "브로고크"
}

----------------------------
--  Keli'dan the Breaker  --
----------------------------
L = DBM:GetModLocalization(557)

L:SetGeneralLocalization{
	name 		= "파괴자 켈리단"
}

---------------------------
--  The Shattered Halls  --
--------------------------------
--  Grand Warlock Nethekurse  --
--------------------------------
L = DBM:GetModLocalization(566)

L:SetGeneralLocalization{
	name 		= "대흑마법사 네더쿠르스"
}

--------------------------
--  Blood Guard Porung  --
--------------------------
L = DBM:GetModLocalization(728)

L:SetGeneralLocalization{
	name 		= "혈투사 포룽"
}

--------------------------
--  Warbringer O'mrogg  --
--------------------------
L = DBM:GetModLocalization(568)

L:SetGeneralLocalization{
	name 		= "전쟁인도자 오므로그"
}

----------------------------------
--  Warchief Kargath Bladefist  --
----------------------------------
L = DBM:GetModLocalization(569)

L:SetGeneralLocalization{
	name 		= "대족장 카르가스 블레이드피스트"
}

L:SetWarningLocalization({
	warnHeathen			= "이교도 경비병",
	warnReaver			= "학살자 경비병",
	warnSharpShooter	= "명사수 경비병"
})

L:SetTimerLocalization({
	timerHeathen		= "이교도 경비병: %s",
	timerReaver			= "학살자 경비병: %s",
	timerSharpShooter	= "명사수 경비병: %s"
})

L:SetOptionLocalization({
	warnHeathen			= "이교도 경비병 경고 보기",
	timerHeathen		= "이교도 경비병 타이머 바 보기",
	warnReaver			= "학살자 경비병 경고 보기",
	timerReaver			= "학살자 경비병 타이머 바 보기",
	warnSharpShooter	= "명사수 경비병 경고 보기",
	timerSharpShooter	= "명사수 경비병 타이머 바 보기"
})

------------------
--  Slave Pens  --
--------------------------
--  Mennu the Betrayer  --
--------------------------
L = DBM:GetModLocalization(570)

L:SetGeneralLocalization{
	name 		= "배반자 멘누"
}

---------------------------
--  Rokmar the Crackler  --
---------------------------
L = DBM:GetModLocalization(571)

L:SetGeneralLocalization{
	name 		= "딱딱이 로크마르"
}

------------------
--  Quagmirran  --
------------------
L = DBM:GetModLocalization(572)

L:SetGeneralLocalization{
	name 		= "쿠아그미란"
}

--------------------
--  The Underbog  --
--------------------
--  Hungarfen  --
-----------------
L = DBM:GetModLocalization(576)

L:SetGeneralLocalization{
	name 		= "헝가르펜"
}

---------------
--  Ghaz'an  --
---------------
L = DBM:GetModLocalization(577)

L:SetGeneralLocalization{
	name 		= "가즈안"
}

--------------------------
--  Swamplord Musel'ek  --
--------------------------
L = DBM:GetModLocalization(578)

L:SetGeneralLocalization{
	name 		= "늪군주 뮤즐레크"
}

-------------------------
--  The Black Stalker  --
-------------------------
L = DBM:GetModLocalization(579)

L:SetGeneralLocalization{
	name 		= "검은 추적자"
}

----------------------
--  The Steamvault  --
---------------------------
--  Hydromancer Thespia  --
---------------------------
L = DBM:GetModLocalization(573)

L:SetGeneralLocalization{
	name 		= "풍수사 세스피아"
}

-----------------------------
--  Mekgineer Steamrigger  --
-----------------------------
L = DBM:GetModLocalization(574)

L:SetGeneralLocalization{
	name 		= "기계박사 스팀리거"
}

L:SetWarningLocalization({
	warnSummon	= "스팀리거 정비사 - 대상 변경"
})

L:SetOptionLocalization({
	warnSummon	= "스팀리거 정비사 경고 보기"
})

L:SetMiscLocalization({
	Mechs	= "얘들아, 쟤네들을 부드럽게 만져줘라!"
})

--------------------------
--  Warlord Kalithresh  --
--------------------------
L = DBM:GetModLocalization(575)

L:SetGeneralLocalization{
	name 		= "장군 칼리스레쉬"
}

-----------------------
--  Auchenai Crypts  --
--------------------------------
--  Shirrak the Dead Watcher  --
--------------------------------
L = DBM:GetModLocalization(523)

L:SetGeneralLocalization{
	name 		= "죽음의 감시인 쉴라크"
}

-----------------------
--  Exarch Maladaar  --
-----------------------
L = DBM:GetModLocalization(524)

L:SetGeneralLocalization{
	name 		= "총독 말라다르"
}

------------------
--  Mana-Tombs  --
------------------
--    Trash     --
------------------
L = DBM:GetModLocalization("AuctTombsTrash")

L:SetGeneralLocalization{
	name 		= "일반몹"
}

-------------------
--  Pandemonius  --
-------------------
L = DBM:GetModLocalization(534)

L:SetGeneralLocalization{
	name 		= "팬더모니우스"
}

---------------
--  Tavarok  --
---------------
L = DBM:GetModLocalization(535)

L:SetGeneralLocalization{
	name 		= "타바로크"
}

----------------------------
--  Nexus-Prince Shaffar  --
----------------------------
L = DBM:GetModLocalization(537)

L:SetGeneralLocalization{
	name 		= "연합왕자 샤파르"
}

-----------
--  Yor  --
-----------
L = DBM:GetModLocalization(536)

L:SetGeneralLocalization{
	name 		= "요르"
}

---------------------
--  Sethekk Halls  --
-----------------------
--  Darkweaver Syth  --
-----------------------
L = DBM:GetModLocalization(541)

L:SetGeneralLocalization{
	name 		= "흑마술사 시스"
}

L:SetWarningLocalization({
	warnSummon	= "정령 소환"
})

L:SetOptionLocalization({
	warnSummon	= "소환된 정령 경고 보기"
})

------------
--  Anzu  --
------------
L = DBM:GetModLocalization(542)

L:SetGeneralLocalization{
	name 		= "안주"
}

L:SetWarningLocalization({
	warnBrood	= "안주의 혈족",
	warnStoned	= "%s|1;이;가; 돌로 돌아갔음"
})

L:SetOptionLocalization({
	warnBrood	= "안주의 혈족 경고 보기",
	warnStoned	= "영혼이 돌로 되돌아가면 경고 보기"
})

L:SetMiscLocalization({
    BirdStone	= "%s|1;이;가; 돌로 돌아감"--확인필요
})

------------------------
--  Talon King Ikiss  --
------------------------
L = DBM:GetModLocalization(543)

L:SetGeneralLocalization{
	name 		= "갈퀴대왕 이키스"
}

------------------------
--  Shadow Labyrinth  --
--------------------------
--  Ambassador Hellmaw  --
--------------------------
L = DBM:GetModLocalization(544)

L:SetGeneralLocalization{
	name 		= "사자 지옥아귀"
}

------------------------------
--  Blackheart the Inciter  --
------------------------------
L = DBM:GetModLocalization(545)

L:SetGeneralLocalization{
	name 		= "선동자 검은심장"
}

--------------------------
--  Grandmaster Vorpil  --
--------------------------
L = DBM:GetModLocalization(546)

L:SetGeneralLocalization{
	name 		= "단장 보르필"
}

--------------
--  Murmur  --
--------------
L = DBM:GetModLocalization(547)

L:SetGeneralLocalization{
	name 		= "울림"
}

-------------------------------
--  Old Hillsbrad Foothills  --
-------------------------------
--  Lieutenant Drake  --
------------------------
L = DBM:GetModLocalization(538)

L:SetGeneralLocalization{
	name 		= "부관 드레이크"
}

-----------------------
--  Captain Skarloc  --
-----------------------
L = DBM:GetModLocalization(539)

L:SetGeneralLocalization{
	name 		= "경비대장 스칼록"
}

--------------------
--  Epoch Hunter  --
--------------------
L = DBM:GetModLocalization(540)

L:SetGeneralLocalization{
	name 		= "시대의 사냥꾼"
}

------------------------
--  The Black Morass  --
------------------------
--  Chrono Lord Deja  --
------------------------
L = DBM:GetModLocalization(552)

L:SetGeneralLocalization{
	name 		= "시간의 군주 데자"
}

----------------
--  Temporus  --
----------------
L = DBM:GetModLocalization(553)

L:SetGeneralLocalization{
	name 		= "템퍼루스"
}

--------------
--  Aeonus  --
--------------
L = DBM:GetModLocalization(554)

L:SetGeneralLocalization{
	name 		= "아에누스"
}

L:SetWarningLocalization({
	warnEnrage	= "격노"
})

L:SetOptionLocalization({
	warnEnrage	= "격노 경고 보기"
})

L:SetMiscLocalization({
    AeonusFrenzy	= "%s|1이;가; 분노합니다!"
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PT")

L:SetGeneralLocalization({
	name = "차원문 타이머 (시동)"
})

L:SetWarningLocalization({
    WarnWavePortalSoon	= "곧 새 차원문",
    WarnWavePortal		= "%d번 차원문",
    WarnBossPortal		= "우두머리 등장"
})

L:SetTimerLocalization({
	TimerNextPortal		= "%d번 차원문"
})

L:SetOptionLocalization({
    WarnWavePortalSoon	= "새 차원문 사전 경고 보기",
    WarnWavePortal		= "새 차원문 경고 보기",
    WarnBossPortal		= "우두머리 등장 경고 보기",
	TimerNextPortal		= "다음 차원문 타이머 바 보기 (우두머리 잡은 후)",
	ShowAllPortalTimers	= "모든 차원문 타이머 바 보기 (부정확함)"
})

L:SetMiscLocalization({
	Shielddown			= "안 돼! 이런 나약한 무리에게 당하다니!"
})

--------------------
--  The Mechanar  --
-----------------------------
--  Gatewatcher Gyro-Kill  --
-----------------------------
L = DBM:GetModLocalization("Gyrokill")--Not in EJ

L:SetGeneralLocalization({
	name = "문지기 회전톱날"
})

-----------------------------
--  Gatewatcher Iron-Hand  --
-----------------------------
L = DBM:GetModLocalization("Ironhand")--Not in EJ

L:SetGeneralLocalization({
	name = "문지기 무쇠주먹"
})

L:SetMiscLocalization({
	JackHammer			= "%s|1이;가; 자신의 망치를 위협적으로 치켜듭니다..."
})

------------------------------
--  Mechano-Lord Capacitus  --
------------------------------
L = DBM:GetModLocalization(563)

L:SetGeneralLocalization{
	name 		= "기계군주 캐퍼시투스"
}

------------------------------
--  Nethermancer Sepethrea  --
------------------------------
L = DBM:GetModLocalization(564)

L:SetGeneralLocalization{
	name 		= "황천술사 세페스레아"
}

--------------------------------
--  Pathaleon the Calculator  --
--------------------------------
L = DBM:GetModLocalization(565)

L:SetGeneralLocalization{
	name 		= "철두철미한 파탈리온"
}

--------------------
--  The Botanica  --
--------------------------
--  Commander Sarannis  --
--------------------------
L = DBM:GetModLocalization(558)

L:SetGeneralLocalization{
	name 		= "지휘관 새래니스"
}

------------------------------
--  High Botanist Freywinn  --
------------------------------
L = DBM:GetModLocalization(559)

L:SetGeneralLocalization{
	name 		= "고위 식물학자 프레이윈"
}

L:SetWarningLocalization({
	warnTranq	= "껍질덩굴손 파수꾼 - 대상 변경"
})

L:SetOptionLocalization({
	warnTranq	= "껍질덩굴손 파수꾼 경고 보기"
})

-----------------------------
--  Thorngrin the Tender  --
-----------------------------
L = DBM:GetModLocalization(560)

L:SetGeneralLocalization{
	name 		= "감시인 쏜그린"
}

-----------
--  Laj  --
-----------
L = DBM:GetModLocalization(561)

L:SetGeneralLocalization{
	name 		= "라즈"
}

---------------------
--  Warp Splinter  --
---------------------
L = DBM:GetModLocalization(562)

L:SetGeneralLocalization{
	name 		= "차원의 분리자"
}

--------------------
--  The Arcatraz  --
----------------------------
--  Zereketh the Unbound  --
----------------------------
L = DBM:GetModLocalization(548)

L:SetGeneralLocalization{
	name 		= "속박 풀린 제레케스"
}

-----------------------------
--  Dalliah the Doomsayer  --
-----------------------------
L = DBM:GetModLocalization(549)

L:SetGeneralLocalization{
	name 		= "파멸의 예언자 달리아"
}

---------------------------------
--  Wrath-Scryer Soccothrates  --
---------------------------------
L = DBM:GetModLocalization(550)

L:SetGeneralLocalization{
	name 		= "격노의 점술사 소코드라테스"
}

-------------------------
--  Harbinger Skyriss  --
-------------------------
L = DBM:GetModLocalization(551)

L:SetGeneralLocalization{
	name 		= "선구자 스키리스"
}

L:SetWarningLocalization({
	warnSplitSoon	= "곧 선구자의 환영",
	warnSplit	= "선구자의 환영"
})

L:SetOptionLocalization({
	warnSplitSoon	= "곧 선구자의 환영 경고 보기",
	warnSplit	= "선구자의 환영 경고 보기"
})

L:SetMiscLocalization({
	Split			= "밤하늘의 무한한 별처럼 온 우주를 덮으리라!"
})

--------------------------
--  Magisters' Terrace  --
--------------------------
--  Selin Fireheart  --
-----------------------
L = DBM:GetModLocalization(530)

L:SetGeneralLocalization{
	name 		= "셀린 파이어하트"
}

L:SetWarningLocalization({
    warningFelCrystal	= "지옥 수정 - 대상 변경"
})

L:SetTimerLocalization({
	timerFelCrystal		= "~지옥 수정"
})

L:SetOptionLocalization({
	warningFelCrystal	= "지옥 수정 대상 변경 특수 경고 보기",
	timerFelCrystal		= "지옥 수정 타이머 바 보기"
})

----------------
--  Vexallus  --
----------------
L = DBM:GetModLocalization(531)

L:SetGeneralLocalization{
	name 		= "벡살루스"
}

L:SetWarningLocalization({
	warnEnergy	= "순수한 에너지 - 대상 변경"
})

L:SetOptionLocalization({
	warnEnergy	= "순수한 에너지 경고 보기"
})

--------------------------
--  Priestess Delrissa  --
--------------------------
L = DBM:GetModLocalization(532)

L:SetGeneralLocalization{
	name 		= "여사제 델리사"
}

L:SetMiscLocalization({
	DelrissaEnd		= "뭔가... 잘못됐어..."
})

------------------------------------
--  Kael'thas Sunstrider (Party)  --
------------------------------------
L = DBM:GetModLocalization(533)

L:SetGeneralLocalization{
	name 		= "캘타스 선스트라이더 (던전)"
}

L:SetMiscLocalization({
	KaelP2				= "세상을... 거꾸로... 뒤집어주마."
})
