begin
  class PBEffects
    # These effects apply to a battler
    AquaRing          = 0
    Attract           = 1
    Bide              = 2
    BideDamage        = 3
    BideTarget        = 4
    Charge            = 5
    ChoiceBand        = 6
    Confusion         = 7
    Counter           = 8
    CounterTarget     = 9
    Curse             = 10
    DefenseCurl       = 11
    DestinyBond       = 12
    Disable           = 13
    DisableMove       = 14
    EchoedVoice       = 15
    Embargo           = 16
    Encore            = 17
    EncoreIndex       = 18
    EncoreMove        = 19
    Endure            = 20
    FlashFire         = 21
    Flinch            = 22
    FocusEnergy       = 23
    FollowMe          = 24
    Foresight         = 25
    FuryCutter        = 26
    FutureSight       = 27
    FutureSightDamage = 28
    FutureSightMove   = 29
    FutureSightUser   = 30
    GastroAcid        = 31
    Grudge            = 32
    HealBlock         = 33
    HealingWish       = 34
    HelpingHand       = 35
    HyperBeam         = 36
    Imprison          = 37
    Ingrain           = 38
    LeechSeed         = 39
    LockOn            = 40
    LockOnPos         = 41
    LunarDance        = 42
    MagicCoat         = 43
    MagnetRise        = 44
    MeanLook          = 45
    Metronome         = 46
    Minimize          = 47
    MiracleEye        = 48
    MirrorCoat        = 49
    MirrorCoatTarget  = 50
#    MudSport          = 51
    MultiTurn         = 52 # Trapping move
    MultiTurnAttack   = 53
    MultiTurnUser     = 54
    Nightmare         = 55
    Outrage           = 56
    PerishSong        = 57
    PerishSongUser    = 58
    Pinch             = 59 # Battle Palace only
    PowerTrick        = 60
    Protect           = 61
    ProtectNegation   = 62
    ProtectRate       = 63
    Pursuit           = 64
    Rage              = 65
    Revenge           = 66
    Rollout           = 67
    Roost             = 68
    SkyDrop           = 69
    SmackDown         = 70
    Snatch            = 71
    Stockpile         = 72
    StockpileDef      = 73
    StockpileSpDef    = 74
    Substitute        = 75
    Taunt             = 76
    Telekinesis       = 77
    Torment           = 78
    Toxic             = 79
    Trace             = 80
    Transform         = 81
    Truant            = 82
    TwoTurnAttack     = 83
    Uproar            = 84
#    WaterSport        = 85
    WeightMultiplier  = 86
    Wish              = 87
    WishAmount        = 88
    WishMaker         = 89
    Yawn              = 90  
#### JERICHO - 001 - START    
    Illusion          = 91 #Illusion
#### JERICHO - 001 - END    
    StickyWeb         = 101
    KingsShield       = 102
    SpikyShield       = 103
    Illusion          = 106
    FairyLockRate     = 107
#### KUROTSUNE - 004 - START
    ParentalBond      = 108
#### KUROTSUNE - 004 - END
#### KUROTSUNE - 010 - START
    Round             = 109
#### KUROTSUNE - 010 - END
#### KUROTSUNE - 023 - START
    Powder            = 110
#### KUROTSUNE - 023 - END
#### KUROTSUNE - 024 - START
    Electrify         = 111
#### KUROTSUNE - 024 - END
#### KUROTSUNE - 032 - START
    MeFirst           = 112
#### KUROTSUNE - 032 - END
    WideGuardCheck    = 113
    WideGuardUser     = 114  
    RagePowder        = 115
    MagicBounced      = 116
    TracedAbility     = 117
    UsingSubstituteRightNow = 118
    SkyDroppee         = 119
    DestinyRate        = 120
    BanefulBunker      = 121
    BeakBlast          = 122
    BurnUp             = 123
    ClangedScales      = 124
    LaserFocus         = 125
    ShellTrap          = 126
    SpeedSwap          = 127
    Tantrum            = 128
    ThroatChop         = 129
    Disguise           = 130
    ZHeal              = 131
    Blazed             = 132
    Savagery           = 133
    # These effects apply to a side
    LightScreen = 0
    LuckyChant  = 1
    Mist        = 2
    Reflect     = 3
    Safeguard   = 4
    Spikes      = 5
    StealthRock = 6
    Tailwind    = 7
    ToxicSpikes = 8
    WideGuard   = 9
    QuickGuard  = 10
#### KUROTSUNE - 009 - START
    Retaliate   = 11
#### KUROTSUNE - 009 - END
#### KUROTSUNE - 016 - START
    CraftyShield = 12
#### KUROTSUNE - 025 - START
    MatBlock     = 13
#### KUROTSUNE - 025 - END
    AuroraVeil   = 14
    # These effects apply to the battle (i.e. both sides) 
    Gravity    = 0
    MagicRoom  = 1
    #TrickRoom  = 2
    WonderRoom = 3
    Terrain    = 4
    FairyLock  = 5
#### KUROTSUNE - 013 - START    
    IonDeluge  = 6
#### KUROTSUNE - 013 - END
#### KUROTSUNE - 001 - START
    # Additional weather effects
    HarshSunlight = 7
    HeavyRain     = 8
#### KUROTSUNE - 001 - END    
    MudSport   = 9
    WaterSport = 10

    # These effects apply to the usage of a move
    SpecialUsage = 0
    PassedTrying = 1
    TotalDamage  = 2
  end
rescue Exception
  if $!.is_a?(SystemExit) || "#{$!.class}"=="Reset"
    raise $!
  end
end