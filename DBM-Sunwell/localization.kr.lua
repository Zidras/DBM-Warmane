if GetLocale() ~= "koKR" then return end
local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")

L:SetGeneralLocalization({
	name = "칼렉고스"
})

L:SetWarningLocalization({
	WarnPortal			= "차원문 #%d : >%s< (%d 파티)",
	SpecWarnWildMagic	= "마법 폭주 - %s!"
})

L:SetOptionLocalization({
	WarnPortal			= "$spell:46021 대상 경고 보기",
	SpecWarnWildMagic	= "마법 폭주 특수 경고 보기",
	ShowRespawn			= "전멸 후 보스 재생성 타이머 표시",
	ShowFrame			= "정신 세계 공대원 창 보기" ,
	FrameClassColor		= "정신 세계 창에 직업 색상 사용",
	FrameUpwards		= "정신 세계 창을 위쪽으로 확장",
	FrameLocked			= "정신 세계 창 위치 고정"
})

L:SetMiscLocalization({
	Demon				= "타락의 사스로바르",
	Heal				= "치유량 + 100%",
	Haste				= "가속 + 100%",
	Hit					= "근접 적중률 - 50%",
	Crit				= "치명타 + 100%",
	Aggro				= "어그로 + 100%",
	Mana				= "마나 소비 - 50%",
	FrameTitle			= "정신 세계",
	FrameLock			= "창 위치 고정",
	FrameClassColor		= "직업 색상 사용",
	FrameOrientation	= "위로 확장",
	FrameHide			= "창 숨김",
	FrameClose			= "닫기",
	FrameGUIMoveMe		= "위치 이동"
})

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization({
	name = "브루탈루스"
})

L:SetOptionLocalization({
	RangeFrameActivation= "범위 프레임 활성화",
	AlwaysOn			= "만남 시작 시. 필터 무시",
	OnDebuff			= "디버프 시. 디버프 필터를 적용합니다."
})

L:SetMiscLocalization({
	Pull			= "하, 새끼 양이 잔뜩 몰려오는구나!"
})

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization({
	name = "지옥안개"
})

L:SetWarningLocalization({
	WarnPhase		= "%s 단계"
})

L:SetTimerLocalization({
	TimerPhase		= "다음 %s 단계"
})

L:SetOptionLocalization({
	WarnPhase		= "다음 단계 경고 보기",
	TimerPhase		= "다음 단계 타이머 바 보기"
})

L:SetMiscLocalization({
	Air				= "비행",
	Ground			= "지상",
	AirPhase		= "나는 어느 때보다도 강하다!",
	Breath			= "숨을 깊게 들이마십니다."
})

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name = "에레다르 쌍둥이"
})

L:SetMiscLocalization({
	Nova			= "방향을 돌려 암흑 회오리를",
	Conflag			= "방향을 돌려 거대한 불길을",
	Sacrolash		= "여군주 사크로래쉬",
	Alythess		= "대흑마법사 알리테스"
})

------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization({
	name = "므우루"
})

L:SetWarningLocalization({
	WarnHuman		= "엘프 (%d)",
	WarnVoid		= "공허의 파수병 (%d)",
	WarnFiend		= "어둠 마귀 등장"
})

L:SetTimerLocalization({
	TimerHuman		= "다음 엘프 (%s)",
	TimerVoid		= "다음 보이드 (%s)",
	TimerPhase		= "엔트로피우스"
})

L:SetOptionLocalization({
	WarnHuman		= "엘프 경고 보기",
	WarnVoid		= "공허의 파수병 경고 보기",
	WarnFiend		= "2단계 마귀 경고 보기",
	TimerHuman		= "엘프 타이머 바 보기",
	TimerVoid		= "공허의 파수병 타이머 바 보기",
	TimerPhase		= "2단계 전환 타이머 바 보기"
})

L:SetMiscLocalization({
	Entropius		= "엔트로피우스"
})

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization({
	name = "킬제덴"
})

L:SetWarningLocalization({
	WarnDarkOrb		= "보호의 구슬 등장",
	WarnBlueOrb		= "푸른용의 수정구 활성화",
	SpecWarnDarkOrb		= "보호의 구슬 등장!",
	SpecWarnBlueOrb		= "푸른용의 수정구 활성화!"
})

L:SetTimerLocalization({
	TimerBlueOrb	= "수정구 활성화"
})

L:SetOptionLocalization({
	WarnDarkOrb		= "보호의 구슬 등장 알림 보기",
	WarnBlueOrb		= "푸른용의 수정구 알림 보기",
	SpecWarnDarkOrb	= "보호의 구슬 등장 특수 경고 보기",
	SpecWarnBlueOrb	= "푸른용의 수정구 활성화 특수 경고 보기",
	TimerBlueOrb	= "푸른용의 수정구 활성화 타이머 바 보기"
})

L:SetMiscLocalization({
	YellPull		= "녀석들은 소모품일 뿐이다. 자, 봐라! 살게라스가 해내지 못한 일을 내가 해낼 것이다! 이 보잘것없는 세상을 갈가리 찢어발기고 불타는 군단의 진정한 주인으로 우뚝 서리라! 종말이 다가왔다! 어디 한번 세계를 구해 봐라!",
	OrbYell1		= "수정구에 힘을 쏟겠습니다! 준비하세요!",
	OrbYell2		= "다른 수정구에 힘을 불어넣었습니다! 어서요!",
	OrbYell3		= "다른 수정구가 준비됐습니다! 서두르세요!",
	OrbYell4		= "모든 힘을 수정구에 실었습니다! 이제 그대들의 몫입니다!"
})
