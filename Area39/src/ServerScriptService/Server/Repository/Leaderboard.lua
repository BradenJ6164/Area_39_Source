local gui = game.Players.LocalPlayer.PlayerGui:WaitForChild("Leaderboard").ScrollingFrame

function resizeResize()
    for i,v in pairs(gui:GetChildren()) do
        if v:IsA("Frame") and v:FindFirstChild("UIListLayout") then
            v.Size = UDim2.new(0.98,0,0,v.UIListLayout.AbsoluteContentSize.Y)
        end
    end
end

return function()

    function plrAdd(plr)
        if not plr then end
        if not plr.Team then end
        if not gui:FindFirstChild(plr.Team.Name) then
            local team = gui.template:Clone()
            team.Name = plr.Team.Name
            team.Parent = gui
            team.Visible = true
            team.Title.TextLabel.Text = plr.Team.Name
            team.Title.BackgroundColor3 = plr.Team.TeamColor.Color
            if plr.Team.TeamColor.Color.R > 180/255 or plr.Team.TeamColor.Color.G > 180/255 or plr.Team.TeamColor.Color.B > 180/255 then
                team.Title.TextLabel.TextColor3 = Color3.fromRGB(0,0,0)
            else
                team.Title.TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
            end
        end
        local plrGui = gui:FindFirstChild(plr.Team.Name).template:Clone()
        plrGui.Parent = gui:FindFirstChild(plr.Team.Name)
        plrGui.Name = plr.Name
        plrGui.plrName.Text = plr.Name
        plrGui.Visible = true
        if plr.MembershipType ~= Enum.MembershipType.None then
            plrGui.Premium.Visible = true
        end
        if plr:IsInGroup(7643572) or plr:GetRankInGroup(5500300) >= 253 then
            plrGui.plrName.TextColor3 = Color3.fromRGB(170, 170, 255)
        end
        gui:FindFirstChild(plr.Team.Name).Size = UDim2.new(0.98,0,0,gui:FindFirstChild(plr.Team.Name).UIListLayout.AbsoluteContentSize.Y)
        gui.CanvasSize = UDim2.new(0,0,0,gui.UIListLayout.AbsoluteContentSize.Y)

        plr:GetPropertyChangedSignal("Team"):Connect(function()
            for i,v in pairs(gui:GetDescendants()) do
                if v:IsA("Frame") and v.Name == plr.Name then
                    v.Parent.Size = UDim2.new(0.98,0,0,v.Parent.UIListLayout.AbsoluteContentSize.Y)
                    if #v.Parent:GetChildren()-1 <= 3 then
                        v.Parent:Destroy()
                    else
                        v:Destroy()
                    end

                   
                    break
                end
            end

                    if not gui:FindFirstChild(plr.Team.Name) then
                        local team = gui.template:Clone()
                        team.Name = plr.Team.Name
                        team.Parent = gui
                        team.Visible = true
                        team.Title.TextLabel.Text = plr.Team.Name
                        team.Title.BackgroundColor3 = plr.Team.TeamColor.Color
                        if plr.Team.TeamColor.Color.R > 150/255 or plr.Team.TeamColor.Color.G > 150/255 or plr.Team.TeamColor.Color.B > 150/255 then
                            team.Title.TextLabel.TextColor3 = Color3.fromRGB(0,0,0)
                        else
                            team.Title.TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
                        end
                    end
                    local plrGui2 = gui:FindFirstChild(plr.Team.Name).template:Clone()
                    plrGui2.Parent = gui:FindFirstChild(plr.Team.Name)
                    plrGui2.Name = plr.Name
                    plrGui2.plrName.Text = plr.Name
                    plrGui2.Visible = true
                    if plr.MembershipType ~= Enum.MembershipType.None then
                        plrGui2.Premium.Visible = true
                    end
                    if plr:IsInGroup(7643572) or plr:GetRankInGroup(5500300) >= 253 then
                        plrGui2.plrName.TextColor3 = Color3.fromRGB(170, 170, 255)
                    end
                    gui:FindFirstChild(plr.Team.Name).Size = UDim2.new(0.98,0,0,gui:FindFirstChild(plr.Team.Name).UIListLayout.AbsoluteContentSize.Y)
                    gui.CanvasSize = UDim2.new(0,0,0,gui.UIListLayout.AbsoluteContentSize.Y)

               
                    resizeResize()
        end)
        resizeResize()

    end
    function plrRemove(plr)
        if plr.Team then
            if gui:FindFirstChild(plr.Team.Name) then
                if gui:FindFirstChild(plr.Team.Name):FindFirstChild(plr.Name) then
                    gui:FindFirstChild(plr.Team.Name):FindFirstChild(plr.Name):Destroy()
                    local count = #gui:FindFirstChild(plr.Team.Name):GetChildren()
                    if count <= 3 then
                        gui:FindFirstChild(plr.Team.Name):Destroy()
                    else
                        gui:FindFirstChild(plr.Team.Name).Size = UDim2.new(0.98,0,0,gui:FindFirstChild(plr.Team.Name).UIListLayout.AbsoluteContentSize.Y)
                    end
                    gui.CanvasSize = UDim2.new(0,0,0,gui.UIListLayout.AbsoluteContentSize.Y)
                end
            end
        end
        resizeResize()
    end

    for i,v in pairs(game.Players:GetPlayers()) do
        plrAdd(v)
    end

    game.Players.PlayerRemoving:Connect(plrRemove)
    game.Players.PlayerAdded:Connect(plrAdd)


end