return function(scp)
    scp.Touch.Touched:Connect(function(p)
        if p.Parent:FindFirstChild("SCP-472") then return end
        
        if p.Parent:FindFirstChild("Humanoid") then
            local val = Instance.new("BoolValue",p.Parent)
            val.Name = "SCP-472"
            for i=1,5 do
                wait(5)
                p.Parent.Humanoid:TakeDamage(20)
            end
        end
    end)
end