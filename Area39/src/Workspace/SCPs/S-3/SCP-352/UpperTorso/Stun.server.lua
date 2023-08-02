function onTouched(hit)
	local humanoid = hit.Parent:findFirstChild("Humanoid")
	local humanoid2 = hit.Parent:findFirstChild("HumanoidRootPart")
	local stun = true
	if humanoid~=nil then
		wait(0.01)
		humanoid.WalkSpeed = 1

		stun = false
		wait(1.65)

		humanoid.WalkSpeed = 16
		wait(3)
		stun = true
	end 
end 

script.Parent.Touched:connect(onTouched)

