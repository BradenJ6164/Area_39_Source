local module = {}

local RunService = game:GetService("RunService")
local Server = RunService:IsServer()

local Keybinds = _G.Area39:GetService("LiveKeybind")

local clickConnection

local remote


if not Server then
    remote = game.ReplicatedStorage.Remotes:WaitForChild("Authorize")
    game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
        char.ChildAdded:Connect(function(c)
            if c:IsA("Tool") and c.Name == "Authorize" then
                Keybinds({[Enum.UserInputType.MouseButton1] = "Use",[Enum.KeyCode.E] = "Interaction"})
                clickConnection = c.Activated:Connect(function()
                    local target = game.Players.LocalPlayer:GetMouse().Target
                    if target.Parent:FindFirstChild("Humanoid") then
                        local hum = target.Parent:FindFirstChild("Humanoid")
                        if game.Players:GetPlayerFromCharacter(hum.Parent) then
                            local plr = game.Players:GetPlayerFromCharacter(hum.Parent) 
                            if plr.Guilty.Value == false then
                                remote:FireServer(plr)
                            end
                        end
                    end
                end)
            end
        end)
        char.ChildRemoved:Connect(function(c)
            if c:IsA("Tool") and c.Name == "Authorize" then
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
    remote.Name = "Authorize"

    remote.OnServerEvent:Connect(function(plr,targetPlr)
        if plr.Character:FindFirstChildWhichIsA("Tool") and plr.Character:FindFirstChildWhichIsA("Tool").Name == "Authorize" and targetPlr.Team.Name == "Class D" then
            if targetPlr.Guilty.Value == false then
                if targetPlr.Character:FindFirstChild("Authorized") then
                    targetPlr.Character.Authorized:Destroy()
                    targetPlr.Character.Head.BillboardGui.Authorized.Visible = false
                else
                    targetPlr.Character.Head.BillboardGui.Authorized.Visible = true
                    targetPlr.Character.Head.BillboardGui.KillSight.Visible = false
                    local val = Instance.new("BoolValue",targetPlr.Character)
                    val.Name = "Authorized"
                end
            end
        end
    end)
end


return module