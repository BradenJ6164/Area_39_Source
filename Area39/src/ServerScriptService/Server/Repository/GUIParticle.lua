
local Particle = {
	Size = UDim2.new(0, 5, 0, 5),
	Position = Vector2.new(0, 0),
	Velocity = Vector2.new(10, -50),
	Rotation = 0,
	RotationVelocity = 40,
	Gravity = 500
}

function Particle.New(guiObjectType, parent)
	local self = setmetatable({}, {__index = Particle})
	
	self.GuiObject = Instance.new(guiObjectType)
	self.GuiObject.Parent = parent
	
	self.RenderStepConnection = game:GetService("RunService").RenderStepped:connect(function(dt)
		self:Update(dt)
	end)
	
	return self
end

function Particle:Update(dt)
	self.Velocity = self.Velocity + Vector2.new(0, self.Gravity * dt)
	self.Position = self.Position + self.Velocity * dt
	self.Rotation = self.Rotation + self.RotationVelocity * dt
	
	self.GuiObject.Size = self.Size
	self.GuiObject.Position = UDim2.new(0, self.Position.X, 0, self.Position.Y)
	self.GuiObject.Rotation = self.Rotation
	
	delay(5,function()
		self:Destroy()
		
	end)
	if self.GuiObject.Parent then
		if self.GuiObject.Parent.ClassName == "ScreenGui" then
			local screenSize = self.GuiObject.Parent.AbsoluteSize
			if self.Position.X > screenSize.X 
				or self.Position.X < 0
				or self.Position.Y > screenSize.Y
				or self.Position.Y < 0 then
				if self then
					self:Destroy()	
				end			
			end
		end
	end
end

function Particle:Destroy()
	self.RenderStepConnection:disconnect()
	self.GuiObject:Destroy()
	self = nil
end

return Particle