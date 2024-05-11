class PokeBattle_ZMoves
  attr_accessor(:id)
  attr_reader(:battle)
  attr_reader(:name)
  attr_reader(:function)
# UPDATE 11/21/2013
# Changed from immutable to mutable to allow for sheer force
# changed from: attr_reader(:basedamage)
  attr_accessor(:basedamage)
  attr_reader(:type)
  attr_reader(:accuracy)
  attr_reader(:addlEffect)
  attr_reader(:target)   
  attr_reader(:priority)
  attr_accessor(:flags)
  attr_reader(:category)  
  attr_reader(:thismove)
  attr_accessor(:pp)
  attr_accessor(:totalpp)
  attr_reader(:oldmove)
  attr_reader(:status) 
  attr_reader(:oldname)
  attr_accessor(:zmove)
################################################################################
# Creating a z move
################################################################################
  def initialize(battle,battler,move,crystal,simplechoice=false)
    @status     = !(move.pbIsPhysical?(move.type) || move.pbIsSpecial?(move.type))
    
    @oldmove    = move
    @oldname    = move.name
    @id         = pbZMoveId(move,crystal)
    @battle     = battle
    @name       = pbZMoveName(move,crystal)
    # Get data on the move
    oldmovedata = PBMoveData.new(move.id)
    @function   = pbZMoveFunction(move,crystal)
    @basedamage = pbZMoveBaseDamage(move,crystal)
    @type       = move.type
    @accuracy   = pbZMoveAccuracy(move,crystal)
    @addlEffect = 0 #pbZMoveAddlEffectChance(move,crystal)
    @target     = move.target
    @priority   = @oldmove.priority
    @flags      = pbZMoveFlags(move,crystal)
    @category   = oldmovedata.category
    @pp         = 1
    @totalpp    = 1
    @thismove   = self #move
    @zmove      = true
    if !@status
      @priority = 0
    end
    battler.pbBeginTurn(self)
    if !@status
      @battle.pbDisplayBrief(_INTL("{1} unleashed its full force Z-Move!",battler.pbThis))
      @battle.pbDisplayBrief(_INTL("{1}!",@name))
    end    
    zchoice=@battle.choices[battler.index] #[0,0,move,move.target]
    if simplechoice!=false
      zchoice=simplechoice
    end      
    ztargets=[]
    user=battler.pbFindUser(zchoice,ztargets)
    if user.hasWorkingAbility(:MOLDBREAKER) ||       
       user.hasWorkingAbility(:TERAVOLT)   ||
       user.hasWorkingAbility(:TURBOBLAZE)
      for battlers in ztargets
        battlers.moldbroken = true
      end
    else
      for battlers in ztargets
        battlers.moldbroken = false
      end
    end 
    if ztargets.length==0
      if @thismove.target==PBTargets::SingleNonUser ||
         @thismove.target==PBTargets::RandomOpposing ||
         @thismove.target==PBTargets::AllOpposing ||
         @thismove.target==PBTargets::AllNonUsers ||
         @thismove.target==PBTargets::Partner ||
         @thismove.target==PBTargets::UserOrPartner ||
         @thismove.target==PBTargets::SingleOpposing ||
         @thismove.target==PBTargets::OppositeOpposing 
        @battle.pbDisplay(_INTL("But there was no target..."))
      else
        #selftarget status moves here
        pbZStatus(@id,battler)        
        zchoice[2].name = @name
        battler.pbUseMove(zchoice)
        @oldmove.name = @oldname
      end      
    else
      if @status
        #targeted status Z's here
        pbZStatus(@id,battler)
        zchoice[2].name = @name
        battler.pbUseMove(zchoice)
        @oldmove.name = @oldname
      else
        turneffects=[]
        turneffects[PBEffects::SpecialUsage]=false
        turneffects[PBEffects::PassedTrying]=false
        turneffects[PBEffects::TotalDamage]=0
        userandtarget=[user,ztargets[0]]
        battler.pbChangeTarget(@thismove,userandtarget,ztargets)
        battler.pbProcessMoveAgainstTarget(@thismove,user,ztargets[0],1,turneffects,false,nil,true)  
        battler.pbReducePPOther(@oldmove)
      end
    end    
  end
  
  def pbZMoveId(oldmove,crystal)
    if @status
      return oldmove.id
    else
      case crystal
      when getID(PBItems,:NORMALIUMZ2)
        return "Z001"
      when getID(PBItems,:FIGHTINIUMZ2)
        return "Z002"
      when getID(PBItems,:FLYINIUMZ2)
        return "Z003"      
      when getID(PBItems,:POISONIUMZ2)
        return "Z004"              
      when getID(PBItems,:GROUNDIUMZ2)
        return "Z005"        
      when getID(PBItems,:ROCKIUMZ2)
        return "Z006"               
      when getID(PBItems,:BUGINIUMZ2)
        return "Z007"      
      when getID(PBItems,:GHOSTIUMZ2)
        return "Z008"                 
      when getID(PBItems,:STEELIUMZ2)
        return "Z009"           
      when getID(PBItems,:FIRIUMZ2)
        return "Z010"     
      when getID(PBItems,:WATERIUMZ2)
        return "Z011"                   
      when getID(PBItems,:GRASSIUMZ2)
        return "Z012"              
      when getID(PBItems,:ELECTRIUMZ2)
        return "Z013"              
      when getID(PBItems,:PSYCHIUMZ2)
        return "Z014"           
      when getID(PBItems,:ICIUMZ2)
        return "Z015"                    
      when getID(PBItems,:DRAGONIUMZ2)
        return "Z016"                  
      when getID(PBItems,:DARKINIUMZ2)
        return "Z017"             
      when getID(PBItems,:FAIRIUMZ2)
        return "Z018"                           
      when getID(PBItems,:ALORAICHIUMZ2)
        return "Z019"              
      when getID(PBItems,:DECIDIUMZ2)
        return "Z020"            
      when getID(PBItems,:INCINIUMZ2)
        return "Z021"        
      when getID(PBItems,:PRIMARIUMZ2)
        return "Z022" 
      when getID(PBItems,:EEVIUMZ2)
        return "Z023"        
      when getID(PBItems,:PIKANIUMZ2)
        return "Z024"  
      when getID(PBItems,:SNORLIUMZ2)
        return "Z025"     
      when getID(PBItems,:MEWNIUMZ2)
        return "Z026"
      when getID(PBItems,:TAPUNIUMZ2)
        return "Z027"
      when getID(PBItems,:MARSHADIUMZ2)
        return "Z028"
      end
    end    
  end  
  
  def pbZMoveName(oldmove,crystal)
    if @status
      return "Z-" + oldmove.name
    else
      case crystal
      when getID(PBItems,:NORMALIUMZ2)
        return "Breakneck Blitz"
      when getID(PBItems,:FIGHTINIUMZ2)
        return "All-Out Pummeling"
      when getID(PBItems,:FLYINIUMZ2)
        return "Supersonic Skystrike"
      when getID(PBItems,:POISONIUMZ2)
        return "Acid Downpour"
      when getID(PBItems,:GROUNDIUMZ2)
        return "Tectonic Rage"
      when getID(PBItems,:ROCKIUMZ2)
        return "Continental Crush"
      when getID(PBItems,:BUGINIUMZ2)
        return "Savage Spin-Out"
      when getID(PBItems,:GHOSTIUMZ2)
        return "Never-Ending Nightmare"
      when getID(PBItems,:STEELIUMZ2)
        return "Corkscrew Crash"
      when getID(PBItems,:FIRIUMZ2)
        return "Inferno Overdrive"
      when getID(PBItems,:WATERIUMZ2)
        return "Hydro Vortex"
      when getID(PBItems,:GRASSIUMZ2)
        return "Bloom Doom"
      when getID(PBItems,:ELECTRIUMZ2)
        return "Gigavolt Havoc"
      when getID(PBItems,:PSYCHIUMZ2)
        return "Shattered Psyche"
      when getID(PBItems,:ICIUMZ2)
        return "Subzero Slammer"
      when getID(PBItems,:DRAGONIUMZ2)
        return "Devastating Drake"
      when getID(PBItems,:DARKINIUMZ2)
        return "Black Hole Eclipse"
      when getID(PBItems,:FAIRIUMZ2)
        return "Twinkle Tackle"
      when getID(PBItems,:ALORAICHIUMZ2)
        return "Stoked Sparksurfer"
      when getID(PBItems,:DECIDIUMZ2)
        return "Sinister Arrow Raid"
      when getID(PBItems,:INCINIUMZ2)
        return "Malicious Moonsault"
      when getID(PBItems,:PRIMARIUMZ2)
        return "Oceanic Operetta"
      when getID(PBItems,:EEVIUMZ2)
        return "Extreme Evoboost"
      when getID(PBItems,:PIKANIUMZ2)
        return "Catastropika"
      when getID(PBItems,:SNORLIUMZ2)
        return "Pulverizing Pancake"
      when getID(PBItems,:MEWNIUMZ2)
        return "Genesis Supernova"
      when getID(PBItems,:TAPUNIUMZ2)
        return "Guardian of Alola"
      when getID(PBItems,:MARSHADIUMZ2)
        return "Soul-Stealing 7-Star Strike"
      end
    end    
  end
  
  def pbZMoveFunction(oldmove,crystal)
    if @status
      return oldmove.function
    else
      "Z"
    end 
  end
  
  def pbZMoveBaseDamage(oldmove,crystal)
    if @status
      return 0
    else
      case crystal
      when getID(PBItems,:ALORAICHIUMZ2)
        return 175
      when getID(PBItems,:DECIDIUMZ2)
        return 180
      when getID(PBItems,:INCINIUMZ2)
        return 180
      when getID(PBItems,:PRIMARIUMZ2)
        return 195
      when getID(PBItems,:EEVIUMZ2)
        return 0
      when getID(PBItems,:PIKANIUMZ2)
        return 210
      when getID(PBItems,:SNORLIUMZ2)
        return 210
      when getID(PBItems,:MEWNIUMZ2)
        return 185
      when getID(PBItems,:TAPUNIUMZ2)
        return 0
      when getID(PBItems,:MARSHADIUMZ2)
        return 195
      else
        case @oldmove.id
        when getID(PBMoves,:MEGADRAIN)
          return 120
        when getID(PBMoves,:WEATHERBALL)  
          return 160
        when getID(PBMoves,:HEX)
          return 160
        when getID(PBMoves,:GEARGRIND)  
          return 180
        when getID(PBMoves,:VCREATE)  
          return 220
        when getID(PBMoves,:FLYINGPRESS)
          return 170
        when getID(PBMoves,:COREENFORCER)
          return 140
        else
          check=@oldmove.basedamage
          if check<56
            return 100
          elsif check<66
            return 120
          elsif check<76
            return 140
          elsif check<86
            return 160
          elsif check<96
            return 175
          elsif check<101
            return 180
          elsif check<111
            return 185
          elsif check<126
            return 190
          elsif check<131
            return 195
          elsif check>139
            return 200
          end          
        end        
      end  
    end    
  end
  
  def pbZMoveAccuracy(oldmove,crystal)
    if @status
      return oldmove.accuracy
    else
      return 0 #Z Moves can't miss
    end      
  end
  
  
  def pbZMoveFlags(oldmove,crystal)
    if @status
      return oldmove.flags
    else
      case crystal
      when getID(PBItems,:NORMALIUMZ2)
        return "f"
      when getID(PBItems,:FIGHTINIUMZ2)
        return "f"
      when getID(PBItems,:FLYINIUMZ2)
        return "f"
      when getID(PBItems,:POISONIUMZ2)
        return "f"
      when getID(PBItems,:GROUNDIUMZ2)
        return "f"
      when getID(PBItems,:ROCKIUMZ2)
        return "f"
      when getID(PBItems,:BUGINIUMZ2)
        return "f"
      when getID(PBItems,:GHOSTIUMZ2)
        return "f"
      when getID(PBItems,:STEELIUMZ2)
        return "f"
      when getID(PBItems,:FIRIUMZ2)
        return "f"
      when getID(PBItems,:WATERIUMZ2)
        return "f"
      when getID(PBItems,:GRASSIUMZ2)
        return "f"
      when getID(PBItems,:ELECTRIUMZ2)
        return "f"
      when getID(PBItems,:PSYCHIUMZ2)
        return "f"
      when getID(PBItems,:ICIUMZ2)
        return "f"
      when getID(PBItems,:DRAGONIUMZ2)
        return "f"
      when getID(PBItems,:DARKINIUMZ2)
        return "f"
      when getID(PBItems,:FAIRIUMZ2)
        return "f"
      when getID(PBItems,:ALORAICHIUMZ2)
        return "f"
      when getID(PBItems,:DECIDIUMZ2)
        return "f"
      when getID(PBItems,:INCINIUMZ2)
        return "af"
      when getID(PBItems,:PRIMARIUMZ2)
        return "f"
      when getID(PBItems,:EEVIUMZ2)
        return ""
      when getID(PBItems,:PIKANIUMZ2)
        return "af"
      when getID(PBItems,:SNORLIUMZ2)
        return "af"
      when getID(PBItems,:MEWNIUMZ2)
        return ""
      when getID(PBItems,:TAPUNIUMZ2)
        return "f"
      when getID(PBItems,:MARSHADIUMZ2)
        return "af"
      end
    end
  end

################################################################################
# About the move
################################################################################
# UPDATE 11/16
# simplifies flag usage - can now ask hasFlags?("m")
# to determine if flag `m` is set.
# or also hasFlags?("abcdef") will also work if all flags are set
# This makes it much easier for anyone not versed in bitwise operations
# to define new flags.
# Note: I tested most edge cases of this - although I could've missed something
  def hasFlags?(flag)
    # must be a string
    return false if !flag.is_a? String
    letters = flag.split('')
    for letter in letters
      return false if !@flags.include?(letter)
    end
    return true
  end
  
################################################################################
# PokeBattle_Move Features needed for move use
################################################################################  
  def pbIsSpecial?(type)  
    @oldmove.pbIsSpecial?(type)
  end
  
  def pbIsPhysical?(type)  
    @oldmove.pbIsPhysical?(type)
  end  
  
  def pbEffect(attacker,opponent,hitnum=0,alltargets=nil,showanimation=true)
    return 0 if !opponent
    if @id == "Z027" # Guardian of Alola
      return pbEffectFixedDamage((opponent.hp*3/4).floor,attacker,opponent,hitnum,alltargets,showanimation)
    elsif @id == "Z023" # Extreme Evoboost  
      if !attacker.pbCanIncreaseStatStage?(PBStats::SPATK,false) &&
         !attacker.pbCanIncreaseStatStage?(PBStats::SPDEF,false) &&
         !attacker.pbCanIncreaseStatStage?(PBStats::SPEED,false) &&
         !attacker.pbCanIncreaseStatStage?(PBStats::ATTACK,false) &&
         !attacker.pbCanIncreaseStatStage?(PBStats::DEFENSE,false)
        @battle.pbDisplay(_INTL("{1}'s stats won't go any higher!",attacker.pbThis))
        return -1
      end
      pbShowAnimation(@name,attacker,nil,hitnum,alltargets,showanimation)
      showanim=true
      if attacker.pbCanIncreaseStatStage?(PBStats::SPATK,false)
        attacker.pbIncreaseStat(PBStats::SPATK,2,false,showanim,nil,showanim)
          showanim=false
      end
      if attacker.pbCanIncreaseStatStage?(PBStats::SPDEF,false)
        attacker.pbIncreaseStat(PBStats::SPDEF,2,false,showanim,nil,showanim)
        showanim=false
      end
      if attacker.pbCanIncreaseStatStage?(PBStats::SPEED,false)
        attacker.pbIncreaseStat(PBStats::SPEED,2,false,showanim,nil,showanim)
        showanim=false
      end
      if attacker.pbCanIncreaseStatStage?(PBStats::ATTACK,false)
        attacker.pbIncreaseStat(PBStats::ATTACK,2,false,showanim,nil,showanim)
        showanim=false
      end
      if attacker.pbCanIncreaseStatStage?(PBStats::DEFENSE,false)
        attacker.pbIncreaseStat(PBStats::DEFENSE,2,false,showanim,nil,showanim)
        showanim=false
      end      
      return 0            
    end    
    damage=pbCalcDamage(attacker,opponent)    
    if opponent.damagestate.typemod!=0 
      pbShowAnimation(@name,attacker,opponent,hitnum,alltargets,showanimation)     
    end
    damage=pbReduceHPDamage(damage,attacker,opponent)
    pbEffectMessages(attacker,opponent)
    pbOnDamageLost(damage,attacker,opponent)
    if @id == "Z019" # Stoked Sparksurfer
      if opponent.pbCanParalyze?(false)
        opponent.pbParalyze(attacker)
        @battle.pbDisplay(_INTL("{1} is paralyzed!  It may be unable to move!",opponent.pbThis))
      end
      if $fefieldeffect!=1 && $fefieldeffect!=35
        $fetempfield = 1 
        $fefieldeffect = $fetempfield
        @battle.pbChangeBGSprite
        @battle.field.effects[PBEffects::Terrain]=3 
        @battle.pbDisplay(_INTL("The terrain became electrified!"))
        @battle.seedCheck
      end
    elsif @id == "Z005" # Tectonic Rage
      if $fefieldeffect == 1 # Electric Terrain
        if $fefieldeffect == $febackup
          $fefieldeffect = 0
        else
          $fefieldeffect = $febackup
        end
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The hyper-charged terrain shorted out!"))
        @battle.field.effects[PBEffects::Terrain]=0
        @battle.seedCheck
      elsif $fefieldeffect == 4 # Dark Crystal Cavern
        $fefieldeffect = 23
        $febackup = 23
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The dark crystals were shattered!"))
        @battle.seedCheck   
      elsif $fefieldeffect == 5 # Chess Board
        if $fefieldeffect == $febackup
          $fefieldeffect = 0
        else
          $fefieldeffect = $febackup
        end
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The board was destroyed!"))
        @battle.seedCheck 
      elsif $fefieldeffect == 17 # Factory Field
        $fefieldeffect = 18
        $febackup = 18
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The field was broken!"))
        @battle.seedCheck
      elsif $fefieldeffect == 23 # Cave
        $fecounter+=1 
        case $fecounter
        when 1
          @battle.pbDisplay(_INTL("Bits of rock fell from the crumbling ceiling!"))
        when 2
          @battle.pbDisplay(_INTL("The quake collapsed the ceiling!"))
          for i in 0...4
            quakedrop = @battle.battlers[i].hp
            next if quakedrop==0
            invulcheck=PBMoveData.new(@battle.battlers[i].effects[PBEffects::TwoTurnAttack]).function
            case invulcheck
            when 0xC9, 0xCC, 0xCA, 0xCB, 0xCD, 0xCE
              quakedrop = 0
            end
            quakedrop =0 if @battle.battlers[i].effects[PBEffects::SkyDrop]
            quakedrop-=1 if @battle.battlers[i].hasWorkingAbility(:STURDY)                 
            quakedrop/=3 if @battle.battlers[i].hasWorkingAbility(:SOLIDROCK)
            quakedrop/=2 if @battle.battlers[i].hasWorkingAbility(:SHELLARMOR)
            quakedrop/=2 if @battle.battlers[i].hasWorkingAbility(:BATTLEARMOR)
            quakedrop =0 if @battle.battlers[i].hasWorkingAbility(:BULLETPROOF)
            quakedrop =0 if @battle.battlers[i].hasWorkingAbility(:ROCKHEAD)
            quakedrop/=3 if @battle.battlers[i].hasWorkingAbility(:PRISMARMOR)
            quakedrop =0 if @battle.battlers[i].effects[PBEffects::Protect] == true
            quakedrop =0 if @battle.battlers[i].effects[PBEffects::WideGuard] == true
            quakedrop-=1 if @battle.battlers[i].effects[PBEffects::Endure] == true
            quakedrop =0 if @battle.battlers[i].effects[PBEffects::KingsShield] == true
            quakedrop =0 if @battle.battlers[i].effects[PBEffects::SpikyShield] == true
            quakedrop =0 if @battle.battlers[i].effects[PBEffects::MatBlock] == true
            @battle.battlers[i].pbReduceHP(quakedrop) if quakedrop != 0
            @battle.battlers[i].pbFaint if @battle.battlers[i].isFainted?
            $fefieldeffect = 0
            $febackup = 0
            @battle.pbChangeBGSprite           
            @battle.seedCheck            
          end
        end        
      elsif $fefieldeffect == 25 # Crystal Cavern
        $fefieldeffect = 23
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The crystals were broken up!"))
        @battle.seedCheck             
      elsif $fefieldeffect == 30 # Mirror Arena
        @battle.pbDisplay(_INTL("The mirror arena shattered!"))
        for i in 0...4
          shatter = @battle.battlers[i].totalhp
          next if shatter==0
          shatter/=2
          invulcheck=PBMoveData.new(@battle.battlers[i].effects[PBEffects::TwoTurnAttack]).function
          case invulcheck
          when 0xC9, 0xCC, 0xCA, 0xCB, 0xCD, 0xCE
            shatter = 0
          end
          shatter =0 if @battle.battlers[i].effects[PBEffects::SkyDrop]
          shatter =0 if @battle.battlers[i].hasWorkingAbility(:SHELLARMOR)
          shatter =0 if @battle.battlers[i].hasWorkingAbility(:BATTLEARMOR)
          shatter =0 if @battle.battlers[i].effects[PBEffects::Protect] == true
          shatter =0 if @battle.battlers[i].effects[PBEffects::WideGuard] == true
          shatter =0 if @battle.battlers[i].effects[PBEffects::KingsShield] == true
          shatter =0 if @battle.battlers[i].effects[PBEffects::SpikyShield] == true
          shatter =0 if @battle.battlers[i].effects[PBEffects::MatBlock] == true
          @battle.battlers[i].pbReduceHP(shatter) if shatter != 0
          @battle.battlers[i].pbFaint if @battle.battlers[i].isFainted?
          $fefieldeffect = 0
          $febackup = 0
          @battle.pbChangeBGSprite           
          @battle.seedCheck            
        end
      end        
    elsif @id == "Z012" # Bloom Doom
      if $fefieldeffect!=2 && $fefieldeffect!=15 && 
       $fefieldeffect!=33 && $fefieldeffect!=35 
        $fetempfield = 2
        $fefieldeffect = $fetempfield
        @battle.pbChangeBGSprite
        @battle.field.effects[PBEffects::Terrain]=3 
        @battle.pbDisplay(_INTL("The terrain became grassy!"))
        @battle.seedCheck
      elsif $fefieldeffect==33
        if $fecounter<4
          $fecounter+=1
          @battle.pbChangeBGSprite
          @battle.pbDisplay(_INTL("Bloom Doom grew the garden a little!"))
        end
      end      
    elsif @id == "Z004" # Acid Downpour
      if $fefieldeffect==2  
        $fetempfield = 10
        $fefieldeffect = $fetempfield
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The grassy terrain was corroded!"))
        @battle.seedCheck
      elsif $fefieldeffect==3
        $fetempfield = 10
        $fefieldeffect = $fetempfield
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("Poison spread through the mist!"))
        @battle.seedCheck
      elsif $fefieldeffect==7
        $fetempfield = 41
        $fefieldeffect = $fetempfield
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The grime snuffed out the flame!"))
        @battle.seedCheck
      elsif $fefieldeffect==19 # Wasteland
        if ((!opponent.pbHasType?(:POISON) && !opponent.pbHasType?(:STEEL)) || opponent.corroded) &&
         !isConst?(opponent.ability,PBAbilities,:TOXICBOOST) &&
         !isConst?(opponent.ability,PBAbilities,:POISONHEAL) &&
         (!isConst?(opponent.ability,PBAbilities,:IMMUNITY) && !(opponent.moldbroken))
          rnd=@battle.pbRandom(4)
          case rnd
          when 0
            break if !opponent.pbCanBurn?(false)
            opponent.pbBurn(attacker)
            @battle.pbDisplay(_INTL("{1} was burned!",opponent.pbThis))
          when 1
            break if !opponent.pbCanFreeze?(false)
            opponent.pbFreeze
            @battle.pbDisplay(_INTL("{1} was frozen solid!",opponent.pbThis))
          when 2
            break if !opponent.pbCanParalyze?(false)
            opponent.pbParalyze(attacker)
            @battle.pbDisplay(_INTL("{1} is paralyzed!  It may be unable to move!",opponent.pbThis))
          when 3
            break if !opponent.pbCanPoison?(false)
            opponent.pbPoison(attacker)
            @battle.pbDisplay(_INTL("{1} was poisoned!",opponent.pbThis))
          end          
        end     
      elsif $fefieldeffect==21 # Water Surface
        $fefieldeffect = 26
        $febackup = 26
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The water was polluted!"))
        $fecounter = 0
        @battle.seedCheck        
      elsif $fefieldeffect==22 # Underwater
        $fefieldeffect = 26
        $febackup = 26
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The water was polluted!"))
        @battle.pbDisplay(_INTL("The grime sunk beneath the battlers!"))
        $fecounter = 0
        @battle.seedCheck  
      elsif $fefieldeffect==23
        $fetempfield = 41
        $fefieldeffect = $fetempfield
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The cave became corrupted!"))
        @battle.seedCheck
      elsif $fefieldeffect==33 # Flower Garden Field
        if $fecounter>0
          $fecounter = 0
          @battle.pbChangeBGSprite
          @battle.pbDisplay(_INTL("The acid melted the bloom!"))        
        end      
      end      
    elsif @id == "Z010" # Inferno Overdrive
      if $fefieldeffect == 11 # Corrosive Mist Field
        dampcheck=0
        for i in 0...4
          dampcheck = 1 if @battle.battlers[i].hasWorkingAbility(:DAMP)
        end
        if dampcheck == 0
          for i in 0...4
            combust = @battle.battlers[i].hp
            next if combust==0
            invulcheck=PBMoveData.new(@battle.battlers[i].effects[PBEffects::TwoTurnAttack]).function
            case invulcheck
            when 0xC9, 0xCC, 0xCA, 0xCB, 0xCD, 0xCE
              combust = 0
            end
            combust =0 if @battle.battlers[i].effects[PBEffects::SkyDrop]
            combust-=1 if @battle.battlers[i].hasWorkingAbility(:STURDY)
            combust =0 if @battle.battlers[i].hasWorkingAbility(:FLASHFIRE)
            combust =0 if @battle.battlers[i].effects[PBEffects::Protect] == true
            combust =0 if @battle.battlers[i].effects[PBEffects::WideGuard] == true
            combust-=1 if @battle.battlers[i].effects[PBEffects::Endure] == true
            combust =0 if @battle.battlers[i].effects[PBEffects::KingsShield] == true
            combust =0 if @battle.battlers[i].effects[PBEffects::SpikyShield] == true
            combust =0 if @battle.battlers[i].effects[PBEffects::MatBlock] == true
            @battle.battlers[i].pbReduceHP(combust) if combust != 0
            @battle.battlers[i].pbFaint if @battle.battlers[i].isFainted?
          end
        else
          @battle.pbDisplay(_INTL("A Pokemon's Damp ability prevented a complete explosion!"))
        end        
        if $fefieldeffect == $febackup
          $fefieldeffect = 0
        else
          $fefieldeffect = $febackup
        end
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The toxic mist combusted!"))
        @battle.field.effects[PBEffects::Terrain]=0
        @battle.seedCheck 
      elsif $fefieldeffect==13  # Icy Field
        $fetempfield = 21
        $fefieldeffect = $fetempfield
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The ice melted away!"))
        @battle.seedCheck  
      elsif $fefieldeffect == 27 # Mountain Field
        $fefieldeffect = 16
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The mountain erupted!"))
        @battle.seedCheck 
      elsif $fefieldeffect == 28 # Snowy Mountain
        $fefieldeffect = 27
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The snow melted away!"))
        @battle.seedCheck 
      elsif $fefieldeffect==33 # Flower Garden Field
        if $fecounter>0
          $fefieldeffect = 7
          @battle.pbChangeBGSprite
          @battle.pbDisplay(_INTL("The garden caught fire!"))
          @battle.seedCheck
        end        
      end      
    elsif @id == "Z003" # Supersonic Skystrike
      if $fefieldeffect == 3 # Misty Terrain
        if $fefieldeffect == $febackup
          $fefieldeffect = 0
        else
          $fefieldeffect = $febackup
        end
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The mist was blown away!"))
        @battle.field.effects[PBEffects::Terrain]=0
        @battle.seedCheck
      elsif $fefieldeffect == 11 # Corrosive Mist
        if $fefieldeffect == $febackup
          $fefieldeffect = 0
        else
          $fefieldeffect = $febackup
        end
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The mist was blown away!"))
        @battle.field.effects[PBEffects::Terrain]=0
        @battle.seedCheck
      end           
    elsif @id == "Z006" # Continental Crush
      if $fefieldeffect == 7 # Burning Field
        if $fefieldeffect == $febackup
          $fefieldeffect = 23
        else
          $fefieldeffect = $febackup
        end
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The sand snuffed out the flame!"))
        @battle.field.effects[PBEffects::Terrain]=0
        @battle.seedCheck
      elsif $fefieldeffect == 23 # Cave
        $fecounter+=1 
        case $fecounter
        when 1
          @battle.pbDisplay(_INTL("Bits of rock fell from the crumbling ceiling!"))
        when 2
          @battle.pbDisplay(_INTL("The quake collapsed the ceiling!"))
          for i in 0...4
            quakedrop = @battle.battlers[i].hp
            next if quakedrop==0
            invulcheck=PBMoveData.new(@battle.battlers[i].effects[PBEffects::TwoTurnAttack]).function
            case invulcheck
            when 0xC9, 0xCC, 0xCA, 0xCB, 0xCD, 0xCE
              quakedrop = 0
            end
            quakedrop =0 if @battle.battlers[i].effects[PBEffects::SkyDrop]
            quakedrop-=1 if @battle.battlers[i].hasWorkingAbility(:STURDY)                 
            quakedrop/=3 if @battle.battlers[i].hasWorkingAbility(:SOLIDROCK)
            quakedrop/=2 if @battle.battlers[i].hasWorkingAbility(:SHELLARMOR)
            quakedrop/=2 if @battle.battlers[i].hasWorkingAbility(:BATTLEARMOR)
            quakedrop =0 if @battle.battlers[i].hasWorkingAbility(:BULLETPROOF)
            quakedrop =0 if @battle.battlers[i].hasWorkingAbility(:ROCKHEAD)
            quakedrop/=3 if @battle.battlers[i].hasWorkingAbility(:PRISMARMOR)
            quakedrop =0 if @battle.battlers[i].effects[PBEffects::Protect] == true
            quakedrop =0 if @battle.battlers[i].effects[PBEffects::WideGuard] == true
            quakedrop-=1 if @battle.battlers[i].effects[PBEffects::Endure] == true
            quakedrop =0 if @battle.battlers[i].effects[PBEffects::KingsShield] == true
            quakedrop =0 if @battle.battlers[i].effects[PBEffects::SpikyShield] == true
            quakedrop =0 if @battle.battlers[i].effects[PBEffects::MatBlock] == true
            @battle.battlers[i].pbReduceHP(quakedrop) if quakedrop != 0
            @battle.battlers[i].pbFaint if @battle.battlers[i].isFainted?
            $fefieldeffect = 0
            $febackup = 0
            @battle.pbChangeBGSprite           
            @battle.seedCheck              
          end
        end         
      end   
    elsif @id == "Z011" # Hydro Vortex
      if $fefieldeffect == 7 # Burning Field
        if $fefieldeffect == $febackup
          $fefieldeffect = 23
        else
          $fefieldeffect = $febackup
        end
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The water snuffed out the flame!"))
        @battle.field.effects[PBEffects::Terrain]=0
        @battle.seedCheck
      elsif $fefieldeffect==32 # Dragon's Den
        $fefieldeffect = 23
        $febackup = 23
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The lava solidified!"))
        @battle.seedCheck          
      end     
    elsif @id == "Z022" # Oceanic Operetta
      if $fefieldeffect == 7 # Burning Field
        if $fefieldeffect == $febackup
          $fefieldeffect = 23
        else
          $fefieldeffect = $febackup
        end
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The water snuffed out the flame!"))
        @battle.field.effects[PBEffects::Terrain]=0
        @battle.seedCheck
      elsif $fefieldeffect == 16 # Superheated Field
        @battle.pbDisplay(_INTL("Steam shot up from the field!"))
        for i in 0...4
          canthit = 0
          invulcheck=PBMoveData.new(@battle.battlers[i].effects[PBEffects::TwoTurnAttack]).function
          case invulcheck
          when 0xC9, 0xCC, 0xCA, 0xCB, 0xCD, 0xCE
            canthit = 1
          end
          canthit =1 if @battle.battlers[i].effects[PBEffects::SkyDrop]
          if canthit = 0 && @battle.battlers[i].pbCanReduceStatStage?(PBStats::ACCURACY)
            @battle.battlers[i].pbReduceStatBasic(PBStats::ACCURACY,1)
            @battle.pbCommonAnimation("StatDown",@battle.battlers[i],nil)
            @battle.pbDisplay(_INTL("{1}'s accuracy fell!",@battle.battlers[i].pbThis))
          end
        end    
      elsif $fefieldeffect == 32 # Dragon's Den
        $fecounter += 1
        case $fecounter
          when 1
            @battle.pbDisplay(_INTL("The lava began to harden!"))
          when 2
            $fefieldeffect = 23
            $febackup = 23
            @battle.pbChangeBGSprite
            @battle.pbDisplay(_INTL("The lava solidified!"))
            $fecounter = 0
            @battle.seedCheck
        end        
      end       
    elsif @id == "Z015" # Subzero Slammer
      if $fefieldeffect == 16 # Superheated Field
        if $fefieldeffect == $febackup
          $fefieldeffect = 27
        else
          $fefieldeffect = $febackup
        end
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The field cooled off!"))
        @battle.field.effects[PBEffects::Terrain]=0
        @battle.seedCheck
      elsif $fefieldeffect == 21 # Water Surface
        $fefieldeffect = 13
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The water froze over!"))
        @battle.seedCheck 
      elsif $fefieldeffect == 26 # Murkwater Surface
        $fefieldeffect = 13
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The toxic water froze over!"))
        @battle.seedCheck     
      elsif $fefieldeffect == 27 # Mountain
        $fefieldeffect = 28
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The mountain was covered in snow!"))
        @battle.seedCheck          
      elsif $fefieldeffect==32 # Dragon's Den
        $fefieldeffect = 23
        $febackup = 23
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The lava was frozen solid!"))
        @battle.seedCheck            
      end  
    elsif @id == "Z013" # Gigavolt Havoc
      if $fefieldeffect==17 # Factory Field
        $fefieldeffect = 18
        $febackup = 18
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("The field shorted out!"))
        @battle.seedCheck     
      elsif $fefieldeffect==18 # Short-Circuit Field
        $fefieldeffect = 17
        $febackup = 17
        @battle.pbChangeBGSprite
        @battle.pbDisplay(_INTL("SYSTEM ONLINE."))
        @battle.seedCheck       
      end        
    elsif @id == "Z026" && $fefieldeffect!=37 && $fefieldeffect!=35 # Genesis Supernova
      $fetempfield = 1
      $fefieldeffect = $fetempfield
      @battle.pbChangeBGSprite
      @battle.field.effects[PBEffects::Terrain]=5
      @battle.pbDisplay(_INTL("The terrain became mysterious!"))
      @battle.seedCheck
    elsif @id == "Z014" && $fefieldeffect==37 # Shattered Psyche 
      if opponent.pbCanConfuse?(false)    
        opponent.effects[PBEffects::Confusion]=2+@battle.pbRandom(4)
        @battle.pbCommonAnimation("Confusion",opponent,nil)
        @battle.pbDisplay(_INTL("The field got too weird for {1}!",opponent.pbThis(true)))
      end
    elsif @id == "Z017" && $fefieldeffect!=38 # Black Hole Eclipse
      $fetempfield = 38
      $fefieldeffect = $fetempfield
      @battle.pbChangeBGSprite
      @battle.field.effects[PBEffects::Terrain]=0
      @battle.pbDisplay(_INTL("You entered the dark dimension!"))
      @battle.seedCheck
    elsif @id == "Z008" && $fefieldeffect!=40 # Never-ending nightmare
      $fetempfield = 40
      $fefieldeffect = $fetempfield
      @battle.pbChangeBGSprite
      @battle.field.effects[PBEffects::Terrain]=0
      @battle.pbDisplay(_INTL("The nightmare haunts you!"))
      @battle.seedCheck
    end    
    return damage   
  end  
  
  def pbEffectFixedDamage(damage,attacker,opponent,hitnum=0,alltargets=nil,showanimation=true)
    type=@type
    typemod=pbTypeModMessages(type,attacker,opponent)
    opponent.damagestate.critical=false
    opponent.damagestate.typemod=0
    opponent.damagestate.calcdamage=0
    opponent.damagestate.hplost=0
    if typemod!=0
      opponent.damagestate.calcdamage=damage
      opponent.damagestate.typemod=4
      pbShowAnimation(@name,attacker,opponent,hitnum,alltargets,showanimation)
      damage=1 if damage<1 # HP reduced can't be less than 1
      damage=pbModifyDamage(damage,attacker,opponent)
      damage=pbReduceHPDamage(damage,attacker,opponent)
      pbEffectMessages(attacker,opponent)
      pbOnDamageLost(damage,attacker,opponent)
      return damage
    end
    return 0
  end  

  def pbOnDamageLost(damage,attacker,opponent)
    #Used by Counter/Mirror Coat/Revenge/Focus Punch/Bide
    type=@type
    if opponent.effects[PBEffects::Bide]>0
      opponent.effects[PBEffects::BideDamage]+=damage
      opponent.effects[PBEffects::BideTarget]=attacker.index
    end
    if @oldmove.pbIsPhysical?(type)
      opponent.effects[PBEffects::Counter]=damage
      opponent.effects[PBEffects::CounterTarget]=attacker.index
    end
    if @oldmove.pbIsSpecial?(type)
      opponent.effects[PBEffects::MirrorCoat]=damage
      opponent.effects[PBEffects::MirrorCoatTarget]=attacker.index
    end
    opponent.lastHPLost=damage # for Revenge/Focus Punch/Metal Burst
    opponent.lastAttacker=attacker.index # for Revenge/Metal Burst
  end 
  
  def pbEffectMessages(attacker,opponent,ignoretype=false)
    if opponent.damagestate.critical
      @battle.pbDisplay(_INTL("A critical hit!"))
    end
    if opponent.damagestate.typemod>4
      @battle.pbDisplay(_INTL("It's super effective!"))
    elsif opponent.damagestate.typemod>=1 && opponent.damagestate.typemod<4
      @battle.pbDisplay(_INTL("It's not very effective..."))
    end
    if opponent.damagestate.endured
      @battle.pbDisplay(_INTL("{1} endured the hit!",opponent.pbThis))
    elsif opponent.damagestate.sturdy
      @battle.pbDisplay(_INTL("{1} hung on with Sturdy!",opponent.pbThis))
      opponent.damagestate.sturdy=false
    elsif opponent.damagestate.focussashused
      @battle.pbDisplay(_INTL("{1} hung on using its Focus Sash!",opponent.pbThis))
    elsif opponent.damagestate.focusbandused
      @battle.pbDisplay(_INTL("{1} hung on using its Focus Band!",opponent.pbThis))
    end
  end  
  
  def pbReduceHPDamage(damage,attacker,opponent)
    endure=false
    if opponent.effects[PBEffects::Substitute]>0 && (!attacker || attacker.index!=opponent.index) &&
     !attacker.hasWorkingAbility(:INFILTRATOR) 
      damage=opponent.effects[PBEffects::Substitute] if damage>opponent.effects[PBEffects::Substitute]
      opponent.effects[PBEffects::Substitute]-=damage
      opponent.damagestate.substitute=true
      @battle.scene.pbDamageAnimation(opponent,0)
      @battle.pbDisplayPaused(_INTL("The substitute took damage for {1}!",opponent.name))
      if opponent.effects[PBEffects::Substitute]<=0
        opponent.effects[PBEffects::Substitute]=0
        @battle.scene.pbUnSubstituteSprite(opponent,opponent.pbIsOpposing?(1))
        @battle.pbDisplayPaused(_INTL("{1}'s substitute faded!",opponent.name))
      end
      opponent.damagestate.hplost=damage
      damage=0
    elsif opponent.effects[PBEffects::Disguise] && (!attacker || attacker.index!=opponent.index) && 
      opponent.effects[PBEffects::Substitute]<=0 && opponent.damagestate.typemod!=0
      @battle.scene.pbDamageAnimation(opponent,0)
      opponent.pbBreakDisguise
      @battle.pbDisplayPaused(_INTL("{1}'s Disguise was busted!",opponent.name))
      opponent.effects[PBEffects::Disguise]=false
      damage=0
    else
      opponent.damagestate.substitute=false
      if damage>=opponent.hp
        damage=opponent.hp
        if opponent.effects[PBEffects::Endure]
          damage=damage-1
          opponent.damagestate.endured=true
        elsif opponent.hasWorkingAbility(:STURDY) && 
              damage==opponent.totalhp &&
              !(opponent.moldbroken)
                opponent.damagestate.sturdy=true
                damage=damage-1                
        elsif opponent.damagestate.focussash && damage==opponent.totalhp
          opponent.damagestate.focussashused=true
          damage=damage-1
          opponent.pokemon.itemRecycle=opponent.item
          opponent.pokemon.itemInitial=0 if opponent.pokemon.itemInitial==opponent.item
          opponent.item=0
        elsif opponent.damagestate.focusband
          opponent.damagestate.focusbandused=true
          damage=damage-1
        end
        damage=0 if damage<0
      end
      oldhp=opponent.hp
      opponent.hp-=damage
      effectiveness=0
      if opponent.damagestate.typemod<4
        effectiveness=1   # "Not very effective"
      elsif opponent.damagestate.typemod>4
        effectiveness=2   # "Super effective"
      end
      if opponent.damagestate.typemod!=0
        @battle.scene.pbDamageAnimation(opponent,effectiveness)
      end
      @battle.scene.pbHPChanged(opponent,oldhp)
      opponent.damagestate.hplost=damage
    end
    return damage
  end    
  
  def pbType(type,attacker,opponent)
    return @type
  end 

  def isContactMove?    
    return @flags.include?("a")
  end
  
  def canSnatch?
    return false
  end
  
  def canMagicCoat?
    return false
  end
  
  def isSoundBased?
    return @flags.include?("k")
  end
  
  def pbMoveFailed(attacker,opponent)
    return false
  end
  
  def pbAccuracyCheck(attacker,opponent)
    return true
  end

  def pbCanUseWhileAsleep?
    return false
  end
  
  def pbTypeModifier(type,attacker,opponent)
    return 4 if type<0
    return 4 if isConst?(type,PBTypes,:GROUND) && opponent.pbHasType?(:FLYING) &&
                opponent.hasWorkingItem(:IRONBALL)
    atype=type # attack type
    otype1=opponent.type1
    otype2=opponent.type2
    if isConst?(otype1,PBTypes,:FLYING) && opponent.effects[PBEffects::Roost]
      if isConst?(otype2,PBTypes,:FLYING)
        otype1=getConst(PBTypes,:NORMAL) || 0
      else
        otype1=otype2
      end
    end
    if isConst?(otype2,PBTypes,:FLYING) && opponent.effects[PBEffects::Roost]
      otype2=otype1
    end
    if isConst?(otype1,PBTypes,:FIRE) && opponent.effects[PBEffects::BurnUp]
      if isConst?(otype2,PBTypes,:FIRE)
        otype1=getConst(PBTypes,:QMARKS) || 0
      else
        otype1=otype2
      end
    end
    if isConst?(otype2,PBTypes,:FIRE) && opponent.effects[PBEffects::BurnUp]
      otype2=otype1
    end    
    mod1=PBTypes.getEffectiveness(atype,otype1)
    mod2=(otype1==otype2) ? 2 : PBTypes.getEffectiveness(atype,otype2)
    if $fefieldeffect == 23 
      mod1=2 if isConst?(otype1,PBTypes,:FLYING) && isConst?(atype,PBTypes,:GROUND)
      mod2=2 if isConst?(otype2,PBTypes,:FLYING) && isConst?(atype,PBTypes,:GROUND)
    end
    if opponent.hasWorkingItem(:RINGTARGET)
      mod1=2 if mod1==0
      mod2=2 if mod2==0
    end
    if attacker.hasWorkingAbility(:SCRAPPY) ||
      opponent.effects[PBEffects::Foresight]
      mod1=2 if isConst?(otype1,PBTypes,:GHOST) &&
        (isConst?(atype,PBTypes,:NORMAL) || isConst?(atype,PBTypes,:FIGHTING))
      mod2=2 if isConst?(otype2,PBTypes,:GHOST) &&
        (isConst?(atype,PBTypes,:NORMAL) || isConst?(atype,PBTypes,:FIGHTING))
    end
    if $fefieldeffect == 29
      mod1=2 if isConst?(otype1,PBTypes,:GHOST) &&
        isConst?(atype,PBTypes,:NORMAL)
      mod2=2 if isConst?(otype2,PBTypes,:GHOST) &&
        isConst?(atype,PBTypes,:NORMAL)
    end
    if opponent.effects[PBEffects::Electrify]
      mod1=0 if isConst?(otype1,PBTypes,:GROUND)
      mod1=4 if isConst?(otype1,PBTypes,:FLYING)
      mod1=2 if isConst?(otype1,PBTypes,(:GHOST || :FAIRY || :NORMAL || :DARK))
      mod2=0 if isConst?(otype2,PBTypes,:GROUND)
      mod2=4 if isConst?(otype2,PBTypes,:FLYING)
      mod2=2 if isConst?(otype2,PBTypes,(:GHOST || :FAIRY || :NORMAL || :DARK))
    end
    if $fefieldeffect == 24
      mod1=0 if isConst?(otype1,PBTypes,:GHOST) && isConst?(atype,PBTypes,(:FAIRY || :DARK || :STEEL))
      mod2=0 if isConst?(otype2,PBTypes,:GHOST) && isConst?(atype,PBTypes,(:FAIRY || :DARK || :STEEL))
    end
#### JERICHO - 005 - END   
    if opponent.effects[PBEffects::Ingrain] ||
       opponent.effects[PBEffects::SmackDown] ||
       @battle.field.effects[PBEffects::Gravity]>0
      mod1=2 if isConst?(otype1,PBTypes,:FLYING) && isConst?(atype,PBTypes,:GROUND)
      mod2=2 if isConst?(otype2,PBTypes,:FLYING) && isConst?(atype,PBTypes,:GROUND)
    end
    if opponent.effects[PBEffects::MiracleEye]
      mod1=2 if isConst?(otype1,PBTypes,:DARK) && isConst?(atype,PBTypes,:PSYCHIC)
      mod2=2 if isConst?(otype2,PBTypes,:DARK) && isConst?(atype,PBTypes,:PSYCHIC)
    end
    return mod1*mod2
  end  
  
  def pbCalcDamage(attacker,opponent,options=0)
    opponent.damagestate.critical=false
    opponent.damagestate.typemod=0
    opponent.damagestate.calcdamage=0
    opponent.damagestate.hplost=0
    return 0 if @basedamage==0
    opponent.damagestate.critical=pbIsCritical?(attacker,opponent)
    stagemul=[2,2,2,2,2,2,2,3,4,5,6,7,8]
    stagediv=[8,7,6,5,4,3,2,2,2,2,2,2,2]    
    type=pbType(@type,attacker,opponent)
    ##### Calcuate base power of move #####
    basedmg=@basedamage # Fron PBS file
    #basedmg=pbBaseDamage(basedmg,attacker,opponent) # Some function codes alter base power
    damagemult=0x1000
    if isConst?(attacker.ability,PBAbilities,:TECHNICIAN) && basedmg<=60
      damagemult=(damagemult*1.5).round
    elsif $fefieldeffect == 17 &&
      isConst?(attacker.ability,PBAbilities,:TECHNICIAN) && basedmg<=80
      damagemult=(damagemult*1.5).round
    end
    if isConst?(attacker.ability,PBAbilities,:TOUGHCLAWS) && 
     isContactMove? 
      damagemult=(damagemult*1.3).round
    end
    if attacker.hasWorkingAbility(:FLAREBOOST) &&
     (attacker.status==PBStatuses::BURN ||
      $fefieldeffect == 7) && pbIsSpecial?(type)
      damagemult=(damagemult*1.5).round
    end
    if attacker.hasWorkingAbility(:TOXICBOOST) &&
     (attacker.status==PBStatuses::POISON ||
     $fefieldeffect == 10 || $fefieldeffect == 11 ||
     $fefieldeffect == 19 || $fefieldeffect == 26) && pbIsPhysical?(type)
      damagemult=(damagemult*1.5).round
    end
    #if attacker.hasWorkingAbility(:ANALYTIC) &&
    #   move isn't Future Sight/Doom Desire && target has already moved this turn
    #  damagemult=(damagemult*1.3).round
    #end
    if attacker.hasWorkingAbility(:RIVALRY) &&
       attacker.gender!=2 && opponent.gender!=2
      if attacker.gender==opponent.gender
        damagemult=(damagemult*1.25).round
      else
        damagemult=(damagemult*0.75).round
      end
    end
    if attacker.hasWorkingAbility(:SANDFORCE) &&
     (@battle.pbWeather==PBWeather::SANDSTORM ||
     $fefieldeffect == 12|| $fefieldeffect == 20) &&
     (isConst?(type,PBTypes,:ROCK) ||
     isConst?(type,PBTypes,:GROUND) ||
     isConst?(type,PBTypes,:STEEL))
      damagemult=(damagemult*1.3).round
    end
    if opponent.hasWorkingAbility(:HEATPROOF) && !(opponent.moldbroken) && isConst?(type,PBTypes,:FIRE)
      damagemult=(damagemult*0.5).round
    end
#### KUROTSUNE - 003 START
    if attacker.hasWorkingAbility(:ANALYTIC) && opponent.hasMovedThisRound?
      damagemult = (damagemult*1.3).round
    end
#### KUROTSUNE - 003 END
    if opponent.hasWorkingAbility(:DRYSKIN) && !(opponent.moldbroken) && isConst?(type,PBTypes,:FIRE)
      damagemult=(damagemult*1.25).round
    end
    if attacker.hasWorkingAbility(:SHEERFORCE) && @addlEffect>0
      damagemult=(damagemult*1.3).round
    end      
    #if move was called using Me First
    #  damagemult=(damagemult*1.5).round
    #end
    if attacker.effects[PBEffects::Charge]>0 && isConst?(type,PBTypes,:ELECTRIC)
      damagemult=(damagemult*2.0).round
    end
    if attacker.effects[PBEffects::HelpingHand] && (options&SELFCONFUSE)==0
      damagemult=(damagemult*1.5).round
    end
    if isConst?(type,PBTypes,:FIRE)
      if @battle.field.effects[PBEffects::WaterSport]>0
        damagemult=(damagemult*0.33).round
      end
    end
    if isConst?(type,PBTypes,:ELECTRIC)
      if @battle.field.effects[PBEffects::MudSport]>0
        damagemult=(damagemult*0.33).round
      end
    end   
    if isConst?(type,PBTypes,:DARK)
      for i in @battle.battlers
        if isConst?(i.ability,PBAbilities,:DARKAURA)
         breakaura=0
         for j in @battle.battlers
           if isConst?(j.ability,PBAbilities,:AURABREAK)
             breakaura+=1
           end
         end
          if breakaura!=0
            damagemult=(damagemult*2/3).round
          else
            damagemult=(damagemult*1.3).round
          end
        end
      end
    end 
    if isConst?(type,PBTypes,:FAIRY)
      for i in @battle.battlers
        if isConst?(i.ability,PBAbilities,:FAIRYAURA)
         breakaura=0
         for j in @battle.battlers
           if isConst?(j.ability,PBAbilities,:AURABREAK)
             breakaura+=1
           end
         end
          if breakaura!=0
            damagemult=(damagemult*2/3).round
          else
            damagemult=(damagemult*1.3).round
          end
        end
      end
    end 
    #Specific Field Effects
    case $fefieldeffect
      when 1 # Electric Field
        if @id == "Z005" # Tectonic Rage Field Change
          damagemult=(damagemult*1.3).round
        end        
      when 2 # Grassy Field
        if @id == "Z004" # Acid Downpour Field Change
          damagemult=(damagemult*1.3).round
        end
      when 3 # Misty Field
        if @id == "Z004" # Acid Downpour Field Change
          damagemult=(damagemult*1.3).round
        end        
        if @id == "Z003" # Supersonic Skystrike Field Change
          damagemult=(damagemult*1.3).round
        end                   
      when 4 # Dark Crystal Cavern
        if @id == "Z017" # Black Hole Eclipse
          damagemult=(damagemult*2).round
          @battle.pbDisplay(_INTL("The consuming darkness fed the attack!"))
        end
        if @id == "Z005" # Tectonic Rage Field Change
          damagemult=(damagemult*1.3).round
        end              
      when 5 # Chess Board
        if @id == "Z006" # Continental Crush
          damagemult=(damagemult*1.5).round
          if isConst?(opponent.ability,PBAbilities,:ADAPTABILITY) ||
           isConst?(opponent.ability,PBAbilities,:ANTICIPATION) ||
           isConst?(opponent.ability,PBAbilities,:SYNCHRONIZE) ||
           isConst?(opponent.ability,PBAbilities,:TELEPATHY)
            damagemult=(damagemult*0.5).round
          end
          if isConst?(opponent.ability,PBAbilities,:OBLIVIOUS) ||
           isConst?(opponent.ability,PBAbilities,:KLUTZ) ||
           isConst?(opponent.ability,PBAbilities,:UNAWARE) ||
           isConst?(opponent.ability,PBAbilities,:SIMPLE) ||
           opponent.effects[PBEffects::Confusion]>0
            damagemult=(damagemult*2).round
          end
          @battle.pbDisplay(_INTL("The chess piece slammed forward!",opponent.pbThis)) 
        end      
        if @id == "Z005" # Tectonic Rage Field Change
          damagemult=(damagemult*1.3).round
        end            
      when 6 # Big Top
        if ((isConst?(type,PBTypes,:FIGHTING) && pbIsPhysical?(type)) ||
          @id == "Z006") # Continental Crush
          striker = 1+rand(14)
          @battle.pbDisplay(_INTL("WHAMMO!",opponent.pbThis)) if $feshutup == 0
          $feshutup+=1
          if attacker.hasWorkingAbility(:HUGEPOWER) ||
           attacker.hasWorkingAbility(:GUTS) ||
           attacker.hasWorkingAbility(:PUREPOWER) ||
           attacker.hasWorkingAbility(:SHEERFORCE)
            if striker >=9
              striker = 15
            else
              striker = 14
            end
            strikermod = attacker.stages[PBStats::ATTACK]
            striker = striker + strikermod
          end
          if striker >= 15
            @battle.pbDisplay(_INTL("...OVER 9000!!!",opponent.pbThis))
            damagemult=(damagemult*3).round
          elsif striker >=13
            @battle.pbDisplay(_INTL("...POWERFUL!",opponent.pbThis))
            damagemult=(damagemult*2).round
          elsif striker >=9
            @battle.pbDisplay(_INTL("...NICE!",opponent.pbThis))
            damagemult=(damagemult*1.5).round
          elsif striker >=3
            @battle.pbDisplay(_INTL("...OK!",opponent.pbThis))
          else
            @battle.pbDisplay(_INTL("...WEAK!",opponent.pbThis))
            damagemult=(damagemult*0.5).round
          end
        end
      when 7 # Burning Field
        if @id == "Z006" # Continental Crush Field Change
          damagemult=(damagemult*1.3).round
        end    
        if @id == "Z011" # Hydro Vortex Field Change
          damagemult=(damagemult*1.3).round
        end    
        if @id == "Z022" # Oceanic Operetta Field Change
          damagemult=(damagemult*1.3).round
        end          
      when 8 # Swamp Field
        if @id == "Z011" # Hydro Vortex
          damagemult=(damagemult*1.5).round
          @battle.pbDisplay(_INTL("The murk strengthened the attack!"))
        end
      when 9 # Rainbow Field
        if @id == "Z018" # Twinkle Tackle
          damagemult=(damagemult*1.5).round
          @battle.pbDisplay(_INTL("The attack was rainbow-charged!"))
        end
        if @id == "Z008" # Never-Ending Nightmare
          damagemult=(damagemult*0.5).round
          @battle.pbDisplay(_INTL("The rainbow softened the attack..."))
        end
      when 10 # Corrosive Field
      when 11 # Corrosive Mist Field
        if @id == "Z003" # Supersonic Skystrike Field Change
          damagemult=(damagemult*1.3).round
        end            
        if @id == "Z010" # Inferno Overdrive Field Change
          damagemult=(damagemult*1.3).round
        end               
      when 12 # Desert Field
      when 13 # Icy Field
        if @id == "Z010" # Inferno Overdrive Field Change
          damagemult=(damagemult*1.3).round
        end                   
      when 14 # Rocky Field
      when 15 # Forest Field
      when 16 # Superheated Field
        if @id == "Z011" || @id == "Z022" # Hydro Vortex & Oceanic Operetta
          damagemult=(damagemult*0.625).round
        end   
        if @id == "Z015" # Subzero Slammer Field Change
          damagemult=(damagemult*1.3).round
        end                 
      when 17 # Factory Field
        if @id == "Z005" # Tectonic Rage Field Change
          damagemult=(damagemult*1.3).round
        end       
        if @id == "Z013" # Gigavolt Havoc Field Change
          damagemult=(damagemult*1.3).round
        end           
      when 18 # Shortcircuit Field
        if isConst?(type,PBTypes,:ELECTRIC)
          striker = 1+rand(14)
          if striker >= 13
            @battle.pbDisplay(_INTL("BZZZAPP!",opponent.pbThis)) if $feshutup == 0
          $feshutup+=1
            damagemult=(damagemult*2.0).round
          elsif striker >= 9
            @battle.pbDisplay(_INTL("Bzzapp!",opponent.pbThis)) if $feshutup == 0
          $feshutup+=1
            damagemult=(damagemult*1.5).round
          elsif striker >= 6
            @battle.pbDisplay(_INTL("Bzap!",opponent.pbThis)) if $feshutup == 0
          $feshutup+=1
            damagemult=(damagemult*1.2).round
          elsif striker >= 3
            @battle.pbDisplay(_INTL("Bzzt.",opponent.pbThis)) if $feshutup == 0
          $feshutup+=1
            damagemult=(damagemult*0.8).round
          else
            @battle.pbDisplay(_INTL("Bzt...",opponent.pbThis)) if $feshutup == 0
          $feshutup+=1
            damagemult=(damagemult*0.5).round
          end
        end
        if @id == "Z011" # Hydro Vortex
          damagemult=(damagemult*1.5).round
          @battle.pbDisplay(_INTL("The attack picked up electricity!"))
        end 
        if @id == "Z013" # Gigavolt Havoc Field Change
          damagemult=(damagemult*1.3).round
        end         
      when 19 # Wasteland
      when 20 # Ashen Beach
      when 21 # Water Surface
        if @id == "Z011" # Hydro Vortex
          damagemult=(damagemult*1.5).round
          @battle.pbDisplay(_INTL("The attack rode the current!"))
        end            
        if @id == "Z004" # Acid Downpour Field Change
          damagemult=(damagemult*1.3).round
        end      
        if @id == "Z015" # Subzero Slammer Field Change
          damagemult=(damagemult*1.3).round
        end           
      when 22 # Underwater
        if @id == "Z004" # Acid Downpour Field Change
          damagemult=(damagemult*1.3).round
        end           
      when 23 # Cave
        if @id == "Z005" # Tectonic Rage Field Change
          damagemult=(damagemult*1.3).round
        end
        if @id == "Z006" # Continental Crush Field Change
          damagemult=(damagemult*1.3).round
        end
        if @id == "Z004" # Acid Downpour Field Change
          damagemult=(damagemult*1.3).round
        end         
      when 25 # Crystal Cavern
        if @id == "Z005" # Tectonic Rage Field Change
          damagemult=(damagemult*1.3).round
        end              
      when 26 # Murkwater Surface
        if @id == "Z015" # Subzero Slammer Field Change
          damagemult=(damagemult*1.3).round
        end            
      when 27 # Mountain
        if @id == "Z010" # Inferno Overdrive Field Change
          damagemult=(damagemult*1.3).round
        end
        if @id == "Z015" # Subzero Slammer Field Change
          damagemult=(damagemult*1.3).round
        end
      when 28 # Snowy Mountain
        if @id == "Z010" # Inferno Overdrive Field Change
          damagemult=(damagemult*1.3).round
        end            
      when 29 # Holy
        if @id == "Z026" # Genesis Supernova
          damagemult=(damagemult*1.3).round
          @battle.pbDisplay(_INTL("The legendary energy resonated with the attack!"))
        end
        if @id == "Z008" # Never-Ending Nightmare
          damagemult=(damagemult*0.5).round
          @battle.pbDisplay(_INTL("The holy aura softened the attack."))
        end
      when 30 # Mirror
      when 31 # Fairy Tale
      when 32 # Dragon's Den
        if @id == "Z005" || @id == "Z006"  # Tectonic Rage & Continental Crush
          @battle.pbDisplay(_INTL("{1} was knocked into the lava!",opponent.pbThis))
        end     
        if @id == "Z015" # Subzero Slammer Field Change
          damagemult=(damagemult*1.3).round
        end               
        if @id == "Z011" # Hydro Vortex Field Change
          damagemult=(damagemult*1.3).round
        end          
      when 33 # Flower Garden
        if @id == "Z010" # Inferno Overdrive Field Change
          damagemult=(damagemult*1.3).round
        end           
      when 34 # Starlight Arena
        if @id == "Z017" # Black Hole Eclipse
          damagemult=(damagemult*2).round
          @battle.pbDisplay(_INTL("The astral energy boosted the attack!"))
        end          
      when 35 # New World
        if @id == "Z006" # Continental Crush
          damagemult=(damagemult*1.5).round
          @battle.pbDisplay(_INTL("The germinal matter amassed in the attack!"))
        end
        if @id == "Z017" # Black Hole Eclipse
          damagemult=(damagemult*4).round
          @battle.pbDisplay(_INTL("The void swallowed up {1}!",opponent.pbThis))
        end
        if @id == "Z026" # Genesis Supernova
          damagemult=(damagemult*1.5).round
          @battle.pbDisplay(_INTL("The ethereal energy strengthened the attack!"))
        end   
        if @id == "Z028" # Soul-Stealing 7 Star Strike
          damagemult=(damagemult*1.5).round
          @battle.pbDisplay(_INTL("The ethereal energy strengthened the attack!"))
        end          
    end
    #End S.Field Effects 
    basedmg=(basedmg*damagemult*1.0/0x1000).round
    ##### Calculate attacker's attack stat #####
    atk=attacker.attack
    atkstage=attacker.stages[PBStats::ATTACK]+6
    if attacker.effects[PBEffects::PowerTrick]
      atk=attacker.defense
      atkstage=attacker.stages[PBStats::DEFENSE]+6
    end    
    if type>=0 && pbIsSpecial?(type)
      atk=attacker.spatk
      atkstage=attacker.stages[PBStats::SPATK]+6
      if $fefieldeffect == 24
        avBoost = 1
        specsBoost = 1    
        evioBoost = 1
        dstBoost = 1
        lbBoost = 1
       # dewBoost = 1
        dssBoost = 1
        mpBoost = 1
        fbBoost = 1
        minusBoost = 1
        plusBoost = 1
        solarBoost = 1
        fgBoost = 1
        batteryBoost = 1
        avBoost = 1.5 if attacker.hasWorkingItem(:ASSAULTVEST)
        specsBoost = 1.5 if attacker.hasWorkingItem(:CHOICESPECS)
        evioBoost = 1.5 if attacker.hasWorkingItem(:EVIOLITE) && pbGetEvolvedFormData(attacker.species).length>0
        dstBoost = 2 if attacker.hasWorkingItem(:DEEPSEATOOTH) && isConst?(attacker.species,PBSpecies,:CLAMPERL)
        lbBoost = 2 if attacker.hasWorkingItem(:LIGHTBALL) && isConst?(attacker.species,PBSpecies,:PIKACHU)
#        dewBoost = 1.5 if attacker.hasWorkingItem(:SOULDEW) && (isConst?(attacker.species,PBSpecies,:LATIAS) || isConst?(attacker.species,PBSpecies,:LATIOS))
        dssBoost = 2 if attacker.hasWorkingItem(:DEEPSEASCALE) && isConst?(attacker.species,PBSpecies,:CLAMPERL)        
        mpBoost = 1.5 if attacker.hasWorkingItem(:METALPOWDER) && isConst?(attacker.species,PBSpecies,:DITTO)
        fbBoost = 1.5 if attacker.hasWorkingAbility(:FLAREBOOST) && attacker.status==PBStatuses::BURN
        minusboost = 1.5 if attacker.hasWorkingAbility(:MINUS) && attacker.pbPartner.hasWorkingAbility(:PLUS)
        plusboost = 1.5 if attacker.hasWorkingAbility(:PLUS) && attacker.pbPartner.hasWorkingAbility(:MINUS)
        solarBoost = 1.5 if attacker.hasWorkingAbility(:SOLARPOWER) && @battle.pbWeather==PBWeather::SUNNYDAY
        fgBoost = 1.5 if attacker.hasWorkingAbility(:FLOWERGIFT) && @battle.pbWeather==PBWeather::SUNNYDAY
        batteryBoost = 1.3 if attacker.pbPartner.hasWorkingAbility(:BATTERY)
        gl1 = attacker.spatk
        gl2 = attacker.spdef
        gl3 = attacker.stages[PBStats::SPDEF]+6
        gl4 = attacker.stages[PBStats::SPATK]+6
        gl2=(gl2*1.0*avBoost*evioBoost*dssBoost*fgBoost*stagemul[gl3]/stagediv[gl3]).floor
        gl1=(gl1*1.0*specsBoost*dstBoost*lbBoost*fbBoost*minusBoost*plusBoost*solarBoost*batteryBoost*stagemul[gl4]/stagediv[gl4]).floor
        if gl1 < gl2
          atk=attacker.spdef
          atkstage=attacker.stages[PBStats::SPDEF]+6
        end
      end
    end
    if (!opponent.hasWorkingAbility(:UNAWARE) || opponent.moldbroken)
      atkstage=6 if opponent.damagestate.critical && atkstage<6
      atk=(atk*1.0*stagemul[atkstage]/stagediv[atkstage]).floor
    end
    if attacker.hasWorkingAbility(:HUSTLE) && pbIsPhysical?(type)
      atk=(atk*1.5).round
    end
    atkmult=0x1000     
    if attacker.hasWorkingAbility(:FLOWERGIFT) && 
      @battle.pbWeather==PBWeather::SUNNYDAY && $fefieldeffect == 24
      if gl1 < gl2
        atkmult=(atkmult*1.5).round
      end
    end 
    if @battle.internalbattle
      if @battle.pbOwnedByPlayer?(attacker.index) && pbIsPhysical?(type) &&
         @battle.pbPlayer.numbadges>=BADGESBOOSTATTACK
        atkmult=(atkmult*1.1).round
      end
      if @battle.pbOwnedByPlayer?(attacker.index) && pbIsSpecial?(type) &&
         @battle.pbPlayer.numbadges>=BADGESBOOSTSPATK
        atkmult=(atkmult*1.1).round
      end
    end
    if opponent.hasWorkingAbility(:THICKFAT) &&
       (isConst?(type,PBTypes,:ICE) || isConst?(type,PBTypes,:FIRE)) && !(opponent.moldbroken)
      atkmult=(atkmult*0.5).round
    end
    if attacker.hp<=(attacker.totalhp/3).floor
      if (attacker.hasWorkingAbility(:OVERGROW) && isConst?(type,PBTypes,:GRASS)) ||
       (attacker.hasWorkingAbility(:BLAZE) && isConst?(type,PBTypes,:FIRE)) ||
       (attacker.hasWorkingAbility(:TORRENT) && isConst?(type,PBTypes,:WATER)) ||
       (attacker.hasWorkingAbility(:SWARM) && isConst?(type,PBTypes,:BUG))
        atkmult=(atkmult*1.5).round
      end
    elsif $fefieldeffect == 7 && (attacker.hasWorkingAbility(:BLAZE) &&
      isConst?(type,PBTypes,:FIRE))
      atkmult=(atkmult*1.5).round
    elsif $fefieldeffect == 15 && (attacker.hasWorkingAbility(:OVERGROW) &&
      isConst?(type,PBTypes,:GRASS))
      atkmult=(atkmult*1.5).round
    elsif $fefieldeffect == 15 && (attacker.hasWorkingAbility(:SWARM) &&
      isConst?(type,PBTypes,:BUG))
      atkmult=(atkmult*1.5).round
    elsif ($fefieldeffect == 21 || $fefieldeffect == 22) &&
     (attacker.hasWorkingAbility(:TORRENT) && isConst?(type,PBTypes,:WATER))
      atkmult=(atkmult*1.5).round
    elsif $fefieldeffect == 33 && (attacker.hasWorkingAbility(:SWARM) &&
      isConst?(type,PBTypes,:BUG))
      atkmult=(atkmult*1.5).round if $fecounter == 0 || $fecounter == 1
      atkmult=(atkmult*2).round if $fecounter == 2 || $fecounter == 3
      atkmult=(atkmult*3).round if $fecounter == 4
    elsif $fefieldeffect == 33 && (attacker.hasWorkingAbility(:OVERGROW) &&
      isConst?(type,PBTypes,:GRASS))
      case $fecounter
        when 1
          if attacker.hp<=(attacker.totalhp*0.67).floor
            atkmult=(atkmult*1.5).round
          end
        when 2
            atkmult=(atkmult*1.5).round
        when 3
            atkmult=(atkmult*2).round
        when 4
            atkmult=(atkmult*3).round
      end
    end
    if attacker.hasWorkingAbility(:GUTS) &&
      attacker.status!=0 && pbIsPhysical?(type)
      atkmult=(atkmult*1.5).round
    end
    if (attacker.hasWorkingAbility(:PLUS) || attacker.hasWorkingAbility(:MINUS)) &&
      pbIsSpecial?(type)
      partner=attacker.pbPartner
      if partner.hasWorkingAbility(:PLUS) || partner.hasWorkingAbility(:MINUS)
        atkmult=(atkmult*1.5).round
      elsif $fefieldeffect == 18
        atkmult=(atkmult*1.5).round
      end
    end
    if (attacker.pbPartner).hasWorkingAbility(:BATTERY) && pbIsSpecial?(type)
      atkmult=(atkmult*1.3).round
    end    
    if attacker.hasWorkingAbility(:DEFEATIST) &&
       attacker.hp<=(attacker.totalhp/2).floor
      atkmult=(atkmult*0.5).round
    end
    if attacker.hasWorkingAbility(:PUREPOWER) ||
       attacker.hasWorkingAbility(:HUGEPOWER) && pbIsPhysical?(type)
      atkmult=(atkmult*2.0).round
    end
    if attacker.hasWorkingAbility(:SOLARPOWER) &&
       @battle.pbWeather==PBWeather::SUNNYDAY && pbIsSpecial?(type)
      atkmult=(atkmult*1.5).round
    end
    if attacker.hasWorkingAbility(:FLASHFIRE) && $fefieldeffect!=39 &&
       attacker.effects[PBEffects::FlashFire] && isConst?(type,PBTypes,:FIRE)
      atkmult=(atkmult*1.5).round
    end
    if attacker.hasWorkingAbility(:SLOWSTART) &&
       attacker.turncount<5 && pbIsPhysical?(type)
      atkmult=(atkmult*0.5).round
    end
    if (@battle.pbWeather==PBWeather::SUNNYDAY || $fefieldeffect == 33) && pbIsPhysical?(type)
      if attacker.hasWorkingAbility(:FLOWERGIFT) &&
         isConst?(attacker.species,PBSpecies,:CHERRIM)
        atkmult=(atkmult*1.5).round
      end
      if attacker.pbPartner.hasWorkingAbility(:FLOWERGIFT)  &&
         isConst?(attacker.pbPartner.species,PBSpecies,:CHERRIM)
        atkmult=(atkmult*1.5).round
      end
    end
    if $fefieldeffect == 34 || $fefieldeffect == 35
      if attacker.hasWorkingAbility(:VICTORYSTAR)
        atkmult=(atkmult*1.5).round
      end
      partner=attacker.pbPartner
      if partner && partner.hasWorkingAbility(:VICTORYSTAR)
        atkmult=(atkmult*1.5).round
      end
    end
    atk=(atk*atkmult*1.0/0x1000).round
    ##### Calculate opponent's defense stat #####
    defense=opponent.defense
    defstage=opponent.stages[PBStats::DEFENSE]+6
    if opponent.effects[PBEffects::PowerTrick]
      defense=opponent.attack
      defstage=opponent.stages[PBStats::ATTACK]+6
    end     
    # TODO: Wonder Room should apply around here
    applysandstorm=false
    if type>=0 && pbIsSpecial?(type) && @function!=0x122 # Psyshock
      defense=opponent.spdef
      defstage=opponent.stages[PBStats::SPDEF]+6
      if $fefieldeffect == 24
        avBoost = 1
        specsBoost = 1    
        evioBoost = 1
        dstBoost = 1
        lbBoost = 1
#        dewBoost = 1
        dssBoost = 1
        mpBoost = 1
        fbBoost = 1
        minusBoost = 1
        plusBoost = 1
        solarBoost = 1
        fgBoost = 1
        batteryBoost = 1
        avBoost = 1.5 if opponent.hasWorkingItem(:ASSAULTVEST)
        specsBoost = 1.5 if opponent.hasWorkingItem(:CHOICESPECS)
        evioBoost = 1.5 if opponent.hasWorkingItem(:EVIOLITE) && pbGetEvolvedFormData(opponent.species).length>0
        dstBoost = 2 if opponent.hasWorkingItem(:DEEPSEATOOTH) && isConst?(opponent.species,PBSpecies,:CLAMPERL)
        lbBoost = 2 if opponent.hasWorkingItem(:LIGHTBALL) && isConst?(opponent.species,PBSpecies,:PIKACHU)
#        dewBoost = 1.5 if opponent.hasWorkingItem(:SOULDEW) && (isConst?(opponent.species,PBSpecies,:LATIAS) || isConst?(opponent.species,PBSpecies,:LATIOS))
        dssBoost = 2 if opponent.hasWorkingItem(:DEEPSEASCALE) && isConst?(opponent.species,PBSpecies,:CLAMPERL)        
        mpBoost = 1.5 if opponent.hasWorkingItem(:METALPOWDER) && isConst?(opponent.species,PBSpecies,:DITTO)
        fbBoost = 1.5 if opponent.hasWorkingAbility(:FLAREBOOST) && opponent.status==PBStatuses::BURN
        minusboost = 1.5 if opponent.hasWorkingAbility(:MINUS) && opponent.pbPartner.hasWorkingAbility(:PLUS)
        plusboost = 1.5 if opponent.hasWorkingAbility(:PLUS) && opponent.pbPartner.hasWorkingAbility(:MINUS)
        solarBoost = 1.5 if opponent.hasWorkingAbility(:SOLARPOWER) && @battle.pbWeather==PBWeather::SUNNYDAY
        fgBoost = 1.5 if opponent.hasWorkingAbility(:FLOWERGIFT) && @battle.pbWeather==PBWeather::SUNNYDAY       
        batteryBoost = 1.3 if attacker.pbPartner.hasWorkingAbility(:BATTERY)
        gl1 = opponent.spatk
        gl2 = opponent.spdef
        gl3 = opponent.stages[PBStats::SPDEF]+6
        gl4 = opponent.stages[PBStats::SPATK]+6
        gl2=(gl2*1.0*avBoost*evioBoost*dssBoost*fgBoost*stagemul[gl3]/stagediv[gl3]).floor
        gl1=(gl1*1.0*specsBoost*dstBoost*lbBoost*fbBoost*minusBoost*plusBoost*solarBoost*batteryBoost*stagemul[gl4]/stagediv[gl4]).floor
        if gl1 > gl2
          defense=opponent.spatk
          defstage=opponent.stages[PBStats::SPATK]+6
        end
      end
      applysandstorm=true
    end
    if !attacker.hasWorkingAbility(:UNAWARE)
      defstage=6 if @function==0xA9 # Chip Away (ignore stat stages)
      defstage=6 if opponent.damagestate.critical && defstage>6
      defense=(defense*1.0*stagemul[defstage]/stagediv[defstage]).floor
    end
    if @battle.pbWeather==PBWeather::SANDSTORM &&
       opponent.pbHasType?(:ROCK) && applysandstorm
      defense=(defense*1.5).round
    end
    defmult=0x1000
    if opponent.hasWorkingItem(:CHOICESPECS) && $fefieldeffect == 24
      if gl1 > gl2   
        defmult=(defmult*1.5).round
      end
    end    
    if opponent.hasWorkingItem(:DEEPSEATOOTH) && 
      isConst?(opponent.species,PBSpecies,:CLAMPERL) && $fefieldeffect == 24
      if gl1 > gl2   
        defmult=(defmult*2).round
      end
    end       
    if opponent.hasWorkingItem(:LIGHTBALL) && 
      isConst?(opponent.species,PBSpecies,:PIKACHU) && $fefieldeffect == 24
      if gl1 > gl2   
        defmult=(defmult*2).round
      end
    end   
#    if opponent.hasWorkingItem(:SOULDEW) && (isConst?(opponent.species,PBSpecies,:LATIAS) || 
#      isConst?(opponent.species,PBSpecies,:LATIOS)) && $fefieldeffect == 24
#      if gl1 > gl2   
#        defmult=(defmult*1.5).round
#      end
#    end   
    if opponent.hasWorkingAbility(:FLAREBOOST) && 
      opponent.status==PBStatuses::BURN && $fefieldeffect == 24
      if gl1 > gl2   
        defmult=(defmult*1.5).round
      end
    end  
    if opponent.hasWorkingAbility(:MINUS) && 
    opponent.pbPartner.hasWorkingAbility(:PLUS) && $fefieldeffect == 24
      if gl1 > gl2   
        defmult=(defmult*1.5).round
      end
    end      
    if opponent.hasWorkingAbility(:PLUS) && 
      opponent.pbPartner.hasWorkingAbility(:MINUS) && $fefieldeffect == 24
      if gl1 > gl2   
        defmult=(defmult*1.5).round
      end
    end      
    if opponent.pbPartner.hasWorkingAbility(:BATTERY) && 
      $fefieldeffect == 24
      if gl1 > gl2   
        defmult=(defmult*1.3).round
      end
    end        
    if opponent.hasWorkingAbility(:SOLARPOWER) && 
      @battle.pbWeather==PBWeather::SUNNYDAY && $fefieldeffect == 24
      if gl1 > gl2   
        defmult=(defmult*1.5).round
      end
    end    
    if @battle.internalbattle
      if @battle.pbOwnedByPlayer?(opponent.index) && pbIsPhysical?(type) &&
         @battle.pbPlayer.numbadges>=BADGESBOOSTDEFENSE
        defmult=(defmult*1.1).round
      end
      if @battle.pbOwnedByPlayer?(opponent.index) && pbIsSpecial?(type) &&
         @battle.pbPlayer.numbadges>=BADGESBOOSTSPDEF
        defmult=(defmult*1.1).round
      end
    end
    if $fefieldeffect == 24 && @function==0xE0
      defmult=(defmult*0.5).round
    end
    if opponent.hasWorkingAbility(:MARVELSCALE) && pbIsPhysical?(type) &&
     (opponent.status>0 || $fefieldeffect == 3 || $fefieldeffect == 9 ||
      $fefieldeffect == 31 || $fefieldeffect == 32 || $fefieldeffect == 34) && !(opponent.moldbroken) 
      defmult=(defmult*1.5).round
    end
    if isConst?(opponent.ability,PBAbilities,:GRASSPELT) && pbIsPhysical?(type) &&
     ($fefieldeffect == 2 || $fefieldeffect == 15) # Grassy Field
      defmult=(defmult*1.5).round
    end
#### AME - 005 - START
    if opponent.hasWorkingAbility(:FLUFFY) && !(opponent.moldbroken) 
      if isContactMove? && !attacker.hasWorkingAbility(:LONGREACH)
        defmult=(defmult*2).round
      end      
      if isConst?(type,PBTypes,:FIRE)
        defmult=(defmult*0.5).round
      end      
    end
    if opponent.hasWorkingAbility(:FURCOAT) && pbIsPhysical?(type) && !(opponent.moldbroken)
      defmult=(defmult*1.5).round
    end
    if $fefieldeffect == 3 && pbIsSpecial?(type) &&
     opponent.pbHasType?(:FAIRY)
      defmult=(defmult*1.5).round
    end
    if $fefieldeffect == 12 && pbIsSpecial?(type) &&
     opponent.pbHasType?(:GROUND)
      defmult=(defmult*1.5).round
    end
    if $fefieldeffect == 22 && pbIsPhysical?(type) &&
     !isConst?(type,PBTypes,:WATER)
      defmult=(defmult*1.5).round
    end
#### AME - 005 - END
    if (@battle.pbWeather==PBWeather::SUNNYDAY || $fefieldeffect == 33) && 
      !(opponent.moldbroken) && pbIsSpecial?(type)
      if opponent.hasWorkingAbility(:FLOWERGIFT) &&
         isConst?(opponent.species,PBSpecies,:CHERRIM)
        defmult=(defmult*1.5).round
      end
      if opponent.pbPartner.hasWorkingAbility(:FLOWERGIFT)  &&
         isConst?(opponent.pbPartner.species,PBSpecies,:CHERRIM)
        defmult=(defmult*1.5).round
      end
    end
    if opponent.hasWorkingItem(:EVIOLITE)
      evos=pbGetEvolvedFormData(opponent.species)
      if evos && evos.length>0
        defmult=(defmult*1.5).round
      end
    end
    if opponent.hasWorkingItem(:ASSAULTVEST) && pbIsSpecial?(type)
      defmult=(defmult*1.5).round
    end
    if opponent.hasWorkingItem(:DEEPSEASCALE) &&
       isConst?(opponent.species,PBSpecies,:CLAMPERL) && pbIsSpecial?(type)
      defmult=(defmult*2.0).round
    end
    if opponent.hasWorkingItem(:METALPOWDER) &&
       isConst?(opponent.species,PBSpecies,:DITTO) &&
       !opponent.effects[PBEffects::Transform] && pbIsPhysical?(type)
      defmult=(defmult*2.0).round
    end
#    if opponent.hasWorkingItem(:SOULDEW) &&
#       (isConst?(opponent.species,PBSpecies,:LATIAS) ||
#       isConst?(opponent.species,PBSpecies,:LATIOS)) && pbIsSpecial?(type) &&
#       !@battle.rules["souldewclause"]
#      defmult=(defmult*1.5).round
#    end
    defense=(defense*defmult*1.0/0x1000).round
    ##### Main damage calculation #####
    damage=(((2.0*attacker.level/5+2).floor*basedmg*atk/defense).floor/50).floor+2
    # Field Effects
    case $fefieldeffect
      when 1 # Electric Field
        if isConst?(type,PBTypes,:ELECTRIC)
          isgrounded=pbTypeModifier(PBTypes::GROUND,opponent,attacker)
          if isgrounded != 0
            damage=(damage*1.5).floor
            @battle.pbDisplay(_INTL("The Electric Terrain strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
            $feshutup2+=1
          end
        end
      when 2 # Grassy Field
        if isConst?(type,PBTypes,:GRASS)
        isgrounded=pbTypeModifier(PBTypes::GROUND,opponent,attacker)
          if isgrounded != 0
            damage=(damage*1.5).floor
            @battle.pbDisplay(_INTL("The Grassy Terrain strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
            $feshutup2+=1
          end
        end
        if isConst?(type,PBTypes,:FIRE)
          isgrounded=pbTypeModifier(PBTypes::GROUND,attacker,opponent)
          if isgrounded != 0
            damage=(damage*1.5).floor
            @battle.pbDisplay(_INTL("The grass below caught flame!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
          end
        end
      when 3 # Misty Field
        if isConst?(type,PBTypes,:DRAGON)
          damage=(damage*0.5).floor
            @battle.pbDisplay(_INTL("The Misty Terrain weakened the attack!",opponent.pbThis)) if $feshutup2 == 0
            $feshutup2+=1
        end
      when 7 # Burning Field
        if isConst?(type,PBTypes,:FIRE)
          isgrounded=pbTypeModifier(PBTypes::GROUND,opponent,attacker)
          if isgrounded != 0
            damage=(damage*1.5).floor
            @battle.pbDisplay(_INTL("The blaze amplified the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
          end
        end
        if isConst?(type,PBTypes,:GRASS)
         isgrounded=pbTypeModifier(PBTypes::GROUND,attacker,opponent)
          if isgrounded != 0
            damage=(damage*0.5).floor
            @battle.pbDisplay(_INTL("The blaze softened the attack...",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
          end
        end
        if isConst?(type,PBTypes,:ICE)
          damage=(damage*0.5).floor
          @battle.pbDisplay(_INTL("The blaze softened the attack...",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 8 # Swamp Field
        if isConst?(type,PBTypes,:POISON)
          isgrounded=pbTypeModifier(PBTypes::GROUND,attacker,opponent)
          if isgrounded != 0
            damage=(damage*1.5).floor
            @battle.pbDisplay(_INTL("The poison infected the nearby murk!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
          end
        end
      when 9 # Rainbow Field
        if isConst?(type,PBTypes,:NORMAL) &&
         !pbIsPhysical?(pbType(@type,attacker,opponent))
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The rainbow energized the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 11 # Corrosive Field
        if isConst?(type,PBTypes,:FIRE)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The toxic mist caught flame!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 12 # DESERT Field
        if isConst?(type,PBTypes,:WATER)
          isgrounded=pbTypeModifier(PBTypes::GROUND,opponent,attacker)
          if isgrounded != 0
            damage=(damage*0.5).floor
            @battle.pbDisplay(_INTL("The desert softened the attack...",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
          end
        end
        if isConst?(type,PBTypes,:ELECTRIC)
          isgrounded=pbTypeModifier(PBTypes::GROUND,attacker,opponent)
          if isgrounded != 0
            damage=(damage*0.5).floor
            @battle.pbDisplay(_INTL("The desert softened the attack...",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
          end
        end
      when 13 # Icy Field
        if isConst?(type,PBTypes,:FIRE)
          damage=(damage*0.5).floor
          @battle.pbDisplay(_INTL("The cold softened the attack...",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:ICE)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The cold strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 14 # Rocky Field
        if isConst?(type,PBTypes,:ROCK)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The field strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 15 # Forest Field
        if isConst?(type,PBTypes,:GRASS)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The forestry strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:BUG) &&
         !pbIsPhysical?(pbType(@type,attacker,opponent))
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The attack spreads through the forest!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 16 # Superheated Field
        if isConst?(type,PBTypes,:FIRE)
          damage=(damage*1.1).floor
          @battle.pbDisplay(_INTL("The attack was super-heated!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:ICE)
          damage=(damage*0.5).floor
          @battle.pbDisplay(_INTL("The extreme heat softened the attack...",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:WATER)
          damage=(damage*0.9).floor
          @battle.pbDisplay(_INTL("The extreme heat softened the attack...",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 17 # Factory Field
        if isConst?(type,PBTypes,:ELECTRIC)
          damage=(damage*1.2).floor
          @battle.pbDisplay(_INTL("The attack took energy from the field!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 21 # Water Surface
        if isConst?(type,PBTypes,:WATER)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The water strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:ELECTRIC)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The water conducted the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:FIRE)
          isgrounded=pbTypeModifier(PBTypes::GROUND,attacker,opponent)
          if isgrounded != 0
            damage=(damage*0.5).floor
            @battle.pbDisplay(_INTL("The water deluged the attack...",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
          end
        end
      when 22 # Underwater
        if isConst?(type,PBTypes,:WATER)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The water strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:ELECTRIC)
          damage=(damage*2).floor
          @battle.pbDisplay(_INTL("The water super-conducted the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 23 # Cave
        if isConst?(type,PBTypes,:FLYING) && !(isContactMove?)
          damage=(damage*0.5).floor
          @battle.pbDisplay(_INTL("The cave choked out the air!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:ROCK)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The cavern strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 24 # Glitch
        if isConst?(type,PBTypes,:PSYCHIC)
          damage=(damage*1.2).floor
          @battle.pbDisplay(_INTL(".0P pl$ nerf!-//",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 25 # Crystal Cavern
        if isConst?(type,PBTypes,:ROCK)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The crystals charged the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:DRAGON)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The crystal energy strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 26 # Murkwater Surface
        if isConst?(type,PBTypes,:WATER) || isConst?(type,PBTypes,:POISON)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The toxic water strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:ELECTRIC)
          damage=(damage*1.3).floor
          @battle.pbDisplay(_INTL("The toxic water conducted the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 27 # Mountain
        if isConst?(type,PBTypes,:ROCK)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The mountain strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:FLYING)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The open air strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:FLYING) &&
         !pbIsPhysical?(pbType(@type,attacker,opponent)) && 
         @battle.pbWeather==PBWeather::STRONGWINDS
          damage=(damage*1.5).floor
        end
      when 28 # Snowy Mountain
        if isConst?(type,PBTypes,:ROCK) || isConst?(type,PBTypes,:ICE)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The snowy mountain strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:FLYING)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The open air strengthened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:FLYING) &&
         !pbIsPhysical?(pbType(@type,attacker,opponent)) && 
         @battle.pbWeather==PBWeather::STRONGWINDS
          damage=(damage*1.5).floor
        end
        if isConst?(type,PBTypes,:FIRE)
          damage=(damage*0.5).floor
          @battle.pbDisplay(_INTL("The cold softened the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 29 # Holy Field
        if (isConst?(type,PBTypes,:GHOST) || (isConst?(type,PBTypes,:DARK)) &&
         !pbIsPhysical?(pbType(@type,attacker,opponent)))
          damage=(damage*0.5).floor
          @battle.pbDisplay(_INTL("The attack was cleansed...",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if (isConst?(type,PBTypes,:FAIRY) ||(isConst?(type,PBTypes,:NORMAL)) &&
         !pbIsPhysical?(pbType(@type,attacker,opponent)))
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The holy energy resonated with the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:PSYCHIC) || isConst?(type,PBTypes,:DRAGON)
          damage=(damage*1.2).floor
          @battle.pbDisplay(_INTL("The legendary energy resonated with the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 31# Fairy Tale
        if isConst?(type,PBTypes,:STEEL)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("For justice!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:FAIRY)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("For ever after!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:DRAGON)
          damage=(damage*2).floor
          @battle.pbDisplay(_INTL("The foul beast's attack gained strength!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 32 # Dragon's Den
        if isConst?(type,PBTypes,:FIRE)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The lava's heat boosted the flame!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
         if isConst?(type,PBTypes,:ICE) || isConst?(type,PBTypes,:WATER)
          damage=(damage*0.5).floor
          @battle.pbDisplay(_INTL("The lava's heat softened the attack...",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:DRAGON)
          damage=(damage*2).floor
          @battle.pbDisplay(_INTL("The draconic energy boosted the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 33 # Flower Field
        if isConst?(type,PBTypes,:GRASS)
          case $fecounter
            when 1
              damage=(damage*1.2).floor
              @battle.pbDisplay(_INTL("The garden's power boosted the attack!",opponent.pbThis)) if $feshutup2 == 0
              $feshutup2+=1
            when 2
              damage=(damage*1.5).floor
              @battle.pbDisplay(_INTL("The budding flowers boosted the attack!",opponent.pbThis)) if $feshutup2 == 0
              $feshutup2+=1              
            when 3
              damage=(damage*2).floor
              @battle.pbDisplay(_INTL("The blooming flowers boosted the attack!",opponent.pbThis)) if $feshutup2 == 0
              $feshutup2+=1              
            when 4
              damage=(damage*3).floor
              @battle.pbDisplay(_INTL("The thriving flowers boosted the attack!",opponent.pbThis)) if $feshutup2 == 0
              $feshutup2+=1
          end
        end
        if $fecounter > 1
          if isConst?(type,PBTypes,:FIRE)
            damage=(damage*1.5).floor
            @battle.pbDisplay(_INTL("The nearby flowers caught flame!",opponent.pbThis)) if $feshutup2 == 0
            $feshutup2+=1
          end
        end
        if $fecounter > 3
          if isConst?(type,PBTypes,:BUG)
            damage=(damage*2).floor
            @battle.pbDisplay(_INTL("The attack infested the flowers!",opponent.pbThis)) if $feshutup2 == 0
            $feshutup2+=1
          end
        elsif $fecounter > 1
          if isConst?(type,PBTypes,:BUG)
            damage=(damage*1.5).floor
            @battle.pbDisplay(_INTL("The attack infested the garden!",opponent.pbThis)) if $feshutup2 == 0
            $feshutup2+=1
          end
        end
      when 34 # Starlight Arena
        if isConst?(type,PBTypes,:DARK)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The night sky boosted the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
         if isConst?(type,PBTypes,:PSYCHIC) || isConst?(type,PBTypes,:WATER)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("The astral energy boosted the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
        if isConst?(type,PBTypes,:FAIRY)
          damage=(damage*1.3).floor
          @battle.pbDisplay(_INTL("Starlight supercharged the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
      when 35 # New World
        if isConst?(type,PBTypes,:DARK)
          damage=(damage*1.5).floor
          @battle.pbDisplay(_INTL("Infinity boosted the attack!",opponent.pbThis)) if $feshutup2 == 0
          $feshutup2+=1
        end
    end
    # FIELD TRANSFORMATIONS
    case $fefieldeffect
      when 2 # Grassy Field
      when 3 # Misty Field
      when 4 # Dark Crystal Cavern
      when 7 # Burning Field
      when 10 # Corrosive Field
      when 11 # Corrosive Mist Field
      when 13 # Icy Field
      when 15 # Forest Field
      when 16 # Superheated Field
      when 17 # Factory Field
      when 18 # Shortcircuit Field
      when 21 # Water Surface
      when 22 # Underwater
      when 23 # Cave Field
      when 25 # Crystal Cavern
      when 26 # Murkwater Surface
      when 27 # Mountain
      when 28 # Snowy Mountain 
      when 30 # Mirror Arena
      when 32 # Dragon's Den
      when 33 # Flower Garden Field
    end
    #End Field Transformations
    # Weather
    case @battle.pbWeather
      when PBWeather::SUNNYDAY
##### KUROTSUNE - 001 - START
        if @battle.field.effects[PBEffects::HarshSunlight] &&
           isConst?(type,PBTypes,:WATER)
          @battle.pbDisplay(_INTL("The Water-type attack evaporated in the harsh sunlight!"))
          return 0
        end
##### KUROTSUNE - 001 - END
        if isConst?(type,PBTypes,:FIRE)
          damage=(damage*1.5).round
        elsif isConst?(type,PBTypes,:WATER)
          damage=(damage*0.5).round
        end
      when PBWeather::RAINDANCE
##### KUROTSUNE - 001 - START
        if @battle.field.effects[PBEffects::HeavyRain] &&
        isConst?(type,PBTypes,:FIRE)
          @battle.pbDisplay(_INTL("The Fire-type attack fizzled out in the heavy rain!"))
          return 0
        end
##### KUROTSUNE - 001 - END
        if isConst?(type,PBTypes,:FIRE)
          damage=(damage*0.5).round
        elsif isConst?(type,PBTypes,:WATER)
          damage=(damage*1.5).round
        end
    end
    # Critical hits
    if opponent.damagestate.critical
      damage=(damage*1.5).round
      if attacker.hasWorkingAbility(:SNIPER)
        damage=(damage*1.5).round
      end
      if $fefieldeffect == 30
        if $buffs == 1
          damage=(damage*1.5).round
          @battle.pbDisplay(_INTL("{1} came into focus with the attack!",attacker.pbThis))
        elsif $buffs == 2
          damage=(damage*2).round
          @battle.pbDisplay(_INTL("{1} came into focus with the attack!",attacker.pbThis))
        elsif $buffs >= 3
          damage=(damage*2.5).round
          @battle.pbDisplay(_INTL("{1} came into focus with the attack!",attacker.pbThis))
        end
        attacker.stages[PBStats::EVASION]=0 if attacker.stages[PBStats::EVASION] > 0
        attacker.stages[PBStats::ACCURACY]=0 if attacker.stages[PBStats::ACCURACY] > 0
        opponent.stages[PBStats::EVASION]=0 if opponent.stages[PBStats::EVASION] < 0
        opponent.stages[PBStats::ACCURACY]=0 if opponent.stages[PBStats::ACCURACY] < 0
      end
    end
    if attacker.hasWorkingAbility(:WATERBUBBLE) && type == PBTypes::WATER
      damage=(damage*=2).round
    end      
    # Random variance
    random=85+@battle.pbRandom(16)
    damage=(damage*random/100.0).floor
    # STAB
    if (attacker.pbHasType?(type) || (attacker.hasWorkingAbility(:STEELWORKER) && 
      type == PBTypes::STEEL))
      if attacker.hasWorkingAbility(:ADAPTABILITY)
        damage=(damage*2).round
      else
        damage=(damage*1.5).round
      end
    end
    # Type effectiveness
    typemod=pbTypeModMessages(type,attacker,opponent)
    damage=(damage*typemod/4.0).round
    opponent.damagestate.typemod=typemod
    if typemod==0
      opponent.damagestate.calcdamage=0
      opponent.damagestate.critical=false
      return 0
    end
    if opponent.hasWorkingAbility(:WATERBUBBLE) && type == PBTypes::FIRE
      damage=(damage*=0.5).round
    end    
    # Burn
    if attacker.status==PBStatuses::BURN && pbIsPhysical?(type) &&
       !attacker.hasWorkingAbility(:GUTS)
      damage=(damage*0.5).round
    end
    # Make sure damage is at least 1
    damage=1 if damage<1
    # Final damage modifiers
    finaldamagemult=0x1000
    if !opponent.damagestate.critical &&
       !attacker.hasWorkingAbility(:INFILTRATOR)
      # Reflect
      if opponent.pbOwnSide.effects[PBEffects::Reflect]>0 && pbIsPhysical?(type)
        # TODO: should apply even if partner faints during an attack]
        if !opponent.pbPartner.isFainted?
          finaldamagemult=(finaldamagemult*0.66).round
        else
          finaldamagemult=(finaldamagemult*0.5).round
        end
      end
      # Light Screen
      if opponent.pbOwnSide.effects[PBEffects::LightScreen]>0 && pbIsSpecial?(type)
        # TODO: should apply even if partner faints during an attack]
        if !opponent.pbPartner.isFainted?
          finaldamagemult=(finaldamagemult*0.66).round
        else
          finaldamagemult=(finaldamagemult*0.5).round
        end
      end
      # Aurora Veil
      if opponent.pbOwnSide.effects[PBEffects::AuroraVeil]>0
        # TODO: should apply even if partner faints during an attack]
        if !opponent.pbPartner.isFainted?
          finaldamagemult=(finaldamagemult*0.66).round
        else
          finaldamagemult=(finaldamagemult*0.5).round
        end
      end     
    end
    if ((opponent.hasWorkingAbility(:MULTISCALE) &&
        !(opponent.moldbroken)) || opponent.hasWorkingAbility(:SHADOWSHIELD)) && opponent.hp==opponent.totalhp 
      finaldamagemult=(finaldamagemult*0.5).round
    end
#### JERICHO - 006 - START    
    if attacker.hasWorkingAbility(:TINTEDLENS) &&
#### JERICHO - 006 - END      
       opponent.damagestate.typemod<4
      finaldamagemult=(finaldamagemult*2.0).round
    end
    if opponent.pbPartner.hasWorkingAbility(:FRIENDGUARD) && !(opponent.moldbroken)
      finaldamagemult=(finaldamagemult*0.75).round
    end
    if $fefieldeffect == 33 && $fecounter >1 
      if (opponent.pbPartner.hasWorkingAbility(:FLOWERVEIL) &&
       opponent.pbHasType?(:GRASS)) ||
       opponent.hasWorkingAbility(:FLOWERVEIL) && !(opponent.moldbroken)
        finaldamagemult=(finaldamagemult*0.5).round
        @battle.pbDisplay(_INTL("The Flower Veil softened the attack!"))
      end
      case $fecounter
        when 2
          if opponent.pbHasType?(:GRASS)
            finaldamagemult=(finaldamagemult*0.75).round
          end
        when 3
          if opponent.pbHasType?(:GRASS)
            finaldamagemult=(finaldamagemult*0.67).round
          end
        when 4
          if opponent.pbHasType?(:GRASS)
            finaldamagemult=(finaldamagemult*0.5).round
          end
      end
    end
    if (((opponent.hasWorkingAbility(:SOLIDROCK) ||
       opponent.hasWorkingAbility(:FILTER)) &&
        !(opponent.moldbroken)) || opponent.hasWorkingAbility(:PRISMARMOR)) && 
        opponent.damagestate.typemod>4 
      finaldamagemult=(finaldamagemult*0.75).round
    end
    if attacker.hasWorkingAbility(:STAKEOUT) && @battle.switchedOut[opponent.index]
      finaldamagemult=(finaldamagemult*2.0).round
    end    
    if opponent.damagestate.typemod>4 
      if (opponent.hasWorkingItem(:CHOPLEBERRY) && isConst?(type,PBTypes,:FIGHTING)) ||
       (opponent.hasWorkingItem(:COBABERRY) && isConst?(type,PBTypes,:FLYING)) ||
       (opponent.hasWorkingItem(:KEBIABERRY) && isConst?(type,PBTypes,:POISON)) ||
       (opponent.hasWorkingItem(:SHUCABERRY) && isConst?(type,PBTypes,:GROUND)) ||
       (opponent.hasWorkingItem(:CHARTIBERRY) && isConst?(type,PBTypes,:ROCK)) ||
       (opponent.hasWorkingItem(:TANGABERRY) && isConst?(type,PBTypes,:BUG)) ||
       (opponent.hasWorkingItem(:KASIBBERRY) && isConst?(type,PBTypes,:GHOST)) ||
       (opponent.hasWorkingItem(:BABIRIBERRY) && isConst?(type,PBTypes,:STEEL)) ||
       (opponent.hasWorkingItem(:OCCABERRY) && isConst?(type,PBTypes,:FIRE)) ||
       (opponent.hasWorkingItem(:PASSHOBERRY) && isConst?(type,PBTypes,:WATER)) ||
       (opponent.hasWorkingItem(:RINDOBERRY) && isConst?(type,PBTypes,:GRASS)) ||
       (opponent.hasWorkingItem(:WACANBERRY) && isConst?(type,PBTypes,:ELECTRIC)) ||
       (opponent.hasWorkingItem(:PAYAPABERRY) && isConst?(type,PBTypes,:PSYCHIC)) ||
       (opponent.hasWorkingItem(:YACHEBERRY) && isConst?(type,PBTypes,:ICE)) ||
       (opponent.hasWorkingItem(:HABANBERRY) && isConst?(type,PBTypes,:DRAGON)) ||
       (opponent.hasWorkingItem(:COLBURBERRY) && isConst?(type,PBTypes,:DARK)) ||
       (opponent.hasWorkingItem(:ROSELIBERRY) && isConst?(type,PBTypes,:FAIRY))        
        finaldamagemult=(finaldamagemult*0.5).round
        opponent.pokemon.itemRecycle=opponent.item
        opponent.pokemon.itemInitial=0 if opponent.pokemon.itemInitial==opponent.item
        opponent.item=0
#### JERICHO - 008 - START      
        if !@battle.pbIsOpposing?(attacker.index)
          @battle.pbDisplay(_INTL("{2}'s {1} weakened the damage from the attack!",PBItems.getName(opponent.pokemon.itemRecycle),opponent.pbThis))
        else
          @battle.pbDisplay(_INTL("The {1} weakened the damage to {2}!",PBItems.getName(opponent.pokemon.itemRecycle),opponent.pbThis))
        end
#### JERICHO - 008 - END  
      end  
    end
    if opponent.hasWorkingItem(:CHILANBERRY) && isConst?(type,PBTypes,:NORMAL)
      finaldamagemult=(finaldamagemult*0.5).round
      opponent.pokemon.itemRecycle=opponent.item
      opponent.pokemon.itemInitial=0 if opponent.pokemon.itemInitial==opponent.item
      opponent.item=0
    end
    finaldamagemult=pbModifyDamage(finaldamagemult,attacker,opponent)
    damage=(damage*finaldamagemult*1.0/0x1000).round
    opponent.damagestate.calcdamage=damage
    return damage
  end  
  
  def pbModifyDamage(damagemult,attacker,opponent)
    if !opponent.effects[PBEffects::ProtectNegation] && (opponent.pbOwnSide.effects[PBEffects::MatBlock] || 
      opponent.effects[PBEffects::Protect] || opponent.effects[PBEffects::KingsShield] || 
      opponent.effects[PBEffects::SpikyShield] || opponent.effects[PBEffects::BanefulBunker])
      @battle.pbDisplay(_INTL("{1} couldn't fully protected itself!",opponent.pbThis))
      return (damagemult/4).floor
    else      
      return damagemult
    end    
  end    
  
  def pbIsCritical?(attacker,opponent)
    if (opponent.hasWorkingAbility(:BATTLEARMOR) ||
        opponent.hasWorkingAbility(:SHELLARMOR)) &&
        !(opponent.moldbroken)  
            return false 
    end
#### KUROTSUNE - 029 - END      
    return false if opponent.pbOwnSide.effects[PBEffects::LuckyChant]>0
    $buffs = 0
    if $fefieldeffect == 30
      $buffs = attacker.stages[PBStats::EVASION] if attacker.stages[PBStats::EVASION] > 0
      $buffs = $buffs.to_i + attacker.stages[PBStats::ACCURACY] if attacker.stages[PBStats::ACCURACY] > 0
      $buffs = $buffs.to_i - opponent.stages[PBStats::EVASION] if opponent.stages[PBStats::EVASION] < 0
      $buffs = $buffs.to_i - opponent.stages[PBStats::ACCURACY] if opponent.stages[PBStats::ACCURACY] < 0
      $buffs = $buffs.to_i
    end
    if attacker.effects[PBEffects::LaserFocus]
      attacker.effects[PBEffects::LaserFocus]=false
      return true
    end    
    return true if attacker.hasWorkingAbility(:MERCILESS) && (opponent.status == PBStatuses::POISON || 
    $fefieldeffect==10 || $fefieldeffect==11)
    c=0
    ratios=[24,8,2,1]
    c+=attacker.effects[PBEffects::FocusEnergy]
    c+=1 if attacker.hasWorkingAbility(:SUPERLUCK)
    c+=1 if attacker.speed > opponent.speed && $fefieldeffect == 24
    if $fefieldeffect == 30
      c += $buffs if $buffs > 0
    end
    c=3 if c>3
    return @battle.pbRandom(ratios[c])==0
  end    
  
  def pbTypeModMessages(type,attacker,opponent)
    return 4 if type<0
    if opponent.hasWorkingAbility(:SAPSIPPER) && !(opponent.moldbroken) && (isConst?(type,PBTypes,:GRASS))
      if opponent.pbCanIncreaseStatStage?(PBStats::ATTACK)
        opponent.pbIncreaseStatBasic(PBStats::ATTACK,1)
        @battle.pbCommonAnimation("StatUp",opponent,nil)
        @battle.pbDisplay(_INTL("{1}'s {2} raised its Attack!",
           opponent.pbThis,PBAbilities.getName(opponent.ability)))
      else
        @battle.pbDisplay(_INTL("{1}'s {2} made {3} ineffective!",
           opponent.pbThis,PBAbilities.getName(opponent.ability),self.name))
      end
      return 0
    end
    if (opponent.hasWorkingAbility(:STORMDRAIN) && (isConst?(type,PBTypes,:WATER))) ||
       (opponent.hasWorkingAbility(:LIGHTNINGROD) && (isConst?(type,PBTypes,:ELECTRIC))) &&
       !(opponent.moldbroken)
      if opponent.pbCanIncreaseStatStage?(PBStats::SPATK)
        opponent.pbIncreaseStatBasic(PBStats::SPATK,1)
        @battle.pbCommonAnimation("StatUp",opponent,nil)
        @battle.pbDisplay(_INTL("{1}'s {2} raised its Special Attack!",
           opponent.pbThis,PBAbilities.getName(opponent.ability)))
      else
        @battle.pbDisplay(_INTL("{1}'s {2} made {3} ineffective!",
           opponent.pbThis,PBAbilities.getName(opponent.ability),self.name))
      end
      return 0
    end
    if isConst?(opponent.ability,PBAbilities,:MOTORDRIVE) &&
      (isConst?(type,PBTypes,:ELECTRIC)) &&
      !(opponent.moldbroken) 
      if opponent.pbCanIncreaseStatStage?(PBStats::SPEED)
        if $fefieldeffect == 17
          opponent.pbIncreaseStatBasic(PBStats::SPEED,2)
          @battle.pbCommonAnimation("StatUp",opponent,nil)
          @battle.pbDisplay(_INTL("{1}'s {2} sharply raised its Speed!",
          opponent.pbThis,PBAbilities.getName(opponent.ability)))
        else
          opponent.pbIncreaseStatBasic(PBStats::SPEED,1)
          @battle.pbCommonAnimation("StatUp",opponent,nil)
          @battle.pbDisplay(_INTL("{1}'s {2} raised its Speed!",
          opponent.pbThis,PBAbilities.getName(opponent.ability)))
        end
      else
        @battle.pbDisplay(_INTL("{1}'s {2} made {3} ineffective!",
        opponent.pbThis,PBAbilities.getName(opponent.ability),self.name))
      end
      return 0
    end
    if ((opponent.hasWorkingAbility(:DRYSKIN) && !(opponent.moldbroken)) && (isConst?(type,PBTypes,:WATER))) ||
       (opponent.hasWorkingAbility(:VOLTABSORB) && !(opponent.moldbroken) && (isConst?(type,PBTypes,:ELECTRIC))) ||
       (opponent.hasWorkingAbility(:WATERABSORB) && !(opponent.moldbroken) && (isConst?(type,PBTypes,:WATER)))
      if opponent.effects[PBEffects::HealBlock]==0
        if opponent.pbRecoverHP((opponent.totalhp/4).floor,true)>0
          @battle.pbDisplay(_INTL("{1}'s {2} restored its HP!",
             opponent.pbThis,PBAbilities.getName(opponent.ability)))
        else
          @battle.pbDisplay(_INTL("{1}'s {2} made {3} useless!",
          opponent.pbThis,PBAbilities.getName(opponent.ability),@name))
        end
        return 0
      end
    end    
    if opponent.hasWorkingAbility(:FLASHFIRE) && !(opponent.moldbroken) && (isConst?(type,PBTypes,:FIRE)) && $fefieldeffect!=39
      if !opponent.effects[PBEffects::FlashFire]
        opponent.effects[PBEffects::FlashFire]=true
        @battle.pbDisplay(_INTL("{1}'s {2} raised its Fire power!",
           opponent.pbThis,PBAbilities.getName(opponent.ability)))
      else
        @battle.pbDisplay(_INTL("{1}'s {2} made {3} ineffective!",
           opponent.pbThis,PBAbilities.getName(opponent.ability),self.name))
      end
      return 0
    end
    if opponent.hasWorkingAbility(:MAGMAARMOR) && (isConst?(type,PBTypes,:FIRE)) &&
     $fefieldeffect == 32 && !(opponent.moldbroken)
      @battle.pbDisplay(_INTL("{1}'s {2} made {3} ineffective!",
       opponent.pbThis,PBAbilities.getName(opponent.ability),self.name))
      return 0
    end
    if ($fefieldeffect == 21 || $fefieldeffect == 26) &&
      (isConst?(type,PBTypes,:GROUND))
      @battle.pbDisplay(_INTL("...But there was no solid ground to attack from!"))
      return 0
    end
    if $fefieldeffect == 22 && (isConst?(type,PBTypes,:FIRE))
      @battle.pbDisplay(_INTL("...But the attack was doused instantly!"))
      return 0
    end
    #Telepathy
    if opponent.hasWorkingAbility(:TELEPATHY) && 
     @basedamage>0 &&
     !(opponent.moldbroken)
      partner=attacker.pbPartner
      if opponent.index == partner.index
        # if !@battle.pbIsOpposing?(attacker.index) #If it's your partner
        @battle.pbDisplay(_INTL("{1} avoids attacks by its ally Pokémon!",opponent.pbThis))
        return 0
      end
    end
    # UPDATE Implementing Flying Press + Freeze Dry
    typemod=pbTypeModifier(type,attacker,opponent)
    typemod2= nil
    typemod3= nil
    if isConst?(type,PBTypes,:WATER) &&
     opponent.pbHasType?(PBTypes::WATER) &&
      $fefieldeffect == 22
      typemod *= 2
    end
    if $fefieldeffect == 24
      if isConst?(type,PBTypes,:DRAGON)
        typemod = 4
      end
      if isConst?(type,PBTypes,:GHOST) && opponent.pbHasType?(PBTypes::PSYCHIC)
        typemod = 0
      end
      if isConst?(type,PBTypes,:BUG) && opponent.pbHasType?(PBTypes::POISON)
        typemod *= 4
      end
      if isConst?(type,PBTypes,:ICE) && opponent.pbHasType?(PBTypes::FIRE)
        typemod *= 2
      end
      if isConst?(type,PBTypes,:POISON) && opponent.pbHasType?(PBTypes::BUG)
        typemod *= 2
      end
    end
    if $fefieldeffect == 29
      if isConst?(type,PBTypes,:NORMAL) && (opponent.pbHasType?(PBTypes::DARK) ||
       opponent.pbHasType?(PBTypes::GHOST))
        typemod *= 2
      end
    end
    if $fefieldeffect == 31
      if isConst?(type,PBTypes,:STEEL) && (opponent.pbHasType?(PBTypes::DRAGON))
        typemod *= 2
      end
    end 
    if @battle.pbWeather==PBWeather::STRONGWINDS && 
     (opponent.pbHasType?(PBTypes::FLYING) && 
     !opponent.effects[PBEffects::Roost]) &&
     (isConst?(type,PBTypes,:ELECTRIC) || isConst?(type,PBTypes,:ICE) ||
     isConst?(type,PBTypes,:ROCK))
      typemod /= 2
    end
    if $fefieldeffect == 32 && # Dragons Den Multiscale
     opponent.hasWorkingAbility(:MULTISCALE) && 
     (isConst?(type,PBTypes,:FAIRY) || isConst?(type,PBTypes,:ICE) ||
     isConst?(type,PBTypes,:DRAGON)) && !(opponent.moldbroken)
      typemod /= 2
    end
    # Field Effect type changes go here
    typemod=FieldTypeChange(attacker,opponent,typemod,false)
    if typemod==0      
      @battle.pbDisplay(_INTL("It doesn't affect {1}...",opponent.pbThis(true)))      
    end
    return typemod
  end  
  
  def FieldTypeChange(attacker,opponent,typemod,absorbtion=false)
    case $fefieldeffect
      when 1 # Electric Field
        if @id == "Z011" # Hydro Vortex
          typemod2=pbTypeModifier(PBTypes::ELECTRIC,attacker,opponent)
          typemod3= ((typemod*typemod2) * 0.25).ceil
          typemod=typemod3
          typeChange=PBTypes::ELECTRIC
        end
      when 5 # Chess Field
        if @id == "Z006" # Continental Crush
          typemod2=pbTypeModifier(PBTypes::ROCK,attacker,opponent)
          typemod3= ((typemod*typemod2) * 0.25).ceil
          typemod=typemod3
          typeChange=PBTypes::ROCK
        end        
      when 7 # Burning Field
      when 8 # Swamp Field
      when 9 # Rainbow Field
      when 10 # Corrosive Field
      when 11 # Corrosive Mist Field
      when 14 # Rocky Field
      when 15 # Forest Field
      when 18 # Shortcircuit Field
        if @id == "Z011" # Hydro Vortex
          typemod2=pbTypeModifier(PBTypes::ELECTRIC,attacker,opponent)
          typemod3= ((typemod*typemod2) * 0.25).ceil
          typemod=typemod3
          typeChange=PBTypes::ELECTRIC
        end        
      when 19 # Wasteland Field
      when 20 # Ashen Beach
      when 22 # Underwater
      when 25 # Crystal Cavern
      when 26 # Murkwater Surface
      when 28 # Snowy Mountain
      when 31 # Fairy Tale
      when 32 # Dragon's Den
        if @id == "Z005" # Tectonic Rage
          typemod2=pbTypeModifier(PBTypes::FIRE,attacker,opponent)
          typemod3= ((typemod*typemod2) * 0.25).ceil
          typemod=typemod3
          typeChange=PBTypes::FIRE
        end          
        if @id == "Z006" # Continental Crush
          typemod2=pbTypeModifier(PBTypes::FIRE,attacker,opponent)
          typemod3= ((typemod*typemod2) * 0.25).ceil
          typemod=typemod3
          typeChange=PBTypes::FIRE
        end            
      when 34 # Starlight Arena
      when 35 # New World
      when 36 # Inverse Field
        temptypemod = typemod
        temptypemod = 16 if typemod == 0 
        temptypemod = 16 if typemod == 1
        temptypemod = 8 if typemod == 2
        temptypemod = 2 if typemod == 8
        temptypemod = 1 if typemod == 16
        typemod = temptypemod
      end   
      if absorbtion
        return typeChange
      else
        return typemod
      end
    end  
  
################################################################################
# PokeBattle_ActualScene Feature for playing animation (based on common anims)
################################################################################    
  
  def pbShowAnimation(movename,user,target,hitnum=0,alltargets=nil,showanimation=true)
    animname=movename.delete(" ").delete("-").upcase
    animations=load_data("Data/PkmnAnimations.rxdata")
    for i in 0...animations.length
      if @battle.pbBelongsToPlayer?(user.index)
        if animations[i] && animations[i].name=="ZMove:"+animname && showanimation
          @battle.scene.pbAnimationCore(animations[i],user,(target!=nil) ? target : user)
          return
        end
      else
        if animations[i] && animations[i].name=="OppZMove:"+animname && showanimation
          @battle.scene.pbAnimationCore(animations[i],target,(user!=nil) ? user : target)
          return
        end   
      end      
    end
  end  
  
################################################################################
# Z Status Effect check
################################################################################  
  
  def pbZStatus(move,attacker)
    atk1 =   [getID(PBMoves,:BULKUP),getID(PBMoves,:HONECLAWS),getID(PBMoves,:HOWL),getID(PBMoves,:LASERFOCUS),getID(PBMoves,:LEER),getID(PBMoves,:MEDITATE),getID(PBMoves,:ODORSLEUTH),getID(PBMoves,:POWERTRICK),getID(PBMoves,:ROTOTILLER),getID(PBMoves,:SCREECH),getID(PBMoves,:SHARPEN),getID(PBMoves,:TAILWHIP),getID(PBMoves,:TAUNT),getID(PBMoves,:TOPSYTURVY),getID(PBMoves,:WILLOWISP),getID(PBMoves,:WORKUP)]
    atk2 =   [getID(PBMoves,:MIRRORMOVE)]
    atk3 =   [getID(PBMoves,:SPLASH)]
    def1 =   [getID(PBMoves,:AQUARING),getID(PBMoves,:BABYDOLLEYES),getID(PBMoves,:BANEFULBUNKER),getID(PBMoves,:BLOCK),getID(PBMoves,:CHARM),getID(PBMoves,:DEFENDORDER),getID(PBMoves,:FAIRYLOCK),getID(PBMoves,:FEATHERDANCE),getID(PBMoves,:FLOWERSHIELD),getID(PBMoves,:GRASSYTERRAIN),getID(PBMoves,:GROWL),getID(PBMoves,:HARDEN),getID(PBMoves,:MATBLOCK),getID(PBMoves,:NOBLEROAR),getID(PBMoves,:PAINSPLIT),getID(PBMoves,:PLAYNICE),getID(PBMoves,:POISONGAS),getID(PBMoves,:POISONPOWDER),getID(PBMoves,:QUICKGUARD),getID(PBMoves,:REFLECT),getID(PBMoves,:ROAR),getID(PBMoves,:SPIDERWEB),getID(PBMoves,:SPIKES),getID(PBMoves,:SPIKYSHIELD),getID(PBMoves,:STEALTHROCK),getID(PBMoves,:STRENGTHSAP),getID(PBMoves,:TEARFULLOOK),getID(PBMoves,:TICKLE),getID(PBMoves,:TORMENT),getID(PBMoves,:TOXIC),getID(PBMoves,:TOXICSPIKES),getID(PBMoves,:VENOMDRENCH),getID(PBMoves,:WIDEGUARD),getID(PBMoves,:WITHDRAW)]
    def2 =   []
    def3 =   []
    spatk1 = [getID(PBMoves,:CONFUSERAY),getID(PBMoves,:ELECTRIFY),getID(PBMoves,:EMBARGO),getID(PBMoves,:FAKETEARS),getID(PBMoves,:GEARUP),getID(PBMoves,:GRAVITY),getID(PBMoves,:GROWTH),getID(PBMoves,:INSTRUCT),getID(PBMoves,:IONDELUGE),getID(PBMoves,:METALSOUND),getID(PBMoves,:MINDREADER),getID(PBMoves,:MIRACLEEYE),getID(PBMoves,:NIGHTMARE),getID(PBMoves,:PSYCHICTERRAIN),getID(PBMoves,:REFLECTTYPE),getID(PBMoves,:SIMPLEBEAM),getID(PBMoves,:SOAK),getID(PBMoves,:SWEETKISS),getID(PBMoves,:TEETERDANCE),getID(PBMoves,:TELEKINESIS)]
    spatk2 = [getID(PBMoves,:HEALBLOCK),getID(PBMoves,:PSYCHOSHIFT)]
    spatk3 = []
    spdef1 = [getID(PBMoves,:CHARGE),getID(PBMoves,:CONFIDE),getID(PBMoves,:COSMICPOWER),getID(PBMoves,:CRAFTYSHIELD),getID(PBMoves,:EERIEIMPULSE),getID(PBMoves,:ENTRAINMENT),getID(PBMoves,:FLATTER),getID(PBMoves,:GLARE),getID(PBMoves,:INGRAIN),getID(PBMoves,:LIGHTSCREEN),getID(PBMoves,:MAGICROOM),getID(PBMoves,:MAGNETICFLUX),getID(PBMoves,:MEANLOOK),getID(PBMoves,:MISTYTERRAIN),getID(PBMoves,:MUDSPORT),getID(PBMoves,:SPOTLIGHT),getID(PBMoves,:STUNSPORE),getID(PBMoves,:THUNDERWAVE),getID(PBMoves,:WATERSPORT),getID(PBMoves,:WHIRLWIND),getID(PBMoves,:WISH),getID(PBMoves,:WONDERROOM)]
    spdef2 = [getID(PBMoves,:AROMATICMIST),getID(PBMoves,:CAPTIVATE),getID(PBMoves,:IMPRISON),getID(PBMoves,:MAGICCOAT),getID(PBMoves,:POWDER)]
    spdef3 = []
    speed1 = [getID(PBMoves,:AFTERYOU),getID(PBMoves,:AURORAVEIL),getID(PBMoves,:ELECTRICTERRAIN),getID(PBMoves,:ENCORE),getID(PBMoves,:GASTROACID),getID(PBMoves,:GRASSWHISTLE),getID(PBMoves,:GUARDSPLIT),getID(PBMoves,:GUARDSWAP),getID(PBMoves,:HAIL),getID(PBMoves,:HYPNOSIS),getID(PBMoves,:LOCKON),getID(PBMoves,:LOVELYKISS),getID(PBMoves,:POWERSPLIT),getID(PBMoves,:POWERSWAP),getID(PBMoves,:QUASH),getID(PBMoves,:RAINDANCE),getID(PBMoves,:ROLEPLAY),getID(PBMoves,:SAFEGUARD),getID(PBMoves,:SANDSTORM),getID(PBMoves,:SCARYFACE),getID(PBMoves,:SING),getID(PBMoves,:SKILLSWAP),getID(PBMoves,:SLEEPPOWDER),getID(PBMoves,:SPEEDSWAP),getID(PBMoves,:STICKYWEB),getID(PBMoves,:STRINGSHOT),getID(PBMoves,:SUNNYDAY),getID(PBMoves,:SUPERSONIC),getID(PBMoves,:TOXICTHREAD),getID(PBMoves,:WORRYSEED),getID(PBMoves,:YAWN)]
    speed2 = [getID(PBMoves,:ALLYSWITCH),getID(PBMoves,:BESTOW),getID(PBMoves,:MEFIRST),getID(PBMoves,:RECYCLE),getID(PBMoves,:SNATCH),getID(PBMoves,:SWITCHEROO),getID(PBMoves,:TRICK)]
    speed3 = []
    acc1   = [getID(PBMoves,:COPYCAT),getID(PBMoves,:DEFENSECURL),getID(PBMoves,:DEFOG),getID(PBMoves,:FOCUSENERGY),getID(PBMoves,:MIMIC),getID(PBMoves,:SWEETSCENT),getID(PBMoves,:TRICKROOM)]
    acc2   = []
    acc3   = []
    eva1   = [getID(PBMoves,:CAMOFLAUGE),getID(PBMoves,:DETECT),getID(PBMoves,:FLASH),getID(PBMoves,:KINESIS),getID(PBMoves,:LUCKYCHANT),getID(PBMoves,:MAGNETRISE),getID(PBMoves,:SANDATTACK),getID(PBMoves,:SMOKESCREEN)]
    eva2   = []
    eva3   = []
    stat1  = [getID(PBMoves,:CELEBRATE),getID(PBMoves,:CONVERSION),getID(PBMoves,:FORESTSCURSE),getID(PBMoves,:GEOMANCY),getID(PBMoves,:HAPPYHOUR),getID(PBMoves,:HOLDHANDS),getID(PBMoves,:PURIFY),getID(PBMoves,:SKETCH),getID(PBMoves,:TRICKORTREAT)]
    stat2  = []
    stat3  = []
    reset  = [getID(PBMoves,:ACIDARMOR),getID(PBMoves,:AGILITY),getID(PBMoves,:AMNESIA),getID(PBMoves,:ATTRACT),getID(PBMoves,:AUTOTOMIZE),getID(PBMoves,:BARRIER),getID(PBMoves,:BATONPASS),getID(PBMoves,:CALMMIND),getID(PBMoves,:COIL),getID(PBMoves,:COTTONGUARD),getID(PBMoves,:COTTONSPORE),getID(PBMoves,:DARKVOID),getID(PBMoves,:DISABLE),getID(PBMoves,:DOUBLETEAM),getID(PBMoves,:DRAGONDANCE),getID(PBMoves,:ENDURE),getID(PBMoves,:FLORALHEALING),getID(PBMoves,:FOLLOWME),getID(PBMoves,:HEALORDER),getID(PBMoves,:HEALPULSE),getID(PBMoves,:HELPINGHAND),getID(PBMoves,:IRONDEFENSE),getID(PBMoves,:KINGSSHIELD),getID(PBMoves,:LEECHSEED),getID(PBMoves,:MILKDRINK),getID(PBMoves,:MINIMIZE),getID(PBMoves,:MOONLIGHT),getID(PBMoves,:MORNINGSUN),getID(PBMoves,:NASTYPLOT),getID(PBMoves,:PERISHSONG),getID(PBMoves,:PROTECT),getID(PBMoves,:QUIVERDANCE),getID(PBMoves,:RAGEPOWDER),getID(PBMoves,:RECOVER),getID(PBMoves,:REST),getID(PBMoves,:ROCKPOLISH),getID(PBMoves,:ROOST),getID(PBMoves,:SHELLSMASH),getID(PBMoves,:SHIFTGEAR),getID(PBMoves,:SHOREUP),getID(PBMoves,:SHELLSMASH),getID(PBMoves,:SHIFTGEAR),getID(PBMoves,:SHOREUP),getID(PBMoves,:SLACKOFF),getID(PBMoves,:SOFTBOILED),getID(PBMoves,:SPORE),getID(PBMoves,:SUBSTITUTE),getID(PBMoves,:SWAGGER),getID(PBMoves,:SWALLOW),getID(PBMoves,:SWORDSDANCE),getID(PBMoves,:SYNTHESIS),getID(PBMoves,:TAILGLOW)]
    heal   = [getID(PBMoves,:AROMATHERAPY),getID(PBMoves,:BELLYDRUM),getID(PBMoves,:CONVERSION2),getID(PBMoves,:HAZE),getID(PBMoves,:HEALBELL),getID(PBMoves,:MIST),getID(PBMoves,:PSYCHUP),getID(PBMoves,:REFRESH),getID(PBMoves,:SPITE),getID(PBMoves,:STOCKPILE),getID(PBMoves,:TELEPORT),getID(PBMoves,:TRANSFORM)]
    heal2  = [getID(PBMoves,:MEMENTO),getID(PBMoves,:PARTINGSHOT)]
    centre = [getID(PBMoves,:DESTINYBOND),getID(PBMoves,:GRUDGE)]
    if atk1.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::ATTACK,false)
        attacker.pbIncreaseStat(PBStats::ATTACK,1,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power boosted its attack!",attacker.pbThis))
      end
    elsif atk2.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::ATTACK,false)
        attacker.pbIncreaseStat(PBStats::ATTACK,2,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power sharply boosted its attack!",attacker.pbThis))
      end
    elsif atk3.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::ATTACK,false)
        attacker.pbIncreaseStat(PBStats::ATTACK,3,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power drastically boosted its attack!",attacker.pbThis))
      end
    elsif def1.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::DEFENSE,false)
        attacker.pbIncreaseStat(PBStats::DEFENSE,1,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power boosted its defense!",attacker.pbThis))
      end
    elsif def2.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::DEFENSE,false)
        attacker.pbIncreaseStat(PBStats::DEFENSE,2,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power sharply boosted its defense!",attacker.pbThis))
      end
    elsif def3.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::DEFENSE,false)
        attacker.pbIncreaseStat(PBStats::DEFENSE,3,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power drastically boosted its defense!",attacker.pbThis))
      end
    elsif spatk1.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::SPATK,false)
        attacker.pbIncreaseStat(PBStats::SPATK,1,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power boosted its special attack!",attacker.pbThis))
      end
    elsif spatk2.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::SPATK,false)
        attacker.pbIncreaseStat(PBStats::SPATK,2,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power sharply boosted its special attack!",attacker.pbThis))
      end
    elsif spatk3.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::SPATK,false)
        attacker.pbIncreaseStat(PBStats::SPATK,3,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power drastically boosted its special attack!",attacker.pbThis))
      end
    elsif spdef1.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::SPDEF,false)
        attacker.pbIncreaseStat(PBStats::SPDEF,1,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power boosted its special defense!",attacker.pbThis))
      end
    elsif spdef2.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::SPDEF,false)
        attacker.pbIncreaseStat(PBStats::SPDEF,2,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power sharply boosted its special defense!",attacker.pbThis))
      end
    elsif spdef3.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::SPDEF,false)
        attacker.pbIncreaseStat(PBStats::SPDEF,3,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power drastically boosted its special defense!",attacker.pbThis))
      end
    elsif speed1.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::SPEED,false)
        attacker.pbIncreaseStat(PBStats::SPEED,1,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power boosted its speed!",attacker.pbThis))
      end
    elsif speed2.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::SPEED,false)
        attacker.pbIncreaseStat(PBStats::SPEED,2,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power sharply boosted its speed!",attacker.pbThis))
      end
    elsif speed3.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::SPEED,false)
        attacker.pbIncreaseStat(PBStats::SPEED,3,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power drastically boosted its speed!",attacker.pbThis))
      end
    elsif acc1.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::ACCURACY,false)
        attacker.pbIncreaseStat(PBStats::ACCURACY,1,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power boosted its accuracy!",attacker.pbThis))
      end
    elsif acc2.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::ACCURACY,false)
        attacker.pbIncreaseStat(PBStats::ACCURACY,2,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power sharply boosted its accuracy!",attacker.pbThis))
      end
    elsif acc3.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::ACCURACY,false)
        attacker.pbIncreaseStat(PBStats::ACCURACY,3,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power drastically boosted its accuracy!",attacker.pbThis))
      end
    elsif eva1.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::EVASION,false)
        attacker.pbIncreaseStat(PBStats::EVASION,1,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power boosted its evasion!",attacker.pbThis))
      end
    elsif eva2.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::EVASION,false)
        attacker.pbIncreaseStat(PBStats::EVASION,2,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power sharply boosted its evasion!",attacker.pbThis))
      end
    elsif eva3.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::EVASION,false)
        attacker.pbIncreaseStat(PBStats::EVASION,3,false,nil,nil,false,false,false)         
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power drastically boosted its evasion!",attacker.pbThis))
      end
    elsif stat1.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::ATTACK,false)
        attacker.pbIncreaseStat(PBStats::ATTACK,1,false,nil,nil,false,false,false)                 
      end
      if attacker.pbCanIncreaseStatStage?(PBStats::DEFENSE,false)
        attacker.pbIncreaseStat(PBStats::DEFENSE,1,false,nil,nil,false,false,false)                 
      end      
      if attacker.pbCanIncreaseStatStage?(PBStats::SPATK,false)
        attacker.pbIncreaseStat(PBStats::SPATK,1,false,nil,nil,false,false,false)                 
      end      
      if attacker.pbCanIncreaseStatStage?(PBStats::SPDEF,false)
        attacker.pbIncreaseStat(PBStats::SPDEF,1,false,nil,nil,false,false,false)                 
      end      
      if attacker.pbCanIncreaseStatStage?(PBStats::SPEED,false)
        attacker.pbIncreaseStat(PBStats::SPEED,1,false,nil,nil,false,false,false)                 
      end      
      @battle.pbDisplayBrief(_INTL("{1}'s Z-Power boosted its stats!",attacker.pbThis))
    elsif stat2.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::ATTACK,false)
        attacker.pbIncreaseStat(PBStats::ATTACK,2,false,nil,nil,false,false,false)                 
      end
      if attacker.pbCanIncreaseStatStage?(PBStats::DEFENSE,false)
        attacker.pbIncreaseStat(PBStats::DEFENSE,2,false,nil,nil,false,false,false)                 
      end      
      if attacker.pbCanIncreaseStatStage?(PBStats::SPATK,false)
        attacker.pbIncreaseStat(PBStats::SPATK,2,false,nil,nil,false,false,false)                 
      end      
      if attacker.pbCanIncreaseStatStage?(PBStats::SPDEF,false)
        attacker.pbIncreaseStat(PBStats::SPDEF,2,false,nil,nil,false,false,false)                 
      end      
      if attacker.pbCanIncreaseStatStage?(PBStats::SPEED,false)
        attacker.pbIncreaseStat(PBStats::SPEED,2,false,nil,nil,false,false,false)                 
      end      
      @battle.pbDisplayBrief(_INTL("{1}'s Z-Power sharply boosted its stats!",attacker.pbThis))
    elsif stat3.include?(move)
      if attacker.pbCanIncreaseStatStage?(PBStats::ATTACK,false)
        attacker.pbIncreaseStat(PBStats::ATTACK,3,false,nil,nil,false,false,false)                 
      end
      if attacker.pbCanIncreaseStatStage?(PBStats::DEFENSE,false)
        attacker.pbIncreaseStat(PBStats::DEFENSE,3,false,nil,nil,false,false,false)                 
      end      
      if attacker.pbCanIncreaseStatStage?(PBStats::SPATK,false)
        attacker.pbIncreaseStat(PBStats::SPATK,3,false,nil,nil,false,false,false)                 
      end      
      if attacker.pbCanIncreaseStatStage?(PBStats::SPDEF,false)
        attacker.pbIncreaseStat(PBStats::SPDEF,3,false,nil,nil,false,false,false)                 
      end      
      if attacker.pbCanIncreaseStatStage?(PBStats::SPEED,false)
        attacker.pbIncreaseStat(PBStats::SPEED,3,false,nil,nil,false,false,false)                 
      end      
      @battle.pbDisplayBrief(_INTL("{1}'s Z-Power drastically boosted its stats!",attacker.pbThis))
    elsif reset.include?(move)
      for i in [PBStats::ATTACK,PBStats::DEFENSE,
                PBStats::SPEED,PBStats::SPATK,PBStats::SPDEF,
                PBStats::EVASION,PBStats::ACCURACY]
        if attacker.stages[i]<0
          attacker.stages[i]=0
        end
      end
      @battle.pbDisplayBrief(_INTL("{1}'s Z-Power returned its decreased stats to normal!",attacker.pbThis))
    elsif heal.include?(move)
      attacker.pbRecoverHP(attacker.totalhp,false)
      @battle.pbDisplayBrief(_INTL("{1}'s Z-Power restored its health!",attacker.pbThis))
    elsif heal2.include?(move)
      attacker.effects[PBEffects::ZHeal]=true
    elsif centre.include?(move)
      attacker.effects[PBEffects::FollowMe]=true
      if !attacker.pbPartner.isFainted?
        attacker.pbPartner.effects[PBEffects::FollowMe]=false
        attacker.pbPartner.effects[PBEffects::RagePowder]=false  
        @battle.pbDisplayBrief(_INTL("{1}'s Z-Power made it the centre of attention!",attacker.pbThis))
      end
    end    
  end
  
end
