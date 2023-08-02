return function(frame)
    local bind = Instance.new("BindableEvent")
    local function plrAdd(plr)
        local clo = frame.template:Clone()
        clo.Name = plr.Name
        clo.Parent = frame
        clo.playerName.Text = plr.Name
        clo.gfx.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. plr.UserId .. "&width=512&height=512&format=png"
        clo.button.MouseButton1Click:Connect(function()
            bind:Fire(plr)
        end)
        clo.Visible = true
        frame.CanvasSize = UDim2.new(0,frame.UIListLayout.AbsoluteContentSize.X,0,0)
    end
    local function plrRemove(plr)
        if frame:FindFirstChild(plr.Name) then
            frame:FindFirstChild(plr.Name):Destroy()
        end
        frame.CanvasSize = UDim2.new(0,frame.UIListLayout.AbsoluteContentSize.X,0,0)
    end
    for i,v in pairs(game.Players:GetPlayers()) do
        plrAdd(v)
    end
    game.Players.PlayerAdded:Connect(plrAdd)
    game.Players.PlayerRemoving:Connect(plrRemove)
    return bind
end