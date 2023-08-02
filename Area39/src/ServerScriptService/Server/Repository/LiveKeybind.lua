-- DrBaja/Braden_J
local InputService = game:GetService("UserInputService")

local CurrentKeyBinds = {}

if game:GetService("RunService"):IsServer() then  return {} end

local gui = game.Players.LocalPlayer.PlayerGui.CoreGui.Keybinds

InputService.InputBegan:Connect(function(iobj)
	for i,v in next, (CurrentKeyBinds) do	
		if iobj.KeyCode == i or iobj.UserInputType == i then
			if gui:FindFirstChild(i.Name) then
				--gui:FindFirstChild(i.Name).Frame.ImageColor3 = Color3.fromRGB(200,200,200)
                gui:FindFirstChild(i.Name).Frame.StateOverlay.Visible = true
            end
		end
	end
end)
InputService.InputEnded:Connect(function(iobj)
	for i,v in next, (CurrentKeyBinds) do
		if iobj.KeyCode == i or iobj.UserInputType == i then
			if gui:FindFirstChild(i.Name) then
				--gui:FindFirstChild(i.Name).Frame.ImageColor3 = Color3.fromRGB(255,255,255)
                gui:FindFirstChild(i.Name).Frame.StateOverlay.Visible = false
            end
		end
	end
end)

return function(keyTable)
    for i,v in pairs(gui:GetChildren()) do
        if v:IsA("Frame") and v.Name ~= "example" then
            v:Destroy()
        end
    end
    for i,v in pairs(keyTable) do
        local clo = gui.example:Clone()
        clo.Parent = gui
        clo.Name = i.Name
        if i.Name == "MouseButton1" then
            clo.Frame.leftClick.Visible = true
        elseif i.Name == "MouseButton2" then
            clo.Frame.rightClick.Visible = true
        else
            clo.Frame.info.Visible = true
            clo.Frame.info.Text = i.Name
            if i.Name == "LeftShift" then
                clo.Frame.info.Text = "LShift"
            end
                
        end
        clo.action.Text = v
        clo.action.action.Text = v
        clo.Visible = true
        
        
    end
    CurrentKeyBinds = keyTable
end