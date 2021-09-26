if GetLocale() ~= "koKR" then return end
local L

------------------------
--  Rage Winterchill  --
------------------------
L = DBM:GetModLocalization("Rage")

L:SetGeneralLocalization{
	name = "격노한 윈터칠"
}

-----------------
--  Anetheron  --
-----------------
L = DBM:GetModLocalization("Anetheron")

L:SetGeneralLocalization{
	name = "아네테론"
}

----------------
--  Kazrogal  --
----------------
L = DBM:GetModLocalization("Kazrogal")

L:SetGeneralLocalization{
	name = "카즈로갈"
}

---------------
--  Azgalor  --
---------------
L = DBM:GetModLocalization("Azgalor")

L:SetGeneralLocalization{
	name = "아즈갈로"
}

------------------
--  Archimonde  --
------------------
L = DBM:GetModLocalization("Archimonde")

L:SetGeneralLocalization{
	name = "아키몬드"
}

----------------
-- WaveTimers --
----------------
L = DBM:GetModLocalization("HyjalWaveTimers")

L:SetGeneralLocalization{
	name 		= "일반몹 구간"
}

L:SetTimerLocalization{
	TimerWave	= "다음 공격"
}

L:SetOptionLocalization{
	WarnWave		= "다음 공격시 경고 보기",
	DetailedWave	= "다음 공격의 상세 내역 경고 보기 (몹 구성)",
	TimerWave		= "다음 공격 타이머 바 보기"
}

L:SetMiscLocalization{
	HyjalZoneName	= "하이잘 정상",
	Thrall			= "스랄",
	Jaina			= "제이나 프라우드무어",
	GeneralBoss		= "우두머리 등장",
	RageWinterchill	= "격노한 윈터칠 등장",
	Anetheron		= "아네테론 등장",
	Kazrogal		= "카즈로갈 등장",
	Azgalor			= "아즈갈로 등장",
	WarnWave_0		= "공격 %s/8",
	WarnWave_1		= "공격 %s/8 - %s %s",
	WarnWave_2		= "공격 %s/8 - %s %s, %s %s",
	WarnWave_3		= "공격 %s/8 - %s %s, %s %s, %s %s",
	WarnWave_4		= "공격 %s/8 - %s %s, %s %s, %s %s, %s %s",
	WarnWave_5		= "공격 %s/8 - %s %s, %s %s, %s %s, %s %s, %s %s",
	RageGossip		= "제 동료와 저는 프라우드무어 님, 당신과 함께하겠습니다.",
	AnetheronGossip	= "아키몬드가 어떤 군대를 보내던 우리는 준비가 되어 있습니다, 프라우드무어 님.",
	KazrogalGossip	= "당신과 함께하겠습니다, 대족장님.",
	AzgalorGossip	= "두려워할 것은 아무것도 없습니다.",
	Ghoul			= "구울",
	Abomination		= "누더기골렘",
	Necromancer		= "강령술사",
	Banshee			= "밴시",
	Fiend			= "지하마귀",
	Gargoyle		= "가고일",
	Wyrm			= "서리고룡",
	Stalker			= "지옥사냥개",
	Infernal		= "지옥불정령"
}
