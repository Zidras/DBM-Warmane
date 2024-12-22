if GetLocale() ~= "koKR" then return end

local L

--------------------------------
-- 안카헤트 - 고대 왕국       --
--------------------------------
-- Prince Taldaram --
---------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "공작 탈다람"
})

-----------------
-- 장로 나독스 --
-----------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "장로 나독스"
})

-------------------------
-- 어둠추적자 제도가 --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "어둠추적자 제도가"
})

-------------------
-- 사자 볼라즈 --
-------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "사자 볼라즈"
})

--------------
-- 아마니타르 --
--------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "아마니타르"
})

-----------------
-- 아졸네룹    --
---------------------
-- 문지기 크릭시르 --
---------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "문지기 크릭시르"
})

----------------
-- 하드로녹스 --
----------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "하드로녹스"
})

--------------
-- 아눕아락 --
--------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "아눕아락(5인)"
})

---------------------------------
-- 시간의 동굴 : 옛 스트라솔름 --
---------------------------------
-- 살덩이갈고리 --
------------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "살덩이갈고리"
})

-----------------------
-- 살덩이창조자 살람 --
-----------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "살덩이창조자 살람"
})

------------------------
-- 시간의 군주 에포크 --
------------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "시간의 군주 에포크"
})

--------------
-- 말가니스 --
--------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "말가니스"
})

L:SetMiscLocalization({
	Outro	= "너의 여정은 이제 막 시작이다, 젊은 왕자여. 병사들을 모아 극한의 땅, 노스렌드로 나를 찾아와라. 그곳에서 모든 일이 결판날 것이다. 네 진정한 운명도 그곳에서 시작되지."
})

-------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "옛 스트라솔름: 스컬지 공격"
})

L:SetWarningLocalization({
	WarningWaveNow	= "스컬지 공격 #%d: %s"
})

L:SetTimerLocalization({
	TimerWaveIn		= "다음 스컬지 공격: #6",
	TimerRoleplay	= "아서스 이야기 종료"
})

L:SetOptionLocalization({
	WarningWaveNow	= "다음 스컬지 공격 알림 보기",
	TimerWaveIn		= "우두머리 처치 이후 다음 스컬지 공격 바 보기",
	TimerRoleplay	= "시작 이야기 바 보기"
})

L:SetMiscLocalization({
	Meathook	= "살덩이갈고리",
	Salramm		= "살덩이창조자 살람",
	Devouring	= "게걸스러운 구울",
	Enraged		= "격노한 구울",
	Necro		= "정예 강령술사",
	Fiend		= "어둠의 강령술사",
	Stalker		= "무덤 거미",
	Abom		= "위액 골렘",
	Acolyte		= "수행 사제",
	Wave1		= "%d %s",
	Wave2		= "%d %s, %d %s",
	Wave3		= "%d %s, %d %s, %d %s",
	Wave4		= "%d %s, %d %s, %d %s, %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "스컬지 공격 = (%d+)/10",
	Roleplay	= "드디어 나타나셨군, 우서.",
	Roleplay2	= "준비가 된 것 같군. 명심해라. 이들은 끔찍한 역병에 걸렸고, 어차피 죽을 것이다. 스컬지의 손아귀에서 로데론을 지키려면 스트라솔름을 정화해야 한다. 가자."
})

-------------------
-- 드락타론 성채 --
-------------------
-- 송곳아귀 --
--------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "송곳아귀"
})

L:SetMiscLocalization({
	YellExplosion = "터져라, 뻥!"
})

-------------------
-- 소환사 노보스 --
-------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "소환사 노보스"
})

L:SetWarningLocalization({
	WarnCrystalHandler	= "수정 제어사 생성됨(남음 %d개)"
})

L:SetTimerLocalization({
	timerCrystalHandler	= "수정 제어사 생성"
})

L:SetOptionLocalization({
	WarnCrystalHandler	= "수정 제어사 생성 시 경고 표시",
	timerCrystalHandler	= "다음 수정 제어사 생성에 대한 타이머 표시"
})

L:SetMiscLocalization({
	YellPull		= "견딜 수 없는 한기가 죽음을 몰고 오리니.",
	HandlerYell		= "와서 나를 보호해라! 어서! 망할 놈들아!",
	Phase2			= "부질없는 짓인 줄 잘 알고 있겠지!",
	YellKill		= "이래 봤자... 아무 소용 없다."
})

---------------------
-- 랩터왕 서슬발톱 --
---------------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "랩터왕 서슬발톱"
})

-------------------
-- 예언자 타론자 --
-------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "예언자 타론자"
})

------------
-- 군드락 --
--------------
-- 슬라드란 --
--------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "슬라드란"
})

------------
-- 무라비 --
------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "무라비"
})

-----------------------
-- 드라카리 거대골램 --
-----------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "드라카리 거대골램"
})

L:SetWarningLocalization({
	WarningElemental	= "2단계: 정령",
	WarningStone		= "1단계: 거대골렘"
})

L:SetOptionLocalization({
	WarningElemental	= "2단계: 정령 경고 보기",
	WarningStone		= "1단계: 거대골렘 경고 보기"
})

---------------
-- 갈다라 --
---------------
L = DBM:GetModLocalization("Galdarah")

L:SetGeneralLocalization({
	name = "갈다라"
})

L:SetWarningLocalization({
	TimerPhase2		= "2단계: 아칼리의 화신",
	TimerPhase1		= "1단계: 아칼리의 고위 사제"
})

L:SetTimerLocalization({
	TimerPhase2		= "2단계: 아칼리의 화신",
	TimerPhase1		= "1단계: 아칼리의 고위 사제"
})

L:SetOptionLocalization({
	TimerPhase2		= "2단계: 아칼리의 화신 경고 보기",
	TimerPhase1		= "1단계: 아칼리의 고위 사제 경고 보기"
})

L:SetMiscLocalization({
	YellPhase2_1	= "지금 이 순간부터 아무것도 남지 않을 것이다!",
	YellPhase2_2	= "힘이 뭔지 알고 싶나? 진짜 힘을 보여주지!"
})

-----------------------
-- 사나운 엑크 --
-----------------------
L = DBM:GetModLocalization("Eck")

L:SetGeneralLocalization({
	name = "사나운 엑크"
})

-----------------
-- 번개의 전당 --
---------------------
-- 장군 비야른그림 --
---------------------
L = DBM:GetModLocalization("Bjarngrin")

L:SetGeneralLocalization({
	name = "장군 비야른그림"
})

--------------
-- 아이오나 --
--------------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "아이오나"
})

----------
-- 볼칸 --
----------
L = DBM:GetModLocalization("Volkhan")

L:SetGeneralLocalization({
	name = "볼칸"
})

----------
-- 로켄 --
----------
L = DBM:GetModLocalization("Loken")

L:SetGeneralLocalization({
	name = "로켄"
})

-----------------
-- 돌의 전당   --
-----------------
-- 고뇌의 마녀 --
-----------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "고뇌의 마녀"
})

----------------
-- 크리스탈루스 --
----------------
L = DBM:GetModLocalization("Krystallus")

L:SetGeneralLocalization({
	name = "크리스탈루스"
})

-----------------------
-- 무쇠구체자 쇼니르 --
-----------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "무쇠구체자 쇼니르"
})

--------------------------------------
--  Brann Bronzebeard Escort Event  --
--------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "브란 브론즈비어드를 보호하라"
})

L:SetWarningLocalization({
	WarningPhase	= "%d 단계"
})

L:SetTimerLocalization({
	timerEvent	= "전투 종료"
})

L:SetOptionLocalization({
	WarningPhase	= "단계 전환 알림 보기",
	timerEvent		= "전투 종료까지 남은시간 바 보기"
})

L:SetMiscLocalization({
	Pull		= "이제 잘 보시라고요! 제가 눈 깜짝할 사이에 정보를...",
	Phase1		= "보안 경보를 발령합니다. 출처 불명의 역사 자료 분석은 하위 등급 대기열로 이전됩니다. 방어 작업을 시작합니다.",
	Phase2		= "위협 지수가 임계점을 돌파했습니다. 천체 기록을 중단합니다. 보안 수준이 상승했습니다.",
	Phase3		= "위협 지수가 높습니다. 공허 분석을 종료합니다. 안전성 검증을 시작합니다.",
	Kill		= "경고, 보안 잠금장치가 비활성화되었습니다. 기억 장치 소거를 시작합..."
})

---------------
-- 마력의 탑 --
----------------
-- 아노말루스 --
----------------
L = DBM:GetModLocalization("Anomalus")

L:SetGeneralLocalization({
	name = "아노말루스"
})

-----------------------
-- 정원사 오르모로크 --
-----------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "정원사 오르모로크"
})

--------------------------
-- 대학자 텔레스트라 --
--------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "대학자 텔레스트라"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "곧 분리",
	WarningSplitNow		= "분리",
	WarningMerge		= "융합"
})
L:SetOptionLocalization({
	WarningSplitSoon	= "분리 사전 경고 보기",
	WarningSplitNow		= "분리 경고 보기",
	WarningMerge		= "융합 경고 보기"
})

L:SetMiscLocalization({
	SplitTrigger1		= "여기엔 내가 참 많지.",
	SplitTrigger2		= "과연 나를 감당할 수 있겠느냐!",
	MergeTrigger		= "이제 끝을 볼 때다!"
})

-----------------
-- 케리스트라자 --
-----------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "케리스트라자"
})

---------------------------------
-- 사령관 콜루르그/스타우트비어드 --
---------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "알 수 없음"
if UnitFactionGroup("player") == "Alliance" then
	commander = "사령관 콜루르그"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "사령관 스타우트비어드"
end

L:SetGeneralLocalization({
	name = commander
})

----------------
-- 마력의 눈 --
---------------------
-- 심문관 드라코스 --
---------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "심문관 드라코스"
})


L:SetOptionLocalization({
	MakeitCountTimer	= "매 순간을 소중히 업적 바 보기"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "매 순간을 소중히 가능"
})

--------------------
-- 마법사 군주 우롬 --
--------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "마법사 군주 우롬"
})

L:SetMiscLocalization({
	CombatStart		= "어리석은 족속들!"
})

------------------------
-- 바로스 클라우드스트라이더 --
------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "바로스 클라우드스트라이더"
})

-------------------------
-- 지맥 수호자 에레고스 --
-------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "지맥 수호자 에레고스"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "매 순간을 소중히 가능"
})

------------------
-- 우트가드 성채 --
---------------------
-- 공작 켈레세스 --
---------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "공작 켈레세스"
})

---------------------
-- 건축가 스카발드 --
-- & 감시자 달론   --
---------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "건축가 스카발드 & 감시자 달론"
})

---------------------
-- 약탈자 잉그바르 --
---------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "약탈자 잉그바르"
})

L:SetMiscLocalization({
	YellIngvarPhase2	= "내가 돌아왔다! 이번엔 내 도끼를 피할 수 없을 거다!",
	YellCombatEnd		= "안 돼! 난 더 잘할 수... 있는데..."
})

-------------------
-- 우트가드 첨탑 --
-------------------
-- 학살자 스카디 --
-------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "학살자 스카디"
})

L:SetMiscLocalization({
	CombatStart		= "웬 놈들이 감히 여길? 정신 차려라, 형제들아! 녀석들을 처치하면 거하게 한 상 차려 주마!",
	Phase2			= "피도 눈물도 없는 것들아! 불쌍한 비룡을 괴롭히다니, 가만두지 않겠다!"
})

------------
-- 왕 이미론 --
------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "왕 이미론"
})

-----------------------
-- 스발라 소로우그레이브 --
-----------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "스발라 소로우그레이브"
})

L:SetTimerLocalization({
	timerRoleplay		= "스발라 소로우그레이브 활성"
})

L:SetOptionLocalization({
	timerRoleplay		= "스발라 소로우그레이브 활성 바 보기"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "주인님! 당신께서 주신 일을 행했습니다. 이제, 축복을 내려 주소서!"
})

---------------------
-- 고르톡 패일후프 --
---------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "고르톡 페일후프"
})

-----------------
-- 보라빛 요새 --
-----------------
-- 시아니고사 --
----------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "시아니고사"
})

L:SetMiscLocalization({
	CyanArrived	= "훌륭한 방어였다만, 도시를 지키게 둘 수는 없지! 직접 말리고스 님의 의지를 실현하리라!"
})

------------
-- 에레켐 --
------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "에레켐"
})

------------
-- 이코론 --
------------
L = DBM:GetModLocalization("Ichoron")

L:SetGeneralLocalization({
	name = "이코론"
})

---------------
-- 라반토르 --
---------------
L = DBM:GetModLocalization("Lavanthor")

L:SetGeneralLocalization({
	name = "라반토르"
})

------------
-- 모라그 --
------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "모라그"
})

------------
-- 제보즈 --
------------
L = DBM:GetModLocalization("Xevoss")

L:SetGeneralLocalization({
	name = "제보즈"
})

---------------------
-- 파멸자 주라마트 --
---------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "파멸자 주라마트"
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "보랏빛 요새: 차원문"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "곧 새로운 차원문",
	WarningPortalNow	= "차원문 #%d",
	WarningBossNow		= "곧 우두머리 등장"
})

L:SetTimerLocalization({
	TimerPortalIn	= "차원문 #%d" ,
})

L:SetOptionLocalization({
	WarningPortalNow	= "차원문 알림 보기",
	WarningPortalSoon	= "차원문 이전에 알림 보기",
	WarningBossNow		= "곧 우두머리 등장 알림 보기",
	TimerPortalIn		= "우두머리 처치 이후 다음 차원문 바 보기",
	ShowAllPortalTimers	= "모든 차원문 바 보기(부정확함)"
})

L:SetMiscLocalization({
	Sealbroken	= "문을 부쉈다! 달라란으로 가는 길이 열렸다! 이제 마력 전쟁의 끝을 내자!",
	WavePortal	= "차원문 열림: (%d+)/18"
})

-----------------------------
--  Trial of the Champion  --
-----------------------------
--  The Black Knight  --
------------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "흑기사"
})

L:SetOptionLocalization({
	AchievementCheck	= "이건 약과야 업적 실패를 파티 대화로 알리기"
})

L:SetMiscLocalization({
	Pull				= "잘했네. 오늘 자네의 가치를 잘 보여주었...",
	AchievementFailed	= ">> 업적 실패 : 구울 폭발에 피해 입음 (%s) <<",
	YellCombatEnd		= "안 돼! 또 무릎 꿇을 수는... 없는데..."
})

-----------------------
--  Grand Champions  --
-----------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "도시 대표 용사"
})

L:SetMiscLocalization({
	YellCombatEnd	= "잘 싸웠네! 다음 상대는 은빛십자군의 일원이라네. 그들을 상대로 자신의 무용을 증명해 보게."
})

----------------------------------
--  Argent Confessor Paletress  --
----------------------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "은빛 고해사제 페일트리스"
})

L:SetMiscLocalization({
	YellCombatEnd	= "훌륭히 해내셨군요!"
})

-----------------------
--  Eadric the Pure  --
-----------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "성기사 에드릭"
})

L:SetMiscLocalization({
	YellCombatEnd	= "항복! 제가 졌습니다. 훌륭한 솜씨군요. 이제 집에 가도 되겠습니까?"
})

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "이크와 크리크"
})

----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "제련장인 가프로스트"
})

L:SetOptionLocalization({
	AchievementCheck	= "11번은 제발! 업적 실패시 파티 대화로 알리기"
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "거대한 사로나이트 덩어리를 당신에게 던집니다!",
	AchievementWarning	= "경고 - 영구 결빙 중첩 높음: %s (%d 중첩)",
	AchievementFailed	= ">> 11번은 제발 업적 실패 : %s (%d 중첩) <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "스컬지군주 티라누스"
})

L:SetMiscLocalization({
	CombatStart		= "아아. 용감하고 용감한 모험가들아, 참견도 이제 끝이다. 네놈들 뒤에 있는 굴에서 뼈와 칼이 부딪치는 소리가 들리는가? 네놈들에게 곧 닥칠 죽음의 소리다.", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
	HoarfrostTarget	= "노려보며 얼음 공격을 준비합니다!",
	YellCombatEnd	= "말도 안 돼... 서릿발송곳니... 경고를..."
})

----------------------
--  Forge of Souls  --
----------------------
--  Bronjahm  --
----------------
L = DBM:GetModLocalization("Bronjahm")

L:SetGeneralLocalization({
	name = "브론잠"
})

-------------------------
--  Devourer of Souls  --
-------------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "영혼의 포식자"
})

---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "투영의 전당: 일반구간"
})

L:SetWarningLocalization({
	WarnNewWaveSoon		= "곧 새로운 영혼 공격 시작",
	WarnNewWave			= "%s 시작"
})

L:SetTimerLocalization({
	TimerNextWave		= "다음 영혼 공격"
})

L:SetOptionLocalization({
	WarnNewWave				= "곧 우두머리 등장 알림 보기",
	WarnNewWaveSoon			= "우두머리 처치 이후 다음 영혼 공격 알림 보기",
	ShowAllWaveWarnings		= "모든 영혼 공격 알림 보기",
	TimerNextWave			= "우두머리 처치 이후 다음 영혼 공격 바 보기",
	ShowAllWaveTimers		= "모든 영혼 공격 이전에 알림 및 바 보기(부정확함)"
})

L:SetMiscLocalization({
	Falric				= "팔릭",
	WaveCheck			= "영혼 공격 = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization("Falric")

L:SetGeneralLocalization({
	name = "팔릭"
})

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization("Marwyn")

L:SetGeneralLocalization({
	name = "마윈"
})

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization("LichKingEvent")

L:SetGeneralLocalization({
	name = "아서스에게서 도망치기"
})

L:SetTimerLocalization({
	achievementEscape	= "탈출 업적"
})

L:SetOptionLocalization({
	WarnWave		= "새로운 적 등장시 알림 보기"
})

L:SetMiscLocalization({
	ArthasYellKill	= "발사! 발사!",
	Ghoul			= "분노한 구울",		--creature id 36940. Not sure how to use these in function above to simplify locals though
	Abom			= "육중한 누더기골렘",	--creature id 37069
	WitchDoctor		= "되살아난 의술사",	--creature id 36941
	Wave1			= "도망칠 방법은 없다!",
	Wave2			= "무덤의 한기에 굴복하라.",
	Wave3			= "또 막다른 곳이다.",
	Wave4			= "얼마나 더 싸울 수 있겠느냐?"
})
