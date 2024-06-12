# Slightly edited copy of the battle inspect system from Rejuvenation v13.0.5 made by DemICE

class PokeBattle_Scene
  def pbCommandMenuEx(index,texts,mode=0)      # Mode: 0 - regular battle
    pbShowWindow(COMMANDBOX)                   #       1 - Shadow Pokémon battle
    cw=@sprites["commandwindow"]               #       2 - Safari Zone
    cw.setTexts(texts)                         #       3 - Bug Catching Contest
    cw.index=@lastcmd[index]
    cw.mode=mode
    pbSelectBattler(index)
    pbRefresh
    loop do
      pbGraphicsUpdate
      pbInputUpdate
      pbFrameUpdate(cw)
      # Update selected command
      if Input.trigger?(Input::LEFT) && (cw.index&1)==1
        pbPlayCursorSE()
        cw.index-=1
      elsif Input.trigger?(Input::RIGHT) &&  (cw.index&1)==0
        pbPlayCursorSE()
        cw.index+=1
      elsif Input.trigger?(Input::UP) &&  (cw.index&2)==2
        pbPlayCursorSE()
        cw.index-=2
      elsif Input.trigger?(Input::DOWN) &&  (cw.index&2)==0
        pbPlayCursorSE()
        cw.index+=2
      elsif Input.trigger?(Input::Y) #Inspect: Calling the system
        statstarget=pbStatInfo(index)
        return -1 if statstarget==-1      
        if !pbInSafari?
          pbShowBattleStats(statstarget)
        end
      end
      if Input.trigger?(Input::C)   # Confirm choice
        pbPlayDecisionSE()
        ret=cw.index
        @lastcmd[index]=ret
        return ret
      elsif Input.trigger?(Input::B) && index==2 #&& @lastcmd[0]!=2 # Cancel #Commented out for cancelling switches in doubles
        pbPlayDecisionSE()
        return -1
      end
    end 
  end

  def pbFightMenu(index)
    pbShowWindow(FIGHTBOX)
    cw = @sprites["fightwindow"]
    battler=@battle.battlers[index]
    cw.battler=battler
    lastIndex=@lastmove[index]
    if battler.moves[lastIndex].id!=0
      cw.setIndex(lastIndex)
    else
      cw.setIndex(0)
    end
    cw.megaButton=0
    cw.megaButton=1 if (@battle.pbCanMegaEvolve?(index) && !@battle.pbCanZMove?(index))
    cw.zButton=0
    cw.zButton=1 if @battle.pbCanZMove?(index)
    pbSelectBattler(index)
    pbRefresh
    loop do
      pbGraphicsUpdate
      pbInputUpdate
      pbFrameUpdate(cw)
      # Update selected command
      if Input.trigger?(Input::LEFT) && (cw.index&1)==1
        pbPlayCursorSE() if cw.setIndex(cw.index-1)
      elsif Input.trigger?(Input::RIGHT) &&  (cw.index&1)==0
        pbPlayCursorSE() if cw.setIndex(cw.index+1)
      elsif Input.trigger?(Input::UP) &&  (cw.index&2)==2
        pbPlayCursorSE() if cw.setIndex(cw.index-2)
      elsif Input.trigger?(Input::DOWN) &&  (cw.index&2)==0
        pbPlayCursorSE() if cw.setIndex(cw.index+2)
      elsif Input.trigger?(Input::Y) #Inspect: Calling the system
        statstarget=pbStatInfoF(index)
        return -1 if statstarget==-1          
        pbShowBattleStats(statstarget)
      end
      if Input.trigger?(Input::C)   # Confirm choice
        ret=cw.index
        if cw.zButton==2
          if battler.pbCompatibleZMoveFromIndex?(ret)
            pbPlayDecisionSE() 
            @lastmove[index]=ret
            return ret
          else
            @battle.pbDisplay(_INTL("{1} is not compatible with {2}!",PBMoves.getName(battler.moves[ret]),PBItems.getName(battler.item)))   
            @lastmove[index]=cw.index        
            return -1
          end
        else
          pbPlayDecisionSE() 
          @lastmove[index]=ret
          return ret
        end          
      elsif Input.trigger?(Input::X)   # Use Mega Evolution 
        if @battle.pbCanMegaEvolve?(index) && !pbIsZCrystal?(battler.item)
          @battle.pbRegisterMegaEvolution(index)
          cw.megaButton=2
          pbPlayDecisionSE()
        end
        if @battle.pbCanZMove?(index)  # Use Z Move
          @battle.pbRegisterZMove(index)
          cw.zButton=2
          pbPlayDecisionSE()
        end        
      elsif Input.trigger?(Input::B)   # Cancel fight menu
        @lastmove[index]=cw.index
        pbPlayCancelSE()
        return -1
      end
    end
  end

  #>>>>DemICE entered the chat    
  def StatInfoTarget(index)
    for i in 0...4
      if (index&1)==(i&1) && !@battle.battlers[i].isFainted? 
        return i
      end  
    end
    return -1
  end 
      
  def pbStatInfo(index)
    pbShowWindow(COMMANDBOX)
    curwindow=StatInfoTarget(index)
    if curwindow==-1
      raise RuntimeError.new(_INTL("No targets somehow..."))
    end
    loop do
      pbGraphicsUpdate
      pbInputUpdate
      pbUpdateSelected(curwindow)
      if Input.trigger?(Input::C)
        pbUpdateSelected(-1)
        statstarget=@battle.battlers[curwindow]
        return statstarget
      end
      if Input.trigger?(Input::B)
        pbUpdateSelected(-1)
        return -1
      end
      if curwindow>=0
        if Input.trigger?(Input::RIGHT)
          loop do
            newcurwindow=2 if curwindow==0
            newcurwindow=0 if curwindow==3
            newcurwindow=3 if curwindow==1
            newcurwindow=1 if curwindow==2
            curwindow=newcurwindow
            break if !@battle.battlers[curwindow].isFainted?
          end
        elsif Input.trigger?(Input::DOWN)
          loop do 
            newcurwindow=2 if curwindow==0
            newcurwindow=0 if curwindow==2
            newcurwindow=2 if curwindow==1
            newcurwindow=0 if curwindow==3
            curwindow=newcurwindow
            break if !@battle.battlers[curwindow].isFainted?
          end  
        elsif Input.trigger?(Input::LEFT)
          loop do 
            newcurwindow=3 if curwindow==0
            newcurwindow=0 if curwindow==2
            newcurwindow=2 if curwindow==1
            newcurwindow=1 if curwindow==3
            curwindow=newcurwindow
            break if !@battle.battlers[curwindow].isFainted?
          end  
        elsif Input.trigger?(Input::UP)
          loop do 
            newcurwindow=3 if curwindow==0
            newcurwindow=1 if curwindow==2
            newcurwindow=3 if curwindow==1
            newcurwindow=1 if curwindow==3
            curwindow=newcurwindow
            break if !@battle.battlers[curwindow].isFainted?                          
          end
        end
      end
    end
  end     
  
  def pbStatInfoF(index)
    pbShowWindow(FIGHTBOX)
    curwindow=StatInfoTarget(index)
    if curwindow==-1
      raise RuntimeError.new(_INTL("No targets somehow..."))
    end
    loop do
      pbGraphicsUpdate
      pbInputUpdate
      pbUpdateSelected(curwindow)
      if Input.trigger?(Input::C)
        pbUpdateSelected(-1)
        statstarget=@battle.battlers[curwindow]
        return statstarget
      end
      if Input.trigger?(Input::B)
        pbUpdateSelected(-1)
        return -1
      end
      if curwindow>=0
        if Input.trigger?(Input::RIGHT)
          loop do
            newcurwindow=2 if curwindow==0
            newcurwindow=0 if curwindow==3
            newcurwindow=3 if curwindow==1
            newcurwindow=1 if curwindow==2
            curwindow=newcurwindow
            break if !@battle.battlers[curwindow].isFainted?
          end
        elsif Input.trigger?(Input::DOWN)
          loop do 
            newcurwindow=2 if curwindow==0
            newcurwindow=0 if curwindow==2
            newcurwindow=2 if curwindow==1
            newcurwindow=0 if curwindow==3
            curwindow=newcurwindow
            break if !@battle.battlers[curwindow].isFainted?
          end  
        elsif Input.trigger?(Input::LEFT)
          loop do 
            newcurwindow=3 if curwindow==0
            newcurwindow=0 if curwindow==2
            newcurwindow=2 if curwindow==1
            newcurwindow=1 if curwindow==3
            curwindow=newcurwindow
            break if !@battle.battlers[curwindow].isFainted?
          end  
        elsif Input.trigger?(Input::UP)
          loop do 
            newcurwindow=3 if curwindow==0
            newcurwindow=1 if curwindow==2
            newcurwindow=3 if curwindow==1
            newcurwindow=1 if curwindow==3
            curwindow=newcurwindow
            break if !@battle.battlers[curwindow].isFainted?                          
          end
        end
      end
    end
  end   

  def pbShowBattleStats(pkmn)
    friend=@battle.battlers[0]
    atksbl="+"  
    atksbl=" " if pkmn.stages[PBStats::ATTACK]<0
    defsbl="+"  
    defsbl=" " if pkmn.stages[PBStats::DEFENSE]<0
    spasbl="+"
    spasbl=" " if pkmn.stages[PBStats::SPATK]<0
    spdsbl="+"
    spdsbl=" " if pkmn.stages[PBStats::SPDEF]<0
    spesbl="+"
    spesbl=" " if pkmn.stages[PBStats::SPEED]<0
    accsbl="+"
    accsbl=" " if pkmn.stages[PBStats::ACCURACY]<0
    evasbl="+"
    evasbl=" " if pkmn.stages[PBStats::EVASION]<0
    c=pkmn.pbCalcCrit()
    if c==0
      crit=4
    elsif c==1
      crit=25
    elsif c==2
      crit=50
    else 
      crit=100
    end  
    if (pkmn.type1 != pkmn.type2)  
      report = [_INTL("Type: {1}/{2}",PBTypes.getName(pkmn.type1),PBTypes.getName(pkmn.type2))]  
    else  
      report = [_INTL("Type: {1}",PBTypes.getName(pkmn.type1))]  
    end
    report.push(_INTL("Level: {1}",pkmn.level))
   # {1} {2} {3} {4}",pkmn.moves[0],pkmn.moves[1],pkmn.moves[2],pkmn.moves[3])"
   #if @battle.revealedMoves[0][pkmn.pokemonIndex].include?(pkmn.moves[0])
    report.push(_INTL("Attack:        {1}   {2}{3}",pkmn.pbCalcAttack(),atksbl,pkmn.stages[PBStats::ATTACK]),
                _INTL("Defense:      {1}   {2}{3}",pkmn.pbCalcDefense(),defsbl,pkmn.stages[PBStats::DEFENSE]),
                _INTL("Sp.Attack:   {1}   {2}{3}",pkmn.pbCalcSpAtk(),spasbl,pkmn.stages[PBStats::SPATK]),
                _INTL("Sp.Defense: {1}   {2}{3}",pkmn.pbCalcSpDef(),spdsbl,pkmn.stages[PBStats::SPDEF]),
                _INTL("Speed:         {1}   {2}{3}",pkmn.pbSpeed(),spesbl,pkmn.stages[PBStats::SPEED]),
                _INTL("Accuracy:   {1}% {2}{3}",pkmn.pbCalcAcc(),accsbl,pkmn.stages[PBStats::ACCURACY]),
                _INTL("Evasion:       {1}% {2}{3}",pkmn.pbCalcEva(),evasbl,pkmn.stages[PBStats::EVASION]),
                _INTL("Crit. Rate:    {1}%    +{2}/3",crit,c))
    if (pkmn == @battle.battlers[1] || pkmn == @battle.battlers[3])
      if @battle.revealedMoves[0][pkmn.pokemonIndex].length!=0
      report.push(_INTL("Revealed Moves:"))
        for i in @battle.revealedMoves[0][pkmn.pokemonIndex]
          if i.id==pkmn.moves[0].id
            report.push(_INTL("{1}:  {2} PP left",pkmn.moves[0].name,pkmn.moves[0].pp))
          end
          if i.id==pkmn.moves[1].id
            report.push(_INTL("{1}:  {2} PP left",pkmn.moves[1].name,pkmn.moves[1].pp))
          end
          if i.id==pkmn.moves[2].id
            report.push(_INTL("{1}:  {2} PP left",pkmn.moves[2].name,pkmn.moves[2].pp))
          end
          if i.id==pkmn.moves[3].id
            report.push(_INTL("{1}:  {2} PP left",pkmn.moves[3].name,pkmn.moves[3].pp))
          end
        end
      end
    end
    dur=@battle.weatherduration
    dur="Permanent" if @battle.weatherduration<0
    turns="turns"
    turns="" if @battle.weatherduration<0
    if @battle.weather==PBWeather::RAINDANCE
      weatherreport=_INTL("Weather: Rain, {1} {2}",dur,turns)
      weatherreport=_INTL("Weather: Torrential Rain, {1} {2}",dur,turns) if @battle.field.effects[PBEffects::HeavyRain]
    elsif @battle.weather==PBWeather::SUNNYDAY
      weatherreport=_INTL("Weather: Sun, {1} {2}",dur,turns)
      weatherreport=_INTL("Weather: Scorching Sun, {1} {2}",dur,turns) if @battle.field.effects[PBEffects::HarshSunlight]
    elsif @battle.weather==PBWeather::SANDSTORM
      weatherreport=_INTL("Weather: Sandstorm, {1} {2}",dur,turns)
    elsif @battle.weather==PBWeather::HAIL
      weatherreport=_INTL("Weather: Hail, {1} {2}",dur,turns)
    elsif @battle.weather==PBWeather::STRONGWINDS
      weatherreport=_INTL("Weather: Strong Winds, {1} {2}",dur,turns)
    elsif @battle.weather==PBWeather::SHADOWSKY
      weatherreport=_INTL("Weather: Shadow Sky, {1} {2}",dur,turns)
    end
    report.push(weatherreport) if @battle.weather!=0
    report.push(_INTL("Slow Start: {1} turns",(5-pkmn.turncount))) if pkmn.hasWorkingAbility(:SLOWSTART) && pkmn.turncount<=5 && (pkmn == @battle.battlers[0] || pkmn == @battle.battlers[2])
    report.push(_INTL("Throat Chop: {1} turns",pkmn.effects[PBEffects::ThroatChop])) if pkmn.effects[PBEffects::ThroatChop]!=0
    report.push(_INTL("Unburdened")) if pkmn.unburdened && (pkmn == @battle.battlers[0] || pkmn == @battle.battlers[2]) && pkmn.hasWorkingAbility(:UNBURDEN)
    report.push(_INTL("Speed Swap")) if pkmn.effects[PBEffects::SpeedSwap]!=0
    report.push(_INTL("Burn Up")) if pkmn.effects[PBEffects::BurnUp]
    report.push(_INTL("Uproar: {1} turns",pkmn.effects[PBEffects::Uproar])) if pkmn.effects[PBEffects::Uproar]!=0
    report.push(_INTL("Truant")) if pkmn.effects[PBEffects::Truant] && (pkmn == @battle.battlers[0] || pkmn == @battle.battlers[2]) && pkmn.hasWorkingAbility(:TRUANT)
    report.push(_INTL("Toxic: {1} turns",pkmn.effects[PBEffects::Toxic])) if pkmn.effects[PBEffects::Toxic]!=0
    report.push(_INTL("Torment")) if pkmn.effects[PBEffects::Torment]
    report.push(_INTL("Miracle Eye")) if pkmn.effects[PBEffects::MiracleEye]
    report.push(_INTL("Minimized")) if pkmn.effects[PBEffects::Minimize]
    report.push(_INTL("Recharging")) if pkmn.effects[PBEffects::HyperBeam]!=0
    report.push(_INTL("Fury Cutter: +{1}",pkmn.effects[PBEffects::FuryCutter])) if pkmn.effects[PBEffects::FuryCutter]!=0
    report.push(_INTL("Echoed Voice: +{1}",pkmn.effects[PBEffects::EchoedVoice])) if pkmn.effects[PBEffects::EchoedVoice]!=0
    report.push(_INTL("Mean Look")) if pkmn.effects[PBEffects::MeanLook]>-1
    report.push(_INTL("Foresight")) if pkmn.effects[PBEffects::Foresight]
    report.push(_INTL("Follow Me")) if pkmn.effects[PBEffects::FollowMe]
    report.push(_INTL("Rage Powder")) if pkmn.effects[PBEffects::RagePowder]
    report.push(_INTL("Flash Fire")) if pkmn.effects[PBEffects::FlashFire]
    report.push(_INTL("Substitute")) if pkmn.effects[PBEffects::Substitute]!=0
    report.push(_INTL("Perish Song: {1} turns",pkmn.effects[PBEffects::PerishSong])) if pkmn.effects[PBEffects::PerishSong]>0
    report.push(_INTL("Leech Seed")) if pkmn.effects[PBEffects::LeechSeed]>-1
    report.push(_INTL("Gastro Acid")) if pkmn.effects[PBEffects::GastroAcid]
    report.push(_INTL("Curse")) if pkmn.effects[PBEffects::Curse]
    report.push(_INTL("Nightmare")) if pkmn.effects[PBEffects::Nightmare]
    report.push(_INTL("Confused")) if pkmn.effects[PBEffects::Confusion]!=0
    report.push(_INTL("Aqua Ring")) if pkmn.effects[PBEffects::AquaRing]
    report.push(_INTL("Ingrain")) if pkmn.effects[PBEffects::Ingrain]
    report.push(_INTL("Power Trick")) if pkmn.effects[PBEffects::PowerTrick]
    report.push(_INTL("Smacked Down")) if pkmn.effects[PBEffects::SmackDown]
    report.push(_INTL("Air Balloon")) if pkmn.hasWorkingItem(:AIRBALLOON)
    report.push(_INTL("Magnet Rise: {1} turns",pkmn.effects[PBEffects::MagnetRise])) if pkmn.effects[PBEffects::MagnetRise]!=0
    report.push(_INTL("Telekinesis: {1} turns",pkmn.effects[PBEffects::Telekinesis])) if pkmn.effects[PBEffects::Telekinesis]!=0
    report.push(_INTL("Heal Block: {1} turns",pkmn.effects[PBEffects::HealBlock])) if pkmn.effects[PBEffects::HealBlock]!=0
    report.push(_INTL("Embargo: {1} turns",pkmn.effects[PBEffects::Embargo])) if pkmn.effects[PBEffects::Embargo]!=0
    report.push(_INTL("Disable: {1} turns",pkmn.effects[PBEffects::Disable])) if pkmn.effects[PBEffects::Disable]!=0
    report.push(_INTL("Encore: {1} turns",pkmn.effects[PBEffects::Encore])) if pkmn.effects[PBEffects::Encore]!=0
    report.push(_INTL("Taunt: {1} turns",pkmn.effects[PBEffects::Taunt])) if pkmn.effects[PBEffects::Taunt]!=0
    report.push(_INTL("Infatuated with {1}",@battle.battlers[pkmn.effects[PBEffects::Attract]].name)) if pkmn.effects[PBEffects::Attract]>=0
    report.push(_INTL("Trick Room: {1} turns",@battle.trickroom)) if @battle.trickroom!=0
    report.push(_INTL("Gravity: {1} turns",@battle.field.effects[PBEffects::Gravity])) if @battle.field.effects[PBEffects::Gravity]>0  
    report.push(_INTL("Tailwind: {1} turns",pkmn.pbOwnSide.effects[PBEffects::Tailwind])) if pkmn.pbOwnSide.effects[PBEffects::Tailwind]>0   
    report.push(_INTL("Reflect: {1} turns",pkmn.pbOwnSide.effects[PBEffects::Reflect])) if pkmn.pbOwnSide.effects[PBEffects::Reflect]>0
    report.push(_INTL("Light Screen: {1} turns",pkmn.pbOwnSide.effects[PBEffects::LightScreen])) if pkmn.pbOwnSide.effects[PBEffects::LightScreen]>0
    report.push(_INTL("Aurora Veil: {1} turns",pkmn.pbOwnSide.effects[PBEffects::AuroraVeil])) if pkmn.pbOwnSide.effects[PBEffects::AuroraVeil]>0
    report.push(_INTL("Safeguard: {1} turns",pkmn.pbOwnSide.effects[PBEffects::Safeguard])) if pkmn.pbOwnSide.effects[PBEffects::Safeguard]>0
    report.push(_INTL("Lucky Chant: {1} turns",pkmn.pbOwnSide.effects[PBEffects::LuckyChant])) if pkmn.pbOwnSide.effects[PBEffects::LuckyChant]>0
    report.push(_INTL("Mist: {1} turns",pkmn.pbOwnSide.effects[PBEffects::Mist])) if pkmn.pbOwnSide.effects[PBEffects::Mist]>0 
    report.push(_INTL("Altered Field: {1} turns",@battle.field.effects[PBEffects::Terrain])) if @battle.field.effects[PBEffects::Terrain]>0
    #report.push(_INTL("Messed up Field: {1} turns",@battle.field.effects[PBEffects::Splintered])) if @battle.field.effects[PBEffects::Splintered]>0  
    #report.push(_INTL("Electric Terrain: {1} turns",@battle.field.effects[PBEffects::ElectricTerrain])) if @battle.field.effects[PBEffects::ElectricTerrain]>0  
    #report.push(_INTL("Grassy Terrain: {1} turns",@battle.field.effects[PBEffects::GrassyTerrain])) if @battle.field.effects[PBEffects::GrassyTerrain]>0
    #report.push(_INTL("Misty Terrain: {1} turns",@battle.field.effects[PBEffects::MistyTerrain])) if @battle.field.effects[PBEffects::MistyTerrain]>0
    #report.push(_INTL("Psychic Terrain: {1} turns",@battle.field.effects[PBEffects::PsychicTerrain])) if @battle.field.effects[PBEffects::PsychicTerrain]>0
    #report.push(_INTL("Rainbow: {1} turns",@battle.field.effects[PBEffects::Rainbow])) if @battle.field.effects[PBEffects::Rainbow]>0
    report.push(_INTL("Magic Room: {1} turns",@battle.field.effects[PBEffects::MagicRoom])) if @battle.field.effects[PBEffects::MagicRoom]>0
    report.push(_INTL("Wonder Room: {1} turns",@battle.field.effects[PBEffects::WonderRoom])) if @battle.field.effects[PBEffects::WonderRoom]>0
    report.push(_INTL("Water Sport: {1} turns",@battle.field.effects[PBEffects::WaterSport])) if @battle.field.effects[PBEffects::WaterSport]>0
    report.push(_INTL("Mud Sport: {1} turns",@battle.field.effects[PBEffects::MudSport])) if @battle.field.effects[PBEffects::MudSport]>0
    report.push(_INTL("Spikes: {1} layers",pkmn.pbOwnSide.effects[PBEffects::Spikes])) if pkmn.pbOwnSide.effects[PBEffects::Spikes]>0
    report.push(_INTL("Toxic Spikes: {1} layers",pkmn.pbOwnSide.effects[PBEffects::ToxicSpikes])) if pkmn.pbOwnSide.effects[PBEffects::ToxicSpikes]>0
    report.push(_INTL("Stealth Rock active")) if pkmn.pbOwnSide.effects[PBEffects::StealthRock]
    report.push(_INTL("Sticky Web active")) if pkmn.pbOwnSide.effects[PBEffects::StickyWeb]
    report.push()
    report.push(_INTL("Wonder Room Stat Swap active")) if pkmn.wonderroom==true
    fieldnames = ["No Field", "Electric Terrain", "Grassy Terrain", "Misty Terrain", "Dark Crystal Cavern",
                  "Chess Board", "Big Top Arena", "Volcanic Field", "Swamp Field", "Rainbow Field",
                  "Corrosive Field", "Corrosive Mist Field", "Desert Field", "Icy Field", "Rocky Field",
                  "Forest Field", "Volcanic Top Field", "Factory Field", "Short-circuit Field", "Wasteland",
                  "Ashen Beach", "Water Surface", "Underwater", "Cave", "Glitch Field",
                  "Crystal Cavern", "Murkwater Surface", "Mountain", "Snowy Mountain", "Holy Field",
                  "Mirror Arena", "Fairy Tale Field", "Dragon's Den", "Flower Garden Field", "Starlight Arena",
                  "New World", "Inverse Field", "Psychic Terrain", "Dimensional Field", "Frozen Dimensional Field",
                  "Haunted Field", "Corrupted Cave", "Bewitched Woods", "Sky Field"]
    report.push(_INTL("Field effect: {1}", fieldnames[$fefieldeffect]))
    party=@battle.pbParty(pkmn.index)
    participants=0
    for i in 0...party.length
      participants+=1 if party[i] && !party[i].isEgg? &&
      party[i].hp>0 && party[i].status==0 && !party[i].nil?
    end
    report.push(_INTL("Remaining Pokemon: {1} ",(participants)))
    Kernel.pbMessage((_INTL"Inspecting {1}:",pkmn.name),report, report.length)
  end
  #DemICE left the chat>>>>    
end

class PokeBattle_Battler
  #>>>>DemICE entered the chat
  def pbCalcCrit()  
    #### KUROTSUNE - 029 - END      
    $buffs = 0
    if $fefieldeffect == 30 # Mirror Arena
      $buffs = self.stages[PBStats::EVASION] if self.stages[PBStats::EVASION] > 0
      $buffs = $buffs.to_i + self.stages[PBStats::ACCURACY] if self.stages[PBStats::ACCURACY] > 0
    end   
    c=0
    c+=self.effects[PBEffects::FocusEnergy]
    c+=1 if self.hasWorkingAbility(:SUPERLUCK) || self.hasWorkingAbility(:LONGREACH)
    if self.hasWorkingItem(:STICK) && isConst?(self.species,PBSpecies,:FARFETCHD)
      c+=2
    end
    if self.hasWorkingItem(:LUCKYPUNCH) && isConst?(self.species,PBSpecies,:CHANSEY)
      c+=2
    end
    c+=1 if self.hasWorkingItem(:RAZORCLAW)
    c+=1 if self.hasWorkingItem(:SCOPELENS)
    if $fefieldeffect == 30 # Mirror Arena
      c += $buffs
    end
    c=3 if c>3
    return c
  end

  def pbCalcAttack()
    stagemul=[2,2,2,2,2,2,2,3,4,5,6,7,8]
    stagediv=[8,7,6,5,4,3,2,2,2,2,2,2,2]    
    atk=@attack
    atkstage=@stages[PBStats::ATTACK]+6
    if @effects[PBEffects::PowerTrick]
      atk=@defense
      atkstage=@stages[PBStats::DEFENSE]+6
    end    
    if @stages[PBStats::ATTACK] >= 0
      stagemulp=1+0.5*@stages[PBStats::ATTACK]
      atk=(atk*1.0*stagemulp).floor  
    else        
      atk=(atk*1.0*stagemul[atkstage]/stagediv[atkstage]).floor
    end  
    if self.hasWorkingAbility(:HUSTLE)
      atk=(atk*1.5).round
    end
    if self.hasWorkingItem(:LIGHTBALL) && isConst?(self.species,PBSpecies,:PIKACHU)
      atk=self.pbSpeed
    end
    atkmult=0x1000           
    if self.hasWorkingAbility(:GUTS) &&
      self.status!=0 
      atkmult=(atkmult*1.5).round
    end   
    if self.hasWorkingAbility(:DEFEATIST) &&
      self.hp<=(self.totalhp/2).floor
      atkmult=(atkmult*0.5).round
    end
    if ((self.hasWorkingAbility(:PUREPOWER) && $fefieldeffect!=37) || #Psychic Terrain
        self.hasWorkingAbility(:HUGEPOWER))
      atkmult=(atkmult*2.0).round
    end  
    if self.hasWorkingAbility(:SLOWSTART) &&
      self.turncount<5 
      atkmult=(atkmult*0.5).round
    end
    if (@battle.pbWeather==PBWeather::SUNNYDAY || $fefieldeffect == 33 || $fefieldeffect == 42) # Flower Garden Field || Bewitched Woods
      if self.hasWorkingAbility(:FLOWERGIFT) && isConst?(self.species,PBSpecies,:CHERRIM)
        atkmult=(atkmult*1.5).round
      end
      if self.pbPartner.hasWorkingAbility(:FLOWERGIFT) && isConst?(self.pbPartner.species,PBSpecies,:CHERRIM)
        atkmult=(atkmult*1.5).round
      end
    end
    if self.hasWorkingItem(:THICKCLUB) &&
      (isConst?(self.species,PBSpecies,:CUBONE) || isConst?(self.species,PBSpecies,:MAROWAK))
      atkmult=(atkmult*2.0).round
    end
    if self.hasWorkingItem(:LIGHTBALL) && isConst?(self.species,PBSpecies,:PIKACHU)
      atkmult=(atkmult*2.0).round
    end
    if self.hasWorkingItem(:CHOICEBAND)
      atkmult=(atkmult*1.5).round
    end 
    if self.hasWorkingAbility(:QUEENLYMAJESTY) && ($fefieldeffect==31) # Chess Board (REMOVED) || Fairy Tale Field
      atkmult=(atkmult*1.5).round
    end 
    if self.hasWorkingAbility(:LONGREACH) &&
      ($fefieldeffect==27 || $fefieldeffect==28) # Mountain || Snowy Mountain
      atkmult=(atkmult*1.5).round
    end     
    if self.hasWorkingAbility(:CORROSION) &&
      ($fefieldeffect==10 || $fefieldeffect==11 ||  $fefieldeffect==41) # Corrosive Field || Corrosive Mist Field || Corrupted Cave
      atkmult=(atkmult*1.5).round
    end     
    atk=(atk*atkmult*1.0/0x1000).round
    return atk
  end
  
  def pbCalcDefense()
    stagemul=[2,2,2,2,2,2,2,3,4,5,6,7,8]
    stagediv=[8,7,6,5,4,3,2,2,2,2,2,2,2]      
    defense=@defense
    defstage=@stages[PBStats::DEFENSE]+6
    if @effects[PBEffects::PowerTrick]
      defense=@attack
      defstage=@stages[PBStats::DEFENSE]+6
    end       
    # TODO: Wonder Room should apply around here
    if @stages[PBStats::DEFENSE] >= 0
      stagemulp=1+0.5*@stages[PBStats::DEFENSE]
      defense=(defense*1.0*stagemulp).floor
    else        
      defense=(defense*1.0*stagemul[defstage]/stagediv[defstage]).floor
    end  
    defmult=0x1000  
    if $fefieldeffect == 24 && @function==0xE0 # Glitch Field
      defmult=(defmult*0.5).round
    end      
    if self.hasWorkingAbility(:MARVELSCALE) && 
      (self.status>0 || $fefieldeffect == 3 || $fefieldeffect == 9 || # Misty Terrain || Rainbow Field
        $fefieldeffect == 31 || $fefieldeffect == 32 || $fefieldeffect == 34) # Fairy Tale Field || Dragon's Den || Starlight Arena
      defmult=(defmult*1.5).round
    end
    if isConst?(self.ability,PBAbilities,:GRASSPELT) && 
      ($fefieldeffect == 2 || $fefieldeffect == 15) # Grassy Field || Forest Field
      defmult=(defmult*1.5).round
    end
    #### AME - 005 - START
    if self.hasWorkingAbility(:FURCOAT)
      defmult=(defmult*1.5).round
    end
    if self.hasWorkingItem(:EVIOLITE)
      evos=pbGetEvolvedFormData(self.species)
      if evos && evos.length>0
        defmult=(defmult*1.5).round
      end
    end
    if self.hasWorkingItem(:METALPOWDER) &&
      isConst?(self.species,PBSpecies,:DITTO) &&
      !self.effects[PBEffects::Transform]
      defmult=(defmult*2.0).round
    end
    if (self.hasWorkingAbility(:PRISMARMOR) || 
        self.hasWorkingAbility(:SHADOWSHIELD)) && $fefieldeffect==4 # Dark Crystal Cavern
      defmult=(defmult*2.0).round
    end    
    if self.hasWorkingAbility(:PRISMARMOR) && ($fefieldeffect==9 || $fefieldeffect==25) # Rainbow Field || Crystal Cavern
      defmult=(defmult*2.0).round
    end   
    if self.hasWorkingAbility(:SHADOWSHIELD) && ($fefieldeffect==34 || $fefieldeffect==35) # Starlight Arena || New World
      defmult=(defmult*2.0).round
    end        
    defense=(defense*defmult*1.0/0x1000).round    
    return defense
  end 
  
  def pbCalcSpAtk()
    stagemul=[2,2,2,2,2,2,2,3,4,5,6,7,8]
    stagediv=[8,7,6,5,4,3,2,2,2,2,2,2,2]    
    atk=@spatk
    atkstage=@stages[PBStats::SPATK]+6
    if @stages[PBStats::SPATK] >= 0
      stagemulp=1+0.5*@stages[PBStats::SPATK]
      atk=(atk*1.0*stagemulp).floor  
    else        
      atk=(atk*1.0*stagemul[atkstage]/stagediv[atkstage]).floor
    end  
    atkmult=0x1000
    if (self.hasWorkingAbility(:PLUS) || self.hasWorkingAbility(:MINUS))
      partner=self.pbPartner
      if partner.hasWorkingAbility(:PLUS) || partner.hasWorkingAbility(:MINUS) 
        atkmult=(atkmult*1.5).round
      elsif $fefieldeffect == 18 # Short-circuit Field
        atkmult=(atkmult*1.5).round
      end
    end
    if (self.pbPartner).hasWorkingAbility(:BATTERY)
      atkmult=(atkmult*1.3).round
    end    
    if self.hasWorkingAbility(:DEFEATIST) &&
      self.hp<=(self.totalhp/2).floor
      atkmult=(atkmult*0.5).round
    end
    if self.hasWorkingAbility(:PUREPOWER) && $fefieldeffect==37 # Psychic Terrain
      atkmult=(atkmult*2.0).round
    end    
    if self.hasWorkingAbility(:SOLARPOWER) &&
      @battle.pbWeather==PBWeather::SUNNYDAY
      atkmult=(atkmult*1.5).round
    end
    if self.hasWorkingItem(:DEEPSEATOOTH) &&
      isConst?(self.species,PBSpecies,:CLAMPERL)
      atkmult=(atkmult*2.0).round
    end
    if self.hasWorkingItem(:LIGHTBALL) &&
      isConst?(self.species,PBSpecies,:PIKACHU)
      atkmult=(atkmult*2.0).round
    end
    if self.hasWorkingItem(:CHOICESPECS)
      atkmult=(atkmult*1.5).round
    end
    if $fefieldeffect == 34 || $fefieldeffect == 35 # Starlight Arena || New World
      if self.hasWorkingAbility(:VICTORYSTAR)
        atkmult=(atkmult*1.5).round
      end
      partner=self.pbPartner
      if partner && partner.hasWorkingAbility(:VICTORYSTAR)
        atkmult=(atkmult*1.5).round
      end
    end
    if self.hasWorkingAbility(:QUEENLYMAJESTY) &&
      ($fefieldeffect==5 || $fefieldeffect==31) # Chess Board || Fairy Tale Field
      atkmult=(atkmult*1.5).round
    end 
    if self.hasWorkingAbility(:LONGREACH) &&
      ($fefieldeffect==27 || $fefieldeffect==28) # Mountain || Snowy Mountain
      atkmult=(atkmult*1.5).round
    end     
    if self.hasWorkingAbility(:CORROSION) &&
      ($fefieldeffect==10 || $fefieldeffect==11) # Corrosive Field || Corrosive Mist Field
      atkmult=(atkmult*1.5).round
    end  
    atk=(atk*atkmult*1.0/0x1000).round
    return atk
  end  
  
  def pbCalcSpDef()
    stagemul=[2,2,2,2,2,2,2,3,4,5,6,7,8]
    stagediv=[8,7,6,5,4,3,2,2,2,2,2,2,2]    
    applysandstorm=false
    defense=@spdef
    defstage=@stages[PBStats::SPDEF]+6
    applysandstorm=true
    if !self.hasWorkingAbility(:UNAWARE)
      if @stages[PBStats::SPDEF] >= 0
        stagemulp=1+0.5*@stages[PBStats::SPDEF]
        defense=(defense*1.0*stagemulp).floor
      else        
        defense=(defense*1.0*stagemul[defstage]/stagediv[defstage]).floor
      end  
    end    
    if @battle.pbWeather==PBWeather::SANDSTORM &&
      self.pbHasType?(:ROCK) && applysandstorm
      defense=(defense*1.5).round
    end
    defmult=0x1000
    if $fefieldeffect == 24 && @function==0xE0 # Glitch Field
      defmult=(defmult*0.5).round
    end
    if $fefieldeffect == 3 && self.pbHasType?(:FAIRY) # Misty Terrain    
      defmult=(defmult*1.5).round
    end
    if $fefieldeffect == 12 && self.pbHasType?(:GROUND) # Desert Field    
      defmult=(defmult*1.5).round
    end
    #if $fefieldeffect == 32 && self.pbHasType?(:DRAGON) # Snowy Mountain 
    #  defmult=(defmult*1.5).round
    #end
    if $fefieldeffect == 22 && !isConst?(type,PBTypes,:WATER) # Underwater
      defmult=(defmult*0.5).round
    end
    #### AME - 005 - END
    if (@battle.pbWeather==PBWeather::SUNNYDAY || $fefieldeffect == 33 || $fefieldeffect == 42) # Flower Garden Field || Bewitched Woods
      if self.hasWorkingAbility(:FLOWERGIFT) &&
        isConst?(self.species,PBSpecies,:CHERRIM)
        defmult=(defmult*1.5).round
      end
      if self.pbPartner.hasWorkingAbility(:FLOWERGIFT)  &&
        isConst?(self.pbPartner.species,PBSpecies,:CHERRIM)
        defmult=(defmult*1.5).round
      end
    end
    if self.hasWorkingItem(:EVIOLITE)
      evos=pbGetEvolvedFormData(self.species)
      if evos && evos.length>0
        defmult=(defmult*1.5).round
      end
    end
    if self.hasWorkingItem(:ASSAULTVEST)
      defmult=(defmult*1.5).round
    end
    if self.hasWorkingItem(:DEEPSEASCALE) && isConst?(self.species,PBSpecies,:CLAMPERL)
      defmult=(defmult*2.0).round
    end  
    if self.hasWorkingItem(:METALPOWDER) &&
      isConst?(self.species,PBSpecies,:DITTO) &&
      !self.effects[PBEffects::Transform]
      defmult=(defmult*2.0).round
    end
    if (self.hasWorkingAbility(:PRISMARMOR) || 
        self.hasWorkingAbility(:SHADOWSHIELD)) && $fefieldeffect==4 # Dark Crystal Cavern
      defmult=(defmult*2.0).round
    end    
    if self.hasWorkingAbility(:PRISMARMOR) && ($fefieldeffect==9 || $fefieldeffect==25) # Chess Board || Crystal Cavern
      defmult=(defmult*2.0).round
    end   
    if self.hasWorkingAbility(:SHADOWSHIELD) && ($fefieldeffect==34 || $fefieldeffect==35) # Starlight Arena || New World
      defmult=(defmult*2.0).round
    end        
    defense=(defense*defmult*1.0/0x1000).round
    return defense
  end  
   
  def pbCalcAcc()
    accstage=self.stages[PBStats::ACCURACY]
    accuracy=(accstage>=0) ? (accstage+3)*100/3 : 300/(3-accstage)
    if self.hasWorkingAbility(:COMPOUNDEYES)
      accuracy*=1.3
    end
    if self.hasWorkingAbility(:VICTORYSTAR)
      accuracy*=1.1
    end
    partner=self.pbPartner
    if partner && partner.hasWorkingAbility(:VICTORYSTAR)
      accuracy*=1.1
    end
    if self.hasWorkingItem(:WIDELENS)
      accuracy*=1.1
    end
    if self.hasWorkingAbility(:LONGREACH) && $fefieldeffect==15 # Forest Field
      accuracy*=0.9
    end 
    return accuracy
  end  
  
  def pbCalcEva()
    evastage=self.stages[PBStats::EVASION] 
    evastage-=2 if @battle.field.effects[PBEffects::Gravity]>0
    evastage=-6 if evastage<-6
    evastage=6 if evastage>6  #>>DemICE
    evastage=0 if self.effects[PBEffects::Foresight] ||
    self.effects[PBEffects::MiracleEye]
    evasion=(evastage>=0) ? (evastage+3)*100/3 : 300/(3-evastage)
    if self.hasWorkingAbility(:TANGLEDFEET) &&
      self.effects[PBEffects::Confusion]>0
      evasion*=1.2
    end
    if self.hasWorkingAbility(:SANDVEIL) &&
      (@battle.pbWeather==PBWeather::SANDSTORM ||
        $fefieldeffect == 12 || $fefieldeffect == 20) # Desert Field || Ashen Beach
      evasion*=1.2
    end
    if self.hasWorkingAbility(:SNOWCLOAK) &&
      (@battle.pbWeather==PBWeather::HAIL || $fefieldeffect == 13 || # Icy Field
        $fefieldeffect == 28) # Snowy Mountain
      evasion*=1.2
    end
    if self.hasWorkingItem(:BRIGHTPOWDER)
      evasion*=1.1
    end
    if self.hasWorkingItem(:LAXINCENSE)
      evasion*=1.1
    end    
    return evasion
  end  
  #DemICE left the chat>>>>

  # For registering revealed moves
  def pbProcessTurn(choice)
    # Can't use a move if fainted
    return if self.isFainted?
    # Wild roaming Pokémon always flee if possible
    if !@battle.opponent && @battle.pbIsOpposing?(self.index) &&
       @battle.rules["alwaysflee"] && @battle.pbCanRun?(self.index)
      pbBeginTurn(choice)
      @battle.pbDisplay(_INTL("{1} fled!",self.pbThis))
      @battle.decision=3
      pbEndTurn(choice)
      return
    end
    # If this battler's action for this round wasn't "use a move"
    if choice[0]!=1
      # Clean up effects that end at battler's turn
      pbBeginTurn(choice)
      pbEndTurn(choice)
      return
    end
    # Turn is skipped if Pursuit was used during switch
    if @effects[PBEffects::Pursuit]
      @effects[PBEffects::Pursuit]=false
      pbCancelMoves
      pbEndTurn(choice)
      @battle.pbJudgeSwitch
      return
    end
    # Use the move
    if choice[2].zmove && !@effects[PBEffects::Flinch] && @status!=PBStatuses::SLEEP && @status!=PBStatuses::FROZEN
      choice[2].zmove=false
      @battle.pbUseZMove(self.index,choice[2],self.item)
    else
      choice[2].zmove=false if choice[2].zmove # For flinches
#    @battle.pbDisplayPaused("Before: [#{@lastMoveUsedSketch},#{@lastMoveUsed}]")
      @battle.previousMove = @battle.lastMoveUsed
      @previousMove = @lastMoveUsed
      PBDebug.logonerr{
         pbUseMove(choice,choice[2]==@battle.struggle)
      }

      # Saving Revealed Moves
      if !(@battle.pbOwnedByPlayer?(self.index))
        if @battle.revealedMoves[0][self.pokemonIndex].length==0 
          @battle.revealedMoves[0][self.pokemonIndex].push(choice[2])       
        else
          dupecheck=0
          for i in @battle.revealedMoves[0][self.pokemonIndex]
            dupecheck+=1 if i.id == choice[2].id
          end
          @battle.revealedMoves[0][self.pokemonIndex].push(choice[2]) if dupecheck==0
        end    
      end
    end    
#   @battle.pbDisplayPaused("After: [#{@lastMoveUsedSketch},#{@lastMoveUsed}]")
  end
end

class PokeBattle_Battle
  attr_accessor(:revealedMoves) # moves revealed by enemy pokemon
  
  alias_method :battleInitalizeOld, :initialize
  def initialize(scene,p1,p2,player,opponent)
    @revealedMoves   = [[[],[],[],[],[],[],[],[],[],[],[],[]]]
    battleInitalizeOld(scene,p1,p2,player,opponent)
  end
end