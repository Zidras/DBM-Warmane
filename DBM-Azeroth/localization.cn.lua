if GetLocale() ~= "zhCN" then return end
local L
--Last update: 2020/07/03 （重新整理）
-- Azuregos (Azshara)
L = DBM:GetModLocalization("Azuregos")

L:SetGeneralLocalization({
	name = "艾索雷葛斯"
})

L:SetMiscLocalization({
	Pull		= "我保护着这个地方。神秘的秘法不能受到亵渎。"
})

-- Taerar (Ashenvale)
L = DBM:GetModLocalization("Taerar")

L:SetGeneralLocalization({
	name = "泰拉尔"
})

L:SetMiscLocalization({
	Pull		= "和平不过是短暂的梦想!让梦魇统治整个世界吧！"
})

-- Ysondre (Feralas)
L = DBM:GetModLocalization("Ysondre")

L:SetGeneralLocalization({
	name = "伊森德雷"
})

L:SetMiscLocalization({
	Pull		= "生命的希冀已被切断!梦游者要展开报复！"
})

-- Lethon (Hinterlands)
L = DBM:GetModLocalization("Lethon")

L:SetGeneralLocalization({
	name = "莱索恩"
})

L:SetMiscLocalization({
	Pull		= "我能感受到你内心的阴影。邪恶的侵蚀永远不会停止！"
})

-- Emeriss (Duskwood)
L = DBM:GetModLocalization("Emeriss")

L:SetGeneralLocalization({
	name = "艾莫莉丝"
})

L:SetMiscLocalization({
	Pull		= "希望是灵魂染上的疾病!这片土地应该枯竭，从此死气腾腾！"
})
