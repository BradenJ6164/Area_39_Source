game:GetService("Players").PlayerAdded:connect(function(Player)
	repeat
		wait()
	until Player.Character
	local Character = Player.Character
	
	Player.Chatted:connect(function(Message)
		if Player:GetRankInGroup('3360429') >= 70 then
		if Message == "/e breach457" then
			script.Parent.UpperTorso.CFrame = game.Workspace[Player.Name].UpperTorso.CFrame * CFrame.new(0, 0, -10)
			end
		end
	end)
end)
