#===============================================================================
#  Neo PauseMenu (for v16.x)
#    by Luka S.J.
# ---------------- 
#  Provides only features present in the default version of the Pokedex in
#  Essentials. Mean as a new cosmetic overhaul, adhering to the UI design
#  language of the Elite Battle System: The Next Generation
#
#  Enjoy the script, and make sure to give credit!
#  (DO NOT ALTER THE NAMES OF THE INDIVIDUAL SCRIPT SECTIONS OR YOU WILL BREAK
#   YOUR SYSTEM!)
#-------------------------------------------------------------------------------
#  Main module for handling each menu item/entry
#===============================================================================
module MenuHandlers
  # hash used to store the elements inside of the menu
  @@menuEntry = {}
  # hash used to store whether or not an element is unlocked
  @@available = {}
  # hash used to store the index of each element; for sorting
  @@indexes = {}
  @@index = 0
  # function to add a new element/entry to the menu.
  def self.addEntry(ref,name,icon,proc,conditional)
    @@menuEntry[ref] = [name,icon,proc]
    @@available[ref] = conditional
    @@indexes[ref] = @@index
    @@index += 1
  end
  # function to get the name of an element/entry
  def self.getName(ref)
    return @@menuEntry[ref][0]
  end
  # function to get the icon of an element/entry
  def self.getIcon(ref)
    return "Graphics/Icons/#{@@menuEntry[ref][1]}"
  end
  # function to get all the possible keys from the main hash
  def self.getKeys
    entries = Array.new(@@menuEntry.keys.length)
    for key in @@menuEntry.keys
      entries[@@indexes[key]] = key
    end
    return entries
  end
  # function used to invoke the stored code for each element/entry
  def self.runAction(ref,scene)
    @@menuEntry[ref][2].call(scene)
  end
  # function to check if the player has access to an element/entry
  def self.available?(ref)
    return @@available[ref].call
  end
  # function that lists all accessible menu elements/entries
  def self.elements?
    ent = self.getKeys
    items = 0
    for val in ent
      items += 1 if self.available?(val)
    end
    return items
  end
end
# compatibility ported from UPI
# WHICH I KEEP FORGETTING
class Sprite
  attr_reader :storedBitmap
  attr_accessor :speed
  attr_accessor :toggle
  attr_accessor :end_x
  attr_accessor :end_y
  attr_accessor :param
  attr_accessor :ex
  attr_accessor :ey
  
  def blur_sprite(blur_val=2,opacity=35)
    bitmap = self.bitmap
    self.bitmap = Bitmap.new(bitmap.width,bitmap.height)
    self.bitmap.blt(0,0,bitmap,Rect.new(0,0,bitmap.width,bitmap.height))
    x=0
    y=0
    for i in 1...(8 * blur_val)
      dir = i % 8
      x += (1 + (i / 8))*([0,6,7].include?(dir) ? -1 : 1)*([1,5].include?(dir) ? 0 : 1)
      y += (1 + (i / 8))*([1,4,5,6].include?(dir) ? -1 : 1)*([3,7].include?(dir) ? 0 : 1)
      self.bitmap.blt(x-blur_val,y+(blur_val*2),bitmap,Rect.new(0,0,bitmap.width,bitmap.height),opacity)
    end
  end
end

class ScrollingSprite < Sprite
  attr_accessor :speed
  attr_accessor :direction
  attr_accessor :vertical
  
  def setBitmap(val,vertical=false,pulse=false)
    @vertical = vertical
    @pulse = pulse
    @direction = 1 if @direction.nil?
    @gopac = 1
    @speed = 32 if @speed.nil?
    val = pbBitmap(val) if val.is_a?(String)
    if @vertical
      bmp = Bitmap.new(val.width,val.height*2)
      for i in 0...2
        bmp.blt(0,val.height*i,val,Rect.new(0,0,val.width,val.height))
      end
      self.bitmap = bmp.clone
      y = @direction > 0 ? 0 : val.height
      self.src_rect.set(0,y,val.width,val.height)
    else
      bmp = Bitmap.new(val.width*2,val.height)
      for i in 0...2
        bmp.blt(val.width*i,0,val,Rect.new(0,0,val.width,val.height))
      end
      self.bitmap = bmp.clone
      x = @direction > 0 ? 0 : val.width
      self.src_rect.set(x,0,val.width,val.height)
    end
  end
  
  def update
    if @vertical
      self.src_rect.y += @speed*@direction
      self.src_rect.y = 0 if @direction > 0 && self.src_rect.y >= self.src_rect.height
      self.src_rect.y = self.src_rect.height if @direction < 0 && self.src_rect.y <= 0
    else
      self.src_rect.x += @speed*@direction
      self.src_rect.x = 0 if @direction > 0 && self.src_rect.x >= self.src_rect.width
      self.src_rect.x = self.src_rect.width if @direction < 0 && self.src_rect.x <= 0
    end
    if @pulse
      self.opacity -= @gopac*@speed
      @gopac *= -1 if self.opacity == 255 || self.opacity == 0
    end
  end
end

def pbBitmap(name)
  if !pbResolveBitmap(name).nil?
    bmp = BitmapCache.load_bitmap(name)
  else
    p "Image located at '#{name}' was not found!" if $DEBUG
    bmp = Bitmap.new(1,1)
  end
  return bmp
end
#-------------------------------------------------------------------------------
#  Main class used to handle the visuals
#-------------------------------------------------------------------------------
class PokemonMenu_Scene
  attr_accessor :index
  attr_accessor :entries
  attr_accessor :endscene
  attr_accessor :close
  attr_accessor :hidden
  
  # retained for compatibility
  def pbShowInfo(text)
    @sprites["helpwindow"].resizeToFit(text,Graphics.height)
    @sprites["helpwindow"].text = text
    @sprites["helpwindow"].visible = true
    @helpstate = true
    pbBottomLeft(@sprites["helpwindow"])
  end
  # retained for compatibility
  def pbShowHelp(text)
    @sprites["helpwindow"].resizeToFit(text,Graphics.height)
    @sprites["helpwindow"].text = text
    @sprites["helpwindow"].visible = true
    @helpstate = true
    pbBottomLeft(@sprites["helpwindow"])
  end
  # main scene generation
  def pbStartScene
    pbSetViableDexes
    # sets the default index
    @index = $PokemonTemp.menuLastChoice.nil? ? 0 : $PokemonTemp.menuLastChoice
    @index = 0 if @index >= MenuHandlers.elements?
    @oldindex = 0
    @endscene = true
    @close = false
    @hidden = false
    # loads the visual parts of the 
    @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    # initializes the background graphic
    @bitmap = Graphics.snap_to_bitmap if !@bitmap
    @sprites["background"] = Sprite.new(@viewport)
    @sprites["background"].bitmap = @bitmap
    @sprites["background"].blur_sprite(3)
    pause_bg = "Graphics/Pictures/PauseMenu/bg_#{$PokemonGlobal.playerID}"
    @sprites["background"].bitmap.blt(0,0,pbBitmap(pause_bg),Rect.new(0,0,Graphics.width,Graphics.height))
    bmp = pbBitmap("Graphics/Pictures/Common/scrollbar_bg")
    @sprites["background"].bitmap.blt(Graphics.width - 28,(Graphics.height - bmp.height)/2,bmp,Rect.new(0,0,bmp.width,bmp.height))
    # initializes the scrolling panorama
    @sprites["panorama"] = ScrollingSprite.new(@viewport)
    @sprites["panorama"].setBitmap("Graphics/Pictures/Common/panorama")
    @sprites["panorama"].speed = 1
    # retained for compatibility
    @sprites["infowindow"] = Window_UnformattedTextPokemon.newWithSize("",0,0,32,32,@viewport)
    @sprites["infowindow"].visible = false
    @sprites["helpwindow"] = Window_UnformattedTextPokemon.newWithSize("",0,0,32,32,@viewport)
    @sprites["helpwindow"].visible = false
    # draw the contest crap
    @sprites["textOverlay"] = Sprite.new(@viewport)
    @sprites["textOverlay"].bitmap = Bitmap.new(@viewport.rect.width,@viewport.rect.height)
    @sprites["textOverlay"].end_x = 0
    @sprites["textOverlay"].x = -@viewport.rect.width
    pbSetSystemFont(@sprites["textOverlay"].bitmap)
    bmp = pbBitmap("Graphics/Pictures/Common/partyBar")
    content = []
    text = []
    if pbInSafari?
      content.push(_INTL("Steps: {1}/{2}",pbSafariState.steps,SAFARISTEPS)) if SAFARISTEPS > 0
      content.push(_INTL("Balls: {1}",pbSafariState.ballcount))
    elsif pbInBugContest?
      if pbBugContestState.lastPokemon
        content.push(_INTL("Caught: {1}",PBSpecies.getName(pbBugContestState.lastPokemon.species)))
        content.push(_INTL("Level: {1}",pbBugContestState.lastPokemon.level))
        content.push(_INTL("Balls: {1}",pbBugContestState.ballcount))
      else
        content.push("Caught: none")
      end
      content.push(_INTL("Balls: {1}",pbBugContestState.ballcount))
    end
    for i in 0...content.length
      text.push([content[i],16, 60 + i*50, 0, Color.new(255,255,255),Color.new(0,0,0,65)])
      @sprites["textOverlay"].bitmap.blt(-2,92 + i*50,bmp,Rect.new(0,0,bmp.width,bmp.height))
    end
    pbDrawTextPositions(@sprites["textOverlay"].bitmap,text)
    # initializes the scroll bar
    @sprites["scroll"] = Sprite.new(@viewport)
    # rendering elements on screen
    self.refresh
    self.update
    # memorizes the target opacities and sets them to 0
    @opacities = {}
    for key in @sprites.keys
      @opacities[key] = @sprites[key].opacity
      @sprites[key].opacity = 0
    end
  end

  def pbHideMenu
    # animations for closing the menu
    @sprites["textOverlay"].end_x = -@viewport.rect.width
    8.times do
      for key in @sprites.keys
        next if !@sprites[key] || @sprites[key].disposed?
        @sprites[key].opacity -= 32
      end
      @sprites["textOverlay"].x += (@sprites["textOverlay"].end_x - @sprites["textOverlay"].x)*0.2
      Graphics.update
    end
  end

  def pbShowMenu
    # animations for opening the menu
    @sprites["textOverlay"].end_x = 0
    8.times do
      for key in @sprites.keys
        next if !@sprites[key] || @sprites[key].disposed?
        @sprites[key].opacity += 32 if @sprites[key].opacity < @opacities[key]
      end
      @sprites["textOverlay"].x += (@sprites["textOverlay"].end_x - @sprites["textOverlay"].x)*0.4
      Graphics.update
    end
  end
  
  def refresh
    # index safety
    @index = MenuHandlers.elements? - 1 if @index >= MenuHandlers.elements?
    @oldindex = @index
    # disposes old items in the menu
    if @entries
      for i in 0...@entries.length
        @sprites["#{i}"].dispose if @sprites["#{i}"]
      end
    end
    # creates a new list of available items
    ent = MenuHandlers.getKeys
    @entries = []
    for val in ent
      @entries.push(val) if MenuHandlers.available?(val)
    end
    # draws individual item entries
    bmp = pbBitmap("Graphics/Pictures/PauseMenu/sel")
    for i in 0...@entries.length
      key = @entries[i]
      @sprites["#{i}"] = Sprite.new(@viewport)
      @sprites["#{i}"].bitmap = Bitmap.new(bmp.width,bmp.height)
      pbSetSystemFont(@sprites["#{i}"].bitmap)
      @sprites["#{i}"].src_rect.set(0,0,bmp.width/2,bmp.height)
      @sprites["#{i}"].bitmap.blt(0,0,bmp,Rect.new(0,0,bmp.width,bmp.height))
      for j in 0...2
        opac = j == 0 ? 155 : 255
        icon = pbBitmap(MenuHandlers.getIcon(key))
        text = MenuHandlers.getName(key)
        text.gsub!("\\pn"){"#{$Trainer.name}"}
        text.gsub!("\\contest"){pbInSafari? ? "Quit" : "Quit Contest"}
        @sprites["#{i}"].bitmap.blt(18 + j*bmp.width/2,6,icon,Rect.new(0,0,48,48),opac)
        pbDrawOutlineText(@sprites["#{i}"].bitmap,66 + j*bmp.width/2,6,136,48,text,Color.new(255,255,255),Color.new(64,64,64),1)
      end
      @sprites["#{i}"].x = Graphics.width - bmp.width/2 - 52
      @sprites["#{i}"].y = 49 + (bmp.height + 12)*i
      @sprites["#{i}"].opacity = 128
    end
    # configures the scroll bar
    n = (@entries.length < 4 ? 1 : @entries.length - 3)
    height = 204/n
    height += 204 - (height*n)
    height += 16
    @sprites["scroll"].bitmap = Bitmap.new(16,height)
    bmp = pbBitmap("Graphics/Pictures/Common/scrollbar_kn")
    @sprites["scroll"].bitmap.blt(0,0,bmp,Rect.new(0,0,16,6))
    @sprites["scroll"].bitmap.stretch_blt(Rect.new(0,6,16,height-14),bmp,Rect.new(0,6,16,1))
    @sprites["scroll"].bitmap.blt(0,height-8,bmp,Rect.new(0,8,16,8))
    @sprites["scroll"].x = Graphics.width - 32
    @sprites["scroll"].y = (Graphics.height - 204)/2
    @sprites["scroll"].end_y = (Graphics.height - 204)/2
  end
  
  def update
    # scrolling background image
    @sprites["panorama"].update
    # calculations for updating the scrollbar position
    k = (@entries.length < 4 ? 0 : @index - 3)
    k = 0 if k < 0
    n = (@entries.length < 4 ? 1 : @entries.length - 3)
    height = 204/n
    @sprites["scroll"].end_y = (Graphics.height-204)/2 + height*k
    @sprites["scroll"].y += (@sprites["scroll"].end_y - @sprites["scroll"].y)*0.2
    # updates for each element/entry in the menu
    for i in 0...@entries.length
      j = @entries.length < 4 ? 0 : (@index - 3)
      j = 0 if j < 0
      y = (-j)*(@sprites["#{i}"].src_rect.height + 12) + 49 + i*(@sprites["#{i}"].src_rect.height + 12)
      @sprites["#{i}"].y -= (@sprites["#{i}"].y - y)*0.1
      @sprites["#{i}"].src_rect.x = @sprites["#{i}"].src_rect.width*(@index == i ? 1 : 0)
      @sprites["#{i}"].x += 2 if @sprites["#{i}"].x < Graphics.width - @sprites["#{i}"].src_rect.width - 52
      if i.between?(j,j+3)
        @sprites["#{i}"].opacity += 15 if @sprites["#{i}"].opacity < 255
      else
        @sprites["#{i}"].opacity -= 15 if @sprites["#{i}"].opacity > 128
      end
      if @index == i
        @sprites["#{i}"].tone.gray -= 51 if @sprites["#{i}"].tone.gray > 0
      else
        @sprites["#{i}"].tone.gray += 51 if @sprites["#{i}"].tone.gray < 255
      end
    end
    # sets the index
    if @oldindex != @index
      @sprites["#{@index}"].x -= 6
      @oldindex = @index
    end
  end

  def pbEndScene
    # disposes the sprite hash
    pbHideMenu
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end

  def pbRefresh
  end
end
#-------------------------------------------------------------------------------
#  Main class used to handle the logic of the pause menu
#-------------------------------------------------------------------------------
class PokemonMenu
  def initialize(scene)
    @scene = scene
  end

  def pbShowMenu
    #@scene.pbRefresh
    @scene.pbShowMenu
  end

  def pbStartPokemonMenu
    # loads up the scene
    @scene.pbStartScene
    @scene.pbShowMenu
    loop do
      # main loop
      Graphics.update
      Input.update
      @scene.update
      if Input.repeat?(Input::DOWN)
        @scene.index += 1
        @scene.index = 0 if @scene.index > @scene.entries.length - 1
        $PokemonTemp.menuLastChoice = @scene.index
        pbSEPlay("SE_Select1")
      elsif Input.repeat?(Input::UP)
        @scene.index -= 1
        @scene.index = @scene.entries.length - 1 if @scene.index < 0
        $PokemonTemp.menuLastChoice = @scene.index
        pbSEPlay("SE_Select1")
      elsif Input.trigger?(Input::C)
        MenuHandlers.runAction(@scene.entries[@scene.index],@scene)
      end
      break if @scene.close || Input.trigger?(Input::B)
    end
    # used to dispose of the scene
    @scene.pbEndScene if @scene.endscene
  end  
end
#-------------------------------------------------------------------------------
#  Your own entries for the pause menu
#
#  How to use
#
#  MenuHandlers.addEntry(:name,"button text","icon name",proc{|menu|
#    # code you want to run
#    # when the entry in the menu is selected
#  },proc{ # code to check if menu entry is available })
#-------------------------------------------------------------------------------
# PokeDex
MenuHandlers.addEntry(:POKEDEX,_INTL("Pokédex"),"menuPokedex",proc{|menu|
  if DEXDEPENDSONLOCATION
    pbFadeOutIn(99999) {
        scene = PokemonPokedexScene.new
        screen = PokemonPokedex.new(scene)
        screen.pbStartScreen
    }
  else
    if $PokemonGlobal.pokedexViable.length == 1
      $PokemonGlobal.pokedexDex = $PokemonGlobal.pokedexViable[0]
      $PokemonGlobal.pokedexDex = -1 if $PokemonGlobal.pokedexDex == $PokemonGlobal.pokedexUnlocked.length-1
      pbFadeOutIn(99999) {
          scene = PokemonPokedexScene.new
          screen = PokemonPokedex.new(scene)
          screen.pbStartScreen
      }
    else
      pbLoadRpgxpScene(Scene_PokedexMenu.new)
    end
  end
},proc{ return $Trainer.pokedex && $PokemonGlobal.pokedexViable.length > 0 })
# Party Screen
MenuHandlers.addEntry(:POKEMON,_INTL("Pokémon"),"menuPokemon",proc{|menu|
  sscene = PokemonScreen_Scene.new
  sscreen = PokemonScreen.new(sscene,$Trainer.party)
  hiddenmove = nil
  pbFadeOutIn(99999) { 
    hiddenmove = sscreen.pbPokemonScreen
    if hiddenmove
      menu.pbEndScene
      menu.endscene = false
    end
  }
  if hiddenmove
    Kernel.pbUseHiddenMove(hiddenmove[0],hiddenmove[1])
    menu.close = true
  end
},proc{ return $Trainer.party.length > 0 })
# Bag Screen
MenuHandlers.addEntry(:BAG,_INTL("Bag"),"menuBag",proc{|menu|
  item = 0
  scene = PokemonBag_Scene.new
  screen = PokemonBagScreen.new(scene,$PokemonBag)
  pbFadeOutIn(99999) { 
  item = screen.pbStartScreen 
  if item > 0
    menu.pbEndScene
    menu.endscene = false
  end
  }
  if item > 0
    Kernel.pbUseKeyItemInField(item)
    menu.close = true
  end
},proc{ return true })
# PokeGear
MenuHandlers.addEntry(:POKEGEAR,_INTL("CyberNav"),"menuPokegear",proc{|menu|
#  pbLoadRpgxpScene(Scene_Pokegear.new)
#  scene = PokemonPokegear_Scene.new
#  screen = PokemonPokegearScreen.new(scene)
  pbFadeOutIn(99999){
    pbLoadRpgxpScene(Scene_Pokegear.new)
#    screen.pbStartScreen
  }
},proc{ return $Trainer.pokegear })
# Trainer Card
MenuHandlers.addEntry(:TRAINER,_INTL("\\pn"),"menuTrainer",proc{|menu|
  scene = PokemonTrainerCardScene.new
  screen = PokemonTrainerCard.new(scene)
  pbFadeOutIn(99999) { 
    screen.pbStartScreen
  }
},proc{ return true })
# Save Screen
MenuHandlers.addEntry(:SAVE,_INTL("Save"),"menuSave",proc{|menu|
  scene = PokemonSaveScene.new
  screen = PokemonSave.new(scene)
  menu.pbEndScene
  menu.endscene = false
  if screen.pbSaveScreen
    menu.close = true
  else
    menu.pbStartScene
    menu.pbShowMenu
    menu.close = false
  end
},proc{ return !$game_system || !$game_system.save_disabled && !(pbInSafari? || pbInBugContest?)})
# Quit Safari-Zone
MenuHandlers.addEntry(:QUIT,_INTL("\\contest"),"menuQuit",proc{|menu|
  if pbInSafari?
    if Kernel.pbConfirmMessage(_INTL("Would you like to leave the Safari Game right now?"))
      menu.pbEndScene
      menu.endscene = false
      menu.close = true
      pbSafariState.decision=1
      pbSafariState.pbGoToStart
    end
  else
    if Kernel.pbConfirmMessage(_INTL("Would you like to end the Contest now?"))
      menu.pbEndScene
      menu.endscene = false
      menu.close = true
      pbBugContestState.pbStartJudging
      return
    end
  end
},proc{ return pbInSafari? || pbInBugContest? })
# Options Screen
MenuHandlers.addEntry(:OPTIONS,_INTL("Options"),"menuOptions",proc{|menu|
  scene = PokemonOptionScene.new
  screen = PokemonOption.new(scene)
  pbFadeOutIn(99999) {
    screen.pbStartScreen
    pbUpdateSceneMap
  }
},proc{ return true })
# Debug Menu
MenuHandlers.addEntry(:DEBUG,_INTL("Debug"),"menuDebug",proc{|menu|
  pbFadeOutIn(99999) { 
    pbDebugMenu
    menu.refresh
  }
},proc{ return $DEBUG })