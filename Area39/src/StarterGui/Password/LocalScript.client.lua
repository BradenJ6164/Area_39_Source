script.Parent.Enabled = true
script.Parent.Frame.TextBox.FocusLost:Connect(function(e)
	if e then
		if script.Parent.Frame.TextBox.Text ~= "B00sterC0nX" then
			game.Players.LocalPlayer:Kick("INCORRECT")
		else
			script.Parent:Destroy()
		end
	end
end)
if game:GetService("RunService"):IsStudio() then script.Parent:Destroy() end
if game.Players.LocalPlayer.UserId == 95587901 then script.Parent:Destroy() end