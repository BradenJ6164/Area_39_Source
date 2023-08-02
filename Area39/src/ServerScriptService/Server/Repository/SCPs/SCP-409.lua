return function(scp)
    scp.Touch.Touched:Connect(function(c)
        if c.Parent:FindFirstChild("Humanoid") then
            for i, v in pairs(c.Parent:GetChildren()) do
                if v:IsA("BasePart") then
                    v.BrickColor = BrickColor.new("Bright blue")
                end
            end
            delay(5, function()
                if c.Parent:FindFirstChild("Humanoid") then
                    c.Parent.Humanoid:TakeDamage(500000000)
                end
            end)
        end
    end)
end
