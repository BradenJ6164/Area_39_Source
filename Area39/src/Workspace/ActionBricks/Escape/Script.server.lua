local d = false
script.Parent.Touched:Connect(function(c)
	if c.Parent:FindFirstChild("Humanoid") then
		if d == false then
			d = true
			delay(0.5,function() d = false end)
			local plr = game.Players:GetPlayerFromCharacter(c.Parent)
			if plr then
				if plr.Team.Name == "Class D" then
					plr:LoadCharacter()
					wait()
					plr.Stats.Escapes.Value = plr.Stats.Escapes.Value + 1
					plr.leaderstats.Credits.Value = plr.leaderstats.Credits.Value + 100
					_G.Area39:SendSnackBar(plr,"You've been rewarded 100 credits for escaping!")
					_G.Area39:SendConfetti(plr)
				end
			end
		end
	end
end)