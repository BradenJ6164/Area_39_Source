local lastFires = {}

local UserInput = game:GetService("UserInputService")

local Keybinds = _G.Area39:GetService("LiveKeybind")
local TweenService = game:GetService("TweenService")

local IsServer = game:GetService("RunService"):IsServer()

local Region3 = _G.Area39:GetService("RegionAPI")
local ControlRoomRegion
if IsServer then
    ControlRoomRegion = Region3.createRegion3FromPart(
                            game.Workspace.Map.ControlRoom)

    game.Workspace.Map.ControlRoom:Destroy()
end
local Trajectory = _G.Area39:GetService("Trajectory").new(
                       Vector3.new(0, -0.001, 0))

local Glass = {"1565824613", "1565825075"}
local Metal = {
    "282954522", "282954538", "282954576", "1565756607", "1565756818"
}
local Grass = {"1565830611", "1565831129", "1565831468", "1565832329"}
local Wood = {"287772625", "287772674", "287772718", "287772829", "287772902"}
local Concrete = {
    "287769261", "287769348", "287769415", "287769483", "287769538"
}
local Explosion = {
    "287390459", "287390954", "287391087", "287391197", "287391361",
    "287391499", "287391567"
}
local Cracks = {"342190504", "342190495", "342190488", "342190510"} -- Bullet Cracks
local Hits = {"363818432", "363818488", "363818567", "363818611", "363818653"} -- Player
local Whizz = {"342190005", "342190012", "342190017", "342190024"} -- Bullet Whizz

local ignoreTable = {}

local morphTable = {}
game.Workspace.DescendantAdded:Connect(function(c)
    if c.Name == "Morph" then
        table.insert(morphTable,c)
    end
end)

function findFirstDescendants(object, name)
    for i, v in pairs(object:GetDescendants()) do
        if v.Name == name then return v end
    end
end

function handleServer(plr, tool, clickPos, contacts)

    local gunSettings = require(tool:FindFirstChild("Settings"))
    if clickPos == "Reload" then
        gunSettings['Reloading'] = true
        if gunSettings['CurrentAmmo'] <= 0 then
            wait(gunSettings["ReloadSpeed"])
            gunSettings['CurrentAmmo'] = gunSettings['ClipSize']
            gunSettings['Reloading'] = false
        end
        return
    end

    if gunSettings['CurrentAmmo'] > 0 then
        if plr.Team.Name == game.Teams['Class D'].Name then
            plr.Guilty.Value = true
            plr.Character.Head.BillboardGui.KillSight.Visible = true
            plr.Character.Head.BillboardGui.Authorized.Visible = false
            if plr.Character:FindFirstChild("Authorized") then
                plr.Character:FindFirstChild("Authorized"):Destroy()
            end
        end
        gunSettings['CurrentAmmo'] = gunSettings['CurrentAmmo'] - 1
        for i, v in pairs(game.Players:GetPlayers()) do
            if v.Name ~= plr.Name then
                game.ReplicatedStorage.Remotes.Gun:FireClient(v, tool, clickPos)
            end
        end

        for i, v in next, contacts do
            if v[1] then
                local sound = Instance.new("Sound", v[1])
                sound.MaxDistance = 100
                sound.EmitterSize = 20
                sound.Volume = 0.2
                if v[1].Material == Enum.Material.Metal or v[1].Material ==
                    Enum.Material.DiamondPlate or v[1].Material ==
                    Enum.Material.CorrodedMetal then
                    sound.SoundId = "rbxassetid://" ..
                                        Metal[math.random(1, #Metal)]
                elseif v[1].Material == Enum.Material.Concrete or v[1].Material ==
                    Enum.Material.Cobblestone or v[1].Material ==
                    Enum.Material.Rock then
                    sound.SoundId = "rbxassetid://" ..
                                        Concrete[math.random(1, #Concrete)]
                elseif v[1].Material == Enum.Material.Wood or v[1].Material ==
                    Enum.Material.WoodPlanks then
                    sound.SoundId = "rbxassetid://" ..
                                        Wood[math.random(1, #Wood)]
                elseif v[1].Material == Enum.Material.Grass then
                    sound.SoundId = "rbxassetid://" ..
                                        Grass[math.random(1, #Grass)]
                else
                    sound.SoundId = "rbxassetid://" ..
                                        Hits[math.random(1, #Hits)]
                end
                sound:Play()
                game.Debris:AddItem(sound, sound.TimeLength)

                function doDamage(hum, amnt)

                    local canDamage = false
                    local target = game.Players:GetPlayerFromCharacter(
                                       hum.Parent)
                    if target then

                        -- local ray = Ray.new(plr.Character.HumanoidRootPart.Position,(plr.Character.HumanoidRootPart.Position-hum.Parent.HumanoidRootPart.Position))
                        -- local hit = workspace:FindPartOnRayWithIgnoreList(ray,{plr.Character,hum.Parent,workspace.Interactables})
                        -- if hit then return false end
                        
                        if target.Team.Name == "Chaos Insurgency" and
                            plr.Team.Name ~= "Chaos Insurgency" then
                            canDamage = true
                        end
                        if target.Team.Name == "Class D" and target.Guilty.Value ==
                            true then canDamage = true end
                        if plr.Team.Name == "Chaos Insurgency" or plr.Team.Name ==
                            "Class D" then
                            canDamage = true
                        end
                        if plr.Team.Name == target.Team.Name then
                            canDamage = false
                        end
                        local foundPlr
                        local foundTarget

                        for i, v in pairs(
                                        Region3.getPlayersInRegion(
                                            ControlRoomRegion)) do
                            if v.Name == target.Name then
                                foundTarget = true
                            elseif v.Name == plr.Name then
                                foundPlr = true
                            end
                        end
                        if foundPlr and foundTarget then
                            canDamage = true
                        end

                        if canDamage then
                            if hum.Health > 0 then
                                hum:TakeDamage(amnt)
                                if hum.Health <= 0 then
                                    plr.Stats.Kills.Value =
                                        plr.Stats.Kills.Value + 1
                                end
                            end
                        else
                            _G.Area39:SendSnackBar(plr,
                                                   "This player is innocent. Do not randomkill!")
                        end

                    end
                end
                local damage = gunSettings['Damage']

                if v[1].Parent:FindFirstChild("Humanoid") then
                    if string.find(v[1].Name, "Head") then
                        damage = damage * gunSettings['CriticalMultiplier']
                    end
                    doDamage(v[1].Parent.Humanoid, damage)
                end

                pcall(function()
                    if v[1].Parent.Parent:FindFirstChild("Humanoid") then

                        doDamage(v[1].Parent.Parent.Humanoid, damage)
                    end
                end)
                pcall(function()
                    if v[1].Parent.Parent.Parent:FindFirstChild("Humanoid") then

                        doDamage(v[1].Parent.Parent.Parent.Humanoid, damage)
                    end
                end)
            end

        end
    end
end

function drawClient(tool, clickPos, bypass)

    if not tool:FindFirstChild("BPoint") then return end
    local gunSettings = require(tool:FindFirstChild("Settings"))
    if findFirstDescendants(tool, "Fire") then
        findFirstDescendants(tool, "Fire"):Play()
    end
    if findFirstDescendants(tool, "Flash") then
        findFirstDescendants(tool, "Flash"):Emit(15)
    end
    if findFirstDescendants(tool, "FlashFX") then
        findFirstDescendants(tool, "FlashFX").Enabled = true
        delay(0.01, function()
            findFirstDescendants(tool, "FlashFX").Enabled = false
        end)
    end
    if not bypass then
        if UserSettings():GetService("UserGameSettings").SavedQualityLevel.Value <
            2 then return end
    end
    local offset = Vector3.new(math.random(-gunSettings['Spread'] * 5,
                                           gunSettings['Spread'] * 5),
                               math.random(-gunSettings['Spread'] * 5,
                                           gunSettings['Spread'] * 5),
                               math.random(-gunSettings['Spread'] * 5,
                                           gunSettings['Spread'] * 5))
                                           ignoreTable = {}
    local dir =
        ((clickPos.p - tool:FindFirstChild("BPoint").Position) + offset / 45).Unit *
            gunSettings['Power']

    table.insert(ignoreTable, tool.Parent)
    
    for i,v in pairs(morphTable) do
        table.insert(ignoreTable,v)
    end
    --[[local ray = Ray.new(tool:FindFirstChild("BPoint").Position, dir)
    local hit, pos, normal = game.Workspace:FindPartOnRayWithIgnoreList(ray,
                                                                        ignoreTable)

    if pos and normal and tool:FindFirstChild("BPoint") then
        local part = Instance.new("Part")
        part.Transparency = 1
        part.CanCollide = false
        part.Anchored = true
        part.Size = Vector3.new(1,1,1)
        part.Parent = workspace.CurrentCamera
        part.Position = pos

        local attach0 = Instance.new("Attachment",tool.BPoint)
        local attach1 = Instance.new("Attachment",part)
        attach0.Position = Vector3.new(0,0,0)
        attach1.Position = Vector3.new(0,0,0)

      

        local beam = Instance.new("Beam",tool.BPoint)
        beam.Width0 = 0.1
        beam.Width1 = 0.1

        beam.Transparency = NumberSequence.new(1,0.5,0.4,0.3,0.2,0.1)
        beam.Color = ColorSequence.new(Color3.new(200, 200, 200))
        
        beam.Attachment0 = attach0
        beam.Attachment1 = attach1

        game.Debris:AddItem(attach0,0.05)
        game.Debris:AddItem(attach1,0.05)

        game.Debris:AddItem(beam,0.05)


        local smoke = script.BarrelParticle:Clone()
        smoke.Parent = workspace.CurrentCamera
        smoke.CFrame = CFrame.new(pos, normal)
        smoke.ParticleEmitter:Emit(40)
        game.Debris:AddItem(smoke, 1.5)

    end]]

    local path, contacts = Trajectory:Cast(
                               tool:FindFirstChild("BPoint").Position, (dir),
                               Enum.Material.Concrete, ignoreTable)
    if path then Trajectory:Draw(path) end
    return contacts
end

if IsServer then
    game.ReplicatedStorage.Remotes.Gun.OnServerEvent:Connect(handleServer)
    return {}
else
    game.ReplicatedStorage.Remotes.Gun.OnClientEvent:Connect(drawClient)

end
local UserGameSettings = UserSettings():GetService("UserGameSettings")
return function(gunSettings, tool)
    if IsServer then return end
    local mouseLockEvent = game.Players.LocalPlayer.PlayerScripts.PlayerModule
                               .CameraModule.toggleMouseLock
    local equipped = false
    local firing = false
    local lock = false
    local reloading = false
    local isOts = false
    local isAiming = false
    local horizontalOffset = 2
    repeat
        wait()
    until game.Players.LocalPlayer.Character
    repeat
        wait()
    until game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    repeat
        wait()
    until game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):IsDescendantOf(workspace)
    local neck, waist = game.Players.LocalPlayer.Character:WaitForChild("Head")
                            :WaitForChild("Neck"),
                        game.Players.LocalPlayer.Character:WaitForChild(
                            "UpperTorso").Waist
    local lShoulder, rShoulder =
        game.Players.LocalPlayer.Character:WaitForChild("LeftUpperArm")
            .LeftShoulder, game.Players.LocalPlayer.Character:WaitForChild(
            "RightUpperArm").RightShoulder
    local lDefault, rDefault = lShoulder.C0, rShoulder.C0
    local defaultNeck, defaultWaist = neck.C0, waist.C0

    local mouse = game.Players.LocalPlayer:GetMouse()
    local holdAnimation = game:GetService("Players").LocalPlayer.Character
                              .Humanoid:LoadAnimation(
                              game.ReplicatedStorage.GunHold)
    local runCon
    local con2, con3
    local cam = workspace.CurrentCamera
    tool.Equipped:Connect(function()
        equipped = true
        Keybinds({
            [Enum.UserInputType.MouseButton1] = "Fire",
            [Enum.KeyCode.R] = "Reload",
            [Enum.KeyCode.E] = "Interaction",
            [Enum.KeyCode.T] = "Toggle OTS"
        })
        gunSettings['IdleAnim'] = game:GetService("Players").LocalPlayer
                                      .Character.Humanoid:LoadAnimation(
                                      tool:FindFirstChild("RifleHoldAnimation") or
                                          tool:FindFirstChild(
                                              "PistolHoldAnimation"))
        gunSettings['IdleAnim']:Play()

        rShoulder.C0 = rDefault
        lShoulder.C0 = lDefault

        neck.C0 = defaultNeck
        waist.C0 = defaultWaist
        game.Players.LocalPlayer:GetMouse().Icon = "rbxassetid://2775556531"
        if isOts then
            UserInput.MouseIconEnabled = false
            game.Players.LocalPlayer.CameraMinZoomDistance = 2
            Keybinds({
                [Enum.UserInputType.MouseButton2] = "Aim",
                [Enum.UserInputType.MouseButton1] = "Fire",
                [Enum.KeyCode.R] = "Reload",
                [Enum.KeyCode.E] = "Interaction",
                [Enum.KeyCode.T] = "Toggle OTS"
            })
            mouseLockEvent.Offset.Value = 0
            
    
            mouseLockEvent:Fire(false, Vector3.new(horizontalOffset, 0, 0))
            UserGameSettings.RotationType = Enum.RotationType.MovementRelative
        end

    end)
    tool.Unequipped:Connect(function()
        equipped = false
        firing = false
        
        if gunSettings['IdleAnim'] then gunSettings['IdleAnim']:Stop() end
        if gunSettings['ReloadAnim'] then
            gunSettings['ReloadAnim']:Stop()
        end
        holdAnimation:Stop()
        isAiming = false
        
        
        mouseLockEvent.Offset.Value = 0

        mouseLockEvent:Fire(false, Vector3.new(horizontalOffset, 0, 0))
        game.Players.LocalPlayer:GetMouse().Icon = ""
        Keybinds({[Enum.KeyCode.E] = "Interaction"})

        waist.C0 = defaultWaist
        rShoulder.C0 = rDefault
        lShoulder.C0 = lDefault
        neck.C0 = defaultNeck
        UserInput.MouseIconEnabled = true
        game.Players.LocalPlayer.CameraMinZoomDistance = 0.5
      
    end)
    tool.Changed:Connect(function()
        if not tool:IsDescendantOf(workspace) and not tool:IsDescendantOf(game.Players) then
            runCon:Disconnect()
        end
    end)

    runCon = game:GetService("RunService").RenderStepped:Connect(function()
        if isOts and equipped then

            if isAiming and game.Players.LocalPlayer.Character and
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                game.Players.LocalPlayer.Character:FindFirstChild(
                    "HumanoidRootPart") and lShoulder and rShoulder then
                local angle = math.asin(mouse.Hit.LookVector.Y)
                local torsoAngle = angle / 2
                local armAngle = angle - torsoAngle
                waist.C0 = defaultWaist * CFrame.Angles(torsoAngle, math.rad(0), 0)
                rShoulder.C0 = rDefault * CFrame.Angles(armAngle, 0, 0)
                lShoulder.C0 = lDefault * CFrame.Angles(armAngle, 0, 0)
                neck.C0 = defaultNeck * CFrame.Angles(armAngle, 0, 0)
                UserGameSettings.RotationType = Enum.RotationType.CameraRelative
                    elseif game.Players.LocalPlayer.Character and
                    game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and
                    game.Players.LocalPlayer.Character:FindFirstChild(
                        "HumanoidRootPart") and lShoulder and rShoulder then
                local angle = math.asin(mouse.Hit.LookVector.Y)
                local torsoAngle = angle / 2
                local armAngle = angle - torsoAngle
                waist.C0 = defaultWaist * CFrame.Angles(torsoAngle, math.rad(0), 0)
                rShoulder.C0 = rDefault * CFrame.Angles(armAngle, 0, 0)
                lShoulder.C0 = lDefault * CFrame.Angles(armAngle, 0, 0)
                neck.C0 = defaultNeck * CFrame.Angles(armAngle, 0, 0)
             
                UserGameSettings.RotationType = Enum.RotationType.MovementRelative
            end
            mouseLockEvent:Fire(true,
                                Vector3.new(mouseLockEvent.Offset.Value, 0, 0))
             
        end
    end)

    con2 = UserInput.InputBegan:Connect(function(iobj, s)
        if s then return end
        if not equipped then return end
       
            if iobj.UserInputType == Enum.UserInputType.MouseButton2 and isOts then
                isAiming = true
                if isOts then
                    UserInput.MouseIconEnabled = true
                end
                holdAnimation:Play()
                gunSettings['IdleAnim']:Stop()
                TweenService:Create(mouseLockEvent.Offset, TweenInfo.new(0.1),
                                    {Value = 2}):Play()
                                    UserGameSettings.RotationType = Enum.RotationType.CameraRelative
            end
            
            if iobj.UserInputType == Enum.UserInputType.MouseButton1 then
                
                if iobj.UserInputState == Enum.UserInputState.Begin then
                    if isOts then
                        if not isAiming then return end
                    end
                    firing = true
                    while firing do
                        if game.Players.LocalPlayer.Character.Humanoid.Health <=
                            0 then return end
                        gunSettings['KickBackAnim'] =
                            game:GetService("Players").LocalPlayer.Character
                                .Humanoid:LoadAnimation(
                                tool:FindFirstChild("RifleKickBackAnimation") or
                                    tool:FindFirstChild(
                                        "PistolKickBackAnimation"))

                        if gunSettings['CurrentAmmo'] > 0 and
                            not gunSettings['Reloading'] and not lock and
                            game.Players.LocalPlayer.Character.Humanoid
                                .WalkSpeed <= 26 then
                            lock = true

                            for i = 1, (gunSettings['FireCount'] or 1) do
                                gunSettings['KickBackAnim']:Play()
                                local contacts =
                                    drawClient(tool,
                                               game.Players.LocalPlayer:GetMouse()
                                                   .Hit, true)
                                game.ReplicatedStorage.Remotes.Gun:FireServer(
                                    tool,
                                    game.Players.LocalPlayer:GetMouse().Hit,
                                    contacts)
                                    for i,v in pairs(contacts) do
                                        if v[1].Parent:FindFirstChildWhichIsA("Humanoid") or v[1].Parent.Parent:FindFirstChildWhichIsA("Humanoid") then
                                            game.Players.LocalPlayer.PlayerGui.HitMark:Play()
                                        end
                                    end
                            end
                            gunSettings['CurrentAmmo'] =
                                gunSettings['CurrentAmmo'] - 1

                        else
                            firing = false
                            break
                        end

                        wait(60 / gunSettings['FireRate'])
                        lock = false
                        if not gunSettings['Automatic'] then
                            break
                        end
                    end
                else
                    firing = false
                end
            elseif iobj.KeyCode == Enum.KeyCode.R and not reloading then

                reloading = true
                if findFirstDescendants(tool, "Reload") then
                    findFirstDescendants(tool, "Reload"):Play()
                end
                gunSettings['ReloadAnim'] =
                    game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(
                        tool:FindFirstChild("ReloadAnimation"))
                gunSettings['ReloadAnim']:Play()
                gunSettings['Reloading'] = true
                game.ReplicatedStorage.Remotes.Gun:FireServer(tool, "Reload")
                wait(gunSettings['ReloadSpeed'])
                gunSettings['Reloading'] = false
                gunSettings['CurrentAmmo'] = gunSettings['ClipSize']
                reloading = false
            end
    
    end)
    con3 = UserInput.InputEnded:Connect(function(iobj, s)
        if s then return end
        if not equipped then return end
        if iobj.UserInputType == Enum.UserInputType.MouseButton1 then
            if iobj.UserInputState == Enum.UserInputState.End then
                firing = false

            end
        end
        if iobj.UserInputType == Enum.UserInputType.MouseButton2 then
            isAiming = false
            if isOts then
             UserInput.MouseIconEnabled = false
            end
            holdAnimation:Stop()
            gunSettings['IdleAnim']:Play()
            UserGameSettings.RotationType = Enum.RotationType.MovementRelative
            TweenService:Create(mouseLockEvent.Offset,TweenInfo.new(0.1),{Value = 0}):Play()
        end
        if iobj.KeyCode == Enum.KeyCode.T then
            isOts = not isOts
            if isOts then
                
                game.Players.LocalPlayer.CameraMinZoomDistance = 2
                Keybinds({
                    [Enum.UserInputType.MouseButton2] = "Aim",
                    [Enum.UserInputType.MouseButton1] = "Fire",
                    [Enum.KeyCode.R] = "Reload",
                    [Enum.KeyCode.E] = "Interaction",
                    [Enum.KeyCode.T] = "Toggle OTS"
                })
                mouseLockEvent.Offset.Value = 0
                
                UserInput.MouseIconEnabled = false
                mouseLockEvent:Fire(false, Vector3.new(horizontalOffset, 0, 0))
                UserGameSettings.RotationType = Enum.RotationType.MovementRelative
            else
                UserInput.MouseIconEnabled = true
                game.Players.LocalPlayer.CameraMinZoomDistance = 0.5

                waist.C0 = defaultWaist
                rShoulder.C0 = rDefault
                lShoulder.C0 = lDefault
                neck.C0 = defaultNeck
                mouseLockEvent.Offset.Value = 0

                mouseLockEvent:Fire(false, Vector3.new(horizontalOffset, 0, 0))
                Keybinds({
                    [Enum.UserInputType.MouseButton1] = "Fire",
                    [Enum.KeyCode.R] = "Reload",
                    [Enum.KeyCode.E] = "Interaction",
                    [Enum.KeyCode.T] = "Toggle OTS"
                })
                UserGameSettings.RotationType = Enum.RotationType.MovementRelative

            end
        end
    end)
    
end

