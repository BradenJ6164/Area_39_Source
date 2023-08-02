return function(scp)
    scp.Candle.Touched:Connect(function(c)
        if c.Parent:FindFirstChild("HumanoidRootPart") and not c.Parent.HumanoidRootPart:FindFirstChild("Fire") then
            local f = Instance.new("Fire")
            f.Parent = c.Parent.HumanoidRootPart
            f.Size = 5
            f.Heat = 5
            delay(5,function()
                c.Parent.Humanoid:TakeDamage(5000000)
            end)
        end
    end)
end