h = 100
script.Parent.ClickDetector.MouseClick:connect(function(p)
	if p.Character:FindFirstChild("Cough") then
		
		else
	local s = Instance.new("Sound")
	s.Name = "Cough"
	s.Parent = p.Character.Head
	s.Volume = 3
	s.SoundId = "rbxassetid://271820055"
	s:Play()

	repeat
		h = h-3 
		p.Character.Humanoid.Health = h
		if p.Character.Humanoid.WalkSpeed > -0.9 then 
		p.Character.Humanoid.WalkSpeed = p.Character.Humanoid.WalkSpeed - 0.4
		end
		wait(.5)
	until h < 0
	h = 100
	end
end)