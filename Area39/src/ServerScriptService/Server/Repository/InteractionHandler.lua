-- DrBaja/Braden_J
local module = {}

local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")

function setDoorCollision(door, value)
    for i, v in pairs(door.Scripted:GetDescendants()) do
        if v:IsA("BasePart") then v.CanCollide = value end
    end
end
function findFirstDescendants(object, name)
    for i, v in pairs(object:GetDescendants()) do
        if v.Name == name and not v:IsA("BoolValue") then return v end
    end
end

local types = {
    ['Vending Machine'] = function(plr, obj, settings)
        if obj.Debounce.Value == false then
            obj.Debounce.Value = true
            delay(2, function() obj.Debounce.Value = false end)
            local ranItem =
                settings['Items'][math.random(1, #settings['Items'])]

            if game.ServerStorage.Tools:FindFirstChild(ranItem) then
                game.ServerStorage.Tools:FindFirstChild(ranItem):Clone().Parent =
                    plr.Backpack
                if findFirstDescendants(obj, "Vend") then
                    findFirstDescendants(obj, "Vend"):Play()
                end
            end
        end
    end
}

if runService:IsServer() then

    game.ReplicatedStorage.Remotes.InteractReplicate.OnServerEvent:Connect(
        function(plr, obj)

            local settings = obj:FindFirstChildWhichIsA("ModuleScript")
            if settings then

                settings = require(settings)
                local mag = (plr.Character.HumanoidRootPart.Position -
                                obj:FindFirstChildWhichIsA("BasePart").Position).magnitude
                if mag <= 20 then

                    if types[settings['Type']] then

                        types[settings['Type']](plr, obj, settings)
                    end
                end
            end
        end)
end

function module:GetNearestDoor(radius, pos, directory)

    if not directory then directory = game.Workspace.Interactables end
    local returning = nil
    for i, v in pairs(directory:GetChildren()) do
        if v:FindFirstChildWhichIsA("BasePart") and
            v:FindFirstChildWhichIsA("ModuleScript") then

            local mag =
                (v:FindFirstChildWhichIsA("BasePart").Position - pos).magnitude
            if mag < radius then
                radius = mag
                returning = v
            end

        end
    end
    return returning
end

function module:DoClient(door, plr, bypass, bypassClearance)
    if not door then return end
    if runService:IsServer() then

        local settings = door:FindFirstChildWhichIsA("ModuleScript")

        if settings then
            settings = require(settings)

            if settings['Type'] == "Swing Door" then
                local mag = (settings['Tweener'].Position -
                                plr.Character.HumanoidRootPart.Position).magnitude
                if mag >= 18 then return end

                if plr.Clearance.Value < settings['Clearance'] then
                    if settings['Clearance'] <= 4 then
                        -- game:GetService("MarketplaceService"):PromptProductPurchase(plr,1075161296)
                    else
                        -- game:GetService("MarketplaceService"):PromptProductPurchase(plr,1075161492)
                    end
                    return false
                end

                if door.Debounce.Value == false then

                    game.ReplicatedStorage.Remotes.DoorReplicate:FireAllClients(
                        door, plr, true, true)

                    local offset = settings['Tweener'].CFrame:ToObjectSpace(
                                       plr.Character.HumanoidRootPart.CFrame)
                    local OpenCF = nil
                    if offset.Z < 0 then
                        OpenCF = settings['OpenOutState']
                    else
                        OpenCF = settings['OpenInState']
                    end

                    door.Debounce.Value = true
                    if settings['AutoClose'] == true then

                        wait(settings['TweenTime'])
                        setDoorCollision(door, false)
                        settings['Tweener'].CFrame = OpenCF
                        wait(settings['AutoCloseTime'])
                        setDoorCollision(door, true)
                        settings['Tweener'].CFrame = settings['CloseState']

                        wait(settings['TweenTime'])

                        wait(0.2)
                    else
                        if door.Open.Value == true then
                            door.Open.Value = false
                            wait(settings['TweenTime'])
                            settings['Tweener'].CFrame = settings['CloseState']
                            setDoorCollision(door, true)
                            wait(0.2)
                        else
                            door.Open.Value = true
                            wait(settings['TweenTime'])
                            settings['Tweener'].CFrame = OpenCF
                            setDoorCollision(door, false)
                            wait(0.2)
                        end

                    end
                    wait(0.15)
                    door.Debounce.Value = false
                end
            end
        end
        return
    end
    plr = players.LocalPlayer

    local settings = door:FindFirstChildWhichIsA("ModuleScript")
    if settings then

        settings = require(settings)

        if plr.Clearance.Value < settings['Clearance'] and not bypass and
            not bypassClearance then
            if types[settings['Type']] then
                game.ReplicatedStorage.Remotes.InteractReplicate:FireServer(door)
                return true
                -- types[settings['Type']](door,settings)
            end
            if not door:FindFirstChildWhichIsA("BasePart") then
                return
            end
            if not findFirstDescendants(door, "Hinge") then return end
            if findFirstDescendants(door, "Deny") then
                findFirstDescendants(door, "Deny"):Play()
            end

            if settings['Clearance'] <= 4 then
                game:GetService("MarketplaceService"):PromptProductPurchase(plr,
                                                                            1075161296)
            else
                game:GetService("MarketplaceService"):PromptProductPurchase(plr,
                                                                            1075161492)
            end

            return false
        end
        game.ReplicatedStorage.Remotes.DoorReplicate:FireServer(door)
        if true then
            if findFirstDescendants(door, "Accept") then

                findFirstDescendants(door, "Accept"):Play()
            end
            if settings['Tweener'] ~= nil then
                local offset = settings['Tweener'].CFrame:ToObjectSpace(
                                   plr.Character.HumanoidRootPart.CFrame)

                if offset.Z < 0 then
                    OpenCF = settings['OpenOutState']
                else
                    OpenCF = settings['OpenInState']
                end

                if settings['AutoClose'] == true and door.Open.Value == false then
                    if findFirstDescendants(door, "Open") then
                        findFirstDescendants(door, "Open"):Play()
                    end
                    local tw = tweenService:Create(settings['Tweener'],
                                                   TweenInfo.new(
                                                       settings['TweenTime'],
                                                       Enum.EasingStyle.Quad,
                                                       Enum.EasingDirection
                                                           .InOut),
                                                   {CFrame = OpenCF})
                    tw:Play()

                    wait(settings['AutoCloseTime'])
                    if findFirstDescendants(door, "Close") then
                        findFirstDescendants(door, "Close"):Play()
                    end
                    local tw = tweenService:Create(settings['Tweener'],
                                                   TweenInfo.new(
                                                       settings['TweenTime'],
                                                       Enum.EasingStyle.Quad,
                                                       Enum.EasingDirection
                                                           .InOut), {
                        CFrame = settings['CloseState']
                    })
                    tw:Play()
                elseif settings['AutoClose'] == false then
                    if door.Open.Value == true then
                        local tw = tweenService:Create(settings['Tweener'],
                                                       TweenInfo.new(
                                                           settings['TweenTime'],
                                                           Enum.EasingStyle.Quad,
                                                           Enum.EasingDirection
                                                               .InOut), {
                            CFrame = settings['CloseState']
                        })
                        tw:Play()
                        if findFirstDescendants(door, "Close") then
                            findFirstDescendants(door, "Close"):Play()
                        end
                    else
                        local tw = tweenService:Create(settings['Tweener'],
                                                       TweenInfo.new(
                                                           settings['TweenTime'],
                                                           Enum.EasingStyle.Quad,
                                                           Enum.EasingDirection
                                                               .InOut),
                                                       {CFrame = OpenCF})
                        tw:Play()
                        if findFirstDescendants(door, "Open") then
                            findFirstDescendants(door, "Open"):Play()
                        end
                    end
                end
            end

        end
        return true
    end
end
if runService:IsClient() then
    game.ReplicatedStorage.Remotes.DoorReplicate.OnClientEvent:Connect(
        function(door, plr)
            if not door:FindFirstChildWhichIsA("ModuleScript") then
                return
            end
            if not findFirstDescendants(door, "Hinge") then return end
            local settings =
                require(door:FindFirstChildWhichIsA("ModuleScript"))
            if findFirstDescendants(door, "Accept") then

                findFirstDescendants(door, "Accept"):Play()
            end
            if settings['Tweener'] ~= nil then
                local offset = settings['Tweener'].CFrame:ToObjectSpace(
                                   plr.Character.HumanoidRootPart.CFrame)

                if offset.Z < 0 then
                    OpenCF = settings['OpenOutState']
                else
                    OpenCF = settings['OpenInState']
                end

                if settings['AutoClose'] == true and door.Open.Value == false then
                    if findFirstDescendants(door, "Open") then
                        findFirstDescendants(door, "Open"):Play()
                    end
                    local tw = tweenService:Create(settings['Tweener'],
                                                   TweenInfo.new(
                                                       settings['TweenTime'],
                                                       Enum.EasingStyle.Quad,
                                                       Enum.EasingDirection
                                                           .InOut),
                                                   {CFrame = OpenCF})
                    tw:Play()

                    wait(settings['AutoCloseTime'])
                    if findFirstDescendants(door, "Close") then
                        findFirstDescendants(door, "Close"):Play()
                    end
                    local tw = tweenService:Create(settings['Tweener'],
                                                   TweenInfo.new(
                                                       settings['TweenTime'],
                                                       Enum.EasingStyle.Quad,
                                                       Enum.EasingDirection
                                                           .InOut), {
                        CFrame = settings['CloseState']
                    })
                    tw:Play()
                elseif settings['AutoClose'] == false then
                    if door.Open.Value == true then
                        local tw = tweenService:Create(settings['Tweener'],
                                                       TweenInfo.new(
                                                           settings['TweenTime'],
                                                           Enum.EasingStyle.Quad,
                                                           Enum.EasingDirection
                                                               .InOut), {
                            CFrame = settings['CloseState']
                        })
                        tw:Play()
                        if findFirstDescendants(door, "Close") then
                            findFirstDescendants(door, "Close"):Play()
                        end
                    else
                        local tw = tweenService:Create(settings['Tweener'],
                                                       TweenInfo.new(
                                                           settings['TweenTime'],
                                                           Enum.EasingStyle.Quad,
                                                           Enum.EasingDirection
                                                               .InOut),
                                                       {CFrame = OpenCF})
                        tw:Play()
                        if findFirstDescendants(door, "Open") then
                            findFirstDescendants(door, "Open"):Play()
                        end
                    end
                end
            end
        end)
else
    game.ReplicatedStorage.Remotes.DoorReplicate.OnServerEvent:Connect(
        function(plr, door) module:DoClient(door, plr) end)
end

return module
