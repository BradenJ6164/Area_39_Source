local MarketPlaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Alarm = _G.Area39:GetService("AlarmSystem")

local Owners = { -- Bypasses buying passes.
    95587901, -- DrBaja (remove and scripts will break :)
    0,
    -1,
    -2,
}

_G.ClearanceUpgrades = {}

local products = {
	[1154403777] = function(info)
        local player = Players:GetPlayerByUserId(info.PlayerId)
        if player then
            _G.ClearanceUpgrades[player] = 4
            if player.Clearance.Value < 4 then
                player.Clearance.Value = 4
            end
        end
        return Enum.ProductPurchaseDecision.PurchaseGranted
    end,
	[1154403815] = function(info)
        local player = Players:GetPlayerByUserId(info.PlayerId)
        if player then
            _G.ClearanceUpgrades[player] = 6
            if player.Clearance.Value < 6 then
                player.Clearance.Value = 6
            end
        end
        return Enum.ProductPurchaseDecision.PurchaseGranted
    end,
	[1154403905] = function(info)
        local player = Players:GetPlayerByUserId(info.PlayerId)
        if player then
            if player.Character then
                for i,v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        local originTrans = Instance.new("IntValue",v)
                        originTrans.Name = "OriginTransparency"
                        originTrans.Value = v.Transparency
                        v.Transparency = 1
                    end
                    if v:IsA("Decal") then
                        v.Transparency = 1
                    end
                end
            end
            player.Character.Head.BillboardGui.Enabled = false
            local con
            con = player.Character.ChildAdded:Connect(function(c)
                if c:IsA("Tool") then
                    for i,v in pairs(c:GetDescendants()) do
                        if v:IsA("BasePart") then
                            local originTrans = Instance.new("IntValue",v)
                            originTrans.Name = "OriginTransparency"
                            originTrans.Value = v.Transparency
                            v.Transparency = 1
                        end
                        if v:IsA("Decal") then
                            v.Transparency = 1
                        end
                    end
                end
            end)
            local con2
            con2 = player.Character.ChildRemoved:Connect(function(c)
                if c:IsA("Tool") then
                    for i,v in pairs(c:GetDescendants()) do
                        if v:IsA("BasePart") then
                            if v:FindFirstChild("OriginTransparency") then
                                v.Transparency = v:FindFirstChild("OriginTransparency").Value
                                v:FindFirstChild("OriginTransparency"):Destroy()
                            end
                        end
                        if v:IsA("Decal") then
                            v.Transparency = 0
                        end
                    end
                end
            end)

			coroutine.resume(coroutine.create(function()
                for i=1,120 do
                    wait(1)
                    if player.Character then
                        for i,v in pairs(player.Character:GetDescendants()) do
                            if not v:FindFirstChild("OriginTransparency") then
                                if v:IsA("BasePart") then
                                    local originTrans = Instance.new("IntValue",v)
                                    originTrans.Name = "OriginTransparency"
                                    originTrans.Value = v.Transparency
                                    v.Transparency = 1
                                end
                                if v:IsA("Decal") then
                                    v.Transparency = 1
                                end
                            end
                        end
                    end
                end
                if player.Character then
                if con then con:Disconnect() end
                if con2 then con2:Disconnect() end
                for i,v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        if v:FindFirstChild("OriginTransparency") then
                            v.Transparency = v:FindFirstChild("OriginTransparency").Value
                            v:FindFirstChild("OriginTransparency"):Destroy()
                        end
                    end
                    if v:IsA("Decal") then
                        v.Transparency = 0
                    end
                end
                player.Character.Head.BillboardGui.Enabled = true
                end
            end))
            return Enum.ProductPurchaseDecision.PurchaseGranted
        end
    end,
	[1154403630] = function(info)
		coroutine.resume(coroutine.create(function()
		
            local player = Players:GetPlayerByUserId(info.PlayerId)
			if player then
				if game.ReplicatedStorage.ClassDRiot.Value == true then
					game.ReplicatedStorage.ClassDRiot.TimeLeft.Value += 600
				end
                if game.ReplicatedStorage.ClassDRiot.Value == false then
                    game.Workspace.ClassDBreach:Play()
                    if game.ReplicatedStorage.Alarms.Value == true then
                        Alarm:StopAlarms()
                    end
                    for i,plr in pairs(game.Players:GetPlayers()) do
                        _G.Area39:SendSnackBar(plr,player.Name .. " has started a Class D Riot.")
                    end
                    
                    Alarm:StartAlarms("RiotAlarm")
                    for i, v in pairs(game.Players:GetPlayers()) do
                        if v.Team.Name == "Class D" then 
                        game.ServerStorage.Tools:FindFirstChild("OTs-14 Groza 1"):Clone()
                            .Parent = v.Backpack
                        game.ServerStorage.Tools:FindFirstChild("USP40"):Clone()
                            .Parent = v.Backpack
                            if v.Clearance.Value < 4 then
                                v.Clearance.Value = 4
                            end
                        end
                    end

                    game.ReplicatedStorage.ClassDRiot.Value = true
					game.ReplicatedStorage.ClassDRiot.TimeLeft.Value = 600
					while   game.ReplicatedStorage.ClassDRiot.TimeLeft.Value > 0 do
						wait(1)
						if  game.ReplicatedStorage.ClassDRiot.Value == false or game.ReplicatedStorage.ClassDRiot.TimeLeft.Value <= 0 then break end

						game.ReplicatedStorage.ClassDRiot.TimeLeft.Value -= 1
					end
                   
                    game.ReplicatedStorage.ClassDRiot.Value = false
                    Alarm:StopAlarms()
                end
            end
        end))
        return Enum.ProductPurchaseDecision.PurchaseGranted
        
    end

}

function Receiept(info)
    
    if game.Players:GetPlayerByUserId(info.PlayerId) then
        _G.Area39:SendConfetti(game.Players:GetPlayerByUserId(info.PlayerId))
    end
    if products[info.ProductId] then return products[info.ProductId](info) end
end

if RunService:IsServer() then MarketPlaceService.ProcessReceipt = Receiept end
local module = {}

function module:UserOwnsGamePassAsync(userId, passId)
    local has = MarketPlaceService:UserOwnsGamePassAsync(userId, passId)
    if table.find(Owners, userId) then has = true end
    return has
end

return module
