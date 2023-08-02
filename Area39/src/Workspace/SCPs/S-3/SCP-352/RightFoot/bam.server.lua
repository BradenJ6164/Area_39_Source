local Part = script.Parent

local Debris = game:GetService('Debris')

local CharacterToIgnore = script:WaitForChild('CharacterToIgnore').Value

local MAGNITUDE = 1000
local TIME_OF_FORCE = 0.2

local hit = true

Part.Touched:connect(function(other)
	local hit = false
	wait(0.3)
	if other.Parent == CharacterToIgnore or (other.Parent and other.Parent.Parent == CharacterToIgnore) then return end
	if not other.Anchored then
		local punchSound = script.Parent.Parent.Head.PunchSound
		if punchSound then punchSound:Play() end
		local direction = (other.Position - Part.Position).unit
		local bodyForce = Instance.new('BodyForce')
		bodyForce.force = MAGNITUDE * direction
		bodyForce.Parent = other
		Debris:AddItem(bodyForce, TIME_OF_FORCE)
	wait(5)
	local hit = true
	end
end)
	
