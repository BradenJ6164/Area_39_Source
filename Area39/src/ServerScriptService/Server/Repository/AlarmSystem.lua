local config = {
    ['RiotAlarm'] = {
        ['Sound'] = "rbxassetid://5425919689",
        ['Volume'] = 5,
        ['Color'] = Color3.fromRGB(255, 255, 0),
        ['Ambience'] =game.Lighting.Raid,
    },
    ['BreachAlarm'] = {
        ['Sound'] = "rbxassetid://134697739",
        ['Volume'] = 0.5,
        ['Color'] = Color3.fromRGB(255, 0, 0),
        ['Ambience'] =game.Lighting.Breach,
    }

}
local Directory = game.Workspace.Map.WarningLights

local lastPush = tick()

local module = {}

function module:StartAlarms(style)
    if math.abs(lastPush - tick()) <= 15 then return end
    lastPush = tick()
    game.Lighting.Breach.Enabled = false
    game.Lighting.Raid.Enabled = false
    for i, v in pairs(Directory:GetChildren()) do
        pcall(function()
            v.Bulb.SpotLight1.Enabled = true
            v.Bulb.SpotLight.Enabled = true
            --v.Motor.MaxVelocity = 0.001
            if config[style] then
                config[style]['Ambience'].Enabled = true
               
                for i, v in pairs(v:GetChildren()) do
                    if v:IsA("MeshPart") then
                        if v.BrickColor == BrickColor.new("Maroon") or v.Color ==
                            Color3.fromRGB(255, 255, 0) or v.Color ==
                            Color3.fromRGB(255, 0, 0) or v.Color ==  Color3.fromRGB(255, 255, 255) then
                            v.Color = config[style]['Color']
                        end
                    end
                end
                v.Bulb.AlarmSound.SoundId = config[style]['Sound']
                v.Bulb.AlarmSound.Volume = config[style]['Volume']
                v.Bulb.SpotLight.Color = config[style]['Color']
                v.Bulb.SpotLight1.Color = config[style]['Color']
                v.Bulb.AlarmSound.Looped = true
                v.Bulb.AlarmSound.MaxDistance = 32

            end
            v.Bulb.AlarmSound:Play()
        end)
    end
    game.ReplicatedStorage.Alarms.Value = true
end

function module:StopAlarms()
    if math.abs(lastPush - tick()) <= 15 then return end
    lastPush = tick()
    for i, v in pairs(Directory:GetChildren()) do
       pcall(function()
            v.Bulb.AlarmSound:Stop()
            v.Bulb.SpotLight1.Enabled = false
            v.Bulb.SpotLight.Enabled = false
           -- v.Motor.MaxVelocity = 0
        end)
        for i, v in pairs(v:GetChildren()) do
            if v:IsA("MeshPart") then
                if v.BrickColor == BrickColor.new("Maroon") or v.Color ==
                    Color3.fromRGB(255, 255, 0) or v.Color ==
                    Color3.fromRGB(255, 0, 0) then
                    v.Color = Color3.fromRGB(255,255,255)
                end
            end
        end
    end
    game.Lighting.Breach.Enabled = false
    game.Lighting.Raid.Enabled = false
    game.ReplicatedStorage.Alarms.Value = false
end

return module
