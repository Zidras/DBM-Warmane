if GetLocale() ~= "koKR" then return end

local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("PvPGeneral")

L:SetGeneralLocalization({
	name	= "기본 전장 기능"
})

L:SetTimerLocalization({
	TimerFlag		= "깃발 재생성",
	TimerShadow		= "어둠의 시야",
	TimerStart		= "게임 시작",
	TimerWin		= "승리"
})

L:SetOptionLocalization({
	AutoSpirit			= "전장에서 사망시 자동으로 무덤 이동",
	ColorByClass		= "전장 점수판 캐릭터명에 직업 색상 사용",
	HideBossEmoteFrame	= "화면 가운데 나타나는 전장 메세지, 주둔지 및 길드 알림 숨김",
	ShowBasesToWin		= "필요 점령 갯수 보기",
	ShowEstimatedPoints	= "승/패 예상 포인트 보기",
	ShowFlagCarrier		= "깃발 운반자 보기",
	ShowGatesHealth		= "관문 체력 바 보기(진행 도중인 전장에 진입한경우 맞지 않음)",
	ShowRelativeGameTime= "전장 시작 시간을 기준으로 승리 타이머 채우기(비활성화하면 막대가 항상 가득 찬 것처럼 보입니다)",
	TimerCap			= "깃발 점령 타이머 보기",
	TimerFlag			= "깃발 재생성 타이머 보기",
	TimerShadow			= "어둠의 눈 타이머 보기",
	TimerStart			= "시작 타이머 보이기",
	TimerWin			= "점령 타이머 보기"
})

L:SetMiscLocalization({
	--BG 2 minutes
	BgStart120TC		= "2분 후 전투가 시작됩니다!",
	--BG 1 minute
	BgStart60TC			= "1분 후 전투가 시작됩니다!",
	BgStart60AlteracTC	= "알터랙 계곡 전투 개시 1분 전...",
	BgStart60SotA2TC	= "1분 후 고대의 해안 두 번째 전투가 시작됩니다.",
	BgStart60WarsongTC	= "1분 후 전쟁노래 협곡 전투가 시작됩니다!",
	-- BG 30 seconds
	BgStart30TC			= "30초 후 전투가 시작됩니다!",
	BgStart30AlteracTC	= "알터랙 계곡 전투 개시 30초 전...",
	BgStart30SotA2TC	= "30초 후 두 번째 전투가 시작됩니다. 준비하세요!",
	BgStart30WarsongTC	= "30초 후 전쟁노래 협곡 전투가 시작됩니다. 준비하십시오!",
	--
	ArenaInvite		= "전투 참여",
	Start60TC		= "투기장 전투 시작 1분 전입니다!",
	Start30TC		= "투기장 전투 시작 30초 전입니다!",
	Start15TC		= "투기장 전투 시작 15초 전입니다!",
	BasesToWin		= "필요 점령 갯수 : %d",
	WinBarText		= "%s 획득",
	-- Flag carrying system
	Flag			= "깃발",
	FlagResetTC		= "깃발이 다시 제자리로 돌아갔습니다.",
	FlagTakenTC		= "(.+)|1이;가; 깃발을 차지했습니다!",
	FlagCapturedTC	= ".+가 깃발을 차지했습니다!",
	FlagDroppedTC	= "깃발이 떨어졌습니다!",
	--
	ExprFlagPickUpTC	= "(.+)|1이;가; .+ 깃발을 손에 넣었습니다!",
	ExprFlagCapturedTC	= "(.+)|1이;가; .+ 깃발 쟁탈에 성공했습니다!",
	ExprFlagReturnTC	= "(.+)|1이;가; .+ 깃발을 되찾았습니다!",
	ExprFlagDroppedTC	= "(.+)|1이;가; .+ 깃발을 떨어뜨렸습니다!",
	Vulnerable1			= "약해져서",
	Vulnerable2			= "약해져서",
	-- Gates
	GatesHealthFrame				= "피해 입은 관문",
	HordeGateFront					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t 정문",
	HordeGateFrontDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t 정문",
	HordeGateWest					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t 서문",
	HordeGateWestDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t 서문",
	HordeGateEast					= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:127:143:92:107|t 동문",
	HordeGateEastDestroyedTex		= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:163:179:92:107|t 동문",
	AllianceGateFront				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t 정문",
	AllianceGateFrontDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t 정문",
	AllianceGateWest				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t 서문",
	AllianceGateWestDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t 서문",
	AllianceGateEast				= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:181:197:92:107|t 동문",
	AllianceGateEastDestroyedTex	= "|TInterface\\MINIMAP\\POIICONS.BLP:16:16:0:0:256:256:217:233:92:107|t 동문",
	-- Strands of the Ancients Gates emotes
	GreenEmeraldAttacked			= "초록 에메랄드 관문이 공격받고 있습니다!",
	GreenEmeraldDestroyed			= "초록 에메랄드 관문이 무너졌습니다!",
	BlueSapphireAttacked			= "푸른 사파이어 관문이 공격받고 있습니다!",
	BlueSapphireDestroyed			= "푸른 사파이어 관문이 무너졌습니다!",
	PurpleAmethystAttacked			= "보라 자수정 관문이 공격받고 있습니다!",
	PurpleAmethystDestroyed			= "보라 자수정 관문이 무너졌습니다!",
	RedSunAttacked					= "붉은 태양 관문이 공격받고 있습니다!",
	RedSunDestroyed					= "붉은 태양 관문이 무너졌습니다!",
	YellowMoonAttacked				= "노란 달 관문이 공격받고 있습니다!",
	YellowMoonDestroyed				= "노란 달 관문이 무너졌습니다!",
	ChamberAncientRelicsAttacked	= "유물의 방이 공격받고 있습니다!",
	ChamberAncientRelicsDestroyed	= "유물의 방 방어선이 깨졌습니다! 티탄 유물이 위험합니다!",
	-- Isle of Conquest Gates CHAT_MSG_BG_SYSTEM_NEUTRAL messages
	HordeGateFrontDestroyedTC		= "호드 요새 정문이 파괴되었습니다!",
	HordeGateWestDestroyedTC		= "호드 요새 서문이 파괴되었습니다!",
	HordeGateEastDestroyedTC		= "호드 요새 동문이 파괴되었습니다!",
	AllianceGateFrontDestroyedTC	= "얼라이언스 요새 정문이 파괴되었습니다!",
	AllianceGateWestDestroyedTC		= "얼라이언스 요새 서문이 파괴되었습니다!",
	AllianceGateEastDestroyedTC		= "얼라이언스 요새 동문이 파괴되었습니다!",
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "알터랙 계곡"
})

L:SetOptionLocalization({
	AutoTurnIn	= "알터랙 계곡내 퀘스트 자동 완료"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "아라시 분지"
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "폭풍의 눈"
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "전쟁노래 협곡"
})

------------------------------
--  Strand of the Ancients  --
------------------------------
L = DBM:GetModLocalization("StrandoftheAncients")

L:SetGeneralLocalization({
	name = "고대의 해안"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "정복의 섬"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "공성 전차 준비 완료",
	WarnSiegeEngineSoon	= "공성 전차 완료 10초 전"
})

L:SetTimerLocalization({
	TimerSiegeEngine	= "공성 전차 준비"
})

L:SetOptionLocalization({
	TimerSiegeEngine	= "공성 전차 준비 바 보기",
	WarnSiegeEngine		= "공성 전차 준비 완료 알림 보기",
	WarnSiegeEngineSoon	= "공성 전차 준비 완료 이전에 알림 보기"
})

L:SetMiscLocalization({
	SiegeEngine				= "공성 전차",
	GoblinStartAlliance		= "저기 시포리움 폭탄 보이세요? 제가 공성 전차를 수리하는 동안엔 그걸 사용해서 관문을 공격하세요!",
	GoblinStartHorde		= "공성 전차를 수리하는 동안 날 좀 지켜 달라고. 필요하면 저기 있는 시포리움 폭탄을 관문에 사용해!",
	GoblinHalfwayAlliance	= "반쯤 됐어요! 호드가 절 못 때리게 해주세요. 기계공학 학교에서는 싸움은 안 가르친다고요!",
	GoblinHalfwayHorde		= "반쯤 됐다고! 얼라이언스 놈들이 가까이 못 오게 해줘. 계약서에 전투 얘긴 없었다고!",
	GoblinFinishedAlliance	= "제 최고의 작품인 듯한데요! 이제 이 공성 전차를 몰고 나가셔도 돼요!",
	GoblinFinishedHorde		= "이제 이 공성 전차를 끌고 나가도 좋아!",
	GoblinBrokenAlliance	= "벌써 부서졌어요?! 괜찮아요. 제가 못 고칠 정도는 아니에요.",
	GoblinBrokenHorde		= "또 부서졌다고?! 내가 고쳐 주지... 하지만 사용자 과실이니까 공짜로 해 줄 순 없다고."
})
