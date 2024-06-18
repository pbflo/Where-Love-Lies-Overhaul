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

# JoiPlay snap_to_bitmap Fix
module Graphics
  class <<self
    alias_method :original_snap_to_bitmap, :snap_to_bitmap if self.method_defined?(:snap_to_bitmap)
  end

  def self.snap_to_bitmap
    ret = new_snap_to_bitmap()
    ret = original_snap_to_bitmap() if ret == nil && defined?(:original_snap_to_bitmap)
    return ret
  end
end
