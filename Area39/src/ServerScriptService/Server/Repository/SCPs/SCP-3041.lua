local lastTick = tick()
return function(scp)
    if math.abs(lastTick-tick()) <= 60 then
        return
    end
    lastTick = tick()
    scp.ClickDetector.MouseClick:Connect(function(plr)
        if (plr.Character.HumanoidRootPart.Position-scp.Blade.Position).Magnitude < 12 then
            local range = 150
            local retu = nil
            local origin
            for i,v in pairs(game.Players:GetPlayers()) do
                if (v.Character.HumanoidRootPart.Position-plr.Character.HumanoidRootPart.Position).Magnitude <= range then
                    range = (v.Character.HumanoidRootPart.Position-plr.Character.HumanoidRootPart.Position).Magnitude
                    retu = v
                end
            end
            origin = plr.Character.PrimaryPart.CFrame
            if retu then
                plr.Character:SetPrimaryPartCFrame(retu.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-6))
                local clo = scp.ClickDetector.Sound:Clone()
                clo.Parent = plr.Character.Head
                clo:Play()
                game.Debris:AddItem(clo,clo.TimeLength)
                retu.Character.Humanoid:TakeDamage(10000000)
                wait(1)
                plr.Character:SetPrimaryPartCFrame(origin)
            end
        else
            plr:Kick("NOOOOOO EXPLOITING")
        end
    end)
end