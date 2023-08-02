function onTouched(hit)
	local humanoid = hit.Parent:findFirstChild("Humanoid")
	if humanoid~=nil then
		wait(0.01)
		humanoid.WalkSpeed = 5
	end 
end 

script.Parent.Touched:connect(onTouched)

