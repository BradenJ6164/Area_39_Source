-- / DrBaja/Braden_J
local lastFires = {}

local UserInput = game:GetService("UserInputService")

local Keybinds = _G.Area39:GetService("LiveKeybind")

local IsServer = game:GetService("RunService"):IsServer()

local Region3 = _G.Area39:GetService("RegionAPI")
local ControlRoomRegion 
if game:GetService("RunService"):IsServer() then
    ControlRoomRegion = Region3.createRegion3FromPart(game.Workspace.Map.ControlRoom)

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

function findFirstDescendants(object, name)
    for i, v in pairs(object:GetDescendants()) do
        if v.Name == name then return v end
    end
end


function handleServer(plr, tool, clickPos, contacts)
    if IsServer then
        local settings = require(tool:FindFirstChild("Settings"))
        if clickPos == "Reload" then
            settings['Reloading'] = true

            if settings['CurrentAmmo'] <= 0 then
                wait(settings['ReloadSpeed'])
                settings['CurrentAmmo'] = settings['ClipSize']
                settings['Reloading'] = false
            end

            return
        end
        if lastFires[plr] == nil then lastFires[plr] = tick() end

        if math.abs(lastFires[plr] - tick()) <= settings['FireRate'] / 65 and
            settings['CurrentAmmo'] > 0 then

            if plr.Team.Name == game.Teams['Class D'].Name then
                plr.Guilty.Value = true
                plr.Character.Head.BillboardGui.KillSight.Visible = true
                plr.Character.Head.BillboardGui.Authorized.Visible = false
                if plr.Character:FindFirstChild("Authorized") then
                    plr.Character:FindFirstChild("Authorized"):Destroy()
                end
            end
            lastFires[plr] = tick()
            settings['CurrentAmmo'] = settings['CurrentAmmo'] - 1
            for i, v in pairs(game.Players:GetPlayers()) do
                if v.Name ~= plr.Name then
                
                    game.ReplicatedStorage.Remotes.Gun:FireClient(v, tool,
                                                                  clickPos)
                end
            end
            
            for i, v in next, contacts do
                local sound = Instance.new("Sound",v[1])
                sound.MaxDistance = 100
                sound.EmitterSize = 20
                sound.Volume = 0.2
                if v[1].Material == Enum.Material.Metal or v[1].Material == Enum.Material.DiamondPlate or v[1].Material == Enum.Material.CorrodedMetal  then
                    sound.SoundId = "rbxassetid://" .. Metal[math.random(1,#Metal)]
                elseif v[1].Material == Enum.Material.Concrete or v[1].Material == Enum.Material.Cobblestone or v[1].Material == Enum.Material.Rock  then
                    sound.SoundId = "rbxassetid://" .. Concrete[math.random(1,#Concrete)]
                elseif v[1].Material == Enum.Material.Wood or v[1].Material == Enum.Material.WoodPlanks then
                    sound.SoundId = "rbxassetid://" .. Wood[math.random(1,#Wood)]
                elseif v[1].Material == Enum.Material.Grass then
                    sound.SoundId = "rbxassetid://" .. Grass[math.random(1,#Grass)]
                else
                    sound.SoundId = "rbxassetid://" .. Hits[math.random(1,#Hits)]
                end
                
                    function dodamage(hum,amnt)
                        local canDamage = true
                        local target = game.Players:GetPlayerFromCharacter(hum.Parent)
                        
                        if target then
                            if target.Team.Name == plr.Team.Name then canDamage = false end
                            if target.Team.Name == "Class D" then
                                if target.Guilty.Value == false then
                                    canDamage = false
                                end
                            end
                            if plr.Team.Name ~= "Class D" and plr.Team.Name ~= "Chaos Insurgency" then
                                if target.Team.Name ~= "Class D" and target.Team.Name ~= "Chaos Insurgency" then
                                    canDamage = false
                                end
                            end
                            if plr.Team.Name == "Class D" and target.Team.Name ~= "Class D" then
                                canDamage = true
                            end
                            if plr.Team.Name == "Chaos Insurgency" and target.Team.Name ~= "Chaos Insurgency" then
                                canDamage = true
                            end
                            if plr.Team.Name ~= "Chaos Insurgency" and plr.Team.Name ~= "Class D" then
                                if target.Team.Name == "Chaos Insurgency" then
                                    canDamage = true
                                end
                            end
                            local plrs = Region3.getPlayersInRegion(ControlRoomRegion)
                            local foundPlr = false
                            local foundTarget = false
                            for _,v in pairs(plrs) do
                                if target.Name == v.Name then
                                    foundTarget = true
                                end
                                if plr.Name == v.Name then
                                    foundPlr = true
                                end
                            end
                            if foundPlr and foundTarget then
                                canDamage = true
                            end

                            if canDamage then
                                hum:TakeDamage(amnt)
                            else
                                _G.Area39:SendSnackBar(plr,"This player is innocent! Do not randomkill!")
                            end
                        else
                            hum:TakeDamage(amnt)
                        end

                    end
                    

                    local damage = settings['Damage']
                    if v[1].Parent:FindFirstChild("Humanoid") then
                        if v[1].Name == "LowerTorso" or v[1].Name ==
                            "UpperTorso" or v[1].Name == "Head" then
                            damage = damage * settings['CriticalMultiplier']
                        end
                        dodamage(v[1].Parent.Humanoid,damage)
                    end
                    if v[1].Parent.Parent:FindFirstChild("Humanoid") then
                       
                        dodamage(v[1].Parent.Parent.Humanoid,damage-(damage/8))
                    end
                end
                if sound then
                    sound:Play()
                    game.Debris:AddItem(sound,sound.TimeLength+0.01)
                end
            
        end

    end
end
function handleClient(tool, clickPos)
    
    local settings = require(tool:FindFirstChild("Settings"))

    if findFirstDescendants(tool, "Fire") then
        findFirstDescendants(tool, "Fire"):Play()
    end
    if findFirstDescendants(tool, "Flash") then
        findFirstDescendants(tool, "Flash"):Emit(15)
    end
    if findFirstDescendants(tool, "Flash") then
        findFirstDescendants(tool, "FlashFX").Enabled = true
        delay(0.01, function()
            findFirstDescendants(tool, "FlashFX").Enabled = false
        end)
    end
    
    local offset = Vector3.new(math.random(-settings['Spread']*5,
                                           settings['Spread']*5),
                               math.random(-settings['Spread']*5,
                                           settings['Spread']*5), math.random(
                                   -settings['Spread']*5 ,
                                   settings['Spread']*5 ))
    
    local dir =
        ((clickPos.p - tool:FindFirstChild("BPoint").Position)+offset/45).Unit *
            settings['Power']

    local path, contacts = Trajectory:Cast(
                               tool:FindFirstChild("BPoint").Position, (dir),
                               Enum.Material.Concrete, {tool.Parent})
    if path then Trajectory:Draw(path) end
    return contacts

end

if IsServer then
    game.ReplicatedStorage.Remotes.Gun.OnServerEvent:Connect(handleServer)
else
 
    game.ReplicatedStorage.Remotes.Gun.OnClientEvent:Connect(handleClient)
end
return function(settings, tool)

    if IsServer then return end
    local equipped = false
    local firing = false
    local lock = false
    local reloading = false

    local cam = workspace.CurrentCamera

    tool.Equipped:Connect(function()
        equipped = true
        Keybinds({
            [Enum.UserInputType.MouseButton1] = "Fire",
            [Enum.KeyCode.R] = "Reload",
            [Enum.KeyCode.E] = "Interaction"
        })
        settings['IdleAnim'] = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(tool:FindFirstChild("RifleHoldAnimation") or tool:FindFirstChild("PistolHoldAnimation"))
        settings['IdleAnim']:Play()
        game.Players.LocalPlayer:GetMouse().Icon = "rbxassetid://2775556531"

    end)
    tool.Unequipped:Connect(function()
        equipped = false
        firing = false
        if settings['IdleAnim'] then
            settings['IdleAnim']:Stop()
        end
        if  settings['ReloadAnim'] then
            settings['ReloadAnim']:Stop()
        end
        game.Players.LocalPlayer:GetMouse().Icon = ""
        Keybinds({[Enum.KeyCode.E] = "Interaction"})
    end)
    UserInput.InputBegan:Connect(function(iobj, s)
        if s then return end
        if not equipped then return end
        if iobj.UserInputType == Enum.UserInputType.MouseButton1 then
            if iobj.UserInputState == Enum.UserInputState.Begin then
                firing = true
                while firing do
                    settings['KickBackAnim'] = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(tool:FindFirstChild("RifleKickBackAnimation") or tool:FindFirstChild("PistolKickBackAnimation"))
                    
                    if settings['CurrentAmmo'] > 0 and not settings['Reloading'] and not lock and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed <= 20 then
                        lock = true
                        
                        for i=1,(settings['FireCount'] or 1) do
                            settings['KickBackAnim']:Play()
                            local contacts =
                                handleClient(tool,
                                            game.Players.LocalPlayer:GetMouse().Hit)
                            game.ReplicatedStorage.Remotes.Gun:FireServer(tool,
                                                                        game.Players
                                                                            .LocalPlayer:GetMouse()
                                                                            .Hit,
                                                                        contacts)
                        end
                        settings['CurrentAmmo'] = settings['CurrentAmmo'] - 1
                        
                    else
                        firing = false
                        break
                    end

                    wait(60 / settings['FireRate'])
                    lock = false
                    if not settings['Automatic'] then break end
                end
            else
                firing = false
            end
        elseif iobj.KeyCode == Enum.KeyCode.R and not reloading then
           
            reloading = true
            if findFirstDescendants(tool, "Reload") then
                findFirstDescendants(tool, "Reload"):Play()
            end
            settings['ReloadAnim'] = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(tool:FindFirstChild("ReloadAnimation"))
            settings['ReloadAnim']:Play()
            settings['Reloading'] = true
            game.ReplicatedStorage.Remotes.Gun:FireServer(tool, "Reload")
            wait(settings['ReloadSpeed'])
            settings['Reloading'] = false
            settings['CurrentAmmo'] = settings['ClipSize']
            reloading = false
        end
    end)
    UserInput.InputEnded:Connect(function(iobj, s)
        if s then return end
        if not equipped then return end
        if iobj.UserInputType == Enum.UserInputType.MouseButton1 then
            if iobj.UserInputState == Enum.UserInputState.End then
                firing = false
            end
        end
    end)
end
