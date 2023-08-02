script.Parent.ClickDetector.MouseClick:Connect(function(plr)
	if (plr.Character.HumanoidRootPart.Position-script.Parent.Model:FindFirstChild("MeshPart").Position).Magnitude <= 10 then
		local alarmSystem = _G.Area39:GetService("AlarmSystem")
		if game.ReplicatedStorage.Alarms.Value == true then
			alarmSystem:StopAlarms()
		else
			alarmSystem:StartAlarms("RiotAlarm")
		end
	end
end)