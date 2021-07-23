if GetLocale() ~= "koKR" then
	return
end
local L = DBM_SpellsUsed_Translations

L.TabCategory_SpellsUsed	= "주문/스킬 쿨다운"
L.AreaGeneral 				= "주문/스킬 쿨다운 기본 설정"
L.Enabled 					= "쿨다운 타이머 사용"
L.ShowLocalMessage	 		= "시전 메세지 보기"
L.OnlyFromRaid				= "공격대 멤버 쿨다운만 보기"
L.EnableInPVP				= "전장 공격대원 쿨다운 보기"
L.EnablePortals				= "마법사 포탈 지속 시간 보기"
L.Reset						= "기본값 복원"
L.Local_CastMessage 		= "주문 시전 감지 : %s"
L.AreaAuras 				= "주문/스킬 등록"
L.SpellID 					= "Spell ID"
L.BarText 					= "바 글자 (기본 : 주문이름: %player)"
L.Cooldown 					= "쿨다운"
L.Error_FillUp				= "새로운 목록을 추가하려면 모든 항목을 입력 하셔야 합니다."
