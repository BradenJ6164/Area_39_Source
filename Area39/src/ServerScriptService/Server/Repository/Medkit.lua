local module = {}

local lastHeals = {}

local RunService = game:GetService("RunService")
local Server = RunService:IsServer()

local Keybinds = _G.Area39:GetService("LiveKeybind")

local clickConnection

local remote


if not Server then
    remote = game.ReplicatedStorage.Remotes:WaitForChild("Medkit")
    game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
        char.ChildAdded:Connect(function(c)
            if c:IsA("Tool") and c.Name == "Medkit" then
                Keybinds({[Enum.UserInputType.MouseButton1] = "Use",[Enum.KeyCode.E] = "Interaction"})
                clickConnection = c.Activated:Connect(function()
                    remote:FireServer()       
                end)
            end
        end)
        char.ChildRemoved:Connect(function(c)
            if c:IsA("Tool") and c.Name == "Medkit" then
                if clickConnection then
                    clickConnection:Disconnect()
                    Keybinds({[Enum.KeyCode.E] = "Interaction"})
                    clickConnection = nil
                end
            end
        end)
    end)
else
    remote = Instance.new("RemoteEvent",game.ReplicatedStorage.Remotes)
    remote.Name = "Medkit"

    remote.OnServerEvent:Connect(function(plr)
        if plr.Character:FindFirstChildWhichIsA("Tool") and plr.Character:FindFirstChildWhichIsA("Tool").Name == "Medkit" then
            if not lastHeals[plr] then
                lastHeals[plr] = tick()
            end
            if math.abs(lastHeals[plr] - tick()) >= 2 then
                lastHeals[plr] = tick()
                for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                    pcall(function()
                        if (v.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 12 then
                            v.Character.Humanoid.Health = v.Character.Humanoid.Health + 20
                            script.Particles:Clone().Parent = v.Character.HumanoidRootPart
                            v.Character.HumanoidRootPart.Particles:Emit(25)
                            game.Debris:AddItem(v.Character.HumanoidRootPart.Particles,1)
                        end
                    end)
                end
            end
        end
    end)
end


return module