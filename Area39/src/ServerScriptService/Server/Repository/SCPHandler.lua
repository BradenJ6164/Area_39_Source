-- DrBaja/Braden_J
local LastUpdate = tick()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local registeredSCPs = {}

local attackFunctions = {}

local module = {}



function findFirstDescendants(object, name)
    for i, v in pairs(object:GetDescendants()) do
        if v.Name == name then return v end
    end
end

function getNearestPlayer(pos)
    local range = 60
    local plr = nil
    for i, v in pairs(Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local mag = (pos - v.Character.HumanoidRootPart.Position).Magnitude
            if mag <= range then
                range = mag
                plr = v
            end
        end
    end
    return plr
end

local function recurse(r)
    for i,v in pairs(r:GetChildren()) do
        if v:IsA("Folder") then
            recurse(v)
        elseif v:IsA("Model") then
           
                
          pcall(function()
            if _G.Area39:GetService(v.Name) then
               spawn(function()
                _G.Area39:GetService(v.Name)(v)
               end) 
            end
          end)
         
          if v:FindFirstChildWhichIsA("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= "SCP-999" then
            for i,x in pairs(v:GetChildren()) do
                if x:IsA("BasePart") then
                   
                    x.Touched:Connect(function(t)
                      
                        if not t.Parent:FindFirstChild("Humanoid") then return end
                        if attackFunctions[v.Name] then
                            attackFunctions[v.Name](v,t.Parent.Humanoid)
                        else
                            t.Parent.Humanoid:TakeDamage(20)
                        end
                        if findFirstDescendants(v, "AttackSound") then
                            findFirstDescendants(v, "AttackSound"):Play()
                        end
        
                    end)
                end
            end
            
              
          end
            
       
            table.insert(registeredSCPs,v)
        end
    end
end
recurse(game.Workspace.SCPs)


function module:RegisterSCP(scp) 
    
    if scp:FindFirstAncestorWhichIsA("Humanoid") and scp:FindFirstChild("HumanoidRootPart") and scp.Name ~= "SCP-999" then
        for i,x in pairs(scp:GetChildren()) do
            if x:IsA("BasePart") then
                x.Touched:Connect(function(t)
                    print(t)
                    if not t.Parent:FindFirstChild("Humanoid") then return end
                    if attackFunctions[scp.Name] then
                        attackFunctions[scp.Name](scp,t.Parent.Humanoid)
                    else
                        t.Parent.Humanoid:TakeDamage(20)
                    end
                    if findFirstDescendants(scp, "AttackSound") then
                        findFirstDescendants(scp, "AttackSound"):Play()
                    end
    
                end)
            end
        end
    end
    table.insert(registeredSCPs, scp) end
RunService.Heartbeat:Connect(function()
    if math.abs(LastUpdate - tick()) >= .1 then
        LastUpdate = tick()

        for i, scp in next, registeredSCPs do
            spawn(function()
                if scp:FindFirstChildWhichIsA("Humanoid") and scp:FindFirstChild("HumanoidRootPart")  then
                    
                    local hum = scp:FindFirstChildWhichIsA("Humanoid")
                    local nearest = getNearestPlayer(
                                        scp:FindFirstChild("HumanoidRootPart").Position)
                    if nearest then
                        scp.HumanoidRootPart:SetNetworkOwner(nearest)
                        hum:MoveTo(nearest.Character.HumanoidRootPart.Position)
                        -- if (nearest.Character.HumanoidRootPart.Position -
                        --     scp:FindFirstChild("HumanoidRootPart").Position).Magnitude <=
                        --     1.5  and scp.Name ~= "SCP 999" then
                        --     if attackFunctions[scp.Name] then
                        --         attackFunctions[scp.Name](scp, nearest)
                        --     else
                        --         nearest.Character:FindFirstChild("Humanoid")
                        --             :TakeDamage(100000)
                        --     end
                        --     if findFirstDescendants(scp, "AttackSound") then
                        --         findFirstDescendants(scp, "AttackSound"):Play()
                        --     end
                        -- end
                    else
                        scp.HumanoidRootPart:SetNetworkOwner(nil)
                        hum:MoveTo(
                            scp:FindFirstChild("HumanoidRootPart").Position)
                    end

                end
            end)
        end
    end
end)

return module
