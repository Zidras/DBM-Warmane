if GetLocale() ~= "zhCN" then return end
local L
-----------------------
--  Flame Leviathan  --
-----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
    name = "Flame Leviathan"
}

L:SetTimerLocalization{}

L:SetMiscLocalization{
    YellPull = "检测到敌对实体。威胁评定协议启动。向主要目标发动攻击。30秒后重新评估。",
    YellPull2 = "Orbital countermeasures enabled.",
    Emote = "%%s开始追赶(%S+)%。"
}

L:SetWarningLocalization{
    PursueWarn = "Pursuing >%s<",
    warnNextPursueSoon = "Target change in 5 seconds",
    SpecialPursueWarnYou = "You are being pursued - Run away",
    warnWardofLife = "Ward of Life spawned"
}

L:SetOptionLocalization{
    SpecialPursueWarnYou = "Show special warning when you are being $spell:62374",
    PursueWarn = "Announce $spell:62374 targets",
    warnNextPursueSoon = "Show pre-warning for next $spell:62374",
    warnWardofLife = "Show special warning for Ward of Life spawn"
}

--------------------------------
--  Ignis the Furnace Master  --
--------------------------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
    name = "Ignis the Furnace Master"
}

L:SetTimerLocalization{}
L:SetWarningLocalization{}

L:SetOptionLocalization{
    SlagPotIcon = DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(63477)
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
    name = "Razorscale"
}

L:SetWarningLocalization{
    warnTurretsReadySoon = "Last turret ready in 20 seconds",
    warnTurretsReady = "Last turret ready",
    SpecWarnDevouringFlameCast = "Devouring Flame on you",
    WarnDevouringFlameCast = "Devouring Flame on >%s<"
}

L:SetTimerLocalization{
    timerTurret1 = "Turret 1",
    timerTurret2 = "Turret 2",
    timerTurret3 = "Turret 3",
    timerTurret4 = "Turret 4",
    timerGrounded = "On the ground"
}

L:SetOptionLocalization{
    PlaySoundOnDevouringFlame = "Play sound when you are affected by $spell:64733",
    warnTurretsReadySoon = "Show pre-warning for turrets",
    warnTurretsReady = "Show warning for turrets",
    SpecWarnDevouringFlameCast = "Show special warning when $spell:64733 is cast on you",
    timerTurret1 = "Show timer for turret 1",
    timerTurret2 = "Show timer for turret 2",
    timerTurret3 = "Show timer for turret 3 (25 player)",
    timerTurret4 = "Show timer for turret 4 (25 player)",
    OptionDevouringFlame = "Announce $spell:64733 targets (unreliable)",
    timerGrounded = "Show timer for ground phase duration"
}

L:SetMiscLocalization{
    YellAir = "给我们一点时间，做好建筑炮台的准备。",
    YellAir2 = "火灭了！准备重建炮台！",
    YellGround = "快一点！她马上就要挣脱了！",
    EmotePhase2 = "%%s被永久地禁锢在地面上！",
    FlamecastUnknown = DBM_CORE_L.UNKNOWN
}

----------------------------
--  XT-002 Deconstructor  --
----------------------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
    name = "XT-002 Deconstructor"
}

L:SetTimerLocalization{}

L:SetWarningLocalization{
    WarningTTIn10Sec = "Tympanic Tantrum in 10 sec."
}

L:SetOptionLocalization{
    SetIconOnLightBombTarget = DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(65121),
    SetIconOnGravityBombTarget = DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(64234),
    WarningTympanicTantrumIn10Sec = "Show special pre-warning (10 sec.) for $spell:62776 "
}

--------------------
--  Iron Council  --
--------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
    name = "Iron Council"
}

L:SetWarningLocalization{
    WarningRuneofDeathIn10Sec = "RoD in ~10 sec."
}

L:SetTimerLocalization{}

L:SetOptionLocalization{
    PlaySoundLightningTendrils = "Play sound on $spell:63486",
    SetIconOnOverwhelmingPower = DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(61888),
    SetIconOnStaticDisruption = DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(61912),
    AlwaysWarnOnOverload = "Always warn on $spell:63481 (otherwise, only when targeted)",
    PlaySoundOnOverload = "Play sound on $spell:63481",
    PlaySoundDeathRune = "Play sound on $spell:63490"
}

L:SetMiscLocalization{
    Steelbreaker = "断钢者",
    RunemasterMolgeim = "符文大师莫尔基姆",
    StormcallerBrundir = "唤雷者布隆迪尔",
    YellPull1 = "Whether the world's greatest gnats or the world's greatest heroes, you're still only mortal!",
    YellPull2 = "Nothing short of total decimation will suffice.",
    YellPull3 = "You will not defeat the Assembly of Iron so easily, invaders!",
    YellRuneOfDeath = "Decipher this!",
    YellRunemasterMolgeimDied = "What have you gained from my defeat? You are no less doomed, mortals!",
    YellRunemasterMolgeimDied2 = "The legacy of storms shall not be undone.",
    YellStormcallerBrundirDied = "The power of the storm lives on...",
    YellStormcallerBrundirDied2 = "You rush headlong into the maw of madness!",
    YellSteelbreakerDied = "My death only serves to hasten your demise.",
    YellSteelbreakerDied2 = "Impossible!"
}

----------------------------
--  Algalon the Observer  --
----------------------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
    name = "Algalon the Observer"
}

L:SetTimerLocalization{
    NextCollapsingStar = "Next Collapsing Star",
    NextCosmicSmash = "Next Cosmic Smash",
    TimerCombatStart = "Combat starts"
}

L:SetWarningLocalization{
    WarningPhasePunch = "Phase Punch on >%s< - Stack %d",
    WarningCosmicSmash = "Cosmic Smash - Explosion in 4 seconds",
    WarnPhase2Soon = "Phase 2 soon",
    warnStarLow = "Collapsing Star is low"
}

L:SetOptionLocalization{
    WarningPhasePunch = "Announce Phase Punch targets",
    NextCollapsingStar = "Show timer for next Collapsing Star",
    WarningCosmicSmash = "Show warning for Cosmic Smash",
    NextCosmicSmash = "Show timer for next Cosmic Smash",
    TimerCombatStart = "Show timer for start of combat",
    WarnPhase2Soon = "Show pre-warning for Phase 2 (at ~23%)",
    warnStarLow = "Show special warning when Collapsing Star is low (at ~25%)"
}

L:SetMiscLocalization{
    YellPull = "See your world through my eyes: A universe so vast as to be immeasurable - incomprehensible even to your greatest minds.",
    YellPull2 = "你们的行动不合逻辑。这场战斗所有可能产生的结果都已被计算在内。无论结果如何，万神殿都会收到观察者发出的信息。",
    YellKill = "我曾经看过尘世沉浸在造物者的烈焰之中，众生连一声悲泣都无法呼出，就此凋零。整个星系在弹指之间历经了毁灭与重生。然而在这段历程之中，我的心却无法感受到丝毫的…恻隐之念。我‧感‧受‧不‧到。成千上万的生命就这么消逝。他们是否拥有与你同样坚韧的生命?他们是否与你同样热爱生命?",
    Emote_CollapsingStar = "%s开始召唤坍缩星！",
    Phase2 = "瞧瞧泰坦造物的能耐吧!",
    CollapsingStar = "Collapsing Star",
    PullCheck = "奥尔加隆发送危险信号的倒计时 = (%d+)分钟。"
}

----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
    name = "Kologarn"
}

L:SetWarningLocalization{}

L:SetTimerLocalization{
    timerLeftArm = "Left Arm respawn",
    timerRightArm = "Right Arm respawn",
    achievementDisarmed = "Timer for Disarm"
}

L:SetOptionLocalization{
    timerLeftArm = "Show timer for Left Arm respawn",
    timerRightArm = "Show timer for Right Arm respawn",
    achievementDisarmed = "Show timer for Disarm achievement",
    SetIconOnGripTarget = DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(64292),
    SetIconOnEyebeamTarget = DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(63346),
    PlaySoundOnEyebeam = "Play sound on $spell:63346",
    YellOnBeam = "Yell on $spell:63346"
}

L:SetMiscLocalization{
    Yell_Trigger_arm_left = "不疼不痒！",
    Yell_Trigger_arm_right = "只是轻伤而已！",
    YellEncounterStart = "None shall pass!",
    YellLeftArmDies = "Just a scratch!",
    YellRightArmDies = "Only a flesh wound!",
    Health_Body = "科隆加恩身体",
    Health_Right_Arm = "右臂",
    Health_Left_Arm = "左臂",
    FocusedEyebeam = "在注视着你",
    YellBeam = "科隆加恩正在注视我！"
}

---------------
--  Auriaya  --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
    name = "Auriaya"
}

L:SetMiscLocalization{
    Defender = "野性防御者 (%d)",
    YellPull = "有些东西，最好永远都不去碰！"
}

L:SetTimerLocalization{
    timerDefender = "Feral Defender activates"
}

L:SetWarningLocalization{
    SpecWarnBlast = "Sentinel Blast - Interrupt now",
    WarnCatDied = "Feral Defender down (%d lives remaining)",
    WarnCatDiedOne = "Feral Defender down (1 life remaining)",
}

L:SetOptionLocalization{
    SpecWarnBlast = "Show special warning for Sentinel Blast (to interrupt)",
    WarnCatDied = "Show warning when Feral Defender dies",
    WarnCatDiedOne = "Show warning when Feral Defender has 1 life remaining",
    timerDefender = "Show timer for when Feral Defender is activated"
}

-------------
--  Hodir  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
    name = "Hodir"
}

L:SetWarningLocalization{}
L:SetTimerLocalization{}

L:SetOptionLocalization{
    PlaySoundOnFlashFreeze = "Play sound on $spell:61968 cast",
    YellOnStormCloud = "Yell on $spell:65133",
    SetIconOnStormCloud = "Set icons on $spell:65133 targets"
}

L:SetMiscLocalization{
    YellKill = "我……我终于从他的魔掌中……解脱了。",
    YellCloud = "我中了风暴雷云 快接近我！"
}

--------------
--  Thorim  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
    name = "Thorim"
}

L:SetWarningLocalization{}

L:SetTimerLocalization{
    TimerHardmodeThorim = "Sif's Presence",
}

L:SetOptionLocalization{
    TimerHardmode = "Show timer for hard mode",
    RangeFrame = "Show range frame",
    AnnounceFails = "Post player fails for $spell:62017 to raid chat\n(requires announce to be enabled and leader/promoted status)"
}

L:SetMiscLocalization{
    YellPhase1 = "入侵者！你们这些凡人竟敢坏了我的兴致，看我怎么……等等，你们……",
    YellPhase2 = "狂妄的小崽子们，竟敢在我的地盘上挑战我？我要亲自碾碎你们！",
    YellKill = "住手！我认输了！",
    ChargeOn = "闪电充能: %s",
    Charge = "中了闪电充能(这一次): %s"
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
    name = "Freya"
}

L:SetMiscLocalization{
    SpawnYell = "孩子们，帮帮我！",
    WaterSpirit = "古代水之精魂",
    Snaplasher = "迅疾鞭笞者",
    StormLasher = "风暴鞭笞者",
    YellKill = "他对我的控制已经不复存在了。我又一次恢复了理智。谢谢你们，英雄们。",
    YellAdds1 = "Eonar, your servant requires aid!",
    YellAdds2 = "The swarm of the elements shall overtake you!",
    EmoteLGift = "开始生长！",
    TrashRespawnTimer = "弗蕾亚的小怪重生"
}

L:SetWarningLocalization{
    WarnSimulKill = "First add down - Resurrection in ~12 seconds",
    WarningBeamsSoon = "Beams soon",
    EonarsGift = "Target Change - switch to Eonar's Gift"
}

L:SetTimerLocalization{
    TimerSimulKill = "Resurrection"
}

L:SetOptionLocalization{
    WarnSimulKill = "Announce first mob down",
    PlaySoundOnFury = "Play sound when you are affected by $spell:63571",
    WarnBeamsSoon = "Show a warning for $spell:62865 is soon",
    TimerSimulKill = "Show timer for mob resurrection"
}

----------------------
--  Freya's Elders  --
----------------------
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
    name = "Freya's Elders"
}

L:SetMiscLocalization{
    TrashRespawnTimer = "弗蕾亚的小怪重生"
}

L:SetWarningLocalization{}

L:SetOptionLocalization{
    PlaySoundOnFistOfStone = "Play sound on Fists of Stone",
    TrashRespawnTimer = "Show timer for trash respawn"
}

---------------
--  Mimiron  --
---------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
    name = "Mimiron"
}

L:SetWarningLocalization{
    MagneticCore = ">%s< has Magnetic Core",
    WarningShockBlast = "Shock Blast - Run away",
    WarnBombSpawn = "Bomb Bot spawned",
    WarningFlamesIn5Sec = "Flames in 5 sec."
}

L:SetTimerLocalization{
    TimerHardmode = "Hard mode - Self-destruct",
    TimeToPhase2 = "Phase 2",
    TimeToPhase3 = "Phase 3",
    TimeToPhase4 = "Phase 4"
}

L:SetOptionLocalization{
    TimeToPhase2 = "Show timer for Phase 2",
    TimeToPhase3 = "Show timer for Phase 3",
    TimeToPhase4 = "Show timer for Phase 4",
    MagneticCore = "Announce Magnetic Core looters",
    HealthFramePhase4 = "Show health frame in Phase 4",
    AutoChangeLootToFFA = "Switch loot mode to Free for All in Phase 3",
    WarnBombSpawn = "Show warning for Bomb Bots",
    TimerHardmode = "Show timer for hard mode",
    PlaySoundOnShockBlast = "Play sound on $spell:63631",
    PlaySoundOnDarkGlare = "Play sound on $spell:63414",
    ShockBlastWarningInP1 = "Show special warning for $spell:63631 in Phase 1",
    ShockBlastWarningInP4 = "Show special warning for $spell:63631 in Phase 4",
    RangeFrame = "Show range frame in Phase 1 (6 yards)",
    SetIconOnNapalm = DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(65026),
    SetIconOnPlasmaBlast = DBM_CORE_L.AUTO_ICONS_OPTION_TEXT:format(62997),
    WarnFlamesIn5Sec = "Show special warning: Flames in 5 sec.",
    SoundWarnCountingFlames = "Play a 5 second audio countdown for next flames"
}

L:SetMiscLocalization{
    MobPhase1 = "巨兽二型",
    MobPhase2 = "VX-001",
    MobPhase3 = "空中指挥单位",
    YellPull = "我们时间不多了，朋友们！来帮忙测试一下我所发明的最新型、最强大的机体吧。在你们改变主意之前，请允许我提醒一下，你们把XT-002搞得一团糟，应该算是欠我个人情吧。",
    YellHardPull = "嘿，你们为什么要这么做啊？没看到上面写着“不要按这个按钮”吗？你们激活了自毁系统，还怎么完成测试呀？",
    YellPhase2 = "太棒了！测试结果非常好！外壳完整率百分之九十八点九！几乎没有划伤！继续。",
    YellPhase3 = "非常感谢，朋友们！你们的帮助使我获得了一些极其珍贵的数据！下面，我要让你们——咦，我把它放哪去了？哦！这里。",
    YellPhase4 = "初步测试阶段完成。真正的测试开始啦！",
    YellKilled = "It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison. overriding my primary directive. All systems seem to be functional now. Clear.",
    LootMsg = "(.+)获得了物品：.*Hitem:(%d+)"
}

---------------------
--  General Vezax  --
---------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
    name = "General Vezax"
}

L:SetTimerLocalization{
    hardmodeSpawn = "Saronite Animus spawn"
}

L:SetWarningLocalization{
    SpecialWarningShadowCrash = "Shadow Crash on you - Move away",
    SpecialWarningShadowCrashNear = "Shadow Crash near you - Watch out",
    SpecialWarningLLNear = "Mark of the Faceless on %s near you"
}

L:SetOptionLocalization{
    SetIconOnShadowCrash = "Set icons on $spell:62660 targets (skull)",
    SetIconOnLifeLeach = "Set icons on $spell:63276 targets (cross)",
    SpecialWarningShadowCrash = "Show special warning for $spell:62660\n(must be targeted or focused by at least one raid member)",
    SpecialWarningShadowCrashNear = "Show special warning for $spell:62660 near you",
    SpecialWarningLLNear = "Show special warning for $spell:63276 near you",
    YellOnLifeLeech = "Yell on $spell:63276",
    YellOnShadowCrash = "Yell on $spell:62660",
    hardmodeSpawn = "Show timer for Saronite Animus spawn (hard mode)",
    CrashArrow = "Show DBM arrow when $spell:62660 is near you",
    BypassLatencyCheck = "Don't use latency based sync check for $spell:62660\n(only use this if you're having problems otherwise)"
}

L:SetMiscLocalization{
    EmoteSaroniteVapors = "一团萨隆邪铁蒸汽在附近聚集起来！",
    YellLeech = "我中了无面者的印记 - 远离我",
    YellCrash = "我中了暗影冲撞 - 远离我"
}

------------------
--  Yogg-Saron  --
------------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
    name = "Yogg-Saron"
}

L:SetMiscLocalization{
    YellPull = "攻击这头野兽要害的时刻即将来临！将你们的愤怒和仇恨倾泻到它的爪牙身上！",
    YellPhase2 = "我是清醒的梦境。",
    Sara = "萨拉",
    WarningYellSqueeze = "我被触须抓住了 - 快救我"
}

L:SetWarningLocalization{
    WarningGuardianSpawned = "Guardian %d spawned",
    WarningCrusherTentacleSpawned = "Crusher Tentacle spawned",
    WarningSanity = "%d Sanity remaining",
    SpecWarnSanity = "%d Sanity remaining",
    SpecWarnGuardianLow = "Stop attacking this Guardian",
    SpecWarnMadnessOutNow = "Induce Madness ending - Move out",
    WarnBrainPortalSoon = "Brain Portal in 3 seconds",
    SpecWarnFervor = "Sara's Fervor on you",
    SpecWarnFervorCast = "Sara's Fervor is being cast on you",
    SpecWarnMaladyNear = "Malady of the Mind on %s near you",
    specWarnBrainPortalSoon = "Brain Portal soon"
}

L:SetTimerLocalization{
    NextPortal = "Brain Portal"
}

L:SetOptionLocalization{
    WarningGuardianSpawned = "Show warning for Guardian spawns",
    WarningCrusherTentacleSpawned = "Show warning for Crusher Tentacle spawns",
    WarningSanity = "Show warning when $spell:63050 is low",
    SpecWarnSanity = "Show special warning when $spell:63050 is very low",
    SpecWarnGuardianLow = "Show special warning when Guardian (Phase 1) is low (for DDs)",
    WarnBrainPortalSoon = "Show pre-warning for Brain Portal",
    SpecWarnMadnessOutNow = "Show special warning shortly before $spell:64059 ends",
    SetIconOnFearTarget = "Set icons on $spell:63881 targets",
    SpecWarnFervorCast = "Show special warning when $spell:63138 is being cast on you (must be targeted or focused by at least one raid member)",
    specWarnBrainPortalSoon = "Show special warning for next Brain Portal",
    WarningSqueeze = "Yell on Squeeze",
    NextPortal = "Show timer for next Brain Portal",
    SetIconOnFervorTarget = "Set icons on $spell:63138 targets",
    ShowSaraHealth = "Show health frame for Sara in Phase 1 (must be targeted or focused by at least one raid member)",
    SpecWarnMaladyNear = "Show special warning for $spell:63881 near you",
    SetIconOnBrainLinkTarget = "Set icons on $spell:63802 targets",
    MaladyArrow = "Show DBM arrow when $spell:63881 is near you"
}