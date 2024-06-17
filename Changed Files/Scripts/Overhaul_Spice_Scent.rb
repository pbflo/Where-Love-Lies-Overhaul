# Constants
Switches = {
    :FirstUse => 129
}

Variables = {
    :EncounterRateModifier => 51
}

# Option
module MenuHandlers
    def self.insertEntry(ref,positionKey,name,icon,proc,conditional,proximity=:after)
        @@menuEntry[ref] = [name,icon,proc]
        @@available[ref] = conditional

        position = @@indexes[positionKey]
        pos = nil
        pos = position if position.is_a?(Integer)
        pos = position.to_i() if position.respond_to?("to_i")
        pos += (proximity == :before ? 0 : 1)
        if pos != nil
            @@indexes.each do |key, value|
                val = nil
                val = value if value.is_a?(Integer)
                val = value.to_i() if value.respond_to?("to_i")
                if val != nil && val >= pos
                    @@indexes[key] = val + 1
                end
            end
		    @@indexes[ref] = pos
        end
		
        @@index += 1
    end
end

MenuHandlers.insertEntry(:SPICESCENT,:QUIT,_INTL("Spice Scent"),"menuSpiceScent",proc{|menu|
  pbFadeOutIn(99999) { 
    pbLoadRpgxpScene(Scene_EncounterRate.new)
  }   
},proc{ return true })

# Scene
# ToFix: Flickering (load/unload)
def Kernel.pbMessageChooseNumberCentered(params,&block)
    return Kernel.pbChooseNumberCentered(params,&block)
end

def pbChooseNumberCentered(params)
    return 0 if !params
    ret=0
    maximum=params.maxNumber
    minimum=params.minNumber
    defaultNumber=params.initialNumber
    cancelNumber=params.cancelNumber
    cmdwindow=Window_InputNumberPokemon.new(params.maxDigits)
    cmdwindow.x=Graphics.width/2-68
    cmdwindow.y =Graphics.height/2-36
    cmdwindow.z=99999
    cmdwindow.visible=true
    cmdwindow.sign=params.negativesAllowed # must be set before number
    cmdwindow.number=defaultNumber
    curnumber=defaultNumber
    command=0
    loop do
      Graphics.update
      Input.update
      pbUpdateSceneMap
      cmdwindow.update
      yield if block_given?
      if Input.trigger?(Input::C)
        ret=cmdwindow.number
        if ret>maximum
          pbPlayBuzzerSE()
        elsif ret<minimum
          pbPlayBuzzerSE()
        else
          pbPlayDecisionSE()
          break
        end
      elsif Input.trigger?(Input::B)
        pbPlayCancelSE()
        ret=cancelNumber
        pbWait(2)
        break
      end
    end
    cmdwindow.dispose
    Input.update
    return ret 
end

class Scene_EncounterRate
    def initialize(menu_index = 0)
        @menu_index = menu_index
    end
    
    def main
        if !defined?($game_variables[:EncounterRateModifier]) || $game_switches[:FirstUse]!=true
            $game_variables[:EncounterRateModifier]=1
        end
        fadein = true
        @sprites={}
        @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
        @viewport.z=99999
        @sprites["background"] = IconSprite.new(0,0)
        @sprites["background"].setBitmap("Graphics/Pictures/SpiceScentBg")
        @sprites["background"].z=255
        Graphics.transition
      
        params=ChooseNumberParams.new
        params.setRange(0,9999)
        params.setInitialValue($game_variables[:EncounterRateModifier].to_f*100)
        params.setCancelValue($game_variables[:EncounterRateModifier].to_f*100)       
        $game_variables[:EncounterRateModifier]=Kernel.pbMessageChooseNumberCentered(params).to_f/100
        $game_switches[:FirstUse]=true
        if defined?($game_map.map_id)
            $PokemonEncounters.setup($game_map.map_id)
        end
        $scene = Scene_Map.new
        Graphics.freeze
        pbDisposeSpriteHash(@sprites)
        @viewport.dispose
    end
end

# Actually Changing the Encounters (TOTEST)
class PokemonEncounters
    def setup(mapID)
        encounterMultiplier = ($game_switches[:FirstUse]) ? $game_variables[:EncounterRateModifier] : 1
        @density=nil
        @stepcount=0
        @enctypes=[]
        begin
          data=load_data("Data/encounters.dat")
          if data.is_a?(Hash) && data[mapID]
            landrate=data[mapID][0][0]*encounterMultiplier
            waterrate=data[mapID][0][1]*encounterMultiplier
            caverate=data[mapID][0][2]*encounterMultiplier
            @density=[landrate,caverate,waterrate,caverate,waterrate,waterrate,landrate,landrate,landrate,landrate,landrate,landrate,landrate]
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

    alias_method :old_pbGenerateEncounter, :pbGenerateEncounter
    def pbGenerateEncounter(enctype)
        if enctype<0 || enctype>EncounterTypes::EnctypeChances.length
          raise ArgumentError.new(_INTL("Encounter type out of range"))
        end
        return nil if @density==nil
        return nil if @density[enctype]==0 || !@density[enctype]
        return nil if @enctypes[enctype]==nil
        return nil if @stepcount + 1 <= 10 && $game_variables[:EncounterRateModifier]<=1
        return old_pbGenerateEncounter(enctype)
    end
end

# Rejuvenation-Like Switch/Variables Symbol Compatibility
class Game_Switches
    alias_method :old_get, :[]
    def [](switch_id)
      switch_id = Switches[switch_id] if switch_id.is_a?(Symbol)
      old_get(switch_id)
    end

    alias_method :old_set, :[]=
    def []=(switch_id, value)
      switch_id = Switches[switch_id] if switch_id.is_a?(Symbol)
      old_set(switch_id, value)
    end
end

class Game_Variables
    alias_method :old_get, :[]
    def [](variable_id)
      variable_id = Variables[variable_id] if variable_id.is_a?(Symbol)
      old_get(variable_id)
    end

    alias_method :old_set, :[]=
    def []=(variable_id, value)
      variable_id = Variables[variable_id] if variable_id.is_a?(Symbol)
      old_set(variable_id, value)
    end
end