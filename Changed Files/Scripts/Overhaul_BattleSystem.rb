$field_effects_highlights = 0

# Status Mods per field id (based on Field_Effect_Manual)
$fieldEffectStatusMoves = {
    1 => [PBMoves::CHARGE,PBMoves::EERIEIMPULSE,PBMoves::MAGNETRISE,], #Electric Field
    2 => [PBMoves::COIL,PBMoves::GROWTH,PBMoves::GRASSWHISTLE], #Grassy Terrain
    3 => [PBMoves::COSMICPOWER,PBMoves::AROMATICMIST,PBMoves::SWEETSCENT,PBMoves::WISH,PBMoves::AQUARING], #Misty Terrain
    4 => [PBMoves::FLASH,PBMoves::DARKVOID,PBMoves::MOONLIGHT,PBMoves::AURORAVEIL], #Dark Crystal Cavern
    5 => [PBMoves::CALMMIND,PBMoves::NASTYPLOT,PBMoves::TRICKROOM], #Chess Board
    6 => [PBMoves::ENCORE,PBMoves::DRAGONDANCE,PBMoves::QUIVERDANCE,PBMoves::SWORDSDANCE,PBMoves::FEATHERDANCE,PBMoves::SING,PBMoves::RAINDANCE,PBMoves::BELLYDRUM,PBMoves::SPOTLIGHT], #Big Top Arena
    7 => [PBMoves::WILLOWISP,PBMoves::SMOKESCREEN], #Volcanic Field
    8 => [PBMoves::SLEEPPOWDER,PBMoves::AQUARING,PBMoves::STRENGTHSAP], #Swamp Field
    9 => [PBMoves::MEDITATE,PBMoves::COSMICPOWER,PBMoves::WISH,PBMoves::AURORAVEIL], #Rainbow Field
    10 => [PBMoves::ACIDARMOR,PBMoves::SLEEPPOWDER,PBMoves::POISONPOWDER,PBMoves::STUNSPORE,PBMoves::TOXIC,PBMoves::VENOMDRENCH], #Corrosive Field
    11 => [PBMoves::ACIDARMOR,PBMoves::SMOKESCREEN,PBMoves::VENOMDRENCH,PBMoves::TOXIC], #Corrosive Mist Field
    12 => [PBMoves::SANDSTORM,PBMoves::SUNNYDAY,PBMoves::SANDATTACK,PBMoves::SHOREUP], #Desert Field
    13 => [PBMoves::HAIL,PBMoves::AURORAVEIL], #Icy Field
    14 => [PBMoves::ROCKPOLISH,PBMoves::STEALTHROCK], #Rocky Field
    15 => [PBMoves::STICKYWEB,PBMoves::GROWTH,PBMoves::DEFENDORDER,PBMoves::STRENGTHSAP,PBMoves::HEALORDER,PBMoves::NATURESMADNESS,PBMoves::FORESTSCURSE], #Forest Field
    16 => [PBMoves::TAILWIND,PBMoves::SMOKESCREEN,PBMoves::POISONGAS], #Volcanic Top Field
    17 => [PBMoves::METALSOUND,PBMoves::IRONDEFENSE,PBMoves::SHIFTGEAR,PBMoves::AUTOTOMIZE,PBMoves::MAGNETRISE,PBMoves::GEARUP], #Factory Field
    18 => [PBMoves::METALSOUND,PBMoves::FLASH,PBMoves::MAGNETRISE], #Short-circuit Field
    19 => [PBMoves::SWALLOW,PBMoves::STEALTHROCK,PBMoves::SPIKES,PBMoves::TOXICSPIKES,PBMoves::STICKYWEB], #Wasteland
    20 => [PBMoves::CALMMIND,PBMoves::SANDATTACK,PBMoves::KINESIS,PBMoves::MEDITATE,PBMoves::SANDSTORM,PBMoves::PSYCHUP,PBMoves::FOCUSENERGY,PBMoves::SHOREUP], #Ashen Beach
    21 => [PBMoves::SPLASH,PBMoves::AQUARING], #Water Surface
    22 => [PBMoves::AQUARING], #Underwater
    23 => [PBMoves::STEALTHROCK], #Cave
    24 => [PBMoves::METRONOME], #Glitch Field
    25 => [PBMoves::ROCKPOLISH,PBMoves::STEALTHROCK,PBMoves::AURORAVEIL], #Crystal Cavern
    26 => [PBMoves::ACIDARMOR,PBMoves::VENOMDRENCH], #Murkwater Surface
    27 => [PBMoves::TAILWIND,PBMoves::SUNNYDAY], #Mountain
    28 => [PBMoves::TAILWIND,PBMoves::SUNNYDAY,PBMoves::HAIL], #Snowy Mountain
    29 => [PBMoves::WISH,PBMoves::MIRACLEEYE,PBMoves::COSMICPOWER,PBMoves::NATURESMADNESS], #Holy Field
    30 => [PBMoves::FLASH,PBMoves::DOUBLETEAM,PBMoves::LIGHTSCREEN,PBMoves::AURORAVEIL,PBMoves::REFLECT,PBMoves::MIRRORMOVE,PBMoves::MIRRORCOAT], #Mirror Arena
    31 => [PBMoves::KINGSSHIELD,PBMoves::CRAFTYSHIELD,PBMoves::FLOWERSHIELD,PBMoves::ACIDARMOR,PBMoves::SWORDSDANCE,PBMoves::NOBLEROAR,PBMoves::WISH,PBMoves::HEALINGWISH,PBMoves::MIRACLEEYE,PBMoves::FORESTSCURSE,PBMoves::FLORALHEALING], #Fairy Tale Field
    32 => [PBMoves::NOBLEROAR,PBMoves::DRAGONDANCE], #Dragon's Den
    "33_0" => [PBMoves::GROWTH,PBMoves::ROTOTILLER,PBMoves::RAINDANCE,PBMoves::WATERSPORT,PBMoves::SUNNYDAY,PBMoves::FLOWERSHIELD], #Flower Garden Field (Stage 1)
    "33_1" => [PBMoves::GROWTH,PBMoves::ROTOTILLER,PBMoves::RAINDANCE,PBMoves::WATERSPORT,PBMoves::SUNNYDAY,PBMoves::FLOWERSHIELD,PBMoves::INGRAIN], #Flower Garden Field (Stage 2)
    "33_2" => [PBMoves::GROWTH,PBMoves::ROTOTILLER,PBMoves::RAINDANCE,PBMoves::WATERSPORT,PBMoves::SUNNYDAY,PBMoves::FLOWERSHIELD,PBMoves::SWEETSCENT], #Flower Garden Field (Stage 3)
    "33_3" => [PBMoves::GROWTH,PBMoves::ROTOTILLER,PBMoves::RAINDANCE,PBMoves::WATERSPORT,PBMoves::SUNNYDAY,PBMoves::FLOWERSHIELD,PBMoves::INGRAIN,PBMoves::SWEETSCENT], #Flower Garden Field (Stage 4)
    "33_4" => [PBMoves::GROWTH,PBMoves::ROTOTILLER,PBMoves::RAINDANCE,PBMoves::WATERSPORT,PBMoves::SUNNYDAY,PBMoves::FLOWERSHIELD,PBMoves::SWEETSCENT], #Flower Garden Field (Stage 5)
    34 => [PBMoves::AURORAVEIL,PBMoves::COSMICPOWER,PBMoves::FLASH,PBMoves::WISH,PBMoves::HEALINGWISH,PBMoves::LUNARDANCE,PBMoves::MOONLIGHT], #Starlight Arena
    35 => [PBMoves::DARKVOID,PBMoves::HEARTSWAP,PBMoves::TRICKROOM,PBMoves::MAGICROOM,PBMoves::WONDERROOM,PBMoves::COSMICPOWER,PBMoves::FLASH,PBMoves::MOONLIGHT,PBMoves::NATURESMADNESS], #New World
    37 => [PBMoves::NASTYPLOT,PBMoves::CALMMIND,PBMoves::COSMICPOWER,PBMoves::MEDITATE,PBMoves::KINESIS,PBMoves::PSYCHUP,PBMoves::MINDREADER,PBMoves::MIRACLEEYE,PBMoves::TELEKINESIS,PBMoves::GRAVITY,PBMoves::TRICKROOM,PBMoves::MAGICROOM,PBMoves::WONDERROOM], #Psychic Terrain
    38 => [PBMoves::QUASH,PBMoves::EMBARGO,PBMoves::HEALBLOCK,PBMoves::DARKVOID], #Dimensional Field
    39 => [PBMoves::PARTINGSHOT], #Frozen Dimensional Field
    40 => [PBMoves::NIGHTMARE,PBMoves::SPITE,PBMoves::CURSE,PBMoves::DESTINYBOND,PBMoves::SCARYFACE,PBMoves::WILLOWISP,PBMoves::HYPNOSIS], #Haunted Field
    42 => [PBMoves::STRENGTHSAP,PBMoves::FORESTSCURSE,PBMoves::POISONPOWDER,PBMoves::SLEEPPOWDER,PBMoves::GRASSWHISTLE,PBMoves::STUNSPORE], #Bewitched Woods
    43 => [PBMoves::MIRRORMOVE,PBMoves::TAILWIND] #Sky Field
}

# Type Mods per field id per type (based on Field_Effect_Manual)
# ToDo: Fill
# $fieldTypeMods = {
#     1 => {PBTypes::ELECTRIC => [PBMoves::EXPLOSION]}
# }

# Type Mods per field id per type (based on Field_Effect_Manual)
# ToDo: Fill
# $fieldTypeAddOns = {
#     10 => {PBTypes::ELECTRIC => [PBTypes::GRASS]}
# }

# Type Boosts by Type (based on Field_Effect_Manual)
$fieldTypeBoosts = {
    PBTypes::BUG => {
        15 => { #Forest Field
            :boost => 1.5,
            :condition => "self.pbIsSpecial?(type)"
        },
        "33_1" => { :boost => 1.5 }, #Flower Garden Field (Stage 2)
        "33_3" => { :boost => 2.0 } #Flower Garden Field (Stage 4)
    },
    PBTypes::DARK => {
        29 => { #Holy Field
            :boost => 0.5,
            :condition => "self.pbIsSpecial?(type)"
        },
        34 => { :boost => 1.5 }, #Starlight Arena
        35 => { :boost => 1.5 }, #New World
        38 => { :boost => 1.5 }, #Dimensional Field
        39 => { :boost => 1.2 }, #Frozen Dimensional Field
        40 => { :boost => 0.7 }, #Haunted Field
        42 => { :boost => 1.2 } #Bewitched Woods
    },
    PBTypes::DRAGON => {
        3 => { #Misty Terrain
            :boost => 0.5,
            :condition => "!opponent.isAirborne?"
        },
        25 => { :boost => 1.5 }, #Crystal Cavern
        29 => { :boost => 1.2 }, #Holy Field
        31 => { :boost => 2.0 }, #Fairy Tale Field
        32 => { :boost => 2.0 } #Dragon's Den
    },
    PBTypes::ELECTRIC => {
        1 => { #Electric Field
            :boost => 1.5,
            :condition => "!attacker.isAirborne?"
        },
        12 => { #Desert Field
            :boost => 0.5,
            :condition => "!opponent.isAirborne?"
        },
        17 => { :boost => 1.2 }, #Factory Field
        21 => { :boost => 1.5 }, #Water Surface
        22 => { :boost => 2.0 }, #Underwater
        26 => { :boost => 1.3 } #Murkwater Surface
    },
    PBTypes::FAIRY => {
        29 => { :boost => 1.5 }, #Holy Field
        31 => { :boost => 1.5 }, #Fairy Tale Field
        34 => { :boost => 1.3 }, #Starlight Arena
        38 => { :boost => 0.5 }, #Dimensional Field
        40 => { :boost => 0.7 }, #Haunted Field
        41 => { :boost => 0.5 }, #Corrupted Cave
        42 => { :boost => 1.3 } #Bewitched Woods
    },
    PBTypes::FIRE => {
        2 => { #Grassy Terrain
            :boost => 1.5,
            :condition => "!opponent.isAirborne?"
        },
        7 => { #Volcanic Field
            :boost => 1.5,
            :condition => "!attacker.isAirborne?"
        },
        11 => { :boost => 0.5 }, #Corrosive Mist Field
        13 => { :boost => 0.5 }, #Icy Field
        16 => { :boost => 1.1 }, #Volcanic Top Field
        21 => { #Water Surface
            :boost => 0.5,
            :condition => "!opponent.isAirborne?"
        },
        22 => { :boost => 0 }, #Underwater
        28 => { :boost => 0.5 }, #Snowy Mountain
        32 => { :boost => 1.5 }, #Dragon's Den
        "33_2" => { :boost => 1.5 }, #Flower Garden Field (Stage 3)
        "33_3" => { :boost => 1.5 }, #Flower Garden Field (Stage 4)
        "33_4" => { :boost => 1.5 }, #Flower Garden Field (Stage 5)
        39 => { :boost => 0.5 } #Frozen Dimensional Field
    },
    PBTypes::FLYING => {
        23 => { #Cave
            :boost => 0.5,
            :condition => "!self.contactMove?"
        },
        27 => { :boost => 1.5 }, #Mountain
        28 => { :boost => 1.5 }, #Snowy Mountain
        41 => { #Corrupted Cave
            :boost => 0.5,
            :condition => "!self.contactMove?"
        },
        43 => { :boost => 1.3 } #Sky Field
    },
    PBTypes::GHOST => {
        29 => { :boost => 0.5 }, #Holy Field
        38 => { :boost => 1.2 }, #Dimensional Field
        40 => { :boost => 1.3 } #Haunted Field
    },
    PBTypes::GRASS => {
        2 => { #Grassy Terrain
            :boost => 1.5,
            :condition => "!attacker.isAirborne?"
        },
        7 => { #Volcanic Field
            :boost => 0.5,
            :condition => "!opponent.isAirborne?"
        },
        15 => { :boost => 1.5 }, #Forest Field
        "33_1" => { :boost => 1.2 }, #Flower Garden Field (Stage 2)
        "33_2" => { :boost => 1.5 }, #Flower Garden Field (Stage 3)
        "33_3" => { :boost => 2.0 }, #Flower Garden Field (Stage 4)
        "33_4" => { :boost => 3.0 }, #Flower Garden Field (Stage 5)
        41 => { :boost => 1.2 }, #Corrupted Cave
        42 => { :boost => 1.3 } #Bewitched Woods
    },
    PBTypes::GROUND => {
        21 => { :boost => 0 }, #Water Surface
        26 => { :boost => 0 } #Murkwater Surface
    },
    PBTypes::ICE => {
        7 => { :boost => 0.5 }, #Volcanic Field
        13 => { :boost => 1.5 }, #Icy Field
        16 => { :boost => 0.5 }, #Volcanic Top Field
        28 => { :boost => 1.5 }, #Snowy Mountain
        32 => { :boost => 0.5 }, #Dragon's Den
        39 => { :boost => 1.5 } #Frozen Dimensional Field
    },
    PBTypes::NORMAL => {
        9 => { :boost => 1.5 }, #Rainbow Field
        29 => { #Holy Field
            :boost => 1.5,
            :condition => "self.pbIsSpecial?(type)"
        },
    },  
    PBTypes::POISON => {
        8 => { #Swamp Field
            :boost => 1.5,
            :condition => "!opponent.isAirborne?"
        },
        26 => { :boost => 1.5 }, #Murkwater Surface
        41 => { :boost => 1.5 } #Corrupted Cave
    },
    PBTypes::PSYCHIC => {
        24 => { :boost => 1.2 }, #Glitch Field
        29 => { :boost => 1.2 }, #Holy Field
        34 => { :boost => 1.5 }, #Starlight Arena
        37 => { #Psychic Terrain
            :boost => 1.5,
            :condition => "!attacker.isAirborne?"
        }
    },
    PBTypes::ROCK => {
        14 => { :boost => 1.5 }, #Rocky Field
        23 => { :boost => 1.5 }, #Cave
        25 => { :boost => 1.5 }, #Crystal Cavern
        27 => { :boost => 1.5 }, #Mountain
        28 => { :boost => 1.5 }, #Snowy Mountain
        41 => { :boost => 1.2 } #Corrupted Cave
    },
    PBTypes::SHADOW => {
        38 => { :boost => 1.2 } #Dimensional Field
    },   
    PBTypes::STEEL => {
        31 => { :boost => 1.5 } #Fairy Tale Field
    },   
    PBTypes::WATER => {
        12 => { #Desert Field
            :boost => 0.5,
            :condition => "!attacker.isAirborne?"
        },
        16 => { #Volcanic Top Field
            :boost => 0.9,
            :condition => "self.move!=PBMoves::SCALD && self.move!=PBMoves::STEAMERUPTION"
        },
        21 => { :boost => 1.5 }, #Water Surface
        22 => { :boost => 1.5 }, #Underwater
        26 => { :boost => 1.5 }, #Murkwater Surface
        32 => { :boost => 0.5 } #Dragon's Den
    } 
}

# Move Boosts by Field (based on Field_Effect_Manual & PokeBattle_Move.rb lines 1489-2312)
$fieldMoveBoosts = {
    1 => { #Electric Field
        2.0 => [PBMoves::MAGNETBOMB],
        1.5 => [PBMoves::EXPLOSION, PBMoves::SELFDESTRUCT, PBMoves::HURRICANE, PBMoves::SURF, PBMoves::SMACKDOWN, PBMoves::MUDDYWATER, PBMoves::THOUSANDARROWS]       
    },
    2 => { #Grassy Terrain
        1.5 => [PBMoves::FAIRYWIND,PBMoves::SILVERWIND],
        0.5 => [PBMoves::MUDDYWATER,PBMoves::SURF,PBMoves::EARTHQUAKE,PBMoves::MAGNITUDE,PBMoves::BULLDOZE]
    },
    3 => { #Misty Terrain
        1.5 => [PBMoves::FAIRYWIND,PBMoves::MYSTICALFIRE,PBMoves::MOONBLAST,PBMoves::MAGICALLEAF,PBMoves::DOOMDUMMY,PBMoves::ICYWIND,PBMoves::AURASPHERE,PBMoves::MISTBALL,PBMoves::STEAMERUPTION,PBMoves::DAZZLINGGLEAM,PBMoves::CLEARSMOG,PBMoves::SMOG,PBMoves::SILVERWIND, PBMoves::MOONGEISTBEAM],
        0.5 => [PBMoves::DARKPULSE,PBMoves::NIGHTDAZE,PBMoves::SHADOWBALL],
        0 => [PBMoves::SELFDESTRUCT,PBMoves::EXPLOSION]
    },
    4 => { #Dark Crystal Cavern
        2.0 => [PBMoves::PRISMATICLASER],
        1.5 => [PBMoves::DARKPULSE,PBMoves::NIGHTDAZE,PBMoves::NIGHTSLASH,PBMoves::SHADOWBALL,PBMoves::SHADOWCLAW,PBMoves::SHADOWFORCE,PBMoves::SHADOWSNEAK,PBMoves::SHADOWPUNCH,PBMoves::SHADOWBONE,PBMoves::AURORABEAM,PBMoves::SIGNALBEAM,PBMoves::FLASHCANNON,PBMoves::LUSTERPURGE,PBMoves::DAZZLINGGLEAM,PBMoves::MIRRORSHOT,PBMoves::DOOMDUMMY,PBMoves::TECHNOBLAST,PBMoves::POWERGEM,PBMoves::MOONGEISTBEAM],
        1.3 => [PBMoves::STOMPINGTANTRUM] #Probably because of mistake (PokeBattle_Move.rb line 3328)
    },
    5 => { #Chess Board
        1.5 => [PBMoves::FAKEOUT,PBMoves::FEINT,PBMoves::FEINTATTACK,PBMoves::STRENGTH,PBMoves::ANCIENTPOWER,PBMoves::PSYCHIC]
    },
    6 => { #Big Top Arena
        2.0 => [PBMoves::PAYDAY],
        1.5 => [PBMoves::VINEWHIP,PBMoves::POWERWHIP,PBMoves::FIRELASH,PBMoves::FIERYDANCE,PBMoves::PETALDANCE,PBMoves::REVELATIONDANCE,PBMoves::FLY,PBMoves::ACROBATICS,PBMoves::FIRSTIMPRESSION]     
    },
    7 => { #Volcanic Field
        2.0 => [PBMoves::SMOG,PBMoves::CLEARSMOG],
        1.5 => [PBMoves::SMACKDOWN,PBMoves::THOUSANDARROWS,PBMoves::ROCKSLIDE]     
    },
    8 => { #Swamp Field
        1.5 => [PBMoves::MUDBOMB,PBMoves::MUDSHOT,PBMoves::MUDSLAP,PBMoves::MUDDYWATER,PBMoves::SURF,PBMoves::SLUDGEWAVE,PBMoves::GUNKSHOT,PBMoves::BRINE,PBMoves::SMACKDOWN,PBMoves::THOUSANDARROWS],
        0 => [PBMoves::SELFDESTRUCT,PBMoves::EXPLOSION]
    },
    9 => { #Rainbow Field
        1.5 => [PBMoves::SILVERWIND,PBMoves::MYSTICALFIRE,PBMoves::DRAGONPULSE,PBMoves::TRIATTACK,PBMoves::SACREDFIRE,PBMoves::FIREPLEDGE,PBMoves::WATERPLEDGE,PBMoves::GRASSPLEDGE,PBMoves::AURORABEAM,PBMoves::JUDGMENT,PBMoves::RELICSONG,PBMoves::HIDDENPOWER,PBMoves::SECRETPOWER,PBMoves::WEATHERBALL,PBMoves::MISTBALL,PBMoves::HEARTSTAMP,PBMoves::MOONBLAST,PBMoves::ZENHEADBUTT,PBMoves::SPARKLINGARIA,PBMoves::FLEURCANNON,PBMoves::PRISMATICLASER],
        0.5 => [PBMoves::DARKPULSE,PBMoves::NIGHTDAZE,PBMoves::SHADOWBALL],
        0 => [PBMoves::NIGHTMARE]
    },
    10 => { #Corrosive Field
        2.0 => [PBMoves::GRASSKNOT,PBMoves::ACID,PBMoves::ACIDSPRAY],
        1.5 => [PBMoves::SMACKDOWN,PBMoves::MUDSLAP,PBMoves::MUDSHOT,PBMoves::MUDDYWATER,PBMoves::MUDBOMB,PBMoves::WHIRLPOOL,PBMoves::THOUSANDARROWS]      
    },
    11 => { #Corrosive Mist Field
        1.5 => [PBMoves::SMOG,PBMoves::CLEARSMOG,PBMoves::ACIDSPRAY,PBMoves::BUBBLE,PBMoves::BUBBLEBEAM,PBMoves::SPARKLINGARIA]
    },
    12 => { #Desert Field
        1.5 => [PBMoves::HEATWAVE,PBMoves::NEEDLEARM,PBMoves::PINMISSILE,PBMoves::DIG,PBMoves::SANDTOMB,PBMoves::THOUSANDWAVES,PBMoves::BURNUP] 
    },
    13 => { #Icy Field
        0.5 => [PBMoves::SCALD,PBMoves::STEAMERUPTION]
    },
    14 => { #Rocky Field
        2.0 => [PBMoves::ROCKSMASH],
        1.5 => [PBMoves::EARTHQUAKE,PBMoves::MAGNITUDE,PBMoves::ROCKCLIMB,PBMoves::STRENGTH,PBMoves::BULLDOZE,PBMoves::ACCELEROCK]  
    },
    15 => { #Forest Field
        2.0 => [PBMoves::CUT,PBMoves::ATTACKORDER],
        1.5 => [PBMoves::SLASH,PBMoves::AIRSLASH,PBMoves::GALESTRIKE,PBMoves::FURYCUTTER,PBMoves::AIRCUTTER,PBMoves::PSYCHOCUT],
        0.5 => [PBMoves::SURF,PBMoves::MUDDYWATER]
    },
    16 => { #Volcanic Top Field
        1.667 => [PBMoves::SCALD,PBMoves::STEAMERUPTION],
        1.3 => [PBMoves::ERUPTION,PBMoves::HEATWAVE,PBMoves::MAGMASTORM,PBMoves::LAVAPLUME,PBMoves::LAVASURF],
        1.2 => [PBMoves::OMINOUSWIND,PBMoves::SILVERWIND,PBMoves::RAZORWIND,PBMoves::ICYWIND,PBMoves::GUST,PBMoves::TWISTER,PBMoves::PRECIPICEBLADES,PBMoves::SMOG,PBMoves::CLEARSMOG],
        0.555 => [PBMoves::SURF,PBMoves::MUDDYWATER,PBMoves::WATERPLEDGE,PBMoves::WATERSPOUT,PBMoves::SPARKLINGARIA],
        0 => [PBMoves::HAIL]
    },
    17 => { #Factory Field
        2.0 => [PBMoves::FLASHCANNON,PBMoves::GYROBALL,PBMoves::GEARGRIND,PBMoves::MAGNETBOMB],
        1.5 => [PBMoves::STEAMROLLER,PBMoves::TECHNOBLAST]       
    },
    18 => { #Short-circuit Field
        1.5 => [PBMoves::DAZZLINGGLEAM,PBMoves::SURF,PBMoves::MUDDYWATER,PBMoves::GYROBALL,PBMoves::MAGNETBOMB,PBMoves::FLASHCANNON,PBMoves::GEARGRIND],
        1.3 => [PBMoves::DARKPULSE,PBMoves::NIGHTDAZE,PBMoves::NIGHTSLASH,PBMoves::SHADOWBALL,PBMoves::SHADOWCLAW,PBMoves::SHADOWFORCE,PBMoves::SHADOWSNEAK,PBMoves::SHADOWPUNCH,PBMoves::SHADOWBONE]
    },
    19 => { #Wasteland
        2.0 => [PBMoves::SPITUP],
        1.5 => [PBMoves::VINEWHIP,PBMoves::POWERWHIP,PBMoves::MUDBOMB,PBMoves::MUDSLAP,PBMoves::MUDSHOT],
        1.2 => [PBMoves::OCTAZOOKA,PBMoves::GUNKSHOT,PBMoves::SLUDGE,PBMoves::SLUDGEWAVE,PBMoves::SLUDGEBOMB],
        0.25 => [PBMoves::MAGNITUDE,PBMoves::EARTHQUAKE,PBMoves::BULLDOZE]
    },
    20 => { #Ashen Beach
        2.0 => [PBMoves::MUDSLAP,PBMoves::MUDSHOT,PBMoves::MUDBOMB,PBMoves::SANDTOMB],
        1.5 => [PBMoves::STRENGTH,PBMoves::HIDDENPOWER,PBMoves::LANDSWRATH,PBMoves::THOUSANDWAVES,PBMoves::SURF,PBMoves::MUDDYWATER],
        1.3 => [PBMoves::ZENHEADBUTT,PBMoves::STOREDPOWER,PBMoves::AURASPHERE,PBMoves::FOCUSBLAST],
        1.2 => [PBMoves::PSYCHIC]
    },
    21 => { #Water Surface
        1.5 => [PBMoves::WHIRLPOOL,PBMoves::DIVE,PBMoves::SURF,PBMoves::MUDDYWATER,PBMoves::SLUDGEWAVE],
        0 => [PBMoves::SPIKES, PBMoves::TOXICSPIKES]
    },
    22 => { #Underwater
        2.0 => [PBMoves::ANCHORSHOT,PBMoves::SLUDGEWAVE],
        1.5 => [PBMoves::WATERPULSE],
        0 => [PBMoves::SUNNYDAY, PBMoves::HAIL, PBMoves::SANDSTORM, PBMoves::RAINDANCE, PBMoves::SHADOWSKY],
    },
    23 => { #Cave
        1.5 => [PBMoves::ROCKTOMB],
        0 => [PBMoves::SKYDROP]
    },
    25 => { #Crystal Cavern
        1.5 => [PBMoves::POWERGEM,PBMoves::DIAMONDSTORM,PBMoves::ANCIENTPOWER,PBMoves::ROCKTOMB,PBMoves::ROCKSMASH,PBMoves::PRISMATICLASER,PBMoves::MULTIATTACK,PBMoves::JUDGMENT,PBMoves::STRENGTH,PBMoves::ROCKCLIMB],
        1.3 => [PBMoves::AURORABEAM,PBMoves::SIGNALBEAM,PBMoves::FLASHCANNON,PBMoves::LUSTERPURGE,PBMoves::DAZZLINGGLEAM,PBMoves::MIRRORSHOT,PBMoves::DOOMDUMMY,PBMoves::TECHNOBLAST,PBMoves::MOONGEISTBEAM]
    },
    26 => { #Murkwater Surface
        1.5 => [PBMoves::MUDBOMB,PBMoves::MUDSHOT,PBMoves::MUDSLAP,PBMoves::THOUSANDWAVES,PBMoves::SMACKDOWN,PBMoves::ACID,PBMoves::ACIDSPRAY,PBMoves::BRINE],
        0 => [PBMoves::SPIKES, PBMoves::TOXICSPIKES]
    },
    27 => { #Mountain
        1.5 => [PBMoves::THUNDER,PBMoves::ERUPTION,PBMoves::AVALANCHE,PBMoves::VITALTHROW,PBMoves::STORMTHROW,PBMoves::CIRCLETHROW,PBMoves::OMINOUSWIND,PBMoves::RAZORWIND,PBMoves::ICYWIND,PBMoves::SILVERWIND,PBMoves::FAIRYWIND,PBMoves::TWISTER]
    },
    28 => { #Snowy Mountain
        2.0 => [PBMoves::ICYWIND],
        1.5 => [PBMoves::POWDERSNOW,PBMoves::AVALANCHE,PBMoves::VITALTHROW,PBMoves::STORMTHROW,PBMoves::CIRCLETHROW,PBMoves::OMINOUSWIND,PBMoves::RAZORWIND,PBMoves::SILVERWIND,PBMoves::FAIRYWIND,PBMoves::TWISTER],
        0.5 => [PBMoves::SCALD,PBMoves::STEAMERUPTION]
    },
    29 => { #Holy Field
        1.5 => [PBMoves::MYSTICALFIRE,PBMoves::MAGICALLEAF,PBMoves::JUDGMENT,PBMoves::SACREDFIRE,PBMoves::ANCIENTPOWER],
        1.3 => [PBMoves::PSYSTRIKE,PBMoves::AEROBLAST,PBMoves::ORIGINPULSE,PBMoves::PRECIPICEBLADES,PBMoves::DRAGONASCENT,PBMoves::DOOMDUMMY,PBMoves::MISTBALL,PBMoves::LUSTERPURGE,PBMoves::PSYCHOBOOST,PBMoves::SPACIALREND,PBMoves::ROAROFTIME,PBMoves::CRUSHGRIP,PBMoves::SECRETSWORD,PBMoves::RELICSONG,PBMoves::HYPERSPACEHOLE,PBMoves::LANDSWRATH,PBMoves::MOONGEISTBEAM,PBMoves::SUNSTEELSTRIKE,PBMoves::PRISMATICLASER,PBMoves::FLEURCANNON,PBMoves::MULTIPULSE]
    },
    30 => { #Mirror Arena
        2.0 => [PBMoves::MIRRORSHOT],
        1.5 => [PBMoves::AURORABEAM,PBMoves::SIGNALBEAM,PBMoves::FLASHCANNON,PBMoves::LUSTERPURGE,PBMoves::DOOMDUMMY,PBMoves::DAZZLINGGLEAM,PBMoves::TECHNOBLAST,PBMoves::PRISMATICLASER]
    },
    31 => { #Fairy Tale Field
        2.0 => [PBMoves::DRAININGKISS],
        1.5 => [PBMoves::NIGHTSLASH,PBMoves::LEAFBLADE,PBMoves::PSYCHOCUT,PBMoves::SMARTSTRIKE,PBMoves::SOLARBLADE,PBMoves::MAGICALLEAF,PBMoves::MYSTICALFIRE,PBMoves::ANCIENTPOWER,PBMoves::RELICSONG,PBMoves::SPARKLINGARIA,PBMoves::MOONGEISTBEAM,PBMoves::FLEURCANNON],
    },
    32 => { #Dragon's Den
        2.0 => [PBMoves::SMACKDOWN,PBMoves::THOUSANDARROWS,PBMoves::PAYDAY,PBMoves::DRAGONASCENT],
        1.5 => [PBMoves::LAVAPLUME,PBMoves::MAGMASTORM,PBMoves::MEGAKICK]
    },
    "33_1" => { #Flower Garden Field (Stage 2)
        1.5 => [PBMoves::CUT]
    },
    "33_2" => { #Flower Garden Field (Stage 3)
        1.5 => [PBMoves::CUT],
        1.2 => [PBMoves::PETALDANCE,PBMoves::PETALBLIZZARD,PBMoves::FLEURCANNON]
    },
    "33_3" => { #Flower Garden Field (Stage 4)
        1.5 => [PBMoves::CUT,PBMoves::FLEURCANNON,PBMoves::PETALDANCE,PBMoves::PETALBLIZZARD]
    },
    "33_4" => { #Flower Garden Field (Stage 5)
        1.5 => [PBMoves::CUT,PBMoves::FLEURCANNON,PBMoves::PETALDANCE,PBMoves::PETALBLIZZARD]
    },
    34 => { #Starlight Arena
        4.0 => [PBMoves::DOOMDUMMY],
        2.0 => [PBMoves::DRACOMETEOR,PBMoves::METEORMASH,PBMoves::COMETPUNCH,PBMoves::SPACIALREND,PBMoves::SWIFT,PBMoves::HYPERSPACEHOLE,PBMoves::HYPERSPACEFURY,PBMoves::MOONGEISTBEAM,PBMoves::SUNSTEELSTRIKE],
        1.5 => [PBMoves::AURORABEAM,PBMoves::SIGNALBEAM,PBMoves::FLASHCANNON,PBMoves::LUSTERPURGE,PBMoves::DAZZLINGGLEAM,PBMoves::MIRRORSHOT,PBMoves::MOONBLAST,PBMoves::TECHNOBLAST,PBMoves::SOLARBEAM],
    },
    35 => { #New World
        4.0 => [PBMoves::DOOMDUMMY],
        2.0 => [PBMoves::VACUUMWAVE,PBMoves::DRACOMETEOR,PBMoves::METEORMASH,PBMoves::MOONBLAST,PBMoves::COMETPUNCH,PBMoves::SPACIALREND,PBMoves::SWIFT,PBMoves::FUTUREDUMMY,PBMoves::ANCIENTPOWER,PBMoves::HYPERSPACEHOLE,PBMoves::HYPERSPACEFURY],
        1.5 => [PBMoves::AURORABEAM,PBMoves::SIGNALBEAM,PBMoves::FLASHCANNON,PBMoves::DAZZLINGGLEAM,PBMoves::MIRRORSHOT,PBMoves::EARTHPOWER,PBMoves::POWERGEM,PBMoves::ERUPTION,PBMoves::PSYSTRIKE,PBMoves::AEROBLAST,PBMoves::SACREDFIRE,PBMoves::MISTBALL,PBMoves::LUSTERPURGE,PBMoves::ORIGINPULSE,PBMoves::PRECIPICEBLADES,PBMoves::DRAGONASCENT,PBMoves::PSYCHOBOOST,PBMoves::ROAROFTIME,PBMoves::MAGMASTORM,PBMoves::CRUSHGRIP,PBMoves::JUDGMENT,PBMoves::SEEDFLARE,PBMoves::SHADOWFORCE,PBMoves::SEARINGSHOT,PBMoves::VCREATE,PBMoves::SECRETSWORD,PBMoves::SACREDSWORD,PBMoves::RELICSONG,PBMoves::FUSIONBOLT,PBMoves::FUSIONFLARE,PBMoves::ICEBURN,PBMoves::FREEZESHOCK,PBMoves::BOLTSTRIKE,PBMoves::BLUEFLARE,PBMoves::TECHNOBLAST,PBMoves::OBLIVIONWING,PBMoves::LANDSWRATH,PBMoves::THOUSANDARROWS,PBMoves::THOUSANDWAVES,PBMoves::DIAMONDSTORM,PBMoves::STEAMERUPTION,PBMoves::COREENFORCER,PBMoves::FLEURCANNON,PBMoves::PRISMATICLASER,PBMoves::SUNSTEELSTRIKE,PBMoves::SPECTRALTHIEF,PBMoves::MOONGEISTBEAM,PBMoves::MULTIATTACK]
    },
    37 => { #Psychic Terrain
        1.5 => [PBMoves::HEX,PBMoves::MAGICALLEAF,PBMoves::MYSTICALFIRE,PBMoves::MOONBLAST,PBMoves::AURASPHERE]
    },
    38 => { #Dimensional Field
        1.5 => [PBMoves::DIMTHRASH,PBMoves::DIMPULSE,PBMoves::DIMFLARE,PBMoves::DIMSNARE],
        1.2 => [PBMoves::DARKPULSE,PBMoves::MOONBLAST],
        0 => [PBMoves::LUCKYCHANT]
    },
    39 => { #Frozen Dimensional Field
        1.2 => [PBMoves::SURF,PBMoves::MUDDYWATER,PBMoves::WATERPULSE,PBMoves::HYDROPUMP,PBMoves::NIGHTSLASH,PBMoves::DARKPULSE]
    },
    40 => { #Haunted Field
        1.3 => [PBMoves::FLAMEBURST,PBMoves::INFERNO,PBMoves::FIRESPIN] # Probably missing ,PBMoves::FLAMECHARGE (because FlameBurst is duplicate)
    },
    41 => { #Corrupted Cave
        1.2 => [PBMoves::SEEDFLARE]
    },
    42 => { #Bewitched Woods
        1.4 => [PBMoves::ICEBEAM,PBMoves::HYPERBEAM,PBMoves::SIGNALBEAM,PBMoves::AURORABEAM,PBMoves::BUBBLEBEAM,PBMoves::CHARGEBEAM,PBMoves::PSYBEAM,PBMoves::FLASHCANNON,PBMoves::MAGICALLEAF],
        1.2 => [PBMoves::DARKPULSE,PBMoves::NIGHTDAZE,PBMoves::MOONBLAST]
    },
    43 => { #Sky Field
        1.5 => [PBMoves::ICYWIND,PBMoves::OMINOUSWIND,PBMoves::SILVERWIND,PBMoves::RAZORWIND,PBMoves::FAIRYWIND,PBMoves::AEROBLAST,PBMoves::SKYUPPERCUT,PBMoves::FLYINGPRESS,PBMoves::THUNDERSHOCK,PBMoves::THUNDERBOLT,PBMoves::THUNDER,PBMoves::STEELWING,PBMoves::TWISTER],
        0 => [PBMoves::EARTHQUAKE,PBMoves::MAGNITUDE,PBMoves::BULLDOZE,PBMoves::ROTOTILLER,PBMoves::DIG,PBMoves::SPIKES,PBMoves::TOXICSPIKES,PBMoves::STICKYWEB]
    }
}

# For new Constants
module PokeBattle_SceneConstants
    # Position and width of HP/Exp bars
    HPGAUGE_X    = -2
    HPGAUGE_Y    = 50
    HPGAUGESIZE  = 204
    HPGAUGEHEIGHTS = 16
    HPGAUGEHEIGHTD = 12
    EXPGAUGE_X   = -2
    EXPGAUGE_Y   = 68
    EXPGAUGESIZE = 204

    # Coordinates of the top left of the player's data boxes
    PLAYERBOX_X   = Graphics.width - 244
    PLAYERBOX_Y   = Graphics.height - 208
    PLAYERBOXD1_X = PLAYERBOX_X - 16
    PLAYERBOXD1_Y = PLAYERBOX_Y - 8
    PLAYERBOXD2_X = PLAYERBOX_X - 4
    PLAYERBOXD2_Y = PLAYERBOX_Y + 48

    # Coordinates of the top left of the foe's data boxes
    FOEBOX_X      = -4
    FOEBOX_Y      = 20
    FOEBOXD1_X    = FOEBOX_X + 4
    FOEBOXD1_Y    = FOEBOX_Y - 20
    FOEBOXD2_X    = FOEBOX_X - 8
    FOEBOXD2_Y    = FOEBOX_Y + 36
    FOEBOXD2BOSS1_Y = FOEBOX_Y + 54
end

# For Adding "field_effects_highlights" option
class PokemonOptionScene
    def pbStartScene
        if !$PokemonSystem.volume 
            $PokemonSystem.volume = 100
        end
        @sprites={}
        @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
        @viewport.z=99999
        @sprites["title"]=Window_UnformattedTextPokemon.newWithSize(_INTL("Options"),0,0,Graphics.width,64,@viewport)
        @sprites["textbox"]=Kernel.pbCreateMessageWindow
        @sprites["textbox"].letterbyletter=false
        @sprites["textbox"].text=_INTL("Speech frame {1}.",1+$PokemonSystem.textskin)
        # These are the different options in the game.  To add an option, define a
        # setter and a getter for that option.  To delete an option, comment it out
        # or delete it.  The game's options may be placed in any order.
        @PokemonOptions=[
            EnumOption.new(_INTL("Text Speed"),[_INTL("Normal"),_INTL("Fast"),_INTL("Max")],
                proc { $PokemonSystem.textspeed },
                proc {|value|  
                    $PokemonSystem.textspeed=value 
                    MessageConfig.pbSetTextSpeed(pbSettingToTextSpeed(value)) 
                }
            ),
            NumberOption.new(_INTL("Volume"),_INTL("Type %d"),0,100,
                proc { $PokemonSystem.volume },
                proc {|value|  $PokemonSystem.volume=value
                    if $game_map
                        $game_map.autoplay
                    end
                }    
            ),
            EnumOption.new(_INTL("Battle Scene"),[_INTL("On"),_INTL("Off")],
                proc { $PokemonSystem.battlescene },
                proc {|value|  $PokemonSystem.battlescene=value }
            ),
            EnumOption.new(_INTL("Battle Style"),[_INTL("Shift"),_INTL("Set")],
                proc { $PokemonSystem.battlestyle },
                proc {|value|  $PokemonSystem.battlestyle=value }
            ),
            NumberOption.new(_INTL("Speech Frame"),_INTL("Type %d"),1,$SpeechFrames.length,
                proc { $PokemonSystem.textskin },
                proc {|value|  $PokemonSystem.textskin=value;
                    MessageConfig.pbSetSpeechFrame("Graphics/Windowskins/"+$SpeechFrames[value])
                }
            ),
            NumberOption.new(_INTL("Menu Frame"),_INTL("Type %d"),1,$TextFrames.length,
                proc { $PokemonSystem.frame },
                proc {|value|  
                    $PokemonSystem.frame=value
                    MessageConfig.pbSetSystemFrame($TextFrames[value]) 
                }
            ),
            EnumOption.new(_INTL("Field UI highlights"),[_INTL("On"),_INTL("Off")],
                proc { $field_effects_highlights},
                proc {|value|  $field_effects_highlights=value }
            ),
            EnumOption.new(_INTL("Font Style"),[_INTL("Em"),_INTL("R/S"),_INTL("FRLG"),_INTL("DP")],
                proc { $PokemonSystem.font },
                proc {|value|  
                    $PokemonSystem.font=value
                    MessageConfig.pbSetSystemFontName($VersionStyles[value])
                }
            ),
            EnumOption.new(_INTL("Backup"),[_INTL("On"),_INTL("Off")],
                proc { $PokemonSystem.backup },
                proc {|value|  $PokemonSystem.backup=value }
            ),
            NumberOption.new(_INTL("Max Backup Number"),_INTL("Type %d"),1,100,
                proc { $PokemonSystem.maxBackup },
                proc {|value|  
                    $PokemonSystem.maxBackup=value #+1
                }    
            ),       
            # Quote this section out if you don't want to allow players to change the screen
            # size.
            EnumOption.new(_INTL("Screen Size"),[_INTL("S"),_INTL("M"),_INTL("L"),_INTL("Full")],
                proc { $PokemonSystem.screensize },
                proc {|value|
                    oldvalue=$PokemonSystem.screensize
                    $PokemonSystem.screensize=value
                    if value!=oldvalue
                        pbSetResizeFactor($PokemonSystem.screensize)
                        ObjectSpace.each_object(TilemapLoader){|o| next if o.disposed?; o.updateClass }
                    end
                }
            ),   
        # ------------------------------------------------------------------------------   
            EnumOption.new(_INTL("Screen Border"),[_INTL("Off"),_INTL("On")],
                proc { $PokemonSystem.border },
                proc {|value|
                    oldvalue=$PokemonSystem.border
                    $PokemonSystem.border=value
                    if value!=oldvalue
                        pbSetResizeFactor($PokemonSystem.screensize)
                        ObjectSpace.each_object(TilemapLoader){|o| next if o.disposed?; o.updateClass }
                    end
                }
            ),
        #### SARDINES - Autosave - START
            EnumOption.new(_INTL("Autosave"),[_INTL("On"),_INTL("Off")],
                proc { $PokemonSystem.autosave },          
                proc {|value|  $PokemonSystem.autosave=value }
            )
        #### SARDINES - Autosave - END
        ]
        @sprites["option"]=Window_PokemonOption.new(@PokemonOptions,0,
        @sprites["title"].height,Graphics.width,Graphics.height-@sprites["title"].height-@sprites["textbox"].height)
        @sprites["option"].viewport=@viewport
        @sprites["option"].visible=true
        # Get the values of each option
        for i in 0...@PokemonOptions.length
            @sprites["option"][i]=(@PokemonOptions[i].get || 0)
        end
        pbDeactivateWindows(@sprites)
        pbFadeInAndShow(@sprites) { pbUpdate }
    end
end

def getFieldEffectPos
    fieldeffectpos = $fefieldeffect
    if fieldeffectpos == 33
        fieldeffectpos = fieldeffectpos.to_s + "_" + $fecounter.to_s
    end

    return fieldeffectpos
end

# For Good/Bad Move Visualization
class FightMenuButtons
    def initialize(index=0,moves=nil,viewport=nil)
        super(Graphics.width,96+UPPERGAP,viewport)
        self.x=0
        self.y=Graphics.height-96-UPPERGAP
        pbSetNarrowFont(self.bitmap)
        @buttonbitmap=AnimatedBitmap.new("Graphics/Pictures/Battle/battleFightButtons")
        @megaevobitmap=AnimatedBitmap.new("Graphics/Pictures/Battle/battleMegaEvo")
        @zmovebitmap=AnimatedBitmap.new("Graphics/Pictures/Battle/battleZMove")
        @zmovebitmap=AnimatedBitmap.new("Graphics/Pictures/Battle/battleZMove")
        @goodmovebitmap=AnimatedBitmap.new("Graphics/Pictures/Battle/fieldUp")
        @badmovebitmap=AnimatedBitmap.new("Graphics/Pictures/Battle/fieldDown")   
        refresh(index,moves,0,0)
    end

    def dispose
        @buttonbitmap.dispose
        @megaevobitmap.dispose
        @goodmovebitmap.dispose
        @badmovebitmap.dispose
        super
    end

    def refresh(index,moves,megaButton,zButton)
        return if !moves || !moves[0]
        battler = moves[0].battle.battlers.find { |attacker| attacker.moves.include?(moves[0]) }
        return if !battler
        self.bitmap.clear
        textpos=[]
        for i in 0...4
            next if i==index
            next if moves[i].id==0
            x=((i%2)==0) ? 5 : 194
            y=((i/2)==0) ? 6 : 48
            y+=UPPERGAP
            self.bitmap.blt(x,y,@buttonbitmap.bitmap,Rect.new(0,moves[i].type*46,190,46))
            textpos.push([_INTL("{1}",moves[i].name),x+96,y+8,2,PokeBattle_SceneConstants::MENUBASECOLOR,PokeBattle_SceneConstants::MENUSHADOWCOLOR])
        end
        ppcolors=[
            PokeBattle_SceneConstants::PPTEXTBASECOLOR,PokeBattle_SceneConstants::PPTEXTSHADOWCOLOR,
            PokeBattle_SceneConstants::PPTEXTBASECOLOR,PokeBattle_SceneConstants::PPTEXTSHADOWCOLOR,
            PokeBattle_SceneConstants::PPTEXTBASECOLORYELLOW,PokeBattle_SceneConstants::PPTEXTSHADOWCOLORYELLOW,
            PokeBattle_SceneConstants::PPTEXTBASECOLORORANGE,PokeBattle_SceneConstants::PPTEXTSHADOWCOLORORANGE,
            PokeBattle_SceneConstants::PPTEXTBASECOLORRED,PokeBattle_SceneConstants::PPTEXTSHADOWCOLORRED
        ]
        for i in 0...4
            next if i!=index
            next if moves[i].id==0
            x=((i%2)==0) ? 5 : 194
            y=((i/2)==0) ? 6 : 48
            y+=UPPERGAP
            imagepos=[]
            movetype = PBTypes.getName(moves[i].pbType(moves[i].type,battler,battler.pbOppositeOpposing))
            secondtype = moves[i].getSecondaryType(battler)
            if secondtype.nil?
                imagepos.push([sprintf("Graphics/Icons/type%s",movetype),416,20+UPPERGAP,0,0,64,28])
            elsif secondtype.length == 1
                imagepos.push([sprintf("Graphics/Icons/type%s",movetype),402,20+UPPERGAP,0,0,64,28])
                imagepos.push([sprintf("Graphics/Icons/minitype%s",PBTypes.getName(secondtype[0])),466,20+UPPERGAP,0,0,28,28])
            else
                imagepos.push([sprintf("Graphics/Icons/minitype%s",movetype),404,20+UPPERGAP,0,0,64,28])
                imagepos.push([sprintf("Graphics/Icons/minitype%s",PBTypes.getName(secondtype[0])),432,20+UPPERGAP,0,0,28,28])
                imagepos.push([sprintf("Graphics/Icons/minitype%s",PBTypes.getName(secondtype[1])),460,20+UPPERGAP,0,0,28,28])
            end
            self.bitmap.blt(x,y,@buttonbitmap.bitmap,Rect.new(190,moves[i].type*46,190,46))
            textpos.push([_INTL("{1}",moves[i].name),x+96,y+8,2,PokeBattle_SceneConstants::MENUBASECOLOR,PokeBattle_SceneConstants::MENUSHADOWCOLOR])
            if moves[i].totalpp>0
                ppfraction=(4.0*moves[i].pp/moves[i].totalpp).ceil
                textpos.push([_INTL("PP: {1}/{2}",moves[i].pp,moves[i].totalpp),448,50+UPPERGAP,2,ppcolors[(4-ppfraction)*2],ppcolors[(4-ppfraction)*2+1]])
            end
        end
        pbDrawImagePositions(self.bitmap,imagepos)
        for i in 0...4
            next if !moves[i]
            x=((i%2)==0) ? 4 : 192
            y=((i/2)==0) ? 6 : 48
            y+=UPPERGAP
            y-=2
            case pbFieldNotesBattle(moves[i])
                when 1 then self.bitmap.blt(x+2,y+2,@goodmovebitmap.bitmap, Rect.new(0,0,@goodmovebitmap.bitmap.width,@goodmovebitmap.bitmap.height))
                when 2 then self.bitmap.blt(x+2,y+2,@badmovebitmap.bitmap, Rect.new(0,0,@badmovebitmap.bitmap.width,@badmovebitmap.bitmap.height))
            end
        end
        pbDrawTextPositions(self.bitmap,textpos)
        if megaButton>0
            self.bitmap.blt(146,0,@megaevobitmap.bitmap,Rect.new(0,(megaButton-1)*46,96,46))
        end
        if zButton>0
            self.bitmap.blt(146,0,@zmovebitmap.bitmap,Rect.new(0,(zButton-1)*46,96,46))
        end    
    end

    def pbFieldNotesBattle(move)
        return 0 if $field_effects_highlights==1
        #return 0 if !isFieldEffect? 
        return 1 if $fieldEffectStatusMoves[getFieldEffectPos()] && $fieldEffectStatusMoves[getFieldEffectPos()].include?(move.id)
        battle = move.battle
        typeBoost = 1; moveBoost=1
        attacker = battle.battlers.find { |battler| battler.moves.include?(move) }
        opponent = attacker.pbOppositeOpposing
        movetype = move.pbType(move.type,attacker,opponent)
        if move.basedamage > 0 && !((0x6A..0x73).include?(move.function) || [0xD4,0xE1].include?(move.function))
            typeBoost = move.typeFieldBoost(movetype,attacker,opponent)
            moveBoost = move.moveFieldBoost
            moveBoost = 1.5 if move.isSoundBased? && move.basedamage > 0 && [23,6].include?($fefieldeffect) # Cave Field, Big Top Arena
        end
        moveBoost = 1.5 if move.id == PBMoves::SONICBOOM && $fefieldeffect == 9 # Rainbow Field
        
        # Failing moves
        case $fefieldeffect
            when 22, 35 # Underwater, New World
                moveBoost = 0 if [PBMoves::ELECTRICTERRAIN,PBMoves::GRASSYTERRAIN,PBMoves::MISTYTERRAIN,PBMoves::PSYCHICTERRAIN,PBMoves::MIST].include?(move.id) # Might not be entirely accurate
                moveBoost = 0 if [PBMoves::RAINDANCE,PBMoves::SUNNYDAY,PBMoves::HAIL,PBMoves::SANDSTORM].include?(move.id) # Might not be entirely accurate
            when 1 # Electric Terrain
                moveBoost = 0 if [PBMoves:FOCUSPUNCH].include?(move.id)
            when 23 # Cave
                moveBoost = 0 if [PBMoves:SKYDROP].include?(move.id)
        end
        totalboost = typeBoost*moveBoost
        if totalboost > 1
            return 1
        elsif totalboost < 1
            return 2
        end

        return 0
    end

    def isFieldEffect?
        return false if $fefieldeffect == 0 || $fefieldeffect == 38 || $fefieldeffect == 39
        return true
    end
end

# class PBTypes
#     def PBTypes.oneTypeEff(attackType,opponentType)
#         return 2 if opponentType.nil?
#         return 4 if PBTypes.isSuperEffective?(attackType,opponentType)
#         return 1 if PBTypes.isNotVeryEffective?(attackType,opponentType)
#         return 0 if PBTypes.isIneffective?(attackType,opponentType)
#         return 2
#     end
# end

class PokeBattle_Move
    # def pbTypeShort(attacker)
    #     pbType(@type,attacker,attacker.pbOppositeOpposing)
    # end

    # def getRandomType(except=[])
    #     except = [except] if except && !except.is_a?(Array)
    #     types=[]
    #     for j in 0...PBTypes.getCount
    #       types.push(j) if j!= PBTypes::QMARKS && j!= PBTypes::SHADOW && !except.include?(j)
    #     end
    #     rnd=@battle.pbRandom(types.length)
    #     type = types[rnd]
    #     return type
    # end

    # def getRoll(update_roll: true, maximize_roll: false)
    #     case $fefieldeffect
    #         when 25 then choices = [PBTypes::FIRE, PBTypes::WATER, PBTypes::GRASS, PBTypes::PSYCHIC] #Crystal Cavern
    #         when 18 then choices = [0.8, 1.5, 0.5, 1.2, 2.0] #Short-circuit
    #     end
    #     result=choices[@roll] # ToDo: Find a solution for @roll
    #     @roll = (@roll + 1) % choices.length if update_roll
    #     result=choices.max if $fefieldeffect == 18 && maximize_roll #Short-circuit
    #     return result
    # end

    def typeFieldBoost(type,attacker=nil,opponent=nil) #Returns Multiplier Value of Field Boost
        typeboosts = $fieldTypeBoosts[type]
        return 1 if !typeboosts
        fieldtype = typeboosts[getFieldEffectPos()]
        return 1 if !fieldtype || !fieldtype[:boost]
        return 1 if fieldtype[:boost] && $fefieldeffect == 34 && !(@battle.pbWeather == 0 || @battle.pbWeather == PBWeather::STRONGWINDS) #Starlight Arena
        
        if fieldtype[:condition] && attacker && opponent
            return 1 if !eval(fieldtype[:condition])
        end

        return fieldtype[:boost]
    end

    def moveFieldBoost
        fieldmove = $fieldMoveBoosts[getFieldEffectPos()]
        return 1 if !fieldmove
        mult = -1
        fieldmove.each do |boost, moves|
            if moves.include?(@id)
                mult = boost
                break
            end
        end
        return 1 if mult == -1
        return 1 if mult > -1 && $fefieldeffect == 34 && !(@battle.pbWeather == 0 || @battle.pbWeather == PBWeather::STRONGWINDS) #Starlight Arena

        return mult
    end

    # def fieldTypeChange(attacker,opponent,typemod,return_type=false)
    #     case $fefieldeffect
    #         when 9 # Rainbow Field
    #             if (pbTypeShort(attacker) == PBTypes::NORMAL) && pbIsSpecial?(pbTypeShort(attacker)) 
    #                 moddedtype = @battle.getRandomType(PBTypes::NORMAL)
    #             end
    #         when 11 # Corrosive Mist Field
    #             if (pbTypeShort(attacker) == PBTypes::FLYING) && !pbIsPhysical?(pbTypeShort(attacker))
    #                 moddedtype = PBTypes::POISON
    #             end
    #         when 18 # Shortcircuit Field
    #             if (pbTypeShort(attacker) == PBTypes::STEEL) && attacker.ability == PBAbilities::STEELWORKER
    #                 moddedtype = PBTypes::ELECTRIC
    #             end
    #         when 25 # Crystal Cavern
    #             if (pbTypeShort(attacker) == PBTypes::ROCK) || (@id == PBMoves::JUDGMENT || @id == PBMoves::ROCKCLIMB || 
    #                 @id == PBMoves::STRENGTH || @id == PBMoves::MULTIATTACK || @id == PBMoves::PRISMATICLASER)
    #         #moddedtype = getRoll(update_roll: caller_locations.any? {|string| string.to_s.include?("pbCalcDamage")} && !return_type) # ToDo
    #             end
    #         when 36 # Inverse Field
    #             if !return_type
    #                 if typemod == 0
    #                     typevar1 = PBTypes.oneTypeEff(@type,opponent.type1)
    #                     typevar2 = PBTypes.oneTypeEff(@type,opponent.type2)
    #                     typevar1 = 1 if typevar1==0
    #                     typevar2 = 1 if typevar2==0
    #                     typemod = typevar1 * typevar2
    #                 end
    #                 typemod = 16 / typemod
    #                 #inverse field can (and should) just skip the rest
    #                 return typemod if !return_type
    #             end
    #     end

    #     if !moddedtype
    #         typefieldmoves = $fieldTypeMods[$fefieldeffect]
    #         if typefieldmoves
    #             typefieldmoves.each do |key, value|
    #                 if (value.include?(@id)) && !moddedtype
    #                     moddedtype = key
    #                 end
    #             end
    #         end
    #     end
    #     if !moddedtype #if moddedtype is STILL nil
    #         currenttype = pbTypeShort(attacker)
    #         typefieldtype = $fieldTypeAddOns[$fefieldeffect]
    #         if typefieldtype
    #             typefieldtype.each do |key, value|
    #                 if (value.include?(currenttype)) && !moddedtype
    #                     moddedtype = key
    #                 end
    #             end
    #         end
    #     end
    #     if return_type
    #         return moddedtype ? moddedtype : nil
    #     else
    #         return typemod if !moddedtype
    #         newtypemod = pbTypeModifier(moddedtype,attacker,opponent)
    #         typemod = ((typemod*newtypemod) * 0.25).ceil
    #         return typemod
    #     end
    # end

    def overlayTypeChange(attacker,opponent,typemod,return_type=false)
        #ToDo: convert function
        return 0
    end

    def getSecondaryType(attacker)
        secondtype = []
        secondtype.push(PBTypes::FLYING) if [PBMoves::FLYINGPRESS].include?(@id)
        fieldtype = FieldTypeChange(attacker,attacker.pbOppositeOpposing,1,true)
        secondtype.push(fieldtype) if fieldtype
        overlaytype = overlayTypeChange(attacker,nil,1,true)
        secondtype.push(overlaytype) if overlaytype
        secondtype = [secondtype[0],secondtype[1]] if secondtype.length>2
        return secondtype.empty? ? nil : secondtype
    end
end

# For Realignment
class PokemonDataBox
    alias orig_PokemonDataBox_initialize initialize

    def initialize(battler,doublebattle,viewport=nil)
        orig_PokemonDataBox_initialize(battler,doublebattle,viewport)
        @spritebaseY=0
    end

    def refresh
        self.bitmap.clear
        return if !@battler.pokemon
        bIsFoe = ((@battler.index == 1) || (@battler.index == 3))
        filename = "Graphics/Pictures/Battle/battle" 
        if @doublebattle  
            case @battler.index % 2 
                when 0  
                    filename += "PlayerBoxD"  
                when 1  
                    filename += "FoeBoxD"  
            end       
        else  
            case @battler.index 
                when 0  
                    filename += "PlayerBoxS"  
                when 1  
                    filename += "FoeBoxS" 
            end 
        end
        filename += battlerStatus(@battler)
        @databox=AnimatedBitmap.new(filename)
        self.bitmap.blt(0,0,@databox.bitmap,Rect.new(0,0,@databox.width,@databox.height))

        if @doublebattle  
            @hpbar = AnimatedBitmap.new("Graphics/Pictures/Battle/hpbardoubles")
            hpbarconstant=PokeBattle_SceneConstants::HPGAUGEHEIGHTD
        else
            @hpbar = AnimatedBitmap.new("Graphics/Pictures/Battle/hpbar")
            hpbarconstant=PokeBattle_SceneConstants::HPGAUGEHEIGHTS
        end
        base=PokeBattle_SceneConstants::BOXTEXTBASECOLOR
        shadow=PokeBattle_SceneConstants::BOXTEXTSHADOWCOLOR
        headerY = @spritebaseY+18
        sbX = @spritebaseX 
        if bIsFoe
            headerY += 4
            sbX -= 12
        end
        if @doublebattle
            headerY -= 12
            sbX += 6

            if bIsFoe
                headerY -= 4
                sbX += 2
            end
        end

        # Pokemon Name
        pokename=@battler.name
        pbSetSystemFont(self.bitmap)
        textpos=[
            [pokename,sbX+8,headerY,false,base,shadow]
        ]
        genderX=self.bitmap.text_size(pokename).width
        genderX+=sbX+14
        if genderX > 165 && !@doublebattle && (@battler.index&1)==1 #opposing pokemon
            genderX = 224
        end
        gendertarget = @battler.effects[PBEffects::Illusion] ? @battler.effects[PBEffects::Illusion] : @battler
        if gendertarget.gender==0 # Male
            textpos.push([_INTL("♂"),genderX,headerY,false,Color.new(48,96,216),shadow])
        elsif gendertarget.gender==1 # Female
            textpos.push([_INTL("♀"),genderX,headerY,false,Color.new(248,88,40),shadow])
        end
        pbDrawTextPositions(self.bitmap,textpos)
        pbSetSmallFont(self.bitmap)
        
        # Level
        hpShiftX = 202
        if bIsFoe
            hpShiftX -= 4
        end
        textpos=[[_INTL("Lv{1}",@battler.level),sbX+hpShiftX,headerY,true,base,shadow]]

        # HP Numbers
        if @showhp
            hpstring=_ISPRINTF("{1: 2d}/{2: 2d}",self.hp,@battler.totalhp)
            textpos.push([hpstring,sbX+202,@spritebaseY+78,true,base,shadow])
        end
        pbDrawTextPositions(self.bitmap,textpos)

        # Shiny
        imagepos=[]
        if (@battler.pokemon.isShiny? && @battler.effects[PBEffects::Illusion].nil?) || (!@battler.effects[PBEffects::Illusion].nil? && @battler.effects[PBEffects::Illusion].isShiny?)
            shinyX=202
            shinyX=-16 if (@battler.index&1)==0 # If player's Pokémon
            shinyY=24
            shinyY=12 if @doublebattle
            imagepos.push(["Graphics/Pictures/shiny.png",sbX+shinyX,@spritebaseY+shinyY,0,0,-1,-1])
        end

        # Mega
        megaY=52
        megaY-=4 if (@battler.index&1)==0 # If player's Pokémon
        megaY=32 if @doublebattle
        megaX=215
        megaX=-27 if (@battler.index&1)==0 # If player's Pokémon
        if @battler.isMega?
            imagepos.push(["Graphics/Pictures/Battle/battleMegaEvoBox.png",sbX+megaX,@spritebaseY+megaY,0,0,-1,-1])
        end

        # Owned
        if @battler.owned && (@battler.index&1)==1
            if @doublebattle  
                imagepos.push(["Graphics/Pictures/Battle/battleBoxOwned.png",sbX-12,4,0,0,-1,-1]) if (@battler.index)==3
                imagepos.push(["Graphics/Pictures/Battle/battleBoxOwned.png",sbX-18,4,0,0,-1,-1]) if (@battler.index)==1
            else  
                imagepos.push(["Graphics/Pictures/Battle/battleBoxOwned.png",sbX-12,20,0,0,-1,-1])  
            end 
        end
        pbDrawImagePositions(self.bitmap,imagepos)

        # HP Gauge
        hpGaugeSize=PokeBattle_SceneConstants::HPGAUGESIZE
        hpgauge=@battler.totalhp==0 ? 0 : (self.hp*hpGaugeSize/@battler.totalhp)
        hpgauge=2 if hpgauge==0 && self.hp>0
        hpzone=0
        hpzone=1 if self.hp<=(@battler.totalhp/2.0).floor
        hpzone=2 if self.hp<=(@battler.totalhp/4.0).floor
        hpcolors=[
            PokeBattle_SceneConstants::HPCOLORGREENDARK,
            PokeBattle_SceneConstants::HPCOLORGREEN,
            PokeBattle_SceneConstants::HPCOLORYELLOWDARK,
            PokeBattle_SceneConstants::HPCOLORYELLOW,
            PokeBattle_SceneConstants::HPCOLORREDDARK,
            PokeBattle_SceneConstants::HPCOLORRED
        ]
        # fill with black (shows what the HP used to be)
        hpGaugeX=PokeBattle_SceneConstants::HPGAUGE_X
        hpGaugeY=PokeBattle_SceneConstants::HPGAUGE_Y
        if @animatingHP && self.hp>0
            self.bitmap.fill_rect(@spritebaseX+hpGaugeX,hpGaugeY,@starthp*hpGaugeSize/@battler.totalhp,6,Color.new(0,0,0))
        end
        hpGaugeLowerY = 14
        hpThiccness = 16
        if bIsFoe
            hpGaugeX += 8
            hpGaugeY += 4
        end
        if @doublebattle
            hpGaugeY -= 12
            hpGaugeLowerY = 10
            hpThiccness = 12

            if bIsFoe
                hpGaugeY -= 4
            end
        end
        self.bitmap.blt(sbX+hpGaugeX,@spritebaseY+hpGaugeY,@hpbar.bitmap,Rect.new(0,(hpzone)*hpbarconstant,hpgauge,hpbarconstant))

        # self.bitmap.fill_rect(sbX+hpGaugeX,hpGaugeY,hpgauge,hpThiccness,hpcolors[hpzone*2+1])
        # self.bitmap.fill_rect(sbX+hpGaugeX,hpGaugeY,hpgauge,2,hpcolors[hpzone*2])
        # self.bitmap.fill_rect(sbX+hpGaugeX,hpGaugeY+hpGaugeLowerY,hpgauge,2,hpcolors[hpzone*2])

        # Status
        if !@battler.status.nil?
            imagepos=[]
            doubles = "D"
            if @doublebattle
                if bIsFoe
                    if @battler.issossmon && !(@battler.index == 2)
                        imagepos.push([sprintf("Graphics/Pictures/Battle/battleStatuses"+ doubles + "%s",@battler.status),@spritebaseX-6,@spritebaseY+26,0,0,64,28])
                    else
                        imagepos.push([sprintf("Graphics/Pictures/Battle/battleStatuses"+ doubles + "%s",@battler.status),@spritebaseX+8,@spritebaseY+36,0,0,64,28])
                    end
                else
                    imagepos.push([sprintf("Graphics/Pictures/Battle/battleStatuses"+ doubles + "%s",@battler.status),@spritebaseX+10,@spritebaseY+36,0,0,64,28])
                end
            elsif bIsFoe
                imagepos.push([sprintf("Graphics/Pictures/Battle/battleStatuses%s",@battler.status),@spritebaseX,@spritebaseY+54,0,0,64,28])
            else
                imagepos.push([sprintf("Graphics/Pictures/Battle/battleStatuses%s",@battler.status),@spritebaseX+4,@spritebaseY+50,0,0,64,28])
            end
            pbDrawImagePositions(self.bitmap,imagepos)
        end

        # EXP
        if @showexp
            # fill with EXP color
            expGaugeX=PokeBattle_SceneConstants::EXPGAUGE_X
            expGaugeY=PokeBattle_SceneConstants::EXPGAUGE_Y
            self.bitmap.fill_rect(@spritebaseX+expGaugeX,expGaugeY,self.exp,2,PokeBattle_SceneConstants::EXPCOLORSHADOW)
            self.bitmap.fill_rect(@spritebaseX+expGaugeX,expGaugeY+2,self.exp,2,PokeBattle_SceneConstants::EXPCOLORBASE)
        end
    end

    def battlerStatus(battler)
        case battler.status
            when PBStatuses::SLEEP  
                return "SLP"  
            when PBStatuses::FROZEN
                return "FRZ"  
            when PBStatuses::BURN 
                return "BRN"  
            when PBStatuses::POISON 
                return "PSN"  
            when PBStatuses::PARALYSIS  
                return "PAR" 
        end 
        return ""
    end
end