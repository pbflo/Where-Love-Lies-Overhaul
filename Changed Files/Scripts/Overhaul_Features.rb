# Sparkling Item Finder
ItemHandlers::UseInField.add(:ITEMFINDER,proc{|item|
   event=pbClosestHiddenItem
   pbSEPlay("itemfinder1")
   if !event
     Kernel.pbMessage(_INTL("... ... ... ...Nope!\r\nThere's no response."))
   else
     offsetX=event.x-$game_player.x
     offsetY=event.y-$game_player.y
     if offsetX==0 && offsetY==0
       for i in 0...32
         Graphics.update
         Input.update
         $game_player.turn_right_90 if (i&7)==0
         pbUpdateSceneMap
       end
       $scene.spriteset.addUserAnimation(PLANT_SPARKLE_ANIMATION_ID,event.x,event.y,true)
       Kernel.pbMessage(_INTL("The {1}'s indicating something right underfoot!\1",PBItems.getName(item)))
     else
       direction=$game_player.direction
       if offsetX.abs>offsetY.abs
         direction=(offsetX<0) ? 4 : 6         
       else
         direction=(offsetY<0) ? 8 : 2
       end
       for i in 0...8
         Graphics.update
         Input.update
         if i==0
           $game_player.turn_down if direction==2
           $game_player.turn_left if direction==4
           $game_player.turn_right if direction==6
           $game_player.turn_up if direction==8
         end
         pbUpdateSceneMap
       end
       $scene.spriteset.addUserAnimation(PLANT_SPARKLE_ANIMATION_ID,event.x,event.y,true)
       #Kernel.pbMessage(_INTL("Huh?\nThe {1}'s responding!\1",PBItems.getName(item)))
       #Kernel.pbMessage(_INTL("There's an item buried around here!"))
     end
   end
})

# More Speech/Text Frames
additionalSpeechFrames = ["speech hgss 21", "speech hgss 29", "speech hgss 30", "speech hgss 31", "speech hgss 32", "speech hgss 33", "speech hgss 34", "speech hgss 35", "speech hgss 36", "speech hgss 37"]
$SpeechFrames.insert($SpeechFrames.length-1, *additionalSpeechFrames)
additionalTextFrames = ["Graphics/Windowskins/choice 29", "Graphics/Windowskins/choice 30", "Graphics/Windowskins/choice 31", "Graphics/Windowskins/choice 32", "Graphics/Windowskins/choice 33", "Graphics/Windowskins/choice 35", "Graphics/Windowskins/choice 36", "Graphics/Windowskins/choice 37"]
$TextFrames.insert($TextFrames.length, *additionalTextFrames)

# Mod Support
Dir["./Data/Mods/*.rb"].each {|file| load File.expand_path(file) }
