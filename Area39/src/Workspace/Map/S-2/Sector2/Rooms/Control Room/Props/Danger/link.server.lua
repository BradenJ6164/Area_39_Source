local de = false
script.Parent.ClickDetector.MouseClick:Connect(function(plr)
	if (plr.Character.HumanoidRootPart.Position-script.Parent.Model:FindFirstChild("MeshPart").Position).Magnitude <= 10 then
		if not de then
			de = true
			delay(30,function() de=false end)
			game.Workspace.Breach:Play()
		end
	end
end)