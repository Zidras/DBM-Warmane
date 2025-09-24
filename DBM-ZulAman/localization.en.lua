local L

---------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk")

L:SetGeneralLocalization({
	name = "Nalorakk"
})

L:SetWarningLocalization({
	WarnBear		= "Bear Form",
	WarnBearSoon	= "Bear Form in 5 sec",
	WarnNormal		= "Normal Form",
	WarnNormalSoon	= "Normal Form in 5 sec"
})

L:SetTimerLocalization({
	TimerBear		= "Bear Form",
	TimerNormal		= "Normal Form"
})

L:SetOptionLocalization({
	WarnBear		= "Show warning for Bear form",
	WarnBearSoon	= "Show pre-warning for Bear form",
	WarnNormal		= "Show warning for Normal form",
	WarnNormalSoon	= "Show pre-warning for Normal form",
	TimerBear		= "Show timer for Bear form",
	TimerNormal		= "Show timer for Normal form"
})

L:SetMiscLocalization({
	YellPull	= "Get da move on, guards! It be killin' time!",
	YellBear	= "You call on da beast, you gonna get more dan you bargain for!",
	YellNormal	= "Make way for Nalorakk!"
})

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon")

L:SetGeneralLocalization({
	name = "Akil'zon"
})

L:SetMiscLocalization({
	YellPull	= "I be da predator! You da prey...",
})

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai")

L:SetGeneralLocalization({
	name = "Jan'alai"
})

L:SetMiscLocalization({
	YellPull	= "Spirits of da wind be your doom!",
	YellBomb	= "I burn ya now!",
	YellAdds	= "Where ma hatcha? Get to work on dem eggs!"
})

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi")

L:SetGeneralLocalization({
	name = "Halazzi"
})

L:SetWarningLocalization({
	WarnSpirit	= "Spirit Phase",
	WarnNormal	= "Normal Phase"
})

L:SetOptionLocalization({
	WarnSpirit	= "Show warning for Spirit phase",
	WarnNormal	= "Show warning for Normal phase"
})

L:SetMiscLocalization({
	YellPull	= "Get on ya knees and bow.... to da fang and claw!",
	YellSpirit	= "I fight wit' untamed spirit....",
	YellNormal	= "Spirit, come back to me!"
})

--------------------------
--  Hex Lord Malacrass --
--------------------------
L = DBM:GetModLocalization("Malacrass")

L:SetGeneralLocalization({
	name = "Hex Lord Malacrass"
})

L:SetMiscLocalization({
	YellPull	= "Da shadow gonna fall on you...."
})

--------------
--  Zul'jin --
--------------
L = DBM:GetModLocalization("ZulJin")

L:SetGeneralLocalization({
	name = "Zul'jin"
})

L:SetMiscLocalization({
	YellPull	= "Nobody badduh dan me!",
	YellPhase2	= "Got me some new tricks... like me brudda bear....",
	YellPhase3	= "Dere be no hidin' from da eagle!",
	YellPhase4	= "Let me introduce you to me new bruddas: fang and claw!",
	YellPhase5	= "Ya don' have to look to da sky to see da dragonhawk!"
})
