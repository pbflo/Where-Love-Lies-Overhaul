################################################################################
# This section was created solely for you to put various bits of code that
# modify various wild Pokémon and trainers immediately prior to battling them.
# Be sure that any code you use here ONLY applies to the Pokémon/trainers you
# want it to apply to!
################################################################################

# Make all wild Pokémon shiny while a certain Switch is ON (see Settings).
Events.onWildPokemonCreate+=proc {|sender,e|
   pokemon=e[0]
   if $game_switches[SHINY_WILD_POKEMON_SWITCH]
     pokemon.makeShiny
   end
}

# Used in the random dungeon map.  Makes the levels of all wild Pokémon in that
# map depend on the levels of Pokémon in the player's party.
# This is a simple method, and can/should be modified to account for evolutions
# and other such details.  Of course, you don't HAVE to use this code.
Events.onWildPokemonCreate+=proc {|sender,e|
   pokemon=e[0]
   if $game_map.map_id==51
     pokemon.level=pbBalancedLevel($Trainer.party) - 4 + rand(5)   # For variety
     pokemon.calcStats
     pokemon.resetMoves
   end
}

# This is the basis of a trainer modifier.  It works both for trainers loaded
# when you battle them, and for partner trainers when they are registered.
# Note that you can only modify a partner trainer's Pokémon, and not the trainer
# themselves nor their items this way, as those are generated from scratch
# before each battle.
#Events.onTrainerPartyLoad+=proc {|sender,e|
#   if e[0] # Trainer data should exist to be loaded, but may not exist somehow
#     trainer=e[0][0] # A PokeBattle_Trainer object of the loaded trainer
#     items=e[0][1]   # An array of the trainer's items they can use
#     party=e[0][2]   # An array of the trainer's Pokémon
#     YOUR CODE HERE
#   end
#}

# UPDATE 11/19/2013
# Cute Charm now gives a 2/3 chance of being opposite gender
Events.onWildPokemonCreate+=proc {|sender,e|
  pokemon=e[0]
  if !$Trainer.party[0].egg?
    ourpkmn = $Trainer.party[0]
    abl = ourpkmn.ability
    if isConst?(abl, PBAbilities, :CUTECHARM) && rand(3) < 2
      pokemon.setGender(ourpkmn.gender == 0 ? 1 : 0)
    end
  end
}
# UPDATE 11/19/2013
# sync will now give a 50% chance of encountered pokemon having
# the same nature as the party leader
Events.onWildPokemonCreate+=proc {|sender,e|
  pokemon=e[0]
  if !$Trainer.party[0].egg?
    ours = $Trainer.party[0]
    if isConst?(ours.ability, PBAbilities, :SYNCHRONIZE) && rand(2) == 0
      pokemon.setNature(ours.nature)
    end
  end
}
#Regional Variants + Other things with multiple movesets (Wormadam, Meowstic, etc)
Events.onWildPokemonCreate+=proc {|sender,e|
  pokemon=e[0]
    v=MultipleForms.call("getMoveList",pokemon)
    if v!=nil
      moves = v
    else      
      moves = pokemon.getMoveList
    end
    movelist=[]
    for i in moves
      if i[0]<=pokemon.level
        movelist[movelist.length]=i[1]
      end
    end
    movelist|=[] # Remove duplicates
    listend=movelist.length-4
    listend=0 if listend<0
    j=0
    for i in listend...listend+4
      moveid=(i>=movelist.length) ? 0 : movelist[i]
      pokemon.moves[j]=PBMove.new(moveid)
      j+=1
    end    
}
# Egg moves for wild events
Events.onWildPokemonCreate+=proc {|sender,e|
  pokemon=e[0]
  case $game_variables[999]
    when 1 # UNUSED
      pokemon.pbLearnMove(:SUCKERPUNCH) # CHANGE
    when 2
      pokemon.pbLearnMove(:THUNDERFANG) # CHANGE
    when 3 
      pokemon.pbLearnMove(:NASTYPLOT) # CHANGE
    when 4 # Zangoose
      pokemon.pbLearnMove(:NIGHTSLASH)
    when 5 # Hoppip
      pokemon.pbLearnMove(:GRASSYTERRAIN)
    when 6
      pokemon.pbLearnMove(:ENCORE)
    when 7 
      pokemon.pbLearnMove(:AROMATHERAPY)
    when 8 # Pichu
      pokemon.pbLearnMove(:ENCORE)
    when 9 
      pokemon.pbLearnMove(:FAKEOUT)
    when 10
      pokemon.pbLearnMove(:WISH)
    when 11
      pokemon.pbLearnMove(:VOLTTACKLE)
    when 12 # Zorua
      pokemon.pbLearnMove(:EXTRASENSORY)
    when 13 # Emolga
      pokemon.pbLearnMove(:IONDELUGE)
    when 14
      pokemon.pbLearnMove(:AIRSLASH)
    when 15
      pokemon.pbLearnMove(:ROOST)
    when 16 # Murkrow
      pokemon.pbLearnMove(:BRAVEBIRD)
    when 17
      pokemon.pbLearnMove(:PERISHSONG)
    when 18 # Tropius
      pokemon.pbLearnMove(:LEECHSEED)
    when 19
      pokemon.pbLearnMove(:DRAGONDANCE)
    when 20
      pokemon.pbLearnMove(:LEAFBLADE)
    when 21 # UNUSED
      pokemon.pbLearnMove(:STEALTHROCK) # CHANGE
    when 22
      pokemon.pbLearnMove(:SIGNALBEAM) # CHANGE
    when 23 # Elgyem
      pokemon.pbLearnMove(:COSMICPOWER)
    when 24
      pokemon.pbLearnMove(:NASTYPLOT)
    when 25 # Pumpkaboo
      pokemon.pbLearnMove(:DESTINYBOND)
    when 26 # Shuppet
      pokemon.pbLearnMove(:CONFUSERAY)
    when 27
      pokemon.pbLearnMove(:GUNKSHOT)
    when 28
      pokemon.pbLearnMove(:PURSUIT)
    when 29 # Drifloon
      pokemon.pbLearnMove(:DESTINYBOND)
    when 30
      pokemon.pbLearnMove(:TAILWIND)
    when 31
      pokemon.pbLearnMove(:WEATHERBALL)
    when 32 # Joltik
      pokemon.pbLearnMove(:CROSSPOISON)
    when 33 # Torkoal
      pokemon.pbLearnMove(:SUPERPOWER)
    when 34
      pokemon.pbLearnMove(:YAWN)
    when 35
      pokemon.pbLearnMove(:ERUPTION)
    when 36 # Heatmor
      pokemon.pbLearnMove(:SUCKERPUNCH)
    when 37
      pokemon.pbLearnMove(:HEATWAVE)
    when 38
      pokemon.pbLearnMove(:NIGHTSLASH)
    when 39 # Tepig
      pokemon.pbLearnMove(:HEAVYSLAM)
    when 40
      pokemon.pbLearnMove(:BODYSLAM)
    when 41
      pokemon.pbLearnMove(:SUCKERPUNCH)
    when 42
      pokemon.pbLearnMove(:SUPERPOWER)
    when 43
      pokemon.pbLearnMove(:MAGNITUDE)
    when 44 # Squirtle
      pokemon.pbLearnMove(:MIRRORCOAT)
    when 45
      pokemon.pbLearnMove(:DRAGONPULSE)
    when 46
      pokemon.pbLearnMove(:AURASPHERE)
    when 47
      pokemon.pbLearnMove(:WATERSPOUT)
    when 48 # Spiritomb
      pokemon.pbLearnMove(:FOULPLAY)
    when 49
      pokemon.pbLearnMove(:SHADOWSNEAK)
    when 50
      pokemon.pbLearnMove(:DESTINYBOND)
    when 51
      pokemon.pbLearnMove(:PAINSPLIT)
    when 52 # Seviper
      pokemon.pbLearnMove(:STOCKPILE)
    when 53
      pokemon.pbLearnMove(:BODYSLAM)
    when 54
      pokemon.pbLearnMove(:FINALGAMBIT)
    when 55 # Lapras
      pokemon.pbLearnMove(:CURSE)
    when 56
      pokemon.pbLearnMove(:DRAGONDANCE)
    when 57
      pokemon.pbLearnMove(:FREEZEDRY)
    when 58 # Snesasel
      pokemon.pbLearnMove(:PURSUIT)
    when 59
      pokemon.pbLearnMove(:ICICLECRASH)
    when 60
      pokemon.pbLearnMove(:FAKEOUT)
    when 61 # Totodile
      pokemon.pbLearnMove(:AQUAJET)
    when 62
      pokemon.pbLearnMove(:DRAGONDANCE)
    when 63
      pokemon.pbLearnMove(:ICEPUNCH)
    when 64 # Skuntank
      pokemon.pbLearnMove(:FLAMETHROWER)
      pokemon.pbLearnMove(:ACIDSPRAY)
      pokemon.pbLearnMove(:PLAYROUGH)
      pokemon.pbLearnMove(:NIGHTSLASH)
      pokemon.ot="Corey"
      pokemon.trainerID=32574
    when 65
      pokemon.pbLearnMove(:FLAMEBURST)
      pokemon.pbLearnMove(:ACIDSPRAY)
      pokemon.pbLearnMove(:PURSUIT)
      pokemon.pbLearnMove(:NIGHTSLASH)
      pokemon.ot="Corey"
      pokemon.trainerID=32574
    when 66
      pokemon.pbLearnMove(:FLAMETHROWER)
      pokemon.pbLearnMove(:ACIDSPRAY)
      pokemon.pbLearnMove(:PURSUIT)
      pokemon.pbLearnMove(:FOULPLAY)
      pokemon.ot="Corey"
      pokemon.trainerID=32574
    when 67 # Rotom
      pokemon.ot="Shade"
      pokemon.trainerID=$Trainer.getForeignID
    when 68 # Larvitar
      pokemon.pbLearnMove(:DRAGONDANCE)
    when 69
      pokemon.pbLearnMove(:CURSE)
    when 70 
      pokemon.pbLearnMove(:IRONHEAD)
    when 71 
      pokemon.pbLearnMove(:OUTRAGE)
    when 72 
      pokemon.pbLearnMove(:STEALTHROCK)
    when 73 # Absol
      pokemon.pbLearnMove(:PLAYROUGH)
      pokemon.pbLearnMove(:MEGAHORN)
      pokemon.pbLearnMove(:SUCKERPUNCH)
      pokemon.pbLearnMove(:SWORDDANCE)
      pokemon.ot="Ame"
      pokemon.trainerID=$Trainer.getForeignID
  end
}