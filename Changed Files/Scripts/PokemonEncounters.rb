module EncounterTypes
  Land         = 0
  Cave         = 1
  Water        = 2
  RockSmash    = 3
  OldRod       = 4
  GoodRod      = 5
  SuperRod     = 6
  HeadbuttLow  = 7
  HeadbuttHigh = 8
  LandMorning  = 9
  LandDay      = 10
  LandNight    = 11
  BugContest   = 12
  Names=[
     "Land",
     "Cave",
     "Water",
     "RockSmash",
     "OldRod",
     "GoodRod",
     "SuperRod",
     "HeadbuttLow",
     "HeadbuttHigh",
     "LandMorning",
     "LandDay",
     "LandNight",
     "BugContest"
  ]
  EnctypeChances=[
     [20,20,10,10,10,10,5,5,4,4,1,1],
     [20,20,10,10,10,10,5,5,4,4,1,1],
     [60,30,5,4,1],
     [60,30,5,4,1],
     [70,30],
     [60,20,20],
     [40,40,15,4,1],
     [30,25,20,10,5,5,4,1],
     [30,25,20,10,5,5,4,1],
     [20,20,10,10,10,10,5,5,4,4,1,1],
     [20,20,10,10,10,10,5,5,4,4,1,1],
     [20,20,10,10,10,10,5,5,4,4,1,1],
     [20,20,10,10,10,10,5,5,4,4,1,1]
  ]
  EnctypeDensities=[25,10,10,0,0,0,0,0,0,25,25,25,25]
  EnctypeCompileDens=[1,2,3,0,0,0,0,0,0,1,1,1,1]
end



class PokemonEncounters
  def initialize
    @enctypes=[]
    @density=nil
  end

  def stepcount
    return @stepcount
  end

  def clearStepCount
    @stepcount=0
  end

  def hasEncounter?(enc)
    return false if @density==nil || enc<0
    return @enctypes[enc] ? true : false  
  end

  def isCave?
    return false if @density==nil
    return @enctypes[EncounterTypes::Cave] ? true : false
  end

  def isGrass?
    return false if @density==nil
    return (@enctypes[EncounterTypes::Land] ||
            @enctypes[EncounterTypes::LandMorning] ||
            @enctypes[EncounterTypes::LandDay] ||
            @enctypes[EncounterTypes::LandNight] ||
            @enctypes[EncounterTypes::BugContest]) ? true : false
  end

  def isRegularGrass?
    return false if @density==nil
    return (@enctypes[EncounterTypes::Land] ||
            @enctypes[EncounterTypes::LandMorning] ||
            @enctypes[EncounterTypes::LandDay] ||
            @enctypes[EncounterTypes::LandNight]) ? true : false
  end

  def isWater?
    return false if @density==nil
    return @enctypes[EncounterTypes::Water] ? true : false
  end

  def pbEncounterType
    if $PokemonGlobal && $PokemonGlobal.surfing
      return EncounterTypes::Water
    elsif self.isCave?
      return EncounterTypes::Cave
    elsif self.isGrass?
      time=pbGetTimeNow
      enctype=EncounterTypes::Land
      enctype=EncounterTypes::LandNight if self.hasEncounter?(EncounterTypes::LandNight) && PBDayNight.isNight?(time)
      enctype=EncounterTypes::LandDay if self.hasEncounter?(EncounterTypes::LandDay) && PBDayNight.isDay?(time)
      enctype=EncounterTypes::LandMorning if self.hasEncounter?(EncounterTypes::LandMorning) && PBDayNight.isMorning?(time)
      if pbInBugContest? && self.hasEncounter?(EncounterTypes::BugContest)
        enctype=EncounterTypes::BugContest
      end
      return enctype
    end
    return -1
  end

  def isEncounterPossibleHere?
    if $PokemonGlobal && $PokemonGlobal.surfing
      return true
    elsif pbGetTerrainTag($game_player)==PBTerrain::Ice
      return false
    elsif self.isCave?
      return true
    elsif self.isGrass?
      return pbIsGrassTag?($game_map.terrain_tag($game_player.x,$game_player.y))
    end
    return false
  end

  def setup(mapID)
    @density=nil
    @stepcount=0
    @enctypes=[]
    begin
      data=load_data("Data/encounters.dat")
      if data.is_a?(Hash) && data[mapID]
        @density=data[mapID][0]
        @enctypes=data[mapID][1]
      else
        @density=nil
        @enctypes=[]
      end
      rescue
      @density=nil
      @enctypes=[]
    end
  end

  def pbMapHasEncounter?(mapID,enctype)
    data=load_data("Data/encounters.dat")
    if data.is_a?(Hash) && data[mapID]
      enctypes=data[mapID][1]
      density=data[mapID][0]
    else
      return false
    end
    return false if density==nil || enctype<0
    return enctypes[enctype] ? true : false  
  end

  def pbMapEncounter(mapID,enctype)
    if enctype<0 || enctype>EncounterTypes::EnctypeChances.length
      raise ArgumentError.new(_INTL("Encounter type out of range"))
    end
    data=load_data("Data/encounters.dat")
    if data.is_a?(Hash) && data[mapID]
      enctypes=data[mapID][1]
    else
      return nil
    end
    return nil if enctypes[enctype]==nil
    chances=EncounterTypes::EnctypeChances[enctype]
    chancetotal=0
    chances.each {|a| chancetotal+=a}
    rnd=rand(chancetotal)
    chosenpkmn=0
    chance=0
    for i in 0...chances.length
      chance+=chances[i]
      if rnd<chance
        chosenpkmn=i
        break
      end
    end
    encounter=enctypes[enctype][chosenpkmn]
    level=encounter[1]+rand(1+encounter[2]-encounter[1])
    return [encounter[0],level]
  end

# UPDATE 11/18/2013
# the following functions were copied from PokeBattle_Pokemon and slightly
# modified to fit the needs for this problem.
# they are used to determine the type of possible pokemon encounters
def hasType?(species, type)
if type.is_a?(String) || type.is_a?(Symbol)
return isConst?(type1(species),PBTypes,type)||isConst?(type2(species),PBTypes,type)
else
return type1==type || type2==type
end
end
# Returns this Pokémon's first type.
def type1(species)
dexdata=pbOpenDexData
pbDexDataOffset(dexdata,species,8)
ret=dexdata.fgetb
dexdata.close
return ret
end

# Returns this Pokémon's second type.
def type2(species)
dexdata=pbOpenDexData
pbDexDataOffset(dexdata,species,9)
ret=dexdata.fgetb
dexdata.close
return ret
end

# adjusts the chances of finding a Pokemon of type by mult
# Note: This does NOT increase the find chance by mult (strictly speaking)
# Since a random number is created between 0 <= r < sum of chances
# Increasing these numbers will shift around the find rate of all of them.
def shiftChances(chances, enctype, type, mult)
for i in 0...chances.length
pkmn = @enctypes[enctype][i]
chances[i] *= mult if hasType?(pkmn[0], type)
chances[i] = 1 if chances[i] < 1
chances[i] = chances[i].to_i
end
return chances
end
# end of update
  
  def pbEncounteredPokemon(enctype,tries=1)
    if enctype<0 || enctype>EncounterTypes::EnctypeChances.length
      raise ArgumentError.new(_INTL("Encounter type out of range"))
    end
    return nil if @enctypes[enctype]==nil
chances=EncounterTypes::EnctypeChances[enctype]
# UPDATE 11/18/2013
# I assumed multiple abilities would change the encounter rate.
# (Apparently it's only Magnet Pull)
# But if more exist in the future, this will make it easy to add them
# First Pokemon has Magnet Pull
if !$Trainer.party[0].egg?
abl = $Trainer.party[0].ability
if isConst?(abl,PBAbilities,:MAGNETPULL)
chances = shiftChances(chances, enctype, :STEEL, 1.5)
end
end
# end of update
    chancetotal=0
    chances.each {|a| chancetotal+=a}
    rnd=0
    tries.times do
      r=rand(chancetotal)
      rnd=r if rnd<r
    end
    chosenpkmn=0
    chance=0
    for i in 0...chances.length
      chance+=chances[i]
      if rnd<chance
        chosenpkmn=i
        break
      end
    end
    encounter=@enctypes[enctype][chosenpkmn]
return nil if !encounter
# UPDATE 11/19/2013
# pressure, hustle and vital spirit will now have a 150% chance of
# finding higher leveled pokemon in encounters
if !$Trainer.party[0].egg?
abl = $Trainer.party[0].ability
if (isConst?(abl, PBAbilities, :PRESSURE) ||
isConst?(abl, PBAbilities, :HUSTLE) ||
isConst?(abl, PBAbilities, :VITALSPIRIT)) &&
rand(2) == 0
# increase the lower bound to half way in-between lower and upper
encounter[1] += (encounter[2] - encounter[1]) / 2
end
end
# end of update
    level=encounter[1]+rand(1+encounter[2]-encounter[1])
    return [encounter[0],level]
  end

  def pbCanEncounter?(encounter,repel)
    return false if $game_system.encounter_disabled
    return false if !encounter || !$Trainer
    return false if $DEBUG && Input.press?(Input::CTRL)
    if !pbPokeRadarOnShakingGrass
      return false if $PokemonGlobal.repel>0 && $Trainer.ablePokemonCount>0 &&
                      encounter[1]<$Trainer.ablePokemonParty[0].level
    end
    return true
  end

  def pbGenerateEncounter(enctype)
    if enctype<0 || enctype>EncounterTypes::EnctypeChances.length
      raise ArgumentError.new(_INTL("Encounter type out of range"))
    end
    return nil if @density==nil
    return nil if @density[enctype]==0 || !@density[enctype]
    return nil if @enctypes[enctype]==nil
    @stepcount+=1
    return nil if @stepcount<=3 # Check three steps after battle ends
    encount=@density[enctype]*16
    if $PokemonGlobal.bicycle
      encount=(encount*4/5)
    end
    if $PokemonMap.blackFluteUsed
      encount/=2
    end
    if $PokemonMap.whiteFluteUsed
      encount=(encount*3/2)
    end
    if $Trainer.party.length>0 && !$Trainer.party[0].isEgg?
      if isConst?($Trainer.party[0].item,PBItems,:CLEANSETAG)
        encount=(encount*2/3)
      elsif isConst?($Trainer.party[0].item,PBItems,:PUREINCENSE)
        encount=(encount*2/3)
      else   # Ignore ability effects if an item effect applies
        if isConst?($Trainer.party[0].ability,PBAbilities,:STENCH)
          encount=(encount/2)
        elsif isConst?($Trainer.party[0].ability,PBAbilities,:WHITESMOKE)
          encount=(encount/2)
        elsif isConst?($Trainer.party[0].ability,PBAbilities,:QUICKFEET)
          encount=(encount/2)
        elsif isConst?($Trainer.party[0].ability,PBAbilities,:SNOWCLOAK) &&
           $game_screen.weather_type==3
          encount=(encount/2)
        elsif isConst?($Trainer.party[0].ability,PBAbilities,:SANDVEIL) &&
           $game_screen.weather_type==4
          encount=(encount/2)
        elsif isConst?($Trainer.party[0].ability,PBAbilities,:SWARM)
          encount=(encount*3/2)
        elsif isConst?($Trainer.party[0].ability,PBAbilities,:ILLUMINATE)
          encount=(encount*2)
        elsif isConst?($Trainer.party[0].ability,PBAbilities,:ARENATRAP)
          encount=(encount*2)
        elsif isConst?($Trainer.party[0].ability,PBAbilities,:NOGUARD)
          encount=(encount*2)
        end
      end
    end
    return nil if rand(180*16)>=encount
    encpoke=pbEncounteredPokemon(enctype)
    if $Trainer.party.length>0 && !$Trainer.party[0].isEgg?
      if encpoke && isConst?($Trainer.party[0].ability,PBAbilities,:INTIMIDATE) &&
         encpoke[1]<=$Trainer.party[0].level-5 && rand(2)==0
        encpoke=nil
      end
      if encpoke && isConst?($Trainer.party[0].ability,PBAbilities,:KEENEYE) &&
         encpoke[1]<=$Trainer.party[0].level-5 && rand(2)==0
        encpoke=nil
      end
    end
    return encpoke
  end
end