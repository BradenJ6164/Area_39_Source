local module = {}

local RunService = game:GetService("RunService")
local IsServer = RunService:IsServer()

local lastInvis = {}

local Remote
if not IsServer then
    Remote = game.ReplicatedStorage.Remotes:WaitForChild("Invisible")
end
if not IsServer then -- Client
    game.Players.LocalPlayer.CharacterAdded:Connect(
        function(char)
            char.ChildAdded:Connect(function(c)
                if c:IsA("Tool") and c.Name == "Invisible" then
                    Remote:FireServer(true)
                end
            end)
            char.ChildRemoved:Connect(function(c)
                if c:IsA("Tool") and c.Name == "Invisible" then
                    Remote:FireServer(false)
                end
            end)
        end)
else
    Remote = Instance.new("RemoteEvent", game.ReplicatedStorage.Remotes)
    Remote.Name = "Invisible"

    Remote.OnServerEvent:Connect(function(plr, val)
        if val then
            if not lastInvis[plr] then
                lastInvis[plr] = tick()-21
            end
            if math.abs(lastInvis[plr]-tick()) >= 5 then
                lastInvis[plr] = tick()
                plr.Character.Head.BillboardGui.Enabled = false
                if plr.Character:FindFirstChild("Invisible") then
                    for i, v in pairs(plr.Character:GetDescendants()) do
                        if v:IsA("BasePart") then

                            local val = Instance.new("IntValue", v)
                            val.Name = "OriginTransparency"
                            val.Value = v.Transparency
                            v.Transparency = 1
                        elseif v:IsA("Decal") then
                            v.Transparency = 1
                        end
                    end
                
                
                end
            else
                _G.Area39:SendSnackBar(plr,"You're using invisibilty to often, please wait 5 seconds.")
            end
        else
            plr.Character.Head.BillboardGui.Enabled = true
            for i, v in pairs(plr.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    if v:FindFirstChild("OriginTransparency") then
                        v.Transparency =
                            v:FindFirstChild("OriginTransparency").Value
                        v:FindFirstChild("OriginTransparency"):Destroy()
                    
                       

                    end
                elseif v:IsA("Decal") then
                    v.Transparency = 0
                end
            end
        end
    end)
end

return module
