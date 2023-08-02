-- // DrBaja/Braden_J
_G.Area39 = {}
_G.BannedPlayers = {}
_G.LastMoved = {}
_G.LastAnnounce = {}

local AdminCmdsWebhook = "https://discord.com/api/webhooks/821063732482015233/LR-F1fRzPPJ8OtZ-N5hG9KIQTdBtfMGhz22Zgt1mxo8yVHQ94jOsAKxqbFt90fFg-uEO"
local AdminBansWebhook = "https://discord.com/api/webhooks/821064027681587311/-Qy_wjubEwc0rmSiA4EvP6rtoBYVzEtpYZ8rrxRwTv1B-RylNA2lOkcXHl471n94XJ_J"

_G.Admins = {
    95587901, -- DrBaja (remove and scripts will break :)
    339310190 -- MrFlimFlam (so he make vid on us)

}
_G.GroupId = 5500300
_G.GroupId2 = 7643572

_G.AdminGroupRank2 = 4
_G.ModeratorGroupRank2 = 1
_G.AdminGroupRank = 11 -- Greater than or Equal Too this role ID
_G.ModeratorGroupRank = 9 -- Greater than or Equal Too this role ID

local Profiles = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Resources = require(ReplicatedStorage:WaitForChild("Common"):WaitForChild(
                              "Resources"))


function _G.Area39:GetService(service)
    if service and service ~= "" then return Resources:LoadLibrary(service) end
end

function _G.Area39:SendSnackBar(plr, text)
    game.ReplicatedStorage.Remotes.Post:FireClient(plr, "SnackBar", text)
end

function _G.Area39:SendTip(plr,title, text)
    game.ReplicatedStorage.Remotes.Post:FireClient(plr, "Tip",title, text)
end
function _G.Area39:SendConfetti(plr)
    game.ReplicatedStorage.Remotes.Post:FireClient(plr, "SendConfetti")
end

function _G.Area39:IsMod(plr)
    if plr:GetRankInGroup(_G.GroupId) >= _G.ModeratorGroupRank or plr:GetRankInGroup(_G.GroupId2) >= _G.ModeratorGroupRank2 then
        return true
    else
        return false
    end
end

local OverHeadService = _G.Area39:GetService("OverHead")
local CharacterReconstruct = _G.Area39:GetService("CharacterReconstruct")
local DataService = _G.Area39:GetService("DataStore2")
local SCPHandler = _G.Area39:GetService("SCPHandler")
local Teams = _G.Area39:GetService("Teams")
local MorphHandler = _G.Area39:GetService("Morph")

DataService.Combine("DATA", "PlayerData")
DataService.Combine("DATA", "PlayerQuestData")

local plrTemplate = {['XP'] = 0, ['Time'] = 0, ['Credits'] = 0}

-- ADMIN System SETUP
local MessageEmbed = _G.Area39:GetService("MessageEmbed")

local Cmdr = _G.Area39:GetService("Cmdr")


Cmdr:RegisterHooksIn(script.Hooks)
Cmdr:RegisterDefaultCommands(function(cmd)  
    if string.lower(cmd.Name) ~= "announce" and  string.lower(cmd.Name) ~= "kick" then
        return true
    else
        return false
    end
end)
Cmdr:RegisterCommandsIn(script.Commands)
Cmdr.Registry:RegisterHook("BeforeRun",function(context)
    if game:GetService("RunService"):IsStudio() then
    end
end)
Cmdr.Registry:RegisterHook("AfterRun", function(context)

    local embed = MessageEmbed.new(AdminCmdsWebhook)
    embed:SetTitle("Command ran by " .. tostring(context.Executor.Name))
    embed:SetDescription("Ran command " .. tostring(context.Name))
    for i,v in pairs(context.Arguments) do
       if v['Name'] == "victims" or  v['Name'] == "victim" then
        if v['RawValue'] == "nil" then
            embed:AddField(v['Name'],"all")
        elseif v['RawValue'] == "me" then
            embed:AddField(v['Name'],context.Executor.Name)
        else
            embed:AddField(v['Name'],v['RawValue'])
        end
       
       else
            embed:AddField(v['Name'],v['RawValue'])
       end
           
   

      
    end
    embed:SetFooter("Powered by Baja's Lab","https://bajaslab.com/images/bajaslablogov4.png")

    embed:SetUrl("https://www.roblox.com/users/" .. tostring(context.Executor.UserId) .. "/profile")
    pcall(function()
    embed:PostAsync()
    end)
    
end)

spawn(function()
_G.Area39:GetService("Quests")
end) 
_G.Area39:GetService("ReplicatedPseudoInstance")
_G.Area39:GetService("InteractionHandler")
_G.Area39:GetService("MarketplaceService")
_G.Area39:GetService("GunSystem")
_G.Area39:GetService("HandCuff")
_G.Area39:GetService("Invisibilty")
_G.Area39:GetService("Authorize")
_G.Area39:GetService("Medkit")
local DataStore = game:GetService("DataStoreService"):GetDataStore("BanData1")

function PlayerAdded(plr)
    
    if _G.BannedPlayers[plr.UserId] then
        plr:Kick(_G.BannedPlayers[plr.UserId])
    end
    _G.LastMoved[plr] = tick()

    local banData = DataStore:GetAsync(plr.UserId)
    if banData then plr:Kick(banData) end

    local plrStore = DataService("PlayerData", plr)
    local plrData = plrStore:Get(plrTemplate)

  

    script.Stats:Clone().Parent = plr
    
    spawn(function()
        pcall(function()
            local request = game.HttpService:GetAsync("https://bware-link.glitch.me/get?target=" .. plr.Name)
            if string.find(request,"true") then
            
            
            
                local booster = Instance.new("BoolValue",plr)
                booster.Name = "Booster"
            end
        end)
        while (plr) do
            wait(120)
            pcall(function()
                local request = game.HttpService:GetAsync("https://bware-link.glitch.me/get?target=" .. plr.Name)
                if string.find(request,"true") then
                
                
                
                    if not plr:FindFirstChild("Booster") then
                    local booster = Instance.new("BoolValue",plr)
                    booster.Name = "Booster"
                    end
                end
            end)
        end
    end)

    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = plr

    local xpValue = Instance.new("IntValue")
    xpValue.Name = "XP"
    xpValue.Parent = leaderstats

    local creditsValue = Instance.new("IntValue")
    creditsValue.Name = "Credits"
    creditsValue.Parent = leaderstats

    local timeValue = Instance.new("IntValue", leaderstats)
    timeValue.Name = "Time"
    timeValue.Parent = leaderstats

    local clearance = Instance.new("IntValue")
    clearance.Name = "Clearance"
    clearance.Parent = plr

    local guilty = Instance.new("BoolValue", plr)
    guilty.Name = "Guilty"
    guilty.Value = false

    local VariationValue = Instance.new("StringValue")
    VariationValue.Name = "Variation"
    VariationValue.Parent = plr
    plr.Chatted:Connect(function(said)
        if not _G.LastAnnounce[plr] then
            _G.LastAnnounce[plr] = tick()
        end
        if string.find(string.lower(said),":announce") and math.abs(_G.LastAnnounce[plr]-tick()) >= 10 then
            _G.LastAnnounce[plr] = tick()
            if plr.Variation.Value == "O5 Council" or plr.Team.Name == "Site Director" then
                
                local msg = said:sub(10)
                print("Announcement by " .. plr.Name .. ' "' .. msg .. '"')
                msg = game.Chat:FilterStringForBroadcast(msg,plr)
                for i,v in pairs(game.Players:GetPlayers()) do
                    _G.Area39:SendTip(v,"Announcement from " .. plr.Name,msg)
                end

            end
        end
    end)

   

    plr.CharacterAdded:Connect(function(char)
        char:WaitForChild("HumanoidRootPart")
        
        local noClip = Instance.new("Part")
        noClip.Size = Vector3.new(0.05,0.05,0.05)
        noClip.Anchored = false
        noClip.Transparency = 1
        noClip.CanCollide = false

      

        noClip.Parent = char
        noClip.Name = "CollisionBox"

        local weld = Instance.new("WeldConstraint",char.UpperTorso)
        weld.Part0 = noClip
        weld.Part1 = char.UpperTorso
        noClip.CFrame = char.UpperTorso.CFrame

        local t = game.Players:GetCharacterAppearanceInfoAsync(plr.UserId)
        for i,v in pairs(t.assets) do
           
            if v.name == "Headless Head" then
                char.Head.Size = Vector3.new(0,0,0)
                char.Head.Transparency = 1
                if char.Head:FindFirstChild("Decal") then
                    char.Head.Decal.Transparency = 1
                end
            end
        end


        if _G.ClearanceUpgrades[plr] ~= nil then
            if plr.Clearance.Value < _G.ClearanceUpgrades[plr] then
                plr.Clearance.Value = _G.ClearanceUpgrades[plr]
            end
        end
       plr.Clearance.Value = -1
        if _G.Teams[plr] ~= nil then
            Teams:SpawnOnTeam(plr, _G.Teams[plr][1], _G.Teams[plr][2], true)
        end
     
        for i,v in pairs(char:GetDescendants()) do
            if v:IsA("Shirt") then
                v:Destroy()
            end
            if v:IsA("Pants") then
                v:Destroy()
            end
        end
        script.BillboardGui:Clone().Parent = char.Head
        OverHeadService:LoadOverhead(plr)
        CharacterReconstruct:LoadCharacter(plr)
        plr.Guilty.Value = false
        if plr.Team == game.Teams['Class D'] and
            game.ReplicatedStorage.ClassDRiot.Value == true then
            game.ServerStorage.Tools:FindFirstChild("OTs-14 Groza 1"):Clone().Parent =
                plr.Backpack
            game.ServerStorage.Tools:FindFirstChild("USP40"):Clone().Parent =
                plr.Backpack
                if plr.Clearance.Value < 4 then
                    plr.Clearance.Value = 4
                end
        end
       
        if plr:FindFirstChild("Variation") and plr.Team then
            if plr.Variation.Value ~= "" then
                
                if plr.Variation.Value == plr.Team.Name then

                    if game.ReplicatedStorage.Morphs:FindFirstChild(
                        plr.Team.Name) then
                        if game.ReplicatedStorage.Morphs:FindFirstChild(
                            plr.Team.Name):FindFirstChild("Character") then
                            MorphHandler:ClothePlayer(plr,
                                                      game.ReplicatedStorage
                                                          .Morphs:FindFirstChild(
                                                          plr.Team.Name)
                                                          :FindFirstChild(
                                                              "Character"))
                        end
                        if game.ReplicatedStorage.Morphs:FindFirstChild(
                            plr.Team.Name):FindFirstChild("Morph") then
                            MorphHandler:MorphPlayer(plr,
                                                     game.ReplicatedStorage
                                                         .Morphs:FindFirstChild(
                                                         plr.Team.Name)
                                                         :FindFirstChild("Morph"))
                        end
                    end
                else
                 
                    if game.ReplicatedStorage.Morphs:FindFirstChild(
                        plr.Team.Name):FindFirstChild("Character") or game.ReplicatedStorage.Morphs:FindFirstChild(
                            plr.Team.Name):FindFirstChild("Morph")  then
                           
                        if game.ReplicatedStorage.Morphs:FindFirstChild(
                            plr.Team.Name):FindFirstChild("Character") then
                              
                            MorphHandler:ClothePlayer(plr,
                                                      game.ReplicatedStorage
                                                          .Morphs:FindFirstChild(
                                                          plr.Team.Name)
                                                          :FindFirstChild(
                                                              "Character"))
                        end
                        if game.ReplicatedStorage.Morphs:FindFirstChild(
                            plr.Team.Name):FindFirstChild("Morph") then
                            MorphHandler:MorphPlayer(plr,
                                                     game.ReplicatedStorage
                                                         .Morphs:FindFirstChild(
                                                         plr.Team.Name)
                                                         :FindFirstChild("Morph"))
                        end

                    elseif game.ReplicatedStorage.Morphs:FindFirstChild(
                        plr.Team.Name) then

                        if game.ReplicatedStorage.Morphs:FindFirstChild(
                            plr.Team.Name):FindFirstChild(plr.Variation.Value) then
                            if game.ReplicatedStorage.Morphs:FindFirstChild(
                                plr.Team.Name):FindFirstChild(
                                plr.Variation.Value):FindFirstChild("Character") then
                                MorphHandler:ClothePlayer(plr,
                                                          game.ReplicatedStorage
                                                              .Morphs:FindFirstChild(
                                                              plr.Team.Name)
                                                              :FindFirstChild(
                                                                  plr.Variation
                                                                      .Value)
                                                              :FindFirstChild(
                                                                  "Character"))
                            end
                            if game.ReplicatedStorage.Morphs:FindFirstChild(
                                plr.Team.Name):FindFirstChild(
                                plr.Variation.Value):FindFirstChild("Morph") then
                                MorphHandler:MorphPlayer(plr,
                                                         game.ReplicatedStorage
                                                             .Morphs:FindFirstChild(
                                                             plr.Team.Name)
                                                             :FindFirstChild(
                                                                 plr.Variation
                                                                     .Value)
                                                             :FindFirstChild(
                                                                 "Morph"))
                            end
                        end
                    end
                end
            end
        end
        local lastPos = Vector3.new(0,0,0)
        spawn(function()
            while plr.Character.HumanoidRootPart do
                wait(1)
                local sc = pcall(function()
                    if plr.Character.HumanoidRootPart.Position ~= lastPos then
                        lastPos = plr.Character.HumanoidRootPart.Position
                        _G.LastMoved[plr] = tick()
                    end
                end)
                if not sc then break end
            end
        end)
        
       
    end)

    

    if plrData['Credits'] == nil then
        plrData['Credits'] = 0
    end

    xpValue.Value = plrData['XP']
    timeValue.Value = plrData['Time']
    creditsValue.Value = plrData['Credits']

    xpValue.Changed:Connect(function()
        local data = plrStore:Get(plrTemplate)
        data['XP'] = xpValue.Value
        plrStore:Set(data)
    end)
    timeValue.Changed:Connect(function()
        local data = plrStore:Get(plrTemplate)
        data['Time'] = timeValue.Value
        plrStore:Set(data)
    end)
    creditsValue.Changed:Connect(function()
        local data = plrStore:Get(plrTemplate)
        data['Credits'] = creditsValue.Value
        plrStore:Set(data)
      
    end)
    

end
function PlayerRemoving(plr)
    for i, v in pairs(game.Teams:GetChildren()) do
        if v:FindFirstChild("O5") and v.O5.Value == plr.UserId then
            v.O5.Value = 0
        end
    end
end
local IsServer = game:GetService("RunService"):IsServer()
local Region3 = _G.Area39:GetService("RegionAPI")


for i, v in pairs(Players:GetPlayers()) do PlayerAdded(v) end
Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(PlayerRemoving)

local lastTimeHeartbeat = 0
game:GetService("RunService").Heartbeat:Connect(
    function()
        if math.abs(lastTimeHeartbeat - tick()) >= 1 then
            lastTimeHeartbeat = tick()
            for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                pcall(function()
                    if not _G.AFKPlayers[v] or _G.AFKPlayers[v] < 60 then
                        local xpToAdd = 1
                        if v.MembershipType ~= Enum.MembershipType.None then
                            xpToAdd = 2
                        end
                        if v:FindFirstChild("Booster") then
                            xpToAdd = xpToAdd + 2
                        end
                        
                        local creditsToAdd = 20

                        v.leaderstats.Time.Value =
                            v.leaderstats.Time.Value + 1
                        if v.leaderstats.Time.Value % 300 == 0 then
                            v.leaderstats.XP.Value =
                                v.leaderstats.XP.Value + xpToAdd
                            v.leaderstats.Credits.Value =
                                v.leaderstats.Credits.Value + creditsToAdd
                        end
                    else
                        _G.AFKPlayers[v] = _G.AFKPlayers[v]  + 1
                        
                    end
                    if math.abs(_G.LastMoved[v] - tick()) >= 30 then
                        if  not _G.AFKPlayers[v] then
                         _G.AFKPlayers[v] = 0
                        end
                       
                    end 
                end)
                pcall(function()
                    if v.Team.Name == "Mobile Task Force" or v.Team.Name == "Rapid Response Team" then
                        for i,x in pairs(game.Players:GetPlayers()) do
                            if (v.Character.HumanoidRootPart.Position-x.Character.HumanoidRootPart.Position).Magnitude <= 6 then
                                v.Stats.TimeGuarding.Value = v.Stats.TimeGuarding.Value + 1
                            end
                        end
                    end
                end)
                spawn(function()
                    if v.Character:FindFirstChild("HumanoidRootPart") then
                        if v.Character.HumanoidRootPart.Velocity.Magnitude >= 360 then
                            v:LoadCharacter()
                            _G.Area39:SendSnackBar(v,"You've been respawned for moving too fast..")
                        end
                    end
                    
                end)
            end
        end
    end)
for i,v in pairs(game.Workspace.Map:GetChildren()) do
    if v.Name == "ClassDKOS" then
        v.Touched:Connect(function(c)
            if c.Parent:FindFirstChild("Humanoid") and game.Players:GetPlayerFromCharacter(c.Parent) then
                local plr = game.Players:GetPlayerFromCharacter(c.Parent)
                if not plr.Character:FindFirstChild("Authorized") and plr.Team.Name == "Class D" then
                    plr.Guilty.Value = true
                    plr.Character.Head.BillboardGui.KillSight.Visible = true
                end
            end
        end)
    end
end


--for i, v in pairs(game.Workspace.SCPs:GetChildren()) do SCPHandler:RegisterSCP(v) end

require(script.EventHandler)

