function onTouched(hit)
	local humanoid = hit.Parent:findFirstChild("Humanoid")
	if humanoid~=nil then
		wait(0.01)
      humanoid.PlatformStand = true
        wait(2)
      humanoid.PlatformStand = false
	end 
end 

script.Parent.Touched:connect(onTouched)