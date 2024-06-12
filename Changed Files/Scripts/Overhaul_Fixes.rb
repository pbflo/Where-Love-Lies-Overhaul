# Surfing Wall Glitch Fix
$lastpbEndSurfResult = false

alias follower_realEndSurf follow_pbEndSurf
def follow_pbEndSurf(xOffset,yOffset)
  return $lastpbEndSurfResult
end

alias follower_endSurf pbEndSurf
def pbEndSurf(xOffset,yOffset)
  $lastpbEndSurfResult = follower_realEndSurf(xOffset,yOffset)
  follower_endSurf(xOffset,yOffset)
  return $lastpbEndSurfResult
end

# Font Install Fix
module FontInstaller
  class <<self
    alias_method :old_install, :install
  end

  def self.install 
    # Check if all fonts already exist
    fontsExist=true
    dest=self.getFontFolder()
    for i in 0...Names.size
      if !Font.exist?(Names[i])
        fontsExist=false
      end
    end
    return if fontsExist
    # Else call install method
    old_install
  end
end

# Mod Support
Dir["./Data/Mods/*.rb"].each {|file| load File.expand_path(file) }
