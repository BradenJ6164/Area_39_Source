return function(scp)
    scp.Union.ClickDetector.MouseClick:Connect(function(p)
        if p.Character:FindFirstChild("SCP-1025") then return end
        local h = 30
        if p.Character.Head:FindFirstChild("Cough") then
        else
            local val = Instance.new("BoolValue",p.Character)
            val.Name = "SCP-1025"
            local s = Instance.new("Sound")
            s.Name = "Cough"
            s.Parent = p.Character.Head
            s.Volume = 3
            s.SoundId = "rbxassetid://271820055"
            s:Play()
            for i=1,10 do
                wait(0.5)
                if p.Character.Humanoid.Health <= 0 then
                    break
                end
                p.Character.Humanoid:TakeDamage(10)
            end


          
         end
            
    end)
end