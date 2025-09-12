local L

-- Magtheridon
L = DBM:GetModLocalization("Magtheridon")

L:SetGeneralLocalization({
	name = "Magtheridon"
})

L:SetOptionLocalization({
	timerP2	= "Montre le timer pour le début de la phase 2"
})

L:SetMiscLocalization({
	DBM_MAG_EMOTE_PULL		= "Les liens de %s commencent à se relâcher !",
	DBM_MAG_YELL_PHASE2		= "Me... voilà... déchaîné !",
	DBM_MAG_ALTERNATIVE_YELL_PHASE2 = "Thank you for releasing me. Now... die!", -- doesn't seem to exist in way of elendil , can't find it in any database too.
	DBM_MAG_YELL_PHASE3		= "Je ne me laisserai pas prendre si facilement ! Que les murs de cette prison tremblent... Et s'effondrent !"
})
