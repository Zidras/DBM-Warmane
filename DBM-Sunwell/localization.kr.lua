if GetLocale() ~= "koKR" then return end
local L

---------------
--  Kalecgos --
---------------
L = DBM:GetModLocalization("Kal")

L:SetGeneralLocalization{
	name = "칼렉고스"
}

L:SetWarningLocalization{
	WarnPortal			= "정신 세계 #%d : >%s< (%d 파티)",
	SpecWarnWildMagic	= "마법 폭주 - %s!"
}

L:SetOptionLocalization{
	WarnPortal			= "$spell:46021 대상 알림 보기",
	SpecWarnWildMagic	= "마법 폭주 대상이 된 경우 특수 경고 보기",
	ShowFrame			= "정신 세계에 있는 공격대원을 별도 창으로 보기" ,
	FrameClassColor		= "정신 세계 창 직업 색상 사용",
	FrameUpwards		= "정신 세계 창 바를 위쪽으로 확장",
	FrameLocked			= "정신 세계 창 고정(이동불가로 설정)"
}

L:SetMiscLocalization{
	Demon				= "타락의 사스로바르",
	Heal				= "치유량 100% 증가",
	Haste				= "시전속도 100% 증가",
	Hit					= "물리 적중률 50% 감소",
	Crit				= "치명타 대미지 100% 증가",
	Aggro				= "위협수준 생성 100% 증가",
	Mana				= "마나 소모량 50% 감소",
	FrameTitle			= "정신 세계",
	FrameLock			= "프레임 잠금",
	FrameClassColor		= "직업 색상 사용",
	FrameOrientation	= "위로 확장",
	FrameHide			= "프레임 숨김",
	FrameClose			= "메뉴 닫기"
}

----------------
--  Brutallus --
----------------
L = DBM:GetModLocalization("Brutallus")

L:SetGeneralLocalization{
	name = "브루탈루스"
}

L:SetMiscLocalization{
	Pull			= "하, 새끼 양이 잔뜩 몰려오는구나!"
}

--------------
--  Felmyst --
--------------
L = DBM:GetModLocalization("Felmyst")

L:SetGeneralLocalization{
	name = "지옥안개"
}

L:SetWarningLocalization{
	WarnPhase		= "%s 단계"
}

L:SetTimerLocalization{
	TimerPhase		= "다음 %s 단계"
}

L:SetOptionLocalization{
	WarnPhase		= "단계 전환 알림 보기",
	TimerPhase		= "다음 단계 바 보기"
}

L:SetMiscLocalization{
	Air				= "비행",
	Ground			= "지상",
	AirPhase		= "나는 어느 때보다도 강하다!",
	Breath			= "숨을 깊게 들이마십니다."
}

-----------------------
--  The Eredar Twins --
-----------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "에레다르 쌍둥이"
}

L:SetMiscLocalization{
	Nova			= "방향을 돌려 암흑 회오리를",
	Conflag			= "방향을 돌려 거대한 불길을",
	Sacrolash		= "여군주 사크로래쉬",
	Alythess		= "대흑마법사 알리테스"
}

------------
--  M'uru --
------------
L = DBM:GetModLocalization("Muru")

L:SetGeneralLocalization{
	name = "므우루"
}

L:SetWarningLocalization{
	WarnHuman		= "타락한 엘프 (%d)",
	WarnVoid		= "공허의 파수병 (%d)",
	WarnFiend		= "어둠 마귀"
}

L:SetTimerLocalization{
	TimerHuman		= "다음 타락한 엘프 (%s)",
	TimerVoid		= "다음 공허의 파수병 (%s)",
	TimerPhase		= "엔트로피우스"
}

L:SetOptionLocalization{
	WarnHuman		= "타락한 엘프 알림 보기",
	WarnVoid		= "공허의 파수병 알림 보기",
	WarnFiend		= "어둠 마귀 알림 보기",
	TimerHuman		= "다음 타락한 엘프 바 보기",
	TimerVoid		= "다음 공허의 파수병 바 보기",
	TimerPhase		= "2 단계 바 보기"
}

L:SetMiscLocalization{
	Entropius		= "엔트로피우스"
}

----------------
--  Kil'jeden --
----------------
L = DBM:GetModLocalization("Kil")

L:SetGeneralLocalization{
	name = "킬제덴"
}

L:SetWarningLocalization{
	WarnDarkOrb		= "보호의 구슬 생성",
	WarnBlueOrb		= "푸른용의 수정구",
	SpecWarnDarkOrb	= "보호의 구슬 생성!",
	SpecWarnBlueOrb	= "푸른용의 수정구 활성화!"
}

L:SetTimerLocalization{
	TimerBlueOrb	= "수정구 활성화"
}

L:SetOptionLocalization{
	WarnDarkOrb		= "보호의 구슬 생성 알림 보기",
	WarnBlueOrb		= "푸른용의 수정구 알림 보기",
	SpecWarnDarkOrb	= "보호의 구슬 생성 특수 경고 보기",
	SpecWarnBlueOrb	= "푸른용의 수정구 활성화 특수 경고 보기",
	TimerBlueOrb	= "푸른용의 수정구 활성화 바 보기"
}

L:SetMiscLocalization{
	YellPull		= "녀석들은 소모품일 뿐이다. 자, 봐라! 살게라스가 해내지 못한 일을 내가 해낼 것이다! 이 보잘것없는 세상을 갈가리 찢어발기고 불타는 군단의 진정한 주인으로 우뚝 서리라! 종말이 다가왔다! 어디 한번 세계를 구해 봐라!",
	OrbYell1		= "수정구에 힘을 쏟겠습니다! 준비하세요!",
	OrbYell2		= "다른 수정구에 힘을 불어넣었습니다! 어서요!",
	OrbYell3		= "다른 수정구가 준비됐습니다! 서두르세요!",
	OrbYell4		= "모든 힘을 수정구에 실었습니다! 이제 그대들의 몫입니다!"
}
