class PokeBattle_Pokemon
  def form
    v=MultipleForms.call("getForm",self)
    if v!=nil
      self.form=v if !@form || v!=@form
      return v
    end
    return @form || 0
  end

  def form=(value)
    @form=value
    self.calcStats
    MultipleForms.call("onSetForm",self,value)
  end

  def hasMegaForm?
    v=MultipleForms.call("getMegaForm",self)
    return v!=nil
  end
  
  def hasZMove?
    canuse=false
    pkmn=self
    case pkmn.item
    when getID(PBItems,:NORMALIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==0
          canuse=true
        end
      end   
    when getID(PBItems,:FIGHTINIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==1
          canuse=true
        end
      end     
    when getID(PBItems,:FLYINIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==2
          canuse=true
        end
      end   
    when getID(PBItems,:POISONIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==3
          canuse=true
        end
      end           
    when getID(PBItems,:GROUNDIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==4
          canuse=true
        end
      end    
    when getID(PBItems,:ROCKIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==5
          canuse=true
        end
      end           
    when getID(PBItems,:BUGINIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==6
          canuse=true
        end
      end  
    when getID(PBItems,:GHOSTIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==7
          canuse=true
        end
      end           
    when getID(PBItems,:STEELIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==8
          canuse=true
        end
      end           
    when getID(PBItems,:FIRIUMZ)
      canuse=false
      for move in pkmn.moves
        if move.type==10
          canuse=true
        end
      end       
    when getID(PBItems,:WATERIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==11
          canuse=true
        end
      end           
    when getID(PBItems,:GRASSIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==12
          canuse=true
        end
      end               
    when getID(PBItems,:ELECTRIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==13
          canuse=true
        end
      end          
    when getID(PBItems,:PSYCHIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==14
          canuse=true
        end
      end   
    when getID(PBItems,:ICIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==15
          canuse=true
        end
      end               
    when getID(PBItems,:DRAGONIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==16
          canuse=true
        end
      end               
    when getID(PBItems,:DARKINIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==17
          canuse=true
        end
      end           
    when getID(PBItems,:FAIRIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.type==18
          canuse=true
        end
      end                     
    when getID(PBItems,:ALORAICHIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.id==getID(PBMoves,:THUNDERBOLT)
          canuse=true
        end
      end
      if pkmn.species!=26 || pkmn.form!=1
        canuse=false
      end 
    when getID(PBItems,:DECIDIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.id==getID(PBMoves,:SPIRITSHACKLE)
          canuse=true
        end
      end
      if pkmn.species!=724
        canuse=false
      end          
    when getID(PBItems,:INCINIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.id==getID(PBMoves,:DARKESTLARIAT)
          canuse=true
        end
      end
      if pkmn.species!=727
        canuse=false
      end           
    when getID(PBItems,:PRIMARIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.id==getID(PBMoves,:SPARKLINGARIA)
          canuse=true
        end
      end
      if pkmn.species!=724
        canuse=false
      end  
    when getID(PBItems,:EEVIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.id==getID(PBMoves,:LASTRESORT)
          canuse=true
        end
      end
      if pkmn.species!=133
        canuse=false
      end           
    when getID(PBItems,:PIKANIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.id==getID(PBMoves,:VOLTTACKLE)
          canuse=true
        end
      end
      if pkmn.species!=25
        canuse=false
      end    
    when getID(PBItems,:SNORLIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.id==getID(PBMoves,:GIGAIMPACT)
          canuse=true
        end
      end
      if pkmn.species!=143
        canuse=false
      end      
    when getID(PBItems,:MEWNIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.id==getID(PBMoves,:PSYCHIC)
          canuse=true
        end
      end
      if pkmn.species!=151
        canuse=false
      end   
    when getID(PBItems,:TAPUNIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.id==getID(PBMoves,:NATURESMADNESS)
          canuse=true
        end
      end
      if !(pokemon.species==785 || pokemon.species==786 || pokemon.species==787 || pokemon.species==788)
        canuse=false
      end   
    when getID(PBItems,:MARSHADIUMZ)
      canuse=false   
      for move in pkmn.moves
        if move.id==getID(PBMoves,:SPECTRALTHIEF)
          canuse=true
        end
      end  
    end
    return canuse
  end  

  def isMega?
    v=MultipleForms.call("getMegaForm",self)
    return v!=nil && v==@form
  end

  def makeMega
    v=MultipleForms.call("getMegaForm",self)
    self.form=v if v!=nil
  end

  def makeUnmega
    v=MultipleForms.call("getUnmegaForm",self)
    self.form=v if v!=nil
  end

  def megaName
    v=MultipleForms.call("getMegaName",self)
    return v if v!=nil
    return ""
  end

  alias __mf_baseStats baseStats
  alias __mf_ability ability
  alias __mf_type1 type1
  alias __mf_type2 type2
  alias __mf_height height
  alias __mf_weight weight
  alias __mf_getMoveList getMoveList
  alias __mf_isCompatibleWithMove? isCompatibleWithMove?
  alias __mf_wildHoldItems wildHoldItems
  alias __mf_baseExp baseExp
  alias __mf_evYield evYield
  alias __mf_initialize initialize

  def baseStats
    v=MultipleForms.call("getBaseStats",self)
    return v if v!=nil
    return self.__mf_baseStats
  end

  def ability
    v=MultipleForms.call("ability",self)
    return v if v!=nil
    return self.__mf_ability
  end

  def type1
    v=MultipleForms.call("type1",self)
    return v if v!=nil
    return self.__mf_type1
  end

  def type2
    v=MultipleForms.call("type2",self)
    return v if v!=nil
    return self.__mf_type2
  end

  def height
    v=MultipleForms.call("height",self)
    return v if v!=nil
    return self.__mf_height
  end
  
  def weight
    v=MultipleForms.call("weight",self)
    return v if v!=nil
    return self.__mf_weight
  end

  def getMoveList
    v=MultipleForms.call("getMoveList",self)
    return v if v!=nil
    return self.__mf_getMoveList
  end
  
  def isCompatibleWithMove?(move)
    v=MultipleForms.call("getMoveCompatibility",self)
    if v!=nil
      return v.any? {|j| j==move }
    end
    return self.__mf_isCompatibleWithMove?(move)
  end

  def wildHoldItems
    v=MultipleForms.call("wildHoldItems",self)
    return v if v!=nil
    return self.__mf_wildHoldItems
  end

  def baseExp
    v=MultipleForms.call("baseExp",self)
    return v if v!=nil
    return self.__mf_baseExp
  end

  def evYield
    v=MultipleForms.call("evYield",self)
    return v if v!=nil
    return self.__mf_evYield
  end

  def initialize(*args)
    __mf_initialize(*args)
    f=MultipleForms.call("getFormOnCreation",self)
    if f
      self.form=f
      self.resetMoves
    end
  end
end



class PokeBattle_RealBattlePeer
  def pbOnEnteringBattle(battle,pokemon)
    f=MultipleForms.call("getFormOnEnteringBattle",pokemon)
    if f
      pokemon.form=f
    end
  end
end



module MultipleForms
  @@formSpecies=HandlerHash.new(:PBSpecies)

  def self.copy(sym,*syms)
    @@formSpecies.copy(sym,*syms)
  end

  def self.register(sym,hash)
    @@formSpecies.add(sym,hash)
  end

  def self.registerIf(cond,hash)
    @@formSpecies.addIf(cond,hash)
  end

  def self.hasFunction?(pokemon,func)
    spec=(pokemon.is_a?(Numeric)) ? pokemon : pokemon.species
    sp=@@formSpecies[spec]
    return sp && sp[func]
  end

  def self.getFunction(pokemon,func)
    spec=(pokemon.is_a?(Numeric)) ? pokemon : pokemon.species
    sp=@@formSpecies[spec]
    return (sp && sp[func]) ? sp[func] : nil
  end

  def self.call(func,pokemon,*args)
    sp=@@formSpecies[pokemon.species]
    return nil if !sp || !sp[func]
    return sp[func].call(pokemon,*args)
  end
  
  def self.call2(func,pokemon,*args)       #For when only given a species
    sp=@@formSpecies[pokemon.species]
    return nil if !sp || !sp[func]
    return sp[func].call(pokemon,*args)
  end  
end



def drawSpot(bitmap,spotpattern,x,y,red,green,blue)
  height=spotpattern.length
  width=spotpattern[0].length
  for yy in 0...height
    spot=spotpattern[yy]
    for xx in 0...width
      if spot[xx]==1
        xOrg=(x+xx)<<1
        yOrg=(y+yy)<<1
        color=bitmap.get_pixel(xOrg,yOrg)
        r=color.red+red
        g=color.green+green
        b=color.blue+blue
        color.red=[[r,0].max,255].min
        color.green=[[g,0].max,255].min
        color.blue=[[b,0].max,255].min
        bitmap.set_pixel(xOrg,yOrg,color)
        bitmap.set_pixel(xOrg+1,yOrg,color)
        bitmap.set_pixel(xOrg,yOrg+1,color)
        bitmap.set_pixel(xOrg+1,yOrg+1,color)
      end   
    end
  end
end

def pbSpindaSpots(pokemon,bitmap)
  spot1=[
     [0,0,1,1,1,1,0,0],
     [0,1,1,1,1,1,1,0],
     [1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1],
     [0,1,1,1,1,1,1,0],
     [0,0,1,1,1,1,0,0]
  ]
  spot2=[
     [0,0,1,1,1,0,0],
     [0,1,1,1,1,1,0],
     [1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1],
     [0,1,1,1,1,1,0],
     [0,0,1,1,1,0,0]
  ]
  spot3=[
     [0,0,0,0,0,1,1,1,1,0,0,0,0],
     [0,0,0,1,1,1,1,1,1,1,0,0,0],
     [0,0,1,1,1,1,1,1,1,1,1,0,0],
     [0,1,1,1,1,1,1,1,1,1,1,1,0],
     [0,1,1,1,1,1,1,1,1,1,1,1,0],
     [1,1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,1,1],
     [0,1,1,1,1,1,1,1,1,1,1,1,0],
     [0,1,1,1,1,1,1,1,1,1,1,1,0],
     [0,0,1,1,1,1,1,1,1,1,1,0,0],
     [0,0,0,1,1,1,1,1,1,1,0,0,0],
     [0,0,0,0,0,1,1,1,0,0,0,0,0]
  ]
  spot4=[
     [0,0,0,0,1,1,1,0,0,0,0,0],
     [0,0,1,1,1,1,1,1,1,0,0,0],
     [0,1,1,1,1,1,1,1,1,1,0,0],
     [0,1,1,1,1,1,1,1,1,1,1,0],
     [1,1,1,1,1,1,1,1,1,1,1,0],
     [1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,0],
     [0,1,1,1,1,1,1,1,1,1,1,0],
     [0,0,1,1,1,1,1,1,1,1,0,0],
     [0,0,0,0,1,1,1,1,1,0,0,0]
  ]
  id=pokemon.personalID
  h=(id>>28)&15
  g=(id>>24)&15
  f=(id>>20)&15
  e=(id>>16)&15
  d=(id>>12)&15
  c=(id>>8)&15
  b=(id>>4)&15
  a=(id)&15
  if pokemon.isShiny?
    drawSpot(bitmap,spot1,b+33,a+25,-120,-120,-20)
    drawSpot(bitmap,spot2,d+21,c+24,-120,-120,-20)
    drawSpot(bitmap,spot3,f+39,e+7,-120,-120,-20)
    drawSpot(bitmap,spot4,h+15,g+6,-120,-120,-20)
  else
    drawSpot(bitmap,spot1,b+33,a+25,0,-115,-75)
    drawSpot(bitmap,spot2,d+21,c+24,0,-115,-75)
    drawSpot(bitmap,spot3,f+39,e+7,0,-115,-75)
    drawSpot(bitmap,spot4,h+15,g+6,0,-115,-75)
  end
end

MultipleForms.register(:UNOWN,{
"getFormOnCreation"=>proc{|pokemon|
   next rand(28)
}
})


MultipleForms.register(:FLABEBE,{
"getFormOnCreation"=>proc{|pokemon|
   next rand(5)
}
})
MultipleForms.register(:FLOETTE,{
"getFormOnCreation"=>proc{|pokemon|
   next rand(5)
}
})
MultipleForms.register(:FLORGES,{
"getFormOnCreation"=>proc{|pokemon|
   next rand(5)
}
})

MultipleForms.register(:SPINDA,{
"alterBitmap"=>proc{|pokemon,bitmap|
   pbSpindaSpots(pokemon,bitmap)
}
})

MultipleForms.register(:CASTFORM,{
"type1"=>proc{|pokemon|
   next if pokemon.form==0              # Normal Form
   case pokemon.form
     when 1; next getID(PBTypes,:FIRE)  # Sunny Form
     when 2; next getID(PBTypes,:WATER) # Rainy Form
     when 3; next getID(PBTypes,:ICE)   # Snowy Form
   end
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0              # Normal Form
   case pokemon.form
     when 1; next getID(PBTypes,:FIRE)  # Sunny Form
     when 2; next getID(PBTypes,:WATER) # Rainy Form
     when 3; next getID(PBTypes,:ICE)   # Snowy Form
   end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:DEOXYS,{
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0                 # Normal Forme
   case pokemon.form
     when 1; next [50,180, 20,150,180, 20] # Attack Forme
     when 2; next [50, 70,160, 90, 70,160] # Defense Forme
     when 3; next [50, 95, 90,180, 95, 90] # Speed Forme
   end
},
"evYield"=>proc{|pokemon|
   next if pokemon.form==0      # Normal Forme
   case pokemon.form
     when 1; next [0,2,0,0,1,0] # Attack Forme
     when 2; next [0,0,2,0,0,1] # Defense Forme
     when 3; next [0,0,0,3,0,0] # Speed Forme
   end
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
     when 1 ; movelist=[[1,:LEER],[1,:WRAP],[7,:NIGHTSHADE],[13,:TELEPORT],
                        [19,:TAUNT],[25,:PURSUIT],[31,:PSYCHIC],[37,:SUPERPOWER],
                        [43,:PSYCHOSHIFT],[49,:ZENHEADBUTT],[55,:COSMICPOWER],
                        [61,:ZAPCANNON],[67,:PSYCHOBOOST],[73,:HYPERBEAM]]
     when 2 ; movelist=[[1,:LEER],[1,:WRAP],[7,:NIGHTSHADE],[13,:TELEPORT],
                        [19,:KNOCKOFF],[25,:SPIKES],[31,:PSYCHIC],[37,:SNATCH],
                        [43,:PSYCHOSHIFT],[49,:ZENHEADBUTT],[55,:IRONDEFENSE],
                        [55,:AMNESIA],[61,:RECOVER],[67,:PSYCHOBOOST],
                        [73,:COUNTER],[73,:MIRRORCOAT]]
     when 3 ; movelist=[[1,:LEER],[1,:WRAP],[7,:NIGHTSHADE],[13,:DOUBLETEAM],
                        [19,:KNOCKOFF],[25,:PURSUIT],[31,:PSYCHIC],[37,:SWIFT],
                        [43,:PSYCHOSHIFT],[49,:ZENHEADBUTT],[55,:AGILITY],
                        [61,:RECOVER],[67,:PSYCHOBOOST],[73,:EXTREMESPEED]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:BURMY,{
"getFormOnCreation"=>proc{|pokemon|
   env=pbGetEnvironment()
   if !pbGetMetadata($game_map.map_id,MetadataOutdoor)
     next 2 # Trash Cloak
   elsif env==PBEnvironment::Sand ||
         env==PBEnvironment::Rock ||
         env==PBEnvironment::Cave
     next 1 # Sandy Cloak
   else
     next 0 # Plant Cloak
   end
},
"getFormOnEnteringBattle"=>proc{|pokemon|
   env=pbGetEnvironment()
   if !pbGetMetadata($game_map.map_id,MetadataOutdoor)
     next 2 # Trash Cloak
   elsif env==PBEnvironment::Sand ||
         env==PBEnvironment::Rock ||
         env==PBEnvironment::Cave
     next 1 # Sandy Cloak
   else
     next 0 # Plant Cloak
   end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:WORMADAM,{
"getFormOnCreation"=>proc{|pokemon|
   env=pbGetEnvironment()
   if !pbGetMetadata($game_map.map_id,MetadataOutdoor)
     next 2 # Trash Cloak
   elsif env==PBEnvironment::Sand || env==PBEnvironment::Rock ||
      env==PBEnvironment::Cave
     next 1 # Sandy Cloak
   else
     next 0 # Plant Cloak
   end
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0               # Plant Cloak
   case pokemon.form
     when 1; next getID(PBTypes,:GROUND) # Sandy Cloak
     when 2; next getID(PBTypes,:STEEL)  # Trash Cloak
   end
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0              # Plant Cloak
   case pokemon.form
     when 1; next [60,79,105,36,59, 85] # Sandy Cloak
     when 2; next [60,69, 95,36,69, 95] # Trash Cloak
   end
},
"evYield"=>proc{|pokemon|
   next if pokemon.form==0      # Plant Cloak
   case pokemon.form
     when 1; next [0,0,2,0,0,0] # Sandy Cloak
     when 2; next [0,0,1,0,0,1] # Trash Cloak
   end
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
     when 1 ; movelist=[[0,:QUIVERDANCE],[1,:SUCKERPUNCH],[1,:TACKLE],
                        [1,:PROTECT],[1,:BUGBITE],[10,:PROTECT],[15,:BUGBITE],
                        [20,:HIDDENPOWER],[23,:CONFUSION],[26,:ROCKBLAST],
                        [29,:HARDEN],[32,:PSYBEAM],[35,:CAPTIVATE],[38,:FLAIL],
                        [41,:ATTRACT],[44,:PSYCHIC],[47,:FISSURE],[50,:BUGBUZZ]]
     when 2 ; movelist=[[0,:QUIVERDANCE],[1,:METALBURST],[1,:SUCKERPUNCH],[1,:TACKLE],
                        [1,:PROTECT],[1,:TACKLE],[10,:PROTECT],[15,:BUGBITE],
                        [20,:HIDDENPOWER],[23,:CONFUSION],[26,:MIRRORSHOT],
                        [29,:METALSOUND],[32,:PSYBEAM],[35,:CAPTIVATE],[38,:FLAIL],
                        [41,:ATTRACT],[44,:PSYCHIC],[47,:IRONHEAD],[50,:BUGBUZZ]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
}
})

MultipleForms.register(:SHELLOS,{
"getFormOnCreation"=>proc{|pokemon|
   maps=[]   
   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 1
   else
     next 0
   end
}
})

MultipleForms.copy(:SHELLOS,:GASTRODON)

MultipleForms.register(:ROTOM,{
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0     # Normal Form
   next [50,65,107,86,105,107] # All alternate forms
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0               # Normal Form
   case pokemon.form
     when 1; next getID(PBTypes,:FIRE)   # Heat, Microwave
     when 2; next getID(PBTypes,:WATER)  # Wash, Washing Machine
     when 3; next getID(PBTypes,:ICE)    # Frost, Refrigerator
     when 4; next getID(PBTypes,:FLYING) # Fan
     when 5; next getID(PBTypes,:GRASS)  # Mow, Lawnmower
   end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
   moves=[
      :OVERHEAT,  # Heat, Microwave
      :HYDROPUMP, # Wash, Washing Machine
      :BLIZZARD,  # Frost, Refrigerator
      :AIRSLASH,  # Fan
      :LEAFSTORM  # Mow, Lawnmower
   ]
   moves.each{|move|
      pbDeleteMoveByID(pokemon,getID(PBMoves,move))
   }
   if form>0
     pokemon.pbLearnMove(moves[form-1])
   end
   if pokemon.moves.find_all{|i| i.id!=0}.length==0
     pokemon.pbLearnMove(:THUNDERSHOCK)
   end
}
})

MultipleForms.register(:GIRATINA,{
"ability"=>proc{|pokemon|
   next if pokemon.form==0           # Altered Forme
   next getID(PBAbilities,:LEVITATE) # Origin Forme
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0 # Altered Forme
   next 6500               # Origin Forme
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0       # Altered Forme
   next [150,120,100,90,120,100] # Origin Forme
},
"getForm"=>proc{|pokemon|
   maps=[49,50,51,72,73]   # Map IDs for Origin Forme
   if isConst?(pokemon.item,PBItems,:GRISEOUSORB) ||
      ($game_map && maps.include?($game_map.map_id))
     next 1
   end
   next 0
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:SHAYMIN,{
"type2"=>proc{|pokemon|
   next if pokemon.form==0     # Land Forme
   next getID(PBTypes,:FLYING) # Sky Forme
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0              # Land Forme
   next getID(PBAbilities,:SERENEGRACE) # Sky Forme
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0 # Land Forme
   next 52                 # Sky Forme
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Land Forme
   next [100,103,75,127,120,75] # Sky Forme
},
"evYield"=>proc{|pokemon|
   next if pokemon.form==0 # Land Forme
   next [0,0,0,3,0,0]      # Sky Forme
},
"getForm"=>proc{|pokemon|
   next 0 if PBDayNight.isNight?(pbGetTimeNow) ||
             pokemon.hp<=0 || pokemon.status==PBStatuses::FROZEN
   next nil
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
     when 1 ; movelist=[[1,:GROWTH],[10,:MAGICALLEAF],[19,:LEECHSEED],
                        [28,:QUICKATTACK],[37,:SWEETSCENT],[46,:NATURALGIFT],
                        [55,:WORRYSEED],[64,:AIRSLASH],[73,:ENERGYBALL],
                        [82,:SWEETKISS],[91,:LEAFSTORM],[100,:SEEDFLARE]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:ARCEUS,{
"type1"=>proc{|pokemon|
   types=[:NORMAL,:FIGHTING,:FLYING,:POISON,:GROUND,
          :ROCK,:BUG,:GHOST,:STEEL,:QMARKS,
          :FIRE,:WATER,:GRASS,:ELECTRIC,:PSYCHIC,
          :ICE,:DRAGON,:DARK,:FAIRY]
   next getID(PBTypes,types[pokemon.form])
},
"type2"=>proc{|pokemon|
   types=[:NORMAL,:FIGHTING,:FLYING,:POISON,:GROUND,
          :ROCK,:BUG,:GHOST,:STEEL,:QMARKS,
          :FIRE,:WATER,:GRASS,:ELECTRIC,:PSYCHIC,
          :ICE,:DRAGON,:DARK,:FAIRY]
   next getID(PBTypes,types[pokemon.form])
},
"getForm"=>proc{|pokemon|
  if $fefieldeffect == 35
    if $fecounter == 1
     form = 0
     loop do
       form = rand(19)
       break if form != 9
     end
     next form
    end
  else
     next 1  if isConst?(pokemon.item,PBItems,:FISTPLATE) || isConst?(pokemon.item,PBItems,:FIGHTINIUMZ2)
     next 2  if isConst?(pokemon.item,PBItems,:SKYPLATE) || isConst?(pokemon.item,PBItems,:FLYINIUMZ2)
     next 3  if isConst?(pokemon.item,PBItems,:TOXICPLATE) || isConst?(pokemon.item,PBItems,:POISONIUMZ2)
     next 4  if isConst?(pokemon.item,PBItems,:EARTHPLATE) || isConst?(pokemon.item,PBItems,:GROUNDIUMZ2)
     next 5  if isConst?(pokemon.item,PBItems,:STONEPLATE) || isConst?(pokemon.item,PBItems,:ROCKIUMZ2)
     next 6  if isConst?(pokemon.item,PBItems,:INSECTPLATE) || isConst?(pokemon.item,PBItems,:BUGINIUMZ2)
     next 7  if isConst?(pokemon.item,PBItems,:SPOOKYPLATE) || isConst?(pokemon.item,PBItems,:GHOSTIUMZ2)
     next 8  if isConst?(pokemon.item,PBItems,:IRONPLATE) || isConst?(pokemon.item,PBItems,:STEELIUMZ2)
     next 10 if isConst?(pokemon.item,PBItems,:FLAMEPLATE) || isConst?(pokemon.item,PBItems,:FIRIUMZ2)
     next 11 if isConst?(pokemon.item,PBItems,:SPLASHPLATE) || isConst?(pokemon.item,PBItems,:WATERIUMZ2)
     next 12 if isConst?(pokemon.item,PBItems,:MEADOWPLATE) || isConst?(pokemon.item,PBItems,:GRASSIUMZ2)
     next 13 if isConst?(pokemon.item,PBItems,:ZAPPLATE) || isConst?(pokemon.item,PBItems,:ELECTRIUMZ2)
     next 14 if isConst?(pokemon.item,PBItems,:MINDPLATE) || isConst?(pokemon.item,PBItems,:PSYCHIUMZ2)
     next 15 if isConst?(pokemon.item,PBItems,:ICICLEPLATE) || isConst?(pokemon.item,PBItems,:ICIUMZ2)
     next 16 if isConst?(pokemon.item,PBItems,:DRACOPLATE) || isConst?(pokemon.item,PBItems,:DRAGONNIUMZ2)
     next 17 if isConst?(pokemon.item,PBItems,:DREADPLATE) || isConst?(pokemon.item,PBItems,:DARKINIUMZ2)
     next 18 if isConst?(pokemon.item,PBItems,:PIXIEPLATE) || isConst?(pokemon.item,PBItems,:FAIRIUMZ2)
     next 0
  end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:BASCULIN,{
"getFormOnCreation"=>proc{|pokemon|
   next rand(2)
},
"wildHoldItems"=>proc{|pokemon|
   next if pokemon.form==0                 # Red-Striped
   next [0,getID(PBItems,:DEEPSEASCALE),0] # Blue-Striped
}
})

MultipleForms.register(:DARMANITAN,{
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Standard Mode
   next [105,30,105,55,140,105] # Zen Mode
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Standard Mode
   next getID(PBTypes,:PSYCHIC) # Zen Mode
},
"evYield"=>proc{|pokemon|
   next if pokemon.form==0 # Standard Mode
   next [0,0,0,0,2,0]      # Zen Mode
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:DEERLING,{
"getForm"=>proc{|pokemon|
   time=pbGetTimeNow
   next (time.month-1)%4
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.copy(:DEERLING,:SAWSBUCK)

MultipleForms.register(:TORNADUS,{
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0     # Incarnate Forme
   next [79,100,80,121,110,90] # Therian Forme
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0                # Incarnate Forme
   if pokemon.abilityflag && pokemon.abilityflag!=2
     next getID(PBAbilities,:REGENERATOR) # Therian Forme
   end
},
"evYield"=>proc{|pokemon|
   next if pokemon.form==0 # Incarnate Forme
   next [0,0,0,3,0,0]      # Therian Forme
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:THUNDURUS,{
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0     # Incarnate Forme
   next [79,105,70,101,145,80] # Therian Forme
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0               # Incarnate Forme
   if pokemon.abilityflag && pokemon.abilityflag!=2
     next getID(PBAbilities,:VOLTABSORB) # Therian Forme
   end
},
"evYield"=>proc{|pokemon|
   next if pokemon.form==0 # Incarnate Forme
   next [0,0,0,0,3,0]      # Therian Forme
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:LANDORUS,{
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0    # Incarnate Forme
   next [89,145,90,71,105,80] # Therian Forme
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0               # Incarnate Forme
   if pokemon.abilityflag && pokemon.abilityflag!=2
     next getID(PBAbilities,:INTIMIDATE) # Therian Forme
   end
},
"evYield"=>proc{|pokemon|
   next if pokemon.form==0 # Incarnate Forme
   next [0,3,0,0,0,0]      # Therian Forme
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:KYUREM,{
"getBaseStats"=>proc{|pokemon|
   case pokemon.form
     when 1; next [125,120, 90,95,170,100] # White Kyurem
     when 2; next [125,170,100,95,120, 90] # Black Kyurem
     else;   next                          # Kyurem
   end
},
"ability"=>proc{|pokemon|
   case pokemon.form
     when 1; next getID(PBAbilities,:TURBOBLAZE) # White Kyurem
     when 2; next getID(PBAbilities,:TERAVOLT)   # Black Kyurem
     else;   next                                # Kyurem
   end
},
"evYield"=>proc{|pokemon|
   case pokemon.form
     when 1; next [0,0,0,0,3,0] # White Kyurem
     when 2; next [0,3,0,0,0,0] # Black Kyurem
     else;   next               # Kyurem
   end
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
     when 1; movelist=[[1,:ICYWIND],[1,:DRAGONRAGE],[8,:IMPRISON],
                       [15,:ANCIENTPOWER],[22,:ICEBEAM],[29,:DRAGONBREATH],
                       [36,:SLASH],[43,:FUSIONFLARE],[50,:ICEBURN],
                       [57,:DRAGONPULSE],[64,:NOBLEROAR],[71,:ENDEAVOR],
                       [78,:BLIZZARD],[85,:OUTRAGE],[92,:HYPERVOICE]]
     when 2; movelist=[[1,:ICYWIND],[1,:DRAGONRAGE],[8,:IMPRISON],
                       [15,:ANCIENTPOWER],[22,:ICEBEAM],[29,:DRAGONBREATH],
                       [36,:SLASH],[43,:FUSIONBOLT],[50,:FREEZESHOCK],
                       [57,:DRAGONPULSE],[64,:NOBLEROAR],[71,:ENDEAVOR],
                       [78,:BLIZZARD],[85,:OUTRAGE],[92,:HYPERVOICE]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:KELDEO,{
"getForm"=>proc{|pokemon|
   next 1 if pokemon.knowsMove?(:SECRETSWORD) # Resolute Form
   next 0                                     # Ordinary Form
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:MELOETTA,{
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0     # Aria Forme
   next [100,128,90,128,77,77] # Pirouette Forme
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0       # Aria Forme
   next getID(PBTypes,:FIGHTING) # Pirouette Forme
},
"evYield"=>proc{|pokemon|
   next if pokemon.form==0 # Aria Forme
   next [0,1,1,1,0,0]      # Pirouette Forme
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:GENESECT,{
"getForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:SHOCKDRIVE)
   next 2 if isConst?(pokemon.item,PBItems,:BURNDRIVE)
   next 3 if isConst?(pokemon.item,PBItems,:CHILLDRIVE)
   next 4 if isConst?(pokemon.item,PBItems,:DOUSEDRIVE)
   next 0
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:MEOWSTIC,{
"ability"=>proc{|pokemon|
next if pokemon.gender==0 # Male Meowstic
#### JERICHO - 015 - START
if pokemon.abilityIndex==2 || (pokemon.abilityflag && pokemon.abilityflag==2)
#### JERICHO - 015 - END
  next getID(PBAbilities,:COMPETITIVE) # Female Meowstic
end
},

"getMoveList"=>proc{|pokemon|
next if pokemon.gender==0 # Male Meowstic
movelist=[]
case pokemon.gender
when 1 ; movelist=[[1,:STOREDPOWER],[1,:MEFIRST],[1,:MAGICALLEAF],[1,:SCRATCH],
[1,:LEER],[1,:COVET],[1,:CONFUSION],[5,:COVET],[9,:CONFUSION],[13,:LIGHTSCREEN],
[17,:PSYBEAM],[19,:FAKEOUT],[22,:DISARMINGVOICE],[25,:PSYSHOCK],[28,:CHARGEBEAM],
[31,:SHADOWBALL],[35,:EXTRASENSORY],[40,:PSYCHIC],
[43,:ROLEPLAY],[45,:SIGNALBEAM],[48,:SUCKERPUNCH],
[50,:FUTURESIGHT],[53,:STOREDPOWER]] # Female Meowstic
end
for i in movelist
i[1]=getConst(PBMoves,i[1])
end
next movelist
}
})

MultipleForms.register(:AEGISLASH,{
    "getBaseStats"=>proc{|pokemon|
      next if pokemon.form==0    # Shield Forme
      next [60,150,50,60,150,50] # Blade Forme
    },
    "onSetForm"=>proc{|pokemon,form|
      pbSeenForm(pokemon)
    }
})

MultipleForms.register(:ZYGARDE,{
"dexEntry"=>proc{|pokemon|
   case pokemon.form      
   when 0
     next  # 50%
   when 1
     next "Its sharp fangs make short work of finishing off its enemies, but it’s unable to maintain this body indefinitely. After a period of time, it falls apart." # 10%
   when 2
     next "This is Zygarde’s form at times when it uses its overwhelming power to suppress those who endanger the ecosystem." # 100%
   end
},
"getBaseStats"=>proc{|pokemon|
   case pokemon.form
   when 0 # 50%
     next   
   when 1 # 10%       
     next [54,100,71,115,61,85] 
   when 2 # 100%
     next [216,100,121,85,91,95] 
   end   
},
"height"=>proc{|pokemon|
   case pokemon.form
   when 0 # 50%
     next   
   when 1 # 10%       
     next 1.2
   when 2 # 100%
     next 4.5
   end  
},
"weight"=>proc{|pokemon|
   case pokemon.form
   when 0 # 50%
     next   
   when 1 # 10%       
     next 33.5
   when 2 # 100%
     next 610.0
   end  
   next 490 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:HOOPA,{
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0     
   next [80,160,60,80,170,130] # Unbound Forme
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0       
   next getID(PBTypes,:DARK) # Unbound Forme
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0               
   if pokemon.abilityflag && pokemon.abilityflag!=2
     next getID(PBAbilities,:MAGICIAN) # Unbound Forme
   end
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
     when 1 ; movelist=[[1,:HYPERSPACEFURY],[1,:TRICK],[1,:DESTINYBOND],[1,:ALLYSWITCH],
                        [1,:CONFUSION],[6,:ASTONISH],[10,:MAGICCOAT],[15,:LIGHTSCREEN],
                        [19,:PSYBEAM],[25,:SKILLSWAP],[29,:POWERSPLIT],[29,:GUARDSPLIT],
                        [46,:KNOCKOFF],[50,:WONDERROOM],[50,:TRICKROOM],[55,:DARKPULSE],
                        [75,:PSYCHIC],[85,:HYPERSPACEFURY]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"height"=>proc{|pokemon|
   next 65 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 490 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})


MultipleForms.register(:ORICORIO,{
"dexEntry"=>proc{|pokemon|
   case pokemon.form      
   when 0
     next  # Baile
   when 1
     next "It creates an electric charge by rubbing its feathers together. It dances over to its enemies and delivers shocking electrical punches." # Pom-Pom
   when 2
     next "This Oricorio relaxes by swaying gently. This increases its psychic energy, which it then fires at its enemies." # Pa'u
   when 3
     next "It summons the dead with its dreamy dancing. From their malice, it draws power with which to curse its enemies." # Sensu
   end
},
"type1"=>proc{|pokemon|
   case pokemon.form      
   when 0
     next #getID(PBTypes,:FIRE) # Baile
   when 1
     next getID(PBTypes,:ELECTRIC) # Pom-Pom
   when 2
     next getID(PBTypes,:PSYCHIC) # Pa'u
   when 3
     next getID(PBTypes,:GHOST) # Sensu
   end
},
   "getFormOnCreation"=>proc{|pokemon|
   maps=[405]   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 1
   else
   maps=[406]   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 2
   else
   maps=[408]   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 3
   else
     next 0
   end
 end
end
}
})

MultipleForms.register(:LYCANROC,{
"dexEntry"=>proc{|pokemon|
   case pokemon.form
     when 1; next "They live alone without forming packs. They will only listen to orders from Trainers who can draw out their true power." # Midnight
     when 2; next "Bathed in the setting sun of evening, Lycanroc has undergone a special kind of evolution. An intense fighting spirit underlies its calmness." # Dusk
     else;   next     # Midday
   end
},
"height"=>proc{|pokemon|
   case pokemon.form
     when 1; next 1.1 # Midnight
     when 2; next 0.8 # Dusk
     else;   next     # Midday
   end
},
"getBaseStats"=>proc{|pokemon|
   case pokemon.form
     when 1; next [85,115, 75, 82, 55, 75] # Midnight
     when 2; next [75,117, 65,110, 55, 65] # Dusk
     else;   next                          # Midday
   end
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Midday
   movelist=[]
   case pokemon.form            # Midnight
     when 1 ; movelist=[[0,:COUNTER],[1,:REVERSAL],[1,:TAUNT],
                        [1,:TACKLE],[1,:LEER],[1,:SANDATTACK],
                        [1,:BITE],[4,:SANDATTACK],[7,:BITE],[12,:HOWL],
                        [15,:ROCKTHROW],[18,:ODORSLEUTH],[23,:ROCKTOMB],
                        [26,:ROAR],[29,:STEALTHROCK],[34,:ROCKSLIDE],
                        [37,:SCARYFACE],[40,:CRUNCH],[45,:ROCKCLIMB],
                        [48,:STONEEDGE]]
     when 2 ; movelist=[[0,:THRASH],[1,:ACCELEROCK],[1,:BITE],
                        [1,:COUNTER],[1,:LEER],[1,:SANDATTACK],
                        [1,:TACKLE],[4,:SANDATTACK],[7,:BITE],[12,:HOWL],
                        [15,:ROCKTHROW],[18,:ODORSLEUTH],[23,:ROCKTOMB],
                        [26,:ROAR],[29,:STEALTHROCK],[34,:ROCKSLIDE],
                        [37,:SCARYFACE],[40,:CRUNCH],[45,:ROCKCLIMB],
                        [48,:STONEEDGE]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     # Move Tutors
                     :COVET,:DRILLRUN,:EARTHPOWER,:ENDEAVOR,:HYPERVOICE,
                     :IRONDEFENSE,:IRONHEAD,:IRONTAIL,:LASTRESORT,:SNORE,
                     :STEALTHROCK,:STOMPINGTANTRUM,:ZENHEADBUTT]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Midday
   if pokemon.form==1      # Midnight
     if pokemon.abilityIndex==1 || (pokemon.abilityflag && pokemon.abilityflag==1) # Midnight
       next getID(PBAbilities,:VITALSPIRIT)
     elsif pokemon.abilityIndex==2 || (pokemon.abilityflag && pokemon.abilityflag==2)
       next getID(PBAbilities,:NOGUARD)  
     end
   end
   if pokemon.form==2      # Dusk
     next getID(PBAbilities,:TOUGHCLAWS)
   end  
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
},
"getFormOnCreation"=>proc{|pokemon|
   maps=[321]   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 1
   else
     next 0
   end
}
})

MultipleForms.register(:WISHIWASHI,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Solo
   next "At their appearance, even Gyarados will flee. When they team up to use Water Gun, its power exceeds that of Hydro Pump."     # School
},
"height"=>proc{|pokemon|
   next 8.2 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 78.6 if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Solo
   next [45,140,130,30,140,135]   # School
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})


MultipleForms.register(:SILVALLY,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Type: Normal
   next "Upon awakening, its RKS System is activated. By employing specific memories, this Pokémon can adapt its type to confound its enemies."     # All other types
},
"type1"=>proc{|pokemon|
   types=[:NORMAL,:FIGHTING,:FLYING,:POISON,:GROUND,
          :ROCK,:BUG,:GHOST,:STEEL,:QMARKS,
          :FIRE,:WATER,:GRASS,:ELECTRIC,:PSYCHIC,
          :ICE,:DRAGON,:DARK,:FAIRY]
   next getID(PBTypes,types[pokemon.form])
},
"type2"=>proc{|pokemon|
   types=[:NORMAL,:FIGHTING,:FLYING,:POISON,:GROUND,
          :ROCK,:BUG,:GHOST,:STEEL,:QMARKS,
          :FIRE,:WATER,:GRASS,:ELECTRIC,:PSYCHIC,
          :ICE,:DRAGON,:DARK,:FAIRY]
   next getID(PBTypes,types[pokemon.form])
},
"getForm"=>proc{|pokemon|
     next 1  if isConst?(pokemon.item,PBItems,:FIGHTINGMEMORY)
     next 2  if isConst?(pokemon.item,PBItems,:FLYINGMEMORY)
     next 3  if isConst?(pokemon.item,PBItems,:POISONMEMORY)
     next 4  if isConst?(pokemon.item,PBItems,:GROUNDMEMORY)
     next 5  if isConst?(pokemon.item,PBItems,:ROCKMEMORY)
     next 6  if isConst?(pokemon.item,PBItems,:BUGMEMORY)
     next 7  if isConst?(pokemon.item,PBItems,:GHOSTMEMORY)
     next 8  if isConst?(pokemon.item,PBItems,:STEELMEMORY)
     next 10 if isConst?(pokemon.item,PBItems,:FIREMEMORY)
     next 11 if isConst?(pokemon.item,PBItems,:WATERMEMORY)
     next 12 if isConst?(pokemon.item,PBItems,:GRASSMEMORY)
     next 13 if isConst?(pokemon.item,PBItems,:ELECTRICMEMORY)
     next 14 if isConst?(pokemon.item,PBItems,:PSYCHICMEMORY)
     next 15 if isConst?(pokemon.item,PBItems,:ICEMEMORY)
     next 16 if isConst?(pokemon.item,PBItems,:DRAGONMEMORY)
     next 17 if isConst?(pokemon.item,PBItems,:DARKMEMORY)
     next 18 if isConst?(pokemon.item,PBItems,:FAIRYMEMORY)
     next 0
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})


MultipleForms.register(:MINIOR,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form!=6      # Core
   next "Originally making its home in the ozone layer, it hurtles to the ground when the shell enclosing its body grows too heavy."     # Meteor
},
"getFormOnCreation"=>proc{|pokemon|
   next rand(6)
},
"weight"=>proc{|pokemon|
   next 40.0 if pokemon.form==6
   next
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form!=6     # Core
   next [60,60,100,60,60,100]   # Meteor
},
"catchrate"=>proc{|pokemon|
   next 30 if pokemon.form==6
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})


MultipleForms.register(:VIVILLON,{
"getFormOnCreation"=>proc{|pokemon|
   next rand(9)
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:NECROZMA,{
"dexEntry"=>proc{|pokemon|
   case pokemon.form
     when 1; next "This is its form while it is devouring the light of Solgaleo. It pounces on foes and then slashes them with the claws on its four limbs and back." # Dusk Mane Necrozma
     when 2; next "This is its form while it's devouring the light of Lunala. It grasps foes in its giant claws and rips them apart with brute force." # Dawn Wings Necrozma
     when 3; next "The light pouring out from all over its body affects living things and nature, impacting them in various ways." # Ultra Necrozma
     else;   next                          # Necrozma
   end
},
"getBaseStats"=>proc{|pokemon|
   case pokemon.form
     when 1; next [97,153,127, 77,113,109] # Dusk Mane Necrozma
     when 2; next [97,113,109, 77,157,127] # Dawn Wings Necrozma
     when 3; next [97,167, 97,129,167, 97] # Ultra Necrozma
     else;   next                          # Necrozma
   end
},
"height"=>proc{|pokemon|
   case pokemon.form
     when 1; next 3.8 # Dusk Mane Necrozma
     when 2; next 4.2 # Dawn Wings Necrozma
     when 3; next 7.5 # Ultra Necrozma
     else;   next     # Necrozma
   end
},
"weight"=>proc{|pokemon|
   case pokemon.form
     when 1; next 460 # Dusk Mane Necrozma
     when 2; next 350 # Dawn Wings Necrozma
     when 3; next 230 # Ultra Necrozma
     else;   next     # Necrozma
   end
},
"type1"=>proc{|pokemon|
   case pokemon.form
     when 1; next getID(PBTypes,:PSYCHIC) # Dusk Mane Necrozma
     when 2; next getID(PBTypes,:PSYCHIC) # Dawn Wings Necrozma
     when 3; next getID(PBTypes,:PSYCHIC) # Ultra Necrozma
     else;   next     # Necrozma
   end
},
"type2"=>proc{|pokemon|
   case pokemon.form
     when 1; next getID(PBTypes,:STEEL)  # Dusk Mane Necrozma
     when 2; next getID(PBTypes,:GHOST)  # Dawn Wings Necrozma
     when 3; next getID(PBTypes,:DRAGON) # Ultra Necrozma
     else;   next                        # Necrozma
   end
},
"evYield"=>proc{|pokemon|
   case pokemon.form
     when 1; next [0,3,0,0,0,0] # Dusk Mane Necrozma
     when 2; next [0,0,0,0,3,0] # Dawn Wings Necrozma
     when 3; next [0,1,0,1,1,0] # Ultra Necrozma
     else;   next               # Necrozma
   end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})


### Regional Variants ###
MultipleForms.register(:RATTATA,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "With its incisors, it gnaws through doors and infiltrates people’s homes. Then, with a twitch of its whiskers, it steals whatever food it finds."     # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 3.8                     # Alola
},
"type1"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:DARK)    # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:NORMAL)  # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[1,:TACKLE],[1,:TAILWHIP],[4,:QUICKATTACK],
                        [7,:FOCUSENERGY],[10,:BITE],[13,:PURSUIT],
                        [16,:HYPERFANG],[19,:ASSURANCE],[22,:CRUNCH],
                        [25,:SUCKERPUNCH],[28,:SUPERFANG],[31,:DOUBLEEDGE],
                        [34,:ENDEAVOR]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getEggMoves"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   eggmovelist=[]
   case pokemon.form            # Alola
     when 1 ; eggmovelist=[:COUNTER,:FINALGAMBIT,:FURYSWIPES,:MEFIRST,
                           :REVENGE,:REVERSAL,:SNATCH,:STOCKPILE,
                           :SWALLOW,:SWITCHEROO,:UPROAR]
   end
   for i in eggmovelist
     i=getID(PBMoves,i)
   end
   next eggmovelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :TOXIC,:HIDDENPOWER,:SUNNYDAY,:TAUNT,:ICEBEAM,:BLIZZARD,
                     :PROTECT,:RAINDANCE,:FRUSTRATION,:RETURN,:SHADOWBALL,
                     :DOUBLETEAM,:SLUDGEBOMB,:TORMENT,:FACADE,:REST,:ATTRACT,
                     :ROUND,:QUASH,:EMBARGO,:SHADOWCLAW,:GRASSKNOT,:SWAGGER,
                     :SLEEPTALK,:UTURN,:SUBSTITUTE,:SNARL,:DARKPULSE,:CONFIDE,
                     # Move Tutors
                     :COVET,:ENDEAVOR,:ICYWIND,:IRONTAIL,:LASTRESORT,:SHOCKWAVE,
                     :SNATCH,:SNORE,:SUPERFANG,:UPROAR,:ZENHEADBUTT]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
}, 
"wildHoldItems"=>proc{|pokemon|
   next if pokemon.form==0                 # Normal
   next [0,getID(PBItems,:PECHABERRY),0]   # Alola
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:GLUTTONY)
   elsif pokemon.abilityIndex==1 || (pokemon.abilityflag && pokemon.abilityflag==1)
     next getID(PBAbilities,:HUSTLE)
   elsif pokemon.abilityIndex==2 || (pokemon.abilityflag && pokemon.abilityflag==2)
     next getID(PBAbilities,:THICKFAT)  
   end
},

"getFormOnCreation"=>proc{|pokemon|
   maps=[55,58,59,144,194,209,218]   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 1
   else
     next 0
   end
},

"getEvo"=>proc{|pokemon|
   next if pokemon.form==0                  # Normal
   next [[30,20,20]]                        # Alola    [LevelNight,20,Raticate]  
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:RATICATE,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "It forms a group of Rattata, which it assumes command of. Each group has its own territory, and disputes over food happen often."     # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 25.5                     # Alola
},
"type1"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:DARK)    # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:NORMAL)  # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[0,:SCARYFACE],[1,:SWORDSDANCE],[1,:TACKLE],
                        [1,:TAILWHIP],[1,:QUICKATTACK],[1,:FOCUSENERGY],
                        [4,:QUICKATTACK],[7,:FOCUSENERGY],[10,:BITE],[13,:PURSUIT],
                        [16,:HYPERFANG],[19,:ASSURANCE],[24,:CRUNCH],
                        [29,:SUCKERPUNCH],[34,:SUPERFANG],[39,:DOUBLEEDGE],
                        [44,:ENDEAVOR]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :ROAR,:TOXIC,:BULKUP,:VENOSHOCK,:HIDDENPOWER,:SUNNYDAY,
                     :TAUNT,:ICEBEAM,:BLIZZARD,:HYPERBEAM,:PROTECT,:RAINDANCE,
                     :FRUSTRATION,:RETURN,:SHADOWBALL,:DOUBLETEAM,:SLUDGEWAVE,
                     :SLUDGEBOMB,:TORMENT,:FACADE,:REST,:ATTRACT,:THIEF,:ROUND,
                     :QUASH,:EMBARGO,:SHADOWCLAW,:GIGAIMPACT,:SWORDSDANCE,
                     :GRASSKNOT,:SWAGGER,:SLEEPTALK,:UTURN,:SUBSTITUTE,:SNARL,
                     :DARKPULSE,:CONFIDE,
                     # Move Tutors
                     :COVET,:ENDEAVOR,:ICYWIND,:IRONTAIL,:KNOCKOFF,:LASTRESORT,
                     :SHOCKWAVE,:SNATCH,:SNORE,:STOMPINGTANTRUM,:SUPERFANG,
                     :THROATCHOP,:UPROAR,:ZENHEADBUTT]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"wildHoldItems"=>proc{|pokemon|
   next if pokemon.form==0                 # Normal
   next [0,getID(PBItems,:PECHABERRY),0]   # Alola
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next [75,71,70,77,40,80]   # Alola
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:GLUTTONY)
   elsif pokemon.abilityIndex==1 || (pokemon.abilityflag && pokemon.abilityflag==1)
     next getID(PBAbilities,:HUSTLE)
   elsif pokemon.abilityIndex==2 || (pokemon.abilityflag && pokemon.abilityflag==2)
     next getID(PBAbilities,:THICKFAT)  
   end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
},
   "getFormOnCreation"=>proc{|pokemon|
   maps=[55,58,59,144]   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 1
   else
     next 0
   end
}
})

MultipleForms.register(:RAICHU,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "It uses psychokinesis to control electricity. It hops aboard its own tail, using psychic power to lift the tail and move about while riding it."  # Alola
},
"height"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 0.7                     # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 21.0                    # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:PSYCHIC)  # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[0,:PSYCHIC],[1,:SPEEDSWAP],[1,:THUNDERSHOCK],
                        [1,:TAILWHIP],[1,:QUICKATTACK],[1,:THUNDERBOLT]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :PSYSHOCK,:CALMMIND,:TOXIC,:HIDDENPOWER,:HYPERBEAM,
                     :LIGHTSCREEN,:PROTECT,:RAINDANCE,:SAFEGUARD,:FRUSTRATION,
                     :THUNDERBOLT,:THUNDER,:RETURN,:PSYCHIC,:BRICKBREAK,
                     :DOUBLETEAM,:REFLECT,:FACADE,:REST,:ATTRACT,:THIEF,
                     :ROUND,:ECHOEDVOICE,:FOCUSBLAST,:FLING,:CHARGEBEAM,
                     :GIGAIMPACT,:VOLTSWITCH,:THUNDERWAVE,:GRASSKNOT,:SWAGGER,
                     :SLEEPTALK,:SUBSTITUTE,:WILDCHARGE,:CONFIDE,
                     # Move Tutors
                     :ALLYSWITCH,:COVET,:ELECTROWEB,:FOCUSPUNCH,:HELPINGHAND,
                     :IRONTAIL,:KNOCKOFF,:LASERFOCUS,:MAGICCOAT,:MAGICROOM,
                     :MAGNETRISE,:RECYCLE,:SHOCKWAVE,:SIGNALBEAM,:SNORE,
                     :TELEKINESIS,:THUNDERPUNCH]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next [60,85,50,110,95,85]    # Alola
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0              # Normal   
   next getID(PBAbilities,:SURGESURFER) # Alola
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:SANDSHREW,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "It lives on snowy mountains. Its steel shell is very hard—so much so, it can’t roll its body up into a ball."  # Alola
},
"height"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 0.6                     # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 40.0                    # Alola
},
"type1"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:ICE)     # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:STEEL)   # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[1,:SCRATCH],[1,:DEFENSECURL],[3,:BIDE],
                        [5,:POWDERSNOW],[7,:ICEBALL],[9,:RAPIDSPIN],
                        [11,:FURYCUTTER],[14,:METALCLAW],[17,:SWIFT],
                        [20,:FURYSWIPES],[23,:IRONDEFENSE],[26,:SLASH],
                        [30,:IRONHEAD],[34,:GYROBALL],[38,:SWORDSDANCE],
                        [42,:HAIL],[46,:BLIZZARD]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getEggMoves"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   eggmovelist=[]
   case pokemon.form            # Alola
     when 1 ; eggmovelist=[:AMNESIA,:CHIPAWAY,:COUNTER,:CRUSHCLAW,:CURSE,
                           :ENDURE,:FLAIL,:ICICLECRASH,:ICICLESPEAR,
                           :METALCLAW,:NIGHTSLASH,:HONECLAWS]
   end
   for i in eggmovelist
     i=getID(PBMoves,i)
   end
   next eggmovelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :WORKUP,:TOXIC,:HAIL,:HIDDENPOWER,:SUNNYDAY,:BLIZZARD,
                     :PROTECT,:SAFEGUARD,:FRUSTRATION,:EARTHQUAKE,:RETURN,
                     :LEECHLIFE,:BRICKBREAK,:DOUBLETEAM,:AERIALACE,:FACADE,:REST,
                     :ATTRACT,:THIEF,:ROUND,:FLING,:SHADOWCLAW,:AURORAVEIL,
                     :GYROBALL,:SWORDSDANCE,:BULLDOZE,:FROSTBREATH,:ROCKSLIDE,
                     :XSCISSOR,:POISONJAB,:SWAGGER,:SLEEPTALK,:SUBSTITUTE,:CONFIDE,
                     # Move Tutors
                     :AQUATAIL,:COVET,:FOCUSPUNCH,:ICEPUNCH,:ICYWIND,:IRONDEFENSE,
                     :IRONHEAD,:IRONTAIL,:KNOCKOFF,:SNORE,:STEALTHROCK,:SUPERFANG,
                     :THROATCHOP]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next [50,75,90,40,10,35]     # Alola
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:SNOWCLOAK)
   elsif pokemon.abilityIndex==1 || (pokemon.abilityflag && pokemon.abilityflag==1)
     next getID(PBAbilities,:SLUSHRUSH)  
   elsif pokemon.abilityIndex==2 && !pokemon.abilityflag
     check = rand(2)
     next getID(PBAbilities,:SNOWCLOAK) if check==0
     next getID(PBAbilities,:SLUSHRUSH) if check==1
   end
},
"getEvo"=>proc{|pokemon|
   next if pokemon.form==0                  # Normal
   next [[7,692,28]]                        # Alola    [Item,Ice Stone,Sandslash]  
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:SANDSLASH,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "This Pokémon’s steel spikes are sheathed in ice. Stabs from these spikes cause deep wounds and severe frostbite as well."  # Alola
},
"height"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 1.2                     # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 55.0                    # Alola
},
"type1"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:ICE)     # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:STEEL)   # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[0,:ICICLESPEAR],[1,:METALBURST],[1,:ICICLECRASH],
                        [1,:SLASH],[1,:DEFENSECURL],[1,:ICEBALL],
                        [1,:METALCLAW]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :WORKUP,:TOXIC,:HAIL,:HIDDENPOWER,:SUNNYDAY,:BLIZZARD,
                     :HYPERBEAM,:PROTECT,:SAFEGUARD,:FRUSTRATION,:EARTHQUAKE,
                     :RETURN,:LEECHLIFE,:BRICKBREAK,:DOUBLETEAM,:AERIALACE,
                     :FACADE,:REST,:ATTRACT,:THIEF,:ROUND,:FOCUSBLAST,:FLING,
                     :SHADOWCLAW,:GIGAIMPACT,:AURORAVEIL,:GYROBALL,:SWORDSDANCE,
                     :BULLDOZE,:FROSTBREATH,:ROCKSLIDE,:XSCISSOR,:POISONJAB,
                     :SWAGGER,:SLEEPTALK,:SUBSTITUTE,:CONFIDE,
                     # Move Tutors
                     :AQUATAIL,:COVET,:DRILLRUN,:FOCUSPUNCH,:ICEPUNCH,:ICYWIND,
                     :IRONDEFENSE,:IRONHEAD,:IRONTAIL,:KNOCKOFF,:SNORE,
                     :STEALTHROCK,:SUPERFANG,:THROATCHOP]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next [75,100,120,65,25,65]     # Alola
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:SNOWCLOAK)
   elsif pokemon.abilityIndex==1 || (pokemon.abilityflag && pokemon.abilityflag==1)
     next getID(PBAbilities,:SLUSHRUSH)  
   elsif pokemon.abilityIndex==2 && !pokemon.abilityflag
     check = rand(2)
     next getID(PBAbilities,:SNOWCLOAK) if check==0
     next getID(PBAbilities,:SLUSHRUSH) if check==1
   end
},
     "getFormOnCreation"=>proc{|pokemon|
   maps=[146,150,165,171,174,178,181]   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 1
   else
     next 0
   end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:VULPIX,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "In hot weather, this Pokémon makes ice shards with its six tails and sprays them around to cool itself off."     # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:ICE)     # Alola
},
"type1"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:ICE)     # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:ICE)     # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[1,:POWDERSNOW],[4,:TAILWHIP],[7,:ROAR],
                        [9,:BABYDOLLEYES],[10,:ICESHARD],[12,:CONFUSERAY],
                        [15,:ICYWIND],[18,:PAYBACK],[20,:MIST],
                        [23,:FEINTATTACK],[26,:HEX],[28,:AURORABEAM],
                        [31,:EXTRASENSORY],[34,:SAFEGUARD],[36,:ICEBEAM],
                        [39,:IMPRISON],[42,:BLIZZARD],[44,:GRUDGE],                        
                        [47,:CAPTIVATE],[50,:SHEERCOLD]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getEggMoves"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   eggmovelist=[]
   case pokemon.form            # Alola
     when 1 ; eggmovelist=[:AGILITY,:CHARM,:DISABLE,:ENCORE,
                           :EXTRASENSORY,:FLAIL,:FREEZEDRY,:HOWL,
                           :HYPNOSIS,:MOONBLAST,:POWERSWAP,:SPITE,
                           :SECRETPOWER,:TAILSLAP]
   end
   for i in eggmovelist
     i=getID(PBMoves,i)
   end
   next eggmovelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :ROAR,:TOXIC,:HAIL,:HIDDENPOWER,:ICEBEAM,:BLIZZARD,:PROTECT,
                     :RAINDANCE,:SAFEGUARD,:FRUSTRATION,:RETURN,:DOUBLETEAM,
                     :FACADE,:REST,:ATTRACT,:ROUND,:PAYBACK,:AURORAVEIL,:PSYCHUP,
                     :FROSTBREATH,:SWAGGER,:SLEEPTALK,:SUBSTITUTE,:DARKPULSE,
                     :CONFIDE,
                     # Move Tutors
                     :AQUATAIL,:COVET,:FOULPLAY,:HEALBELL,:ICYWIND,:IRONTAIL,
                     :PAINSPLIT,:ROLEPLAY,:SNORE,:SPITE,:ZENHEADBUTT]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"wildHoldItems"=>proc{|pokemon|
   next if pokemon.form==0                 # Normal
   next [0,getID(PBItems,:SNOWBALL),0]     # Alola
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:SNOWCLOAK)
   elsif pokemon.abilityIndex==1 || (pokemon.abilityflag && pokemon.abilityflag==1)
     next getID(PBAbilities,:SNOWWARNING)  
   elsif pokemon.abilityIndex==2 && !pokemon.abilityflag
     check = rand(2)
     next getID(PBAbilities,:SNOWCLOAK) if check==0
     next getID(PBAbilities,:SNOWWARNING) if check==1
   end
},
"getEvo"=>proc{|pokemon|
   next if pokemon.form==0                  # Normal
   next [[7,692,38]]                        # Alola    [Item,Ice Stone,Ninetales]  
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:NINETALES,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "Possessing a calm demeanor, this Pokémon was revered as a deity incarnate before it was identified as a regional variant of Ninetales."     # Alola
},
"type1"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:ICE)     # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:FAIRY)   # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[0,:DAZZLINGGLEAM],[1,:IMPRISON],[1,:NASTYPLOT],
                        [1,:ICEBEAM],[1,:ICESHARD],[1,:CONFUSERAY],
                        [1,:SAFEGUARD]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :PSYCHOCK,:CALMMIND,:ROAR,:TOXIC,:HAIL,:HIDDENPOWER,
                     :ICEBEAM,:BLIZZARD,:HYPERBEAM,:PROTECT,:RAINDANCE,
                     :SAFEGUARD,:FRUSTRATION,:RETURN,:DOUBLETEAM,:FACADE,
                     :REST,:ATTRACT,:ROUND,:PAYBACK,:GIGAIMPACT,:AURORAVEIL,
                     :PSYCHUP,:FROSTBREATH,:DREAMEATER,:SWAGGER,:SLEEPTALK,
                     :SUBSTITUTE,:DARKPULSE,:DAZZLINGGLEAM,:CONFIDE,
                     # Move Tutors
                     :AQUATAIL,:COVET,:FOULPLAY,:HEALBELL,:ICYWIND,:IRONTAIL,
                     :LASERFOCUS,:PAINSPLIT,:ROLEPLAY,:SNORE,:SPITE,
                     :WONDERROOM,:ZENHEADBUTT]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"wildHoldItems"=>proc{|pokemon|
   next if pokemon.form==0                 # Normal
   next [0,getID(PBItems,:SNOWBALL),0]     # Alola
},
"evYield"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next [0,0,0,2,0,0]           # Alola
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next [73,67,75,109,81,100]   # Alola
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:SNOWCLOAK)
   elsif pokemon.abilityIndex==1 || (pokemon.abilityflag && pokemon.abilityflag==1)
     next getID(PBAbilities,:SNOWWARNING)  
   elsif pokemon.abilityIndex==2 && !pokemon.abilityflag
     check = rand(2)
     next getID(PBAbilities,:SNOWCLOAK) if check==0
     next getID(PBAbilities,:SNOWWARNING) if check==1
   end
},

"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:DIGLETT,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "Its head sports an altered form of whiskers made of metal. When in communication with its comrades, its whiskers wobble to and fro."  # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 1.0                     # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:STEEL)   # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[1,:SANDATTACK],[1,:METALCLAW],[4,:GROWL],
                        [7,:ASTONISH],[10,:MUDSLAP],[14,:MAGNITUDE],
                        [18,:BULLDOZE],[22,:SUCKERPUNCH],[25,:MUDBOMB],
                        [28,:EARTHPOWER],[31,:DIG],[35,:IRONHEAD],
                        [39,:EARTHQUAKE],[43,:FISSURE]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getEggMoves"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   eggmovelist=[]
   case pokemon.form            # Alola
     when 1 ; eggmovelist=[:ANCIENTPOWER,:BEATUP,:ENDURE,:FEINTATTACK,
                           :FINALGAMBIT,:HEADBUTT,:MEMENTO,:METALSOUND,
                           :PURSUIT,:REVERSAL,:FLASH]
   end
   for i in eggmovelist
     i=getID(PBMoves,i)
   end
   next eggmovelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :WORKUP,:TOXIC,:HIDDENPOWER,:SUNNYDAY,:PROTECT,:FRUSTRATION,
                     :EARTHQUAKE,:RETURN,:DOUBLETEAM,:SLUDGEBOMB,:SANDSTORM,
                     :ROCKTOMB,:AERIALACE,:FACADE,:REST,:ATTRACT,:THIEF,:ROUND,
                     :ECHOEDVOICE,:SHADOWCLAW,:BULLDOZE,:ROCKSLIDE,:SWAGGER,
                     :SLEEPTALK,:SUBSTITUTE,:FLASHCANNON,:CONFIDE,
                     # Move Tutors
                     :EARTHPOWER,:IRONDEFENSE,:IRONHEAD,:SNORE,
                     :STEALTHROCK,:STOMPINGTANTRUM]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next [10,55,30,90,35,40]     # Alola
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==1 || (pokemon.abilityflag && pokemon.abilityflag==1) # Alola
     next getID(PBAbilities,:TANGLINGHAIR) 
   end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
},
   "getFormOnCreation"=>proc{|pokemon|
   maps=[97,116,403,404]   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 1
   else
     next 0
   end
}
})

MultipleForms.register(:DUGTRIO,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "Its shining gold hair provides it with protection. It’s reputed that keeping any of its fallen hairs will bring bad luck."  # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 66.6                    # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:STEEL)   # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[0,:SANDTOMB],[1,:ROTOTILLER],[1,:NIGHTSLASH],
                        [1,:TRIATTACK],[1,:SANDATTACK],[1,:METALCLAW],[1,:GROWL],
                        [4,:GROWL],[7,:ASTONISH],[10,:MUDSLAP],[14,:MAGNITUDE],
                        [18,:BULLDOZE],[22,:SUCKERPUNCH],[25,:MUDBOMB],
                        [30,:EARTHPOWER],[35,:DIG],[41,:IRONHEAD],
                        [47,:EARTHQUAKE],[53,:FISSURE]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :WORKUP,:TOXIC,:HIDDENPOWER,:SUNNYDAY,:HYPERBEAM,:PROTECT,
                     :FRUSTRATION,:EARTHQUAKE,:RETURN,:DOUBLETEAM,:SLUDGEWAVE,
                     :SLUDGEBOMB,:SANDSTORM,:ROCKTOMB,:AERIALACE,:FACADE,:REST,
                     :ATTRACT,:THIEF,:ROUND,:ECHOEDVOICE,:SHADOWCLAW,:GIGAIMPACT,
                     :STONEEDGE,:BULLDOZE,:ROCKSLIDE,:SWAGGER,:SLEEPTALK,
                     :SUBSTITUTE,:FLASHCANNON,:CONFIDE,
                     # Move Tutors
                     :EARTHPOWER,:IRONDEFENSE,:IRONHEAD,:SNORE,
                     :STEALTHROCK,:STOMPINGTANTRUM]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"evYield"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next [0,2,0,0,0,0]           # Alola
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next [35,100,60,110,50,70]     # Alola
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==1 || (pokemon.abilityflag && pokemon.abilityflag==1) # Alola
     next getID(PBAbilities,:TANGLINGHAIR) 
   end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:MEOWTH,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "When its delicate pride is wounded, or when the gold coin on its forehead is dirtied, it flies into a hysterical rage."  # Alola
},
"type1"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:DARK)    # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:DARK)    # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[1,:SCRATCH],[1,:GROWL],[6,:BITE],
                        [9,:FAKEOUT],[14,:FURYSWIPES],[17,:SCREECH],
                        [22,:FEINTATTACK],[25,:TAUNT],[30,:PAYDAY],
                        [33,:SLASH],[38,:NASTYPLOT],[41,:ASSURANCE],
                        [46,:CAPTIVATE],[49,:NIGHTSLASH],[50,:FEINT],
                        [55,:DARKPULSE]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getEggMoves"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   eggmovelist=[]
   case pokemon.form            # Alola
     when 1 ; eggmovelist=[:AMNESIA,:ASSIST,:CHARM,:COVET,:FLAIL,:FLATTER,
                           :FOULPLAY,:HYPNOSIS,:PARTINGSHOT,:PUNISHMENT,
                           :SNATCH,:SPITE]
   end
   for i in eggmovelist
     i=getID(PBMoves,i)
   end
   next eggmovelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :WORKUP,:TOXIC,:HIDDENPOWER,:SUNNYDAY,:TAUNT,:PROTECT,
                     :RAINDANCE,:FRUSTRATION,:THUNDERBOLT,:THUNDER,:RETURN,
                     :SHADOWBALL,:DOUBLETEAM,:AERIALACE,:TORMENT,:FACADE,:REST,
                     :ATTRACT,:THIEF,:ROUND,:ECHOEDVOICE,:QUASH,:EMBARGO,
                     :SHADOWCLAW,:PAYBACK,:PSYCHUP,:DREAMEATER,:SWAGGER,
                     :SLEEPTALK,:UTURN,:SUBSTITUTE,:DARKPULSE,:CONFIDE,
                     # Move Tutors
                     :COVET,:FOULPLAY,:GUNKSHOT,:HYPERVOICE,:ICEWIND,:IRONTAIL,
                     :KNOCKOFF,:LASTRESORT,:SEEDBOMB,:SHOCKWAVE,:SNATCH,:SNORE,
                     :SPITE,:THROATCHOP,:UPROAR,:WATERPULSE]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next [40,35,35,90,50,40]     # Alola
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==2 || (pokemon.abilityflag && pokemon.abilityflag==2) # Alola
     next getID(PBAbilities,:RATTLED)  
   end
},
"getEvo"=>proc{|pokemon|
   next if pokemon.form==0                  # Normal
   next [[1,0,53]]                          # Alola    [Happiness,,Persian]  
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
},
   "getFormOnCreation"=>proc{|pokemon|
   maps=[24,390,391]   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 1
   else
     next 0
   end
}
})

MultipleForms.register(:PERSIAN,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "It looks down on everyone other than itself. Its preferred tactics are sucker punches and blindside attacks."  # Alola
},
"height"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 1.1                     # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 33.0                    # Alola
},
"type1"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:DARK)    # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:DARK)    # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[0,:SWIFT],[1,:QUASH],[1,:PLAYROUGH],[1,:SWITCHEROO],
                        [1,:SCRATCH],[1,:GROWL],[1,:BITE],[1,:FAKEOUT],[6,:BITE],                        
                        [9,:FAKEOUT],[14,:FURYSWIPES],[17,:SCREECH],
                        [22,:FEINTATTACK],[25,:TAUNT],[32,:POWERGEM],
                        [37,:SLASH],[44,:NASTYPLOT],[49,:ASSURANCE],
                        [56,:CAPTIVATE],[61,:NIGHTSLASH],[65,:FEINT],
                        [69,:DARKPULSE]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :WORKUP,:ROAR,:TOXIC,:HIDDENPOWER,:SUNNYDAY,:TAUNT,
                     :HYPERBEAM,:PROTECT,:RAINDANCE,:FRUSTRATION,:THUNDERBOLT,
                     :THUNDER,:RETURN,:SHADOWBALL,:DOUBLETEAM,:AERIALACE,:TORMENT,
                     :FACADE,:REST,:ATTRACT,:THIEF,:ROUND,:ECHOEDVOICE,:QUASH,
                     :EMBARGO,:SHADOWCLAW,:PAYBACK,:GIGAIMPACT,:PSYCHUP,
                     :DREAMEATER,:SWAGGER,:SLEEPTALK,:UTURN,:SUBSTITUTE,:SNARL,
                     :DARKPULSE,:CONFIDE,
                     # Move Tutors
                     :COVET,:FOULPLAY,:GUNKSHOT,:HYPERVOICE,:ICEWIND,:IRONTAIL,
                     :KNOCKOFF,:LASTRESORT,:SEEDBOMB,:SHOCKWAVE,:SNATCH,:SNORE,
                     :SPITE,:THROATCHOP,:UPROAR,:WATERPULSE]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next [65,60,60,115,75,65]    # Alola
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:FURCOAT)
   elsif pokemon.abilityIndex==2 || (pokemon.abilityflag && pokemon.abilityflag==2)
     next getID(PBAbilities,:RATTLED)  
   end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
},
   "getFormOnCreation"=>proc{|pokemon|
   maps=[390,391]   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 1
   else
     next 0
   end
}
})

MultipleForms.register(:GEODUDE,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "If you accidentally step on a Geodude sleeping on the ground, you’ll hear a crunching sound and feel a shock ripple through your entire body."  # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 20.3                    # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:ELECTRIC)# Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[1,:TACKLE],[1,:DEFENSECURL],[4,:CHARGE],
                        [6,:ROCKPOLISH],[10,:ROLLOUT],[12,:SPARK],
                        [16,:ROCKTHROW],[18,:SMACKDOWN],[22,:THUNDERPUNCH],
                        [24,:SELFDESTRUCT],[28,:STEALTHROCK],[30,:ROCKBLAST],
                        [34,:DISCHARGE],[36,:EXPLOSION],[40,:DOUBLEEDGE],
                        [42,:STONEEDGE]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getEggMoves"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   eggmovelist=[]
   case pokemon.form            # Alola
     when 1 ; eggmovelist=[:AUTOTOMIZE,:BLOCK,:COUNTER,:CURSE,:ENDURE,:FLAIL,
                           :MAGNETRISE,:ROCKCLIMB,:SCREECH,:WIDEGUARD]
   end
   for i in eggmovelist
     i=getID(PBMoves,i)
   end
   next eggmovelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :TOXIC,:HIDDENPOWER,:SUNNYDAY,:PROTECT,:FRUSTRATION,
                     :SMACKDOWN,:THUNDERBOLT,:THUNDER,:EARTHQUAKE,:RETURN,
                     :BRICKBREAK,:DOUBLETEAM,:FLAMETHROWER,:SANDSTORM,
                     :FIREBLAST,:ROCKTOMB,:FACADE,:REST,:ATTRACT,:ROUND,
                     :FLING,:CHARGEBEAM,:BRUTALSWING,:EXPLOSION,:ROCKPOLISH,
                     :STONEEDGE,:VOLTSWITCH,:GYROBALL,:BULLDOZE,:ROCKSLIDE,
                     :SWAGGER,:SLEEPTALK,:SUBSTITUTE,:NATUREPOWER,:CONFIDE,
                     # Move Tutors
                     :BLOCK,:EARTHPOWER,:ELECTROWEB,:FIREPUNCH,:FOCUSPUNCH,
                     :IRONDEFENSE,:MAGNETRISE,:SNORE,:STEALTHROCK,
                     :SUPERPOWER,:THUNDERPUNCH]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:MAGNETPULL)  
   elsif pokemon.abilityIndex==2 || (pokemon.abilityflag && pokemon.abilityflag==2)
     next getID(PBAbilities,:GALVANIZE)       
   end
},
"wildHoldItems"=>proc{|pokemon|
   next if pokemon.form==0                 # Normal
   next [0,getID(PBItems,:CELLBATTERY),0]  # Alola
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:GRAVELER,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "They eat rocks and often get into a scrap over them. The shock of Graveler smashing together causes a flash of light and a booming noise."  # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 110.0                   # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:ELECTRIC)# Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[1,:TACKLE],[1,:DEFENSECURL],[1,:CHARGE],[1,:ROCKPOLISH],
                        [4,:CHARGE],[6,:ROCKPOLISH],[10,:ROLLOUT],[12,:SPARK],
                        [16,:ROCKTHROW],[18,:SMACKDOWN],[22,:THUNDERPUNCH],
                        [24,:SELFDESTRUCT],[30,:STEALTHROCK],[34,:ROCKBLAST],
                        [40,:DISCHARGE],[44,:EXPLOSION],[50,:DOUBLEEDGE],
                        [54,:STONEEDGE]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :TOXIC,:HIDDENPOWER,:SUNNYDAY,:PROTECT,:FRUSTRATION,
                     :SMACKDOWN,:THUNDERBOLT,:THUNDER,:EARTHQUAKE,:RETURN,
                     :BRICKBREAK,:DOUBLETEAM,:FLAMETHROWER,:SANDSTORM,
                     :FIREBLAST,:ROCKTOMB,:FACADE,:REST,:ATTRACT,:ROUND,
                     :FLING,:CHARGEBEAM,:BRUTALSWING,:EXPLOSION,:ROCKPOLISH,
                     :STONEEDGE,:VOLTSWITCH,:GYROBALL,:BULLDOZE,:ROCKSLIDE,
                     :SWAGGER,:SLEEPTALK,:SUBSTITUTE,:NATUREPOWER,:CONFIDE,
                     # Move Tutors
                     :ALLYSWITCH,:BLOCK,:EARTHPOWER,:ELECTROWEB,:FIREPUNCH,
                     :FOCUSPUNCH,:IRONDEFENSE,:MAGNETRISE,:SHOCKWAVE,:SNORE,
                     :STEALTHROCK,:STOMPINGTANTRUM,:SUPERPOWER,:THUNDERPUNCH]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:MAGNETPULL)  
   elsif pokemon.abilityIndex==2 || (pokemon.abilityflag && pokemon.abilityflag==2)
     next getID(PBAbilities,:GALVANIZE)       
   end
},
"wildHoldItems"=>proc{|pokemon|
   next if pokemon.form==0                 # Normal
   next [0,getID(PBItems,:CELLBATTERY),0]  # Alola
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
},
   "getFormOnCreation"=>proc{|pokemon|
   maps=[269,289,419,489]   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 1
   else
     next 0
   end
}
})

MultipleForms.register(:GOLEM,{
"getMegaForm"=>proc{|pokemon|
   next 2 if isConst?(pokemon.item,PBItems,:DEMONSTONE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0 if pokemon.form==2
   next
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Rift Golem") if pokemon.form==2
   next
},

"dexEntry"=>proc{|pokemon|
  case pokemon.form
  when 0  # Normal
    next
  when 1  # Alola
    next "Because it can’t fire boulders at a rapid pace, it’s been known to seize nearby Geodude and fire them from its back."  # Alola
  when 2  # Rift
    next
  end
},
"getBaseStats"=>proc{|pokemon|
  case pokemon.form
  when 0  # Normal
    next
  when 1  # Alola
    next
  when 2  # Rift
    next [100,100,150,10,100,150]
  end
},
"height"=>proc{|pokemon|
  case pokemon.form
  when 0  # Normal
    next
  when 1  # Alola
    next 1.7
  when 2  # Rift
    next
  end
},
"weight"=>proc{|pokemon|
  case pokemon.form
  when 0  # Normal
    next
  when 1  # Alola
    next 316.0
  when 2  # Rift
    next 256.0
  end
},
"type1"=>proc{|pokemon|
  case pokemon.form
  when 0  # Normal
    next
  when 1  # Alola
    next
  when 2  # Rift
    next getID(PBTypes,:DARK)
  end
},
"type2"=>proc{|pokemon|
  case pokemon.form
  when 0  # Normal
    next
  when 1  # Alola
    next getID(PBTypes,:ELECTRIC)
  when 2  # Rift
    next getID(PBTypes,:FIGHTING)
  end
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[1,:HEAVYSLAM],[1,:TACKLE],[1,:DEFENSECURL],[1,:CHARGE],
                        [1,:ROCKPOLISH],[4,:CHARGE],[6,:ROCKPOLISH],[10,:STEAMROLLER],
                        [12,:SPARK],[16,:ROCKTHROW],[18,:SMACKDOWN],[22,:THUNDERPUNCH],
                        [24,:SELFDESTRUCT],[30,:STEALTHROCK],[34,:ROCKBLAST],
                        [40,:DISCHARGE],[44,:EXPLOSION],[50,:DOUBLEEDGE],
                        [54,:STONEEDGE],[60,:HEAVYSLAM]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :ROAR,:TOXIC,:HIDDENPOWER,:SUNNYDAY,:HYPERBEAM,:PROTECT,
                     :FRUSTRATION,:SMACKDOWN,:THUNDERBOLT,:THUNDER,:EARTHQUAKE,
                     :RETURN,:BRICKBREAK,:DOUBLETEAM,:FLAMETHROWER,:SANDSTORM,
                     :FIREBLAST,:ROCKTOMB,:FACADE,:REST,:ATTRACT,:ROUND,
                     :ECHOEDVOICE,:FOCUSBLAST,:FLING,:CHARGEBEAM,:BRUTALSWING,
                     :EXPLOSION,:GIGAIMPACT,:ROCKPOLISH,:STONEEDGE,:VOLTSWITCH,
                     :GYROBALL,:BULLDOZE,:ROCKSLIDE,:SWAGGER,:SLEEPTALK,
                     :SUBSTITUTE,:WILDCHARGE,:NATUREPOWER,:CONFIDE,
                     # Move Tutors
                     :ALLYSWITCH,:BLOCK,:EARTHPOWER,:ELECTROWEB,:FIREPUNCH,
                     :FOCUSPUNCH,:IRONDEFENSE,:MAGNETRISE,:SHOCKWAVE,:SNORE,
                     :STEALTHROCK,:STOMPINGTANTRUM,:SUPERPOWER,:THUNDERPUNCH]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"ability"=>proc{|pokemon|
  case pokemon.form
  when 0 # Normal
    next
  when 1 # Alola
    if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0)
      next getID(PBAbilities,:MAGNETPULL)  
    elsif pokemon.abilityIndex==1 || (pokemon.abilityflag && pokemon.abilityflag==1)
      next getID(PBAbilities,:STURDY)
    elsif pokemon.abilityIndex==2 || (pokemon.abilityflag && pokemon.abilityflag==2)
      next getID(PBAbilities,:GALVANIZE)       
    end
  when 2 # Rift
    next getID(PBAbilities,:CONTRARY)
  end  
},
"wildHoldItems"=>proc{|pokemon|
  case pokemon.form
  when 0
    next          # Normal
  when 1
   next [0,0,getID(PBItems,:CELLBATTERY)]  # Alola
 end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:GRIMER,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "The crystals on Grimer’s body are lumps of toxins. If one falls off, lethal poisons leak out."  # Alola
},
"height"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 0.7                     # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 42.0                    # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:DARK)    # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[1,:POUND],[1,:POISONGAS],[4,:HARDEN],[7,:BITE],
                        [12,:DISABLE],[15,:ACIDSPRAY],[18,:POISONFANG],
                        [21,:MINIMIZE],[26,:FLING],[29,:KNOCKOFF],[32,:CRUNCH],
                        [37,:SCREECH],[40,:GUNKSHOT],[43,:ACIDARMOR],
                        [46,:BELCH],[48,:MEMENTO]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getEggMoves"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   eggmovelist=[]
   case pokemon.form            # Alola
     when 1 ; eggmovelist=[:ASSURANCE,:CLEARSMOG,:CURSE,:IMPRISON,:MEANLOOK,
                           :PURSUIT,:SCARYFACE,:SHADOWSNEAK,:SPITE,
                           :SPITUP,:STOCKPILE,:SWALLOW,:POWERUPPUNCH]
   end
   for i in eggmovelist
     i=getID(PBMoves,i)
   end
   next eggmovelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :TOXIC,:VENOSHOCK,:HIDDENPOWER,:SUNNYDAY,:TAUNT,:PROTECT,
                     :RAINDANCE,:FRUSTRATION,:RETURN,:SHADOWBALL,:DOUBLETEAM,
                     :SLUDGEWAVE,:FLAMETHROWER,:SLUDGEBOMB,:FIREBLAST,:ROCKTOMB,
                     :TORMENT,:FACADE,:REST,:ATTRACT,:THIEF,:ROUND,:FLING,
                     :BRUTALSWING,:QUASH,:EMBARGO,:EXPLOSION,:PAYBACK,
                     :ROCKPOLISH,:STONEEDGE,:ROCKSLIDE,:INFESTATION,:POISONJAB,
                     :SWAGGER,:SLEEPTALK,:SUBSTITUTE,:SNARL,:CONFIDE,
                     # Move Tutors
                     :FIREPUNCH,:GASTROACID,:GIGADRAIN,:GUNKSHOT,:ICEPUNCH,
                     :KNOCKOFF,:PAINSPLIT,:SHOCKWAVE,:SNORE,:THUNDERPUNCH]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:POISONTOUCH) 
   elsif pokemon.abilityIndex==1 || (pokemon.abilityflag && pokemon.abilityflag==1)
     next getID(PBAbilities,:GLUTTONY)     
   elsif pokemon.abilityIndex==2 || (pokemon.abilityflag && pokemon.abilityflag==2)
     next getID(PBAbilities,:POWEROFALCHEMY)       
   end
},
     "getFormOnCreation"=>proc{|pokemon|
   maps=[64,66,138]   # Map IDs for second form
   if $game_map && maps.include?($game_map.map_id)
     next 1
   else
     next 0
   end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:MUK,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form!=1      # Normal
   next "While it’s unexpectedly quiet and friendly, if it’s not fed any trash for a while, it will smash its Trainer’s furnishings and eat up the fragments."  # Alola
},
"height"=>proc{|pokemon|
   next if pokemon.form!=1      # Normal/PULSE
   next 0.7                     # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form!=1      # Normal/PULSE
   next 42.0                    # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form!=1      # Normal/PULSE
   next getID(PBTypes,:DARK)    # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form!=1      # Normal/PULSE
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[0,:VENOMDRENCH],[1,:POUND],[1,:POISONGAS],[1,:HARDEN],
                        [1,:BITE],[4,:HARDEN],[7,:BITE],[12,:DISABLE],[15,:ACIDSPRAY],
                        [18,:POISONFANG],[21,:MINIMIZE],[26,:FLING],[29,:KNOCKOFF],
                        [32,:CRUNCH],[37,:SCREECH],[40,:GUNKSHOT],[46,:ACIDARMOR],                        
                        [52,:BELCH],[57,:MEMENTO]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :TOXIC,:VENOSHOCK,:HIDDENPOWER,:SUNNYDAY,:TAUNT,:HYPERBEAM,
                     :PROTECT,:RAINDANCE,:FRUSTRATION,:RETURN,:SHADOWBALL,
                     :BRICKBREAK,:DOUBLETEAM,:SLUDGEWAVE,:FLAMETHROWER,
                     :SLUDGEBOMB,:FIREBLAST,:ROCKTOMB,:TORMENT,:FACADE,:REST,
                     :ATTRACT,:THIEF,:ROUND,:FOCUSBLAST,:FLING,:BRUTALSWING,
                     :QUASH,:EMBARGO,:EXPLOSION,:PAYBACK,:GIGAIMPACT,:ROCKPOLISH,
                     :STONEEDGE,:ROCKSLIDE,:INFESTATION,:POISONJAB,:SWAGGER,
                     :SLEEPTALK,:SUBSTITUTE,:SNARL,:DARKPULSE,:CONFIDE,
                     # Move Tutors
                     :BLOCK,:FIREPUNCH,:FOCUSPUNCH,:GASTROACID,:GIGADRAIN,
                     :GUNKSHOT,:ICEPUNCH,:KNOCKOFF,:PAINSPLIT,:RECYCLE,
                     :SHOCKWAVE,:SNORE,:SPITE,:THUNDERPUNCH]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"getUnmegaForm"=>proc{|pokemon|
  if pokemon.form == 2
   next 0
 else
   next nil
 end   
},
"getMegaName"=>proc{|pokemon|
   next _INTL("PULSE Muk") if pokemon.form==2     # PULSE
   next                                           # Normal/Alola
},
"getBaseStats"=>proc{|pokemon|
   next [105,105,70,40,97,250] if pokemon.form==2 # PULSE
   next                                           # Normal/Alola 
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   next getID(PBAbilities,:PROTEAN) if pokemon.form==2 # PULSE
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:POISONTOUCH) 
   elsif pokemon.abilityIndex==1 || (pokemon.abilityflag && pokemon.abilityflag==1)
     next getID(PBAbilities,:GLUTTONY)     
   elsif pokemon.abilityIndex==2 || (pokemon.abilityflag && pokemon.abilityflag==2)
     next getID(PBAbilities,:POWEROFALCHEMY)       
   end   
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:EXEGGUTOR,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "As it grew taller and taller, it outgrew its reliance on psychic powers, while within it awakened the power of the sleeping dragon."  # Alola
},
"height"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 10.9                    # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 415.6                   # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:DRAGON)  # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[0,:DRAGONHAMMER],[1,:SEEDBOMB],[1,:BARRAGE],
                        [1,:HYPNOSIS],[1,:CONFUSION],[17,:PSYSHOCK],
                        [27,:EGGBOMB],[37,:WOODHAMMER],[47,:LEAFSTORM]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :PSYSHOCK,:TOXIC,:HIDDENPOWER,:SUNNYDAY,:HYPERBEAM,
                     :LIGHTSCREEN,:PROTECT,:FRUSTRATION,:SOLARBEAM,
                     :EARTHQUAKE,:RETURN,:PSYCHIC,:BRICKBREAK,:DOUBLETEAM,
                     :REFLECT,:FLAMETHROWER,:SLUDGEBOMB,:FACADE,:REST,:ATTRACT,
                     :THIEF,:ROUND,:ENERGYBALL,:BRUTALSWING,:EXPLOSION,
                     :GIGAIMPACT,:SWORDSDANCE,:PSYCHUP,:BULLDOZE,:DRAGONTAIL,
                     :INFESTATION,:DREAMEATER,:GRASSKNOT,:SWAGGER,:SLEEPTALK,
                     :SUBSTITUTE,:TRICKROOM,:NATUREPOWER,:CONFIDE,
                     # Move Tutors
                     :BLOCK,:DRACOMETEOR,:DRAGONPULSE,:GIGADRAIN,:GRAVITY,
                     :IRONHEAD,:IRONTAIL,:KNOCKOFF,:LOWKICK,:OUTRAGE,:SEEDBOMB,
                     :SKILLSWAP,:SNORE,:STOMPINGTANTRUM,:SUPERPOWER,:SYNTHESIS,
                     :TELEKINESIS,:WORRYSEED,:ZENHEADBUTT]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next [95,105,85,45,125,75]   # Alola
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:FRISK)
   elsif pokemon.abilityIndex==2 && !pokemon.abilityflag
     check = rand(2)
     next getID(PBAbilities,:FRISK) if check==0
     next getID(PBAbilities,:HARVEST) if check==1
   end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:MAROWAK,{
"dexEntry"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next "The bones it possesses were once its mother’s. Its mother’s regrets have become like a vengeful spirit protecting this Pokémon."  # Alola
},
"weight"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next 34.0                    # Alola
},
"type1"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:FIRE)    # Alola
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   next getID(PBTypes,:GHOST)   # Alola
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0      # Normal
   movelist=[]
   case pokemon.form            # Alola
     when 1 ; movelist=[[1,:GROWL],[1,:TAILWHIP],[1,:BONECLUB],[1,:FLAMEWHEEL],
                        [3,:TAILWHIP],[7,:BONECLUB],[11,:FLAMEWHEEL],[13,:LEER],
                        [17,:HEX],[21,:BONEMERANG],[23,:WILLOWISP],
                        [27,:SHADOWBONE],[33,:THRASH],[37,:FLING],
                        [43,:STOMPINGTANTRUM],[49,:ENDEAVOR],[53,:FLAREBLITZ],
                        [59,:RETALIATE],[65,:BONERUSH]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
},
"getMoveCompatibility"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
   when 1; movelist=[# TMs
                     :TOXIC,:HIDDENPOWER,:SUNNYDAY,:ICEBEAM,:BLIZZARD,:HYPERBEAM,
                     :PROTECT,:RAINDANCE,:FRUSTRATION,:SMACKDOWN,:THUNDERBOLT,
                     :THUNDER,:EARTHQUAKE,:RETURN,:SHADOWBALL,:BRICKBREAK,
                     :DOUBLETEAM,:REFLECT,:FLAMETHROWER,:SANDSTORM,:FIREBLAST,
                     :ROCKTOMB,:AERIALACE,:FACADE,:FLAMECHARGE,:REST,:ATTRACT,
                     :THIEF,:ROUND,:ECHOEDVOICE,:FOCUSBLAST,:FALSESWIPE,
                     :FLING,:BRUTALSWING,:WILLOWISP,:GIGAIMPACT,:STONEEDGE,
                     :SWORDSDANCE,:BULLDOZE,:ROCKSLIDE,:DREAMEATER,:SWAGGER,
                     :SLEEPTALK,:SUBSTITUTE,:DARKPULSE,:CONFIDE,
                     # Move Tutors
                     :ALLYSWITCH,:EARTHPOWER,:ENDEAVOR,:FIREPUNCH,:FOCUSPUNCH,
                     :HEATWAVE,:ICYWIND,:IRONDEFENSE,:IRONHEAD,:IRONTAIL,
                     :KNOCKOFF,:LASERFOCUS,:OUTRAGE,:PAINSPLIT,:SNORE,:SPITE,
                     :STEALTHROCK,:STOMPINGTANTRUM,:THROATCHOP,:THUNDERPUNCH,
                     :UPROAR]
   end
   for i in 0...movelist.length
     movelist[i]=getConst(PBMoves,movelist[i])
   end
   next movelist
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0 # Normal
   if pokemon.abilityIndex==0 || (pokemon.abilityflag && pokemon.abilityflag==0) # Alola
     next getID(PBAbilities,:CURSEDBODY) 
   elsif pokemon.abilityIndex==2 || (pokemon.abilityflag && pokemon.abilityflag==2) 
     next getID(PBAbilities,:ROCKHEAD)      
   end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

## End of Regional Variants ##

#### KUROTSUNE - 001 - START
MultipleForms.register(:KYOGRE,{
"getMegaName"=>proc{|pokemon|
   next _INTL("Primal Kyogre") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0     
   next [100,150,90,90,180,160] # Primal
},
"ability"=>proc{|pokemon|
   next if pokemon.form==0               
   next getID(PBAbilities,:PRIMORDIALSEA) # Primal
},
"height"=>proc{|pokemon|
   next 65 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 490 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})


MultipleForms.register(:GROUDON,{
"getMegaName"=>proc{|pokemon|
   next _INTL("Primal Groudon") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0     
   next [100,180,160,90,150,90] # Primal
},
"type2"=>proc{|pokemon|
   next if pokemon.form==0     
   next getID(PBTypes,:FIRE)  # Primal
},   
"ability"=>proc{|pokemon|
   next if pokemon.form==0               
   next getID(PBAbilities,:DESOLATELAND) # Primal
},
"height"=>proc{|pokemon|
   next 65 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 490 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})



#### KUROTSUNE - 001 - END
##### Mega Evolution forms #####################################################


MultipleForms.register(:VENUSAUR,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:VENUSAURITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Venusaur") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [80,100,123,80,122,120] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:THICKFAT) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 24 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 1555 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:CHARIZARD,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:CHARIZARDITEX)
   next 2 if isConst?(pokemon.item,PBItems,:CHARIZARDITEY)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Charizard X") if pokemon.form==1
   next _INTL("Mega Charizard Y") if pokemon.form==2
   next
},
"getBaseStats"=>proc{|pokemon|
   next [78,130,111,100,130,85] if pokemon.form==1
   next [78,104,78,100,159,115] if pokemon.form==2
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:DRAGON) if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:TOUGHCLAWS) if pokemon.form==1
   next getID(PBAbilities,:DROUGHT) if pokemon.form==2
   next
},
"weight"=>proc{|pokemon|
   next 1105 if pokemon.form==1
   next 1005 if pokemon.form==2
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:BLASTOISE,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:BLASTOISINITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Blastoise") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [79,103,120,78,135,115] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:MEGALAUNCHER) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 1011 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:ALAKAZAM,{

"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:ALAKAZITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Alakazam") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [55,50,65,150,175,105] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:TRACE) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 480 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:GENGAR,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:GENGARITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Gengar") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [60,65,80,130,170,95] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SHADOWTAG) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 405 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:KANGASKHAN,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:KANGASKHANITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Kangaskhan") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [105,125,100,100,60,100] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
#### KUROTSUNE - 004 - START
   next getID(PBAbilities,:PARENTALBOND) if pokemon.form==1
#### KUROTSUNE - 004 - END
   next
},
"weight"=>proc{|pokemon|
   next 1000 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:PINSIR,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:PINSIRITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Pinsir") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [65,155,120,105,65,90] if pokemon.form==1
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:FLYING) if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:AERILATE) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 590 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:AERODACTYL,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:AERODACTYLITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Aerodactyl") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [80,135,85,150,70,95] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:TOUGHCLAWS) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 790 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:MEWTWO,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:MEWTWONITEX)
   next 2 if isConst?(pokemon.item,PBItems,:MEWTWONITEY)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Mewtwo X") if pokemon.form==1
   next _INTL("Mega Mewtwo Y") if pokemon.form==2
   next
},
"getBaseStats"=>proc{|pokemon|
   next [106,190,100,130,154,100] if pokemon.form==1
   next [106,150,70,140,194,120] if pokemon.form==2
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:FIGHTING) if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:STEADFAST) if pokemon.form==1
   next getID(PBAbilities,:INSOMNIA) if pokemon.form==2
   next
},
"weight"=>proc{|pokemon|
   next 1270 if pokemon.form==1
   next 330 if pokemon.form==2
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:AMPHAROS,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:AMPHAROSITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Ampharos") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [90,95,105,45,165,110] if pokemon.form==1
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:DRAGON) if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:MOLDBREAKER) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 615 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:SCIZOR,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:SCIZORITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Scizor") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [70,150,140,75,65,100] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:TECHNICIAN) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 1250 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:HERACROSS,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:HERACRONITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Heracross") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [80,185,115,75,40,105] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SKILLLINK) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 625 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:HOUNDOOM,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:HOUNDOOMINITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Houndoom") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [75,90,90,115,140,90] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SOLARPOWER) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 495 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:TYRANITAR,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:TYRANITARITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Tyranitar") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [100,164,150,71,95,120] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SANDSTREAM) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 2550 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:BLAZIKEN,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:BLAZIKENITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Blaziken") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [80,160,80,100,130,80] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SPEEDBOOST) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 520 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:GARDEVOIR,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:GARDEVOIRITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Gardevoir") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [68,85,65,100,165,135] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:PIXILATE) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 484 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:MAWILE,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:MAWILITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Mawile") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [50,105,125,50,55,95] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:HUGEPOWER) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 235 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:AGGRON,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:AGGRONITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Aggron") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [70,140,230,50,60,80] if pokemon.form==1
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:STEEL) if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:FILTER) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 3950 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:MEDICHAM,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:MEDICHAMITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Medicham") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [60,100,85,100,80,85] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:PUREPOWER) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 315 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:MANECTRIC,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:MANECTITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Manectric") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [70,75,80,135,135,80] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:INTIMIDATE) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 440 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:BANETTE,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:BANETTITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Banette") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [64,165,75,75,93,83] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:PRANKSTER) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 130 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:ABSOL,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:ABSOLITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Absol") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [65,150,60,115,115,60] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:MAGICBOUNCE) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 490 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:GARCHOMP,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:GARCHOMPITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Garchomp") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [108,170,115,92,120,95] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SANDFORCE) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 950 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:LUCARIO,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:LUCARIONITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Lucario") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [70,145,88,112,140,70] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:ADAPTABILITY) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 575 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:ABOMASNOW,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:ABOMASITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Abomasnow") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [90,132,105,30,132,105] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SNOWWARNING) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 1850 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:BEEDRILL,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:BEEDRILLITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Beedrill") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [65,150,40,145,15,80] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:ADAPTABILITY) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 14 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 40.5 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:PIDGEOT,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:PIDGEOTITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Pidgeot") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [83,80,80,121,135,80] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:NOGUARD) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 22 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 50.5 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:SLOWBRO,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:SLOWBRONITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Slowbro") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [95,75,180,30,130,80] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SHELLARMOR) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 20 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 120 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:STEELIX,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:STEELIXITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Steelix") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [75,125,230,30,55,95] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SANDFORCE) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 105 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 740 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:SCEPTILE,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:SCEPTILITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Sceptile") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [70,110,70,145,145,85] if pokemon.form==1
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:DRAGON) if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:LIGHTNINGROD) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 19 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 55.2 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:SWAMPERT,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:SWAMPERTITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Swampert") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [100,150,110,70,85,110] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SWIFTSWIM) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 19 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 102 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:SABLEYE,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:SABLENITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Sableye") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [50,85,125,20,85,115] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:MAGICBOUNCE) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 5 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 161 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:SHARPEDO,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:SHARPEDONITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Sharpedo") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [70,140,70,105,110,65] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:STRONGJAW) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 25 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 130.3 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:CAMERUPT,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:CAMERUPTITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Camerupt") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [70,120,100,20,145,105] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SHEERFORCE) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 25 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 320.5 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:ALTARIA,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:ALTARIANITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Altaria") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [75,110,100,80,110,105] if pokemon.form==1
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:FAIRY) if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:PIXILATE) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 15 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 206 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:GLALIE,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:GLALITITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Glalie") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [80,120,80,100,120,80] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:REFRIGERATE) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 21 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 350.2 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:SALAMENCE,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:SALAMENCITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Salamence") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [95,145,130,120,120,90] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:AERILATE) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 18 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 112.5 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:METAGROSS,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:METAGROSSITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Metagross") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [80,145,150,110,105,110] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:TOUGHCLAWS) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 25 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 942.9 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:LATIAS,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:LATIASITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Latias") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [80,100,120,110,140,150] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:LEVITATE) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 18 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 52 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:LATIOS,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:LATIOSITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Latios") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [80,130,100,110,160,120] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:LEVITATE) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 23 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 70 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:RAYQUAZA,{
"getMegaForm"=>proc{|pokemon|
   next 1 if pokemon.knowsMove?(:DRAGONASCENT)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Rayquaza") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [105,180,100,115,180,100] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:DELTASTREAM) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 108 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 392 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:LOPUNNY,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:LOPUNNITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Lopunny") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [65,136,94,135,54,96] if pokemon.form==1
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:FIGHTING) if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SCRAPPY) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 13 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 28.3 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:GALLADE,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:GALLADITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Gallade") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [68,165,95,110,65,115] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:INNERFOCUS) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 16 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 56.4 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:AUDINO,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:AUDINITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Audino") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [103,60,126,50,80,126] if pokemon.form==1
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:FAIRY) if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:HEALER) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 15 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 32 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
MultipleForms.register(:DIANCIE,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:DIANCITE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Diancie") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [50,160,110,110,160,110] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:MAGICBOUNCE) if pokemon.form==1
   next
},
"height"=>proc{|pokemon|
   next 11 if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 27.8 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
 
#######################DIMENSIONAL RIFT FORMS##############################
MultipleForms.register(:GALVANTULA,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:DEMONSTONE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Rift Galvantula") if pokemon.form==1
   next
},
"type1"=>proc{|pokemon|
   next getID(PBTypes,:POISON) if pokemon.form==1
   next
},   
"getBaseStats"=>proc{|pokemon|
   next [70,80,100,130,80,160] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:PARENTALBOND) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 1011 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
MultipleForms.register(:VOLCANION,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:DEMONSTONE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("DEMON Volcanion") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [110,60,80,20,90,200] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:WATERABSORB) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 1011 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
MultipleForms.register(:CHANDELURE,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:DEMONSTONE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Rift Chandelure") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [110,25,69,100,200,110] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:PROTEAN) if pokemon.form==1
   next
},
"weight"=>proc{|pokemon|
   next 1011 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
MultipleForms.register(:CARNIVINE,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:DEMONSTONE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Rift Carnivine") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [80,110,75,115,120,100] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:THICKFAT) if pokemon.form==1
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:DRAGON) if pokemon.form==1
},
"weight"=>proc{|pokemon|
   next 1011 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
MultipleForms.register(:GARBODOR,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:DEMONSTONE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Rift Garbodor") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [120,80,200,10,120,200] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:POISONHEAL) if pokemon.form==1
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:DARK) if pokemon.form==1
},
"weight"=>proc{|pokemon|
   next 1011 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:FERROTHORN,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:DEMONSTONE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Rift Ferrothorn") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [300,80,240,115,80,250] if pokemon.form==1
   next [600,250,200,240,80,200] if pokemon.form==2
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SHIFT) if pokemon.form==1
   next getID(PBAbilities,:SHIFT) if pokemon.form==2
   next
},
"type1"=>proc{|pokemon|
   next getID(PBTypes,:FIRE) if pokemon.form==1
   next getID(PBTypes,:FIRE) if pokemon.form==2
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:STEEL) if pokemon.form==1
   next getID(PBTypes,:STEEL) if pokemon.form==2
   next
},
"weight"=>proc{|pokemon|
   next 110 if pokemon.form==1
   next 2101 if pokemon.form==2
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:REGIROCK,{
"getBaseStats"=>proc{|pokemon|
   next [150,190,105,200,105,250] if pokemon.form==1
   next [200,250,45,220,40,310] if pokemon.form==2
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:SAVAGERY) if pokemon.form==1
   next getID(PBAbilities,:SAVAGERY) if pokemon.form==2
   next
},
"type1"=>proc{|pokemon|
   next getID(PBTypes,:ROCK) if pokemon.form==1
   next getID(PBTypes,:ROCK) if pokemon.form==2
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:FIGHTING) if pokemon.form==1
   next getID(PBTypes,:FIGHTING) if pokemon.form==2
   next
},
"weight"=>proc{|pokemon|
   next 110 if pokemon.form==1
   next 30 if pokemon.form==2
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
MultipleForms.register(:TANGELA,{
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:TANGLINGHAIR) if pokemon.form==1
   next
},
"type1"=>proc{|pokemon|
   next getID(PBTypes,:GRASS) if pokemon.form==1
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:DARK) if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})
MultipleForms.register(:TANGROWTH,{
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:TANGLINGHAIR) if pokemon.form==1
   next
},
"type1"=>proc{|pokemon|
   next getID(PBTypes,:GRASS) if pokemon.form==1
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:GHOST) if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

##### Misc forms ###############################################################


MultipleForms.register(:KECLEON,{
"getMegaName"=>proc{|pokemon|
   next _INTL("Purple Kecleon") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next if pokemon.form==0     
   next [130,120,90,95,60,130] # Purple
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:SOLROCK,{
"getBaseStats"=>proc{|pokemon|
   case pokemon.form
     when 1; next [90,110,90,44,90,75] # Solrock Dominant
     when 2; next [125,170,100,95,120, 90] # Lunatone Dominant
     else;   next                          
   end
},
"ability"=>proc{|pokemon|
   case pokemon.form
     when 1; next getID(PBAbilities,:ANALYTIC)
     else;   next                                
   end
},
"evYield"=>proc{|pokemon|
   case pokemon.form
     when 1; next [0,3,0,0,0,0] # Sold om
     else;   next               # Kyurem
   end
},
"getMoveList"=>proc{|pokemon|
   next if pokemon.form==0
   movelist=[]
   case pokemon.form
     when 1; movelist=[[1,:FIRESPIN],[1,:ROCKTOMB],[8,:IMPRISON],
                       [15,:COSMICPOWER],[22,:SMACKDOWN],[29,:ROCKPOLISH],
                       [36,:STONEEDGE],[43,:TAKEDOWN],[50,:BULLDOZE],
                       [57,:PSYCHIC],[64,:SOLARFLARE],[71,:FLAREBLITZ],
                       [78,:ROCKWRECKER],[85,:COSMICPOWER],[92,:BLUEFLARE]]
   end
   for i in movelist
     i[1]=getConst(PBMoves,i[1])
   end
   next movelist
}
})
 
MultipleForms.register(:GYARADOS,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:GYARADOSITE)
   next 2 if isConst?(pokemon.item,PBItems,:DEMONSTONE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Mega Gyarados") if pokemon.form==1
   next _INTL("Rift Gyarados") if pokemon.form==2
   next
},
"getBaseStats"=>proc{|pokemon|
   next [95,155,109,81,70,130] if pokemon.form==1
   next [70,110,100,100,90,78] if pokemon.form==2
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:DARK) if pokemon.form==1
   next getID(PBTypes,:DIMENSION) if pokemon.form==2
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:MOLDBREAKER) if pokemon.form==1
   next getID(PBAbilities,:INTIMIDATE2) if pokemon.form==2
   next
},
"weight"=>proc{|pokemon|
   next 3050 if pokemon.form==1
   next 3060 if pokemon.form==2
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:REGIGIGAS,{
"getBaseStats"=>proc{|pokemon|
  case pokemon.form
  when 0 # Standard form
   next
  when 1 # Fire
   next [110,80,110,160,110,100]
  when 2 # Water
   next [110,80,110,160,110,100]
  when 3 # Ice
   next [110,160,110,80,110,100]
  when 4 # Grass
   next [110,160,110,80,110,100]
  when 5 # Fairy
   next [110,80,110,160,110,100]
  when 6 # Psychic
   next [110,80,110,160,110,100]
  when 7 # Dragon
   next [110,160,110,80,110,100]
  when 8 # Bug
   next [110,160,110,80,110,100]
  when 9 # Fighting
   next [110,160,110,80,110,100]
 end
},
"type1"=>proc{|pokemon|
  case pokemon.form
  when 0 # Standard form
   next
  when 1 # Fire
   next getID(PBTypes,:FIRE)
  when 2 # Water
   next getID(PBTypes,:WATER)
  when 3 # Ice
   next getID(PBTypes,:ICE)
  when 4 # Grass
   next getID(PBTypes,:GRASS)
  when 5 # Fairy
   next getID(PBTypes,:FAIRY)
  when 6 # Psychic
   next getID(PBTypes,:PSYCHIC)
  when 7 # Dragon
   next getID(PBTypes,:DRAGON)
  when 8 # Bug
   next getID(PBTypes,:BUG)
  when 9 # Fighting
   next getID(PBTypes,:FIGHTING)
 end
},
"type2"=>proc{|pokemon|
  case pokemon.form
  when 0 # Standard form
   next
  when 1 # Fire
   next getID(PBTypes,:FIRE)
  when 2 # Water
   next getID(PBTypes,:WATER)
  when 3 # Ice
   next getID(PBTypes,:ICE)
  when 4 # Grass
   next getID(PBTypes,:GRASS)
  when 5 # Fairy
   next getID(PBTypes,:FAIRY)
  when 6 # Psychic
   next getID(PBTypes,:PSYCHIC)
  when 7 # Dragon
   next getID(PBTypes,:DRAGON)
  when 8 # Bug
   next getID(PBTypes,:BUG)
  when 9 # Fighting
   next getID(PBTypes,:FIGHTING)
 end
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})

MultipleForms.register(:WEAVILE,{
"getMegaForm"=>proc{|pokemon|
   next 1 if isConst?(pokemon.item,PBItems,:DEMONSTONE)
   next
},
"getUnmegaForm"=>proc{|pokemon|
   next 0
},
"getMegaName"=>proc{|pokemon|
   next _INTL("Rift WEAVILE") if pokemon.form==1
   next
},
"getBaseStats"=>proc{|pokemon|
   next [180,190,80,135,5,90] if pokemon.form==1
   next
},
"ability"=>proc{|pokemon|
   next getID(PBAbilities,:DARKAURA) if pokemon.form==1
   next
},
"type2"=>proc{|pokemon|
   next getID(PBTypes,:PSYCHIC) if pokemon.form==1
},
"weight"=>proc{|pokemon|
   next 1011 if pokemon.form==1
   next
},
"onSetForm"=>proc{|pokemon,form|
   pbSeenForm(pokemon)
}
})