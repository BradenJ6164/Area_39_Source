local module = {}

local regionAPI = _G.Area39:GetService("RegionAPI")

local zones = {
    ['Sector 1'] = {
        ['Folder'] = game.Workspace.Map['S-1'],
        ['Audio'] = "rbxassetid://491987353"
    },
    ['Sector 2'] = {
        ['Folder'] = game.Workspace.Map['S-2'],
        ['Audio'] = "rbxassetid://1128963106"
    },
    ['Sector 3'] = {
        ['Folder'] = game.Workspace.Map['S-3'],
        ['Audio'] = "rbxassetid://4851400295"
    },
    ['Sector 4'] = {
        ['Folder'] = game.Workspace.Map['S-4'],
        ['Audio'] = "rbxassetid://1836908773"
    },
    ['Class D Containment'] = {
        ['Folder'] = game.Workspace.Map['CDCZ'],
        ['Audio'] = "rbxassetid://1836908773"
    }

}

function notify(txt)
    getGui().AreaEntry.Visible = true
    getGui().Notif:Play()
    getGui().AreaEntry:TweenSize(UDim2.new(0.3, 0, 0, 3), "Out", "Quad", .25)
    wait(0.25)
    getGui().AreaEntry:TweenSize(UDim2.new(0.3, 0, 0.05, 0), "Out", "Quad", .5)
    wait(0.5)
    for i = 1, #txt do
        getGui().AreaEntry.entry.Text = string.sub(txt, 1, i)
        wait()
    end
    wait(1.5)
    local z = #txt
    for i = 1, #txt do
        getGui().AreaEntry.entry.Text = string.sub(txt, 1, z)
        z = z - 1
        wait()
    end
    getGui().AreaEntry.entry.Text = ""
    getGui().AreaEntry:TweenSize(UDim2.new(0.3, 0, 0, 3), "Out", "Quad", .5)
    wait(0.5)
    getGui().AreaEntry:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", .25)
    wait(0.25)
    getGui().AreaEntry.Visible = false
end

local cachePars = {}
local cache = {}

local started = false
local recurseTime = 1

local crntZone = ""

local de = false


spawn(function()
    while wait(recurseTime) do
        if game.Workspace:FindFirstChild("AmbienceUpdators") then
            for i,v in pairs(game.Workspace.AmbienceUpdators:GetChildren()) do
                if cachePars[v] == nil then
                    cachePars[v] = v.Touched:Connect(function(c)
                        
                        local plr = (game.Players:GetPlayerFromCharacter(c.Parent) or game.Players:GetPlayerFromCharacter(c.Parent.Parent))
                        
                        if plr then
                          
                        if plr.Name == game.Players.LocalPlayer.Name and started and not de then
                            de = true
                            delay(.5,function() de = false end)
                            for i, v in pairs(cache) do
                                local plrs = regionAPI.getPlayersInRegion(v['Zone'])
                                local found = false
                                for i, v in pairs(plrs) do
                                    if v.Name == game.Players.LocalPlayer.Name then
                                        found = v
                                    end
                                end
                                if found then
                
                                    if getGui().Sound.SoundId ~= v['Audio'] then
                                        getGui().Sound.SoundId = v['Audio']
                                        getGui().Sound:Play()
                                        notify("Now Entering " .. i)
                                    end
                
                                end
                            end
                        end
                    end
                    end)
                    v.Changed:Connect(function()
                        if v.Parent ~= workspace.AmbienceUpdators then 
                            cachePars[v]:Disconnect()
                            cachePars[v] = nil

                        end
                    end)
                end
            end
        end
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    delay(1,function()
        for i, v in pairs(cache) do
            local plrs = regionAPI.getPlayersInRegion(v['Zone'])
            local found = false
            for i, v in pairs(plrs) do
                if v.Name == game.Players.LocalPlayer.Name then
                    found = v
                end
            end
            if found then

                if getGui().Sound.SoundId ~= v['Audio'] then
                    getGui().Sound.SoundId = v['Audio']
                    getGui().Sound:Play()
                    notify("Now Entering " .. i)
                end

            end
        end
    end)
end)

function getGui() return game.Players.LocalPlayer.PlayerGui.CoreGui end

for i, v in pairs(zones) do
    if v['Folder']:FindFirstChildWhichIsA("Model") then
        local p = Instance.new("Part")
        local cframe, size = v['Folder']:FindFirstChildWhichIsA("Model")
                                 :GetBoundingBox()
        p.CFrame = cframe
        p.Size = size
        p.Anchored = true
        p.CanCollide = false
        p.Transparency = 1
        p.Parent = workspace
        p.Name = i

        local region = regionAPI.createRegion3FromPart(p)

        local tbl = {
            ['Folder'] = v['Folder'],
            ['Audio'] = v['Audio'],
            ['Zone'] = region
        }
        cache[i] = tbl
        p:Destroy()
    end
end

function module:Start()
    started = true

    --[[spawn(function()

        while started do
            wait(recurseTime)
            
        end
    end)]]
end
function module:Stop()
    started = false
    getGui().Sound:Stop()
end

return module
