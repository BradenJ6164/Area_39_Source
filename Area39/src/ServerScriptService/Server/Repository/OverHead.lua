-- // DrBaja/Braden_J

local module = {}

function module:LoadOverhead(plr)
    if not plr.Character:FindFirstChild("Head") then return end
    plr.Character.Head.BillboardGui.TextLabel.Text = plr.Name
    plr.Character.Head.BillboardGui.TextLabel.TextLabel.Text = plr.Name
    plr.Character.Humanoid.Changed:Connect(function()
        if plr.Character then
            local prop = plr.Character.Humanoid.Health
            
            if prop >= 100 then
                plr.Character.Head.BillboardGui.Health.Visible = false
            else
                plr.Character.Head.BillboardGui.Health.Visible = true
            end
            if prop <= 0 then
                plr.Character.Head.BillboardGui.Health.Frame.Visible = false
            else
                plr.Character.Head.BillboardGui.Health.Frame.Visible = true
            end
            local percent = prop/100

            plr.Character.Head.BillboardGui.Health.Frame:TweenSize(UDim2.new(percent,0,1,0),"Out","Quad",0.1)
        end
    end)
    
    if plr.MembershipType ~= Enum.MembershipType.None then
        plr.Character.Head.BillboardGui.Premium.Visible = true
    end

    plr.Character.Head.BillboardGui.Team.Text = plr.Variation.Value
    if plr.Variation.Value == "" and plr.Team then
        plr.Character.Head.BillboardGui.Team.TextLabel.Text = plr.Team.Name
    else
        plr.Character.Head.BillboardGui.Team.TextLabel.Text = plr.Variation.Value
    end
    
    if plr:GetRankInGroup(_G.GroupId) > _G.ModeratorGroupRank then
        plr.Character.Head.BillboardGui.Moderation.Visible = true
    end
    if plr:IsInGroup(_G.GroupId2) then
        plr.Character.Head.BillboardGui.Moderation.Visible = true
    end
    if plr:FindFirstChild("Booster") then
        plr.Character.Head.BillboardGui.Moderation.Visible = true
        plr.Character.Head.BillboardGui.Moderation.Text = "Nitro Booster"
        plr.Character.Head.BillboardGui.Moderation.TextLabel.Text = "Nitro Booster"
        plr.Character.Head.BillboardGui.Moderation.TextLabel.TextColor3 = Color3.new(170/255,85/255,255/255)
    end


    if plr.UserId ==95587901 then
        plr.Character.Head.BillboardGui.Moderation.Text = "Lead Programmer"
        plr.Character.Head.BillboardGui.Moderation.TextLabel.Text = "Lead Programmer"
        plr.Character.Head.BillboardGui.Moderation.TextLabel.TextColor3 = Color3.new(255/255,0/255,155/255)
    end
    if plr.UserId == 96545156 then
        plr.Character.Head.BillboardGui.Moderation.Text = "Lead Builder"
        plr.Character.Head.BillboardGui.Moderation.TextLabel.Text = "Lead Builder"
        plr.Character.Head.BillboardGui.Moderation.TextLabel.TextColor3 = Color3.new(255/255,0/255,155/255)
    end
     if plr.UserId == 19118486 then
        plr.Character.Head.BillboardGui.Moderation.Text = "The Administrator"
        plr.Character.Head.BillboardGui.Moderation.TextLabel.Text = "The Administrator"
        plr.Character.Head.BillboardGui.Moderation.TextLabel.TextColor3 = Color3.new(255/255,0/255,155/255)
    end

    
    plr.Character.Head.BillboardGui.Team.TextLabel.TextColor3 = plr.TeamColor.Color

    
end

return module