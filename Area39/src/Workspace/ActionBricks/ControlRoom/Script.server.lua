local d = false
script.Parent.Touched:Connect(function(c)
	if c.Parent:FindFirstChild("Humanoid") then
		if d == false then
			d = true
			delay(0.5,function() d = false end)
			local plr = game.Players:GetPlayerFromCharacter(c.Parent)
			if plr then
				if plr.Team.Name == "Chaos Insurgency" then
					plr:LoadCharacter()
					wait()
					plr.Stats.ControlRoomOvertakes.Value = plr.Stats.ControlRoomOvertakes.Value + 1
				end
			end
		end
	end
end)