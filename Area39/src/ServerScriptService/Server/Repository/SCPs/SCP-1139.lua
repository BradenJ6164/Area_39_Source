return function(scp)
    scp.Toucher.Touched:Connect(function(c)
        if c.Parent:FindFirstChild("Humanoid") and not c.Parent:FindFirstChild("SCP-1139") then
            local val = Instance.new("BoolValue",c.Parent)
            val.Name = "SCP-1139"
            for i=1,10 do
                wait(4)
                c.Parent.Humanoid:TakeDamage(9)
                game.Chat:Chat(c.Parent.Head,game.HttpService:GenerateGUID())
            end
            c.Parent.Humanoid:TakeDamage(1000)
        end
    end)
end